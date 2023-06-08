package neg;

import java.util.List;
import java.util.Map;

import entidades.Medico;
import entidades.Paciente;

public interface IMedicoNegocio {
	public Medico iniciarSesion(String usurname, String contraseņa);
	public List<Medico> obtenerMedicos();
	public Map<String, String> obtenerColumnas();
	public List<Medico>obtenerMedicosPorFiltro(String columna, String texto);
}
