package neg;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import entidades.Medico;


public interface IMedicoNegocio {
	public Medico iniciarSesion(String usurname, String contrase�a);
	public List<Medico> obtenerMedicos();
	public List<Medico>obtenerMedicosPorFiltro(String columna, String texto);
	Map<String, String> obtenerColumnas();
	public Medico getMedico(HttpServletRequest request,boolean isCreating);
	public boolean editarMedico(Medico medico);
	public boolean eliminarMedico(int codMed);
	public boolean crearMedico(Medico medico);
	
	
	
	
}
