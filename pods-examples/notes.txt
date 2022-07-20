-----:Kubernetes Pods:----------------------

Pods are the smallest deployable units that can be created and managed in Kubernetes.
  ----You need to create a Pod for the container to run.
  ----Pod can contain one or more containers
  --- If these containers are tightly coupled then run those  tightly coupled containers in one Pod.
  --- A Pod  is a group of one or more containers, with shared storage and network resources, and a specification for how to run the containers.
 
 1) Pods that run a single container. 
===========================================================================
=> One-Container-Per-Pod model is the most common Kubernetes use case; 
=> In this case, you can think of a Pod as a wrapper around a single container
=> Kubernetes manages Pods rather than managing the containers directly.

============================================================================
mypod1.yml
===========================================================================
apiVersion: v1
kind: Pod
metadata:
  name: mypod1
  labels:
    run: mypod1
spec:
  restartPolicy: Always
  containers:
  - name: mytomcat
    image: tomcat
    ports:
     - containerPort: 8080

 2) Pods that run multiple containers that need to work together.
==============================================
=>  A Pod can contain multiple co-located containers that are tightly coupled and need to share resources. 

=============================================================
mypod2.yml
============================================================
apiVersion: v1
kind: Pod
metadata:
  name: mypod2
spec:
  restartPolicy: Never
  containers:
  - name: mynginx
    image: nginx
    ports:
     - containerPort: 80
  - name: mytomcat
    image: tomcat
    ports:
     - containerPort: 8080
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Pod Lifecycle


Pods are only scheduled once in their lifetime. 
Once a Pod is scheduled (assigned) to a Node, the Pod runs on that Node until it stops or is terminated.


If a Node dies, the Pods scheduled to that node are scheduled for deletion after a timeout period.

A given Pod (as defined by a UID) is never "rescheduled" to a different node; instead, that Pod can be replaced by a new, near-identical Pod, with even the same name if desired, but with a different UID.

Pending	
Running	
Succeeded	
Failed	
Unknown	



Container states 
Kubernetes tracks the state of each container inside a Pod. 

Once the scheduler assigns a Pod to a Node, the kubelet starts creating containers for that Pod using a container runtime.

 There are three possible container states: 
Waiting, 
Running, 
Terminated.


Container restart policy
===================================================================
The spec of a Pod has a restartPolicy field with possible values 
Always, 
OnFailure, 
Never. 

The default value is Always.

The restartPolicy applies to all containers in the Pod. 

===================================================================

----->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

ubuntu@jenkins-server:~$ kubectl describe pod mypod1
Name:         mypod1
Namespace:    default
Priority:     0
Node:         minikube/192.168.49.2
Start Time:   Wed, 20 Jul 2022 02:50:08 +0000
Labels:       run=mypod1
Annotations:  <none>
Status:       Running
IP:           172.17.0.3
IPs:
  IP:  172.17.0.3
Containers:
  mypod1:
    Container ID:   docker://b844f112ed842ab481c77dfdfa95887700110f7179289a4ab8075cf3a4cc57ae
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:1761fb5661e4d77e107427d8012ad3a5955007d997e0f4a3d41acc9ff20467c7
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Wed, 20 Jul 2022 02:50:18 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-f9dpd (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-f9dpd:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  7m33s  default-scheduler  Successfully assigned default/mypod1 to minikube
  Normal  Pulling    7m33s  kubelet            Pulling image "nginx"
  Normal  Pulled     7m23s  kubelet            Successfully pulled image "nginx" in 9.265682542s
  Normal  Created    7m23s  kubelet            Created container mypod1
  Normal  Started    7m23s  kubelet            Started container mypod1

--------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
     
