# Section-7-Security
## 140. Kubernetes Security Primitives

- Let's begin with the host that form the cluster itself.Of course, all access to these hosts must be secured,route access disabled,password based authentication disabledand only SSH key based authentication to be made available.And of course,any other measures you need to take to secure your physicalor virtual infrastructure that hosts Kubernetes.

- Of course, if that is compromised,everything is compromised.Our focus in this lecture is moreon Kubernetes related security.

- What are the risks and what measures do you need to taketo secure the cluster?

- As we have seen already,the kube-apiserver is at the centerof all operations within Kubernetes.We interact with it through the kube control utilityor by accessing the API directly,and through that you can perform almost any operationon the cluster.So that's the first line of defense.Controlling access to the API server itself.

- We need to make two types of decisions.

  - Who can access the cluster 
    - Who can access the API server is defined by the authentication mechanisms. There are different ways that you can authenticate to the API server, starting with user IDs and passwords stored in static files or tokens, certificates, or even integration with external authentication providers like LDAP. 

    - Finally, for machines, we create service accounts.

  - what can they do?
    - Once they gain access to the cluster what can they do is defined by authorization mechanisms. Authorization is implemented using role-based access controls where users are associated to groupswith specific permissions. 

    - In addition, there are other authorization modules like the attribute-based access control, Node authorizers, webhooks, et cetera.

- TLS Certificates

  - All communication with the cluster between the various components such as the ETCD cluster, the kube-controller-manager, scheduler, API server, as well as those running on the worker nodes such as the Kubelet and the kube-proxy is secured using TLS encryption.

- Network Policies
  - What about communication between applications within the cluster?
  
  - By default, all Pods can access all other Pods within the cluster. Now, you can restrict access between them using network policies.

## 141. Authentication

- As we have seen already, the Kubernetes cluster consists of multiple nodes, physical or virtual, and various components that work together.

- We have users like administrators that access the cluster to perform administrative tasks, the developers that access the cluster to test or deploy applications. 

- We have end users who access the applications deployed on the cluster, and we have third party applications accessing the cluster for integration purposes.

- our focus is on securing access to the Kubernetes cluster with authentication mechanisms.

- So we talked about the different usersthat may be accessing the cluster.Security of end users, who access the applicationsdeployed on the cluster is managedby the applications themselves, internally.So we will take them out of our discussion.Our focus is on users' access to the Kubernetes clusterfor administrative purposes.

- So we are left with two types of users,humans such as the administrators and developers,and robots such as other processesor services or applicationsthat require access to the cluster.Kubernetes does not manage user accounts natively.It relies on an external sourcelike a file with user details or certificatesor a third party identity service,like LDAP to manage these users.

- And so you cannot create users in a Kubernetes clusteror view the list of users like this.However, in case of service accounts,Kubernetes can manage them.You can create and

- we will focus on users in Kubernetes.All user access is managed by the API server,whether you're accessing the cluster throughKubecontrol tool or the API directly.All of these requests go through the Kube API server.

- The Kube API server authenticates the request before processing it.So how does the Kube API server authenticate?

  - There are different authentication mechanisms that can be configured.
  
    - You can have a list of username and passwords in a static password file (deprecated) or usernamesand tokens in a static token file (use this)
      - Let's start with static password and token files as it is the easiest to understand.Let's start with the simplest form of authentication.You can create a list of users and their passwordsin a CSV file and use that as the sourcefor user information.The file has three columns, password, username, and user ID.

      - We then pass the file name as an optionto the Kube API server.Remember the Kube API server serviceand the various options we looked at earlier in this course.That is where you must specify this option.You must then restart the Kube API serverfor these options to take effect.

      - If you set up your cluster using the Kubeadm tool,then you must modify the Kube API serverPOD definition file.The Kubeadm tool will automaticallyrestart the Kube API server once you update this file.To authenticate using the basic credentialswhile accessing the API server,specify the user and password in a curl command like this.

      - In the CSV file with the user details that we saw,we can optionally have a fourth column with the groupdetails to assign users to specific groups.

      - Similarly, instead of a static password file, you can have a static token file. Here instead of password, you specify a token. Pass the token file as an option, tokenauth file to the Kube API server. While authenticating specify the token as an authorization barrier token to your request like this.

    - you can authenticate using certificates.
    - to connect to third partyauthentication protocols like LDAP, Kerberos et cetera.


