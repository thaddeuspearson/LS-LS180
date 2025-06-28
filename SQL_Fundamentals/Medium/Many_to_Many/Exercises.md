# Many to Many
*LS180 SQL Fundamentals Exercises*

## 1. Set Up Database

### Challenge:

Initially, we need to create a `billing` database with a customers table and a services table. 

1. The `customers` table should include the following columns:
    - `id` is a unique numeric customer id that auto-increments and serves as a primary key for this table.
    - `name` is the customer's name. This value must be present in every record and may contain names of any length.
    - `payment_token` is a required unique 8-character string that consists of solely uppercase alphabetic letters. It identifies each customer's payment information with the payment processor the company uses.

2. The `services` table should include the following columns:
    - `id` is a unique numeric service id that auto-increments and serves as a primary key for this table.
    - `description` is the service description. This value must be present and may contain any text.
    - `price` is the annual service price. It must be present, must be greater than or equal to 0.00. The data type is numeric(10, 2)

3. Insert the following data:
    - Data for the `customers` table:
    
        ```sql
        id | name          | payment_token
        --------------------------------
        1  | Pat Johnson   | XHGOAHEQ
        2  | Nancy Monreal | JKWQPJKL
        3  | Lynn Blake    | KLZXWEEE
        4  | Chen Ke-Hua   | KWETYCVX
        5  | Scott Lakso   | UUEAPQPS
        6  | Jim Pornot    | XKJEYAZA
        ```

    - Data for the `services` Table:

        ```sql
        id | description         | price
        ---------------------------------
        1  | Unix Hosting        | 5.95
        2  | DNS                 | 4.95
        3  | Whois Registration  | 1.95
        4  | High Bandwidth      | 15.00
        5  | Business Support    | 250.00
        6  | Dedicated Hosting   | 50.00
        7  | Bulk Email          | 250.00
        8  | One-to-one Training | 999.00
        ```

4. Create a join table that associates customers with services and vice versa. 
    - The join table should have columns for both the services id and the customers id, as well as a primary key named id that auto-increments.

    - The customer id in this table should have the property that deleting the corresponding customer record from the customers table will automatically delete all rows from the join table that have that customer_id. Do not apply this same property to the service id.

    - Each combination of customer and service in the table should be unique. In other words, a customer shouldn't be listed as using a particular service more than once.

5. Enter some data in the join table that shows which services each customer uses as follows:
    - Pat Johnson uses Unix Hosting, DNS, and Whois Registration
    - Nancy Monreal doesn't have any active services
    - Lynn Blake uses Unix Hosting, DNS, Whois Registration, High Bandwidth, and Business Support
    - Chen Ke-Hua uses Unix Hosting and High Bandwidth
    - Scott Lakso uses Unix Hosting, DNS, and Dedicated Hosting
    - Jim Pornot uses Unix Hosting, Dedicated Hosting, and Bulk Email

### Solution:

<details><summary>Click to Reveal</summary>

```sql
CREATE DATABASE billing;

CREATE TABLE customers (
    id serial PRIMARY KEY,
    name text NOT NULL,
    payment_token char(8) NOT NULL UNIQUE CHECK (payment_token ~ '^[A-Z]{8}$')
);

CREATE TABLE services (
    id serial PRIMARY KEY,
    description text NOT NULL,
    price numeric(10, 2) CHECK (price >= 0.00)
);

INSERT INTO customers (name, payment_token) VALUES
    ('Pat Johnson', 'XHGOAHEQ'), ('Nancy Monreal', 'JKWQPJKL'),
    ('Lynn Blake', 'KLZXWEEE'), ('Chen Ke-Hua', 'KWETYCVX'),
    ('Scott Lakso', 'UUEAPQPS'), ('Jim Pornot', 'XKJEYAZA');

INSERT INTO services (description, price) VALUES
    ('Unix Hosting', 5.95), ('DNS', 4.95), ('Whois Registration', 1.95),
    ('High Bandwidth', 15.00), ('Business Support', 250.00),
    ('Dedicated Hosting', 50.00), ('Bulk Email', 250.00),
    ('One-to-one Training', 999.00);

CREATE TABLE customers_services (
    id serial PRIMARY KEY,
    customer_id integer REFERENCES customers (id) ON DELETE CASCADE NOT NULL,
    service_id integer REFERENCES services (id) NOT NULL,
    UNIQUE(customer_id, service_id)
);

INSERT INTO customers_services (customer_id, service_id) VALUES
    (1, 1), (1, 2), (1, 3), (3, 1), (3, 2), (3, 3), (3, 4), (3, 5), 
    (4, 1), (4, 4), (5, 1), (5, 2), (5, 6), (6, 1), (6, 6), (6, 7);
```
</details>

<br>

## 2. Get Customers With Services

### Challenge:

1. Write a query to retrieve the `customer` data for every customer who currently subscribes to at least one service.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT DISTINCT c.* 
FROM customers c JOIN customers_services cs ON c.id = cs.customer_id;
```
</details>

<br>

## Get Customers With No Services

### Challenge:

1. Write a query to retrieve the `customer` data for every customer who does not currently subscribe to any services.

2. Can you write a query that displays all customers with no services and all services that currently don't have any customers?

### Solution:

<details><summary>Click to Reveal</summary>

1. Customers without services:
    ```sql
    SELECT c.*
    FROM customers c 
        LEFT JOIN customers_services cs on c.id = cs.customer_id
    WHERE cs.service_id IS NULL; 
    ```

2. Customers without services and services without customers:
    ```sql
    SELECT c.*, s.*
    FROM customers c 
        LEFT JOIN customers_services cs on c.id = cs.customer_id
        FULL JOIN services s ON cs.service_id = s.id
    WHERE s.id IS NULL OR c.name IS NULL;
    ```

</details>

<br>

## Get Services With No Customers

### Challenge:

Using `RIGHT OUTER JOIN`, write a query to display a list of all services that are not currently in use.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT s.description
FROM customers_services cs 
    RIGHT JOIN services s ON cs.service_id = s.id
WHERE cs.customer_id IS NULL;
```
</details>

<br>

## Services for each Customer

### Challenge:

1. Write a query to display a list of all customer names together with a comma-separated list of the services they use. Your output should look like this:

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT c.name, string_agg(s.description, ', ')
FROM customers c
    LEFT JOIN customers_services cs ON c.id = cs.customer_id
    LEFT JOIN services s ON cs.service_id = s.id
GROUP BY c.id;
```
</details>

<br>
