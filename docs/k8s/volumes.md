persist data using k8s volumes.
There are 3 ways to do that.
- Persistent volume
- Persitent volume calim
- storage class


k8s doesn't give data persistence i.e when ever pod restarts db data is lost.
- So we need a storage that doesn't depend on pod life cycle.
- Storage must be available on all nodes.
- Storage needs to survive even if cluster crashes

1. Persistent volume.
- It is a cluster resource i.e placed inside a cluster
- it gets created via yml file.
- peristent volume is of kind `PersistentVolume` to be defined in yml file.
- spec(yml config) contains capactity -> Storage and other details.
    Depends on storage type spec attributes will differ.

PV needs a actual physical storage like below
- locak disk
- nfs server
- cloud storage
However, there are few things to know. Where does this storage come and who makes it available to cluster.
and type of storage we need, create /manage of self.
PV users.
`Usually k8s Admin sets up and maintains the cluster. so Admin decides which storage type to use, admin provisions storage resource`
`k8s user deploys app in cluster as a directory or thorugh CI pipeline -> user creates claim to PV`


any PV type is an external plugin to our k8s cluster. PV -> k8s 
PV are always available to whole cluster so it is not specific to Name spaces.
NOTE : `k8s cluster contains many name spaces.`

`PV are resource that need to be there BEFORE the pod that depends on it is created.`

Volumes are two types
- Local
    it violate 2 and 3 requirement for data persistence.
        - it is specific to 1 node
        - won't survive when cluster crashes
- Remote
    Data bases should be always kept in remote type PV.

2. Peristent volume claim.
Application has to claim the Persistent volume, These Applications are created by k8s users.
2. 1. Below is level of volume abstractoins
    - k8s cluster
        application pod inside cluster
            PV claim(`pod requests volume thorugh PVC claim`)
                Claim tries to find a volume in cluster
                connects volume which located outside of application but inside of cluster
                
                Now volume is mounted into the Pod.
            volume is mounted into container which is inside that pod
<NOTE : pod can contain multiple containers>

- This PVC also created thorugh yml files.
- it is of kind type to be specified in yml is `PersitentVolumeClaim`
- Use this created PVC in container pods configuration .yml file under sections `volumes -> persistentVolumeClaim`


-------------------------------------
Volume is directory with some data
volumes are accessible in containers which exist in pod
pod specifies what volumes to provide.


3. ConfigMap and Secret

These are local volumes
not created via PV / PVC
managed by k8s

Steps involved for the case of creating

- Create ConfigMap / Secret component
- Mount that into your pod / container

4. Storage Class

SC provisions PV dynamically when PVC claims it.
i.e create PV dynamically
SC has kind StorageClass.
SC config has provisioner Which tool to create / use PV i.e each Storage backend has provisioner.
also we configure parameters for storage we want to request for creating a PV.


So the flow is

- Pod claims storage via PVC
- PVC requests storage from SC
- SC creates PV that meets the needs of claim as mentioned in config