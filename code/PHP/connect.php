<?php
$connection = pg_connect("host='localhost' dbname='coursework' user='postgres' password='admin'");

if(!$connection) die('Ошибка подключения!');
