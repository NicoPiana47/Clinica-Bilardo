package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexión.Conexion;
import dao.IEspecialidadDao;
import entidades.Especialidad;

public class EspecialidadDao implements IEspecialidadDao{
	private static final String obtenerEspecialidad = " SELECT CodEspecialidad_ESP, Descripcion_ESP FROM Medicos "
			+ "INNER JOIN Especialidades ON CodEspecialidad_MED = CodEspecialidad_ESP WHERE CodMed_MED = ?";
	private static final String readall = "SELECT * FROM especialidades";

	@Override
	public Especialidad obtenerEspecialidadPorCodigo(int codMedico) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		Especialidad unaEspecialidad = new Especialidad();
		ResultSet resultado = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(obtenerEspecialidad);
	        statement.setInt(1, codMedico);
	        resultado = statement.executeQuery();      
			
	        if (resultado.next()) {
	        	unaEspecialidad.setCodEspecialidad(resultado.getInt("CodEspecialidad_ESP"));
	        	unaEspecialidad.setDescripcion(resultado.getString("Descripcion_ESP"));
	        }

		}
		catch (Exception e) {
			
		}
	
		return unaEspecialidad;
	}
	
	@Override
	public List<Especialidad> readAll() {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Especialidad> especialidad = new ArrayList<Especialidad>();

		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			statement = conexion.prepareStatement(readall);
			resultSet = statement.executeQuery();
			while(resultSet.next()) {
				especialidad.add(getEspecialidad(resultSet));
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return especialidad;
	}

	private Especialidad getEspecialidad(ResultSet resultSet) throws SQLException {
	    int codEspecialidad = resultSet.getInt("CodEspecialidad_ESP");
	    String descripcion = resultSet.getString("Descripcion_ESP");
	    
	    return new Especialidad(codEspecialidad, descripcion);
	}
}
