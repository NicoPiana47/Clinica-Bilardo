package daoImpl;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import conexión.Conexion;
import dao.IPacienteDao;
import entidades.Localidad;
import entidades.Paciente;
import entidades.Provincia;

public class GeneralDao {

	public List<String> getColumns(String tabla, String columnaCodigo) {
		List<String> nombresColumnas = new ArrayList<>();
		Connection conexion = Conexion.getConexion().getSQLConexion();

	    try {
	        DatabaseMetaData metaData = conexion.getMetaData();
	        ResultSet rs = metaData.getColumns(null, null, tabla, null);
	        
	        while (rs.next()) {
	            String nombreColumna = rs.getString("COLUMN_NAME");
	            
	            if(!nombreColumna.equals(columnaCodigo)) {
		            nombresColumnas.add(nombreColumna);
	            }
	        }
	    } 
	    catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return nombresColumnas;
	}
	
}
