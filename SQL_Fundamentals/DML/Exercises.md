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

<br>

## 2. Insert Data for Parts and Devices

### Challenge:

1. Add in two different devices. One should be named, `"Accelerometer"`. The other should be named, `"Gyroscope"`.

2. The first device should have 3 parts _(this is grossly simplified)_. The second device should have 5 parts. The part numbers may be any number between 1 and 10000.

3. There should also be 3 parts that don't belong to any device yet.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
INSERT INTO devices (name) VALUES ('Accelerometer'), ('Gyroscope');

INSERT INTO parts (part_number, device_id) VALUES (1, 1), (2, 1), (3, 1), (10, 2), (11, 2), (12, 2), (13, 2), (14, 2);

INSERT INTO parts (part_number) VALUES (100), (200), (300);
```
</details>
