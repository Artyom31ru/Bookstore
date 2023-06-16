<?php require 'connect.php';

$sql = "select id_order, buyer_id, seller_id,
		buyers.surname as b_surname, buyers.firstname as b_firstname,
		sellers.surname as s_surname, sellers.firstname as s_firstname,
		date_order, city, street, home, coalesce(sum(price * quantity), 0.00) as sum_order from orders
		left join suborders on order_id = id_order
		left join books on book_id = id_book
		join buyers on buyer_id = id_buyer
		join sellers on seller_id = id_seller
		join branches on branch_id = id_branch
		group by id_order, b_surname, b_firstname, s_surname, s_firstname, date_order, city, street, home order by id_order";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;