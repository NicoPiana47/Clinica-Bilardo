package dao;

import java.util.List;

import entidades.Medico;

public interface IMedicoDao {

	public Medico traerMedicoPorNombreUsuario (String username);
	public List<Medico> readAll();
    public List<String> getColumns();
	public List<Medico> getMedicosByFilter(String column, String text);
	
	public boolean delete(int codMed);
}
