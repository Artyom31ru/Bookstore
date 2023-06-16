<?php require 'connect.php';

$id = $_GET['id'];

$sql = "select id_suborder, title, author, genre, quantity
	    from suborders
	    join books on book_id = id_book
	    join genres on genre_id = id_genre
	    where order_id = $id order by id_suborder";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;
