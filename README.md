Kubernetes is an open-source platform that automates containerised applications' deployment, scaling, and management. It was originally developed by Google and is now maintained by the Cloud Native Computing Foundation (CNCF). It is written in 'Golang'.
Kubernetes follows a master-worker (or control plane-node) architecture. Here's a textual representation of the key components and how they interact:
![image](https://github.com/ShrikarMukesh/kubernetes/assets/46884233/cfe7612b-9dda-4beb-8947-363991d6d949)


**Master (Control Plane)**:
1. **API Server**: The central management point for the Kubernetes cluster. It exposes the Kubernetes API, which clients use to interact with the cluster.
2. **Etcd**: A highly available and consistent key-value store used for storing all cluster data, including configuration data and the current state of the cluster.
3. **Scheduler**: The component responsible for distributing work to worker nodes (Pods). It takes into account resource requirements, hardware/software constraints, and user-defined policies.
4. **Controller Manager**: Runs controller processes that regulate the state of the system. Examples include the ReplicaSet controller, which maintains the correct number of Pods, and the Node controller, which manages nodes.
5. **Cloud Controller Manager (optional)**: If you're using a cloud provider, this component interacts with the cloud provider's API to manage resources like Load Balancers and Persistent Volumes.
6. **Kubelet**: Runs on each node and ensures that containers in Pods are running in a healthy state. It communicates with the API server.
7. **Kube Proxy**: Maintains network rules on nodes, allowing network communication to Pods from network sessions inside or outside the cluster.
8. **Container Runtime**: The software responsible for running containers. Docker and containerd are common container runtimes used with Kubernetes.

**Worker (Node)**:
1. **Kubelet**: Communicates with the API server and ensures containers in Pods are running as expected.
2. **Kube Proxy**: Maintains network rules on the node to enable communication to Pods.
3. **Container Runtime**: Responsible for running containers (e.g., Docker).
4. **Pod**: The smallest deployable unit in Kubernetes, containing one or more containers.
5. **Service Proxy (iptables or IPVS)**: Responsible for load balancing traffic to Pods within the node.
6. **cAdvisor**: Collects container-level performance statistics and exposes them for monitoring.

**Cluster Network**:
- The cluster network connects all nodes in the cluster, allowing Pods and services to communicate with each other.
- Network plugins like Calico, Flannel, and Cilium are used to implement networking in Kubernetes clusters.

This architecture allows Kubernetes to manage containerized applications across a cluster of machines efficiently. The control plane components handle the management and orchestration, while the worker nodes execute the workloads in the form of containers. The etcd store maintains the desired state of the cluster, and the various controllers and kubelets work to achieve that state.

Kubernetes (K8s) is a powerful container orchestration platform used for automating the deployment, scaling, and management of containerized applications. 
Kubernetes manages these containerized applications through various objects that represent the desired state of the system. Below, I'll explain some of the most common Kubernetes objects along with examples:

1. **Pod**:
   - A Pod is the smallest deployable unit in Kubernetes.
   - It can contain one or more containers that share the same network namespace, IP address, and storage.
   - Example:
     ```yaml
     apiVersion: v1
     kind: Pod
     metadata:
       name: my-pod
     spec:
       containers:
       - name: my-container
         image: nginx
     ```

2. **Service**:
   - A Service defines a set of Pods and a policy for accessing them.
   - It provides a stable endpoint (usually an IP and port) to access one or more Pods.
   - Example:
     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: my-service
     spec:
       selector:
         app: my-app
       ports:
       - protocol: TCP
         port: 80
         targetPort: 8080
     ```

3. **Deployment**:
   - A Deployment manages the desired state for a set of Pods, allowing you to declaratively update and scale applications.
   - It can automatically create and manage ReplicaSets.
   - Example:
     ```yaml
     apiVersion: apps/v1
     kind: Deployment
     metadata:
       name: my-deployment
     spec:
       replicas: 3
       selector:
         matchLabels:
           app: my-app
       template:
         metadata:
           labels:
             app: my-app
         spec:
           containers:
           - name: my-container
             image: nginx
     ```

4. **ReplicaSet**:
   - A ReplicaSet ensures that a specified number of replica Pods are running at all times.
   - It's often managed by a Deployment.
   - Example:
     ```yaml
     apiVersion: apps/v1
     kind: ReplicaSet
     metadata:
       name: my-replicaset
     spec:
       replicas: 3
       selector:
         matchLabels:
           app: my-app
       template:
         metadata:
           labels:
             app: my-app
         spec:
           containers:
           - name: my-container
             image: nginx
     ```

5. **ConfigMap**:
   - A ConfigMap stores configuration data as key-value pairs, which can be used by Pods as environment variables or mounted as files.
   - Example:
     ```yaml
     apiVersion: v1
     kind: ConfigMap
     metadata:
       name: my-config
     data:
       app_config.properties: |
         key1=value1
         key2=value2
     ```

6. **Secret**:
   - A Secret stores sensitive information, such as passwords or API keys, in an encrypted manner.
   - It can be used by Pods as environment variables or mounted as files.
   - Example:
     ```yaml
     apiVersion: v1
     kind: Secret
     metadata:
       name: my-secret
     data:
       username: dXNlcm5hbWU=
       password: cGFzc3dvcmQ=
     ```

These are some of the fundamental Kubernetes objects. Kubernetes offers many more objects and resources to manage various aspects of your containerized applications, including StatefulSets, DaemonSets, PersistentVolumeClaims, and more. The choice of which objects to use depends on your application's requirements and architecture.

Ingress is another important Kubernetes object used for managing external access to services within the cluster. It provides a way to route incoming HTTP and HTTPS traffic to different services based on rules and configurations. Ingress controllers are responsible for implementing the rules defined in Ingress resources. Below is an explanation of Ingress along with an example:

**Ingress**:
- An Ingress is an API object that manages external access to services within a cluster.
- It enables you to define rules for routing HTTP and HTTPS traffic based on hostnames and paths.
- Ingress resources typically work with an Ingress controller (e.g., Nginx Ingress Controller, Traefik) that handles the actual routing and load balancing.
- Example:
  ```yaml
  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: my-ingress
  spec:
    rules:
      - host: example.com
        http:
          paths:
            - path: /app
              pathType: Prefix
              backend:
                service:
                  name: my-service
                  port:
                    number: 80
  ```

In this example, the Ingress resource defines a rule that routes traffic to the `my-service` service when the host is `example.com` and the path begins with `/app`. The Ingress controller will use this configuration to set up the necessary routing rules.

Ingress resources are essential for exposing your applications to the external world, managing SSL/TLS termination, and routing traffic to different services based on rules, making them a key component for handling external traffic in a Kubernetes cluster.
