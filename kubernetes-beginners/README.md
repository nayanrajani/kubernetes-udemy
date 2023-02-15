# Kubernetes-Beginners

## Intoduction

- We will go through an overview of Kubernetes. Kubernetes, also known as K8s was built by Google based on their experience running containers in production.

- It is now an open source project and is arguably one of the best and most popular container orchestration technologies out there.

## Container & Orchestration

- Containers

  - So what are containers? Containers are completely isolated environments. As in they can have their own processes or services, their own networking interfaces, their own mounts just like virtual machines.
  - Except they all share the same operating system Kernel.
  - We will look at what that means in a bit.
  - What is also important to note that containers are not new with Docker. Containers have existed for about 10 years now and some of the different types of containers are LXC, LXD, LXCFS etc.
  - Docker utilises LXC containers. Setting up these container environments is hard as they are very low level and that is where a docker offers a high level tool with several powerful functions making it really easy for end users like us.

- Orchestration
  - So we learned about containers and we now have our application packaged into a docker container. But what next? How do you run it in production? What if your application relies on other containers such as database or messaging services or other backend services? What if the number of users increase and you need to scale your application? You would also like to scale down when the load decreases.
  - To enable these functionalities you need an underlying platform with a set of resources. The platform needs to orchestrate the connectivity between the containers and automatically scale up or down based on the load. This whole process of automatically deploying and managing containers is known as Container Orchestration.

## Architecture

- Nodes

  - Let us start with Nodes. A node is a machine – physical or virtual – on which kubernetesis installed. A node is a worker machine and this is were containers will be launched by kubernetes.It was also known as Minions in the past. So you might here these terms used inter changeably.
  - But what if the node on which our application is running fails? Well, obviously our application goes down. So you need to have more than one nodes.

- Cluster

  - A cluster is a set of nodes grouped together. This way even if one node fails you have your application still accessible from the other nodes. Moreover having multiple nodes helps in sharing load as well.

- Master
  - Now we have a cluster, but who is responsible for managing the cluster? Were is the information about the members of the cluster stored? How are the nodes monitored? When a node fails how do you move the workload of the failed node to another worker node? That’s were the Master comes in. The master is another node with Kubernetes installed in it, and is configured as a Master. The master watches over the nodes in the cluster and is responsible for the actual orchestration of containers on the worker nodes.

### Components of Kubernetes

- When you install Kubernetes on a System, you are actually installing the following components. An API Server. An ETCD service. A kubelet service. A Container Runtime, Controllers and Schedulers.

- The API server acts as the front-end for kubernetes. The users, management devices, Command line interfaces all talk to the API server to interact with the kubernetes cluster.

- Next is the ETCD key store. ETCD is a distributed reliable key-value store used by kubernetesto store all data used to manage the cluster. Think of it this way, when you have multiple nodes and multiple masters in your cluster, etcd stores all that information on all the nodes in the cluster in a distributed manner. ETCD is responsible for implementing locks within the cluster to ensure there are no conflicts between the Masters.

- The scheduler is responsible for distributing work or containers across multiple nodes. It looks for newly created containers and assigns them to Nodes.

- The controllers are the brain behind orchestration. They are responsible for noticing and responding when nodes, containers or endpoints goes down. The controllers makes decisions to bring up new containers in such cases.
- The container runtime is the underlying software that is used to run containers. In our case it happens to be Docker.
- And finally kubelet is the agent that runs on each node in the cluster. The agent is responsible for making sure that the containers are running on the nodes as expected.

- Kubectl

  - we also need to learn a little bit about ONE of the command line utilities known as the kube command line tool or kubectl or kube control as it is also called. The kube control tool is used to deploy and manage applications on a kubernetes cluster, to get cluster information, get the status of nodes in the cluster and many other things.

  - The kubectl run command is used to deploy an application on the cluster. The kubectl cluster-info command is used to view information about the cluster and the kubectl get pod command is used to list all the nodes part of the cluster. That’s all we need to know for now and we will keep learning more commands throughout this course. We will explore more commands with kubectl when we learn the associated concepts.For now just remember the run, cluster-info and get nodes commands and that will help us get through the first few labs.

## Kubernetes Setup

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
