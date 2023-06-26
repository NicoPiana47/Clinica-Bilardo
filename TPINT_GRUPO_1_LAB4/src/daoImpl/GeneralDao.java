package daoImpl;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexión.Conexion;
import entidades.Medico;

public class GeneralDao {

	public List<String> getColumns(String tabla, String... columnasCodigo) {
		List<String> nombresColumnas = new ArrayList<>();
		Connection conexion = Conexion.getConexion().getSQLConexion();

	    try {
	        DatabaseMetaData metaData = conexion.getMetaData();
	        ResultSet rs = metaData.getColumns(null, null, tabla, null);
	        
	        while (rs.next()) {
	            String nombreColumna = rs.getString("COLUMN_NAME");
	      
	            boolean omitirColumna = false;
	            for (String columnaCodigo : columnasCodigo) {
	                if (nombreColumna.equals(columnaCodigo)) {
	                    omitirColumna = true;
	                    break;
	                }
	            }

	            if (!omitirColumna) {
	                nombresColumnas.add(nombreColumna);
	            }
	        }
	    } 
	    catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return nombresColumnas;
	}
	
	public boolean dniRepetido(String DNI, int cod) {		
		Connection cn = Conexion.getConexion().getSQLConexion();
		Medico x = new Medico();
		boolean repetido = true;
		  try
		  {
			 String query = "SELECT CASE "
			 		+ "WHEN EXISTS (SELECT 1 FROM Medicos WHERE DNI_MED = ? AND CodMed_MED <> ?) "
			 		+ "THEN 1 "
			 		+ "WHEN EXISTS (SELECT 1 FROM Pacientes WHERE DNI_PAC = ? AND CodPac_PAC <> ?) "
			 		+ "THEN 1 "
			 		+ "ELSE 0 "
			 		+ "END AS Repetido;";
			 
			 PreparedStatement st = cn.prepareStatement(query);
			 st.setString(1, DNI);
			 st.setInt(2, cod);
			 st.setString(3, DNI);
			 st.setInt(4, cod);
			 ResultSet rs = st.executeQuery();
			
			 while(rs.next()) {
				 repetido = rs.getBoolean("Repetido");		
			 }				 
		  }
		  catch (Exception e) {
				e.printStackTrace();
		  }
		  finally  {
			  
		  }
		return repetido;	
	}
	
	public boolean correoRepetido(String correo, int cod) {		
		Connection cn = Conexion.getConexion().getSQLConexion();
		Medico x = new Medico();
		boolean repetido = true;
		  try
		  {
			 String query = "SELECT CASE "
			 		+ "WHEN EXISTS (SELECT 1 FROM Medicos WHERE Correo_MED = ? AND CodMed_MED <> ?) "
			 		+ "THEN 1 "
			 		+ "WHEN EXISTS (SELECT 1 FROM Pacientes WHERE Correo_PAC = ? AND CodPac_PAC <> ?) "
			 		+ "THEN 1 "
			 		+ "ELSE 0 "
			 		+ "END AS Repetido;";
			 
			 PreparedStatement st = cn.prepareStatement(query);
			 st.setString(1, correo);
			 st.setInt(2, cod);
			 st.setString(3, correo);
			 st.setInt(4, cod);
			 ResultSet rs = st.executeQuery();
			
			 while(rs.next()) {
				 repetido = rs.getBoolean("Repetido");		
			 }				 
		  }
		  catch (Exception e) {
				e.printStackTrace();
		  }
		  finally  {
			  
		  }
		return repetido;	
	}
	
}
