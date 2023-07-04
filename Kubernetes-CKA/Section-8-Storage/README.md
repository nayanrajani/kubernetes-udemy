# Section - 8 Storage

## 183. Docker Storage

- there are two Concept of Storage in Docker
  - Storage Drivers
  - Volume Drivers

## 184. Storage Driver in Docker

- Docker automatically chooses the drivers
- Types:
  - AUFS
  - ZFS
  - BTRFS
  - Device Mapper
  - Overlay
  - Overlay2

- How docker store data in local file system:
  - when you install Docker in local system it creates a folder under
    - /var/lib/docker
      - aufs
      - containers
      - image
      - volumes

- Docker Layered Architecture
  - Each command/instruction in Dockerfile creates a new layer of architecture from the previous changes.

  - Image Layer (READ ONLY)
    - docker build Dockerfile .......
      - Layer 1 Base Image
      - Layer 2 Changes in apt packages
      - Layer 3 chnage in pip package
      - layer 4 change in source code
      - layer 5 update entripoint with "flask" command

  - Container layer (READ WRITE)
    - docker run ......
      - layer 6 container layer

- Copy-on-write mechanism
  - If you want to update the app source code/app
  - then container layer will copy the code and you will update the code as a new version.
  - image layer code will be the same until you rebuild the code or image

- Volumes
  - if you delete the container then it will delete the data inside the container as well
  - to persiste the data you should use volumes
  - volume mount
    - Mount volumes from the Volume Directory
    - create a volume and mount the volume to the container.
      - docker run -v data_volume:/var/lib/mysql mysql
  - Bind Mount
    - Mount Volumes from Any Location specified from the docker host.
    - if we have a database or volume and we want to mount container to that volume
      - docker run -v /data/mysql:/var/lib/mysql mysql

- Old Way to mount
  - -v
- New way
  - docker run \
    -- mount type=bind,source=/data/mysql,target=/var/lib/mysql mysql

- all this done by Storage Drivers

## 185. Volume Docker Plugin in Docker

- Volume are not handeled by Storage drivers
- Types:
  - Local
  - Azure file storage
  - Convoy
  - etc

- for AWS EBS
  - docker run -it \
        --name mysql
        --volume-driver rexray/ebs
        --mount src=ebs-vol,target=/var/lib/mysql
        mysql

## 186. Container Storage Interface (CSI)

- To extend support to different runtime interface we saw
  - Container Runtime Interface (CRI)
    - Which was used to Support Like rocker Cri-o etc

- To extend support to different Newtwork interface we saw
  - Container Network Interface (CNI)
    - Weaveworks
    - flannel
    - cilium

- To extend support to different Storage interface we will see
  - Container Storage Interface (CSI)
    - portwax
    - amazon ebs
    - dell emc
    - glusterFS

- CSI will call some RPC (Remote Procedure Call)
  - CreateVolume
  - DeleteVolume
  - ControllerPublishVolume
  - will be called by Orchestrator
  - this must be implemented by the Storage drivers

## 188. Volumes

- Just as in Docker, the pods created in Kubernetes are transient in nature.  When a pod is created to process data, and then deleted,  the data processed by it, gets deleted as well.  For this, we attach a volume to the pod.  The data generated by the pod is now stored in the volume,  and even after the pod is deleted, the data remains.  Let's look at a simple implementation of volumes.  We have a single node Kubernetes cluster.  We create a simple pod that generates a random number  between one and hundred,  and writes that with file  at slash O P T slash number dot out.  It then gets deleted along with the random number.  To retain the number generated by the pod,  we create a volume.

- And a volume needs a storage.  When you create a volume,  you can choose to configure its storage in different ways.  We will look at the various options in a bit,  but for now we will simply configure it  to use a directory on the host.  In this case, I specify a path,  forward slash data, on the host.  This way, any files created in the volume  would be stored in the directory data on my node.  

- Once the volume is created, to access it from a container  we mount the volume to a directory inside the container.  We use the volume mounts field  in each container to mount the data volume  to the directory, slash O P T within the container.  The random number will now be written to slash O P T mount  inside the container,  which happens to be on the data volume,  which is in fact the data directory on the host.  When the pod gets deleted,  the file with the random number still lives on the host.

- Let's take a step back  and look at the volume storage options.  We just used the host path option to configure it directly  on the host as storage space for the volume.  Now that works fine on a single node,  however, it is not recommended for use  in a multi node cluster.

- This is because the pods would use the slash data directory  on all the nodes, and expect all of them to be the same  and have the same data.  Since they're on different servers,  they're in fact, not the same.  Unless you configure some kind of external replicated  cluster storage solution.  Kubernetes supports several types  of different storage solutions,  such as NFS, cluster affairs, Flocker,  fiber channel, Ceph FS, scale io,  or public cloud solutions like AWS, EBS,  Azure desk, or file,  or Google's Persistent Desk.  

- For example, to configure an AWS elastic block store volume  as the storage option for the volume,  we replaced host path field of the volume  with the AWS Elastic block store field,  along with the volume ID and file system type.  The volume storage will now be on AWS EBS.

## 189. Persistent Volumes

- Now, when you have a large environment   with a lot of users deploying a lot of pods,  the users would have to configure storage  every time for each pod.  Whatever storage solution is used,  the users who deploys the pods would have to configure that  on all pod definition files in his environment.  Every time there are changes to be made  the user would have to make them on all of his pods.  Instead, you would like to manage storage more centrally.  You would like it to be configured in a way  that an administrator can create a large pool of storage  and then have users carve out pieces from it as required.  That is where persistent volumes can help us.

