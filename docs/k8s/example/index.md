Browser request -> Mongo express external service -> mongo expess pod -> Internal service of mongo DB -> Mongo DB pod.

1. create mongo db deployment

If you're using sercrets then it must be created before deployments.
Then secrets to be referenced in deployment

1. 1. create a secret
      PS D:\tech\others\kubernetes> kubectl apply -f '.\6. example\6.1.mongo-service.yml'
      secret/mongodb-secret created

1. 2. provide secret ref in deployment.yml file

- name: MONGO_INITDB_ROOT_USERNAME
  # value: root // use this incase direct value instead of secret
  valueFrom:
  secretKeyRef:
  name: mongodb-secret
  key: mongo-root-username
- name: MONGO_INITDB_ROOT_PASSWORD
  # value: example
  valueFrom:
  secretKeyRef:
  name: mongodb-secret
  key: mongo-root-password

1. 3. Create a deployment file
      PS D:\tech\others\kubernetes> kubectl apply -f '.\6. example\6.1.mongodb.yml'
      deployment.apps/mongodb-deployment created
1. 3. 1. verify all items with below command.
         `kubectl get all` // it will dispay <pod,services,deployments and replicas>
         PS D:\tech\others\kubernetes> kubectl get all
         NAME READY STATUS RESTARTS AGE
         pod/mongodb-deployment-76979dbb78-77cbm 0/1 ContainerCreating 0 81s

NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
service/kubernetes ClusterIP 10.96.0.1 <none> 443/TCP 3d23h

NAME READY UP-TO-DATE AVAILABLE AGE
deployment.apps/mongodb-deployment 0/1 1 0 81s

NAME DESIRED CURRENT READY AGE
replicaset.apps/mongodb-deployment-76979dbb78 1 1 0 81s
verify the pod status
PS D:\tech\others\kubernetes> kubectl get pod
NAME READY STATUS RESTARTS AGE
mongodb-deployment-76979dbb78-77cbm 1/1 Running 0 10m

<if status is not shown as Running,run below command.>

Run `kubectl describe pod <pod_name>`

1. 4. Create deployment and service in one single file coz they belong together

Update service yml config in deployment.yml file.
apiVersion: v1
kind: Service
metadata:
name: mongodb-service
spec:
selector:
app: mongodb # to Connect to pod through label
ports: - protocol: TCP
port: 27017 #service port, this can be different
targetPort: 27017 #container port of deployment

1. 4. 1. apply the deployment.yml changes

PS D:\tech\others\kubernetes> kubectl apply -f '.\6. example\6.1.mongodb.yml'
deployment.apps/mongodb-deployment unchanged
service/mongodb-service created <only service is added to deployment.yml so rest is unchanged>

1. 4. 2. verify all to make sure services entry is appearing service.

Run `kubectl get all`

1. 4. 3. <verify whether service is mapped correctly  to contianer.>
1. 4. 3. 1. describe service first

PS D:\tech\others\kubernetes> kubectl describe service mongodb-service
Warning: v1 Endpoints is deprecated in v1.33+; use discovery.k8s.io/v1 EndpointSlice
Name: mongodb-service
Namespace: default
Labels: <none>
Annotations: <none>
Selector: app=mongodb
Type: ClusterIP
IP Family Policy: SingleStack
IP Families: IPv4
IP: 10.102.32.5
IPs: 10.102.32.5
Port: <unset> 27017/TCP
TargetPort: 27017/TCP
Endpoints: 10.244.0.16:27017
Session Affinity: None
Events: <none>

1. 4. 3. 2. get pods with ip name listed
            Run `kubectl get pod -o wide`

PS D:\tech\others\kubernetes> kubectl get pod -o wide
NAME READY STATUS RESTARTS AGE IP NODE NOMINATED NODE READINESS GATES
mongodb-deployment-77b9dd68cb-qng5p 1/1 Running 0 11m 10.244.0.16 minikube <none> <none>
`Note: IP address of pod and End point of service shold be same`

2. Configure mongo-express

If you're using configMap for creating deployments, you must create create configmap first.
so configmap can be referenced in deployment.
Config map - to Share same config across multiple pods

2. 1. Create a configmap

PS D:\tech\others\kubernetes> kubectl apply -f '.\6. example\6.2. mongo-configmap.yml'
configmap/mongodb-configmap created

2. 2. provide config ref in deployment.yml file in my case mongo-express.yml
      <Similar to secret map, difference is that configMapKeyRef> - name: ME_CONFIG_MONGODB_SERVER # value: anyvalue // use this incase direct value instead of secret
      valueFrom:
      configMapKeyRef:
      name: mongodb-configmap
      key: database_url

