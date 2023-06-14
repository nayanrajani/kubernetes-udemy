# Section-3 - Scheduling

## 53. Manual Scheduling

- In Kubernetes, Pods can be manually scheduled using the nodeName field in the Pod specification. This allows you to specify the node where you want the Pod to be scheduled.

- Note that manually scheduling Pods is not recommended in most cases, as it can lead to uneven distribution of workload across nodes and may make it harder to manage and scale your cluster. Instead, it's generally better to rely on Kubernetes' built-in scheduling algorithms to ensure that Pods are scheduled optimally.

## 56. Labels and Selectors

- In Kubernetes, labels are key-value pairs that are used to identify and organize objects such as Pods, Services, Deployments, and ReplicaSets. Labels are attached to objects as metadata and can be used to group related objects together or to specify how objects should be selected for certain operations.

- Selectors, on the other hand, are used to filter objects based on their labels. A selector specifies a set of label requirements, and any objects with labels that match those requirements will be selected. Selectors are commonly used when working with Kubernetes objects that reference other objects, such as Services that need to select a set of Pods to route traffic to.

- Labels and selectors are powerful tools in Kubernetes that allow you to organize and manage your objects in a flexible and scalable way. They can be used to implement complex deployment strategies, such as canary deployments, blue-green deployments, and rolling updates, as well as to monitor and debug your application.

## 59. Taints and Tolerations

- Taints are applied to nodes, and tolerations are applied to Pods. Taints and tolerations work together to ensure that Pods are only scheduled on nodes that are compatible with their requirements.

  - Here's how taints and tolerations work:

    - A taint is a label that is applied to a node. A taint consists of a key, a value, and an effect. The key and value are used to identify the taint, and the effect determines what happens when a Pod tries to schedule on the node. There are three possible effects:

    - NoSchedule: Pods will not be scheduled on the node unless they have a matching toleration.

    - PreferNoSchedule: Kubernetes will try to avoid scheduling Pods on the node unless no other nodes are available.

    - NoExecute: Pods that do not have a matching toleration will be evicted from the node.

- A toleration is a setting on a Pod that allows it to tolerate a matching taint on a node. A toleration consists of a key, a value, an operator, and a tolerationSeconds field. The key and value must match the taint applied to the node. The operator determines how the toleration should be applied, and the tolerationSeconds field specifies how long the Pod will tolerate the taint before it is evicted.

## 62. Node Selectors

