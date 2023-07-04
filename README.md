# kubernetes-udemy

- https://www.geeksforgeeks.org/kubernetes-tutorial/
## Kubernetes for Beginner

- The Kubernetes for the Absolute Beginner's course helps a beginner having no prior experience with containers or container orchestration get started with the concepts of Kubernetes.

- As this is a beginner's course, we do not deep dive into technical details.

- Instead, we focus on a high level overview of Kubernetes, setting up a symbol lab environment to play with Kubernetes, learning the prerequisites required to understand and get started, understanding the various concepts to deploy an application such as pods, replica sets, deployments, and services.

- This course is also suitable for a non-technical person trying to understand the basic concepts of Kubernetes just enough to get involved in discussions around technology.

## Kubernetes for Administrator

- The Kubernetes for Administrators course focuses on advanced topics on Kubernetes and in-depth discussions into the various concepts around deploying a high availability cluster for production use case, understanding more about scheduling, monitoring, maintenance, securities, storage, and troubleshooting.

- This course also helps you prepare for the certified Kubernetes administrator exam and gets you verified as a Kubernetes administrator.

## Kubernetes for Developers

- The Kubernetes for Developers course is for application developers who are looking to learn how to design, build, and configure cloud native applications.

- Now, you don't have to be an expert application developer for this course, and there's no real coding or application development involved in either this course or the certification itself.

- You only need to know the real basics of development on a platform like Python or Node.js.

- This course focuses on topics relevant for a developer such as ConfigMaps,secrets and service accounts,multi container pods, readiness and liveness probes, logging and monitoring, jobs, services, and networking.

## Kubernetes Setup (under newly created ubuntu VM ONLY) with CRI-Dockerd

- Master node

  - Run this below commands
    - sudo wget https://raw.githubusercontent.com/nayanrajani/kubernetes-udemy/main/kubernetes-beginners/master-node-setup.sh
    - sudo chmod 755 master-node-setup.sh
    - sudo bash master-node-setup.sh

- Worker node

  - Run this below command
    - sudo wget https://raw.githubusercontent.com/nayanrajani/kubernetes-udemy/main/kubernetes-beginners/worker-node-setup.sh
    - sudo chmod 755 worker-node-setup.sh
    - sudo bash worker-node-setup.sh

- after this above commands, run this below command in master to generate the token that can be pasted in worker node to join the cluster
  - sudo kubeadm token create --print-join-command
    - it will print the token, just copy and paste in the worker nodes
  - now to check the nodes have joined or not, run below command in master
    - kubectl get nodes


### kubernetes hard way installation

- Installing Kubernetes the hard way can help you gain a better understanding of putting together the different components manually.

- An optional series on this is available at our youtube channel here:
  - https://www.youtube.com/watch?v=uUupRagM7m0&list=PL2We04F3Y_41jYdadX55fdJplDvgNGENo

- The GIT Repo for this tutorial can be found here: https://github.com/mmumshad/kubernetes-the-hard-way


### Kubeadm way

- The vagrant file used in the next video is available here:
  - https://github.com/kodekloudhub/certified-kubernetes-administrator-course

- Here's the link to the documentation:
  - https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

- pre-requisite
  - Virtual Box
  - Vagrant
  - clone this repo

- Steps:

- Inside Local Machine
  - go inside that repo folder after cloning
  - vi Vagrantfile
    - check
  - vagrant status
    - check the status of VMs
  - vagrant up
    - it will take time.
    - you can check the logs.
  - vagrant status
  - vagrant ssh [name of master/node]  // to connect to the nodes/master
  - logout
  
- Refer the documentation
  - https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

