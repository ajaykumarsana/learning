# usage:

{==Apache Kafka==} is a distributed event streaming platform designed to handle high-throughput, fault-tolerant data streaming and message processing. It allows systems to produce, store, and consume streams of events in real-time, making it ideal for building data pipelines and event-driven architectures. Kafka is widely used for use cases like real-time analytics, log aggregation, and microservice communication.

# Kafka

- Is a mail delivery service.
- It is highly scalable system for managing event logs.
- It has producers
  - Producers are those services that publish (write) event to kafka.
- kafka has topics
  - it is a type of categorizing
- it has consumers
  - consumers are those that subscribe to the event sent by produces
  - consumers can generate event to the topic
- kakfa has a mechanism of generating chain of events
- It has real-time processing (Stream API).
- kafka partitions
- kafka brokers
- consumer grouping
- Zookeeper

when we read/ write data to kafka , we do this in form of events.
This event contains - Key, value, Time stamp, meta data.

------------------------------------------ Kafka vs Databse -----------------------------

## It is not a replace for databse, but it is event streamng platform for higher throughput.

Imagine we build ecommerce application called streamStore.

we have multiple micro services deals with

- Payments
- Inventory
  update stock in data base
- Users
- Orders
- Notifications
- Analytics

when customer places a order , it does following

- check stock
- accept payment
- confirmation
- track the order
  i.e order is tighlty couples with various other services.
  Each service directly calls another service.
  Example : when payment service goes down entire process is disrupted.
  analytics can't record data

When our architecture is tightly couples with each other services and requests are coming in millions which leads to application crash.

To avoid potential failures like this, kafka is introudced.

`For Ex:`
Order placed, the sequence of actions goes as below.

1. (Producer- generate event record on purchase sends to kafka, it doesn't wait for the response)

2. KAFKA has order topic in it, order topic will write these data 2. 1. When ever is inventory is update / payment is failed / order is placed / and other event had happend All of these `events` will be stored in kafka giant bucket. 2. 2. These events are organised and durably stored in `topics`, Topics are of categories to which records are published.

3. Kafka will notify the consumers (basically micro services) which are subscribed to the events 3. 1. Kafka actions can be for the step 3 is - update stock / sending notification to customer / update sale status 3. 2. These actions are called consumers which are subscribed to Order Topic. 3. 3. Notification service will send a email to customer and department head 3. 4. inventory service will update data base by updating stock. 3. 4. 1. {==invenetory service will Geneare event and add to inventory topic ==} 3. 4. 1. 1. inventory topic will notify the alert service - send alert to re-stock topic about low stock - re-stock topic will notify the inventory re-stock service 3. 5. payment service Genearate invoice and send invoice to customer

in above example all orders `details will store in order topics` similarly for `payments in payments topic` and `inventory (stock) updation event will store in inventory topic`.

Kafka producer -> topic -> Kafka consumer

After introducing Reak time processing(Streams).

Kafka producer -> Order topic -> [`(input ->) Kafka streams App (-> processed data)` ]-> Sales topic -> Kakfa consumer

# Kafka Streams API

- The Streams API allows you to create real-time apps by continuously transorming and analysing incoming data streams.
- contineous flow of recods(key,value pairs)
- provides high level computation functions to process event streams, like transformations and stateful operations
  - counts, averages, suma and joins
- Transforming the input streams into output streams.
- streams API is a library embed in app to perform stream processing.

# kafka partitions - For Scalability and Performance.

It is introduced to support handling of huge data, imagine a app with million users and reciepents has stream of events getting generated to topic there is a need of scale up of system.

Events with the same key are written to the same partition.

- Scalability
  - Distributes data across mulitple kafka brokers
- Paralellism
  - Allow concurrent message processing
- Ordering
  - Guarantees order within partition
- Fault Tolerance
  - Replication and leader failover
- Logical Grouping
  - Groups related data for efficient processing.

# Consumer Groups

when few topic has millions of events coming in from producer and kafka sends notification to same consumer with millions of events , consumer can't handle full load.
So we introduce a concept of replicating consumer with help of k8s as a consumer group with a predined groupID, now millions of event will be distributed to consumers in group.

- Kafka distributes load automatically by assigning partitions to consumers

Where does all these data saved?

# Kafka Brokers

Data in topics saved on kafka servers called brokers.

- it is a Server that stores data in topics, manages message distribution to consumers.
- Fault Tolerance
  - Topics partitions are distributed across multiple brokers
  - Each partition has a leader broker and mulitple replicas

Note :
Stores messages on disk for a `configuratble retention period`, retain data.
Benefit of data retention is Real time data processing.
Consumer can read when ever needed
Replay of messages, debugging historical data

---

# zoo keeper

Kafka needs to track below with help of zookeeper to track below

- Each kafka has a leader broker
- facilitates election of the leader broker
- Maintain registry of all active brokers in the cluster

- zookeepr is a centralized service for managing meta data and cordination tasks for distributed system ( brokers)
- External dependecy - apache zookeeper
- kafka 3.0 removed zookeepr but introduced KRaft
  - Metadata is managed natively with in kafka brokers
