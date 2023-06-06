package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidades.Medico;
import negImpl.MedicoNegocio;


/**
 * Servlet implementation class servletMedicos
 */
@WebServlet("/servletMedicos")
public class servletMedicos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MedicoNegocio mNeg = new MedicoNegocio();
       
    public servletMedicos() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		iniciarSesion(request, response);

	}
	
	
	public void iniciarSesion(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession sessionMedico = request.getSession();
		Boolean filas = false;
		if(request.getParameter("btnIngresar")!=null)
        {
			sessionMedico.setAttribute("sessionMedico", null);
        	
			Medico med = mNeg.iniciarSesion(request.getParameter("txtNombreUsuario"), request.getParameter("txtContraseña"));
			
        	if(med != null) {
        		sessionMedico.setAttribute("sessionMedico", med);
        		filas = true;
        	}
        	
        	RequestDispatcher rd = null;
        	
        	if(filas) {
        		if(med.getTipo()) rd = request.getRequestDispatcher("/AdminMedicos.jsp");
        		else rd = request.getRequestDispatcher("/Inicio.jsp");
        	}
        	else rd = request.getRequestDispatcher("/Login.jsp");
        	      	
        	request.setAttribute("inicioSesion", filas);
        	try {
				rd.forward(request, response);
			} catch (ServletException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
	}

}
