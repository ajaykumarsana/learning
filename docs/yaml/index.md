YAML
yet antoher mark up language.
It is human redable data serializatoin format
it is used for configuring files and for data <exchange between systems>.
It is easy to read and write.
It used indentation and colons to structure the data., it is very important to have indentation
<spaces reccommended over tabs, use multiple spaces for indentation, as a conventional use `two spaces`>
use #to write commands for descriptive text or hint, comments are ignored by YAML parser.
<Syntax:>
key: value
nested_key:

- item 1
- item 2
  YAML uses below data structures.

1. <Scalars> - key: value
   represents simple values like string,numbers,booleans and null.
   scalars doesn't have indentation, so it can be expressed directly.

For ex:

`string_key : 'String'
numeber_key: 33
boolean_key: true
null_key: null`

2. Lists
   lists are represented by - followed by space
   lists can contains any combination of scalars, other lists, or mappings(key-value)
   <For ex:>
   list_key:

- item 1
- item 2
  sub_list:
  - item 3
  - item 4
  - sub_item 1

3. Mappings
   mapping represents key:value pairs use : to sepreate
   mappings can be neted within each other

<for ex:>

key:
sub_key: value1
sub_key: 'value2'

diff between list and mapping is list has - but map has key:value pair

4. Multiline scalars
   if a scalar value spans into multiple lines use pipe | character to indicate a block scalar or > character to indicate folder scalar
   <for ex:>

multiline_key: |
This is a
multi line
scalar value

---

`NOTE : `
you can validate yaml syntax in yaml lint web , paste your code to validate.
spaces are very important
We can define multiple yml in single file with sepearation of `---`, so `---` will be treated as start of yml file

## .yml file

key: value
key2: value1

---

## doc2 : yes

doc3: file 3

yaml is human friendly data serialization standard for all programming languages.
syntax is strict indentation.

user yaml online validator to fix the issue.

Store the yaml config file with your code.( since these changes applies to your app whre code is resided)

```yaml
--8<-- "docs/yaml/example.yml"
```
