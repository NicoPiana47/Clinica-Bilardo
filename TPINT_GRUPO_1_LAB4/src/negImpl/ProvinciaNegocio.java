package negImpl;

import daoImpl.ProvinciaDao;
import entidades.Provincia;
import neg.IProvinciaNegocio;

public class ProvinciaNegocio implements IProvinciaNegocio{
	ProvinciaDao pdao = new ProvinciaDao();

	@Override
	public Provincia obtenerProvinciaPorCodigo(int codProvincia) {
		return pdao.obtenerProvinciaPorCodigo(codProvincia);
	}
}