## 145. TLS Basics

- A certificate is used to guarantee trust between two parties during a transaction. 
  - For example, when a user tries to access a web server, TLS certificates ensure that the communication between the user and the server is encrypted and the server is who it says it is.

  - Let's take a look at a scenario.
    - Symmetric Encryption
      - Without secure connectivity,if a user were to access his online banking application,the credentials he types inwould be sent in a plain text format.The hacker sniffing network trafficcould easily retrieve the credentialsand use it to hack into the user's bank account.

      - Well, that's obviously not safe,so you must encrypt the data being transferredusing encryption keys.The data is encrypted using a key,which is basically a set of random numbers and alphabets.You add the random number to your dataand you encrypt it into a format that cannot be recognized.The data is then sent to the server.

      - The hacker sniffing the network gets the data,but can't do anything with it.However, the same is the casewith the server receiving the data.It cannot decrypt the data without the key,so a copy of the key must also be sentto the server so that the server can decryptand read the message.Since the key is also sent over the same network,the attacker can sniff that as welland decrypt the data with it.

      - This is known as symmetric encryption.
      - It is a secure way of encryption,but since it uses the same key to encryptand decrypt the data, and since the key has to be exchanged between the Sender and the receiver,there is a risk of a hacker gaining access to the keyand decrypting the data,and that's where asymmetric encryption comes in.
    - Asymmetric Encryption
      - Instead of using a single key to encrypt and decrypt data, asymmetric encryption uses a pair of keys,a private key and a public key.Well, they are private and public keys,but for the sake of this example,we will call it a private key and a public lock.We will get back to that at the end,but for now think of it as a key and a lock pair.

      - A key, which is only with me, so it's private,a lock that anyone can access, so it's public.The trick here is, if you encrypt or lock the datawith your lock, you can only open itwith the associated key.

      - So your key must always be secure with youand not be shared with anyone else, it's private,but the lock is public and maybe shared with others,but they can only lock something with it.No matter what is locked using the public lock,it can only be unlocked by your private key.Before we go back to our web server example,let's look at an even simpler use caseof securing SSH access to servers using key pairs.

      - You have a server in your environmentthat you need access to.You don't want to use passwords as they're too riskyso you decide to use key pairs.You generate a public and private key pair.You can do this by running the SSH keys and command.It creates two files, ID_RSA is the private keyand ID_RSA.pub is the public key.Well, not a public key, a public lock.

      - You then secure your serverby locking down all access to it,except through a door that is locked using your public lock.It's usually done by adding an entry with your public keyinto the server's SSH authorized_keys file.So you see the lock is publicand anyone can attempt to break through.But as long as no one gets their hands on your private key,which is safe with you on your laptop,no one can gain access to the server.

      - When you try to SSH, you specify the locationof your private key in your SSH command.

      - What if you have other servers in your environment?How do you secure more than one server with your key pair?
        - Well, you can create copies of your public lockand place them on as many servers as you want.You can use the same private keyto SSH into all of your servers securely.

      - What if other users need access to your servers?
        - Well, they can do the same thing.They can generate their own public and private key pairs.As the only person who has access to those servers,you can create an additional door for themand lock it with their public locks,copy their public locks to all the servers,and now other users can access the serversusing their private keys.

    - To securely transfer the symmetric key from the client to the server,we use asymmetric encryption.So we generate a public and private key pair on the server.We're going to refer to the public logas public key going forwardnow that you have got the idea.The SSH key gen command was used earlierto create a pair of keys for SSH purposes,so the format is a bit different.Here we use the open SSL commandto generate a private and public key pair,and that's how they look.When the user first accesses the web server using STTPS,he gets the public key from the server.Since the hacker is sniffing all traffic,let us assume he too gets a copy of the public key.We'll see what he can do with it.The user, in fact, the user's browserthen encrypts the symmetric keyusing the public key provided by the server.The symmetric key is now secure.The user then sends this to the server.The hacker also gets a copy.The server uses the private key to decrypt the messageand retrieve the symmetry key from it.However, the hacker does not have the private keyto decrypt and retrieve the symmetric keyfrom the message it received.The hacker only has the public keywith which he can only lock or encrypt a messageand not decrypt the message.The symmetric key is now safely available onlyto the user and the server.They can now use the symmetric keyto encrypt data and send to each other.The receiver can use the same symmetric keyto decrypt data and retrieve information.The hacker is left with the encrypted messagesand public keys with which he can't decrypt any data.With asymmetric encryption,we have successfully transferred the symmetric keysfrom the user to the server,and with symmetric encryptionwe have secured all future communication between them.

    - The hacker now looks for new ways to hack into your account,and so he realizes that the only way hecan get your credential is by getting youto type it into a form he presents.So he creates a website that looks exactlylike your bank's website.The design is the same, the graphics are the same,the website is a replica of the actual bank's website.He hosts the website on his own server.He wants you to think it's secure too,so he generates his own set of publicand private key pairs and configures them on his web server.And finally, he somehow manages to tweak your environmentor your network to route your request goingto your bank's website to his servers.When you open up your browserand type the website address in,you see a very familiar page,the same logging page of your bankthat you are used to seeing,so you go ahead and type in the username and password.You make sure you type in STPS in the URLto make sure the communication is secure and encrypted.Your browser receives a key,you send encrypted symmetric keyand then you send your credentials encrypted with the keyand the receiver decrypts the credentialswith the same symmetric key.You've been communicating securely in an encrypted manner,but with the hacker's server.As soon as you send in your credentials,you see a dashboard that doesn't look very muchlike your bank's dashboard.What if you could look at the key you receivedfrom the server and say if it is a legitimate keyfrom the real bank server?When the server sends the key,it does not send the key along,it sends a certificate that has the key in it.If you take a closer look at the certificate,you will see that it is like an actual certificatebut in a digital format.It has information about who the certificate is issued to,the public key of that server,the location of that server, et cetera.On the right, you see the output of an actual certificate.Every certificate has a name on it,the person or subject to whom the certificateis issued to that is very importantas that is the field that helps you validate their identity.If this is for a web server,this must match what the user types inin the URL on his browser.If the bank is known by any other names,and if they'd like their users to access their applicationwith the other names as well,then all those names should be specified in this certificateunder the subject as native name section.But you see, anyone can generate a certificate like this.You could generate one for yourself saying you're Google,and that's what the hacker did in this case.He generated a certificate saying he is your bank's website.So how do you look at a certificate and verifyif it is legit?That is where the most important partof the certificate comes into play.Who signed and issued the certificate?If you generated a certificatethen you'll have to sign it by yourself.That is known as a self-signed certificate.

    - Anyone looking at the certificate you generated will immediately know that it is not a safe certificate,because you have signed it.If you looked at the certificate you receivedfrom the hacker closely,you would've noticed that it was a fake certificatethat was signed by the hacker himself.As a matter of fact, your browser does that for you.All of the web browsers are built inwith a certificate validation mechanismwhile in the browser text the certificate receivedfrom the server and validates itto make sure it is legitimate.If it identifies it to be a fixed certificate,then it actually warns you.So then how do you create a legitimate certificatefor your web servers that the web browsers will trust?How do you get your certificates signedby someone with authority?That's where certificate authorities or CAs comes in.They're well known organizationsthat can sign and validate your certificates for you.Some of the popular ones are Symantec, DigiCert, Comodo,GlobalSign, et cetera.The way this works is,you generate a certificate signing a request or CSRusing the key you generated earlierand the domain name of your website.You can do this again using the open SSL command.This generates a My-Bank.CSR file,which is the certificate signing requestthat should be sent to the CA for signing.It looks like this.The certificate authorities verify your detailsand once it checks out,they sign the certificate and send it back to you.You now have a certificate signed by a CAthat the browsers trust.If hacker tried to get his certificate signed the same way,he would fail during the validation phaseand his certificate would be rejected by the CA.So the website that he's hostingwon't have a valid certificate.The CAs use different techniquesto make sure that you are the actual owner of that domain.You now have a certificate signed by a CAthat the browsers trust.But how do the browsers know that the CA itselfwas legitimate?For example, one if the certificate was signed by a fake CA,in this case, our certificate was signed by Symantec.How would the browser know Symantec is a valid CAand that the certificate was in fact signed by Symantecand not by someone who says they are Symantec?The CAs themselves have a set of publicand private key pairs.The CAs use their private keys to sign the certificates.The public keys of all the CAs are built in to the browsers.The browser uses the public key of the CAto validate that the certificate was actually signedby the CA themselves.You can actually see them in the settingsof your web browser under certificates,they're under trusted CAs tab.Now, these are public CAsthat help us ensure the public websites we visit,like our banks, emails, et cetera, are legitimate.However, they don't help you validate siteshosted privately, say within your organization.For example, for accessing your payrollor internal email applications.For that, you can host your own private CAs.Most of these companies listed herehave a private offering of their services,a CA server that you can deploy internallywithin your company.You can then have the public keyof your internal CAs server installedon all your employees browsersand establish secure connectivity within your organization.

