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

