<?php
session_start();

$host = "localhost";
$port = "5432";
$dbname = "proyectoinge";
$user = "postgres";
$password = "5202";

$conn = pg_connect("host=$host port=$port dbname=$dbname user=$user password=$password");
if (!$conn) die("Error de conexión");

$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $correo = trim(pg_escape_string($conn, $_POST['correo'] ?? ''));
    $pass   = $_POST['password'] ?? '';

    if (empty($correo) || empty($pass)) {
        $error = "Todos los campos son obligatorios.";
    } else {

        $query = "SELECT * FROM usuario WHERE correo='$correo'";
        $result = pg_query($conn, $query);

        if (pg_num_rows($result) == 1) {

            $userData = pg_fetch_assoc($result);

            if (password_verify($pass, $userData['contrasena'])) {

                $_SESSION['usuario_id'] = $userData['id'];
                $_SESSION['nombre'] = $userData['nombre'];

                header("Location: dashboard.php");
                exit();

            } else {
                $error = "Contraseña incorrecta.";
            }

        } else {
            $error = "El usuario no está registrado.";
        }
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login — GymStart</title>
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: #0f0f0f;
    color: #f0f0f0;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem 1rem;
  }

  .card {
    background: #1a1a1a;
    border: 0.5px solid #2e2e2e;
    border-radius: 16px;
    width: 100%;
    max-width: 400px;
    padding: 2rem 1.75rem;
  }

  .logo { display: flex; align-items: center; gap: 10px; margin-bottom: 1.75rem; }
  .logo-icon {
    width: 36px; height: 36px;
    background: #C0DD97; border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
  }
  .logo-icon svg { width: 20px; height: 20px; }
  .logo-name { font-size: 18px; font-weight: 600; color: #f0f0f0; }
  .logo-sub  { font-size: 12px; color: #888780; margin-top: 1px; }

  h1 { font-size: 22px; font-weight: 600; color: #f0f0f0; margin-bottom: 4px; }
  .subtitle { font-size: 13px; color: #888780; margin-bottom: 1.75rem; }

  .field { margin-bottom: 1rem; }
  .field label { display: block; font-size: 12px; color: #888780; margin-bottom: 6px; }
  .field input {
    width: 100%;
    background: #111;
    border: 0.5px solid #2e2e2e;
    border-radius: 8px;
    padding: 10px 14px;
    font-size: 14px;
    color: #f0f0f0;
    outline: none;
    transition: border-color 0.15s;
  }
  .field input:focus { border-color: #639922; }

  .btn {
    width: 100%;
    background: #639922;
    border: none;
    border-radius: 10px;
    padding: 13px;
    font-size: 15px;
    font-weight: 600;
    color: #173404;
    cursor: pointer;
    margin-top: 1.5rem;
    transition: background 0.15s;
  }
  .btn:hover { background: #97C459; }

  .error-box {
    background: #2a1010;
    border: 0.5px solid #E24B4A;
    border-radius: 8px;
    padding: 10px 14px;
    font-size: 13px;
    color: #F09595;
    margin-bottom: 1rem;
  }

  .link {
    margin-top: 1.25rem;
    text-align: center;
    font-size: 13px;
    color: #888780;
  }
  .link a { color: #C0DD97; text-decoration: none; }
  .link a:hover { text-decoration: underline; }
</style>
</head>
<body>

<div class="card">

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
      <div class="logo-sub">Tu primer gym app</div>
    </div>
  </div>

  <h1>Iniciar sesión</h1>
  <p class="subtitle">Accede a tu entrenamiento</p>

  <?php if ($error): ?>
    <div class="error-box"><?= htmlspecialchars($error) ?></div>
  <?php endif; ?>

  <form method="POST">

    <div class="field">
      <label>Correo electrónico</label>
      <input type="email" name="correo" placeholder="correo@ejemplo.com" required>
    </div>

    <div class="field">
      <label>Contraseña</label>
      <input type="password" name="password" placeholder="Tu contraseña" required>
    </div>

    <button class="btn" type="submit">Entrar</button>

  </form>

  <div class="link">
    ¿No tienes cuenta? <a href="registro.php">Regístrate aquí</a>
  </div>

</div>

</body>
</html>
