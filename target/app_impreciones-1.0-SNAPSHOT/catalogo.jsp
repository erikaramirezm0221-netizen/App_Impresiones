<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.mycompany.app_impreciones.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Catálogo de Productos - Neo PrintStudio</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <style>
        /* Estilos generales */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f8f9fa;
        }
        /* Header y navegación */
        .header {
            background-color: #007bff; /* Azul primario */
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header a {
            color: white;
            text-decoration: none;
            margin-left: 20px;
        }
        .header a:hover {
            text-decoration: underline;
        }
        .main-content {
            padding: 20px;
        }
        /* Contenedor de productos */
        .productos-container {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center; /* Centra los productos */
            padding: 30px 0;
        }
        /* Diseño de la tarjeta de producto */
        .producto-card {
            background-color: white;
            border: 1px solid #dee2e6;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px;
            text-align: center;
            transition: transform 0.3s ease;
        }
        .producto-card:hover {
            transform: translateY(-8px);
        }
        .producto-card h3 {
            color: #343a40;
            margin-top: 5px;
        }
        /* Estilo de la imagen */
        .producto-card img {
            width: 100%;
            height: 200px; /* Tamaño fijo */
            object-fit: cover; /* Asegura que la imagen cubra el área sin deformarse */
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .precio {
            font-size: 1.6em;
            color: #28a745; /* Verde para precios */
            font-weight: bold;
            margin: 10px 0;
        }
        /* Botón de Carrito */
        button[type="submit"] {
            background-color: #ffc107; /* Amarillo para el carrito */
            color: #333;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        button[type="submit"]:hover {
            background-color: #e0a800;
        }
    </style>
</head>
<body>

<%
    // **1. Solo necesitas obtener la sesión en un scriptlet.**
    Usuario usuarioLogeado = (Usuario) session.getAttribute("usuarioLogeado");
    
    // VALIDACIÓN CRÍTICA (Redirección si no está logeado)
    if (usuarioLogeado == null) {
        response.sendRedirect("login.jsp");
        return; 
    }
    request.setAttribute("usuario", usuarioLogeado);
%>

<div class="header">
    <h1>Neo PrintStudio</h1>
    <div>
        <span>Bienvenido, **${usuario.nombre}**</span>
        <a href="CarritoServlet">Ver Carrito</a>
        <a href="LoginServlet?accion=cerrarSesion">Cerrar Sesión</a>
    </div>
</div>

<div class="main-content">
    <h2>Catálogo de Productos</h2>
    <p>Explora nuestros productos de impresión:</p>

    <c:choose>
        <%-- Si la lista 'productos' NO está vacía --%>
        <c:when test="${not empty requestScope.productos}">
            
            <div class="productos-container">
                
                <c:forEach var="p" items="${requestScope.productos}">
                    <div class="producto-card">
                        <h3>${p.nombre}</h3>
                        
                        <%-- ENLACE DE IMAGEN: La clave está aquí --%>
                        <c:choose>
                            <c:when test="${not empty p.imagenUrl}">
                                <img src="images/${p.imagenUrl}" alt="${p.nombre}">
                            </c:when>
                            <c:otherwise>
                                <p>[Imagen no disponible]</p>
                            </c:otherwise>
                        </c:choose>

                        <p class="precio">$${p.precio}</p>
                        <p>${p.descripcion}</p>
                        
                        <form action="CarritoServlet" method="post">
                            <input type="hidden" name="idProducto" value="${p.id}">
                            <input type="hidden" name="accion" value="agregar">
                            <button type="submit">Agregar al Carrito</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        
        <%-- ELSE (Si la lista 'productos' está vacía o es null) --%>
        <c:otherwise>
            <p style="text-align: center; color: red;">No hay productos disponibles en este momento. Por favor, revisa la base de datos y la conexión.</p>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>