<?php require 'connect.php';

$id = $_GET['id'];

$sql = "select id_order, buyer_id, seller_id,
		buyers.surname as b_surname, buyers.firstname as b_firstname,
		sellers.surname as s_surname, sellers.firstname as s_firstname,
		date_order, city, street, home from orders
		join buyers on buyer_id = id_buyer
		join sellers on seller_id = id_seller
		join branches on branch_id = id_branch
		where id_order = $id";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;