<?php require 'connect.php';

$json = file_get_contents('php://input');
$data = json_decode($json);

$sql = "call update_seller($data->id, '$data->surname', '$data->firstname', '$data->patronymic', $data->branch_id, $data->salary)";

$result = pg_query($connection, $sql);

if (!$result){
	http_response_code(500);
	echo json_encode(array('error' => $result));
}
else{
	echo "Успешно обновлена запись!";
} 