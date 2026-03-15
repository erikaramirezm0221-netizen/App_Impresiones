<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.mycompany.app_impreciones.modelo.Usuario"%>
<%@page import="java.math.BigDecimal"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Carrito de Compras - Neo PrintStudio</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background-color: #f8f9fa;
        }
        .header {
            background-color: #007bff;
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
        .main-content {
            padding: 20px;
        }
        .table-carrito {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .table-carrito th, .table-carrito td {
            border: 1px solid #dee2e6;
            padding: 12px;
            text-align: left;
        }
        .table-carrito th {
            background-color: #e9ecef;
            color: #343a40;
        }
        .total-box {
            float: right;
            width: 300px;
            padding: 20px;
            border: 2px solid #007bff;
            border-radius: 8px;
            margin-top: 20px;
            background-color: #eaf3ff;
        }
        .total-box h3 {
            margin-top: 0;
            color: #007bff;
        }
        .btn-checkout {
            background-color: #28a745; /* Verde */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            display: block;
            width: 100%;
            margin-top: 15px;
            text-align: center;
            text-decoration: none;
        }
        .btn-eliminar {
            background-color: #dc3545; /* Rojo */
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        .img-thumb {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 3px;
        }
    </style>
</head>
<body>

<%
    // VALIDACIÓN CRÍTICA DE SESIÓN
    Usuario usuarioLogeado = (Usuario) session.getAttribute("usuarioLogeado");
    if (usuarioLogeado == null) {
        response.sendRedirect("login.jsp");
        return; 
    }
    request.setAttribute("usuario", usuarioLogeado);
    
    // Inicializar el total en cero si no está en el ámbito de aplicación
    BigDecimal totalGlobal = BigDecimal.ZERO;
    request.setAttribute("totalGlobal", totalGlobal);
%>

<div class="header">
    <h1>Carrito de Compras</h1>
    <div>
        <span>Usuario: **${usuario.nombre}**</span>
        <a href="CatalogoServlet">Volver al Catálogo</a>
        <a href="LoginServlet?accion=cerrarSesion">Cerrar Sesión</a>
    </div>
</div>

<div class="main-content">

    <c:choose>
        <%-- 1. Si la lista de ítems del carrito NO está vacía --%>
        <c:when test="${not empty sessionScope.carritoCompras}">
            
            <table class="table-carrito">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Imagen</th>
                        <th>Producto</th>
                        <th>Precio Unitario</th>
                        <th>Cantidad</th>
                        <th>SubTotal</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="totalAcumulado" value="${0.0}" />
                    <c:forEach var="item" items="${sessionScope.carritoCompras}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty item.producto.imagenUrl}">
                                        <img src="images/${item.producto.imagenUrl}" alt="${item.producto.nombre}" class="img-thumb">
                                    </c:when>
                                    <c:otherwise>
                                        [Sin Foto]
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${item.producto.nombre}</td>
                            <td>$${item.producto.precio}</td>
                            <td>
                                ${item.cantidad}
                            </td>
                            <td>$${item.subTotal}</td>
                            <td>
                                <form action="CarritoServlet" method="post" style="display: inline;">
                                    <input type="hidden" name="idItem" value="${loop.index}">
                                    <input type="hidden" name="accion" value="eliminar">
                                    <button type="submit" class="btn-eliminar">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <%-- Acumular el subtotal al total --%>
                        <c:set var="totalAcumulado" value="${totalAcumulado + item.subTotal}" />
                    </c:forEach>
                </tbody>
            </table>
            
            <div class="total-box">
                <h3>Resumen de la Compra</h3>
                <p>Total a pagar: <span style="font-size: 1.8em;">$${totalAcumulado}</span></p>
                <a href="CheckoutServlet" class="btn-checkout">Finalizar Compra</a>
            </div>

        </c:when>
        
        <%-- 2. ELSE: Si el carrito está vacío --%>
        <c:otherwise>
            <p style="text-align: center; color: gray; margin-top: 50px;">
                Su carrito de compras está vacío. 
                <a href="CatalogoServlet">Vuelve al catálogo</a> para agregar productos.
            </p>
        </c:otherwise>
    </c:choose>

</div>
</body>
</html>
