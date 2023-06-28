package servlets;

import java.io.IOException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializer;

import entidades.Especialidad;
import entidades.Localidad;
import entidades.Medico;
import entidades.MedicosXDias;
import entidades.Provincia;
import exceptions.DNIInvalidoException;
import exceptions.MailInvalidoException;
import negImpl.EspecialidadNegocio;
import negImpl.LocalidadNegocio;
import negImpl.MedicoNegocio;
import negImpl.ProvinciaNegocio;

@SuppressWarnings("serial")
@WebServlet("/servletMedicos")
public class servletMedicos extends HttpServlet {
	MedicoNegocio medicoNegocio = new MedicoNegocio();
	ProvinciaNegocio provinciaNegocio = new ProvinciaNegocio();
    LocalidadNegocio localidadNegocio = new LocalidadNegocio();
    EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
    
    public servletMedicos() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		inicializarModuloMedicos(request, response, null);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		iniciarSesion(request, response);
		eliminarMedico(request, response);
		listarMedicosConFiltro(request, response);
		crearMedico(request, response);
		editarMedico(request, response);
	}
	
	public void iniciarSesion(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession sessionMedico = request.getSession();
		Boolean iniciosesion = false;
		if(request.getParameter("btnIngresar")!=null) {
			sessionMedico.setAttribute("sessionMedico", null);
        	
			Medico med = medicoNegocio.iniciarSesion(request.getParameter("txtNombreUsuario"), request.getParameter("txtContraseña"));
			
        	if(med != null) {
        		sessionMedico.setAttribute("sessionMedico", med);
        		iniciosesion = true;
        	}
        	
        	RequestDispatcher rd = null;
        	
        	if (iniciosesion) {
        	    if (med.getTipo()) {
        	        inicializarModuloMedicos(request, response, null);
        	        return;
        	    } else {
        	        rd = request.getRequestDispatcher("/servletTurnos?ini=" + med.getCodMed());
        	    }
        	} else {
        	    rd = request.getRequestDispatcher("/Login.jsp");
        	}

        	request.setAttribute("inicioSesion", iniciosesion);
        	rd.forward(request, response);
        }
	}
	
	public void inicializarModuloMedicos(HttpServletRequest request, HttpServletResponse response, List<Medico> listaMedicos) throws ServletException, IOException {
		if(listaMedicos == null) {		
			List<Medico> listaMedicosCompleta = medicoNegocio.obtenerMedicos(false);
			request.setAttribute("listaMedicos", listaMedicosCompleta); 
		}
		else {
			request.setAttribute("listaMedicos", listaMedicos); 
		}
		
		inicializarListas(request);
    	RequestDispatcher rd = request.getRequestDispatcher("/AdminMedicos.jsp");  
		rd.forward(request, response);	
	}
	
	
	public void listarMedicosConFiltro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    if(request.getParameter("btnFiltrar")!=null || request.getParameter("btnLimpiarFiltros")!=null) {
	    	List<Medico> listaMedicos = null;
	    	
	    	if(request.getParameter("btnFiltrar")!=null) {
	    		String texto = request.getParameter("txtFiltro");
	    		String columna = request.getParameter("ddlFiltros");
	    		listaMedicos = medicoNegocio.obtenerMedicosPorFiltro(columna, texto);
	    	}
	    	
	    	if(request.getParameter("btnLimpiarFiltros")!=null) {
	    		listaMedicos = medicoNegocio.obtenerMedicos(false);
	    	}
	    	
	    	inicializarModuloMedicos(request, response, listaMedicos);
	    }
	}
	
	private void inicializarListas(HttpServletRequest request) {
        List<Localidad> listaLocalidades = localidadNegocio.obtenerLocalidades();
        List<Provincia> listaProvincias = provinciaNegocio.obtenerProvincias();
        List<Especialidad> listaEspecialidades = especialidadNegocio.obtenerEspecialidades();
        Map<String, String> listaFiltros = medicoNegocio.obtenerColumnas();
        
		request.setAttribute("listaLocalidades", listaLocalidades);
		request.setAttribute("listaProvincias", listaProvincias);
		request.setAttribute("listaEspecialidades", listaEspecialidades);	
		request.setAttribute("listaFiltros", listaFiltros); 
	}
	
	private void eliminarMedico(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("btnEliminar") != null) {
			int codMed = Integer.parseInt(request.getParameter("CodMed").toString());
			boolean elimino = medicoNegocio.eliminarMedico(codMed);
			request.setAttribute("elimino", elimino);
			inicializarModuloMedicos(request, response, null);
		}
	}
	
	private void crearMedico(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		if(request.getParameter("btnCrearMedico") != null) {
			try {			
				getHorarios(request);
				Medico medico = medicoNegocio.getMedico(request,true);
				int creo = medicoNegocio.crearMedico(medico);
				request.setAttribute("CrearMedico", creo);
			}
			catch(DNIInvalidoException ex) {
				request.setAttribute("CrearMedico", 2);
			}
			catch(MailInvalidoException ex) {
				request.setAttribute("CrearMedico", 3);
			}
			finally {
				inicializarModuloMedicos(request, response, null);	
			}
		}	
	}
	
	private void editarMedico(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		if(request.getParameter("btnEditarMedico") != null) {
			try {			
				getHorarios(request);
				Medico medico = medicoNegocio.getMedico(request,false);
				int edito = medicoNegocio.editarMedico(medico);
				request.setAttribute("edito", edito);
				  
				    HttpSession session = request.getSession();
		            Medico medicoSession = (Medico) session.getAttribute("sessionMedico");

		            if (edito == 1 && medicoSession != null && medico.getCodMed() == medicoSession.getCodMed()) {
		            	Medico medicoNuevo = medicoNegocio.obtenerMedicoPorUsername(medico.getUsername());
		            	medicoNegocio.convertirSetAJson(medicoNuevo);
		                session.setAttribute("sessionMedico", medicoNuevo);
		            }
		            
			}
			catch(DNIInvalidoException ex) {
				request.setAttribute("edito", 2);
			}
			catch(MailInvalidoException ex) {
				request.setAttribute("edito", 3);
			}
			finally {
				inicializarModuloMedicos(request, response, null);	
			}
		}	
	}
	
	private void getHorarios(HttpServletRequest request) {
		String datosJSON = request.getParameter("datosHorarios");
		if(!datosJSON.equals("null") && !datosJSON.isEmpty()) {
			if (!datosJSON.contains("hour")) {
				GsonBuilder gsonBuilder = new GsonBuilder();
				gsonBuilder.registerTypeAdapter(LocalTime.class, (JsonDeserializer<LocalTime>) (json, type, jsonDeserializationContext) -> {
				     String timeString = json.getAsJsonPrimitive().getAsString();
				     DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm", Locale.ENGLISH);
				     return LocalTime.parse(timeString, formatter);
				});
				Gson gson = gsonBuilder.create();
				
				MedicosXDias[] horariosArray = gson.fromJson(datosJSON, MedicosXDias[].class);
				List<MedicosXDias> listaHorarios = Arrays.asList(horariosArray);
				Set<MedicosXDias> treeSetHorarios = new TreeSet<>(listaHorarios);
				request.setAttribute("treeSetHorarios", treeSetHorarios);
			}
		}
	}

}

