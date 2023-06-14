package neg;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import entidades.Medico;


public interface IMedicoNegocio {
	public Medico iniciarSesion(String usurname, String contraseņa);
	public List<Medico> obtenerMedicos();
	public List<Medico>obtenerMedicosPorFiltro(String columna, String texto);
	Map<String, String> obtenerColumnas();
	public Medico getMedico(HttpServletRequest request,boolean isCreating);
	public int editarMedico(Medico medico);
	public boolean eliminarMedico(int codMed);
	public int crearMedico(Medico medico);
	
	
	
	
}
