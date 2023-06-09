package dao;

import java.util.List;


import entidades.Provincia;

public interface IProvinciaDao {
	public Provincia obtenerProvinciaPorCodigo(int codProvincia);
	public List<Provincia> readAll();

}
