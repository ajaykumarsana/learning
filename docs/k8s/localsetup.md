Production cluster setup.
------------------------

In general production set up has 2 master nodes.
Multiple worker nodes more than master nodes.
Master nodes, worker nodes creatd in one single node.

minikube
    Creates virtual box on your machine.
    Node runs in that virtual box.
    it is 1 node k8s cluster.
    it is used for testing purposes.
    it runs both master and worker processes in one single node.
    cluster set up
minikube has kubectl dependency.
kubectl - kubernetes-cli
To test on local env.
we need a tool to interact with cluster.
Kubectl.
    command line tool for k8s cluster.
    we can create other components of k8s with help of kubectl
    create components can be performed
    and delete components too
    create services
    it is used for both
        minikube cluster
        Cloud cluster
    


