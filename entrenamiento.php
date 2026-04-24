<?php
session_start();

if (!isset($_SESSION['usuario_id'])) {
    header("Location: login.php");
    exit();
}

// 🔌 CONEXIÓN
$conn = pg_connect("host=localhost port=5432 dbname=proyectoinge user=postgres password=5202");

if (!$conn) {
    die("Error de conexión");
}

$usuario_id = $_SESSION['usuario_id'];

if (!isset($_GET['dia_id'])) {
    die("Día no especificado");
}

$dia_id = intval($_GET['dia_id']);


// ==========================
// CREAR / REUTILIZAR ENTRENAMIENTO
// ==========================

$check = pg_query($conn, "
SELECT id FROM entrenamiento 
WHERE usuario_id = $usuario_id 
AND completado = false
LIMIT 1
");

if (pg_num_rows($check) > 0) {
    $row = pg_fetch_assoc($check);
    $_SESSION['entrenamiento_id'] = $row['id'];
} else {
    $insert = pg_query($conn, "
    INSERT INTO entrenamiento (usuario_id, rutina_dia_id, fecha, completado)
    VALUES ($usuario_id, $dia_id, NOW(), false)
    RETURNING id
    ");

    if (!$insert) {
        die("Error creando entrenamiento: " . pg_last_error($conn));
    }

    $row = pg_fetch_assoc($insert);
    $_SESSION['entrenamiento_id'] = $row['id'];
}


// ==========================
// QUERY EJERCICIOS
// ==========================

$query = "
SELECT 
    re.ejercicio_id,
    e.nombre AS ejercicio,
    re.series,
    re.reps,
    re.orden,

    (
        SELECT (rs.kg || 'kg x ' || rs.reps)
        FROM registro_serie rs
        WHERE rs.usuario_id = $usuario_id
        AND rs.ejercicio_id = re.ejercicio_id
        AND rs.serie = 1
        ORDER BY rs.fecha DESC
        LIMIT 1
    ) AS anterior_1,

    (
        SELECT (rs.kg || 'kg x ' || rs.reps)
        FROM registro_serie rs
        WHERE rs.usuario_id = $usuario_id
        AND rs.ejercicio_id = re.ejercicio_id
        AND rs.serie = 2
        ORDER BY rs.fecha DESC
        LIMIT 1
    ) AS anterior_2,

    (
        SELECT (rs.kg || 'kg x ' || rs.reps)
        FROM registro_serie rs
        WHERE rs.usuario_id = $usuario_id
        AND rs.ejercicio_id = re.ejercicio_id
        AND rs.serie = 3
        ORDER BY rs.fecha DESC
        LIMIT 1
    ) AS anterior_3

FROM rutina_ejercicio re
JOIN ejercicio e ON re.ejercicio_id = e.id
WHERE re.rutina_dia_id = $dia_id
ORDER BY re.orden
";

$result = pg_query($conn, $query);

if (!$result) {
    die("Error en query: " . pg_last_error($conn));
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Entrenamiento — GymStart</title>
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
    background: #0f0f0f;
    color: #f0f0f0;
    min-height: 100vh;
    padding-bottom: 130px;
  }

  .page {
    max-width: 430px;
    margin: 0 auto;
    padding: 1.5rem 1rem 0;
  }

  /* HEADER */
  .header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 1.5rem;
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

  .back-btn {
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

  /* PAGE TITLE */
  .page-title { font-size: 20px; font-weight: 600; color: #f0f0f0; margin-bottom: 4px; }
  .page-sub   { font-size: 13px; color: #888780; margin-bottom: 1.5rem; }

  /* EXERCISE CARD */
  .exercise {
    background: #1a1a1a;
    border: 0.5px solid #2e2e2e;
    border-radius: 12px;
    padding: 1rem;
    margin-bottom: 12px;
  }
  .exercise h3 {
    font-size: 15px;
    font-weight: 600;
    color: #f0f0f0;
    margin-bottom: 12px;
  }

  /* TABLE GRID */
  .table {
    display: grid;
    grid-template-columns: 44px 1fr 58px 58px 38px;
    gap: 5px;
    align-items: center;
  }

  .th {
    font-size: 11px;
    color: #888780;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    padding: 0 2px 6px;
  }

  /* each cell in a data row */
  .td {
    background: #111;
    border: 0.5px solid #2e2e2e;
    padding: 7px 4px;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  /* round corners per row: first and last cell */
  .td.first { border-radius: 8px 0 0 8px; border-right: none; }
  .td.last  { border-radius: 0 8px 8px 0; border-left: none; }
  .td.mid   { border-left: none; border-right: none; }

  .serie-num {
    font-size: 13px;
    font-weight: 600;
    color: #888780;
  }
  .anterior-val {
    font-size: 12px;
    color: #97C459;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    width: 100%;
    padding: 0 4px;
  }

  input[type=number] {
    width: 100%;
    padding: 5px 2px;
    background: transparent;
    border: none;
    color: #f0f0f0;
    font-size: 14px;
    text-align: center;
    outline: none;
    -moz-appearance: textfield;
  }
  input[type=number]::-webkit-outer-spin-button,
  input[type=number]::-webkit-inner-spin-button { -webkit-appearance: none; }

  .btn {
    width: 28px; height: 28px;
    background: #1a2e10;
    border: 0.5px solid #639922;
    border-radius: 6px;
    color: #97C459;
    font-size: 13px;
    cursor: pointer;
    display: flex; align-items: center; justify-content: center;
    transition: all 0.15s;
  }
  .btn:hover { background: #639922; color: #173404; }

  /* row spacing */
  .row-gap { height: 5px; grid-column: 1 / -1; }

  /* BOTTOM BAR */
  #barra-container {
    position: fixed;
    bottom: 0; left: 0; right: 0;
    background: #111;
    border-top: 0.5px solid #2e2e2e;
    padding: 0.75rem 1rem;
    z-index: 100;
  }
  .bar-inner {
    max-width: 430px;
    margin: 0 auto;
    display: flex;
    flex-direction: column;
    gap: 8px;
  }

  .timer-track {
    position: relative;
    height: 30px;
    background: #1a1a1a;
    border: 0.5px solid #2e2e2e;
    border-radius: 8px;
    overflow: hidden;
  }
  #barra {
    height: 100%;
    width: 100%;
    background: #639922;
    transition: width 1s linear;
    border-radius: 8px;
  }
  #timer-texto {
    position: absolute;
    inset: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 12px;
    font-weight: 500;
    color: #f0f0f0;
  }

  .bar-actions { display: flex; gap: 8px; }
  .btn-cancelar {
    flex: 1;
    background: transparent;
    border: 0.5px solid #2e2e2e;
    border-radius: 8px;
    padding: 10px;
    font-size: 13px;
    color: #888780;
    cursor: pointer;
    transition: all 0.15s;
  }
  .btn-cancelar:hover { border-color: #888780; color: #f0f0f0; }

  .btn-finalizar {
    flex: 2;
    background: #7c1d1d;
    border: 0.5px solid #E24B4A;
    border-radius: 8px;
    padding: 10px;
    font-size: 13px;
    font-weight: 600;
    color: #F09595;
    cursor: pointer;
    transition: all 0.15s;
  }
  .btn-finalizar:hover { background: #E24B4A; color: #fff; }
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
    <a href="dashboard.php" class="back-btn">← Volver</a>
  </div>

  <h2 class="page-title">Entrenamiento</h2>
  <p class="page-sub">Registra tus series y descansa entre ellas</p>

<?php
while ($row = pg_fetch_assoc($result)) {

    $anteriores = [
    $row['anterior_1'],
    $row['anterior_2'],
    $row['anterior_3']
];
    $eid = $row['ejercicio_id'];

    echo "<div class='exercise'>";
    echo "<h3>" . htmlspecialchars($row['ejercicio']) . "</h3>";
    echo "<div class='table'>";

    // Header
    echo "<div class='th'>Serie</div>
          <div class='th'>Anterior</div>
          <div class='th'>Kg</div>
          <div class='th'>Reps</div>
          <div class='th'></div>";

   for ($i = 1; $i <= $row['series']; $i++) {

    $anterior = isset($anteriores[$i-1]) && $anteriores[$i-1]
        ? $anteriores[$i-1]
        : "-";

    echo "<div class='row-gap'></div>";
    echo "
    <div class='td first'><span class='serie-num'>$i</span></div>
    <div class='td mid'><span class='anterior-val'>" . htmlspecialchars($anterior) . "</span></div>
    <div class='td mid'><input type='number' id='kg_{$eid}_{$i}' placeholder='0' inputmode='decimal'></div>
    <div class='td mid'><input type='number' id='rep_{$eid}_{$i}' placeholder='0' inputmode='numeric'></div>
    <div class='td last'><button class='btn' onclick='guardar($eid,$i)' id='btn_{$eid}_{$i}'>✔</button></div>
    ";
}

    echo "</div></div>";
}
?>

</div><!-- .page -->

<div id="barra-container">
  <div class="bar-inner">
    <div class="timer-track">
      <div id="barra"></div>
      <span id="timer-texto"></span>
    </div>
    <div class="bar-actions">
      <button class="btn-cancelar" onclick="cancelar()">Cancelar descanso</button>
      <button class="btn-finalizar" onclick="finalizar()">Finalizar entrenamiento</button>
    </div>
  </div>
</div>

<script>
let t;

function iniciar() {
    clearInterval(t);

    let total = 165;
    let tiempo = total;

    let barra = document.getElementById("barra");
    let texto = document.getElementById("timer-texto");

    t = setInterval(() => {
        let p = (tiempo / total) * 100;
        barra.style.width = p + "%";

        let min = Math.floor(tiempo / 60);
        let seg = tiempo % 60;
        texto.innerText = `Descanso ${min}:${seg < 10 ? '0'+seg : seg}`;

        tiempo--;

        if (tiempo < 0) {
            clearInterval(t);
            texto.innerText = "Listo 💪";
            barra.style.width = "0%";
        }
    }, 1000);
}

function cancelar() {
    clearInterval(t);
    document.getElementById("barra").style.width = "0%";
    document.getElementById("timer-texto").innerText = "";
}

function guardar(ej, s) {

    let kg = document.getElementById("kg_"+ej+"_"+s).value;
    let reps = document.getElementById("rep_"+ej+"_"+s).value;

    fetch("guardar_serie.php", {
        method: "POST",
        headers: {"Content-Type":"application/x-www-form-urlencoded"},
        body: `ejercicio_id=${ej}&kg=${kg}&reps=${reps}`
    });

    document.getElementById("btn_"+ej+"_"+s).style.background = "#639922";
    document.getElementById("btn_"+ej+"_"+s).style.color = "#173404";

    iniciar();
}

function finalizar() {
    fetch("finalizar_entrenamiento.php", {method:"POST"})
    .then(()=> {
        alert("Guardado");
        window.location = "dashboard.php";
    });
}
</script>

</body>
</html>