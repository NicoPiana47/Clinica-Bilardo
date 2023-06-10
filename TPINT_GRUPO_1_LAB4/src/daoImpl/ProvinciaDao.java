package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import conexión.Conexion;
import dao.IProvinciaDao;
import entidades.Especialidad;
import entidades.Localidad;
import entidades.Medico;
import entidades.Provincia;

public class ProvinciaDao implements IProvinciaDao{
	private static final String obtenerProvincia = "SELECT * FROM provincias WHERE CodProvincia_PROV = ?";
	private static final String readall = "SELECT * FROM provincias";
	
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

	@Override
	public List<Provincia> readAll() {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Provincia> provincias = new ArrayList<Provincia>();

		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			statement = conexion.prepareStatement(readall);
			resultSet = statement.executeQuery();
			while(resultSet.next()) {
				provincias.add(getProvincia(resultSet));
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return provincias;
	}

	
	private Provincia getProvincia(ResultSet resultSet) throws SQLException {
		
	    int codProvincia = resultSet.getInt("CodProvincia_PROV");
	    String descripcion = resultSet.getString("Descripcion_PROV");
	    
	    return new Provincia(codProvincia, descripcion);
	}
}
