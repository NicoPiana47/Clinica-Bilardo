package servlets;

import java.io.IOException;
import java.util.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import entidades.Especialidad;
import entidades.EstadoTurno;
import entidades.Medico;
import entidades.Paciente;
import entidades.Turno;
import negImpl.EspecialidadNegocio;
import negImpl.EstadoTurnosNegocio;
import negImpl.MedicoNegocio;
import negImpl.PacienteNegocio;
import negImpl.TurnosNegocio;

/**
 * Servlet implementation class servletTurnos
 */
@WebServlet("/servletTurnos")
public class servletTurnos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TurnosNegocio turnoNegocio = new TurnosNegocio();
       
    public servletTurnos() {

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("rep")!=null)
			inicializarAdminReportes(request, response);
		if(request.getParameter("asig")!=null)
			inicializarAdminAsigTurnos(request, response);
		if(request.getParameter("ini")!=null)
			inicializarInicio(request, response);	
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("fechaAjax") != null) {
			boolean existe = false;
			try {
				existe = buscarTurno(request.getParameter("fechaAjax"), request.getParameter("horarioAjax"), request.getParameter("codMedAjax"));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			response.setContentType("text/plain");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().print(existe);
		    return;
		}
		
		if(request.getParameter("btnFiltrarFechas") != null){
			listarTurnosConFechas(request, response);
		}
		
		try {
			grabarTurno(request, response);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		if(request.getParameter("btnFiltrar")!=null) {
			listarTurnosConFiltros(request, response);
		}
		
		if(request.getParameter("btnLimpiarFiltros")!=null) {
			inicializarInicio(request, response);	
    	}
    	
		
		if(request.getParameter("codTurnoAjax")!=null) {
			boolean cambio = cambiarEstado(request.getParameter("estado"), request.getParameter("codTurnoAjax"));
			response.setContentType("text/plain");
		    response.setCharacterEncoding("UTF-8");
		    response.getWriter().print(cambio);
		    return;	
		}
		
		if(request.getParameter("ini")!=null)
			inicializarInicio(request, response);	
		
	}
	
	public boolean buscarTurno(String fechaS, String horarioS, String codMedS) throws ParseException {
		int codMed = Integer.parseInt(codMedS);
		
		String fecha = fechaS + " " + horarioS;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date fechaTurno = dateFormat.parse(fecha);
		
		return turnoNegocio.buscarTurno(fechaTurno, codMed);
	}
	
	public void listarTurnosConFechas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("btnFiltrar") != null) {
			List<Turno> listaTurnos = null;
			
			if(request.getParameter("txtFechaDesde").equals("") && request.getParameter("txtFechaHasta").equals("")) {
				listaTurnos = turnoNegocio.obtenerTurnos();
			}
			else {											
				listaTurnos = turnoNegocio.obtenerTurnosEntreFechas(request.getParameter("txtFechaDesde"), request.getParameter("txtFechaHasta"));
			}
			String medicoConMasTurnos = listarReportesMedicoConMasTurnos(request, response, listaTurnos);
			long cantTurnos = listaTurnos.stream().count();
			
			request.setAttribute("listaTurnos", listaTurnos);
			request.setAttribute("medicoConMasTurnos", medicoConMasTurnos);
			request.setAttribute("cantTurnos", cantTurnos);
			
			RequestDispatcher rd = request.getRequestDispatcher("/AdminReportes.jsp");
			rd.forward(request, response);
			
		}
	}
	
	
	public String listarReportesMedicoConMasTurnos(HttpServletRequest request, HttpServletResponse response, List<Turno> listaTurnos) throws ServletException, IOException {
		
		Map<String, Integer> conteoMedicos = new HashMap<>();
		
		for (Turno turno : listaTurnos) {
		    String medico = turno.getMedico().getNombre();
		    if (conteoMedicos.containsKey(medico)) {
		    	
		        int cantidadTurnos = conteoMedicos.get(medico);
		        conteoMedicos.put(medico, cantidadTurnos + 1);
		    } else {
		    	
		        conteoMedicos.put(medico, 1);
		    }
		}
		
		String medicoConMasTurnos = null;
		int maximoTurnos = 0;
		
		for (Map.Entry<String, Integer> entry : conteoMedicos.entrySet()) {
		    String medico = entry.getKey();
		    int cantidadTurnos = entry.getValue();

		    if (cantidadTurnos > maximoTurnos) {
		        medicoConMasTurnos = medico;
		        maximoTurnos = cantidadTurnos;
		    }
		}
	
		return medicoConMasTurnos;
	}
	
	public void inicializarAdminReportes(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TurnosNegocio turnoNegocio = new TurnosNegocio();
    	List<Turno> listaTurnos = turnoNegocio.obtenerTurnos();
    	String medicoConMasTurnos = listarReportesMedicoConMasTurnos(request, response, listaTurnos);
    	long cantTurnos = listaTurnos.stream().count();
    	
		request.setAttribute("listaTurnos", listaTurnos);
		request.setAttribute("medicoConMasTurnos", medicoConMasTurnos);
		request.setAttribute("cantTurnos", cantTurnos);
		    
	    RequestDispatcher rd = request.getRequestDispatcher("/AdminReportes.jsp");
		rd.forward(request, response);
	}
	
	public void inicializarAdminAsigTurnos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		EspecialidadNegocio espNeg = new EspecialidadNegocio();
		MedicoNegocio medNeg = new MedicoNegocio();
		PacienteNegocio pacNeg = new PacienteNegocio();
		
		List<Especialidad> listaEspecialidades = espNeg.obtenerEspecialidades();
		List<Medico> listaMedicos = medNeg.obtenerMedicos(true);
		List<Paciente> listaPacientes = pacNeg.obtenerPacientes(true);
    	
		request.setAttribute("listaEspecialidades", listaEspecialidades);
		request.setAttribute("listaMedicos", listaMedicos);
		request.setAttribute("listaPacientes", listaPacientes);
		    
	    RequestDispatcher rd = request.getRequestDispatcher("/AdminAsignacionTurnos.jsp");
		rd.forward(request, response);
	}
	
	public void inicializarInicio(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<Turno> listaTurnos = turnoNegocio.obtenerTurnos();
		request.setAttribute("listaTurnos", listaTurnos);
		
		inicializarListas(request, response);
	}
	
	public void grabarTurno(HttpServletRequest request, HttpServletResponse response) throws ParseException, ServletException, IOException {
		if(request.getParameter("btnAsignar") != null) {
			Turno turno = new Turno();
			
			String fechaTurnoS = request.getParameter("fecha");
			String horaTurnoS = request.getParameter("ddlHorariosDisponibles");
			String fecha = fechaTurnoS + " " + horaTurnoS;
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	        Date fechaTurno = dateFormat.parse(fecha);
	        
	     
	        int codMed = Integer.parseInt(request.getParameter("ddlMedicos"));
	        int codPac = Integer.parseInt(request.getParameter("ddlPacientes"));
	        
	        turno.setFechaTurno(fechaTurno);
	        turno.getMedico().setCodMed(codMed);
	        turno.getPaciente().setCodPac(codPac);
	        turno.getEstado().setCodEstado_EST(2);
	        
	        boolean guardo = turnoNegocio.grabarTurno(turno);
	        
	        request.setAttribute("guardo", guardo);
	        inicializarAdminAsigTurnos(request,  response);
		}
	}
	
	private void inicializarListas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		EstadoTurnosNegocio estNeg = new EstadoTurnosNegocio();
		
		Map<String, String> listaFiltros = turnoNegocio.obtenerColumnas();
	    List<EstadoTurno> listaEstados = estNeg.obtenerEstados();
	    
	    request.setAttribute("listaFiltros", listaFiltros);
	    request.setAttribute("listaEstados", listaEstados);
	    
	    RequestDispatcher rd = request.getRequestDispatcher("/Inicio.jsp");
		rd.forward(request, response);
	}
	
	public void listarTurnosConFiltros(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String texto = request.getParameter("txtFiltro");
		String columna = request.getParameter("ddlFiltros");
		List<Turno> listaTurnos = turnoNegocio.obtenerTurnosPorFiltro(columna, texto);
		
		request.setAttribute("listaTurnos", listaTurnos);		
		inicializarListas(request, response);
	}
	
	public boolean cambiarEstado(String estadoS, String codTurnoAjaxS) throws ServletException, IOException {
		
		int codEstado = Integer.parseInt(estadoS);
		int codTurno = Integer.parseInt(codTurnoAjaxS);
		
		return turnoNegocio.cambiarEstado(codEstado, codTurno);

	}
}
