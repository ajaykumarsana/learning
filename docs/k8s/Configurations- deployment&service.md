-----------------------------k8s configuration-----------------------------
Each configuration file has 3 parts
1. metadata
2. specification
3. status // Status will be automatically added by k8s.


k8s has self healing mechanism, it validates desired spec with actual spec. If there is deviation between these two it self heals.
Status of current would come from etcd of master node() i.e brain of cluster.
cluster changes are stored in etcd (mentioned in 1.architecture.md )

-------------------------------------------------------------

Connecting Deployment to pods
    pod name label has to match with matchLabels of deployment
Connecting service to deployments
    service app name has to match with deployment app name & pod app name
pod to service
    pod container port has to match with service targetPort.

// connection has been established.

So when ever you create deployments and services... IP address of pods gets allocated to services


1. Run `kubectl apply -f kubernetes/nginx-dep.yml` // Create deployment
deployment.apps/nginx-dep created
PS D:\tech\others> kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
nginx-dep-687d5fb844-6r25r   1/1     Running   0          3s
nginx-dep-687d5fb844-fgr2n   1/1     Running   0          2s
PS D:\tech\others> kubectl get replicaset
NAME                   DESIRED   CURRENT   READY   AGE
nginx-dep-687d5fb844   2         2         2       6s
Create service
2. Run `kubectl apply -f kubernetes/nginx-service.yml` // Create servicess
PS D:\tech\others> kubectl apply -f kubernetes/nginx-service.yml
service/nginx-service created

Verify/get services 
3. Run `kubectl get service` // Get esrvices
PS D:\tech\others> kubectl get service 
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP   2d23h
nginx-service   ClusterIP   10.111.196.14   <none>        80/TCP    77s
PS D:\tech\others> kubectl get services
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes      ClusterIP   10.96.0.1       <none>        443/TCP   2d23h
nginx-service   ClusterIP   10.111.196.14   <none>        80/TCP    80s

There is a default service i.e kubernets always there
To know more about service.

4. Run `kubectl describe service <service_name>` // Describe service name to see ip address.

it has more info.


------------------------------------------------------

PS D:\tech\others> kubectl describe service nginx-service
Warning: v1 Endpoints is deprecated in v1.33+; use discovery.k8s.io/v1 EndpointSlice
Name:              nginx-service
Namespace:         default
Labels:            <none>
Annotations:       <none>
Selector:          app=nginx
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.111.196.14
IPs:               10.111.196.14
Port:              <unset>  80/TCP
TargetPort:        8080/TCP
Endpoints:         10.244.0.11:8080,10.244.0.12:8080
Session Affinity:  None
Events:            <none>
PS D:\tech\others> 
-----------------------------------------
Verify Ip address correctly mapped or not.

5. Run `kubectl get pods -o wide` // to know more info about pods.

PS D:\tech\others> kubectl get pods -o wide
NAME                         READY   STATUS    RESTARTS   AGE   IP            NODE       NOMINATED NODE   READINESS GATES
nginx-dep-687d5fb844-6r25r   1/1     Running   0          13m   10.244.0.11   minikube   <none>           <none>
nginx-dep-687d5fb844-fgr2n   1/1     Running   0          13m   10.244.0.12   minikube   <none>           <none>

NOTE : <IP address of 5 command has to match with ip address of 4th command>

6. To get the status of k8s configuratoin file.
Run `kubectl get deployment <deploy_ment-name> -o yaml`
PS D:\tech\others> kubectl get deployment nginx-dep -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"app":"nginx"},"name":"nginx-dep","namespace":"default"},"spec":{"replicas":2,"selector":{"matchLabels":{"app":"nginx"}},"template":{"metadata":{"labels":{"app":"nginx"}},"spec":{"containers":[{"image":"nginx:1.16","name":"nginx","ports":[{"containerPort":8080}]}]}}}}
  creationTimestamp: "2025-07-22T17:31:51Z"
  generation: 1
  labels:
    app: nginx
  name: nginx-dep
  namespace: default
  resourceVersion: "7622"
  uid: f81a2a7a-9e14-4d1a-83f5-50517d71e62e
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx
    spec:
      containers:
      - image: nginx:1.16
        imagePullPolicy: IfNotPresent
        name: nginx
        ports:
        - containerPort: 8080
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 2
  conditions:
  - lastTransitionTime: "2025-07-22T17:31:53Z"
    lastUpdateTime: "2025-07-22T17:31:53Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2025-07-22T17:31:51Z"
    lastUpdateTime: "2025-07-22T17:31:53Z"
    message: ReplicaSet "nginx-dep-687d5fb844" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 2
  replicas: 2
  updatedReplicas: 2
7. To store it into file.
PS D:\tech\others> kubectl get deployment nginx-dep -o yaml > kubernetes/nginx-dep-result-with-status-generated.yml

NOTE : This configuration of status is coming from etcd of cluster.

8. Delete deployments and services using yml commands.
8. 1. Run `kubectl delete -f .\kubernetes\nginx-dep.yml` To delete deployments
8. 2. Run `kubectl delete -f .\kubernetes\nginx-service.yml` to delete services


PS D:\tech\others> kubectl delete -f .\kubernetes\nginx-dep.yml
deployment.apps "nginx-dep" deleted
PS D:\tech\others> kubectl delete -f .\kubernetes\nginx-service.yml
service "nginx-service" deleted
verify services and deployments deletion
PS D:\tech\others> kubectl get service                             
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   3d
PS D:\tech\others> kubectl get deployment                          
No resources found in default namespace.