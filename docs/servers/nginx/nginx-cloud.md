Cloud Platform Load balancer.
AWS, GCP and etc.

Nginx Ingress controller acts as a load balancer inside K8 cluster
Can't be accessible publicly.

Cloud LB handles incoming requests from internet.



User with browser request -> cloud LB -> Ingress controller(NGINX) -> route to k8s service -> route to defined pod based on host and path matching

