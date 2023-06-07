package neg;

import java.util.List;
import java.util.Map;

import entidades.Paciente;
import entidades.Provincia;

public interface IPacienteNegocio {
	public boolean insert(Paciente persona);
	public boolean update(Paciente persona);
    public boolean delete(String dni);
    public boolean existeDni(String dni);
    public List<Paciente> obtenerPacientes();
    public List<Paciente> obtenerPacientesPorFiltro(String columna, String text);
    public Map<String, String> obtenerColumnas();
}
