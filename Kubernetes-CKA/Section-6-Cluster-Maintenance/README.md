# Section-6-Cluster-Maintenance

## 121. OS Upgrades

- Before doing upgrades to the nodes
- there are three commands you should make sure you run
  - kubectl drain {node-name}
    - it will drain(shift) all the pods inside this node to other nodes and mark it as UNschedule so that no other pods are created inside this node.
  - kubectl cordon {node-name}
    - Use to mark a Node as UNschedule so that no other pods are created inside this node.
  - kubectl uncordon {node-name}
    - to Unmark a Node from UNschedule, so that other pods can be created inside this node.

## 124. Kubernetes Software Versions

- 