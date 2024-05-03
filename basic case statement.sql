-- In Oracle SQL, you can't reference a table in the outer query within a subquery without providing an alias for the outer query.
SELECT c.*,
       ROUND((c.stems_ordered - (SELECT AVG(stems_ordered) FROM customer_orders)), 2) AS avg_position,
       CASE 
           WHEN ROUND((c.stems_ordered - (SELECT AVG(stems_ordered) FROM customer_orders)), 2) > 0 THEN 'Above average'
           WHEN ROUND((c.stems_ordered - (SELECT AVG(stems_ordered) FROM customer_orders)), 2) = 0 THEN 'Normal'
           ELSE 'Below average'
       END AS rating
FROM customer_orders c;
