package dao;

import java.util.List;

import entidades.Medico;
import entidades.Paciente;

public interface IMedicoDao {

	public Medico traerMedicoPorNombreUsuario (String username);
	public List<Medico> readAll();
}
