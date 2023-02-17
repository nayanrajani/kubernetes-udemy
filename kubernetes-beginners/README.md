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

  - this contains all the details

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

      - Check yaml folder
      - ![20230216_140608](https://user-images.githubusercontent.com/57224583/219311648-46f9e264-7180-4f66-9428-500f7a30e2cc.jpg)

    - cat pod.yaml
    - kubectl apply -f pod.yaml
    - kubectl get pods
    - kubectl describe pod (podname)

    ### Tips & Tricks

    - Extension for VSCode

      - Kubernetes support
      - Yaml by RedHat

      #### Coding Exercise

      - this contains coding excercise

        - PODs - 1

          - Introduction: Let us start simple! Given a pod-definition.yml file. We are only getting started with it. I have added two root level properties - apiVersion and kind.
          - Instruction: Add the missing two properties - metadata and spec
            - <img width="302" alt="image" src="https://user-images.githubusercontent.com/57224583/219335431-24512e4d-d2c3-4876-8e92-c9fc9cfdd80e.png">

        - PODs - 2

          - Introduction: Let us now populate values for each property. Start with apiVersion.
          - Instruction: Update value of apiVersion to v1. Remember to add a space between colon (:) and the value (v1)

        - PODs - 3

          - Instruction: Update value of kind to Pod.

        - PODs - 4

          - Introduction: Let us now get to the metadata section.
          - Instruction: Add a property "name" under metadata with value "myapp-pod". Remember to add a space before 'name' to make it a child of metadata

        - PODs - 6

          - Introduction: We now need to provide information regarding the docker image we plan to use.
          - Instruction: Add a property containers under spec section. Do not add anything under it yet.

        - PODs - 7

          - Instruction: Containers is an array/list. So create the first element/item in the array/list and add the following properties to it: name - nginx and image - nginx

        - <img width="262" alt="image" src="https://user-images.githubusercontent.com/57224583/219337266-a830744e-46ad-4870-bde2-ad97b2db81a7.png">

        - PODs - 8

          - Introduction: Perfect! You have successfully created a Kubernetes-Definition file. Let us try it one more time, this time all on your own!
          - Instruction: Create a Kubernetes Pod definition file using values below:
            Name: postgres
            Labels: tier => db-tier
            Container name: postgres
            Image: postgres

        - <img width="275" alt="image" src="https://user-images.githubusercontent.com/57224583/219337742-183a12a6-d693-4c57-bc6a-cf85a665e874.png">

        - PODs - 9

          - Introduction: Postgres Docker image requires an environment variable to be set for password. - Instruction: Set an environment variable for the docker container. POSTGRES_PASSWORD with a value mysecretpassword. I know we haven't discussed this in the lecture, but it is easy. To pass in an environment variable add a new property 'env' to the container object. It is a sibling of image and name. env is an array/list. So add a new item under it. The item will have properties name and value. name should be the name of the environment variable - POSTGRES_PASSWORD. And value should be the password - mysecretpassword

        - <img width="299" alt="image" src="https://user-images.githubusercontent.com/57224583/219338533-3320365e-eba4-4ce2-bd30-d283004b097a.png">

    ### Replication Controller & ReplicaSet

    - ![20230216_163238](https://user-images.githubusercontent.com/57224583/219348032-1ac924da-2e3a-4976-9502-63c122c22c5b.jpg)

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

      #### Demo For ReplicaSet

      - vi replicaset.yaml
        - check yaml folder for code
        - <img width="267" alt="image" src="https://user-images.githubusercontent.com/57224583/219360322-937bcfcd-7a14-4499-8811-8cce1c96bc65.png">
      - cat replicaset.yaml
      - kubectl get pods
      - kubectl get replicaset
      - kubectl delete pod (podname)
      - kubectl get replicaset
      - kubectl get pods
      - kubectl describe replicaset myapp-replicaset
      - kubectl edit replicaset myapp-replicaset
        - change replicas to 4
      - kubectl get pods
      - kubectl scale replicaset myapp-replicaset --replicas=2

      #### Coding Exercise

      - this contains coding excercise

        - ReplicaSet - 1

          - Introduction: Let us start with ReplicaSets! Given a blank replicaset-definition.yml file. We are only getting started with it, so let's get it populated.
          - Instruction: Add all the root level properties to it.
          - Note: Only add the properties, not any values yet.
            apiVersion:
            kind:
            metadata:
            spec:

        - ReplicaSet - 2

          - Introduction: Let us now add values for ReplicaSet. ReplicaSet is under apiVersion - apps/v1
          - Instruction: Update values for apiVersion and kind
            apiVersion: apps/v1
            kind: ReplicaSet
            metadata:
            spec:

        - PODs - 5

          - Introduction: Let us add some labels to our Pod
          - Instruction: Add a property "labels" under metadata with a child property "app" with a value "myapp". Remember to have equal number of spaces before "name" and "labels" so they are siblings

            - <img width="275" alt="image" src="https://user-images.githubusercontent.com/57224583/219367125-f7c057d3-d874-4aae-b515-bdef1e6bcb9f.png">

        - ReplicaSet - 3

          - Introduction: Let us now add values for metadata
          - Instruction: Name the ReplicaSet - frontend. And add labels app=>mywebsite and tier=> frontend

        - ReplicaSet - 4

          - Introduction: Let us now get to the specification
          - Instruction: The spec section for ReplicaSet has 3 fields: replicas, template and selector. Simply add these properties. Do not add any values yet.

        - ReplicaSet - 5

          - Instruction: Let us update the number of replicas to 4.

        - ReplicaSet - 6

          - Introduction: The template section expects a Pod definition. Luckily, we have the one we created in the previous set of exercises. Next to the replicaset-definition.yml you will now find the same pod-definition.yml file that you created before.
          - Instruction: Let us now copy the contents of the pod-definition.yml file, except for the apiVersion and kind and place it under the template section. Take extra care on moving the contents to the right so it falls under template.

        - ReplicaSet - 7

          - Introduction: Let us now link the pods to the ReplicaSet by updating selectors.
          - Instruction: Add a property "matchLabels" under selector and copy the labels defined in the pod-definition under it.

            - Note: This may not work in play-with-k8s as it runs on 1.8 version of kubernetes. ReplicaSets moved to apps/v1 in 1.9 version of Kubernetes.

        - <img width="441" alt="image" src="https://user-images.githubusercontent.com/57224583/219368541-41feb3fb-5eba-4ee8-b749-e2fb238c19e2.png">

    ### Deployment

    - <img width="425" alt="image" src="https://user-images.githubusercontent.com/57224583/219555358-d61303a2-486f-40e3-bdc1-c2a196a8c92e.png">

    - Deployment which is a kubernetes object that comes higher in the hierarchy. The deployment provides us with capabilities to upgrade the underlying instances seamlessly using rolling updates, undo changes, and pause and resume changes to deployments.

    - <img width="429" alt="image" src="https://user-images.githubusercontent.com/57224583/219555592-2309a767-a378-4af4-bf01-556abd19f064.png">

      #### Demo for Deplyment

      - check deployment.yaml
        - <img width="239" alt="image" src="https://user-images.githubusercontent.com/57224583/219556587-40c30e26-d562-4aa4-8549-fe8b6996a440.png">
      - cat deployment.yaml
      - kubectl create -f deployment.yaml
      - kubectl get deployment
      - kubectl get pods
      - kubectl describe deployment myapp-deployment
      - kubectl get all

      #### Coding Exercise

      - this contains coding excercise

        - Deployment - 1

          - Introduction: Let us start with Deployments! Given a deployment-definition.yml file. We are only getting started with it, so let's get it populated.
          - Instruction: Add all the root level properties to it. Note: Only add the properties, not any values yet

        - Deployment - 2

          - Introduction: Let us now add values for Deployment. Deployment is under apiVersion apps/v1
          - Instruction: Update values for apiVersion and kind

        - Deployment - 3

          - Introduction: Let us now add values for metadata
          - Instruction: Name the Deployment frontend. And add labels app=>mywebsite and tier=> frontend

        - Deployment - 4

          - Introduction: Let us now get to the specification
          - Instruction: The spec section for Deployment has 3 fields: replicas, template and selector. Simply add these properties. Do not add any values.

        - Deployment - 5

          - Instruction: Let us update the number of replicas to 4.

        - Deployment - 6

          - Introduction: The template section expects a Pod definition. Luckily, we have the one we created in the previous set of exercises. Next to the deployment-definition.yml you will now find the same pod-definition.yml file that you created before.
          - Instruction: Let us now copy the contents of the pod-definition.yml file, except for the apiVersion and kind and place it under the template section. Take extra care on moving the contents to the right so it falls under template

        - Deployment - 7

          - Introduction: Let us now link the pods to the Deployment by updating selectors.
          - Instruction: Add a property "matchLabels" under selector and copy the labels defined in the pod-definition under it.
          - Note: this may not work in play-with-k8s as it runs on 1.8 version of kubernetes

        - <img width="418" alt="image" src="https://user-images.githubusercontent.com/57224583/219558965-495b8b4f-4bed-47ed-b926-f6e6bfcd4ca7.png">

      #### Rollout & Versioning

      - <img width="428" alt="image" src="https://user-images.githubusercontent.com/57224583/219560519-8edbc098-ef10-490b-a608-bb2860b1550b.png">

        - Whenever you create a new deployment or upgrade the images in an existing deployment it triggers a Rollout. A rollout is the process of gradually deploying or upgrading your application containers. When you first create a deployment, it triggers a rollout. A new rollout creates a new Deployment revision. Let’s call it revision 1. In the future when the application is upgraded – meaning when the container version is updated to a new one – a new rollout is triggered and a new deployment revision is created named Revision 2. This helps us keep track of the changes made to our deployment and enables us to rollback to a previous version of deployment if necessary.

          - <img width="393" alt="image" src="https://user-images.githubusercontent.com/57224583/219560735-d93fcf7f-26b6-4583-9e7a-76861934bb17.png">

        - <img width="416" alt="image" src="https://user-images.githubusercontent.com/57224583/219561074-fcd2bf90-d349-4cf9-b3f3-fedf65831493.png">

          - There are two types of deploymentstrategies. Say for example you have 5 replicas of your web application instance deployed. One way to upgrade these to a newer version is to destroy all of these and then create newer versions of application instances. Meaning first, destroy the 5 running instances and then deploy 5 new instances of the new application version. The problem with this as you can imagine, is that during the period after the older versions are down and before any newer version is up, the application is down and inaccessible to users. This strategy is known as the Recreate strategy, and thankfully this is NOT the default deployment strategy.

          - The second strategy is were we do not destroy all of them at once. Instead we take down the older version and bring up a newer version one by one. This way the application never goes down and the upgrade is seamless. Remember, if you do not specify a strategy while creating the deployment, it will assume it to be Rolling Update. In other words, RollingUpdate is the default Deployment Strategy

            - <img width="430" alt="image" src="https://user-images.githubusercontent.com/57224583/219561350-92b8904d-2ded-4344-b0b7-e4aefe4a00cd.png">

        - Differnce B/w the recreate and rollingupdate

          - The difference between the recreate and rollingupdate strategies can also be seen when you view the deployments in detail. Run the kubectl describe deployment command to see detailed information regarding the deployments. You will notice when the Recreate strategy was used the eventsindicate that the old replicaset was scaled down to 0 first and the new replica set scaled up to 5. However when the RollingUpdate strategy was used the old replica set was scaled down one at a time simultaneously scaling up the new replica set one at a time.

        - Upgrades

          - <img width="377" alt="image" src="https://user-images.githubusercontent.com/57224583/219562220-8adbeb9c-97a4-4c37-b3a0-fd971b63e22d.png">

          - When a new deployment is created, say to deploy 5 replicas, it first creates a Replicaset automatically, which in turn creates the number of PODs required to meet the number of replicas. When you upgrade your application as we saw in the previous slide, the kubernetes deployment object creates a NEW replicaset under the hoods and starts deploying the containers there. At the same time taking down the PODs in the old replica-set following a RollingUpdate strategy.

          - This can be seen when you try to list the replicasets using the kubectl get replicasets command. Here we see the old replicaset with 0 PODs and the new replicaset with 5 PODs.

        - Rollback

          - <img width="386" alt="image" src="https://user-images.githubusercontent.com/57224583/219562414-f1241474-1303-49ad-8fbb-5dd710685202.png">

          - Say for instance once you upgrade your application, you realize something isn’t very right. Something’s wrong with the new version of build you used to upgrade. So you would like to rollback your update. Kubernetes deployments allow you to rollback to a previous revision. To undo a change run the command kubectl rollout undo followed by the name of the deployment. The deployment will then destroy the PODs in the new replicaset and bring the older ones up in the old replicaset. And your application is back to its older format.

          - When you compare the output of the kubectl get replicasets command, before and after the rollback, you will be able to notice this difference. Before the rollback the first replicaset had 0 PODs and the new replicaset had 5 PODs and this is reversed after the rollback is finished.

        - All the Commands

          - <img width="374" alt="image" src="https://user-images.githubusercontent.com/57224583/219562638-3f5c4bd0-8c6e-4a64-b21c-7190f1e0767c.png">

          - To summarize the commands real quick, use the kubectl create command to create the deployment, get deployments command to list the deployments, apply and set image commands to update the deployments, rollout status command to see the status of rollouts and rollout undo command to rollback a deployment operation.

      #### Demo for update and rollback

      - <img width="602" alt="image" src="https://user-images.githubusercontent.com/57224583/219565212-da184b48-a0f3-41e5-b026-e4a43fd82467.png">

        - kubectl create -f deployment.yaml
        - kubectl rollout status deployment.apps/myapp-deployment
        - kubectl delete deployment myapp-deployment
        - kubectl create -f deployment.yaml
        - kubectl rollout status deployment.apps/myapp-deployment
        - kubectl rollout history deployment.apps/myapp-deployment
        - kubectl delete deployment myapp-deployment
        - kubectl create -f deployment.yaml --record
        - kubectl rollout status deployment.apps/myapp-deployment
        - kubectl rollout history deployment.apps/myapp-deployment
        - kubectl describe deployment myapp-deployment
          - see in the annotation section
          - let's change the image to see the rollout status again
        - kubectl edit deployment myapp-deployment --record
          - change the image nginx to nginx:1.18
        - kubectl rollout status deployment.apps/myapp-deployment

          - <img width="595" alt="image" src="https://user-images.githubusercontent.com/57224583/219567234-554e4f9d-6c16-4ae0-8c4b-7cf15df20ad0.png">

        - kubectl describe deployment myapp-deployment
          - check events
        - kubectl set image deployment myapp-deployment nginx=nginx:1.18-perl --record
        - kubectl rollout status deployment.apps/myapp-deployment
          - <img width="593" alt="image" src="https://user-images.githubusercontent.com/57224583/219568535-ea36bc2d-1b9a-4af6-97a6-bcc00d33e9bb.png">
        - kubectl rollout history deployment.apps/myapp-deployment
          - let's move to older version
        - kubectl rollout undo deployment myapp-deployment

  ## Networking in Kubernetes

  - <img width="424" alt="image" src="https://user-images.githubusercontent.com/57224583/219574504-c70a4275-1ff9-4f83-975f-3200c02371d0.png">

    - Let us look at the very basics of networking in Kubernetes. We will start with a single node kubernetes cluster. The node has an IP address, say it is 192.168.1.2 in this case. This is the IP address we use to access the kubernetes node, SSH into it etc. On a side note, remember if you are using a MiniKube setup, then I am talking about the IP address of the minikube virtual machine inside your Hypervisor. Your laptop may be having a different IP like 192.168.1.10. So its important to understand how VMs are setup.

    - So on the single node kubernetes cluster we have created a Single POD. As you know a POD hosts a container. Unlike in the docker world were an IP address is always assigned to a Docker CONTAINER, in Kubernetes the IP address is assigned to a POD. Each POD in kubernetes gets its own internal IP Address. In this case its in the range 10.244 series and the IP assigned to the POD is 10.244.0.2. So how is it getting this IP address? When Kubernetes is initially configured it creates an internal private network with the address 10.244.0.0 and all PODs are attached to it. When you deploy multiple PODs, they all get a separate IP assigned. The PODs can communicate to each other through this IP. But accessing other PODs using this internal IP address MAY not be a good idea as its subject to change when PODs are recreated. We will see BETTER ways to establish 192.168.1.10 192.168.1.2 Minikube Node My System 192.168.1.2 10.244.0.0 10.244.0.3 10.244.0.2 10.244.0.4 POD POD POD Node communication between PODs in a while. For now its important to understand how the internal networking works in kubernetes.

  - Cluster Networking

    - <img width="416" alt="image" src="https://user-images.githubusercontent.com/57224583/219578060-86ff4142-6768-45b6-8907-3f1644eeac15.png">

      - So it’s all easy and simple to understand when it comes to networking on a single node. But how does it work when you have multiple nodes in a cluster? In this case we have two nodes running kubernetes and they have IP addresses 192.168.1.2 and 192.168.1.3 assigned to them. Note that they are not part of the same cluster yet. Each of them has a single POD deployed. As discussed in the previous slide these pods are attached to an internal network and they have their own IP addresses assigned. HOWEVER, if you look at the network addresses, you can see that they are the same. The two networks have an address 10.244.0.0 and the PODs deployed have the same address too.

      - This is NOT going to work well when the nodes are part of the same cluster. The PODs have the same IP addresses assigned to them and that will lead to IP conflicts in the network. Now that’s ONE problem. When a kubernetes cluster is SETUP, kubernetes does NOT automatically setup any kind of networking to handle these issues. As a matter of fact, kubernetes expects US to setup networking to meet certain fundamental requirements. Some of these are that all the containers or PODs in a kubernetes cluster MUST be able to communicate with one another without having to configure NAT. All nodes must be able to communicate with containers and all containers must be able to communicate with the nodes in the cluster. Kubernetes expects us to setup a networking solution that meets these criteria.

    - <img width="407" alt="image" src="https://user-images.githubusercontent.com/57224583/219578640-abec0fca-4d60-435a-a02c-e4b8c69811a6.png">

      - Fortunately, we don’t have to set it up ALL on our own as there are multiple pre-built solutions available. Some of them are the cisco ACI networks, Cilium, Big Cloud Fabric, Flannel, Vmware NSX-t and Calico. Depending on the platform you are deploying your Kubernetes cluster on you may use any of these solutions. For example, if you were setting up a kubernetes cluster from scratch on your own systems, you may use any of these solutions like Calico, Flannel etc. If you were deploying on a Vmware environment NSX-T may be a good option. If you look at the play-with-k8s labs they use WeaveNet. In our demos in the course we used Calico. Depending on your environment and after evaluating the Pros and Cons of each of these, you may chose the right networking solution.

    - We used calio earlier
      - If you go back and look at the demo were we setup a kubernetes cluster initially, we setup networking based on Calico. It only took us a few set of commands to get it setup. So its pretty easy.

    -<img width="377" alt="image" src="https://user-images.githubusercontent.com/57224583/219579069-59a20ed3-97c9-4ab8-8fb7-1d21bd2c1f9c.png">

  ## Services in Kubernetes

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

        #### Demo Services

        - check nodeport.yaml

          - <img width="419" alt="image" src="https://user-images.githubusercontent.com/57224583/219614047-c44de236-7f77-4f82-881d-dbd59bbaa0e6.png">

        - vi nodeport.yaml
        - cat nodeport.yaml
        - kubectl get svc
        - curl ip:80
        - nodeip:30004 (in browser)

    #### ClusterIp

    - <img width="297" alt="image" src="https://user-images.githubusercontent.com/57224583/219615530-3da16086-4f6c-4be1-98b0-5021082c83e3.png">

      - A kubernetes service can help us group these PODs together and provide a single interface to access the PODs in a group. For example a service created for the backend PODs will help group all the backend PODs together and provide a single interface for other PODs to access this service. The requests are forwarded to one of the PODs under the service randomly. Similarly, create additionalservices for Redis and allow the backend PODs to access the redis system through this service. This enables us to easily and effectively deploy a microservices based application on kubernetes cluster. Each layer can now scale or move as required without impacting communication between the various services. Each service gets an IP and name assigned to it inside the cluster and that is the name that should be used by other PODs to access the service. This type of service is known as ClusterIP.

      - To create such a service, as always, use a definition file. In the service definition file , first use the default template which has apiVersion, kind, metadata and spec. The apiVersion is v1 , kind is Service and we will give a name to our service – we will call it back-end. Under Specification we have type and ports. The type is ClusterIP. In fact, ClusterIP is the default type, so even if you didn’t specify it, it will automatically assume it to be ClusterIP. Under ports we have a targetPort and port. The target port is the port were the back-end is exposed, which in this case is 80. And the port is were the service is exposed. Which is 80 as well. To link the service to a set of PODs, we use selector.We will refer to the pod-definition file and copy the labels from it and move it under selector. And that should be it. We can now create the service using the kubectl create command and then check its status using the kubectl get services command. The service can be accessed by other PODs using the ClusterIP or the service name.

    #### LoadBalancer

    - <img width="440" alt="image" src="https://user-images.githubusercontent.com/57224583/219616922-678dacdc-1f23-43d6-b3da-e84591bae5ee.png">

      - What end users really want is a single URL to access the application. For this, you will be required to setup a separate Load Balancer VM in your environment. In this case I deploy a new VM for load balancer purposes and configure it to forward requests that come to it to any of the Ips of the Kubernetes nodes. I will then configure my organizations DNS to point to this load balancer when a user hosts http://myapp.com. Now setting up that load balancer by myself is a tedious task, and I might have to do that in my local or onprem environment. However, if I happen to be on a supported CloudPlatform, like Google Cloud Platform, I could leverage the native load balancing functionalities of the cloud platform to set this up. Again you don’t have to set that up manually, Kubernetes sets it up for you. Kubernetes has built-in integration with supported cloud platforms.

    - <img width="398" alt="image" src="https://user-images.githubusercontent.com/57224583/219620162-836cafa5-a290-40c4-94f5-271c9afa1575.png">

    #### Coding Excercise

    - check services then at last check the image

      - Services - 1

        - Introduction: Let us start with Services! Given a service-definition.yml file. We are only getting started with it, so let's get it populated.
        - Instruction: Add all the root level properties to it. Note: Only add the properties, not any values.

      - Services - 2

        - Introduction: Let us now add values for Service. Service is under apiVersion v1
        - Instruction: Update values for apiVersion and kind

      - Services - 3

        - Introduction: Let us now add values for metadata.
        - Instruction: Add a name for the service = frontend and a label = app=>myapp

      - Services - 4

        - Introduction: Let us now add values for spec section. The spec section for Services have type, selector and ports.
        - Instruction: Add properties under spec section - type, selector and ports. Do not add any values for them.

      - Services - 5

        - Introduction: Let us now add values for ports. Ports is an Array/ List. Each item in the list has a set of properties - port and targetPort
        - Instruction: Create an Array/List item under ports. Add a dictionary with properties port and targetPort. Set values for both to port 80.
        - Note: We will not be providing a NodePort as we would like Kubernetes to assign one automatically for us.

      - Services - 6

        - Introduction: Let us now add values for type. Since we are creating a frontend service for enabling external access to users, we will set it to NodePort.
        - Instruction: Set value for type to NodePort.

      - Services - 7

        - Introduction: Let us now add values for selector. We need to link the Service to the PODs created by the deployment.
        - Instruction: Given the deployment-definition.yml file we created in the previous Section. Copy the appropriate labels and paste it under selector section of service-definition.yml file.

      - <img width="453" alt="image" src="https://user-images.githubusercontent.com/57224583/219631053-048d6b9b-45b3-48d2-9039-7b32623e2e77.png">

      - Services - 8

        - Introduction: Let us now try to create a service-definition.yml file from scratch. This time all in one go. You are tasked to create a service to enable the frontend pods to access a backend set of Pods.
        - Instruction: Use the information provided in the below table to create a backend service definition file. Refer to the provided deployment-definition file for information regarding the PODs.
          Service Name: image-processing
          labels: app=> myapp
          type: ClusterIP
          Port on the service: 80
          Port exposed by image processing container: 8080

        - <img width="689" alt="image" src="https://user-images.githubusercontent.com/57224583/219630708-29d33e2b-becb-4aeb-b931-8737222e10c0.png">
