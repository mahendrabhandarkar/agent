#podman is already installed, ansible playbook for kubernetes cluster for 3 node setup using podman

wsl --install
#In ubuntu
cd /mnt/c/mahendra/agent/k8s-cluster
sudo apt update
sudo apt install sshpass
sudo apt update
sudo apt install -y ansible
ansible-playbook -i inventory.ini playbook.yml
# Create a Podman Network
podman network create k8snet --subnet 10.87.0.0/16
# Create 3 containers
# Master node
podman run -d --name master --network k8snet --hostname master --ip 10.87.0.10 -p 2222:22 ubuntu:20.04 sleep infinity

# Worker 1
podman run -d --name worker1 --network k8snet --hostname worker1 --ip 10.87.0.11 -p 2223:22 ubuntu:20.04 sleep infinity

# Worker 2
podman run -d --name worker2 --network k8snet --hostname worker2 --ip 10.87.0.12 -p 2224:22 ubuntu:20.04 sleep infinity

#Install SSH in each container
podman exec -it master bash
apt update && apt install -y openssh-server sudo
service ssh start

# Repeat [Install SSH in each container] step for worker1 and worker2.

# From WSL terminal (on your host):
ssh-keygen  # if you haven't already
id_rsa # file name
cp /mnt/c/mahendra/agent/k8s-cluster/id_rsa.pub .

#Where to Place the SSH Key in Each Container
podman exec -it master bash
mkdir -p /root/.ssh
echo "ssh-rsa AAAA... user@host" >> /root/.ssh/authorized_keys
#echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITax4diUU4ha+uUoLFK8U3yRw/qDT9FRJgZHpTUehLI root@L-INE-2NM8V93" >> /root/.ssh/authorized_keys
chmod 700 /root/.ssh
chmod 600 /root/.ssh/authorized_keys
exit
#Repeat [Where to Place the SSH Key in Each Container] for worker1 and worker2.

# Check permission
podman exec -it master bash
cat /etc/ssh/sshd_config | grep -E 'PermitRootLogin|PubkeyAuthentication' # if PermitRootLogin / PubkeyAuthentication is not yes
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#PubkeyAuthentication.*/PubkeyAuthentication yes/' /etc/ssh/sshd_config
cat /etc/ssh/sshd_config | grep -E 'PermitRootLogin|PubkeyAuthentication' # PermitRootLogin / PubkeyAuthentication should change to yes
service ssh restart
#Repeat [Check permission] for worker1 and worker2.

#Verify it Works
ssh root@localhost -p 2222 #if it still not works then follow below commands

#-- podman exec -it master passwd # change master, worker1, worker2 password, and now verify again
ssh root@localhost -p 2222

# Run your playbook
cd /mnt/c/mahendra/agent/k8s-cluster/
ansible-playbook -i inventory.ini playbook.yml

# Run WLS2 Ubuntu - Set swapoff in system config. To disable swap permanently on the host:
sudo swapoff -a

# delete old save key
#sudo apt-key list
#sudo apt-key del F6EC B376 2474 EDA9 D21B  7022 8719 20D1 991B C93C

rm -f /etc/apt/keyrings/kubernetes-apt-keyring.gpg
ansible-playbook -i inventory.ini playbook.yml
