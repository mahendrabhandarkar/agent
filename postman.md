wsl --install
"C:\Program Files\Redhat\Podman\podman.exe" machine init ollama_machine
podman machine start ollama_machine
podman machine set --rootful ollama_machine # for providing root access to machine
podman pull docker.io/ollama/ollama
podman images
podman run -d --name ollama-server -p 11434:11434 ollama/ollama:latest
podman ps
curl http://localhost:11434
podman exec -it ollama-server bash
ollama pull llama3
OLLAMA_NO_AUTH=1 ollama run llama3

