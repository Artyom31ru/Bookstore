<?php require 'connect.php';

$json = file_get_contents('php://input');
$data = json_decode($json);

$sql = "call update_book($data->id, '$data->title', '$data->author', $data->genre_id, $data->price)";

$result = pg_query($connection, $sql);

if (!$result){
	http_response_code(500);
	echo json_encode(array('error' => $result));
}
else{
	echo "Успешно обновлена запись!";
} 