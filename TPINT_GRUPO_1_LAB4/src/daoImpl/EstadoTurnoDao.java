package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import conexión.Conexion;
import dao.IEstadoTurnoDao;
import entidades.Especialidad;
import entidades.EstadoTurno;

public class EstadoTurnoDao implements IEstadoTurnoDao {
	private static final String readall = "SELECT * FROM EstadosTurno WHERE Descripcion_EST <> 'Ocupado' AND Descripcion_EST <> 'Libre'";
	@Override
	public List<EstadoTurno> readAll() {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<EstadoTurno> estado = new ArrayList<EstadoTurno>();

		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			statement = conexion.prepareStatement(readall);
			resultSet = statement.executeQuery();
			while(resultSet.next()) {
				estado.add(getEstados(resultSet));
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return estado;
	}
	
	private EstadoTurno getEstados(ResultSet resultSet) throws SQLException {
	    int codEstado = resultSet.getInt("CodEstado_EST");
	    String descripcion = resultSet.getString("Descripcion_EST");
	    
	    return new EstadoTurno(codEstado, descripcion);
	}

}
