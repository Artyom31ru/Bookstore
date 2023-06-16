<?php require 'connect.php';

$id = $_GET['id'];

$sql = "select id_sample, title, author, genre, total
	    from books
	    join genres on genre_id = id_genre
	    join samples on book_id = id_book
	    where branch_id = $id order by id_sample";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;
