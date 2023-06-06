package neg;

import entidades.Localidad;
import entidades.Provincia;

public interface ILocalidadNegocio {
	public Localidad obtenerLocalidadPorCodigo(int codLocalidad);
	public Provincia obtenerProvinciaPorLocalidad(int codLocalidad);
}
