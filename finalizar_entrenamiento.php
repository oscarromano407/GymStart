<?php
session_start();

$conn = pg_connect("host=localhost port=5432 dbname=proyectoinge user=postgres password=5202");

$id = $_SESSION['entrenamiento_id'];

pg_query($conn, "
UPDATE entrenamiento
SET completado = true
WHERE id = $id
");

unset($_SESSION['entrenamiento_id']);
?>