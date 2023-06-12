package dao;

import java.util.List;

import entidades.Paciente;

public interface IPacienteDao {
	/*public boolean insert(Paciente persona);
	public boolean update(Paciente persona);
    public boolean delete(String dni);
    public boolean existeDni(String dni);*/
    public List<Paciente> readAll();
    public List<Paciente> getPacientesByFilter(String column, String text);
    public List<String> getColumns();
	public boolean insert(Paciente paciente);
    
    
}
