package servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import entidades.Turno;
import negImpl.TurnosNegocio;

/**
 * Servlet implementation class servletTurnos
 */
@WebServlet("/servletTurnos")
public class servletTurnos extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public servletTurnos() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		TurnosNegocio turnoNegocio = new TurnosNegocio();
    	List<Turno> listaTurnos = turnoNegocio.obtenerTurnos();
		request.setAttribute("listaTurnos", listaTurnos);
		    
	    RequestDispatcher rd = request.getRequestDispatcher("/AdminReportes.jsp");
		rd.forward(request, response);
		
			
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	/*public void cargarTabla(HttpServletRequest request, HttpServletResponse response) {
		if(request.getParameter("cargaTabla") != null) {
			
			
		}
		
		
		
		
		
		
	}*/
	
}
