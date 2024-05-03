select week,
sum(stems_ordered) total_stems
,crop_id
from customer_orders
where customer_id = 39 and
stems_ordered < 10000 
group by week,crop_id
having  sum(stems_ordered)
< 10000
order by week