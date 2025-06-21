# DML / DCL / DDL
*LS180 SQL Fundamentals Exercises*

## Part One

SQL consists of 3 different sublanguages. For example, one of these sublanguages is called the Data Control Language (DCL) component of SQL. It is used to control access to a database; it is responsible for defining the rights and roles granted to individual users. Common SQL DCL statements include:

```sql
GRANT
REVOKE
```
&nbsp;

**Name and define the remaining 2 sublanguages, and give at least 2 examples of each.**

1. `Data Manipulation Language` *(DML)* is used to retrieve and manipulate data within a relational database. Some example keywords include:

    ```sql
    SELECT
    UPDATE
    INSERT
    DELETE
    ```

1. `Data Definition Language` *(DDL)* is used to create and manipulate the schema of a relational database. Some example keywords include:

    ```sql
    CREATE
    ALTER
    DROP
    ```

&nbsp;


## Part Two

```sql
SELECT column_name FROM my_table;
```
&nbsp;

**Does the above statement use the Data Definition Language (DDL) or the Data Manipulation Language (DML) component of SQL?**

1. This is a clear example of DML, as a read operation (`SELECT`) is being used to retireve data from the table `my_table`and nothing is changing regarding the structure of the database.

&nbsp;


## Part Three

```sql
CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);
```
&nbsp;

**Does the above statement use the DDL or DML component of SQL?**

1. This is a clear example of the DDL sublanguage being used. THe `things` table will be created with the `CREATE` keyword. SInce this is altering the structure of the database, this is DDL.

&nbsp;


## Part Four

```sql
ALTER TABLE things
DROP CONSTRAINT things_item_key;
```

**Does the above statement use the DDL or DML component of SQL?**

1. Any use of the `ALTER` keyword is using the DDL sublanguage, as it is used to change the structure of the entity it is working on *(in this case, a table)*.


## Part Five

```sql
INSERT INTO things VALUES (3, 'Scissors', 'Metal');
```

**Does the above statement use the DDL or DML component of SQL?**

1. The `INSERT` keyword is responsible for putting data into table, which is a clear illustration of the DML component.

&nbsp;


## Part Six

```sql
UPDATE things
SET material = 'plastic'
WHERE item = 'Cup';
```
**Does the above statement use the DDL or DML component of SQL?**

1. `UPDATE` performs an aptly named update operation on data within a database. It does not update the structure at all. This indicates it is a part of the DML component of SQL.

&nbsp;


## Part Seven

```sql
\d things
```

**Does the above statement use the DDL, DML, or DCL component of SQL?**

1. This syntax is a psql meta-command, and it `describes` the `things` table, by printing out the table to the console. Since this command neither manipulates any data within the table, nor edits the table structure, it is neither DML, DDL, nor DCL.

&nbsp;


## Part Eight

```sql
DELETE FROM things WHERE item = 'Cup';
```

**Does the above statement use the DDL or DML component of SQL?**

1. The `DELETE` keyword will remove the filtered data from the `things` table, which is an example of DML. This is a delete operation, however, it is not impacting the structure of the database, only the data within it.

&nbsp;

## Part Nine

```sql
DROP DATABASE xyzzy;
```

**Does the above statement use the DDL or DML component of SQL?**

1. The `DROP` keyword performs a delete operation on the entire database provided as an argument. THis will not only delete all of the data, bt the entire structure of the database itself, meaning it is DDL. Since data cannot exist without the database, the data deletion is considered a side effect.

&nbsp;

## Part Ten

```sql
CREATE SEQUENCE part_number_sequence;
```

**Does the above statement use the DDL or DML component of SQL?**

1. The `CREATE` keyword alters the structure of the database, which means this is a statement using the DDL sublanguage.