## 146. TLS in Kubernetes

- https://kubernetes.io/docs/tasks/tls/

- The Kubernetes cluster consists of a set of master and worker nodes.Of course, all communication between these nodesneed to be secure and must be encrypted.All interactions between all servicesand their clients need to be secure.For example, an administrator interacting withthe Kubernetes cluster through the kubectl utilityor while accessing the Kubernetes API directlymust establish secure TLS connection.Communication between all the componentswithin the Kubernetes cluster also need to be secured.So the two primary requirements areto have all the various services within the clusterto use server certificatesand all clients to use client certificatesto verify they are who they say they are.Let's look at the different componentswithin the Kubernetes clusterand identify the various servers and clientsand who talks to who.

- Kube-Api derver
  - As we know already, the API server exposes an HTTPS service that other components, as well as external users,use to manage the Kubernetes cluster.So it is a server and it requires certificatesto secure all communication with its clients.So we generate a certificate and key pair.We call it APIserver.cert and APIserver.key.We will try to stickto this naming convention going forward.Anything with a .CRT extension is the certificateand .key extension is the private key.Also remember, these certificate names could be differentin different Kubernetes setups dependingon who and how the cluster was set up.So these names may be different in yours.In this lecture, we will try to use namesthat help us easily identify the certificate files.Another server in the cluster is the etcd server.The etcd server stores all information about the cluster.So it requires a pair of certificate and key for itself.We will call it etcdserver.crt and etcdserver.key.The other server component in the clusteris on the worker nodes.They are the kubelet services.They also expose an HTTPS API endpointthat the kube-apiserver talks toto interact with the worker nodes.Again, that requires a certificate and key pair.We call it kubelet.cert and kubelet.key.Those are really the server componentsin the Kubernetes cluster.Let's now look at the client components.Who are the clients who access these services?The clients who access the kube-apiserver are us,the administrators through kubectl Arrest API.The admin user requires a certificateand key pair to authenticate to the kube-API server.We will call it admin.crt, and admin.key.The scheduler talks to the kube-apiserverto look for pods that require schedulingand then get the API server to schedule the podson the right worker nodes.The scheduler is a client that accesses the kube-apiserver.As far as the kube-apiserver is concerned,the scheduler is just another client, like the admin user.So the scheduler needs to validate its identityusing a client TLS certificate.So it needs its own pair of certificate and keys.We will call it scheduler.cert and scheduler.key.The Kube Controller Manager is another clientthat accesses the kube-apiserver, so it also requiresa certificate for authentication to the kube-apiserver.So we create a certificate pair for it.The last client component is the kube-proxy.The kube-proxy requires a client certificateto authenticate to the kube-apiserver,and so it requires its own pair of certificate and keys.We will call them kubeproxy.crt, and kubeproxy.key.The servers communicate amongst them as well.For example, the kube-apiserver communicateswith the etcd server.In fact, of all the components, the kube-apiserveris the only server that talks to the etcd server.So as far as the etcd server is concerned,the kube-apiserver is a client, so it needs to authenticate.The kube-apiserver can use the same keysthat it used earlier for serving its own API service.The APIserver.crt, and the APIserver.key files.Or, you can generate a new pairof certificates specifically for the kube-apiserverto authenticate to the etcd server.The kube-apiserver also talks to the kubelet serveron each of the individual nodes.That's how it monitors the worker nodes for this.Again, it can use the original certificates,or generate new ones specifically for this purpose.So that's too many certificates.Let's try and group them.There are a set of client certificates, mostly usedby clients to connect to the kube-apiserverand there are a set of server site certificatesused by the kube-apiserver, etcd server, and kubletto authenticate their clients.We will now see how to generate these certificates.

  - As we know already, we need a certificate authority to sign all of these certificates. Kubernetes requires you to have at least one certificate authority for your cluster. In fact, you can have more than one. One for all the components in the cluster and another one specifically for etcd. In that case, the etcd servers certificates and the etcd servers client certificates, which in this case is the API server client certificate, will be all signed by the etcd server CA. For now, we will stick to just one CA for our cluster.The CA, as we know, has its own pair of certificate and key.We will call it CA.crt and CA.key. That should sum up all the certificates used in the cluster.

