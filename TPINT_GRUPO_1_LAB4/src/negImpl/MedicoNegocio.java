package negImpl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import daoImpl.GeneralDao;
import daoImpl.MedicoDao;
import entidades.Especialidad;
import entidades.Localidad;
import entidades.Medico;
import entidades.MedicosXDias;
import entidades.Provincia;
import exceptions.DNIInvalidoException;
import exceptions.MailInvalidoException;
import neg.IMedicoNegocio;

public class MedicoNegocio extends GeneralNegocio implements IMedicoNegocio{
	MedicoDao mDao = new MedicoDao();
	GeneralDao gDao = new GeneralDao();
	
	@Override
	public Medico iniciarSesion(String username, String contraseña) {
		Medico med = new Medico();
		
		if (!username.isEmpty() && !contraseña.isEmpty()) {
    		
			med= mDao.traerMedicoPorNombreUsuario(username);
			if(med != null && med.getContraseña() != null && med.getContraseña().equals(contraseña)) {
				convertirSetAJson(med);
				return med;
			}
    	}
		
		return null;
	}
	@Override
	public Medico obtenerMedicoPorUsername(String username) {		
		return mDao.traerMedicoPorNombreUsuario(username);
	}

	public void convertirSetAJson(Medico medico) {
		Gson gson = new GsonBuilder().create();
		Set<MedicosXDias> horarios = medico.getHorarios();
        String horariosJson = gson.toJson(horarios);
        medico.setHorariosJson(horariosJson);
	}

	@Override
	public List<Medico> obtenerMedicos(boolean sinInactivos) {
	    List<Medico> medicos = mDao.readAll(sinInactivos);

	    for (Medico medico : medicos) {
	    	convertirSetAJson(medico);
	    }

	    return medicos;
	}

	@Override
    public Map<String, String> obtenerColumnas() {
        List<String> columnasList = mDao.getColumns();
        return super.obtenerColumnas("_MED", columnasList);
    }

	@Override
	public List<Medico> obtenerMedicosPorFiltro(String columna, String texto) {
		return mDao.getMedicosByFilter(columna, texto);
	}

	@Override
	public Medico getMedico(HttpServletRequest request,boolean isCreating) {
		int codMed = 0;
	    if (!isCreating) {
	        String codMedParam = request.getParameter("codMed");
	        if (codMedParam != null && !codMedParam.isEmpty()) {
	            codMed = Integer.parseInt(codMedParam);
	        }
	    }		
	    
	    Set<MedicosXDias> horarios = (Set<MedicosXDias>) request.getAttribute("treeSetHorarios");
		String dni = request.getParameter("txtDNI");    
		String contraseña = request.getParameter("txtContraseña");    
		String usuario = request.getParameter("txtUsuario");  
		Provincia provincia = createProvinciaFromRequest(request);
	    Localidad localidad = createLocalidadFromRequest(request);
	    Especialidad especialidad=createEspecialidadFromRequest(request);
		String nombre = request.getParameter("txtNombre");
		String apellido = request.getParameter("txtApellido");
		String correo = request.getParameter("txtCorreo");
		String sexo = request.getParameter("ddlSexo");
		String nacionalidad = request.getParameter("txtNacionalidad");
		Date fechaNac = parseDate(request);
		String direccion = request.getParameter("txtDireccion");
		String telefono = request.getParameter("txtTelefono");
		Boolean estado = request.getParameter("rdEstado").equals("1");
		Boolean tipo = request.getParameter("rdTipo").equals("1");
		
	    return new Medico(codMed, dni, especialidad, localidad, provincia, correo, usuario, 
	    			contraseña, nombre, apellido, sexo, nacionalidad, fechaNac, direccion, 
	    			telefono, tipo, estado, horarios);
	   
	}
	
	private Especialidad createEspecialidadFromRequest(HttpServletRequest request) {
		int codigoEspecialidad=Integer.parseInt(request.getParameter("ddlEspecialidad"));
		Especialidad especialidad=new Especialidad();
		especialidad.setCodEspecialidad(codigoEspecialidad);
		return especialidad;
	}
	
	private Provincia createProvinciaFromRequest(HttpServletRequest request) {
	    int codigoProvincia = Integer.parseInt(request.getParameter("ddlProvincia"));
	    Provincia provincia = new Provincia();
	    provincia.setCodProvincia(codigoProvincia);
	    return provincia;
	}

	private Localidad createLocalidadFromRequest(HttpServletRequest request) {
	    int codigoLocalidad = Integer.parseInt(request.getParameter("ddlLocalidad"));
	    Localidad localidad = new Localidad();
	    localidad.setCodLocalidad(codigoLocalidad);
	    return localidad;
	}
	
	private Date parseDate(HttpServletRequest request) {
	    try {
	        String fechaNacString = request.getParameter("txtFechaNacimiento");
	        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
	        return dateFormat.parse(fechaNacString);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	@Override
	public boolean eliminarMedico(int codMed) {
		boolean elimino = mDao.delete(codMed);
		return elimino;
	}
	
	@Override
	public int crearMedico(Medico medico) throws DNIInvalidoException, MailInvalidoException {
		DNIInvalidoException excDNI = new DNIInvalidoException();
		MailInvalidoException excMail = new MailInvalidoException();
		if(gDao.dniRepetido(medico.getDNI(), medico.getCodMed())) throw excDNI;
		if(gDao.correoRepetido(medico.getCorreo(), medico.getCodMed())) throw excMail;
		if(mDao.usernameRepetido(medico.getUsername(), medico.getCodMed())) return 4;
		if(mDao.create(medico)) return 1;
		else return 0;
	}

	@Override
	public int editarMedico(Medico medico) throws DNIInvalidoException, MailInvalidoException {
		DNIInvalidoException excDNI = new DNIInvalidoException();
		MailInvalidoException excMail = new MailInvalidoException();
		if(gDao.dniRepetido(medico.getDNI(), medico.getCodMed())) throw excDNI;
		if(gDao.correoRepetido(medico.getCorreo(), medico.getCodMed())) throw excMail;
		if(mDao.usernameRepetido(medico.getUsername(), medico.getCodMed())) return 4;
		if(mDao.update(medico)) return 1;
		else return 0;
	}

	
}
