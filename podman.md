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
podman run -p 8080:9191 ksfinalb

#kibana, elasticsearch, logstash, prometheus grafana node_exporter alertmanager, portainer - in podman
docker-compose -f elk_installation_podman.yml down -v
del .env
elk_automation.bat
podman exec -it elasticsearch /bin/bash
bin/elasticsearch-reset-password -u kibana_system -i  # set password to changeme then restart kibana.

#sonarqube coverage, sonarqub security, jenkins, nexus repository, private docker hub repository, keycloak, gitlab, rabbitmq
docker-compose -f environment_related_services.yml down -v

#kubernetes native - envoy-master, envoy-client, metalb,
