<?php
session_start();

if (!isset($_SESSION['usuario_id']) || !isset($_SESSION['entrenamiento_id'])) {
    exit();
}

$conn = pg_connect("host=localhost port=5432 dbname=proyectoinge user=postgres password=5202");

if (!$conn) {
    exit();
}

$usuario_id = $_SESSION['usuario_id'];
$entrenamiento_id = $_SESSION['entrenamiento_id'];

$ejercicio_id = $_POST['ejercicio_id'] ?? null;
$kg = $_POST['kg'] ?? null;
$reps = $_POST['reps'] ?? null;

// VALIDACIÓN
if (!$ejercicio_id || !$kg || !$reps) {
    exit();
}

// INSERT 
$serie = $_POST['serie'] ?? null;

pg_query($conn, "
INSERT INTO registro_serie 
(usuario_id, ejercicio_id, kg, reps, serie, entrenamiento_id)
VALUES ($usuario_id, $ejercicio_id, $kg, $reps, $serie, $entrenamiento_id)
");
?>