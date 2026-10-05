# views

- views are stored queris that gives results when invoked
- it is virtual table
- Below is the very big query which can be stored as view.
- syntax `create view <view_name> as <LONG_QUERY>`
- `create view full_review_series as select first_name, last_name, count(*) as count, ifnull(min(rating),0), ifnull(max(rating),0),ifnull(avg(rating),0), case when count(*) >1 then 'ACTIVE' else 'INACTIVE' end as STATUS from reviewers left join reviews on reviewers.id = reviews.reviewer_id group by first_name, last_name;`
- show tables // will show full_review_series;
- though it is virtual table few table operations can't be performed on view when below keywords are use
  - SUM, MIN, MAX, COUNT
  - DISTINCT
  - GROUP BY
  - sub query
  - joins
  - union

## Modify view

- you can do with two possibilities
  1- `CREATE or REPLACE view <view_name> AS <QUERY>`
  2- `ALTER VIEW <view_name> AS <QUERY>`

## drop view

- `drop view <view_name>`

# MODES - SQL

## view modes

- select @@GLOBAL.SQL_MODE;
- select @@SESSION.SQL_MODE;
- it is not safe to change mode for global but its okay to change session.
  `ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION`

## reset modes

- SET SESSION sql_mode =''
- SET SESSION sql_mode ='...list of modes you want'

## STRICT_TRANS_TABLES

- when this mode is set, we can't insert different data types into columns other than specied data types

## ONLY_FULL_GROUP_BY

- we have to use either aggregate columns or selectable columns in the group by clause
- When you use GROUP BY, every column in your SELECT list must meet one of two conditions:
  - It must be included in the GROUP BY clause.
  - It must be wrapped inside an aggregate function (like AVG(), MIN(), MAX(), or COUNT()).

## NO_ZERO_IN_DATE

- warns when 00 exist indate.

# Window functions

- window funtions peform aggregate operations on groups of rows
- They produce results on each row without applying filter or grouping.

## OVER() - PARTITION - BY

- this clause constructs a window. when its empty window considers all rows.

### over withempty params

- `select avg(salary) OVER() from employees ;`
- it calculates average aggregate function of all data
- but it would return `all the rows of a table` since it has `over()`

### rest others

- `mysql> select avg(salary) from employees ;` // it return only one row.
  +-------------+
  | avg(salary) |
  +-------------+
  | 68428.5714 |
  +-------------+
  1 row in set (0.206 sec)
- To make average by groupoing and print on each row.
  - `select emp_no,salary,department, avg(salary) OVER(partition by department),avg(salary) over() from employees;`
  - it does calclulate average by department wise also total average of table and produce value to each row.
  - it has 3 different departments so it prints one of the 3 average values on all 21 rows.

### ORDER BY

- this would to be applied on top of partition & By to make sure order by clause is applied on.
- `mysql> select *, sum(salary) over() as total_salary, sum(salary) over(partition by department) as depart_total_sal, sum(salary) over (partition by department order by salary desc) from employees;`
- `sum(salary) over() as total_salary` // Return total salary on each row
- `sum(salary) over(partition by department) as depart_total_sal` // return grouping by department sum
- `sum(salary) over (partition by department order by salary desc)` // return grouping by department in descending order of salary

## RANK

- returns the rank of current row within its partition
- ` select *, rank() over(partition by department order by salary) from employees;`
- this would give us rank with groping by department wise based on salary acending rank
- rank numbers always start from 1
- when values are same rank number will be same for no of records but the next entry is not immediate number, it will be the row count number
  - it skips ranks if values are same.

## ROW_NUMBER()

- it is used to differentiate rows with unique numbers when `rank numbers` are same.
- `row_number() over(partition by department order by salary) as row_num`

## DENSE_RANK()

- it gives the same rank for values of same combination with only change is immediate record is next available rank not the row number.
- it doesn't skip any ranks
- `dense_rank() over(order by salary)`

## NTILE(val)

- based on input it categorize into different buckets on the basis of over() passed.
- `ntile(10) over(order by salary) `
- it splits all data into 10 buckets based on the salary value.

## FIRST_VALUE(expr)

- returns the first value of the over() condition applied
- ` FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) as highest_paid_overall`

## LAST_VALUE(expr)

- returns the first value of the over() condition applied
- ` FIRST_VALUE(emp_no) OVER(ORDER BY salary DESC) as highest_paid_overall`

## nth_VALUE(expr,val)

- returns the first value of the over() condition applied
- ` nth_VALUE(emp_no) OVER(ORDER BY salary DESC) as highest_paid_overall`

## LAG, LEAD

- it is used to find the difference of lag, leading from previous row data.
- Lag returns previous row value where lead returns next row value.
- to make it more usefull we should apply on order value by any column.
- `lag(salary) over(order by salary), lead(salary) over(order by salary)`
- For better calculation use deduction or subtraction on ordered column.
- `salary - lag(salary) over(order by salary) as lag_salary,  salary - lead(salary) over(order by salary) lead_salary `

```sql
--8<-- "docs/mysql/9.sql"
```
