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

- Enable communication between various components within and outside of the application.

- Service helps us connect applications together or users.

- <img width="386" alt="image" src="https://user-images.githubusercontent.com/57224583/219602877-fdfd15cb-5ad2-4475-a1f5-6a795025a4bd.png">

    - Kubernetes Services enable communication between various components within and outside of the application. Kubernetes Services helps us connect applications together with other applications or users. For example, our application has groups of PODs running various sections, such as a group for serving front-end load to users, another group running back-end processes, and a third group connecting to an external data source. It is Services that enable connectivity between these groups of PODs. Services enable the front-end application to be made available to users, it helps communication between back-end and front-end PODs, and helps in establishing connectivity to an external data source. Thus services enable loose coupling between microservices in our application.

- ![etc](https://user-images.githubusercontent.com/57224583/219603870-b5a6fe30-ec50-4ae5-8122-b34d9fe055f1.png)

- Service types

  - <img width="356" alt="image" src="https://user-images.githubusercontent.com/57224583/219604100-db085ea3-fdb0-4359-81f4-917da1e9e694.png">

    - NodePort

      - <img width="367" alt="image" src="https://user-images.githubusercontent.com/57224583/219604379-2eeb57c0-d74c-4975-ac88-83ecb870921a.png">

      - <img width="352" alt="image" src="https://user-images.githubusercontent.com/57224583/219605836-26cec7f4-2e81-4e33-842a-3e4801067c95.png">

        - If you look at it, there are 3 ports involved. The port on the POD were the actual web server is running is port 80. And it is referred to as the targetPort, because that is were the service forwards the requests to. The second port is the port on the service itself. It is simply referred to as the port. Remember, these terms are from the viewpoint of the service. The service is in fact like a virtual server inside the node. Inside the cluster it has its own IP address. And that IP address is called the Cluster-IP of the service. And finally we have the port on the Node itself which we use to access the web server externally. And that is known as the NodePort. As you can see it is 30008. That is because NodePorts can only be in a valid range which is from 30000 to 32767.

      - <img width="425" alt="image" src="https://user-images.githubusercontent.com/57224583/219605934-b1b06d48-cd2e-4601-bc24-cc6724d414df.png">

      - Let us now look at how to create the service. Just like how we created a Deployment, ReplicaSet or Pod, we will use a definition file to create a service. The high level structure of the file remains the same. As before we have apiVersion,kind, metadata and spec sections. The apiVersion is going to be v1. The kind is ofcourse service. The metadata will have a name and that will be the name of the service. It can have labels, but we don’t need that for now. Next we have spec. and as always this is the most crucial part of the file as this is were we will be defining the actual services and this is the part of a definition file that differs between different objects. In the spec section of a service we have type and ports. The type refers to the type of service we are creating. As discussed before it could be ClusterIP, NodePort, or loadBalancer. In this case since we are creating a NodePort we will set it as NodePort. The next part of spec is ports. This is were we input information regarding what we discussed on the left side of this screen. The first type of port is the targetPort, which we will set to 80. The next one is simply port, which is the port on the service object and we will set that to 80 as well. The third is NodePort which we will set to 30008 or any number in the valid range. Remember that out of these, the only mandatory field is port . If you don’t provide a targetPort it is assumed to be the same as port and if you don’t provide a nodePort a free port in the valid range between 30000 and 32767 is automatically allocated. Also note that portsis an array.

      - So note the dash under the ports section that indicate the first element in the array. You can have multiple such port mappings within a single service. So we have all the information in, but something is really missing. There is nothing here in the definition file that connects the service to the POD. We have simply specified the targetPort but we didn’t mention the targetPort on which POD. There could be 100s of other PODs with web services running on port 80. So how do we do that? As we did with the replicasets previously and a technique that you will see very often in kubernetes, we will use labels and selectors to link these together. We know that the POD was created with a label. We need to bring that label into this service definition file.

    - ![etc (2)](https://user-images.githubusercontent.com/57224583/219610474-846c40b9-fb65-4ccd-9ebb-74a8407a6dde.png)

      - So we have a new property in the spec section and that is selector. Under the selector provide a list of labels to identify the POD. For this refer to the poddefinition file used to create the POD. Pull the labels from the pod-definition file and place it under the selector section. This links the service to the pod. Once done create the service using the kubectl create command and input the service-definition file and there you have the service created.To see the created service, run the kubectl get services command that lists the services, their cluster-ip and the mapped ports. The type is NodePort as we created and the port on the node automatically assigned is 32432. We can now use this port to access the web service using curl or a web browser.

    - <img width="313" alt="image" src="https://user-images.githubusercontent.com/57224583/219612207-8ab8f8be-7158-4d93-a692-f8fa83801864.png">

      - So far we talked about a service mapped to a single POD. But that’s not the case all the time, what do you do when you have multiple PODs? In a production environment you have multiple instances of your web application running for highavailability and load balancing purposes. In this case we have multiple similar PODs running our web application. They all have the same labels with a key app set to value myapp. The same label is used as a selector during the creation of the service. So when the service is created, it looks for matching PODs with the labels and finds 3 of them. The service then automatically selects all the 3 PODs as endpoints to forward the external requests coming from the user. You don’t have to do any additional configuration to make this happen. And if you are wondering what algorithm it uses to balance load, it uses a random algorithm. Thus the service acts as a built-in load balancer to distribute load across different PODs.

    - <img width="301" alt="image" src="https://user-images.githubusercontent.com/57224583/219612446-8de97e41-3b10-4419-b275-1c8b4da72fc1.png">

      - And finally, lets look at what happens when the PODs are distributed across multiple nodes. In this case we have the web application on PODs on separate nodes in the cluster. When we create a service , without us having to do ANY kind of additional configuration, kubernetes creates a service that spans across all the nodes in the cluster and maps the target port to the SAME NodePort on all the nodes in the cluster. This way you can access your application using the IP of any node in the cluster and using the same port number which in this case is 30008. To summarize – in ANY case weather it be a single pod in a single node, multiple pods on a single node, multiple pods on multiple nodes, the service is created exactly the same without you having to do any additional steps during the service creation. When PODs are removed or added the service is automatically updated making it highly flexible and adaptive. Once created you won’t typically have to make any additional configuration changes.

    - Demo Services

      - check nodeport.yaml

        - <img width="419" alt="image" src="https://user-images.githubusercontent.com/57224583/219614047-c44de236-7f77-4f82-881d-dbd59bbaa0e6.png">

        - vi nodeport.yaml
        - cat nodeport.yaml
        - kubectl get svc
        - curl ip:80
        - nodeip:30004 (in browser)

### 37. Services Cluster IP

- <img width="297" alt="image" src="https://user-images.githubusercontent.com/57224583/219615530-3da16086-4f6c-4be1-98b0-5021082c83e3.png">

  - A kubernetes service can help us group these PODs together and provide a single interface to access the PODs in a group. For example a service created for the backend PODs will help group all the backend PODs together and provide a single interface for other PODs to access this service. The requests are forwarded to one of the PODs under the service randomly. Similarly, create additionalservices for Redis and allow the backend PODs to access the redis system through this service. This enables us to easily and effectively deploy a microservices based application on kubernetes cluster. Each layer can now scale or move as required without impacting communication between the various services. Each service gets an IP and name assigned to it inside the cluster and that is the name that should be used by other PODs to access the service. This type of service is known as ClusterIP.

  - To create such a service, as always, use a definition file. In the service definition file , first use the default template which has apiVersion, kind, metadata and spec. The apiVersion is v1 , kind is Service and we will give a name to our service – we will call it back-end. Under Specification we have type and ports. The type is ClusterIP. In fact, ClusterIP is the default type, so even if you didn’t specify it, it will automatically assume it to be ClusterIP. Under ports we have a targetPort and port. The target port is the port were the back-end is exposed, which in this case is 80. And the port is were the service is exposed. Which is 80 as well. To link the service to a set of PODs, we use selector.We will refer to the pod-definition file and copy the labels from it and move it under selector. And that should be it. We can now create the service using the kubectl create command and then check its status using the kubectl get services command. The service can be accessed by other PODs using the ClusterIP or the service name.

    - ![MicrosoftTeams-image (2)](https://github.com/nayanrajani/Personal/assets/57224583/3c7c484c-41bc-4a96-9f5f-7e4fd8e683a8)

    - ![MicrosoftTeams-image (3)](https://github.com/nayanrajani/Personal/assets/57224583/66e3b2e2-b76c-49c0-8391-1dbab0e6378d)

### 38. LoadBalancer

- <img width="440" alt="image" src="https://user-images.githubusercontent.com/57224583/219616922-678dacdc-1f23-43d6-b3da-e84591bae5ee.png">

  - What end users really want is a single URL to access the application. For this, you will be required to setup a separate Load Balancer VM in your environment. In this case I deploy a new VM for load balancer purposes and configure it to forward requests that come to it to any of the Ips of the Kubernetes nodes. I will then configure my organizations DNS to point to this load balancer when a user hosts http://myapp.com. Now setting up that load balancer by myself is a tedious task, and I might have to do that in my local or onprem environment. However, if I happen to be on a supported CloudPlatform, like Google Cloud Platform, I could leverage the native load balancing functionalities of the cloud platform to set this up. Again you don’t have to set that up manually, Kubernetes sets it up for you. Kubernetes has built-in integration with supported cloud platforms.

    - <img width="398" alt="image" src="https://user-images.githubusercontent.com/57224583/219620162-836cafa5-a290-40c4-94f5-271c9afa1575.png">

### 41. Namespaces

- In Kubernetes, namespaces provides a mechanism for isolating groups of resources within a single cluster. Names of resources need to be unique within a namespace, but not across namespaces. Namespace-based scoping is applicable only for namespaced objects (e.g. Deployments, Services, etc) and not for cluster-wide objects (e.g. StorageClass, Nodes, PersistentVolumes, etc).

- ![MicrosoftTeams-image (2)](https://github.com/nayanrajani/Personal/assets/57224583/c37cde2a-03d6-4dd0-a349-22d32cbc42c6)

- ![MicrosoftTeams-image (3)](https://github.com/nayanrajani/Personal/assets/57224583/75c37ea2-e8e4-46f9-875d-298ccf0bb9a6)

- ![MicrosoftTeams-image (4)](https://github.com/nayanrajani/Personal/assets/57224583/b4058379-d8eb-4c05-b1c8-ff6ed0ad1e86)

- ![MicrosoftTeams-image (5)](https://github.com/nayanrajani/Personal/assets/57224583/53baf829-a76f-45f9-a300-52c87ceddbd3)

- ![MicrosoftTeams-image (6)](https://github.com/nayanrajani/Personal/assets/57224583/5357141e-e3b6-40af-afe4-fe99620c9d87)

- ![MicrosoftTeams-image (7)](https://github.com/nayanrajani/Personal/assets/57224583/9c201959-7038-4668-9329-9233f2152453)

- ![MicrosoftTeams-image (8)](https://github.com/nayanrajani/Personal/assets/57224583/000184c3-b2ee-402b-869b-d856cb7e8d74)

- ![MicrosoftTeams-image (9)](https://github.com/nayanrajani/Personal/assets/57224583/ca64ff85-0ded-4dd1-a0c1-b2409e3e2d26)

- ![MicrosoftTeams-image (10)](https://github.com/nayanrajani/Personal/assets/57224583/3c2d6482-2438-4e9e-af28-0f6110994c43)

- ![MicrosoftTeams-image (11)](https://github.com/nayanrajani/Personal/assets/57224583/0cafba98-ccac-4a24-9ca1-0a7c4072567f)

  - When to Use Multiple Namespaces
    - Namespaces are intended for use in environments with many users spread across multiple teams, or projects. For clusters with a few to tens of users, you should not need to create or think about namespaces at all. Start using namespaces when you need the features they provide.

    - Namespaces provide a scope for names. Names of resources need to be unique within a namespace, but not across namespaces. Namespaces cannot be nested inside one another and each Kubernetes resource can only be in one namespace.

    - Namespaces are a way to divide cluster resources between multiple users (via resource quota).

    - It is not necessary to use multiple namespaces to separate slightly different resources, such as different versions of the same software: use labels to distinguish resources within the same namespace.

    - Note: For a production cluster, consider not using the default namespace. Instead, make other namespaces and use those.

  - Initial namespaces
    - Kubernetes starts with four initial namespaces:

    - default
      - Kubernetes includes this namespace so that you can start using your new cluster without first creating a namespace.
    - kube-node-lease
      - This namespace holds Lease objects associated with each node. Node leases allow the kubelet to send heartbeats so that the control plane can detect node failure.
    - kube-public
      - This namespace is readable by all clients (including those not authenticated). This namespace is mostly reserved for cluster usage, in case that some resources should be visible and readable publicly throughout the whole cluster. The public aspect of this namespace is only a convention, not a requirement.
    - kube-system
      - The namespace for objects created by the Kubernetes system.
  - Working with Namespaces
    - Creation and deletion of namespaces are described in the Admin Guide documentation for namespaces.

    - Note: Avoid creating namespaces with the prefix kube-, since it is reserved for Kubernetes system namespaces.
  - Viewing namespaces
    - You can list the current namespaces in a cluster using:

  - kubectl get namespace

  - For example:

    - kubectl run nginx --image=nginx --namespace=<insert-namespace-name-here>
    - kubectl get pods --namespace=<insert-namespace-name-here>
      - Setting the namespace preference
      - You can permanently save the namespace for all subsequent kubectl commands in that context.
    - kubectl config set-context --current --namespace=<insert-namespace-name-here>
  
  - Validate it
    - kubectl config view --minify | grep namespace:

  - Namespaces and DNS
    - When you create a Service, it creates a corresponding DNS entry. This entry is of the form <service-name>.<namespace-name>.svc.cluster.local, which means that if a container only uses <service-name>, it will resolve to the service which is local to a namespace. This is useful for using the same configuration across multiple namespaces such as Development, Staging and Production. If you want to reach across namespaces, you need to use the fully qualified domain name (FQDN).

    - As a result, all namespace names must be valid RFC 1123 DNS labels.

  - Warning:
    - By creating namespaces with the same name as public top-level domains, Services in these namespaces can have short DNS names that overlap with public DNS records. Workloads from any namespace performing a DNS lookup without a trailing dot will be redirected to those services, taking precedence over public DNS.

    - To mitigate this, limit privileges for creating namespaces to trusted users. If required, you could additionally configure third-party security controls, such as admission webhooks, to block creating any namespace with the name of public TLDs.

  - Not all objects are in a namespace
    - Most Kubernetes resources (e.g. pods, services, replication controllers, and others) are in some namespaces. However namespace resources are not themselves in a namespace. And low-level resources, such as nodes and persistentVolumes, are not in any namespace.

    - To see which Kubernetes resources are and aren't in a namespace:

  - In a namespace
    - kubectl api-resources --namespaced=true

  - Not in a namespace
    - kubectl api-resources --namespaced=false

### 44. Imperative vs Declarative

- Now in the infrastructure-as-code world, there are different approaches in managing the infrastructure, and they are classified into imperative and declarative approaches.

- Let's understand these with an analogy.
- ![MicrosoftTeams-image (5)](https://github.com/nayanrajani/Personal/assets/57224583/21d7fad5-bec0-486e-8637-7d6458b1f343)
- Imperative
  - Let's say you want to visit a friend's house located at Street B. Now in the past, you would hire a taxi and give step-by-step instructions to the driver on how to reach the destination, like take right to street B, then take left to go to street C, and then take another left and then right to go to Street D, and stop at the house. Specifying what to do and how to do, more importantly, is the imperative approach.

- Declarative
  - On the other hand, today, when you book a cab, say through Uber, you just specify the final destination, like drive to Tom's house, and this is the declarative approach.

  - In this case, we're not giving step-by-step instructions. Instead, we're just specifying the final destination. We're declaring the final destination, and the system figures out the right path to reach the destination. Specifying what to do, not how to do, is the declarative approach.


- In Kubernetes Way
- ![MicrosoftTeams-image (4)](https://github.com/nayanrajani/Personal/assets/57224583/6fc964b7-8901-4252-981b-8e77746a4e98)

  - Imperative
    - In the Kubernetes world, the imperative way of managing infrastructure is using commands like the kubectl run command to create a pod. The kubectl create deployment command to create a deployment.
    - The kubectl expose command to create a service, to expose a deployment. And the kubectl edit command may be used to edit an existing object. For scaling a deployment or replica set, use the kubectl scale command. And updating the image on a deployment, we use the kubectl set image command
    - Now we have also used object configuration files to manage objects, such as creating an object using the kubectl create -f command, with the f option to specify the object configuration file. And editing an object using the kubectl replace command. And deleting an object using the kubectl delete command.
    - All of these are imperative approaches to managing objects in Kubernetes.
    - We're saying exactly how to bring the infrastructure to our needs by creating, updating, or deleting objects.

    - ![MicrosoftTeams-image (7)](https://github.com/nayanrajani/Personal/assets/57224583/c96eef29-47df-4266-a8f0-6f830d00452f)

    - However, note that there is a difference between the live object and the definition file that you have locally. The change you made using the kubectl edit command is not really recorded anywhere.
    - After the change is applied, you're only left with your local definition file, which in fact has the old image name in it. In the future, say you or a teammate decide to make a change to this object,unaware that a change was made using the kubectl edit command, when the new change is applied, the previous change to the image is lost. So you can use the kubectl edit command if you are making a change and you're sure that you're not going to rely on the object configuration file in the future.
    - But a better approach to that is to first edit the local version of the object configuration file, with the required changes, that is, by updating the image name here, and then running the kubectl replace command to update the object.

    - ![MicrosoftTeams-image (6)](https://github.com/nayanrajani/Personal/assets/57224583/235f13e4-c073-45f0-b7fc-5d56258f28df)

    - This way, going forward, the changes made are recorded and can be tracked as part of the change review process. So at times, you may want to completely delete and recreate objects. In such cases, you may run the same command, but with the force option, like this. Now, this is still the imperative approach, because you're still instructed Kubernetes how to create or update these objects. First, you run the kubectl create command to create the object, and then you run the replace command to replace the object, or delete command to delete the object. And what if you run the create command if the object already exists?
    - Now, then it would fail with an error that says the pod already exists.When you update an object, you should always make sure that the object exists first before running the replace command. If an object does not exist, the replace command fails with an error message. So the imperative approach is very taxing for you as an administrator, as you must always be aware of the current configurations and perform checks to make sure that things are in place before making a change.
  
    - ![MicrosoftTeams-image (3)](https://github.com/nayanrajani/Personal/assets/57224583/88ac8991-a0e7-4c71-9fc3-d6ba90ae4d49)

  - Declarative
    - The declarative approach would be to create a set of files that defines the expected state of the applications and services on a Kubernetes cluster. And with a single kubectl apply command, Kubernetes should be able to read the configuration files and decide by itself what needs to be done to bring the infrastructure to the expected state.
    - So in the declarative approach, you will run the kubectl apply command for creating, updating, or deleting an object. The apply command will look at the existing configuration and figure out what changes need to be made to the system.

    - The declarative approach is where you use the same object configuration files that we've been working on. But instead of the create or replace commands, we use the kubectl apply command to manage objects. The kubectl apply command is intelligent enough to create an object if it doesn't already exist. If there are multiple object configuration files, as you would usually, then you may specify a directory as the path instead of a single file. That way, all the objects are created at once. Now when changes are to be made, we simply update the object configuration file and run the kubectl apply command again. And this time, it knows that the object exists. And so it only updates the object with the new changes.

    - ![MicrosoftTeams-image (3)](https://github.com/nayanrajani/Personal/assets/57224583/5188fe31-4f81-4125-8241-c575958d6f9a)

    - So it never really throws an error that says the object already exists or the updates cannot be applied. It will always figure out the right approach to updating the object.So going forward, any changes made on the application, whether they are updating images or fields of existing configuration files,or adding new configuration files altogether for new objects, all we do is simply update our local directory  with the changes and then the kubectl apply command take care of the rest.

    - ![MicrosoftTeams-image (2)](https://github.com/nayanrajani/Personal/assets/57224583/730e3f55-3c08-4d2b-872a-571112fdb6fd)


- Exam Tip!
  - ![MicrosoftTeams-image (4)](https://github.com/nayanrajani/Personal/assets/57224583/455fa6e1-1ded-402a-a094-8e300cb387e9)

  - So from an exam perspective, you could use the imperative approach to save time as much as possible.For example, if a question is to just create a pod or a deployment with a given image, then one of these imperative commands can help you achieve that quickly. So it's important to practice the imperative commands. If you need to edit a property of an existing object, then using the kubectl edit command may be the quickest way, right?
  - If you have a complex requirement, say, for example that requires multiple containers, environment variables, commands, init containers, etc, then using an object configuration file to create the object would be preferred. 
  - This way, if you see that you made a mistake, you can easily update the file and apply it again.
  - And using the kubectl apply command in that case would be a better option.

### 48. Kubectl Apply Command

- ![MicrosoftTeams-image (3)](https://github.com/nayanrajani/Personal/assets/57224583/3d621fda-ee5c-4b4a-a382-e9a7c9ca47f1)

- The apply command takes into consideration the local configuration file, the live object definition on Kubernetes, and the last applied configuration before making a decision on what changes are to be made. So when you run the apply command,if the object does not already exist the object is created. When the Object is created, an object configuration, similar to what we created locally is created within Kubernetes but with additional fields to store status of the object. This is the live configuration of the object on the Kubernetes cluster. This is how Kubernetes internally stores information about an object, no matter what approach you use to create the object. But when you use the kubectl apply command
to create an object, it does something a bit more. The YAML version of the local object configuration file we wrote is converted to a json format, and it is then stored as the last applied configuration.
- Going forward, for any updates to the object, all the three are compared to identify what changes are
to be made on the live object. For example, say when the nginX image is updated to 1.19 in our local file and we are on the kubectl apply command, this value is compared with the value in the live configuration.And if there is a difference, the live configuration is updated with the new value. After any change, the last applied json format is always updated to the latest so that it's always up to date.
- So, why do we then really need the last applied configuration, right? So if a field was deleted, say 
for example the type label was deleted, and now when we run the kubectl apply command, we see that the last applied configuration had a label but it's not present in the local configuration. This means that the field needs to be removed from the live configuration. So if a field was present in the live configuration and not present in the local or the last applied configuration, then it will be left as is.- But if a field is missing from the local file and it is present in the last applied configuration, so that means that in the previous step, or whenever the last time we ran the kubectl apply command, that particular field was there and it is now being removed. So the last applied configuration helps us figure out what fields have been removed from the local file, right?
- So that field is then removed from the actual, the live configuration. What we just discussed is available for your reference in detail in the Kubernetes document pages. So follow this link to view that.Okay, so we saw the three sets of files, and we know that the local file is what's stored on our local system. The live object configuration is in the Kubernetes memory. But where is this json file that has the last applied configuration stored? Well, it's stored on the live object configuration on the Kubernetes cluster itself as an annotation named a last applied configuration.
- So remember that this is only done when you use the apply command. The kubectl create or replace command
do not store the last applied configuration like this. So you must bear in mind not to mix the imperative and declarative approaches while managing the Kubernetes objects. So once you use the applied command, going forward,whenever a change is made the apply command compares all three sections. The local part definition file, the live object configuration, and the last applied configuration stored within the live object configuration file, for deciding what changes are to be made to the live configuration, similar to what we saw

- ![MicrosoftTeams-image (2)](https://github.com/nayanrajani/Personal/assets/57224583/5c03e84a-b6a1-4316-822c-b657730bb1ef)