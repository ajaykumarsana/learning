REST
Anatomy

- Application Programming Interface
- A set of rules & protocols that allow s/w apps to communicate each other
- it defines methods and data formats that application use to requst and recieve information.
- Enable them to interact and perform functions.
- Act as intermidediary, enables intereaction between developers and software systems.
- Request is , when a client invokes URL with specific End Point and `Method`.

  - when request is made, an API being called.
  - Some requests need specific Headers, Params and/or payload
  - Headers contain
    - meta data
    - content type
    - authorization keys/ token
  - It does contain Method
    - desired action which dictates what will be sent in request
  - contain Payload
  - Path params - embed in URL
  - query params - append at the end of URL

- When a API sends data / Error back to requester in jSON format is called Response.
  - Response contain Headers, statuscode, Body.
  - body contain either data or Error

URL

- Uniform Resource Locator
- Protocol://subdomain.second-levedomain.TOP_levelDOmain/<EndPoint>

Make a request

- Request is an outbound call from an application to a URL asking for data

# HTTP Method

- Rest full web services will use HTTP methods and client requests
- classify the kind of action that client is requesting of the server.
- common used methods
  - GET - read only - a `safe http method` i.e it does read only.
  - POST - used to create new resources - contains payloadd
  - PUT - update an existing resource - contains payloadd
  - PATCH - update partial piece of info i.e alter the data that is specified - contains payloadd
  - DELETE - remove data from server

# HTTP status codes

- restful web services use http status codes in server responses
- common status codes, 400 indicates client error, 500 indicates server error

  - 200 - OK succesful and request and response.
  - 401 - not authorized
  - 404 - not found
  - 500 - internal server
  - 503 - gateway time out

- API allows access to a system functionality to all developers.
- Business are shifting to `API-first approach`.
- API's are secure
- API's are integral part of microservice architectures, as they facilitate the communication between loosely coupled components.

# REST message

- messge refers back and forth communication via request and response
- every response body associated with status code.
- message is useful while debugging and testing rest API like confirmation of resource creation.

# REST api's are stateless.

- Statefullness

  - an API or webservice stores data from client on its own servers

- statelessness
  - not stored
  - server doesn't store any session or previous requests that made and also server treates each request is independent( idempotent)
  - client side send tokens to validate the user isntead server remember
  - API act as a bridge between DB and application
- REST architecture requires that client states is not stored on the server

# URI - Unifrom Resource Identifier

- URN - identifies a resource through unique and persistent name like books has ISBN
- URL - typical web address
- best practices
  - develop forward slashes with hierarchy
  - use plural nouns for branches
  - use -- for multiple words
  - use lower cases
  - no file extensions

# Diff between REST and SOAP

REST - Representational state transfer - is an architecture to develop web service

- allows data transfer in JSON XML and others.
  SOAP - simple object access protocol - standards are strict implementations and statefullness.
- server and client are closely connected.
- supports XML
- used when regulated data needs to be transferred

# Diff between REST and AJAX

AJAX - asynnchronus java script and XML.

- referes to making asynchronous web request
  REST may handle AJAx calls but REST can't be replaced by AJAX.

# tools to develop and test REST API

- depends on the language we used to build REST API.
- Node.js - Express framework / POSTman for testing.

# pros and cons

PRO

- Easy to learn
- wide range of data transfes like JSON and XML
- stateless ness
- scalability // due to independent nature of client

CONS

- session not able to maintain because of statelessness.
- lack of built -in security
- need to be versioned for backward compatibility.
- consistency in URI, difficult to maintain for complex projects.

# core components of http request

- method
- URI
- request header
- request body
- HTTP version 1.1 or 2.0

# core components of http response

- statuscode
- http version
- response header
- response body

# caching in REST ful

- each rest api contains specific meta data related to caching of responses
- headers of cache control and expires specify what responses may be cached by whom and how long
- Cache is used to save bandwidth and return the same response when request is same.
