package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conexión.Conexion;
import dao.ILocalidadDao;
import entidades.Localidad;
import entidades.Provincia;

public class LocalidadDao implements ILocalidadDao {
	private static final String obtenerLocalidad = "SELECT * FROM localidades WHERE CodLocalidad_LOC = ?";
	private static final String obtenerProvincia = " SELECT CodProvincia_PROV, Descripcion_PROV FROM Provincias INNER JOIN "
				                                   + "Localidades ON CodProvincia_PROV = CodProvincia_LOC WHERE CodLocalidad_LOC = ?";

	@Override
	public Localidad obtenerLocalidadPorCodigo(int codLocalidad) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		Localidad unaLocalidad = new Localidad();
		ResultSet resultado = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(obtenerLocalidad);
	        statement.setInt(1, codLocalidad);
	        resultado = statement.executeQuery();      
			
	        if (resultado.next()) {
	        	unaLocalidad.setCodLocalidad(resultado.getInt("CodLocalidad_LOC"));
	            unaLocalidad.setDescripcion(resultado.getString("Descripcion_LOC"));
	            unaLocalidad.setProvincia(obtenerProvinciaPorLocalidad(resultado.getInt("CodLocalidad_LOC")));
	        }

		}
		catch (Exception e) {
			
		}
	
		return unaLocalidad;
	}

	public Provincia obtenerProvinciaPorLocalidad(int codLocalidad) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		Provincia unaProvincia = new Provincia();
		ResultSet resultado = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(obtenerProvincia);
	        statement.setInt(1, codLocalidad);
	        resultado = statement.executeQuery();      
			
	        if (resultado.next()) {
	            unaProvincia.setCodProvincia(resultado.getInt("CodProvincia_PROV"));
	            unaProvincia.setDescripcion(resultado.getString("Descripcion_PROV"));
	        }
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			
		}
		
		return unaProvincia;
	}

}