- A persistent volume is a cluster-wide pool  of storage volumes configured by an administrator  to be used by users deploying applications on the cluster.  The users can now select storage from this pool  using persistent volume claims.  Let us now create a persistent volume.  We start with the base template and update the API version.  Set the kind to persistent volume  and name it PV-Vol 1.  Under the spec section, specify the access modes.  Access mode defines how a volume  should be mounted on the hosts,  whether in a read-only mode or read/write mode, et cetera.

- The supported values are ReadOnlyMany, ReadWriteOnce,  or ReadWriteMany mode.  Next is the capacity.  Specify the amount of storage to be reserved  for this persistent volume,  which is set to 1 GB here.  Next comes the volume type.  We will start with the hostPath option  that uses storage from the node's local directory.  Remember, this option is not to be used  in a production environment.

- To create the volume,  run Kube Control, create command,  and to list the created volume, run the Kube Control,  get persistent volume command.  Replace the host path option  with one of the supported storage solutions  as we saw in the previous lecture,  like AWS Elastic Block Store, et cetera.

## 190. Persistent Volume Claims

- Now, we will try to create a Persistent Volume Claim to make the storage available to a note.  Persistent Volumes and Persistent Volume claims  are two separate objects in the Kubernetes name space.  An administrator creates a set of persistent volumes,  and a user creates persistent volume claims  to use the storage.  Once the persistent volume claims are created,  Kubernetes binds the persistent volumes to claims based  on the request and properties set on the volume.

- Every Persistent Volume   is bound  to a single Persistent Volume.  During the binding process, Kubernetes tries to find  a Persistent Volume that has sufficient capacity,  as requested by the claim.  And any other request properties such as,  access modes, volume modes, storage class, et cetera.  However, if there are multiple possible matches  for a single claim,  and you would like to specifically use a particular volume,  you could still use labels and selectors  to bind to the right volumes.  

- Finally, note that a smaller claim may get bound  to a larger volume if all the other criteria matches,  and there are no better options.  There is a one to one relationship between claims  and volumes, so no other claims can utilize  the remaining capacity in the volume.  If there are no volumes available,  the persistent volume claim will remain in a pending state  until newer volumes are made available to the cluster.  Once newer volumes are available,  the claim would automatically be bound to the newly available volume.

- Let us now create a persistent volume claim.  We start with a blank template.  Set the API version to V1 and kind  to persistent volume claim.  We will name it, "My Claim", under specification.  Set the access modes to read, write once.  And set resources to request a storage of 500 megabytes.  Create the claim using cube control, create command.

- To view the created claim, run the cube control,  get persistent volume claim command.  We see the claim in a pending state.  When the claim is created,  Kubernetes looks at the volume created previously.  The access modes match.  The capacity requested is 500 megabytes,  but the volume is configured with one GB of storage.  Since there are no other volumes available,  the Persistent Volume Claim is bound  to the Persistent Volume.  When we run the get volumes command, again,  we see the claim is bound  to the Persistent Volume we created.

- To delete a PVC, run the cube control,  delete persistent volume claim command.  But what happens to the underlying persistent  volume when the claim is deleted?  You can choose what is to happen to the volume.  By default, it is set to retain.  Meaning the persistent volume will remain  until it is manually deleted by the administrator.  It is not available for reuse by any other claims.  Or, it can be deleted automatically.

- This way, as soon as the claim is deleted,  the volume will be deleted as well.  Thus, freeing up storage on the end storage device.  Or, a third option is to recycle.  In this case, the data in the data volume will be scrubbed before making it available to other claims.

## Using PVC in PODS

- Reference URL: https://kubernetes.io/docs/concepts/storage/persistent-volumes/#claims-as-volumes

## 196. Storage Class

- Every time an application requires storage,   you have to first manually provision  the disk on Google Cloud,  and then manually create a persistent volume definition file  using the same name as that of the disk that you created.  That's called static provisioning volumes.  It would've been nice  if the volume gets provisioned automatically  when the application requires it,  and that's where storage classes come in.  With storage classes, you can define a provisioner,  such as Google Storage,  that can automatically provision storage on Google Cloud  and attach that to pods when a claim is made.  That's called dynamic provisioning of volumes.

- You do that by creating a storage class object  with the API version set to storage.k8.io/v1,  specify a name, and use provisioner as Kubernetes.io/gce-pd.  So going back to our original state where we have a pod  using a PVC for its storage, and the PVC is bound to a PV,  we now have a storage class,  so we no longer need the PV definition,  because the PV and any associated storage  is going to be created automatically  when the storage class is created.  For the PVC to use the storage class we defined,  we specify the storage class name in the PVC definition.

- That's how the PVC knows which storage class to use.  Next time a PVC is created,  the storage class associated with it  uses the defined provisioner  to provision a new disk with the required size on GCP,  and then creates a persistent volume,  and then binds the PVC to that volume.  So remember that it still creates a PV,  it's just that you don't have to manually create PV anymore.  It's created automatically by the storage class.  We used the GCE provisioner to create a volume on GCP.  There are many other provisioners as well,  such as, for AWS EBS, Azure File, Azure Disk, CephFS,  Portworx, ScaleIO, and so on.  With each of these provisioners,  you can pass in additional parameters,  such as the type of disk to provision,  the replication type, et cetera.

- These parameters are very specific to the provisioner  that you are using.  For Google Persistent Disk, you can specify the type,  which could be standard, or SSD.  You can specify the replication mode,  which could be none, or regional PD.  So you see, you can create different storage classes,  each using different types of disks.  For example, a silver storage class with the standard disks,  a gold class with SSD drives,  and a platinum class with SSD drives and replication.

- And that's why it's called storage class.  You can create different classes of service.  Next time you create a PVC,  you can simply specify the class of storage  you need for your volumes.