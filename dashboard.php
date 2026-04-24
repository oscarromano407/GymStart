<?php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    header("Location: login.php");
    exit();
}

$conn = pg_connect("host=localhost port=5432 dbname=proyectoinge user=postgres password=5202");

if (!$conn) {
    die("Error de conexión");
}

$usuario_id = $_SESSION['usuario_id'];
$nombre = $_SESSION['nombre'];

// OBTENER RUTINA DEL USUARIO
$qUser = pg_query($conn, "SELECT rutina_id FROM usuario WHERE id = $usuario_id");

if (!$qUser) {
    die("Error usuario: " . pg_last_error($conn));
}

$userData = pg_fetch_assoc($qUser);

if (!$userData || !$userData['rutina_id']) {
    die("El usuario no tiene rutina asignada");
}

$rutina_id = $userData['rutina_id'];

// OBTENER DÍAS DE LA RUTINA
$queryDias = pg_query($conn, "
SELECT rd.id, rd.nombre
FROM rutina_dia rd
WHERE rd.rutina_id = $rutina_id
ORDER BY rd.orden
");

if (!$queryDias) {
    die("Error en días: " . pg_last_error($conn));
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Dashboard — GymStart</title>
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: #0f0f0f;
    color: #f0f0f0;
    min-height: 100vh;
    padding: 0;
  }
  .page {
    max-width: 430px;
    margin: 0 auto;
    padding: 1.5rem 1rem 3rem;
  }

  /* HEADER */
  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1.75rem;
  }
  .logo { display: flex; align-items: center; gap: 10px; }
  .logo-icon {
    width: 36px; height: 36px;
    background: #C0DD97; border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
  }
  .logo-icon svg { width: 20px; height: 20px; }
  .logo-name { font-size: 18px; font-weight: 600; color: #f0f0f0; }
  .logo-sub  { font-size: 12px; color: #888780; margin-top: 1px; }

  .logout-btn {
    background: transparent;
    border: 0.5px solid #2e2e2e;
    border-radius: 8px;
    padding: 7px 12px;
    font-size: 12px;
    color: #888780;
    cursor: pointer;
    text-decoration: none;
    transition: all 0.15s;
  }
  .logout-btn:hover { border-color: #888780; color: #f0f0f0; }

  /* WELCOME */
  .welcome {
    margin-bottom: 1.5rem;
  }
  .welcome-greeting {
    font-size: 13px;
    color: #888780;
    margin-bottom: 3px;
  }
  .welcome-name {
    font-size: 22px;
    font-weight: 600;
    color: #f0f0f0;
  }

  /* SECTION LABEL */
  .section-label {
    font-size: 11px;
    font-weight: 500;
    color: #888780;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    margin-bottom: 10px;
  }

  /* DAY CARD */
  .day-card {
    background: #1a1a1a;
    border: 0.5px solid #2e2e2e;
    border-radius: 12px;
    padding: 1rem 1.25rem;
    margin-bottom: 10px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 12px;
  }
  .day-info { flex: 1; }
  .day-number {
    font-size: 11px;
    color: #888780;
    margin-bottom: 3px;
  }
  .day-name {
    font-size: 15px;
    font-weight: 500;
    color: #f0f0f0;
  }
  .day-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    background: #639922;
    color: #173404;
    padding: 9px 16px;
    border-radius: 8px;
    text-decoration: none;
    font-size: 13px;
    font-weight: 600;
    white-space: nowrap;
    flex-shrink: 0;
    transition: background 0.15s;
  }
  .day-btn:hover { background: #97C459; }
</style>
</head>
<body>
<div class="page">

  <div class="header">
    <div class="logo">
      <div class="logo-icon">
        <svg viewBox="0 0 24 24" fill="none" stroke="#27500A" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <rect x="2" y="10" width="3" height="4" rx="1"/>
          <rect x="19" y="10" width="3" height="4" rx="1"/>
          <rect x="5" y="8" width="2" height="8" rx="1"/>
          <rect x="17" y="8" width="2" height="8" rx="1"/>
          <line x1="7" y1="12" x2="17" y2="12"/>
        </svg>
      </div>
      <div>
        <div class="logo-name">GymStart</div>
      </div>
    </div>
    <a href="login.php" class="logout-btn">Salir</a>
  </div>

  <div class="welcome">
    <p class="welcome-greeting">Hola 👋</p>
    <h1 class="welcome-name"><?= htmlspecialchars($nombre) ?></h1>
  </div>

  <p class="section-label">Tu rutina</p>

  <?php
  $i = 1;
  while ($row = pg_fetch_assoc($queryDias)) {
      echo "<div class='day-card'>";
      echo "  <div class='day-info'>";
      echo "    <p class='day-number'>Día " . $i . "</p>";
      echo "    <p class='day-name'>" . htmlspecialchars($row['nombre']) . "</p>";
      echo "  </div>";
      echo "  <a href='entrenamiento.php?dia_id=" . $row['id'] . "' class='day-btn'>▶ Empezar</a>";
      echo "</div>";
      $i++;
  }
  ?>

</div><!-- .page -->
</body>
</html>