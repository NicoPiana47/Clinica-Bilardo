package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import conexión.Conexion;
import dao.IProvinciaDao;
import entidades.Provincia;

public class ProvinciaDao implements IProvinciaDao{
	private static final String obtenerProvincia = "SELECT * FROM provincias WHERE CodProvincia_PROV = ?";

	public Provincia obtenerProvinciaPorCodigo(int codProvincia) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		Provincia unaProvincia = new Provincia();
		try{
			PreparedStatement statement = conexion.prepareStatement(obtenerProvincia);
	        statement.setInt(1, codProvincia);
	        ResultSet resultado = statement.executeQuery();      
			
	        if (resultado.next()) {
	            unaProvincia.setCodProvincia(resultado.getInt("CodProvincia_PROV"));
	            unaProvincia.setDescripcion(resultado.getString("Descripcion_PROV"));
	        }
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				conexion.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return unaProvincia;
	}
}
