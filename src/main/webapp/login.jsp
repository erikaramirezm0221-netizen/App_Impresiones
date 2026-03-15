<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Iniciar Sesión - Neo PrintStudio</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <style>
        /* Estilos Generales y Fondo Armónico */
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa; /* Fondo claro similar al catálogo */
            display: flex;
            justify-content: center; /* Centrar horizontalmente */
            align-items: center; /* Centrar verticalmente */
            height: 100vh;
            margin: 0;
        }

        /* Contenedor del Formulario (La "Tarjeta" de Login) */
        .login-container {
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15); /* Sombra suave y prominente */
            padding: 40px;
            width: 350px;
            text-align: center;
        }

        .login-container h2 {
            color: #007bff; /* Color primario similar al header del catálogo */
            margin-bottom: 30px;
            font-size: 1.8em;
        }

        /* Estilos de los Grupos de Formulario */
        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #343a40;
        }

        /* Estilo de los Campos de Entrada */
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            box-sizing: border-box; /* Incluye padding y borde en el ancho total */
            transition: border-color 0.3s;
        }
        
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
            outline: none;
        }

        /* Estilo del Botón de Login */
        .btn-login {
            background-color: #28a745; /* Verde fuerte para la acción principal */
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            font-weight: bold;
            width: 100%;
            transition: background-color 0.3s;
        }

        .btn-login:hover {
            background-color: #1e7e34;
        }

        /* Mensajes de Error/Éxito */
        .message {
            margin-top: 20px;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Iniciar Sesión</h2>

        <%
            // Capturar el mensaje de error si viene del LoginServlet
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="message error">
                <%= error %>
            </div>
        <%
            }
        %>
        
        <form action="LoginServlet" method="post">
            <input type="hidden" name="accion" value="login">
            
            <div class="form-group">
                <label for="email">Correo Electrónico:</label>
                <input type="email" id="email" name="email" class="form-control" placeholder="ejemplo@mail.com" required>
            </div>

            <div class="form-group">
                <label for="password">Contraseña:</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Ingrese su contraseña" required>
            </div>

            <button type="submit" class="btn-login">Ingresar</button>
        </form>
    </div>

</body>
</html>