- Inside ALL Nodes
  - Install a Container runtime
    - we will install containerd, click on the container runtime link in documentation
    - First install the pre-requisite for the container also.
      - run this below command on all the nodes
        cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
        overlay
        br_netfilter
        EOF

        sudo modprobe overlay
        sudo modprobe br_netfilter

        # sysctl params required by setup, params persist across reboots
        cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
        net.bridge.bridge-nf-call-iptables  = 1
        net.bridge.bridge-nf-call-ip6tables = 1
        net.ipv4.ip_forward                 = 1
        EOF

        # Apply sysctl params without reboot
        sudo sysctl --system

      - lsmod | grep br_netfilter
      - lsmod | grep overlay
      - sysctl net.bridge.bridge-nf-call-iptables net.bridge.bridge-nf-call-ip6tables net.ipv4.ip_forward

    - Now go to top and select the containerd as a runtime.
      - click on getting started with containerd
        - go to option 2 i.e., apt-get
          - select ubuntu
            - go to Install using the apt repository
              - Set up the repository
                - Update the apt package index and install packages to allow apt to use a repository over HTTPS:
                  - sudo apt-get update
                  - sudo apt-get install ca-certificates curl gnupg

                - Add Docker’s official GPG key:
                  - sudo install -m 0755 -d /etc/apt/keyrings
                  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                  - sudo chmod a+r /etc/apt/keyrings/docker.gpg

                - Use the following command to set up the repository:
                  - echo \
                    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
                    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
                    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

              - Install Containerd Engine
                - Update the apt package index:
                  - sudo apt-get update
                - Install Containerd
                  - sudo apt install containerd.io
                - systemctl status containerd

    - Go back to container Runtime Page
      - check for cgroup drivers
        - ps -p 1
        - if systemd
          - go to Configuring the systemd cgroup driver on documentation page
            - sudo vi /etc/containerd/config.toml
              - remove all the things inside this file
              - and paste the below configuration
                - [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc]
                    [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
                      SystemdCgroup = true
            - :wq!
            - sudo systemctl restart containerd
  - got to https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
    - install the kubeadm, kubelet and kubectl
      - You will install these packages on all of your machines:
        - kubeadm: the command to bootstrap the cluster.
        - kubelet: the component that runs on all of the machines in your cluster and does things like starting pods and containers.
        - kubectl: the command line util to talk to your cluster.

    - Debian
      - Update the apt package index and install packages needed to use the Kubernetes apt repository:
        - sudo apt-get update
        - sudo apt-get install -y apt-transport-https ca-certificates curl

      - Download the Google Cloud public signing key:
        - curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg

      - Add the Kubernetes apt repository:
        - echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

      - Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
        - sudo apt-get update
        - sudo apt-get install -y kubelet kubeadm kubectl
        - sudo apt-mark hold kubelet kubeadm kubectl

- Inside Master node
  - go to https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#initializing-your-control-plane-node

    - ip add
      - copy the ip address of the api server from 3 para
    - sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=[ip]
      - this above command will create an admin file, and will let you allow to run some command copy and paste those command in commandline and run it.
    - mkdir .....
    - sudo.....
    - sudo....
    - kubectl get pods
    - there is one link above in cli click on that link.
      - select weave net
        - run installation command and run it
        - kubectl get pods -A
          - you will see weave net
    - Now we need to match the weave net cidr range for pods to our cidr ranges that we provided
      - kubectl get ds -A (Deamon set)
      - kubectl edit weave-net -n kube-system
        - look for containers weave
        - inside the env add below lines:
          - - name: IPALLOC_RANGE
              value: 10.244.0.0/16
          - :wq!
      - kubectl get pods -A
  - go to worker node and paste the kubeadm join command
  - Now run below command to see the pods are visible
    - kubectl get nodes
  - to check, create a pod
    - kubectl run nginx --image=nginx

- Inside WorkerNode1
  - now join the cluster with master node kubeadm join command with sudo
- Inside WorkerNode2
  - now join the cluster with master node kubeadm join command with sudo

### Shortform

- Deployment => deploy
- Services => svc
- Namespaces => 
  - ns
  - kubectl get pods -n={namespacename}
- ServiceAccount =>
  - sa
  - kubectl get sa (name-scheduler) -n {namespacename}