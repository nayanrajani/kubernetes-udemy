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

### 12. Docker-vs-ContainerD

- https://kodekloud.com/blog/docker-vs-containerd/
- https://www.knowledgehut.com/blog/devops/docker-vs-containerd
- https://blog.purestorage.com/purely-informational/containerd-vs-docker-whats-the-difference/
- https://earthly.dev/blog/containerd-vs-docker/