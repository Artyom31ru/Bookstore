<?php require 'connect.php';

$json = file_get_contents('php://input');
$data = json_decode($json);

if (isset($data->sort1)) $sort1 = $data->sort1;
else $sort1 = '';
if ($data->sort2) {
	$sort2 = ' where genre_id = ' . $data->sort2;
	$sort3 = ' and ';
}
else {
	$sort2 = '';
	$sort3 = ' where ';
}
if ($data->sort3) $sort3 .= " (title like '%$data->sort3%' or author like '%$data->sort3%')";
else $sort3 = '';

$sql = "select id_book, title, author, genre, genre_id, price
	    from books
	    join genres on genre_id = id_genre $sort2 $sort3 $sort1";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;

