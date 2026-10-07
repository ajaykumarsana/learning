StatefulSet is a k8s component used for stateful apps.
stateful application are databases
    - mysql
    - mongodbb
    - es
stateless applications are those which don't keep record of state.
    - Each request is completely new - isolated interaction

----------------
Deployment---
stateless applications are deployed using `Deployment` which allows to replicate apps in pods

stateful applications are deployed using `StatefulSet` which allows to replicate apps in pods/

Both mange pods based on container spec and configurate the storage in same way.

----------------- Deployment vs StatefulSet ---------------------------
StatefulSet names will have fixed set id + name where as deployment will have random hash code.

replicationg stateful apps is more difficult.

As stateful applications as perstent id which not possible to interchange.
Assume if we allow mysql to 3 replicas ( SCALE up) and all of the pods give read / write access it would lead to data inconsistancy.
So to fix the issue.
We should allow only one 1 mysql pods to perorm READ and WRITE and other pods are only for READ.
- That one pod called Master and other pods called Worker Nodes.
- As there is a chance that each pod of mysql can point to different PV (storge), it does contineous sync from master to keep data up to date.
- So we should do data contineous sync between different pods of same db replica pods.

NOTE : we can lose the data when all pods die. cluster crashes.

we should do data persisteance for state full apps.
In persistance storage data will reamin despite pod live status.
 - Perstent volume lifecycle isn't tied with toher component life cycle so data will survice despite pod dies.
it is better to use remote storage for data persistance.

in StatefulSet 
    - when we create replicas -> it will start creating replica only after the first (master) pod is created.
    - if we try to delete it -> Deletion starts from last pod created.
    - There is a service name for each statefull apps /pod.
        - Which will be controlled by load balancer.
    - When ever pod restarts its name and end point remain same but ip address will changes.

    - StatefulApps not perfect for containerized environments.