- In a newly created Kubernetes cluster, as per default setup a pod can be scheduled on any of the worker node in the cluster. But there are some circumstances, where we may need to control which node the pod deploys to.

  - ![image](https://github.com/nayanrajani/Personal/assets/57224583/cfceb3fa-4a97-45e6-a3d2-e11770326d3d)

  - For ex: Let’s say we have a different kinds of workloads running in our cluster and we would like to dedicate, the data processing workloads pods that require higher horsepower to the nodes with an SSD attached to it.

  - nodeSelector is the simplest form of node selection. It is a field PodSpec and specifies a map of key-value pairs. For the Pod to be eligible to run on a node, the node must have the key-value pairs as labels attached to them.

  - To work with nodeSelector, we first need to attach a label to the node with below command:

    - kubectl label nodes <node-name> <label-key>=<label-value>
    - kubectl label nodes node-01 size=Large
    - kubectl get nodes node-01 --show-labels (to verify the attached labels)
  - In 2nd step we need to add a nodeSelector term to the pod configuration:

    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
      labels:
        env: test
    spec:
      containers:
      - name: nginx
        image: nginx
      nodeSelector:
        size: Large

  - Once the nodeSelector term is added in the Pod configuration file, we can run the below command to create the pod:

    - kubectl apply -f nginx-pod.yaml
  - Once the Pod is created, the scheduler identifies the right node to place the pod as per the nodeSelector term in the Pod configuration file.

## 63. Node Affinity

- The primary purpose of the node Affinity feature is to ensure that pods are hosted on particular nodes. It provides us with advanced capabilities to limit the pod placement on specific nodes.

  - ![image](https://github.com/nayanrajani/Personal/assets/57224583/21c9cbfd-d76f-4222-abaa-1e0166c14e75)

  - For eg. let’s say we have different kinds of workloads running in our cluster and we would like to dedicate, the data processing workloads that require higher horsepower to the node that is configured with high or medium resources, and here the node affinity comes into play.

  - pod-definition.yaml
      apiVersion: v1
      kind: Pod
      metadata:
      name: dbapp
      spec:
      containers:
      - name: dbapp
        image: db-processor
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution
            nodeSelectorTerms:
            - matchExpresions:
              - key: Size
                operator: In
                values:
                - Large
                - Medium

  - So in the Pod Definition file, under the spec section we have affinity and then node Affinity and under that, we have a property “requiredDuringSchedulingIgnoredDuringExecution” and then we have the nodeSelectorTerms that is an array and that is where we’ll specify the key and value pairs.
  
  - The Key-value pairs are in the form of key, operator and value, where the operator is “In”. The Operator ensures that the pod will be placed on a node whose label size has any value in the list of values specified.
  
  - To label a node, run the following command:

    - kubectl label nodes <node-name> <label-key>=<label-value>
  - In our case:
    - kubectl label nodes node-01 size=large
    - We can also use the “NotIn” operator to say, something like size “NotIn” small, where node affinity will match the node with a size not set to small.

      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution
            nodeSelectorTerms:
            - matchExpresions:
              - key: Size
                operator: NotIn
                values:
                - Small

  - As per above figure “1.1”, we have only set the label on large and medium nodes, the smaller node doesn’t even have the label set. So we don’t really have to even check the value of the label, as long as we are sure we don’t set the label size to the smaller nodes, using the “Exist” operator will give us the same result as “NotIn” in our case.

    affinity:
      nodeAffinity:
        requiredDuringSchedulingIgnoredDuringExecution
          nodeSelectorTerms:
          - matchExpresions:
            - key: Size
              operator: Exists

  - The “exist” operator will simply check if the label “size” exists on the nodes and we don’t need the value section for that, as it does not compare the values.

  - The node affinity syntax supports the following operators: In, NotIn, Exists, DoesNotExist, Gt, Lt, etc. Refer to assign-pod-node for more details.

  - Now we understand all of this and we are comfortable with creating a pod with specific affinity rules. When the pods are created these rules are considered and the pods are placed onto the right nodes.

  - So There are currently 2 types of node affinity available:  
    - requiredDuringSchedulingIgnoreDuringExecution
    - preferredDuringSchedulingIgnoreDuringExecution

  - And there are additional types of node affinity Planned:
    - requiredDuringSchedulingRequiredDuringExecution

  - Let’s understand the 2 available affinity types:
  - There are two states in the lifecycle of a pod, when considering the node affinity, during scheduling and during execution.
  
  - During scheduling is the state where a Pod does not exist and is created for the first time and when its first created the affinity rules specified are considered to place the pod on the right node.
  
  - Now, what if the nodes with matching labels are not available Or we forgot to label the nodes as large (in our case)? This is where the node affinity comes into play.
  
  - If we select the required type (the first affinity), the scheduler will mandate that the pod be placed on a node with given affinity rules. If it cannot find the matching node, the pod will not be scheduled. This type will be used in cases where the placement of the pod is crucial.
  
  - But let’s say the pod placement is less important than running the workload itself, in that case, we can set the affinity to the preferred type (the 2nd affinity) and in cases where a matching node is not found, the scheduler will simply ignore node affinity rules and place the Pods on any available node. The preferred one is a way of telling the scheduler, hey try your best to place the pod on the matching node but if you really cannot find one just place it anywhere.

  - The second state is During Execution. It is a state where a pod has been running and a change is made in the environment that affects node affinity, such as a change in the label of a node. i.e, an administrator removed the label we set earlier from the node (size = large). Now, what would happen to the pods that are running on the node?

  - In both types of the available node affinity, pods will continue to run and any changes in node affinity will not impact them once they are scheduled.

    - ![image](https://github.com/nayanrajani/Personal/assets/57224583/1acba7aa-10fc-4287-9cac-5dd18abc3d6f)

  - The new type expected in the future, only have a difference in the during execution state. A new option is called RequiredDuringExecution is introduced, which will evict any pod that is running on nodes that do not meet affinity rules.

    - ![image](https://github.com/nayanrajani/Personal/assets/57224583/bbde0b7e-5509-4f94-ad77-ee958076af09)


## 66. Taints and Tolerations vs Node Affinity

- Now that we have learned about taints, and tolerations, and node affinity, let us tie together the two concepts through a fun exercise. We have three nodes and three pods each in three colors, blue, red, and green. The ultimate aim is to place the blue pod in the blue node, the red pod in the red node, and likewise for green. We are sharing the same Kubernetes cluster with other teams.
- So there are other pods in the cluster as well as other nodes. We do not want any other pod to be placed on our node. Neither do we want our pods to be placed on their nodes. Let us first try to solve this problem using taints and tolerations. We apply a taint to the nodes marking them with their colors, blue, red, and green, and we then set a toleration on the pods to tolerate the respective colors.
- When the pods are now created, the nodes ensure they only accept the pods with the right toleration.
- So the green pod ends up on the green node, and the blue pod ends up on the blue node. However, taints and tolerations does not guarantee that the pods will only prefer these nodes. So the red node ends up on one of the other nodes that do not have a taint or toleration set. This is not desired.
- Let us try to solve the same problem with node affinity. With node affinity, we first label the nodes with their respective colors, blue, red, and green. We then set node selectors on the pods to tie the pods to the nodes. As such, the pods end up on the right nodes. However, that does not guarantee that other pods are not placed on these nodes. In this case, there is a chance that one of the other pods may end up on our nodes.
- This is not something we desire.
- As such, a combination of taints, and tolerations, and node affinity rules can be used together to completely dedicate nodes for specific pods. We first use taints and tolerations to prevent other pods from being placed on our nodes, and then we use node affinity to prevent our pods from being placed on their nodes.

## 67. Resource Requirements and Limits

- https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/

## 71. DaemonSets

- DaemonSets are like ReplicaSets, as in it helps you deploy multiple instances of pods. But it runs one copy of your pod on each node in your cluster. Whenever a new node is added to the cluster, a replica of the pod is automatically added to that node. And when a node is removed the pod is automatically removed. The DaemonSet ensures that one copy of the pod is always present in all nodes in the cluster.
- So what are some use cases of DaemonSets?
- Say you would like to deploy a monitoring agent or log collector on each of your nodes in the cluster, so you can monitor your cluster better. A DaemonSet is perfect for that as it can deploy your monitoring agent in the form of a pod in all the nodes in your cluster. Then you don't have to worry about adding or removing monitoring agents from these nodes when there are changes in your cluster as the DaemonSet will take care of that for you.
- Earlier, while discussing the Kubernetes architecture, we learned that one of the worker node components that is required on every node in the cluster is a kube-proxy. That is one good use case of DaemonSets. The kube-proxy component can be deployed as a DaemonSet in the cluster.

## 74. Static Pods

- Static Pods are managed directly by the kubelet daemon on a specific node, without the API server observing them. Unlike Pods that are managed by the control plane (for example, a Deployment); instead, the kubelet watches each static Pod (and restarts it if it fails).

- Static Pods are always bound to one Kubelet on a specific node.

- The kubelet automatically tries to create a mirror Pod on the Kubernetes API server for each static Pod. This means that the Pods running on a node are visible on the API server, but cannot be controlled from there. The Pod names will be suffixed with the node hostname with a leading hyphen.

  - Note: If you are running clustered Kubernetes and are using static Pods to run a Pod on every node, you should probably be using a DaemonSet instead.
  - Note: The spec of a static Pod cannot refer to other API objects (e.g., ServiceAccount, ConfigMap, Secret, etc).
  - Note: Static pods do not support ephemeral containers.

## 77. Multiple Schedulers

- Now, we have seen how the default scheduler works  in Kubernetes in the previous lectures.It has an algorithm that distributes podsacross nodes evenly,as well as takes into considerationvarious conditions we specify through tains and tolerationsand node affinity, et cetera.
- But what if none of these satisfies your needs?Say you have a specific applicationthat requires its components to be placedon nodes after performing some additional checks?So you decide to have your own scheduling algorithmto place pods on nodesso that you can add your own custom conditionsand checks in it.Kubernetes is highly extensible.
- You can write your own Kubernetes scheduler program,package it and deploy it as the default scheduleror as an additional schedulerin the Kubernetes cluster.That way all of the other applicationscan go through the default scheduler.However, some specific applicationsthat you may choose can use your own custom scheduler.So your Kubernetes clustercan have multiple schedulers at a time.When creating a pod or a deployment,you can instruct Kubernetesto have the pod scheduled by a specific scheduler.
- So let's see how that's done.Now, when there are multiple schedulers,they must have different namesso that we can identify them as separate schedulers.So the default scheduler is named default scheduler.And this name is configuredin a kube-scheduler configuration file that looks like this.Now, the default scheduler doesn't really need onebecause if you don't specify a name,it sets the name to a default scheduler.But this is how it would lookif you were to create one.And for the other schedulers,we could create a separate configuration fileand set the scheduler name like this.
- So let's start with the most simplest wayof deploying an additional scheduler.Now, we earlier, we sawhow to deploy the Kubernetes kube-scheduler.We download the kube-scheduler binaryand run it as a service with a set of options.Now, to deploy an additional scheduler,you may use the same kube-scheduler binaryor use one that you might have built for yourself,which is what you would do if you needed the schedulerto work differently.
- In this case, we're going to use the same binaryto deploy the additional scheduler.And this time, we point the configurationto the custom configuration file that we created.So each scheduler uses a separate configuration fileand with each file having its own scheduler name.And note that there are other optionsto be passed in, such as the kubeconfig fileto authenticate into the Kubernetes APIbut I'm just skipping that for nowjust to keep it super simple.This is not how you would deploy a custom scheduler 99%of the time today because with kubeadm deployment,all the control plane components runas a pod or a deployment within the Kubernetes cluster.
- So let's look at another way.So let's look at how it worksif you were to deploy the scheduler as a pod.So we create a pod definition fileand specify the kubeconfig property,which is the path to the scheduler conf filethat has the authentication informationto connect to the Kubernetes API server.We then pass in our custom kube-scheduler configuration fileas a config option to the scheduler.Note that we have the scheduler name specified in the file.So that's how the name gets picked up by the scheduler.Now, another important option to look hereis the leader elect option.And this goes into the kube-scheduler configuration.The leader elect option is usedwhen you have multiple copies of the scheduler runningon different master nodesas a high-availability setupwhere you have multiple master nodeswith the Kubernetes scheduler process runningon both of them.
- If multiple copies of the same schedulerare running on different nodes,only one can be active at a time,and that's where the leader elect option helpsin choosing a leaderwho will lead the scheduling activities.So we will discuss more about HA setupin another section.In case you do have multiple masters,just remember that you can pass in this additional parameterto set a log object name,and this is to differentiate the new custom schedulerfrom the default election process.

- So when you run the get pods commandin the kube-system namespace,you can then see the new custom scheduler running.So this is if you ran it as a pod,and if you run as a deployment,then you'll probably seea slightly different naming conventionbut you'll be able to see the pod there.Just make sure you're checking the right namespace.
- Now, once we have deployed that custom scheduler,the next step is to configure a podor a deployment to use this new scheduler.So how do you use our custom scheduler?So here we have a pod definition fileand what we need to dois add a new field called scheduler nameand specify the name of the new scheduler,and that's basically it.This way when the pod is created,the right scheduler gets picked upand the scheduling process works.Now, we now create the pod using the kubectl create command.
- If the scheduler was not configured correctly,then the pod will continue to remain in a pending state.And if everything is good,then the pod will be in a running state.So if the pod is in a pending state,then you can look at the logsunder the pod describe command,the kubectl describe command.And you'll mostly noticethat the scheduler isn't configured correctly.
- Now, how do you know which scheduler picked it up?
- So we have multiple schedulers.How do you know which scheduler picked upscheduling a particular pod?
- Now, we can view this in the eventsusing the kubectl get events commandwith the -o wide option.And this will list all the events in the current namespaceand look for the scheduled eventsand as you can see, the source of the eventis the custom scheduler that we created.
- That's the name that we gave to the custom scheduler.And the message says that successfully assigned the image.So that indicates that it's working.You could also view the logs of the schedulerin case you run into issues.
- So for that, view the logs using the kubectl logs commandand provide the scheduler name,either the pod name or the deployment name, and then the right namespace.

## 80. Configuring Scheduler Profiles

- So let's first recap how the Kubernetes scheduler works using this simple example of scheduling a pod to one of these four nodes that you can see here that are part of the Kubernetes cluster. 
- So here, we have our pod definition file and there's our pod. It is waiting to be scheduled on one of these four nodes. Now, it has a resource requirement of 10 CPU so it's only gonna be schedule on a node that has 10 CPU remaining. And you can see the available CPU on all of these nodes that are listed here.

- Now, it is not alone, there are some other pods that are waiting to be scheduled as well. So the first thing that happens is that when these pods are created, the pods end up in a scheduling queue.

- So this is where the pods wait to be scheduled. So at this stage, pods are sorted based on the priority defined on the pods. So in this case, our pod has a high priority set. So, to set a priority, you must first create a priority class that looks like this and you should set it a name and set it a priority value. 
- In this case, it's set to 1 million so that's really high priority. So, this is how pods with higher priority gets to the beginning of the queue to be scheduled first.
- And so that sorting happens in this scheduling phase.
  
  - For example, while in the scheduling queue, it's the priority sort plugin that sorts the pods in an order based on the priority configured on the pods.This is how parts with priority class gets higher priority over the other pods when scheduling.

- Then, our pod enters the filter phase. This is where nodes that cannot run the pod are filtered out. So, in our case, the first two nodes do not have sufficient resources so do not have 10 CPU remaining so they are filtered out.
  
  - In the filtering stage, it's the node resources fit plugin that identifies the notes that has sufficient resources required by the pods and filters out the nodes that doesn't. Now, some other plugin examples that come into this particular stage are the node name plugin that checks if a pod has a node name mentioned in the pods spec and filters out all the nodes that does not match this name. Another example is the node unschedulable plugin that filters out nodes that has the unschedulable flag set to true. So, this is when you're on the drain, the cordon command on a node, which we will discuss later. But all the notes that has the unschedulable flags set are true, it's this particular plugin that makes sure that no pods are set on those nodes.

- The next phase is the scoring phase. So this is where nodes are scored with different weights. From the two remaining nodes, the scheduler associates a score to each node based on the free space that it will haveafter reserving the CPU required for that pod. So, in this case, the first one has two left and the second node will have six left. So, the second node gets a higher score. And so, that's the node that gets picked up.

  - Now, in the scoring phase, again, the node resources fit plugin associates a score to each node based on the resource available on it and after the pod is allocated to it. So, as you can see, a single plugin can be associated in multiple different phases. Another example of a plugin in this stage would be the image locality plugin that associates a high score to the nodes that already has the container image used by the pods among the different nodes. Now, note that at this phase, the plugins do not really reject the pod placementon a particular node. For example, in case of the image locality node,it ensures that pods are placed on a node that already has the image but if there are no nodes available, it will anyway place the pod on a node that does not even have the image. So, it's just a scoring that happens at this stage.

- And finally, in the binding phase,this is where the pod is finally bound to a node with the highest score. 

  - And finally, in the binding phase, you have the default binder plugin that provides the binding mechanism. 
  
- Now, the highly extensible nature of Kubernetes makes it possible for us to customize what plugins go where and for us to write our own plugin and plug them in here. And that is achieved with the help of what is called as extension points. So, at each stage, there is an extension point to which a plugin can be plugged to.

  - In the scheduling queue, we have a queue sort extension to which the priority sort plugin is plugged to.And then we have the filter extension,the score and the bind extension to which each of these plugins that we just talked about are plugged to. 
  - As a matter of fact, there's more. So, there are extensions before entering the filter phase called the pre-filter extension and after the filter phase called post filter.And then there are pre-scorebefore the score extension pointand reserve after the extension point,the score extension point.And then there's permit and pre-bindbefore the bind and post bind after the binding phase.So, there are so many options available.
  - Basically you can get a custom code of your ownto run anywhere in these points by just creating a pluginand plugging it into the respective kind of pointthat you want to plug it to.And here is a little bit more detailson some additional plugins that come by defaultthat are associated with the different extension points.
  - As you can see, some of the plugins span acrossmultiple extension points.Some of them are just within a specific extension point.So, that's what scheduling plugins and extension points are.So the highly extensible nature of Kubernetesallows us to customize the way that these plugins are calledand write our own scheduling plugin if needed.

- Scheduler Profiles
  - References
    - https://github.com/kubernetes/community/blob/master/contributors/devel/sig-scheduling/scheduling_code_hierarchy_overview.md
    - https://kubernetes.io/blog/2017/03/advanced-scheduling-in-kubernetes/
    - https://jvns.ca/blog/2017/07/27/how-does-the-kubernetes-scheduler-work/
    - https://stackoverflow.com/questions/28857993/how-does-kubernetes-scheduler-work