SELECT contracted_stems,crop_id
from customer_contracts 
where  contracted_stems > 25000 
order by contracted_stems desc
FETCH FIRST 10 rows only;

SELECT *
FROM (
    SELECT contracted_stems, crop_id
    FROM customer_contracts
    WHERE contracted_stems > 25000
    ORDER BY contracted_stems DESC
)
WHERE ROWNUM <= 10;

with a as
(SELECT contracted_stems, crop_id
    FROM customer_contracts
    WHERE contracted_stems > 25000
    ORDER BY contracted_stems DESC)
select * from a
WHERE ROWNUM <= 10;

