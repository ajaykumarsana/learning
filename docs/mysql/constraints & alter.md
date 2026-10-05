# UNIQUE

- it is to be applied at column level to make sure duplicate values are not entered.
- syntax `create table contacts( phoneno varchar(10) not null unique);`

# check constraints

- it is used to check the condition and inserts data if passed
- set at creating table at column level
- syntax `age INT CHECK (age > 0)`
- `CREATE TABLE users (`
  `username VARCHAR(20) NOT NULL,`
  `age INT CHECK (age > 0));`
- `tablename_1 check is failed`

# named constraints

- it is same as above with a diff of having name defined constraint failed in the error msg.
- syntax `CONSTRAINT age_not_negative CHECK (age >= 0) `
- `CREATE TABLE users2 (`
  ` username VARCHAR(20) NOT NULL,`
  ` age INT,`
  ` CONSTRAINT age_not_negative CHECK (age >= 0) );`

## multiple column constraints

- to have constraint like unique or logical at multiple columsn together.
- syntax `CONSTRAINT <name> CHECK ( col >= col2)`
- syntax `CONSTRAINT <name> UNIQUE ( col ,col2)`
- `CREATE TABLE houses (`
  `purchase_price INT NOT NULL,`
  `sale_price INT NOT NULL,`
  `CONSTRAINT sprice_gt_pprice CHECK(sale_price >= purchase_price));`

`

# Alter table

## add

- `alter table price add column item varchar(50) not null unique;`
- `alter table price add column quantity varchar(50) not null default 1;`

## change column def

- `alter table price change column item item varchar(20);`

## drop column

- ` alter table price drop column item;`

## rename column of a table

- `alter table prices rename column rate to rate_unit;`
- we can't rename a table using MODIFY constraint.

## modify column def

- it is used to change the defiinition of a column except renaming.
- ` alter table prices modify rate_unit decimal(4,2) not null;

## add constraint

- ` alter table price add constraint gt_nt_0 check(rate)>0;`

## drop cosntraint

- `alter table price drop constraint gt_nt_0;`

## rename table

- ` alter table price_list rename to prices;`

## drop/delete foreign key

- `alter table orders drop foreign key orders_ibfk_1`

## add foreign key

- `alter table orders add foreign key(customer_id) references customers(id) ON DELETE CASCADE;`
