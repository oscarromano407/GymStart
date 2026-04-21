<?php
$host = "localhost";
$port = "5432";
$dbname = "proyectoinge";
$user = "postgres";
$password = "2212"; 

$conn = pg_connect("host=$host port=$port dbname=$dbname user=$user password=$password");

if (!$conn) {
    echo "Error de conexión";
}
?>