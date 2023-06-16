<?php require 'connect.php';

$sql = "select * from genres order by id_genre";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;