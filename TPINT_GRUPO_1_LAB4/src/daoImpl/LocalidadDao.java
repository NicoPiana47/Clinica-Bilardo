package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexión.Conexion;
import dao.ILocalidadDao;
import entidades.Localidad;
import entidades.Provincia;

public class LocalidadDao implements ILocalidadDao {
	private static final String obtenerLocalidad = "SELECT * FROM localidades WHERE CodLocalidad_LOC = ?";
	private static final String obtenerProvincia = "SELECT * FROM provincias WHERE CodProvincia_PROV = ?";
	private static final String readall = "SELECT * FROM localidades";

	@Override
	public Localidad obtenerLocalidadPorCodigo(int codLocalidad) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		Localidad unaLocalidad = new Localidad();
		ResultSet resultSet = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(obtenerLocalidad);
	        statement.setInt(1, codLocalidad);
	        resultSet = statement.executeQuery();      
			
	        if (resultSet.next()) {
	        	unaLocalidad.setCodLocalidad(resultSet.getInt("CodLocalidad_LOC"));
	            unaLocalidad.setDescripcion(resultSet.getString("Descripcion_LOC"));
	            unaLocalidad.setProvincia(obtenerProvinciaPorLocalidad(resultSet.getInt("CodProvincia_LOC")));
	        }

		}
		catch (Exception e) {
			
		}
	
		return unaLocalidad;
	}

	public Provincia obtenerProvinciaPorLocalidad(int codLocalidad) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		Provincia unaProvincia = new Provincia();
		ResultSet resultSet = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(obtenerProvincia);
	        statement.setInt(1, codLocalidad);
	        resultSet = statement.executeQuery();      
			
	        if (resultSet.next()) {
	            unaProvincia.setCodProvincia(resultSet.getInt("CodProvincia_PROV"));
	            unaProvincia.setDescripcion(resultSet.getString("Descripcion_PROV"));
	        }
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			
		}
		
		return unaProvincia;
	}

	@Override
	public List<Localidad> obtenerLocalidadesPorProvincia(int codProvincia) {
		 Connection conexion = Conexion.getConexion().getSQLConexion();
		    List<Localidad> listaLocalidades = new ArrayList<>();
		    ResultSet resultSet = null;
		    try {
		        String obtenerLocalidades = "SELECT * FROM localidades WHERE CodProvincia_LOC = ?";
		        PreparedStatement statement = conexion.prepareStatement(obtenerLocalidades);
		        statement.setInt(1, codProvincia);
		        resultSet = statement.executeQuery();
		        
		        while (resultSet.next()) {
		            Localidad localidad = new Localidad();
		            localidad.setCodLocalidad(resultSet.getInt("CodLocalidad_LOC"));
		            localidad.setDescripcion(resultSet.getString("Descripcion_LOC"));
		            localidad.setProvincia(obtenerProvinciaPorLocalidad(resultSet.getInt("CodProvincia_LOC")));
		            listaLocalidades.add(localidad);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        
		        }
		    
		    return listaLocalidades;
	}

	public List<Localidad> readAll() {
		Connection conexion = Conexion.getConexion().getSQLConexion();
	    List<Localidad> localidades = new ArrayList<>();
		ResultSet resultSet = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(readall);
	        resultSet = statement.executeQuery();      
			
			while(resultSet.next()) {
	            localidades.add(getLocalidad(resultSet));
			}

		}
		catch (Exception e) {
			
		}
	
		return localidades;
	}
	
	private Localidad getLocalidad(ResultSet resultSet) throws SQLException {
		
	    int codLocalidad = resultSet.getInt("CodLocalidad_LOC");
	    String descripcion = resultSet.getString("Descripcion_LOC");
	    Provincia provincia = obtenerProvinciaPorLocalidad(resultSet.getInt("CodProvincia_LOC"));
	    
	    return new Localidad(codLocalidad, descripcion, provincia);
	}

}
