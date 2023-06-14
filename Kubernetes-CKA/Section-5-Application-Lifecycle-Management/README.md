# Section 5: Application Lifecycle Management

## 92. Rolling Updates and Rollbacks

- Deployment

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
  
  - Rollout & Versioning

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

## 97. Configure Applications

- Configuring applications comprises of understanding the following concepts:

  - Configuring Command and Arguments on applications
  
  - Configuring Environment Variables
  
  - Configuring Secrets

## 96. Commands

## 97. Commands and Arguments

## 100. Configure Environment Variables in Applications

## 101. Configuring ConfigMaps in Applications

- When you have a lot of pod definition files, itwill become difficult to manage the environment data storedwithin the query's files.

- We can take this information out of the pod definition fileand manage it centrally using configuration maps.Config maps are used to pass configuration datain the form of key value pairs in Kubernetes.

- When a pod is created, inject the config map into the podso the key value pairs are availableas environment variablesfor the application hosted inside the containerin the pod.There are two phases involved in configuring config maps.First, create the config map, and secondinject them into the pod.

- Just like any other Kubernetes object, there are two waysof creating a config map.The imperative way without using a config mapdefinition file, and the declarative way,by using a config map definition file.

- Imperative
  - If you do not wish to create a config map definition file,you could simply use the Kube control, create configmap command, and specify the required arguments.Let's take a look at that first.

  - With this method,you can directly specify the key valued pairsin the command line.To create a config map of the given values,run the Kube control create config map command.The command is followedby the config name and the option from literal.The from literal option is used to specify thekey value pairs in the command itself.

  - In this example, we are creating a config mapby the name app configwith a key value pair of app color equals blue.If you wish to add additional key value pairs,simply specify the from literal options multiple times.However, this will get complicated whenyou have too many configuration items.Another way to input configuration data is through a file.

  - Use the from file option to specify a pathto the file that contains the required data.The data from this file is read and stored under the nameof the file.

- Declarative
  - Let us now look at the declarative approach.For this, we create a definition file, just like how we didfor the pod.The file has a apiVersion, kind metadata,and instead of spec, here we have data.The apiVersion is V1, the kind is config map.Under metadata, we specify a name for the config map.
  
  - We will call it app config.Under data, and the configuration data,in a key value format.Run the Kube control, create commandand specify the configuration file name.So, that creates the app config, config map with the valueswe specify.You can create as many config mapsas you need in the same way for various different purposes.
  
  - Here I have one of my application,other for my SQO and another one for Redis.So, it is important to name the config maps appropriately,as you will be using these names laterwhile associating it with pods.To view config maps, run the Kube controlget config maps command.
  
  - This lists the newly created config map named app config.The describe config maps command lists theconfiguration data as well under the data section.Now that we have the config map created

- Inject this data in POD

  - Now that we have the config map created,let us proceed with step two, configuring it with a pod.Here I have a simple pod definition filethat runs my simple web application.
  
  - To inject an environment variable,add a new property to the container called ENV from.The ENV from property is a list.So, we can pass as many environment variables as required.Each item in the list corresponds to config map item.Specify the name of the config map we created earlier.
  
  - This is how we inject a specific config mapfrom the ones we created before.Creating the pod definition file nowcreates a web application with a blue background.What we just saw was using config maps toinject environment variables.
  
  - There are other ways to inject configuration data into pods.You can inject it as a single environment variableor, you can inject the whole data as files in a volume.

## 104. Configure Secrets in Applications

- 