## Section-2 - Core Concept

### 11.Cluster Architecture

- Master node
  - The master node is responsible for managing the Kubernetes cluster, storing information regarding the different nodes, planning which containers goes where, monitoring the nodes and containers on them, et cetera.

  - The master node does all of these using a set of components together known as the control playing components.

  - We will look at each of these components now.

- ETCD Cluster
  - Now, there are many containers being loaded and unloaded from the ships on a daily basis and so you need to maintain information about the different ships, what container is on which ship and what time it was loaded, et cetera.

  - All of these are stored in a highly available key value store, known as etcd.

  - Etcd is a database that stores information in a key value format.

- Kube-scheduler
  - A scheduler identifies the right node to place a container on based on the containers resource requirements,the worker nodes capacity or any other policies or constraints, such as taintsand tolerations or node affinity rules that are on them.

- Controller-Manager
  - we have controllers available that take care of different areas. The node controller takes care of nodes.
  - They're responsible for onboarding new nodes to the cluster, handling situations where nodes become unavailableor get destroyed, and the replication controller ensures that the desired number of containers are running at all times in a replication group.

- Kube API
  - The Kube API server is the primary management component of Kubernetes.
  - The Kube API server is responsible for orchestrating all operations within the cluster.
  - It exposes the Kubernetes API, which is used by external users to perform management operations on the cluster, as well as the various controllers to monitor the state of the cluster and make necessary changes as required and by the worker nodes to communicate with the server.

- Containers
  - Now, we are working with containers here.
  - Containers are everywhere, so we need everything to be container compatible.
  - Our applications are in the form of containers. The different components that form the entire management system on the master node could be hosted in the form of containers.
  - The DNS service networking solution can all be deployed in the form of containers.
  - So we need these software that can run containers and that's the container runtime engine, a popular one being Docker.
  - So we need Docker, or it's supported equivalent installed on all the nodes in the cluster, including the master nodes, if you wish to host the controlling components as containers.
  - Now, it doesn't always have to be Docker. Kubernetes supports other runtime engines as well like ContainerD, a Rocket.
  
- Let us now turn our focus onto the cargo ships.

- Kubelet
  - Now, every ship has a captain. The captain is responsible for managing all activities on these ships. The captain is responsible for liaising with the master ships, starting with letting the mastership know that they're interested in joining the group, receiving information about the containers to be loaded on the ship and loading the appropriate containers as required, sending reports back to the master about the status of this ship and the status of the containers on the ship, et cetera.
  - Now, the captain of the ship is the kubelet in Kubernetes. A kubelet is an agent that runs on each node in a cluster. It listens for instructions from the Kube API server and deploys or destroys containers on the nodes as required.
  - The Kube API server periodically fetches status reports from the kubelet to monitor the status of nodes and containers on them. The kubelet was more of a captain on the ship that manages containers on the ship but the applications running on the worker nodes need to be able to communicate with each other.

- Kube Proxy Service
  - For example, you might have a web server running in one container on one of the nodes and a database server running on another container on another node. How would the web server reach the database server on the other node?
  - Communication between worker nodes are enabled by another component that runs on the worker node known as the Kube Proxy Service.
  - The Kube Proxy Service ensures that the necessary rules are in place on the worker nodes to allow the containers running on them to reach each other.

- Summary
  - So to summarize, we have master and worker nodes. On the master, we have the etcd cluster, which stores information about the cluster. We have the cube scheduler that is responsible for scheduling applications or containers on nodes.
  - We have different controllers that take care of different functionslike the node controller, replication controller, et cetera.
  - We have the Kube API server that is responsible for orchestrating all operations within the cluster. On the worker node, we have the kubelet that listens for instructions from the Kube API server and manages containers and the Kube Proxy that helps in enabling communicationbetween services within the cluster.

- Master (Manage, PLan, Schedule, Monitor Nodes)
  - ETCD Cluster
  - Kuber-apiserver
  - Kube Controller Manager
  - Kube Scheduller

- Worker Node (Host Application as a containers)
  - Kubelet
  - kube-proxy
  - Container runtime engine (cre)
    - supports Docker and Rocket

### 12. Docker-vs-ContainerD

- https://kodekloud.com/blog/docker-vs-containerd/
- https://www.knowledgehut.com/blog/devops/docker-vs-containerd
- https://blog.purestorage.com/purely-informational/containerd-vs-docker-whats-the-difference/
- https://earthly.dev/blog/containerd-vs-docker/
- https://containerd.io/
- https://www.docker.com/blog/what-is-containerd-runtime/

