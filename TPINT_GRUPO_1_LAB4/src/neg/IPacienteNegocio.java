package neg;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import entidades.Paciente;
import entidades.Provincia;

public interface IPacienteNegocio {
    public List<Paciente> obtenerPacientes();
    public List<Paciente> obtenerPacientesPorFiltro(String columna, String text);
    public Map<String, String> obtenerColumnas();
	public int guardar(Paciente unPaciente);
	public Paciente getPacienteCrear(HttpServletRequest request);
	public boolean eliminarPaciente(int codMed);
	public Paciente getPacienteEditar(HttpServletRequest request);
	public int editarPaciente(Paciente unPaciente);
}