## 147. TLS in Kubernetes - Certificate Creation

- there are basically two types of certificates will be used
  - Client
    - who will be using the service
  - Server
    - who will provide the service

- CA Authority
  - this provides signed CA certificate for both client and server certificates.
  - provides public for all the resources for trusted connection
    - and a private signed certificate to be used for authentication purpose.

## Excerise to create a Certificate and signed CA certificate, need to check.

## 152. Certificates API

- but as, and when the users increase and your team growsyou need a better automated way to manage the certificates,signing requests, as well as to rotate certificateswhen they expire.Kubernetes has a built in certificates APIthat can do this for you.With the certificates API, you now send a certificatesigning request directly to Kubernetes through an API call.This time when the administrator receivesa certificate signing request, instead of logging ontothe master node and signing the certificate by himself,he creates a Kubernetes API objectcalled certificate signing request.Once the object is createdall certificate signing requests can be seenby administrators of the cluster.The request can be reviewed and approvedeasily using Kube control commands.This certificate can then be extractedand shared with the user.Let's see how it is done.A user first creates a keythen generates a certificate signing request,using the key with her name on it,then sends the request to the administrator.The administrator takes a keyand creates a certificate signing request object.The certificate signing request object is createdlike any other Kubernetes object using a manifest filewith the usual fields.The kind is certificate signing request.Under the spec section, specify the groupsthe user should be part of,and lists the usages of the account as a list of strings.The request field is where you specify the certificatesigning request sent by the userbut you don't specify it as plain text.Instead, it must be encoded using the base 64 command.Then, move the encoded text into the request fieldand then submit the request.Once the object is createdall certificate signing requests can be seenby administrators by running the Kubectl, get CSR command.Identify the new request and approve the requestby running the Kubectl certificate approved command.Kubernetes signs the certificate using the CA key pairsand generates a certificate for the user.This certificate can then be extractedand shared with the user.View the certificate by viewing it in a YAML format.The generated certificate is part of the output,but as before, it is in a base 64 and coded format.To decode it, take the textand use the base 64 utilities decode option.This gives the certificate in a plain text format.This can then be shared with the end user.

