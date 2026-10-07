1. PS C:\Users\AjayChanduSuhas> kubectl get nodes
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   13m   v1.33.1

2. PS D:\tech\others> kubectl get pods 
No resources found in default namespace.
PS D:\tech\others> kubectl get pod 
No resources found in default namespace.
# to get services
PS D:\tech\others> kubectl get services
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   33m

-- no pods would be present at first, we should create them----

in k8s pods is very small unit.
when you do  `kubectl create -h`, you won't see pods available commands.
so , creating a pod refers to createing a deployment.
Deployment- abstraction over pods.

3. Create a pod(deployment)
`kubectl create deployment <NAME> --image=<image_name>`
PS D:\tech\others> kubectl create deployment nginx-dep --image=nginx
deployment.apps/nginx-dep created
<deployment has all info i.e blueprint to create pod>
<The above command will create 1 pod,1 replica>
it will fetch latest docker nginx image.

3. 1. as pod abstraction is deployment, it can be verified by checking deployment.
run `kubectl get deployment`
PS D:\tech\others> kubectl get deployment
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
nginx-dep   1/1     1            1           3m12s 

3. 1. 1. verify pod created or not.
run `kubectl get pod `
pod will have name <deployment_name-hashcode-podename>
 PS D:\tech\others> kubectl get pod     
NAME                      READY   STATUS    RESTARTS   AGE
nginx-dep-5879cc9-5httx   1/1     Running   0          2m10s
PS D:\tech\others> kubectl get pods    
NAME                      READY   STATUS    RESTARTS   AGE
nginx-dep-5879cc9-5httx   1/1     Running   0          2m17s
3. 1. 2. when you create a pod, it comes with replicaset too
Run `kubectl get replicaset`
PS D:\tech\others> kubectl get replicaset
NAME                DESIRED   CURRENT   READY   AGE
nginx-dep-5879cc9   1         1         1       8m15s

replica will have name <deployment_name-hashcode>

replicaset is managing the replicas of a pod.

3. 2. you can configure multiple replicas while creating a pod.
//// Layers of abstraction
nginx-dep.yml explained
# . Deployment manages replica set
# . replicaset manages all replicas of pod
# . pod is abstraction of a container.
# . Deployment manages Pods
4. Edit a deplooyment ( pods)
Run `kubectl edit deployment <deployment_name>`
it will open a editor with configuration of a deployment with default values.

make changes, i have made version change in image and save.

PS D:\tech\others> kubectl edit deployment nginx-dep
deployment.apps/nginx-dep edited

PS D:\tech\others> kubectl edit deployment nginx-dep
deployment.apps/nginx-dep edited
NAME                         READY   STATUS              RESTARTS   AGE
nginx-dep-579d65b68f-lrvq5   1/1     Running             0          86s
nginx-dep-767f689748-nsg7d   0/1     ContainerCreating   0          8s
PS D:\tech\others> kubectl get pod
NAME                         READY   STATUS              RESTARTS   AGE
nginx-dep-579d65b68f-lrvq5   1/1     Running             0          96s
nginx-dep-767f689748-nsg7d   0/1     ContainerCreating   0          18s
PS D:\tech\others> kubectl get pod
NAME                         READY   STATUS      RESTARTS   AGE
nginx-dep-579d65b68f-lrvq5   0/1     Completed   0          101s
nginx-dep-767f689748-nsg7d   1/1     Running     0          23s
PS D:\tech\others> kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
nginx-dep-767f689748-nsg7d   1/1     Running   0          28s

after i edit save (version change twice), old pod will complete and create a new pod. But replica set will maintain all sets.
That's the magic of kubernetes.

4. 1. PS D:\tech\others> kubectl get replicaset
NAME                   DESIRED   CURRENT   READY   AGE
nginx-dep-579d65b68f   0         0         0       3m24s
nginx-dep-5879cc9      0         0         0       23m
nginx-dep-767f689748   1         1         1       2m6s

5. to check logs of pod
usefull for debugging.
Run `kubectl logs <pod_name> `

PS D:\tech\others> kubectl logs nginx-dep-767f689748-nsg7d 
PS D:\tech\others> 

6. Describe pod or check complete info of pod.
Run `kubectl describe pod <pod_name>`
usefull for debugging.
<you can run this when you notice 0/1 as READY while getting pods>
PS D:\tech\others> kubectl logs nginx-dep-767f689748-nsg7d 
PS D:\tech\others> kubectl describe pod nginx-dep-767f689748-nsg7d                                 
Name:             nginx-dep-767f689748-nsg7d
Namespace:        default
Priority:         0
Service Account:  default
Node:             minikube/192.168.49.2
Start Time:       Sun, 20 Jul 2025 00:38:07 +0530
Labels:           app=nginx-dep
                  pod-template-hash=767f689748
Annotations:      <none>
Status:           Running
IP:               10.244.0.7
IPs:
  IP:           10.244.0.7
