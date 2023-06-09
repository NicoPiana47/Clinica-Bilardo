package neg;

import java.util.List;


import entidades.Provincia;

public interface IProvinciaNegocio {
	public Provincia obtenerProvinciaPorCodigo(int codProvincia);
	public List<Provincia> obtenerProvincias();
}
