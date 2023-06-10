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
		ResultSet resultado = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(obtenerLocalidad);
	        statement.setInt(1, codLocalidad);
	        resultado = statement.executeQuery();      
			
	        if (resultado.next()) {
	        	unaLocalidad.setCodLocalidad(resultado.getInt("CodLocalidad_LOC"));
	            unaLocalidad.setDescripcion(resultado.getString("Descripcion_LOC"));
	            unaLocalidad.setProvincia(obtenerProvinciaPorLocalidad(resultado.getInt("CodProvincia_LOC")));
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

	@Override
	public List<Localidad> obtenerLocalidadesPorProvincia(int codProvincia) {
		 Connection conexion = Conexion.getConexion().getSQLConexion();
		    List<Localidad> listaLocalidades = new ArrayList<>();
		    ResultSet resultado = null;
		    try {
		        String obtenerLocalidades = "SELECT * FROM localidades WHERE CodProvincia_LOC = ?";
		        PreparedStatement statement = conexion.prepareStatement(obtenerLocalidades);
		        statement.setInt(1, codProvincia);
		        resultado = statement.executeQuery();
		        
		        while (resultado.next()) {
		            Localidad localidad = new Localidad();
		            localidad.setCodLocalidad(resultado.getInt("CodLocalidad_LOC"));
		            localidad.setDescripcion(resultado.getString("Descripcion_LOC"));
		            localidad.setProvincia(obtenerProvinciaPorLocalidad(resultado.getInt("CodProvincia_LOC")));
		            listaLocalidades.add(localidad);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    } finally {
		        
		        }
		    
		    return listaLocalidades;
	}

	public List<Localidad> obtenerLocalidades() {
		Connection conexion = Conexion.getConexion().getSQLConexion();
	    List<Localidad> localidades = new ArrayList<>();
		ResultSet resultado = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(readall);
	        resultado = statement.executeQuery();      
			
	        
			while(resultado.next()) {
				Localidad unaLocalidad = new Localidad();
	        	unaLocalidad.setCodLocalidad(resultado.getInt("CodLocalidad_LOC"));
	            unaLocalidad.setDescripcion(resultado.getString("Descripcion_LOC"));
	            unaLocalidad.setProvincia(obtenerProvinciaPorLocalidad(resultado.getInt("CodProvincia_LOC")));
	            localidades.add(unaLocalidad);
			}

		}
		catch (Exception e) {
			
		}
	
		return localidades;
	}

}
