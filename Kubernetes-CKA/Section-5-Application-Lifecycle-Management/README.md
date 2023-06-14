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