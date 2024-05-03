```markdown
# Oracle SQL Subquery Usage

When using subqueries in Oracle SQL, it's important to provide aliases for tables referenced in the outer query within the subquery. Failure to do so will result in an error.

## Example

```sql
SELECT c.*,
       ROUND((c.stems_ordered - (SELECT AVG(stems_ordered) FROM customer_orders)), 2) AS avg_position,
       CASE 
           WHEN ROUND((c.stems_ordered - (SELECT AVG(stems_ordered) FROM customer_orders)), 2) > 0 THEN 'Above average'
           WHEN ROUND((c.stems_ordered - (SELECT AVG(stems_ordered) FROM customer_orders)), 2) = 0 THEN 'Normal'
           ELSE 'Below average'
       END AS rating
FROM customer_orders c;
```

In the provided example, the table `customer_orders` is referenced within subqueries. To avoid errors, aliases (`c` in this case) are provided for the outer query's table.
``` 

This `readme.md` file provides an explanation of a SQL query involving subqueries in Oracle SQL. It highlights the necessity of providing aliases for tables referenced in the outer query within subqueries to avoid errors. An example query is provided along with an explanation.

```markdown
# Oracle SQL Query Explanation

This SQL query retrieves data from the `customer_orders` table, filtering records based on certain conditions, and grouping the results by week and crop_id. 

## Query

```sql
SELECT week,
       SUM(stems_ordered) AS total_stems,
       crop_id
FROM customer_orders
WHERE customer_id = 39 
  AND stems_ordered < 10000 
GROUP BY week, crop_id
HAVING SUM(stems_ordered) < 10000
ORDER BY week;
```

## Explanation

- **SELECT**: Specifies the columns to be retrieved in the result set.
  - `week`: Week column from the `customer_orders` table.
  - `SUM(stems_ordered) AS total_stems`: Calculates the total number of stems_ordered for each group of week and crop_id.
  - `crop_id`: Crop ID column from the `customer_orders` table.

- **FROM**: Specifies the table from which to retrieve data (`customer_orders`).

- **WHERE**: Filters rows based on specified conditions.
  - `customer_id = 39`: Limits results to rows where the customer_id is 39.
  - `stems_ordered < 10000`: Limits results to rows where the stems_ordered is less than 10000.

- **GROUP BY**: Groups the result set by specified columns (`week` and `crop_id`).
  
- **HAVING**: Filters groups based on aggregate conditions.
  - `SUM(stems_ordered) < 10000`: Only includes groups where the sum of stems_ordered is less than 10000.

- **ORDER BY**: Sorts the result set by the specified column (`week`) in ascending order.

This query retrieves the total number of stems_ordered for each week and crop_id combination, where the customer_id is 39 and the total stems_ordered is less than 10000 for each group, ordered by week.
``` 

```markdown
# Oracle-Style Outer Join Syntax vs. Standard SQL Join Syntax

This document compares two SQL queries written in different syntax styles: Oracle-style outer join syntax and standard SQL join syntax. Both queries achieve the same result but are expressed differently.

## Oracle-Style Outer Join Syntax

```sql
SELECT "date", customer, crop, country, stems_ordered
FROM customers c, customer_orders co, countries cn, crops cr
WHERE c.customer_id = co.customer_id(+) 
AND c.country_id = cn.country_id(+) 
AND co.crop_id = cr.crop_id(+);
```

## Standard SQL Join Syntax

```sql
SELECT co."date", c.customer, cr.crop, cn.country, co.stems_ordered
FROM customers c
LEFT JOIN customer_orders co ON c.customer_id = co.customer_id
LEFT JOIN countries cn ON c.country_id = cn.country_id
LEFT JOIN crops cr ON co.crop_id = cr.crop_id;
```

## Comparison

### Oracle-Style Outer Join Syntax

- Uses `(+)` to denote outer joins.
- Tables are listed in the `FROM` clause separated by commas.
- Conditions for joining tables are specified in the `WHERE` clause.

### Standard SQL Join Syntax

- Uses `LEFT JOIN` to denote outer joins.
- Tables are joined explicitly using the `LEFT JOIN` keyword.
- Join conditions are specified in the `ON` clause.

Both queries achieve the same result, but the syntax and readability differ. The standard SQL join syntax is more explicit and aligns with ANSI SQL standards, making it more portable across different database systems. On the other hand, the Oracle-style syntax may be preferred by users accustomed to Oracle databases or for maintaining compatibility with legacy code.
```

