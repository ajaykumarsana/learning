

Usually internet works in below.

User browsing client request -> Proxy server -> www(public internet) -> multiple servers

Proxy acts as a middleman.
    Sits between clients and the public internet

1. <Forward-Proxy:>
It is client-facing, sits in client network.
it serves the clients by forwarding their requests to public server.

Imagine a corporate company where employees with different systems will request multiple thousands of requests to internet. If sender send any malicious script which reaches internal network can create lot of damage to the network /  company by hacking.

So, To avoid this company will introduce proxy to safeguard malicous attacks.

Multiple computer users -> <forward-proxy> -> WWW
`Forward proxy` is a `guard of your company internal newtork`.
in simple: `company private internal net work -> proxy -> public network (WWW)`

This proxy has below features.
1. 1. <ACCESS-CONTROL:>block access to certain websites or restrict internet usage within a company.
1. 2. <Security:> Scan for any virus and block when public network sends content back to client.
1. 3. <Monitoring:> it could log employee web activity.
1. 4. <Caching-responses:> if same request coming from multiple other sources, proxy will send cahced local copy of data to the client -> To save bandwidth and speeds up content delivery to client

2. <Reverse-Proxy:>
Reverse proxy sits on server side.
It acts as an inermediatary for requests from clients, but primarly serves the server, sitting in front of multiple servers.
Handles incoming client requests and forward them to appropriate servers.

it works like below.
Multiple computer users with requests + forward proxy -> WWW -> <Reverse proxy> -> route to BE servers
it allows flexible routing with rules.
Reverse proxy has below features.
2. 1. <Load balancing:> handles incoming request and distributes to multiple Back end servers to balance load,
        This load balancing happens based on URL paths, request headers and cookies.
2. 2. <Security:> Filter requests for malicious activity before they reach server, Ensusre SSL encryption is enabled
2. 3. <cahing>
2. 4. <logging>
2. 5. <Session-Persitance> Ensure users are directed to same backe end server during a session

`NGINX is popular reverse proxy`

3. <Load balancer.>
Every cloud platoform has their load balancer.
Why do we need revers proxy when we have cloud load balancer...?

In reality we need both Cloud load balancer and revers proxy.

it works like below.

user with request(s) + <Forward proxy> -> Cloud load balancer-> <Revers proxy> -> rRoute to web servers
|<-----------PRIVATE NETWORK------------>    <Public sub net>    <-------------Private Sub net------------>

By having both CLB + revers proxy is 
- much more secure.
- scalable.

For ex : Traffic management for Micro service architecture.

Route requests to the appropriate micro services based on application sepecific login



---------------------------k8s cluster with micro service-----------------

user with requests -> AWS Load balancer -> <Ingress-controller> -> route to specif service -> serve from pod

AWS LB: Handles incoming requests from internet

<Ingress controller>:  It is Revers proxy for k8s.
    - Handles internal routing and security

-------------------------------- NGINX vs nod server ----------------------
Ng inx :
- High performance web server
- Reverse proxy forwarding request to appropriate BE server
- ideal for serving static content
- Handles security feature like SSL Termination
- Performance benefits: 

Nodejs + express:
- Express.js is a server framework for node js
- used for building dynamic web apps and APIs by defining route logic
- can be able to build custom middleware