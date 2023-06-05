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
import negImpl.MedicosNegocioImpl;
import neg.MedicosNegocio;


/**
 * Servlet implementation class servletMedicos
 */
@WebServlet("/servletMedicos")
public class servletMedicos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MedicosNegocio mNeg = new MedicosNegocioImpl();
       
    public servletMedicos() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		int filas = 0;
		if(request.getParameter("btnIngresar")!=null)
        {
        	
        	Medico med = mNeg.iniciarSesion(request.getParameter("txtNombreUsuario"), request.getParameter("txtContraseña"));
        		
        	if(med != null) {
        		session.setAttribute("medico", med);
        	}
        	      	
        	request.setAttribute("cantFilas", filas);
        	RequestDispatcher rd = request.getRequestDispatcher("/AgregarSeguros.jsp");
        	rd.forward(request, response);
        }

	}
	
	
	public void iniciarSesion() {
		
		
	}

}
