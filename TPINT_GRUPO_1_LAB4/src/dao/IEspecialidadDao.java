package dao;

import java.util.List;

import entidades.Especialidad;

public interface IEspecialidadDao {
	public Especialidad obtenerEspecialidadPorCodigo(int codMedico);
	public List<Especialidad> readAll();
		
}
