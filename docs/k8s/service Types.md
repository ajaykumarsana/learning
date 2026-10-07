As service is of kind `Service` in Config yml file.
it is one of the component that k8s offers
service also has ip address.
service is also accessibel at port.
service is acts as a load balancer when multiple pods of same service type exist


k8s cluster each pod has its own ip address.
    - These pods are destroyed frequently.
    - when pod dies new pod gets created but will have new IP address.
    - it not good approach to use pods ip address
    - so, `service` helps us to 
        - have static IP.
        - Load balancing
        - it is good abstraction for loose coupling with in cluster
        
`Typesc of services`
    - Cluster Ip services
    - Headless service

1. <Cluster Ip> - it is mostly used and default.
Assume we have micro service app deployed in cluster 
--------------------------------------------------

1. 1. We have a pod which is running on node 1
    - This pod has IP Run `kubectl get pod -o wide` , 10.*.1.*
    - so we have `micro service` app running in container of a pod with port `3000`
    - we have `side car` container which collects the logs of micro service on port `9000`

1. 2.  we have clone of node1 as node 2 with same set up.
 with IP : 10.*.2.*
NOTE : 1. 1. and 1.2. are created under a same service 

1. 3. Mongo db service with multiple nodes -> pods.

1. 4. <workflow>

When a request of accessing micro service app comes from browser -> will go through `Ingress` -> ingress request will be forwarded to pod through `service`( Cluster Ip - internal service) -> service will forward request to one of the pods that are registed -> pod will connect with mongo db `service`( Cluster Ip - internal service)

NOTE : In simple.

                                         | -  Node1 - pod - my-app
Browser request -> Ingress -> service ---
                                         | -  Node2 - pod - my-app -> Talk to mongo service (Cluster IP)


- Service will have pod's selector defined in its config so it knows which pod that request should forward. Here all pods will have same service
- Service will pick pods from above nodes randomely because service acts as a `load balancer`
`target port in service config` tells which port of pod to be targetted.
- When service is created, k8s creates end points to that.
    - Also k8s keeps track of end points of members who are part of that service.

-------------------------
2. Headless service

It is needed for following conditions
- When client wants to communicate with 1 specific pod directly.
- Pods want to talk directly with different specific pod.
 - XXX - random selection of pod may not happen
- So, Random selection of nodes/pod not possible
- UseCase : when we deploy stateful applications i.e databses.
    - While replicating multiple pods of same data bases, only one pod will act as master and rest are worker nodes.
    - In this case, client sends requests to master pod which can write to db
        - how does client know IP address of master pod.
         - 1. API call to k8s api server? // Draw back is app too tied to k8s API. in efficeint way.
         - 2. DNS look up
         DNS will look for service - returns single iP address which is (Cluster IP)
         when we set <clusterIP> as `None` in service config yml file, DNS will send IP address of pod. // `Headless service setting clusterIP as none`.
---------------------------
3. Service type attributes. // Service configuration.

in service configuration we can have 3 possible spec type.
 - ClusterIP // Default
 - NodePort //  not secure
 - LoadBalancer

NodePort service :-
it requires config nodePort under ports which is under spec of service config, it enables external request to be rached at nodePort which is static




 
