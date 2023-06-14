package negImpl;

import java.util.List;

import daoImpl.LocalidadDao;
import entidades.Localidad;
import entidades.Provincia;
import neg.ILocalidadNegocio;

public class LocalidadNegocio implements ILocalidadNegocio{
	LocalidadDao localidadDao = new LocalidadDao();
	

	@Override
	public Localidad obtenerLocalidadPorCodigo(int codLocalidad) {
		return localidadDao.obtenerLocalidadPorCodigo(codLocalidad);
	}
	
	@Override
	public Provincia obtenerProvinciaPorLocalidad(int codLocalidad) {
		return localidadDao.obtenerProvinciaPorLocalidad(codLocalidad);
	}

	@Override
	public List<Localidad> obtenerLocalidades() {
		return localidadDao.readAll();
	}

	
	
}
