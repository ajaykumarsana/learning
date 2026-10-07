Basic set up of 1 nod with 2 apps.
worker, server,nodes
1. each node has multiple application pods with containers running on that node.
2. 3 process must be installed in every node.
3. worker nodes does the actual work.
container run time should be installed in every node.
kublet interacts with both the container and node.
kubelet starts the pod with a container inside.

kubernetes cluster made of multiple nodes.

Node1
    web-app (State less - deployment - service1)
    Database (Statefull - stateFulSet -service2)
    coontainer run time ()
    kubelet( installed in `worker node`)
    kube proxy ( installed in `worker node`)

Node2
    web-app (State less - deployment - service1)
    Database(Statefull - stateFulSet -service2)
    coontainer run time()
    kubelet( installed in worker node)
    kube proxy ( installed in worker node)

Communication takes place with help of services.
kube proxy----
it should beinstalled in every node.
kubeProxy forwards the requests.

kubelet---

How do you interact with cluster.?

1. Schedule pod
2. monitor
3. re-schedule/re-start pod
4. join new node.
`Worker nodes need more resources.`


Master nodes, worker nodes has seperate responsibilities.
----------------------------------- Master -------------------------
<Master node / server has different process.>
k8s cluster may have multiple master nodes.
Master nodes occupy less storage, cpu , ram
4 process run on every master node.

1. API server 
    (cluster gateway)
    acts as a gatekeeper for authentication.
    UI client update/query
    it validate incoming client request and validate it then forwards for other process the interact with pod(schedule).
    with this, it become 1 entry point to the cluster so that secure.
2. Scheduler
    when you send a request to API server about scheduling pod it follows like below.
    schedule new pod request -> API server -> Scheduler -> where to put pod -> kubelet
    scheduler check storage of nodes and allocated the pods to nodes which is least busy / more storage.
    Scheduler decides on which node, new pod should be scheduled.
3. Controller manager
    Detects cluseter state changes i.e pods crash, pods die
    When it found, it recover pod
    Controller manager request -> Scheduler -> based on resource caclulation(node allocation) make request to kubelet-> restart pod

4. etcd
    it is considered as <cluster brain> becaue of the data it holds.
    when pod get's scheduled or dies those details stored as a <key value pair>
    Cluster changes are stored in this file.
    4. 1. how does api server know Is the cluster healthy?
    4. 2. how does scheduler know What resources are available?
    4. 3. how does caontroller manager know Did the cluster state change?
    All of these info stored in etcd
    Actual app data is not stored in etcd.


    ----------------------- add master/ node server------------
    a.  Get new bare server
    b. Install all the master/worker node processes
    c. add it to the cluster.








