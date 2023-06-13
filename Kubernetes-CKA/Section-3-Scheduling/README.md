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

- 