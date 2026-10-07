Directory structue of helm.
nameOfChart/
    - chart.yml // meta info about chart
    - values.yml //values for the template files
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