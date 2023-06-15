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

- References
  - https://kubernetes.io/docs/concepts/overview/kubernetes-api/

  - Here is a link to kubernetes documentation if you want to learn more about this topic (You don't need it for the exam though):

  - https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md

  - https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api_changes.md

## 126. Cluster Upgrade Process

- https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/

- https://kubernetes.io/docs/tasks/administer-cluster/cluster-upgrade/

## 130. Backup and Restore Methods

- Let's start by looking at what you should consider  backing up in Kubernetes cluster.  So far in this course,  we have deployed a number of different applications  on our Kubernetes cluster  using deployment, pods, and service definition files.  We know that the etcd cluster  is where all cluster-related information is stored,  and if your applications are configured  with persistent storage,  then that is another candidate for backups.  

- Resources:
  - With respect to resources that we created in the cluster,  at times we use the imperative way of creating an object  by executing a command, such as while creating a namespace,  or a secret, or config map, or, at times,  for exposing applications.  And at times, we used the declarative approach  by first creating a definition file  and then running the kubectl apply command on that file.  This is the preferred approach  if you want to save your configuration,  because now, you have all the objects required  for a single application  in the form of object definition files in a single folder. 
  
  - This can easily be reused at a later time,  or shared with others.  Of course, you must have a copy of these files  saved at all times.  A good practice is to store these  on source code repositories,  that way it can be maintained by a team.  The source code repository should be configured  with the right backup solutions.  With managed or public source code repositories like GitHub,  you don't have to worry about this. 
  
  - With that, even when you lose your entire cluster,  you can redeploy your application on the cluster  by simply applying these configuration files on them.  While the declarative approach is the preferred approach,  it is not necessary that all of your team members  stick to those standards.  What if someone created an object the imperative way  without documenting that information anywhere?  So a better approach to backing up resource configuration  is to query the Kube API server.  
  
  - Query the Kube API server using the kubectl,  or by accessing the API server directly,  and save all resource configurations  for all objects created on the cluster as a copy.  For example, one of the commands  that can be used in a backup script  is to get all pods, and deployments,  and services in all namespaces  using the kubectl utility's get all command,  and extract the output in a YAML format,  then save that file.  And that's just for a few resource group.  
  
  - There are many other resource groups  that must be considered.  Of course, you don't have to develop  that solution yourself.  There are tools like Ark, or now called Velero, by Heptio,  that can do this for you.  It can help in taking backups of your Kubernetes cluster  using the Kubernetes API.

- ETCD Cluster:
  - Let us now move on to etcd.  The etcd cluster stores information  about the state of our cluster.  So information about the cluster itself,  the nodes and every other resources  created within the cluster, are stored here.  So instead of backing up resource as before,  you may choose to backup the etcd server itself.  As we have seen, the etcd cluster  is hosted on the master nodes.  While configuring etcd, we specified a location  where all the data would be stored, the data directory.
  
  - That is the directory that can be configured  to be backed up by your backup tool.  Etcd also comes with a builtin snapshot solution.  You can take a snapshot of the etcd database  by using the etcd control utility's snapshot save command.  Give the snapshot a name, snapshot.db.  A snapshot file is created  by the name in the current directory.
  
  - If you want it to be created in another location,  specify the full path.  You can view the status of the backup  using the snapshot status command.  To restore the cluster from this backup  at a later point in time,  first, stop the Kube API server service,  as the restore process will require you  to restart the etcd cluster,  and the Kube API server depends on it.  Then, run the etcd controls snapshot restore command,  with the path set to the path of the backup file,  which is the snapshot.db file.
  
  - When etcd restores from a backup,  in initializes a new cluster configuration  and configures the members of etcd  as new members to a new cluster.  This is to prevent a new member  from accidentally joining an existing cluster.  On running this command, a new data directory is created.  In this example, at location var lib etcd from backup.  We then configure the etcd configuration file  to use the new data directory.  
  
  - Then, reload the service demon and restart etcd service.  Finally, start the Kube API server service.  Your cluster should now be back in the original state.  A quick note before I let you go.  With all the etcd commands,  remember to specify the certificate files  for authentication,  specify the endpoint to the etcd cluster  and the CS certificate,  the etcd server certificate, and the key.  
  
  - So we have seen two options, a backup using etcd,  and a backup by querying the Kube API server.  Now both of these have their pros and cons.  Well, if you're using a managed Kubernetes environment,  then, at times, you may not even access to the etcd cluster.  In that case, backup by querying the Kube API server  is probably the better way.

## Working with ETCDCTL

- etcdctl is a command line client for [etcd](https://github.com/coreos/etcd).
- In all our Kubernetes Hands-on labs, the ETCD key-value database is deployed as a static pod on the master. The version used is v3.

- To make use of etcdctl for tasks such as back up and restore, make sure that you set the ETCDCTL_API to 3.

- You can do this by exporting the variable ETCDCTL_API prior to using the etcdctl client. This can be done as follows:

  - export ETCDCTL_API=3

- On the Master Node:

  - ![image](https://github.com/nayanrajani/Personal/assets/57224583/b2eb9e43-8642-4a1e-942f-d0a15c444b80)

- To see all the options for a specific sub-command, make use of the -h or --help flag.

- For example, if you want to take a snapshot of etcd, use: 
  - etcdctl snapshot save -h and keep a note of the mandatory global options.

- Since our ETCD database is TLS-Enabled, the following options are mandatory:
  - --cacert                                                verify certificates of TLS-enabled secure servers using this CA bundle

  - --cert                                                    identify secure client using this TLS certificate file

  - --endpoints=[127.0.0.1:2379]          This is the default as ETCD is running on master node and exposed on localhost 2379.

  - --key                                                      identify secure client using this TLS key file

- Similarly use the help option for snapshot restore to see all available options for restoring the backup.

  - etcdctl snapshot restore -h

- For a detailed explanation on how to make use of the etcdctl command line tool and work with the -h flags

## References

  - https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/#backing-up-an-etcd-cluster
  - https://github.com/etcd-io/website/blob/main/content/en/docs/v3.5/op-guide/recovery.md
  - https://www.youtube.com/watch?v=qRPNuT080Hk