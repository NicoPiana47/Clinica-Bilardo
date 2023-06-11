package neg;

import java.util.List;
import java.util.Map;

import entidades.Medico;
import entidades.Paciente;

public interface IMedicoNegocio {
	public Medico iniciarSesion(String usurname, String contraseña);
	public List<Medico> obtenerMedicos();
	public List<Medico>obtenerMedicosPorFiltro(String columna, String texto);
	Map<String, String> obtenerColumnas();
	
	public boolean eliminarMedico(int codMed);
}
