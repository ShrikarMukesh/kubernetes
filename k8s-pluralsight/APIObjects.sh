#Get the Information about our current cluster, ensure we're logged into the correct cluster
kubectl config get-contexts
CURRENT   NAME       CLUSTER    AUTHINFO   NAMESPACE
*         minikube   minikube   minikube   default

#Change config context if needed by specifying the name
kubectl config use-contexts minikube

kubectl cluster-info

#Get List of API resources available in the cluster
kubectl api-resources | more

kubectl explain pods | more


kubectl explain pod.spec | more
kubectl explain pod.spec.containers | more