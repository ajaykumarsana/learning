Data base trigger is a set of SQL statements that are automatically run when a specific table is changed.
It basically contain below

- trigger_time
  - BEFORE
  - AFTER
- trigger_event
  - INSERT
  - UPDATE
  - DELETE
- table_name

  - <table_name>

- DELIMETER <any character>
  - this will set <any character> as delimeter instead of usual `;` of mysql which is end of query.
- For using triggers we should use delimeter as it has mulitple if , end, then and so on... So Having unique delimeter helps in writing multi line triggers

# syntax

```
Delimeter @@
create trigger <trigger_name>
 <trigger_time> <trigger_event> on <table_name> for each row
 BEGIN
 <!-- if
 then
 signal sql_state
 set message
 end if; -->
 <!-- INSERT into table (col1,col2) values(<val1>,<val2>) -->
 END;
@@
delimeter ;
```

# Example

```
Delimeter @@
create trigger min_18
  BEFORE INSERT on people for each row
  BEGIN
    if NEW.age < 18
    THEN
      SIGNAL SQL_STATE '45000'
      SET MESSAGE_TXT= 'age didn't qualify';
    END if;
  END;
@@
delimeter ;
```

# listing triggers

- show triggers;

# remove trigger

- drop trigger <trigger_name>
