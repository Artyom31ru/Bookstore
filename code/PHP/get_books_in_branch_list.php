<?php require 'connect.php';

$id = $_GET['id'];

$sql = "select id_book, title, author, total from books
		join samples on book_id = id_book
		where total > 0 and branch_id = (select branch_id from sellers
							join orders on seller_id = id_seller
							where id_order = $id) order by id_book";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;
