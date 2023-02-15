sudo hostnamectl set-hostname worker-node1
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
sudo chmod 755 /tmp/installDocker.sh
sudo bash /tmp/installDocker.sh
sudo systemctl restart docker
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installK8S-v1-23.sh -P /tmp
rm /tmp/installK8S-v1-23.sh.1
sudo chmod 755 /tmp/installK8S-v1-23.sh
sudo bash /tmp/installK8S-v1-23.sh