- Now that we have seen how it works.
- Let's see who does all of this for us.If you look at the Kubernetes control planeyou see the Kube play server, the scheduler,the control manager, and CD server, et cetera.Which of these components is actually responsiblefor all the certificate related operations?All the certificate related operations are carriedout by the controller manager.If you look closely at the controller manager,you will see that it has controllersin it called as CSR approving, CSR signing, et cetera,that are responsible for carrying out these specific tasks.We know that if anyone has to sign certificatesthey need the CA servers route certificate and private key.The Controller Manager service configurationhas two options where you can specify this.

## 155. KubeConfig

- https://devopscube.com/kubernetes-kubeconfig-file/

## 159. API Groups

- These APIs are categorized into two, the core group and the named group.

- The core group is where all core functionality exists, such as name, spaces, pods, replication controllers, events and points, nodes, bindings, persistent volumes, persistent volume claims, conflict maps, secrets, services, et cetera.

- The named group APIs are more organized and going forward, all the newer features are going to be made available through these named groups. It has groups under it for apps, extensions, networking, storage, authentication, authorization, et cetera. Shown here are just a few. 

- Within apps, you have deployments, replica sets, stateful sets. Within networking, you have network policies. Certificates have these certificate signing requests that we talked about earlier in the section. So the ones at the top are API groups, and the ones at the bottom are resources in those groups.

- Each resource in this has a set of actions associated with them, Things that you can do with these resources, such as list the deployments, get information about one of these deployments, create a deployment, delete a deployment, update a deployment, watch a deployment, et cetera. These are known as verbs.

