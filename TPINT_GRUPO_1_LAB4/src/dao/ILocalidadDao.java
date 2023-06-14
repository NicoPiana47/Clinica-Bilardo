package dao;

import java.util.List;

import entidades.Localidad;
import entidades.Provincia;

public interface ILocalidadDao {
	public Localidad obtenerLocalidadPorCodigo(int codLocalidad);
	public Provincia obtenerProvinciaPorLocalidad(int codLocalidad);
	public List<Localidad> readAll();
}
