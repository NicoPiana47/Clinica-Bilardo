package negImpl;

import java.util.List;

import daoImpl.LocalidadDao;
import entidades.Localidad;
import entidades.Provincia;
import neg.ILocalidadNegocio;

public class LocalidadNegocio implements ILocalidadNegocio{
	LocalidadDao ldao = new LocalidadDao();
	

	@Override
	public Localidad obtenerLocalidadPorCodigo(int codLocalidad) {
		return ldao.obtenerLocalidadPorCodigo(codLocalidad);
	}
	
	@Override
	public Provincia obtenerProvinciaPorLocalidad(int codLocalidad) {
		return ldao.obtenerProvinciaPorLocalidad(codLocalidad);
	}

	@Override
	public List<Localidad> obtenerLocalidades(int codProvincia) {
		// TODO Auto-generated method stub
		return ldao.obtenerLocalidadesPorProvincia(codProvincia);
	}

	
	
}
