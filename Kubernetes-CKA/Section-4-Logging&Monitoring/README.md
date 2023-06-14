# Section-4- Logging & monitoring

## 84. Monitor Cluster Components

- So how do you monitor resource consumption on Kubernetes?

- Or more importantly, what would you like to monitor?

- I'd like to know node-level metrics,such as the number of nodes in the cluster,how many of them are healthy,as well as performance metrics such as CPU,memory, network, and disc utilization,as well as pod-level metrics,such as the number of pods,and the performance metrics of each pod,such as the CPU and memory consumption on them.

- So we need a solution that will monitor these metrics,store them, and provide analytics around this data.As of this recording, Kubernetes does not comewith a full-featured built-in monitoring solution.However, there are a numberof open-source solutions available todaysuch as Metrics Server, Prometheus, the Elastic Stack,and proprietary solutions like Datadog and Dynatrace.Heapster was one of the original projectsthat enabled monitoringand analysis features for Kubernetes.

- You will see a lot of reference onlinewhen you look for reference architectureson monitoring Kubernetes.However, Heapster is now deprecated,and a slimmed-down version was formed,known as the Metrics Server.You can have one Metrics Server per Kubernetes cluster.The Metrics Server retrieves metricsfrom each of the Kubernetes nodes and pods,aggregates them, and stores them in memory.

- Note that the Metrics Serveris only an in-memory monitoring solutionand does not store the metrics on the disk.And as a result, you cannot see historical performance data.For that, you must relyon one of the advanced monitoring solutionswe talked about earlier in this lecture.So how are the metrics generatedfor the pods on these nodes?Kubernetes runs an agent on each nodeknown as the kubelet, which is responsiblefor receiving instructionsfrom the Kubernetes API master serverand running pods on the nodes.

- The kubelet also contains a sub componentknown as the cAdvisor or Container Advisor.cAdvisor is responsiblefor retrieving performance metrics from podsand exposing them through the kubelet APIto make the metrics available for the Metrics Server.If you're using minikube for your local cluster,run the command,minikube addons enable metrics-server.For all other environments,deploy the Metrics Serverby cloning the Metrics Server deployment filesfrom the GitHub repository,and then deploying the required componentsusing the kubectl create command.

- This command deploys a set of pods, services, and rolesto enable Metrics Serverto pull for performance metricsfrom the nodes in the cluster.Once deployed, give the Metrics Server some timeto collect and process data.Once processed, cluster performance can be viewedby running the command kubectl top node.This provides the CPUand memory consumption of each of the node.As you can see,8% of the CPU on my master node is consumedwhich is about 166 millicores.Use the kubectl top pod commandto view performance metrics of pods in Kubernetes.

## 87. Managing Application Logs

- https://kubernetes.io/docs/concepts/cluster-administration/logging/