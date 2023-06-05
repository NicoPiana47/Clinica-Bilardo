package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class servletMedicos
 */
@WebServlet("/servletMedicos")
public class servletMedicos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	MedicosDao sdao = new MedicosDaoImpl();
       
    public servletMedicos() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("btnAceptar")!=null)
        {
        	int filas=0;
        	if (!(request.getParameter("txtNombreUsuario").isEmpty() || request.getParameter("txtContraseña").isEmpty())) {
        		
        	}
        	      	
        	request.setAttribute("cantFilas", filas);
        	RequestDispatcher rd = request.getRequestDispatcher("/AgregarSeguros.jsp");
        	rd.forward(request, response);
        }

	}
	
	
	public void iniciarSesion() {
		
		
	}

}