3. 3. Create deployment file for mongo-express.
      kubectl apply -f '.\6. example\6.2. mongo-configmap.yml'

PS D:\tech\others\kubernetes> kubectl get pod
NAME READY STATUS RESTARTS AGE
mongo-express-5dd87b9fcf-7pprc 0/1 ContainerCreating 0 9s
mongodb-deployment-77b9dd68cb-qng5p 1/1 Running 0 31m
takes time to pull image if it take longer run `kubectl describt pod <pod_name>`

PS D:\tech\others\kubernetes> kubectl get pod
NAME READY STATUS RESTARTS AGE
mongo-express-5dd87b9fcf-7pprc 1/1 Running 0 2m2s
mongodb-deployment-77b9dd68cb-qng5p 1/1 Running 0 33m
PS D:\tech\others\kubernetes> kubectl describe pod mongo-express-5dd87b9fcf-7pprc

To see logs : `kubectl logs <pod_name>` 2. 3. 1. to confirm whether mongo-express has started or not.

kubectl logs mongo-express-5dd87b9fcf-7pprc

you will see
Wed Jul 23 18:41:44 UTC 2025 retrying to connect to mongo:27017 (3/10)

Mongo Express server listening at http://0.0.0.0:8081
Server is open to allow connections from anyone (0.0.0.0)
basicAuth credentials are "admin:pass", it is recommended you change this in your config.js!

2. 4. Create mongo-express service in mongo-deployment file.
      make this service as external by using `type`// Assign service to external IP address, and accepts external requests.
      NOTE: but internal service also acts as load balancer.

apiVersion: v1
kind: Service
metadata:
name: mongo-express-service
spec:
selector:
app: mongo-express
type: LoadBalancer # makeing it as external service
ports: - protocol: TCP
port: 8081
targetPort: 8081 # continaer port should be same
nodePort: 30000 # port for external ip address, port that should be put into browser

NOTE : nodeport has range from 30000 ~ 32000 2. 4. 1. Create service now
PS D:\tech\others\kubernetes> kubectl apply -f '.\6. example\6.2. mongo-express.yml'
deployment.apps/mongo-express unchanged
service/mongo-express-service created 2. 4. 2. Get services to see loadblancer type ervice is crated or not
ClusetIP is internal service, which we created for mongodb-service. // Default
PS D:\tech\others\kubernetes> kubectl get service
NAME TYPE CLUSTER-IP EXTERNAL-IP PORT(S) AGE
kubernetes ClusterIP 10.96.0.1 <none> 443/TCP 4d
mongo-express-service LoadBalancer 10.97.69.32 <pending> 8081:30000/TCP 38s
mongodb-service ClusterIP 10.102.32.5 <none> 27017/TCP 39m

External service has both internal:external ports sepcified

2. 4. 3. Assign External IP for a service.
         Run `minikube service <name of service>`
         PS D:\tech\others\kubernetes> minikube service mongo-express-service
         |-----------|-----------------------|-------------|---------------------------|
         | NAMESPACE | NAME | TARGET PORT | URL |
         |-----------|-----------------------|-------------|---------------------------|
         | default | mongo-express-service | 8081 | http://192.168.49.2:30000 |
         |-----------|-----------------------|-------------|---------------------------|
         🏃 Starting tunnel for service mongo-express-service.
         |-----------|-----------------------|-------------|------------------------|
         | NAMESPACE | NAME | TARGET PORT | URL |
         |-----------|-----------------------|-------------|------------------------|
         | default | mongo-express-service | | http://127.0.0.1:55267 |
         |-----------|-----------------------|-------------|------------------------|
         🎉 Opening service default/mongo-express-service in default browser...
         ❗ Because you are using a Docker driver on windows, the terminal needs to be open to run it.

This will open a webpage.
login with admin/pass as default mongo express

When ever i add a data base in the url
Browser request (add database)-> Mongo express external service -> mongo expess pod -> Internal service of mongo DB -> Mongo DB pod.

you can get the mongo-express pod logs by doing some interaction with UI.

```yaml
--8<-- "docs/k8s/example/mongo-service.yml"
```

```yaml
--8<-- "docs/k8s/example/mongodb.yml"
```

```yaml
--8<-- "docs/k8s/example/mongo-configmap.yml"
```

```yaml
--8<-- "docs/k8s/example/mongo-express.yml"
```
