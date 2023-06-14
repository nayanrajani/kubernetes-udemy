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

## Kubernetes Setup (under newly created ubuntu VM ONLY)

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

### Shortform

- Deployment => deploy
- Services => svc
- Namespaces => 
  - ns
  - kubectl get pods -n={namespacename}
- ServiceAccount =>
  - sa
  - kubectl get sa (name-scheduler) -n {namespacename}