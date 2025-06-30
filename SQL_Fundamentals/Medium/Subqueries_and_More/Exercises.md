# Subqueries and More
*LS180 SQL Fundamentals Exercises*

## 1. Set Up Database

### Challenge:

Create a new database called `auction`. In this database there will be three tables, `bidders`, `items`, and `bids`.

1. `bidders`
    - `id` of type SERIAL: this should be a primary key
    - `name` of type text: this should be NOT NULL

2. `items`
    - `id` of type SERIAL: this should be a primary key
    - `name` of type text: this should be NOT NULL
    - `initial_price` and `sales_price`: These two columns should both be of type numeric. Each column should be able to hold a positive number as high as 1000 dollars with 2 decimal points of precision.
        - The `initial_price` represents the starting price of an item when it is first put up for auction. This column should never be NULL.
        - The `sales_price` represents the final price at which the item was sold. This column may be NULL, as it is possible to have an item that was never sold off.

3. `bids`
    - `id` of type SERIAL: this should be a primary key
    - `bidder_id`, `item_id`: These will be of type integer and should not be NULL. This table connects a bidder with an item and each row represents an individual bid. 
        - There should never be a row that has bidder_id or item_id unknown or NULL. 
        - Nor should there ever be a bid that references a nonexistent item or bidder.
        - If the item or bidder associated with a bid is removed, that bid should also be removed from the database.
        - Create your bids table so that both bidder_id and item_id together form a composite index for faster lookup.
    - `amount`: The amount of money placed for each individual bid by a bidder. This column should be of the same type as items.initial_price and have the same constraints.

4. Finally, use the \copy meta-command to import the below files into your auction database. You'll have to create these files yourself before you can import them with \copy.

- `bidders.csv`
- `items.csv`
- `bids.csv`

### Solution:

<details><summary>Click to Reveal</summary>

1. Create the relations
```sql
CREATE DATABASE auction;

CREATE TABLE bidders (
    id serial PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE items (
    id serial PRIMARY KEY,
    name text NOT NULL,
    initial_price numeric(6,2) NOT NULL CHECK (initial_price BETWEEN 0.01 AND 1000.00),
    sales_price numeric(6,2) CHECK (sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
    id serial PRIMARY KEY,
    bidder_id integer NOT NULL REFERENCES bidders(id) ON DELETE CASCADE,
    item_id integer NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    amount numeric(6,2) NOT NULL CHECK (amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);
```

2. Copy the data
```
\copy bidders FROM 'bidders.csv' WITH HEADER CSV

\copy items FROM 'items.csv' WITH HEADER CSV

\copy bids FROM 'bids.csv' WITH HEADER CSV
```
</details>

<br>

## 2. Conditional Subqueries: IN

### Challenge:

Write a SQL query that shows all items that have had bids put on them. Use the logical operator IN for this exercise, as well as a subquery.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT i.name AS "Bid on Items"
FROM items i 
WHERE i.id IN (
    SELECT DISTINCT item_id FROM bids
);
```
</details>

<br>

## 3. Conditional Subqueries: NOT IN

### Challenge:

Write a SQL query that shows all items that have not had bids put on them. Use the logical operator NOT IN for this exercise, as well as a subquery.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT i.name AS "Not Bid On"
FROM items i
WHERE i.id NOT IN (
    SELECT item_id FROM bids
);
```
</details>

<br>

## 4. Conditional Subqueries: EXISTS

### Challenge:

Write a SELECT query that returns a list of names of everyone who has bid in the auction. While it is possible (and perhaps easier) to do this with a JOIN clause, we're going to do things differently: use a subquery with the EXISTS clause instead.

### Solution:

<details><summary>Click to Reveal</summary>

1. Using a subquery:
    ```sql
    SELECT b.name
    FROM bidders b
    WHERE EXISTS (
        SELECT 1 FROM bids WHERE bids.bidder_id = b.id
    );
    ```
2. Using a JOIN:
    ```sql
    SELECT name
    FROM bidders b JOIN bids ON b.id = bids.bidder_id
    GROUP BY b.id
    ORDER BY b.id;
    ```
</details>

<br>

## 5. Query From a Transient Table

### Challenge:

Write an SQL query that finds the largest number of bids from an individual bidder.

For this exercise, you must use a subquery to generate a result table _(or transient table)_, and then query that table for the largest number of bids.

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT MAX(bid_counts.count)
FROM (
    SELECT count(bidder_id)
    FROM bids
    GROUP BY bidder_id
) AS bid_counts;
```
</details>

<br>

## 6. Scalar Subqueries

### Challenge:

For this exercise, use a scalar subquery to determine the number of bids on each item. The entire query should return a table that has the name of each item along with the number of bids on an item.

### Solution:

<details><summary>Click to Reveal</summary>

1. Using a Scalar Subquery
```sql
SELECT name, (
    SELECT count(item_id)
    FROM bids
    WHERE item_id = i.id)
FROM items i;
```
2. Using a LEFT JOIN
```sql
SELECT i.name, count(item_id)
FROM items i 
    LEFT JOIN bids b ON b.item_id = i.id
GROUP BY i.id
ORDER BY i.id;
```
</details>

<br>

## 7. Row Comparison

### Challenge:

Write an SQL query that will display the id for the item that matches all of the data that we know, but does not use the AND keyword. Here is the data we know:

`'Painting', 100.00, 250.00`

### Solution:

<details><summary>Click to Reveal</summary>

```sql
SELECT id 
FROM items i 
WHERE (
    ROW(i.name, i.initial_price, i.sales_price) =
    ROW('Painting', 100.00, 250.00)
);
```
</details>

## 8. EXPLAIN

### Challenge:

Use EXPLAIN to check the efficiency of the query statement we used in the exercise on EXISTS:

```sql
 SELECT b.name
    FROM bidders b
    WHERE EXISTS (
        SELECT 1 FROM bids WHERE bids.bidder_id = b.id
    );
```

First use just EXPLAIN, then include the ANALYZE option as well.

### Solution:

<details><summary>Click to Reveal</summary>

1. `EXPLAIN`:
    ```sql
    EXPLAIN SELECT b.name
    FROM bidders b
    WHERE EXISTS (
        SELECT 1 FROM bids WHERE bids.bidder_id = b.id
    );
    ```

2. `EXPLAIN ANALYZE`
    ```sql
    EXPLAIN ANALYZE SELECT b.name
    FROM bidders b
    WHERE EXISTS (
        SELECT 1 FROM bids WHERE bids.bidder_id = b.id
    );
    ```
</details>

<br>

