# DML
*LS180 SQL Fundamentals Exercises*

## 1. Set Up Database

### Challenge:

1. Create a database named `workshop`.

2. Create a table should be called `devices`. This table should have columns that meet the following specifications:
    - Includes a primary key called `id` that is auto-incrementing.
    - A column called `name`, that can contain a String. It cannot be NULL.
    - A column called `created_at` that lists the date this device was created. It should be of type timestamp and it should also have a default value related to when a device is created.

3. Make a table called `parts` that reflects the information listed above. Table `parts` should have the following columns that meet the following specifications:
    - An `id` which auto-increments and acts as the primary key
    - A `part_number`. This column should be unique and not null.
    - A foreign key column called `device_id`. This will be used to associate various parts with a device.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
CREATE DATABASE workshop;

CREATE TABLE devices (
    id serial PRIMARY KEY,
    name varchar(50) NOT NULL,
    created_at timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE parts (
    id serial PRIMARY KEY,
    part_number integer NOT NULL UNIQUE,
    device_id integer REFERENCES devices (id)
);
```
</details>
