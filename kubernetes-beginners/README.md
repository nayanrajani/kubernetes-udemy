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

## Kubernetes Concepts

### POds

- Before we head into understanding PODs, we would like to assume that the following have been setup already. At this point, we assume that the application is already developed and built into Docker Images and it is availalble on a Docker repository like Docker hub, so kubernetes can pull it down. We also assume that the Kubernetes cluster has already been setup and is working. This could be a single-node setup or a multi-node setup, doesn’t matter. All the services need to be in a running state.

- https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/
- https://kubernetes.io/docs/concepts/

- Master-node
  - kubectl run nginx --image=nginx
  - kubectl get pods
  - kubectl describe nginx
  - kubectl describe pods nginx
  - kubectl get pods -o wide

## YAML

- ![20230216_132717](https://user-images.githubusercontent.com/57224583/219305060-a6c43299-c6de-40ca-a71e-5ddd0d909f27.jpg)

- YAML file is used to represent the DATA, the configuration DATA

- ![20230216_132752](https://user-images.githubusercontent.com/57224583/219304695-2cff5c7f-ce88-45d9-ba46-621bedb2ce3a.jpg)

- ![20230216_132816](https://user-images.githubusercontent.com/57224583/219305231-55e07ee7-a06b-4226-a91b-88adf86eb9bb.jpg)

- ![20230216_132827](https://user-images.githubusercontent.com/57224583/219305349-57cc09e8-7ff5-4993-a1c1-90e6ea4ff0ba.jpg)

- When to use:

  - Dictionaries

    - ![20230216_132902](https://user-images.githubusercontent.com/57224583/219305440-524b0b96-d38c-4450-96e9-47606ae23a96.jpg)

  - List

    - ![20230216_132919](https://user-images.githubusercontent.com/57224583/219305735-68e186f5-9f10-4b33-92da-311e154ccec4.jpg)

  - List of Dictionaries
    - ![20230216_132937](https://user-images.githubusercontent.com/57224583/219305520-88cccc0c-86b0-4ba8-8f27-02acf81ff36c.jpg)

- Notes:
  - ![20230216_133003](https://user-images.githubusercontent.com/57224583/219305846-b2f5ccd8-3995-4bc8-9699-137654702c22.jpg)

## Kubernetes Concepts- PODS, ReplicaSets, Deployment

### POds with YAMl

- Kubernetes uses YAML files as input for the creation of objects such as PODs, Replicas, Deployments, services etc. All of these follow similar structure. A kubernetes definition file always contains 4 top level fields. The apiVersion, kind, metadata and spec. These are top level or root level properties. Think of them as siblings, children of the same parent. These are all REQUIRED fields, so you MUST have them in your configuration file.

- ![20230216_133338](https://user-images.githubusercontent.com/57224583/219305923-fafd2740-c218-4972-815e-e3438516c202.jpg)

- Let us look at each one of them.

  - The first one is the apiVersion.

    - This is the version of the kubernetes API we’re using to create the object. Depending on what we are trying to create we must use the RIGHT apiVersion. For now since we are working on PODs, we will set the apiVersion as v1. Few other possible values for this field are apps/v1beta1, extensions/v1beta1 etc. We will see what these are for later in this course.

  - Next is the kind.

    - The kind refersto the type of object we are trying to create, which in this case happens to be a POD. So we will set it as Pod. Some other possible values here could be ReplicaSet or Deployment or Service, which is what you see in the kind field in the table on the right.

  - The next is metadata.

    - The metadata is data about the object like its name, labels etc. As you can see unlike the first two were you specified a string value, this, is in the form of a dictionary. So everything under metadata is intended to the right a little bit and so names and labels are children of metadata. The number of spaces before the two properties name and labels doesn’t matter, but they should be the same as they are siblings. In this case labels has more spaces on the left than name and so it is now a child of the name property instead of a sibling. Also the two properties must have MORE spaces than its parent, which is metadata, so that its intended to the right a little bit. In this case all 3 have the same number of spaces before them and so they are all siblings, which is not correct. Under metadata, the name is a string value – so you can name your POD myapp-pod - and the labels is a dictionary. So labels is a dictionary within the metadata dictionary. And it can have any key and value pairs as you wish. For now I have added a label app with the value myapp. Similarly you could add other labels as you see fit which will help you identify these objects at a later point in time. Say for example there are 100s of PODs running a front-endapplication, and 100’s of them running a backend application or a database, it will be DIFFICULT for you to group these PODs once they are deployed. If you label them now as front-end, back-end or database, you will be able to filter the PODs based on this label at a later point in time.

    - It’s IMPORTANT to note that under metadata, you can only specify name or labels or anything else that kubernetes expects to be under metadata. You CANNOT add any other property as you wish under this. However, under labels you CAN have any kind of key or value pairs as you see fit. So its IMPORTANT to understand what each of these parameters expect.

  - So far we have only mentioned the type and name of the object we need to create which happens to be a POD with the name myapp-pod, but we haven’t really specified the container or image we need in the pod.
  - The last section in the configuration file is the specification which is written as spec.
    - Depending on the object we are going to create, this is were we provide additional information to kubernetes pertaining to that object. This is going to be different for different objects, so its important to understand or refer to the documentation section to get the right format for each. Since we are only creating a pod with a single container in it, it is easy. Spec is a dictionary so add a property under it called containers, which is a list or an array. The reason this property is a list is because the PODs can have multiple containers within them as we learned in the lecture earlier. In this case though, we will only add a single item in the list, since we plan to have only a single container in the POD. The item in the list is a dictionary, so add a name and image property. The value for image is nginx.

- Once the file is created, run the command kubectl create -f followed by the file name
  which is pod-definition.yml and kubernetes creates the pod.
  So to summarize remember the 4 top level properties. apiVersion, kind, metadata
  and spec. Then start by adding values to those depending on the object you are
  creating.

  - ![20230216_133412](https://user-images.githubusercontent.com/57224583/219306005-a3b3c18b-d0d3-4540-8456-11885f7a78e5.jpg)

### Demo

- vi pod.yaml
  #(you need to format this below code with similar to image)
  apiVersion: v1
  kind: Pod
  metadata:
  name: nginx
  labels:
  app: nginx
  tier: frontend
  spec:
  containers:

  - name: nginx
    image: nginx

  - ![20230216_140608](https://user-images.githubusercontent.com/57224583/219311648-46f9e264-7180-4f66-9428-500f7a30e2cc.jpg)

- cat pod.yaml
- kubectl apply -f pod.yaml
- kubectl get pods
- kubectl describe pod <podname>
