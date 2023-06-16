<?php require 'connect.php';

$json = file_get_contents('php://input');
$data = json_decode($json);

$sql = "call insert_suborder($data->order_id, $data->book_id, $data->quantity)";

$result = pg_query($connection, $sql);

if (!$result){
	http_response_code(500);
	echo json_encode(array('error' => $result));
}
else{
	echo "Успешно добавлена запись!";
} 