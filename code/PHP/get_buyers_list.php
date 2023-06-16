<?php require 'connect.php';

$sql = "select * from buyers order by id_buyer";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;