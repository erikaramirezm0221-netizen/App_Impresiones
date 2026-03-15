/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.app_impreciones.controlador;

import com.mycompany.app_impreciones.modelo.Usuario;
import com.mycompany.app_impreciones.dao.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if (accion != null && accion.equals("login")) {
            // El servlet lee tu entrada: erika@gmail.com y 1234
            String email = request.getParameter("email"); 
            String password = request.getParameter("password");

            // Llama al DAO para verificar contra la BD
            Usuario usuario = usuarioDAO.validar(email, password);

            if (usuario != null) {
                // Login Exitoso
                HttpSession session = request.getSession();
                session.setAttribute("usuarioLogeado", usuario);
                response.sendRedirect("CatalogoServlet"); 
                
            } else {
                // Login Fallido: Error de credenciales O falla de conexión a BD
                request.setAttribute("error", "Credenciales incorrectas o la base de datos no está disponible.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else if (accion != null && accion.equals("cerrarSesion")) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login.jsp");
        } else {
             response.sendRedirect("login.jsp");
        }
    }
    
    // ... (Método doGet sin cambios) ...
}