-The Kubernetes API reference page can tell you what the API group is for each object; select an object, and the first section in the documentation page shows it's group details, v1 core is just v1. You can also view these on your Kubernetes cluster.

- Access your Kube API server at port 6-4-4-3 without any path and it will list you the available API groups. And then, within the named API groups it returns all the supported resource groups. A quick note on accessing the cluster API like that. If you were to access the API directly through cURL as shown here,then you will not be allowed access except for certain APIs like version, as you have not specified any authentication mechanisms. So you have to authenticate to the API using your certificate files by passing them in the command line like this.

- An alternate option is to start a Kube control proxy client. The Kube control proxy command launches a proxy service locally on port 8-0-0-1 and uses credentials and certificates from your Kube config file to access the cluster.

- That way, you don't have to specify those in the cURL command. Now you can access the Kube control proxy service at port 8-0-0-1 and the proxy will use the credentials from Kube config file to forward your request to the Kube API server.

- This will list all available APIs at root.

- So here are two terms that kind of sound the same, The Kube proxy and Kube control proxy. well, they're not the same. We discussed about Kube proxy earlier this course. It is used to enable connectivity between pods and services across different nodes in the cluster. We discuss about Kube proxy in much more detail later in this course. Whereas Kube control proxy is an ACTP proxy service created by Kube control utility to access the Kube API server.

- So what to take away from this?

- All resources in Kubernetes are grouped into different API groups. At the top level, you have core API group and named API group. Under the named API group, you have one for each section. Under these API groups, you have the different resources and each resource has a set of associated actions known as verbs.

## 160. Authorization

- First of all, why do you need authorization in your cluster?

- As an administrator of the clusterwe were able to perform all sorts of operations in it,such as viewing various objects like podsand nodes and deployments,creating or deleting objectssuch as adding or deleting podsor even nodes in the cluster.As an admin, we are able to perform any operationbut soon we will have others accessing the cluster as wellsuch as the other administrators,developers,testersor other applications like monitoring applicationsor continuous delivery applications like Jenkins, et cetera.

- So, we will be creating accounts for themto access the cluster by creating usernamesand passwords or tokens, or signed TL certificatesor service accounts as we saw in the previous lectures.But we don't want all of themto have the same level of access as us.For example, we don't want the developersto have access to modify our cluster configuration,like adding or deleting nodesor the storage or networking configurations.

- We can allow them to view but not modify,but they could have access to deploying applications.The same goes with service accounts,we only want to provide the external applicationthe minimum level of accessto perform its required operations.When we share our cluster between different organizationsor teams, by logically partitioning it using name spaces,we want to restrict access to the usersto their name spaces alone.

- That is what authorization can help you within the cluster.

- There are different authorization mechanismssupported by Kubernetes,such as node authorization,attribute-based authorization,role-based authorization and webhook.

- Node based
  - Let's just go through these now.We know that the Kube API Server is accessed by userslike us for management purposes,as well as the kubelets on nodewithin the cluster for management processwithin the cluster.
  
  - The kubelet accesses the API serverto read information about services and points,nodes, and pods.The kubelet also reports to the Kube API Serverwith information about the node, such as its status.These requests are handled by a special authorizerknown as the Node Authorizer.
  
  - In the earlier lectures,when we discussed about certificates,we discussed that the kubeletsshould be part of the system nodes groupand have a name prefixed with system node.So any request coming from a userwith the name system nodeand part of the system nodes groupis authorized by the node authorizer,and are granted these privileges,the privilege is required for a kubelet.So that's access within the cluster.

- attribute-based authorization
  - Let's talk about external access to the API.For instance, a user.Attribute-based authorizationis where you associate a user or a group of userswith a set of permissions.In this case, we say the dev usercan view, create and delete pods.
  
  - You do this by creating a policy filewith a set of policies defined in adjacent format this wayyou pass this file into the API server.Similarly, we create a policy definition filefor each user or group in this file.
  
  - Now, every time you need to addor make a change in the security,you must edit this policy file manuallyand restart the Kube API Server.As such, the attribute-based access control configurationsare difficult to manage.

