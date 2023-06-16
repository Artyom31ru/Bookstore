<?php require 'connect.php';

if (isset($_GET['sort']))
$sort = htmlspecialchars($_GET['sort']);
else $sort = '';

$sql = "select id_seller, surname, firstname, patronymic, city, street, home, salary, branch_id
		from sellers join branches on branch_id = id_branch $sort";

$result = pg_query($connection, $sql);
$result = json_encode(pg_fetch_all($result));

echo $result;