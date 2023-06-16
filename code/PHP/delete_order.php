<?php require 'connect.php';

$id = $_GET['id'];

$sql = "call delete_order($id)";

$result = pg_query($connection, $sql);

if (!$result){
	http_response_code(500);
	echo json_encode(array('error' => $result));
}
else{
	echo "Успешно обновлена запись!";
} 