- role-based authorization
  - Role-based access controls make these much easier.With role-based access controls,instead of directly associating a useror a group with a set of permissions,we define a role, in this case for developers.We create a role with the setof permissions required for developersthen we associate all the developers to that role.
  
  - Similarly, create a role for security userswith the right set of permissions required for themthen associate the user to that role.Going forward, whenever a changeneeds to be made to the user's accesswe simply modify the roleand it reflects on all developers immediately.
  
  - Role-based access controls provide a more standard approachto managing access within the Kubernetes cluster.We will look at role-based access controlsin much more detail in the next lecture.For now, let's proceedwith the other authorization mechanisms.

- Webhook
  - Say you want to manage authorization externallyand not through the built-in mechanismsthat we just discussed.For instance, Open Policy Agent is a third-party toolthat helps with admission control and authorization.You can have Kubernetes make an API callto the Open Policy Agent with the informationabout the user and his access requirements,and have the Open Policy Agent decideif the user should be permitted or not.Based on that response, the user is granted access.

- Now, there are two more modes in addition to what we just saw.
- Always Allow and Always Deny.
  - As the name states, Always Allow, allows all requests without performing any authorization checks. Always Deny, denies all requests. So, where do you configure these modes? Which of them are active by default? Can you have more than one at a time? How does authorization work if you do have multiple ones configured? The modes are set using the Authorization Mode Option on the Kube API Server. If you don't specify this option, it is set to Always Allow by default. You may provide a comma separated list of multiple modes that you wish to use. In this case, I wanna set it to node-rbac and webhook. When you have multiple modes configured your request is authorized using each one in the order it is specified. For example, when a user sends a request it's first handled by the Node Authorizer. The Node Authorizer handles only node requests,so it denies the request. Whenever a module denies a request it is forwarded to the next one in the chain. The role-based access control module performs its checks and grants the user permission.Authorization is complete and user is given access to the requested object. So, every time a module denies the request it goes to the next one in the chain and as soon as a module approves the request no more checks are done and the user is granted permission.

## 161. Role Based Access Controls

- So how do we create a role?

- We do that by creating a role object.So, we create a role definition filewith the API version setto our back.authorization.K.IU/V1and kind said to role, we name the role developeras we are creating this role for developers,and then we specify rules.Each rule has three sections:API groups, resources, and works.The same things that we talkedabout in one of the previous lectures.For Core group you can leave the API group section as blank.For any other group, you specify the group name.The resources that we want togive developers access to are pods.

- The actions that they can takeare list, get, create, and delete.Similarly, to allow the developers to create conflict maps,we add another rule to create config map.You can add multiple rules for a single role like this.Create the role using the cube control create roll command.The next step is to link the user to that role.For this, we create another object called roll binding.The roll binding object links a user object to a role.

- We will name it dev user to Developer Binding.The kind is role binding.It has two sections.The subjects is where we specify the user details.The roll ref section is where we provide the detailsof the roll we created.Create the role binding using thecube control create command.Also note that the rolesand role bindings fall under the scope of name spaces.So here the dev user gets accessto pot and convict maps within the default name space.

- If you want to limit the dev user's accesswithin a different name spacethen specify the name space within the metadataof the definition file while creating them.To view the created roles,run the cube control get rolls command.To list role bindings, run the cube control,get roll bindings command.To view more details about the role, run the cube controldescribe role developer command.Here you see the details about the resources and permissionsfor each resource.Similarly, to view details about rule bindingsrun the cube control, describe rolled bindings command.Here you can see details about an existing role binding.

- What if you being a user would like to seeif you have access to a particular resource in the cluster?

- You can use the Q control oath can I command,and check if you can say, create deployments,or say delete notes.If you're an administrator, then you can evenimpersonate another user to check their permission.For instance, say you were tasked to create necessary setof permissions for a user to performa set of operations, and you did that,but you would like to test if what you did is working.You don't have to authenticate as the user to test it.Instead, you can use the same commandwith the AS user option like this.

- Since we did not grant the developer permissionsto create deployments, it returns no.The dev user has access to creating pods though.You can also specify the name space in the commandlike this, the dev user does not have permission tocreate a pod in the test name space.Well, a quick note on resource names.We just saw how you can provide accessto users for resources like pods within the name space.You can go one level downand allow access to specific resources alone.

- For example, say you have five parts in namespaceyou wanna give access to a user to pods, but not all pods.You can restrict access to the blue and orange pod aloneby adding a resource names field to the rule.

## 164. Cluster Roles and Role Bindings

- 