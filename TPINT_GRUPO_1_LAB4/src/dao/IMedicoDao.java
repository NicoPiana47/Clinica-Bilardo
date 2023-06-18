package dao;

import java.util.List;

import entidades.Medico;

public interface IMedicoDao {

	public Medico traerMedicoPorNombreUsuario (String username);
    public List<String> getColumns();
	public List<Medico> getMedicosByFilter(String column, String text);
	public boolean usernameRepetido(String username, int cod);
	
	public boolean delete(int codMed);
	public boolean create(Medico medico);
	public boolean update(Medico medico);
	public List<Medico> readAll(boolean sinInactivos);
}
