package neg;

import java.util.List;

import entidades.Medico;
import entidades.Paciente;

public interface IMedicoNegocio {
	public Medico iniciarSesion(String usurname, String contrase�a);
	public List<Medico> obtenerMedicos();
}
