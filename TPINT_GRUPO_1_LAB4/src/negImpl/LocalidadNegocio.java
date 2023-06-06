package negImpl;

import daoImpl.LocalidadDao;
import entidades.Localidad;
import entidades.Provincia;
import neg.ILocalidadNegocio;

public class LocalidadNegocio implements ILocalidadNegocio{
	LocalidadDao pdao = new LocalidadDao();

	@Override
	public Localidad obtenerLocalidadPorCodigo(int codLocalidad) {
		return pdao.obtenerLocalidadPorCodigo(codLocalidad);
	}
	
	@Override
	public Provincia obtenerProvinciaPorLocalidad(int codLocalidad) {
		return pdao.obtenerProvinciaPorLocalidad(codLocalidad);
	}
}