Controlled By:  ReplicaSet/nginx-dep-767f689748
Containers:
  nginx:
    Container ID:   docker://fd4dc9db169d0b4082e620da8f7939da4b1ed64cf82a41ed237804058d349df5
    Image:          nginx:1.17
    Image ID:       docker-pullable://nginx@sha256:6fff55753e3b34e36e24e37039ee9eae1fe38a6420d8ae16ef37c92d1eb26699
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 20 Jul 2025 00:38:29 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-8n2ll (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       True
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  7m2s   default-scheduler  Successfully assigned default/nginx-dep-767f689748-nsg7d to minikube
  Normal  Pulling    7m1s   kubelet            Pulling image "nginx:1.17"
  Normal  Pulled     6m41s  kubelet            Successfully pulled image "nginx:1.17" in 20.956s (20.956s including waiting). Image size: 126773960 bytes.
  Normal  Created    6m40s  kubelet            Created container: nginx
  Normal  Started    6m40s  kubelet            Started container nginx
PS D:\tech\others>

7. Get inside a pod.
Run `kubectl exec -it <POD_NAME> --bin/bash`
Ued for debugging.
with above we can go into application container(POD).
PS D:\tech\others> kubectl exec -it nginx-dep-767f689748-nsg7d -- bin/bash
root@nginx-dep-767f689748-nsg7d:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@nginx-dep-767f689748-nsg7d:/# cd /var/
root@nginx-dep-767f689748-nsg7d:/var# ls
backups  cache  lib  local  lock  log  mail  opt  run  spool  tmp
root@nginx-dep-767f689748-nsg7d:/var# exit
exit
PS D:\tech\others> 

8. Delete deployment
Run `kubectl delete deployment <deployment_name>`
PS D:\tech\others> kubectl get deployment
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
nginx-dep   1/1     1            1           36m
PS D:\tech\others> kubectl get pod       
NAME                         READY   STATUS    RESTARTS   AGE
nginx-dep-767f689748-nsg7d   1/1     Running   0          16m
PS D:\tech\others> kubectl get replicaset
NAME                   DESIRED   CURRENT   READY   AGE
nginx-dep-579d65b68f   0         0         0       17m
nginx-dep-5879cc9      0         0         0       37m
nginx-dep-767f689748   1         1         1       16m

PS D:\tech\others> kubectl delete deployment nginx-dep
deployment.apps "nginx-dep" deleted
PS D:\tech\others> kubectl get deployment
No resources found in default namespace.
PS D:\tech\others> kubectl get replicaset
No resources found in default namespace.
PS D:\tech\others> kubectl get pod
No resources found in default namespace.

<When you delete deplooyment,it will delete deployments, pods, replica sets>

`NOTE:`

Deployment // all CRUD will affect beneath the deployment set.
    REPLICASET
        POD

------------------------ In general there is lot of options required while creating a deployment-----
So to smoothen we use k8s config files.

9. Apply configuration.
Run `kubectl apply -f <config-file>.yml`
Create any configuration.yml file

PS D:\tech\others> kubectl apply -f kubernetes/nginx-dep.yml
deployment.apps/nginx-dep created
PS D:\tech\others> kubectl get deployment
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
nginx-dep   1/1     1            1           3s
PS D:\tech\others> kubectl get pod        
NAME                         READY   STATUS    RESTARTS   AGE
nginx-dep-7f65fcf556-nk52t   1/1     Running   0          7s
PS D:\tech\others> kubectl get replicaset 
NAME                   DESIRED   CURRENT   READY   AGE
nginx-dep-7f65fcf556   1         1         1       12s
PS D:\tech\others> 

NOTE : you can change config file and apply again.
<i had changed nginx-dep.yml file with replica value as 2>

9. 1. PS D:\tech\others> kubectl apply -f kubernetes/nginx-dep.yml
deployment.apps/nginx-dep configured
PS D:\tech\others> 
you can see 2 replicas , 2 pods running.
PS D:\tech\others> kubectl get replicaset
NAME                   DESIRED   CURRENT   READY   AGE
nginx-dep-7f65fcf556   2         2         2       5m25s
PS D:\tech\others> kubectl get pod
NAME                         READY   STATUS    RESTARTS   AGE
nginx-dep-7f65fcf556-fl6lr   1/1     Running   0          66s <NOTICE that new one is created after applying configuration>
nginx-dep-7f65fcf556-nk52t   1/1     Running   0          5m38s
PS D:\tech\others> kubectl get deployment
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
nginx-dep   2/2     2            2           5m43s

9. 2. delete deployment by using file.
Run `kubectl delete -f <config-file>.ymtl`
PS D:\tech\others> kubectl delete -f kubernetes/nginx-dep.yml
deployment.apps "nginx-dep" deleted
PS D:\tech\others> kubectl get nodes
NAME       STATUS   ROLES           AGE    VERSION
minikube   Ready    control-plane   103m   v1.33.1
PS D:\tech\others> kubectl get deployment
No resources found in default namespace.
PS D:\tech\others> kubectl get pod
No resources found in default namespace.
PS D:\tech\others> kubectl get replicaset
No resources found in default namespace.
PS D:\tech\others> 



