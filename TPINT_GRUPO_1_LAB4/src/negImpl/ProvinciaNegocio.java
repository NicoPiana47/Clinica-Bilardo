package negImpl;

import java.util.List;

import daoImpl.ProvinciaDao;
import entidades.Provincia;
import neg.IProvinciaNegocio;

public class ProvinciaNegocio implements IProvinciaNegocio{
	ProvinciaDao pdao = new ProvinciaDao();

	@Override
	public Provincia obtenerProvinciaPorCodigo(int codProvincia) {
		return pdao.obtenerProvinciaPorCodigo(codProvincia);
	}

	@Override
	public List<Provincia> obtenerProvincias() {
		return pdao.readAll();
		
	}

}
