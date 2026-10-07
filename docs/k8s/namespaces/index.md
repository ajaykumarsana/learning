What is namespace
To organise resources in namespaces.
it is a virtual cluster inside cluster.
In k8s cluster we have 4 default namespaces

1. List of default name-spaces in k8s.
   Run `kubectl get namespace`

PS D:\tech\others> kubectl get namespace
NAME STATUS AGE
default Active 6d21h
kube-node-lease Active 6d21h
kube-public Active 6d21h
kube-system Active 6d21h
kubernetes-dashboard Active 6d21h

1. 1. kubernetes-dashboard
      it automatically ships with minikube.(only)
1. 2. kube-system
      DO not create / modify this namespace.
1. 3. kube-public
      contains publicly accesible data.
      a confiMap , which container cluster information.
      PS D:\tech\others> kubectl cluster-info
      Kubernetes control plane is running at https://127.0.0.1:50910
      CoreDNS is running at https://127.0.0.1:50910/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

   To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.

1. 4. kube-node-release
      availability of node
1. 5. default
      resources you create are located here.

1. Create a name-space.

Run `kubectl create namespace <name_space>`

PS D:\tech\others> kubectl create namespace aj-namespace

PS D:\tech\others> kubectl get namespace
NAME STATUS AGE
aj-namespace Active 37s
default Active 6d22h
kube-node-lease Active 6d22h
kube-public Active 6d22h
kube-system Active 6d22h
kubernetes-dashboard Active 6d22h

2. 1. We can create namespace using configMap.

3. need of namespace - resources are grouped in namespaces. - `Grouping - Structure`: Logically grouping would be best use-case. - Should not use for small - projects. - `Conflict`: Many teams use same application with different configurations to deploy somethings, to avoid conflicting names. - `Resource sharing` : If we have multiple environments in one cluster to avoid resource duplications. same resources can be used by different environments - `Blue Green deployment` : Same builds with multiple versions can use same common shared resources. - `Access and resource Limits` : Each team which shares common cluster can restrict accessing their name spaces by another projects.So Team can have isolated env inside shared single cluster. - CPU, RAM and storage - Resource Quota can be defined for namespaces
   Few things to note:
   Resources of another Namespace can't be accessed. - But services of different name spaces can be accessed. - in conigMap def we should use <my-service.property>
   Each Name space must define own configMap.
   Example:
   k8s-cluster
   | data-base names
   | monintoring namespaces
   | Elastic Stack / Kibana namespaces
   | nginx - ingress name spaces.

PS D:\tech\others> kubectl get configmap
NAME DATA AGE
kube-root-ca.crt 1 7d
kube-public Active 7d
kube-system Active 7d
kubernetes-dashboard Active 7d
PS D:\tech\others> kubectl apply -f '.\kubernetes\7. namespaces\mysql-namespace.yml' --namespace=aj-namespace error: the namespace from the provided object "my-namespace" does not match the namespace "aj-namespace". You must pass '--namespace=my-namespace' to perform this operation.
PS D:\tech\others> kubectl apply -f '.\kubernetes\7. namespaces\mysql-namespace.yml'configmap/mysql-configmap created
PS D:\tech\others> kubectl apply -f '.\kubernetes\7. namespaces\mysql-namespace.yml' --namespace=aj-namespace
configmap/mysql-configmap unchanged
PS D:\tech\others> kubectl get all -n aj-namespace
No resources found in aj-namespace namespace.
PS D:\tech\others> kubectl get configmap -n aj-namespace
NAME DATA AGE
kube-root-ca.crt 1 77m
mysql-configmap 1 56s
PS D:\tech\others>

4. To know current name-space
   `kubectl config get-contexts`
   PS D:\tech\others> kubectl config get-contexts
   CURRENT NAME CLUSTER AUTHINFO NAMESPACE

-         minikube   minikube   minikube   default

4. 1. Change active name-space
      PS D:\tech\others> kubectl config set-context --current --namespace=aj-namespace
      Context "minikube" modified.
      PS D:\tech\others> kubectl config get-contexts
      CURRENT NAME CLUSTER AUTHINFO NAMESPACE

-         minikube   minikube   minikube   aj-namespace

```yaml
--8<-- "docs/k8s/namespaces/mysql-namespace.yml"
```
