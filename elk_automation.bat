@echo off
setlocal enabledelayedexpansion

echo [1/7] Starting Elasticsearch...
docker-compose -f elk_installation_podman.yml up -d elasticsearch

echo [2/7] Waiting for Elasticsearch to be ready...
:wait_loop
curl -s -u elastic:changeme http://localhost:9200 >nul 2>&1
if errorlevel 1 (
    timeout /t 5 >nul
    goto wait_loop
)

echo [3/7] Elasticsearch is ready.

echo [4/7] Generating Kibana service token...

rem Reset token variable
set "TOKEN="

for /f "tokens=3 delims== " %%t in ('podman exec elasticsearch bin/elasticsearch-service-tokens create elastic/kibana kibana-token') do (
    set "TOKEN=%%t"
)

if not defined TOKEN (
    echo ❌ Failed to generate token.
    exit /b 1
)

echo ELASTICSEARCH_SERVICE_TOKEN=!TOKEN! > .env
echo ✅ Token saved to .env

echo [5/7] Starting Kibana and Logstash...
docker-compose -f elk_installation_podman.yml up -d kibana logstash

echo [6/7] Starting Monitoring Tools (Prometheus, Grafana, Node Exporter, Alertmanager)...
docker-compose -f elk_installation_podman.yml up -d prometheus grafana node_exporter alertmanager

echo [7/7] Starting Portainer...
docker-compose -f elk_installation_podman.yml up -d portainer

echo ✅ ELK stack is fully running.
endlocal
