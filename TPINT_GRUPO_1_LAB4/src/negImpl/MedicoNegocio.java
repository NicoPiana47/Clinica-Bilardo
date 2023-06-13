package negImpl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import daoImpl.MedicoDao;
import entidades.Especialidad;
import entidades.Localidad;
import entidades.Medico;
import entidades.Paciente;
import entidades.Provincia;
import neg.IMedicoNegocio;

public class MedicoNegocio extends GeneralNegocio implements IMedicoNegocio{
	MedicoDao mDao = new MedicoDao();
	
	
	@Override
	public Medico iniciarSesion(String username, String contraseña) {
		Medico med = new Medico();
		
		if (!username.isEmpty() || !contraseña.isEmpty()) {
    		
			med= mDao.traerMedicoPorNombreUsuario(username);
			if(med != null && med.getContraseña() != null && med.getContraseña().equals(contraseña)) {
				return med;
			}
    	}
		
		return null;
	}


	@Override
	public List<Medico> obtenerMedicos() {
		return mDao.readAll();
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
	public boolean eliminarMedico(int codMed) {
		boolean elimino = mDao.delete(codMed);
		return elimino;
	}


	@Override
	public boolean crearMedico(Medico medico) {
		boolean agregado = mDao.create(medico);
		return agregado;
	}


	@Override
	public Medico getMedicoEditar(HttpServletRequest request) {
		int codMed = Integer.parseInt(request.getParameter("codMed"));
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
		Boolean Tipo = request.getParameter("rdTipo").equals("1");
		
	    return new Medico(codMed,dni,especialidad,localidad,provincia,correo,usuario,contraseña,nombre,apellido,sexo,nacionalidad,fechaNac,direccion,telefono,Tipo,estado);
	   
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
	        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	        return dateFormat.parse(fechaNacString);
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }
	    return null;
	}


	@Override
	public boolean editarMedico(Medico medico) {
		boolean update = mDao.update(medico);
		return update;
	}

	
	

}
