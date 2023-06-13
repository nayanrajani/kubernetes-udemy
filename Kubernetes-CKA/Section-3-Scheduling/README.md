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