- CLI-CTR
  - this is solely made for debugging containerd.
  - not to manage container or create
  - ![MicrosoftTeams-image (2)](https://github.com/nayanrajani/Personal/assets/57224583/3e02dedd-fe51-454a-9acc-01ab1b1fced7)
  - ![MicrosoftTeams-image (2)](https://github.com/nayanrajani/Personal/assets/57224583/3e02dedd-fe51-454a-9acc-01ab1b1fced7)

- CLI-nerdctl
  - ![MicrosoftTeams-image (4)](https://github.com/nayanrajani/Personal/assets/57224583/d1d95dc3-f895-4bf5-857c-aa7be89b45e0)
  - ![MicrosoftTeams-image (5)](https://github.com/nayanrajani/Personal/assets/57224583/4fad29c0-1566-4fe1-b9b9-c4b96c5f11e0)

- CLI-crictl
  - ![MicrosoftTeams-image (6)](https://github.com/nayanrajani/Personal/assets/57224583/24ca84ee-c6df-4bcc-bed6-0631a33429ef)
  - ![MicrosoftTeams-image (7)](https://github.com/nayanrajani/Personal/assets/57224583/1744d7eb-e5c1-4803-9e8a-0a5cf0581555)

- Docker vs crictl
  - ![MicrosoftTeams-image (8)](https://github.com/nayanrajani/Personal/assets/57224583/5feb155a-fd82-44b1-85f6-2f5758ce562e)
  - ![MicrosoftTeams-image (9)](https://github.com/nayanrajani/Personal/assets/57224583/34a67d5d-d39f-4ef5-9841-47e31e6f7e6f)

- ![MicrosoftTeams-image (2)](https://github.com/nayanrajani/Personal/assets/57224583/023f46f7-c119-4232-b689-655360738735)

### 13. ETCD For Beginners

- Objectives
  - What is ETCD
    - ETCD is distributed reliable key-value store that is simple, secure & fast.
  - What is key-value store?
    - traditional way of storing data was in a row and column table like sql.
    - but key-value is a nosql type.
    - it stores data in form of document/files.
  - How to get Started quickly?
    - Download binaries
    - extract
    - run etcd service
      - ./etcd
  - How to operate ETCD?
    - run etcd service
      - ./etcd
        - it start to listen at port 2379 by default.
      - etcdctl is a cli to store and retrive data in a key-value pair.
        - ./etcdctl set key1 value1
        - ./etcdctl get key1
    - ./etcdctl --version

  - Later:
    - What is a distributed system?
    - how ETCD Operates
    - RAFT Operates
    - Best Practice on number of nodes

### 14. ETCD in Kubernetes

- ETCD stores the following:
  - Nodes
  - PODs
  - Configs
  - Secrets
  - Accounts
  - Roles
  - Bindings
  - Others

- the changes for the above only considered stored in ETCD when the chnages are successfull.

- There are two ways to deploy the ETCD in Kubernetes
  - From Scratch
    - Download Binaries
    - define etcd.service
  - Kubeadm tool
    - it deploys in a pod as a kube-system namespace
    - to get all the keys in pod
      = kubectl exec etcd-master -n kube-system etcdctl get / --prefix -keys-only

### 16. Kube-API Server

- Primary management component in kubernetes
- Create a pod
  - Authenticate User
  - Validate User
  - Retrieve data
  - update ETCD
  - scheduler
  - kubelet

- Kube-api is the only service that interact with ETCD data store

- View api server option
  - service
    - cat /etc/systemd/system/kube
  - running
    - ps -aux | grep kube-apiserver

- view api-server kubeadm
  - kubectl get pods -n kube-system

### 17. Kube Controller Manager

- controller continously monitors the state of various components and works towards to bring the service in the desired functionng state.
- it is like a manager
- focus on
  - watch status
  - remediate situation

- Controllers
  - Node-controllers
    - check the nodes health
    - node monitor period = 5s
    - node monitor grace period = 40s (then unreachable)
    - POD Eviction Timeout = 5M (if doesn't comes up in 5M then it will create a new POD, if it has replicaset)
  - Replication-Controller
    - Responsible to monitor replicaset
    - to keep the desired number of replicaset up and running.
  - PV-Binder-Controller
  - Stateful-Set
  - Replicaset
  - Service-Account-Controller
  - CronJob
  - Deployment-Controller
  - Namespace-Controller
  - Endpoint-Controller

- These all controllers are packaged under the "Kube-Controller-Manager"
- Install binaries from kubernetes page
- run it as a service

- View with Kubeadm (installed as a pod)
  - kubectl get pods -n kube-system

- view withoud kubeadm
  - cat /etc/systemd/system/kube-controller-manager.service

- view running process
  - ps -aux | grep kube-controller-manager

### 18. Kube Scheduler

- kube-scheduler only responsible to decide which pod goes on which node
- why do we need scheduler
  - when there are many ships and many containers, we wanna make sure the right container lands on a right ship.
  - there can be of different sizes, destinations and capacity.

- Two phases to identify the best scheduler for the POD
  - Filter Nodes
    - to filter out the profiles which do not fit the profile foor the POD
  - Ranks Nodes (runs a priority function)
    - Ranks the best nodes first according to the POD requirement

- Without kubeadm
  - download binaries
  - run it as a service

- with kubeadm
  - it will directly run into a POD

- view running resources
  - ps -aux | grep kube-scheduler

### 19. Kubelet

- Kubelet is like a captian on the ship, who leads all the activities.

- Register the Node
- Create PODs
- Monitor Pods & Nodes

- Kubeadm doesnot deploy kubelets
- view running resources
  - ps -aux | grep kubelet

### 20. Kube Proxy

- in kubernetes cluster every pod can reach every other pod.
- this is done by a POD networking section
- Kube-proxy is a process that runs on each Node in kubernetes cluster.
- it's service is to point the newly created service to communicate.

- Without kubeadm
  - download binaries
  - run it as a service

- with kubeadm
  - it will directly run into a POD
  - kubectl get daemonset -n kube-system

### 21. Recap - Pods

- Before we head into understanding PODs, we would like to assume that the following have been setup already. At this point, we assume that the application is already developed and built into Docker Images and it is availalble on a Docker repository like Docker hub, so kubernetes can pull it down. We also assume that the Kubernetes cluster has already been setup and is working. This could be a single-node setup or a multi-node setup, doesn’t matter. All the services need to be in a running state.

- https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/
- https://kubernetes.io/docs/concepts/

- with Kubernetes, our ultimate aim is to deploy our application in the form of containers on a set of machines that are configured as worker nodes in a cluster.
- However, Kubernetes does not deploy containers directly on the worker nodes.
- The containers are encapsulated into a Kubernetes object known as pods. A pod is a single instance of an application. A pod is the smallest object that you can create in Kubernetes.

### 22. Pods with YAML

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

  - Demo
    - vi pod.yaml
      - Check yaml folder
      - ![20230216_140608](https://user-images.githubusercontent.com/57224583/219311648-46f9e264-7180-4f66-9428-500f7a30e2cc.jpg)
    - cat pod.yaml
    - kubectl apply -f pod.yaml
    - kubectl get pods
    - kubectl describe pod (podname)
  - Tips & Tricks
    - Extension for VSCode
      - Kubernetes support
      - Yaml by RedHat

### 29. Recap - ReplicaSets

- Replication Controllers

  - Controllers are the brain behind Kubernetes. They are processes that monitor kubernetes objects and respond accordingly.

  - It’s important to note that there are two similar terms. Replication Controller and Replica Set. Both have the same purpose but they are not the same. Replication Controller is the older technology that is being replaced by Replica Set. Replica set is the new recommended way to setup replication. However, whatever we discussed in the previous few slides remain applicable to both these technologies. There are minor differences in the way each works and we will look at that in a bit.

  - <img width="429" alt="image" src="https://user-images.githubusercontent.com/57224583/219348839-d18013fc-bd6b-4d88-bbc0-593e74acbea6.png">

- ReplicaSet

  - The apiVersion though is a bit different. It is apps/v1 which is different from what we had before for replication controller.
  - The kind would be ReplicaSet and we add name and labels in metadata.
  
  - ![MicrosoftTeams-image (1)](https://user-images.githubusercontent.com/57224583/219351093-0f465160-5cd1-4302-8724-70c6afc2fade.png)

  - Labels and Selectors

    - <img width="424" alt="image" src="https://user-images.githubusercontent.com/57224583/219351761-6b633d21-17a1-40ac-87b3-2a2f87164f42.png">

  - Scale
    - <img width="426" alt="image" src="https://user-images.githubusercontent.com/57224583/219352703-f0e1febb-4660-4011-87d1-45601c5916d0.png">

  - Commands

    - <img width="388" alt="image" src="https://user-images.githubusercontent.com/57224583/219352975-d65a05cb-9e50-46f0-b535-412dd1614909.png">

### 32. Deployments

- <img width="425" alt="image" src="https://user-images.githubusercontent.com/57224583/219555358-d61303a2-486f-40e3-bdc1-c2a196a8c92e.png">

  - Deployment which is a kubernetes object that comes higher in the hierarchy. The deployment provides us with capabilities to upgrade the underlying instances seamlessly using rolling updates, undo changes, and pause and resume changes to deployments.

  - <img width="429" alt="image" src="https://user-images.githubusercontent.com/57224583/219555592-2309a767-a378-4af4-bf01-556abd19f064.png">

  - Demo for Deplyment

    - check deployment.yaml
      - <img width="239" alt="image" src="https://user-images.githubusercontent.com/57224583/219556587-40c30e26-d562-4aa4-8549-fe8b6996a440.png">
      - cat deployment.yaml
      - kubectl create -f deployment.yaml
      - kubectl get deployment
      - kubectl get pods
      - kubectl describe deployment myapp-deployment
      - kubectl get all

### 36. Services

- 