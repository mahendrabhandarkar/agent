#https://www.youtube.com/watch?v=Vri-dT9AbfI&t=62s --- Using the KIND (Kubernetes in Docker) extension in Podman Desktop for local Kubernetes deployment -- Kind is an opensource project that allow you to run kubernetes cluster inside of a container engine, this could be podman, docker or others. this is quite helpful for development and testing purposes. As well as running kubernetes locally in lightweight fashion with that being said if you are using podman on windows let's go head and configure a podman machine the virtual machine to run this workload. To create machine: Once in podman desktop, Create a podman machine, go to settings and Resources. Then Create Kind Cluster. https://kubernetes.io/docs/tutorials/stateless-application/guestbook/ ---- https://www.youtube.com/watch?v=uTihkWIi-Dk&t=144s --- Run kubernetes multi node cluster locally with Kind and local Docker Registry | step by step guide --- https://github.com/maxcotec/k8s-kind-docker

wsl --install <br />
"C:\Program Files\Redhat\Podman\podman.exe" machine init ollama_machine <br />
podman machine start ollama_machine <br />
podman machine set --rootful ollama_machine # for providing root access to machine <br />
podman pull docker.io/ollama/ollama <br />
podman images <br />
podman run -d --name ollama-server -p 11434:11434 ollama/ollama:latest <br />
podman ps <br />
curl http://localhost:11434 <br />
podman exec -it ollama-server bash <br />
ollama pull llama3 <br />
OLLAMA_NO_AUTH=1 ollama run llama3 <br />

podman machine start ollama_machine <br />
podman ps <br />
"C:\Program Files\Redhat\Podman\podman.exe" build -t ksfinalb:latest Dockerfile .  ----or---- podman buildx build . <br />
podman build --file server.Dockerfile --tag our-first-server . <br />
podman ps -aq | xargs docker rm --- shows all ID, and now we deleted all containers. <br />
podman run -p 8080:9191 ksfinalb <br />
podman run --rm --entrypoint sh --volume /tmp/container:/tmp ubuntu -c "echo 'Hello there.' > /tmp/file & cat /tmp/file" -- create file and bind it with volume with /tmp your directory. <br />
podman login <br /> --- to login into docker hub <br />
podman tag ourlocalimagename ourusername/imagenamewanttoshownindockerhub:R0.0.1 <br />
podman push ourusername/imagenamewanttoshownindockerhub:R0.0.1 <br />
podman run --name=alpine --entrypoint=sleep -d alpline infinity 
podman stats alpline
podman exec -i -t alpline sh 
podman top alpline
podman inspect alpline | less
podman context ls
podman context use default
echo $env:DOCKER_CONTEXT ; echo $env:DOCKER_HOST;
export DOCKER_CONTEXT=context_not_working
unset DOCKER_CONTEXT

#kibana, elasticsearch, logstash, prometheus grafana node_exporter alertmanager, portainer - in podman
docker-compose -f elk_installation_podman.yml down -v
del .env
elk_automation.bat
podman exec -it elasticsearch /bin/bash
bin/elasticsearch-reset-password -u kibana_system -i  # set password to changeme then restart kibana.

#sonarqube coverage, sonarqub security, jenkins, nexus repository, private docker hub repository, keycloak, gitlab, rabbitmq
docker-compose -f environment_related_services.yml down -v

#kubernetes native - envoy-master, envoy-client, metalb,

#devsecops -- SonarQube, OWASP ZAP, DefectDojo, MySQL, Gitleaks	, Semgrep, Checkov, Trivy	, Hadolint, Nuclei, etc.
docker-compose -f devsecops_docker_compose.yml down --volumes
docker image prune -af

#bugzilla - defect, test management and agile management
docker-compose -f bugzilla_docker_compose.yml up -d

docker-compose -f devsecops_docker_compose.yml pull
docker-compose -f devsecops_docker_compose.yml up -d

# to run command [ollama run llama2] in ollama container
docker exec -it ollama ollama run llama2
