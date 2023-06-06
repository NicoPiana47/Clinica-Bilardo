package dao;

import entidades.Localidad;
import entidades.Provincia;

public interface ILocalidadDao {
	public Localidad obtenerLocalidadPorCodigo(int codLocalidad);
	public Provincia obtenerProvinciaPorLocalidad(int codLocalidad);
}
