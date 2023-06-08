package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import conexión.Conexion;
import dao.IEspecialidadDao;
import entidades.Especialidad;

public class EspecialidadDao implements IEspecialidadDao{
	private static final String obtenerLocalidad = " SELECT CodEspecialidad_ESP, Descripcion_ESP FROM Medicos "
			+ "INNER JOIN Especialidades ON CodEspecialidad_MED = CodEspecialidad_ESP WHERE CodMed_MED = ?";

	@Override
	public Especialidad obtenerEspecialidadPorCodigo(int codMedico) {
		Connection conexion = Conexion.getConexion().getSQLConexion();
		Especialidad unaEspecialidad = new Especialidad();
		ResultSet resultado = null;
		try{
			PreparedStatement statement = conexion.prepareStatement(obtenerLocalidad);
	        statement.setInt(1, codMedico);
	        resultado = statement.executeQuery();      
			
	        if (resultado.next()) {
	        	unaEspecialidad.setCodEspecialidad_ESP(resultado.getInt("CodEspecialidad_ESP"));
	        	unaEspecialidad.setDescripcion_ESP(resultado.getString("Descripcion_ESP"));
	        }

		}
		catch (Exception e) {
			
		}
	
		return unaEspecialidad;
	}
}
