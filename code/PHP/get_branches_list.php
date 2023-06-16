<?php require 'connect.php';

$sql = "select * from branches order by id_branch";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;