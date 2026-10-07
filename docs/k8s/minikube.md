Install hypervisor
Instal kubectl
Install minikube
Install dependent Microsoft visual C++ if required.

start minikube

IN my case virtualBox didn't work, so i had used docker as hypervisor.

1. PS C:\Users\AjayChanduSuhas> minikube version
minikube version: v1.36.0
commit: f8f52f5de11fc6ad8244afac475e1d0f96841df1-dirty


Run docker desktop. , it will take longer if it first time.
2. PS C:\Users\AjayChanduSuhas> minikube start --driver=docker ( hypervisor is docker)

 * minikube v1.36.0 on Microsoft Windows 11 Home Single Language 10.0.26100.4652 Build 26100.4652
* Using the docker driver based on user configuration
* Using Docker Desktop driver with root privileges
* Starting "minikube" primary control-plane node in "minikube" cluster
* Pulling base image v0.0.47 ...
    > gcr.io/k8s-minikube/kicbase...:  502.26 MiB / 502.26 MiB  100.00% 3.25 Mi
* Creating docker container (CPUs=2, Memory=4000MB) ...
! Failing to connect to https://registry.k8s.io/ from inside the minikube container
* To pull new external images, you may need to configure a proxy: https://minikube.sigs.k8s.io/docs/reference/networking/proxy/
* Preparing Kubernetes v1.33.1 on Docker 28.1.1 ...
  - Generating certificates and keys ...
  - Booting up control plane ...
  - Configuring RBAC rules ...
* Configuring bridge CNI (Container Networking Interface) ...
* Verifying Kubernetes components...
  - Using image gcr.io/k8s-minikube/storage-provisioner:v5
* Enabled addons: storage-provisioner, default-storageclass


3. PS C:\Users\AjayChanduSuhas> minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured

4. PS C:\Users\AjayChanduSuhas> minikube dashboard
* Enabling dashboard ...
  - Using image docker.io/kubernetesui/metrics-scraper:v1.0.8
  - Using image docker.io/kubernetesui/dashboard:v2.7.0
* Some dashboard features require the metrics-server addon. To enable all features please run:

        minikube addons enable metrics-server

* Verifying dashboard health ...
* Launching proxy ...
* Verifying proxy health ...
* Opening http://127.0.0.1:50952/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/ in your default browser...


5.  # to get nodes
PS C:\Users\AjayChanduSuhas> kubectl get nodes
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   13m   v1.33.1

6. # kubectl version
Client Version: v1.30.1
Kustomize Version: v5.0.4-0.20230601165947-6ce0bf390ce3
Server Version: v1.33.1

if you see both client server versions, that denotes minikube is correctly installed.

kubectl CLI -> is used to configure minikube cluster.

minikube CLI -> is used to start/delete cluster.


minikube comes with docker.