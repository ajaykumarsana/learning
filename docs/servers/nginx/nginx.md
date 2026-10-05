old days nginx was acting as web server which installed as a software of backend server.
Due to the demand of milliion request handling, we created multiple servers.
now, the problem which request to map which server.
There comes load balancer. i.e proxy server.
Proxy servers is intermediatry service that forward client request to other server.

Ciient requst -> NGINX LB(PROXY server) -> other backend severs



Nginx can act as a LB
 - distributes incomeing requests across multiple backend servers
 - This load balancing is one of the functinality of NGINX proxy
 - This can be done either least request or default round robin of distributing requests
 
Nginx is both
- 1. web server
- 2. proxy server.
    - 2. 1. Load balancing.
        - Forward clienet request to other back end servers
    - 2. 2. Caching // Core feature of NGINX proxy
        - When multiple of same request type comes server has send to send same response to multiple requests which increases load, now this caching is introduced to store copy of response and send to other multiple requests of same type.
        - Cache respons is used for frequently accessed resources.
        - copies stored temporarily to improve performance.
    - 2. 3. Security - By keeping one entry point
        - For a application like fb has hundreds of servers so we can't expose all of those servers to public to avoid cyber attack / hackers may get confidential info.
        - So, we keep one server that is publicly available to avoid attacks.
        - Doing this we achieve security, minimized exposure, centralized access control of servers, logging and monitoring
        - Security 1 proxy server (entry point) is efficient, securing that can be done in below ways

        2. 3. 1. <Encrypted communication.>
        NGinx can handle SSL/ TLS encryption and decription.
        - enable proxy server to accept HTTPS requests
        - Accept encrypted traffic
        - Deny non encrypted requests 

        FE /  BROWSER send encrypted message to -> proxy -> proxy will send that to web server( web server decrypts it self).

        In above even if attacker gets encrypted message they can't decrypt it.

    - 2. 4. <Compression>
        Nginx can compress the response.
        - To reduce bandwidth usage and improve load time
        - ngix can compress the heavy size data in both server and client for faster communication.

        Assume Netflix has millions subscribers who may want HD content from server , now our proxy server has send back thos HD vids to user machines.
        To trnasfer HD vids it takes lot of bandwidth usage, hence compress is needed.

    2. 5. <Segmentation> - sending response in chunks
        - Break the file into smaller chunks(video streaming)

-----------------------------------------------------
<Configuration>
How to configure Nginx as webserver or proxy server , how to configure caching and SSL etc in NGINX

- nginx configuration is specified in `nginx.conf` file and located in `etc/nginx/` folder
- using custom syntax comprising `directives` and `Blocks`

<web-server>

    server {
        listen 80;
        server_name localhost;

        # Serve static files
        location / {
            root /usr/share/nginx/html;   # Path to your static files which can be /var/www/example.com
            index index.html index.htm;
        }
    }
--------------------------
- NOTE: In above `location directive` defines how the server should process specific types of requests.
- specify the location whre does your files contains
--------------------------

<proxy> // Forward Traffic to other web servers

    server {
        listen 80;
        server_name localhost;

        # Serve static files
        location / {
            proxy_pass http://backend_server_ip_address:<PORT>;  # backend service or IP
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }

        # Example: Reverse proxy API requests
        location /api/ {
            proxy_pass http://backend_server_ip_address:<PORT>;  # backend service or IP
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }

-------------------------
We learnt to have https to safeguard our application from attackers.
we should use SSL which has to accept https requests only.
1. redirect all http requests to https
2. serve content over https with SSL/TLS configured
3. Load balancing
4. have cache

<SSL, accept https>
    server {
        listen 80;
        server_name dashboard.com www.dashboard.com;

        #1. Redirect all HTTP traffic to HTTPS
        return 301 https://$host$request_uri;
    }

    server {
        listen 443 ssl;
        server_name dashboard.com www.dashboard.com;

        #2. SSL configuration
        ssl_certificate     /etc/ssl/certs/dashboard.crt;
        ssl_certificate_key /etc/ssl/private/dashboard.key;

        ssl_protocols TLSv1.2 TLSv1.3;
        ssl_ciphers HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers on;

        # add headers
        add_header Strict-Transport-Security "max-age=31536000; includeSubDomains always;

        #...

        location / {
            proxy_pass http://backend_server_ip_address:<PORT>;  # backend service or IP
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
-------------------
<load balancing & cache>

In below all requests are proxied to `backend_servers_group` 
There are 3 instances of same app running.

http {
    #4
    proxy_cache_path /tmp/nginx_cache levels=1:2 keys_zone=my_cache:10m max_size=100m inactive=60m use_temp_path=off;
    #3.
    upstream backend_servers_group {
        server 192.168.1.101:8080; #service.example.com
        server 192.168.1.102:8080; #service.example2.com
        server 192.168.1.103:8080; #service.example3.com

        # Optional: Configure load balancing method
        # least_conn;  # least connections instead of default round robin
    }

    server {
        listen 80;
        server_name example.com;

        location / {
            #4
            proxy_cache my_cache;
            proxy_cache_valid 200 302 10m;  # Cache 200 and 302 responses for 10 mins
            proxy_cache_valid 404 1m;        # Cache 404 responses for 1 min
            proxy_cache_use_stale error timeout http_500 http_502 http_503 http_504;

            proxy_pass http://backend_servers_group # upstream name should be same here
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}



-------------------------
Apache comparison
----------------
Apache - Highly customizable and extensible, Good choice for dynamic content handling
Nginx - Faster and more light weight, suites for performance environment and serving static content and has easy configuration to set it