```markdown
# SQL Query Comparison

This document compares three SQL queries that retrieve data from the `customer_contracts` table, filtering records where the contracted_stems are greater than 25000, and selecting the top 10 records based on the contracted_stems.

## Query 1

```sql
SELECT contracted_stems, crop_id
FROM customer_contracts 
WHERE contracted_stems > 25000 
ORDER BY contracted_stems DESC
FETCH FIRST 10 ROWS ONLY;
```

## Query 2

```sql
SELECT *
FROM (
    SELECT contracted_stems, crop_id
    FROM customer_contracts
    WHERE contracted_stems > 25000
    ORDER BY contracted_stems DESC
)
WHERE ROWNUM <= 10;
```

## Query 3

```sql
WITH a AS (
    SELECT contracted_stems, crop_id
    FROM customer_contracts
    WHERE contracted_stems > 25000
    ORDER BY contracted_stems DESC
)
SELECT * FROM a
WHERE ROWNUM <= 10;
```

## Comparison

- **Query 1**: Uses the `FETCH FIRST` clause to limit the result set to the first 10 rows after ordering by contracted_stems.
- **Query 2**: Utilizes a subquery to first select rows with contracted_stems greater than 25000, orders them, and then applies `ROWNUM` filtering to limit to the top 10 rows.
- **Query 3**: Utilizes a Common Table Expression (CTE) to define the result set with contracted_stems greater than 25000 and orders it. Then, applies `ROWNUM` filtering to limit to the top 10 rows.

All three queries achieve the same result, selecting the top 10 rows from `customer_contracts` where the contracted_stems are greater than 25000, but they use different syntax constructs (FETCH FIRST, subquery, CTE) to achieve the same outcome.
```
```markdown
# Oracle-Style RIGHT Outer Join Syntax vs. Standard SQL Join Syntax

This document compares two SQL queries written in different syntax styles: Oracle-style RIGHT outer join syntax and standard SQL join syntax. Both queries achieve the same result but are expressed differently.

## Oracle-Style RIGHT Outer Join Syntax

```sql
SELECT "date", customer, crop, country, stems_ordered
FROM customers c, customer_orders co, countries cn, crops cr
WHERE c.customer_id(+) = co.customer_id
AND c.country_id(+) = cn.country_id
AND co.crop_id(+) = cr.crop_id;
```

## Standard SQL Join Syntax

```sql
SELECT co."date", c.customer, cr.crop, cn.country, co.stems_ordered
FROM customers c
RIGHT JOIN customer_orders co ON c.customer_id = co.customer_id
RIGHT JOIN countries cn ON c.country_id = cn.country_id
RIGHT JOIN crops cr ON co.crop_id = cr.crop_id;
```

## Comparison

### Oracle-Style RIGHT Outer Join Syntax

- Uses `(+)` to denote outer joins.
- Tables are listed in the `FROM` clause separated by commas.
- Join conditions and outer joins are specified in the `WHERE` clause.

### Standard SQL Join Syntax

- Uses `RIGHT JOIN` to denote outer joins.
- Tables are joined explicitly using the `RIGHT JOIN` keyword.
- Join conditions are specified in the `ON` clause.

Both queries achieve the same result, but the syntax and readability differ. The standard SQL join syntax is more explicit and aligns with ANSI SQL standards, making it more portable across different database systems. On the other hand, the Oracle-style syntax may be preferred by users accustomed to Oracle databases or for maintaining compatibility with legacy code.
```