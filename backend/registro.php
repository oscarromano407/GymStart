<?php
$host = "localhost";
$port = "5432";
$dbname = "proyectoinge";
$user = "postgres";
$password = "5202";

$conn = pg_connect("host=$host port=$port dbname=$dbname user=$user password=$password");
if (!$conn) die("Error de conexión");

$error = "";
$success = false;
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    // LIMPIAR DATOS
    $nombre   = trim(pg_escape_string($conn, $_POST['nombre'] ?? ''));
    $correo   = trim(pg_escape_string($conn, $_POST['correo'] ?? ''));
    $pass     = $_POST['password'] ?? '';
    $confirm  = $_POST['confirm'] ?? '';
    $genero   = $_POST['genero'] ?? '';
    $edad     = $_POST['edad'] ?? '';
    $peso     = $_POST['peso'] ?? '';
    $estatura = $_POST['estatura'] ?? '';
    $objetivo = $_POST['objetivo'] ?? '';
    $prioridad= $_POST['prioridad'] ?? '';
    $diasRaw  = $_POST['dias'] ?? '';

    $dias = explode(",", $diasRaw);

    // =========================
    // 🔴 VALIDACIONES
    // =========================

    if (
        empty($nombre) ||
        empty($correo) ||
        empty($pass) ||
        empty($confirm) ||
        empty($genero) ||
        empty($edad) ||
        empty($peso) ||
        empty($estatura) ||
        empty($objetivo) ||
        empty($prioridad) ||
        empty($diasRaw)
    ) {
        $error = "Todos los campos son obligatorios.";
    }

    elseif (!filter_var($correo, FILTER_VALIDATE_EMAIL)) {
        $error = "Correo inválido.";
    }

    elseif ($pass != $confirm) {
        $error = "Las contraseñas no coinciden.";
    }

    elseif (strlen($pass) < 8) {
        $error = "La contraseña debe tener al menos 8 caracteres.";
    }

    elseif (count($dias) < 3) {
        $error = "Debes seleccionar al menos 3 días.";
    }

    elseif (!is_numeric($edad) || $edad < 10 || $edad > 100) {
        $error = "Edad inválida.";
    }

    elseif (!is_numeric($peso) || $peso <= 0) {
        $error = "Peso inválido.";
    }

    elseif (!is_numeric($estatura) || $estatura <= 0) {
        $error = "Estatura inválida.";
    }

    else {

        // VALIDAR CORREO DUPLICADO
        $check = pg_query($conn, "SELECT id FROM usuario WHERE correo='$correo'");
        if (pg_num_rows($check) > 0) {
            $error = "El correo ya está registrado.";
        } else {

            $passHash = password_hash($pass, PASSWORD_DEFAULT);

            // INSERT USUARIO
            $query = "INSERT INTO usuario 
            (nombre,correo,contrasena,genero,edad,peso,estatura,objetivo,prioridad,dias)
            VALUES 
            ('$nombre','$correo','$passHash','$genero',$edad,$peso,$estatura,'$objetivo','$prioridad',".count($dias).")
            RETURNING id";

            $result = pg_query($conn, $query);

            if (!$result) {
                $error = "Error al registrar: " . pg_last_error($conn);
            } else {

                $row = pg_fetch_assoc($result);
                $usuario_id = $row['id'];

                // INSERT DIAS
                foreach ($dias as $d) {
                    $d = pg_escape_string($conn, $d);
                    pg_query($conn, "INSERT INTO dias_usuario(usuario_id,dia) VALUES($usuario_id,'$d')");
                }

                $success = true;
                header("Location: login.php");
exit();
            }
        }
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Registro — GymStart</title>
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
 
  body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: #0f0f0f;
    color: #f0f0f0;
    min-height: 100vh;
    display: flex;
    align-items: flex-start;
    justify-content: center;
    padding: 2rem 1rem;
  }
 
  .card {
    background: #1a1a1a;
    border: 0.5px solid #2e2e2e;
    border-radius: 16px;
    width: 100%;
    max-width: 420px;
    padding: 2rem 1.75rem;
  }
 
  /* LOGO */
  .logo { display: flex; align-items: center; gap: 10px; margin-bottom: 1.75rem; }
  .logo-icon {
    width: 36px; height: 36px;
    background: #C0DD97; border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
  }
  .logo-icon svg { width: 20px; height: 20px; }
  .logo-name { font-size: 18px; font-weight: 600; color: #f0f0f0; }
  .logo-sub  { font-size: 12px; color: #888780; margin-top: 1px; }
 
  /* STEPS */
  .step-bar { display: flex; gap: 6px; margin-bottom: 1.75rem; }
  .step { height: 3px; flex: 1; border-radius: 99px; background: #2e2e2e; transition: background 0.3s; }
  .step.done   { background: #97C459; }
  .step.active { background: #C0DD97; }
 
  h1 { font-size: 22px; font-weight: 600; color: #f0f0f0; margin-bottom: 4px; }
  .subtitle { font-size: 13px; color: #888780; margin-bottom: 1.75rem; }
 
  /* FIELDS */
  .field { margin-bottom: 1rem; }
  .field label { display: block; font-size: 12px; color: #888780; margin-bottom: 6px; }
  .field input, .field select {
    width: 100%;
    background: #111;
    border: 0.5px solid #2e2e2e;
    border-radius: 8px;
    padding: 10px 14px;
    font-size: 14px;
    color: #f0f0f0;
    outline: none;
    transition: border-color 0.15s;
    appearance: none;
  }
  .field input:focus, .field select:focus { border-color: #639922; }
  .field select option { background: #1a1a1a; }
  .row2 { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
 
  /* OBJECTIVE CARDS */
  .obj-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-top: 6px; }
  .obj-card {
    background: #111; border: 0.5px solid #2e2e2e; border-radius: 10px;
    padding: 10px 12px; cursor: pointer; transition: all 0.15s;
  }
  .obj-card.wide { grid-column: 1 / -1; }
  .obj-card.sel  { border-color: #639922; background: #1a2e10; }
  .obj-card .oc-icon  { font-size: 18px; margin-bottom: 4px; }
  .obj-card .oc-title { font-size: 13px; color: #f0f0f0; font-weight: 500; }
  .obj-card .oc-desc  { font-size: 11px; color: #888780; margin-top: 2px; }
  .obj-card.sel .oc-title { color: #C0DD97; }
 
  /* PRIORITY CARDS */
  .pri-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; margin-top: 6px; }
  .pri-card {
    background: #111; border: 0.5px solid #2e2e2e; border-radius: 10px;
    padding: 10px 12px; cursor: pointer; text-align: center; transition: all 0.15s;
  }
  .pri-card.sel { border-color: #639922; background: #1a2e10; }
  .pri-card .pc-icon  { font-size: 18px; margin-bottom: 4px; }
  .pri-card .pc-label { font-size: 13px; color: #f0f0f0; font-weight: 500; }
  .pri-card.sel .pc-label { color: #C0DD97; }
 
  /* DAYS */
  .dias-grid { display: flex; gap: 8px; justify-content: space-between; margin-top: 6px; }
  .dia-btn {
    flex: 1; aspect-ratio: 1; border-radius: 50%;
    border: 0.5px solid #2e2e2e; background: #111;
    color: #888780; font-size: 13px; font-weight: 500;
    cursor: pointer; display: flex; align-items: center; justify-content: center;
    transition: all 0.15s;
  }
  .dia-btn.sel { background: #639922; border-color: #639922; color: #173404; }
  .dias-hint { font-size: 11px; color: #888780; margin-top: 8px; }
 
  /* BUTTONS */
  .btn-primary {
    width: 100%; background: #639922; border: none; border-radius: 10px;
    padding: 13px; font-size: 15px; font-weight: 600; color: #173404;
    cursor: pointer; margin-top: 1.5rem; transition: background 0.15s;
  }
  .btn-primary:hover { background: #97C459; }
  .btn-secondary {
    width: 100%; background: transparent; border: 0.5px solid #2e2e2e;
    border-radius: 10px; padding: 11px; font-size: 14px; color: #888780;
    cursor: pointer; margin-top: 10px; transition: all 0.15s;
  }
  .btn-secondary:hover { border-color: #888780; color: #f0f0f0; }
 
  /* ERROR */
  .error-box {
    background: #2a1010; border: 0.5px solid #E24B4A; border-radius: 8px;
    padding: 10px 14px; font-size: 13px; color: #F09595; margin-bottom: 1rem;
  }
 
  /* SUCCESS */
  .success { text-align: center; padding: 1.5rem 0; }
  .s-icon {
    width: 64px; height: 64px; background: #1a2e10; border-radius: 50%;
    margin: 0 auto 1.25rem; display: flex; align-items: center; justify-content: center;
  }
  .s-icon svg { width: 30px; height: 30px; }
  .success h2 { font-size: 20px; font-weight: 600; color: #f0f0f0; margin-bottom: 8px; }
  .success p { font-size: 14px; color: #888780; line-height: 1.6; }
 
  /* STEP PANELS */
  .step-panel { display: none; }
  .step-panel.active { display: block; }
 
  /* HIDDEN INPUT */
  input[type="hidden"] { display: none; }
</style>
</head>
<body>
 
<div class="card">
 
  <div class="logo">
    <div class="logo-icon">
      <svg viewBox="0 0 24 24" fill="none" stroke="#27500A" stroke-width="2.5" stroke-linecap="round">
        <path d="M6 4v16M18 4v16M2 12h4M18 12h4M6 8h12M6 16h12"/>
      </svg>
    </div>
    <div>
      <div class="logo-name">GymStart</div>
    </div>
  </div>
 
  <?php if ($success): ?>
 
  <div class="success">
    <div class="s-icon">
      <svg viewBox="0 0 24 24" fill="none" stroke="#97C459" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="20 6 9 17 4 12"/>
      </svg>
    </div>
    <h2>¡Registro exitoso!</h2>
    <p>Tu plan de entrenamiento personalizado está listo. Bienvenido a FitStart.</p>
  </div>
 
  <?php else: ?>
 
  <?php if ($error): ?>
    <div class="error-box"><?= htmlspecialchars($error) ?></div>
  <?php endif; ?>
 
  <form method="POST" id="regForm">
 
    <!-- PASO 1 -->
    <div class="step-panel active" id="panel1">
      <div class="step-bar">
        <div class="step active" id="sb1"></div>
        <div class="step" id="sb2"></div>
        <div class="step" id="sb3"></div>
      </div>
      <h1>Crea tu cuenta</h1>
      <p class="subtitle">Paso 1 de 3 — datos personales</p>
 
      <div class="field"><label>Nombre completo</label>
        <input type="text" name="nombre" placeholder="Ej. Carlos Ramírez" required>
      </div>
      <div class="field"><label>Correo electrónico</label>
        <input type="email" name="correo" placeholder="correo@ejemplo.com" required>
      </div>
      <div class="field"><label>Contraseña</label>
        <input type="password" name="password" placeholder="Mínimo 8 caracteres" required>
      </div>
      <div class="field"><label>Confirmar contraseña</label>
        <input type="password" name="confirm" placeholder="Repite tu contraseña" required>
      </div>
      <div class="row2">
        <div class="field"><label>Género</label>
          <select name="genero">
            <option value="H">Hombre</option>
            <option value="M">Mujer</option>
          </select>
        </div>
        <div class="field"><label>Edad</label>
          <input type="number" name="edad" placeholder="25" min="10" max="100" required>
        </div>
      </div>
      <button type="button" class="btn-primary" onclick="goStep(2)">Continuar</button>
    </div>
 
    <!-- PASO 2 -->
    <div class="step-panel" id="panel2">
      <div class="step-bar">
        <div class="step done"></div>
        <div class="step active"></div>
        <div class="step"></div>
      </div>
      <h1>Tu físico actual</h1>
      <p class="subtitle">Paso 2 de 3 — medidas y objetivo</p>
 
      <div class="row2">
        <div class="field"><label>Peso (kg)</label>
          <input type="number" name="peso" step="0.1" placeholder="70.5" required>
        </div>
        <div class="field"><label>Estatura (m)</label>
          <input type="number" name="estatura" step="0.01" placeholder="1.75" required>
        </div>
      </div>
 
      <div class="field" style="margin-top:4px">
        <label style="margin-bottom:10px;display:block">Objetivo principal</label>
        <input type="hidden" name="objetivo" id="objetivo" value="hipertrofia">
        <div class="obj-grid">
          <div class="obj-card sel" onclick="selObj(this,'hipertrofia')">
            <div class="oc-icon">💪</div>
            <div class="oc-title">Hipertrofia</div>
            <div class="oc-desc">Ganar músculo</div>
          </div>
          <div class="obj-card" onclick="selObj(this,'perder_peso')">
            <div class="oc-icon">🔥</div>
            <div class="oc-title">Perder peso</div>
            <div class="oc-desc">Quemar grasa</div>
          </div>
          <div class="obj-card wide" onclick="selObj(this,'recomposicion')">
            <div class="oc-icon">⚡</div>
            <div class="oc-title">Recomposición</div>
            <div class="oc-desc">Músculo y definición a la vez</div>
          </div>
        </div>
      </div>
 
      <div class="field" style="margin-top:4px">
        <label style="margin-bottom:10px;display:block">Zona prioritaria</label>
        <input type="hidden" name="prioridad" id="prioridad" value="torso">
        <div class="pri-grid">
          <div class="pri-card sel" onclick="selPri(this,'torso')">
            <div class="pc-icon">🦾</div>
            <div class="pc-label">Torso</div>
          </div>
          <div class="pri-card" onclick="selPri(this,'pierna')">
            <div class="pc-icon">🦵</div>
            <div class="pc-label">Pierna</div>
          </div>
        </div>
      </div>
 
      <button type="button" class="btn-primary" onclick="goStep(3)">Continuar</button>
      <button type="button" class="btn-secondary" onclick="goStep(1)">Volver</button>
    </div>
 
    <!-- PASO 3 -->
    <div class="step-panel" id="panel3">
      <div class="step-bar">
        <div class="step done"></div>
        <div class="step done"></div>
        <div class="step active"></div>
      </div>
      <h1>Tu disponibilidad</h1>
      <p class="subtitle">Paso 3 de 3 — días de entrenamiento</p>
 
      <div class="field">
        <label>Días que puedes entrenar</label>
        <div class="dias-grid">
          <div class="dia-btn" onclick="toggleDia(this,'L')">L</div>
          <div class="dia-btn" onclick="toggleDia(this,'M')">M</div>
          <div class="dia-btn" onclick="toggleDia(this,'X')">X</div>
          <div class="dia-btn" onclick="toggleDia(this,'J')">J</div>
          <div class="dia-btn" onclick="toggleDia(this,'V')">V</div>
          <div class="dia-btn" onclick="toggleDia(this,'S')">S</div>
          <div class="dia-btn" onclick="toggleDia(this,'D')">D</div>
        </div>
        <p class="dias-hint" id="dias-hint">Selecciona mínimo 3 días</p>
      </div>
      <input type="hidden" name="dias" id="dias">
 
      <button type="button" class="btn-primary" onclick="submitForm()">Empezar a entrenar</button>
      <button type="button" class="btn-secondary" onclick="goStep(2)">Volver</button>
    </div>
 
  </form>
  <?php endif; ?>
 
</div>
 
<script>
let diasSel = [];
 
function goStep(n) {
  document.querySelectorAll('.step-panel').forEach(p => p.classList.remove('active'));
  document.getElementById('panel' + n).classList.add('active');
  window.scrollTo(0, 0);
}
 
function selObj(el, val) {
  document.querySelectorAll('.obj-card').forEach(c => c.classList.remove('sel'));
  el.classList.add('sel');
  document.getElementById('objetivo').value = val;
}
 
function selPri(el, val) {
  document.querySelectorAll('.pri-card').forEach(c => c.classList.remove('sel'));
  el.classList.add('sel');
  document.getElementById('prioridad').value = val;
}
 
function toggleDia(el, dia) {
  el.classList.toggle('sel');
  if (diasSel.includes(dia)) {
    diasSel = diasSel.filter(d => d !== dia);
  } else {
    diasSel.push(dia);
  }
  document.getElementById('dias').value = diasSel.join(',');
  const h = document.getElementById('dias-hint');
  h.textContent = diasSel.length < 3
    ? 'Selecciona mínimo 3 días'
    : diasSel.length + ' días seleccionados';
  h.style.color = diasSel.length >= 3 ? '#639922' : '#888780';
}
 
function submitForm() {
  if (diasSel.length < 3) {
    alert('Selecciona al menos 3 días de entrenamiento.');
    return;
  }
  document.getElementById('regForm').submit();
}
</script>
 
</body>
</html>