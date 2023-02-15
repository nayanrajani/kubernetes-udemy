echo "set paste" > $HOME/.vimrc
sudo hostnamectl set-hostname master-node
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
sudo chmod 755 /tmp/installDocker.sh
sudo bash /tmp/installDocker.sh
sudo systemctl restart docker
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installK8S-v1-23.sh -P /tmp
sudo chmod 755 /tmp/installK8S-v1-23.sh
sudo bash /tmp/installK8S-v1-23.sh
kubectl get nodes
sudo kubeadm token create --print-join-command