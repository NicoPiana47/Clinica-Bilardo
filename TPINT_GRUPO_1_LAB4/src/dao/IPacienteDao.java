package dao;

import java.util.List;

import entidades.Paciente;

public interface IPacienteDao {
    public List<Paciente> readAll(boolean sinInactivos);
    public List<Paciente> getPacientesByFilter(String column, String text);
    public List<String> getColumns();
	public boolean insert(Paciente paciente);
	public boolean delete(int codMed);
	public boolean update(Paciente paciente);
    
    
}
