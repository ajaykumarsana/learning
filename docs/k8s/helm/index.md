To package yml files and distribute them in public and private repos.

1. package manager for kubernetes
   Let's say a project has following

- statefulSet ( Database)
- configMap ( external configuration)
- secret ( to keep confidentail info)
- services
- K8s User permissoins

Every thing yml files and to test all of the yml files takes time.
It requires everyone(Team members or app developers) to test and run on their machine to access / run all of above.

So helm being a package manager does pack all of these yml files and store in internet as a bundle of ymls.
This bundle of ymls called as Heml Charts.

Helm Charts.

- Bundle of yml files
- Create your own helm charts with helm.
- Push them to Helm repository
- Download and use existing ones

Usually below of these used for Helm Charts due to its nature of complex setup.

- Database apps
  Mysql
  Mongo DB
  ElasticSearch
- Monitoring Apps
  Promotheus

So these charts will be available in Helm repo, adn these config can be reused.
Helm repo can be

- Public registries
- Private registries - Share in organisations.

2. Helm has `Templating Engine` feature.
   This is useful when as follows.
   When a k8s cluster is having multiple micro services, assume These micro service deployments and service yml have same set of configuratione except the name and version. Helm is useful for creating Template.

We can do above by

- Defining a common blueprint.
- Dynamic values are replaced by placeholders.
  Ex: {{.Values.continer.name}}
  These values are stores in values.yml file

So we can replace many yml files by one single yml using value placeholders.
NOTE : this is best used for CI / CD. In or Build we can replace the values on the fly.

3. Deploy same set up application across diff environments

4. release management

Helm version 2 comes in two parts.

- helm CLI
- SERVER (Tiller)
  When you run <helm install <chart-name>> in CLI, it sends request to Tiller
  - Tiller creates components

When ever user create or change a deployment by running a command in CLI, tiller stores copy of configuratoin.
Actualy changes are aplies to existing deployment instead of creating a new one.

There are few commands

- helm install <chart-name>
- helm upgrade <chart-name>
- helm rolback <chart-name>

There is downsides of Tiller

- Tiller has too much of power in k8s cluster.
  Create / DELETE / Update components
- Security issue ( because of which they removed in helm 3)

# Structure - Helm

Directory structue of helm.
nameOfChart/ - chart.yml // meta info about chart - values.yml //values for the template files
charts/ // has chart dependencies
templates/ // actual template files
readme.md
.license

    ...

helm install <chart-name>

usually values.yml contains as below, which is default values.

- imageName
- port
- version

we can override these default values.

helm install --values=<path of overidevalues> <chart-name>
helm install --set <property-name>=<value> // helm install --set version=2.0.0
