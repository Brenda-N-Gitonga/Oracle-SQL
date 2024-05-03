-- Oracle-style outer join syntax
select "date",customer,crop,country,stems_ordered
from 
customers c ,
customer_orders co,
countries cn,
crops cr
 where 
c.customer_id = co.customer_id(+) and
c.country_id = cn.country_id(+)
and
co.crop_id = cr.crop_id(+);

-- standard SQL join syntax
SELECT co."date", c.customer, cr.crop, cn.country, co.stems_ordered
FROM customers c
LEFT JOIN customer_orders co ON c.customer_id = co.customer_id
LEFT JOIN countries cn ON c.country_id = cn.country_id
LEFT JOIN crops cr ON co.crop_id = cr.crop_id;

