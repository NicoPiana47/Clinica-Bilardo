package neg;

import java.util.List;

import entidades.Medico;
import entidades.Paciente;

public interface IMedicoNegocio {
	public Medico iniciarSesion(String usurname, String contraseña);
	public List<Medico> obtenerMedicos();
}
