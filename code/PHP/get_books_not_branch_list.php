<?php require 'connect.php';

$id = $_GET['id'];

$sql = "select id_book, title, author, genre from books
		join genres on genre_id = id_genre
		where id_book not in (
  			select book_id
  			from samples
  			where branch_id = $id) order by id_book";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;
