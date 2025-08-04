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

