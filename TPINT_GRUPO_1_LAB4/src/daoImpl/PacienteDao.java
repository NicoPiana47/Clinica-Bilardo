package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import conexión.Conexion;
import dao.IPacienteDao;
import entidades.Localidad;
import entidades.Paciente;
import entidades.Provincia;

public class PacienteDao extends GeneralDao implements IPacienteDao {
	private static final String insert = "INSERT INTO pacientes(DNI_PAC, CodLocalidad_PAC, CodProvincia_PAC, Nombre_PAC, Apellido_PAC, Correo_PAC, Sexo_PAC, Nacionalidad_PAC, FechaNacimiento_PAC, Direccion_PAC, Telefono_PAC) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String delete = "UPDATE pacientes SET Estado_PAC = 0 WHERE CodPac_PAC = ?";
	private static final String readall = "SELECT * FROM pacientes";
	private static final String update = "UPDATE pacientes SET DNI_PAC = ?, CodLocalidad_PAC = ?, CodProvincia_PAC = ?, Nombre_PAC = ?, Apellido_PAC = ?, Correo_PAC = ?, Sexo_PAC = ?, Nacionalidad_PAC = ?, FechaNacimiento_PAC = ?, Direccion_PAC = ?, Telefono_PAC = ?, Estado_PAC = ? WHERE CodPac_PAC = ?";

	@Override
	public List<Paciente> readAll(boolean sinInactivos) {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Paciente> pacientes = new ArrayList<Paciente>();

		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			if (sinInactivos) {
	            statement = conexion.prepareStatement(readall + " WHERE Estado_PAC = '1'");
	        } else {
	            statement = conexion.prepareStatement(readall);
	        }
			resultSet = statement.executeQuery();
			while(resultSet.next()) {
				pacientes.add(getPaciente(resultSet));
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return pacientes;
	}
	
	@Override
	public List<String> getColumns() {
	    return super.getColumns("pacientes", "CodPac_PAC");
	}
	
	@Override
	public List<Paciente> getPacientesByFilter(String column, String text) {

		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Paciente> pacientes = new ArrayList<Paciente>();
		Connection conexion = Conexion.getConexion().getSQLConexion();
		
		try{
			String query = createQueryFiltersPacientes(column);
			
			statement = conexion.prepareStatement(query);
	        statement.setString(1, "%" + text + "%");
	        
	        resultSet = statement.executeQuery();      
			
			while(resultSet.next()){
				pacientes.add(getPaciente(resultSet));
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return pacientes;
	}
	
	private String createQueryFiltersPacientes(String column) {
		Map<String, String> columnMappings = new HashMap<>();
		String query = "SELECT * FROM pacientes p";

		columnMappings.put("CodProvincia_PAC", 
				" INNER JOIN provincias pr ON p.CodProvincia_PAC = pr.CodProvincia_PROV WHERE pr.Descripcion_PROV LIKE ?");
		columnMappings.put("CodLocalidad_PAC", 
				" INNER JOIN localidades lo ON p.CodLocalidad_PAC = lo.CodLocalidad_LOC WHERE lo.Descripcion_LOC LIKE ?");
		
		if (columnMappings.containsKey(column)) {
		    query += columnMappings.get(column);
		} else {
		    query += " WHERE p." + column + " LIKE ?";
		}
		
		return query;
	}

	private Paciente getPaciente(ResultSet resultSet) throws SQLException {
		
		int codigoPaciente = resultSet.getInt("CodPac_PAC");
		LocalidadDao localidadDao = new LocalidadDao();
		Localidad unaLocalidad = localidadDao.obtenerLocalidadPorCodigo(resultSet.getInt("CodLocalidad_PAC"));
		Provincia unaProvincia = unaLocalidad.getProvincia();
		
		int codPac = codigoPaciente;
		String DNI = resultSet.getString("DNI_PAC");
		Provincia provincia = unaProvincia;
	    Localidad localidad = unaLocalidad;
		String nombre = resultSet.getString("Nombre_PAC");
		String apellido = resultSet.getString("Apellido_PAC");
		String correo = resultSet.getString("Correo_PAC");
		String sexo = resultSet.getString("Sexo_PAC");
		String nacionalidad = resultSet.getString("Nacionalidad_PAC");
		Date fechaNacimiento = resultSet.getDate("FechaNacimiento_PAC");
		String direccion = resultSet.getString("Direccion_PAC");
		String telefono = resultSet.getString("Telefono_PAC");
		boolean estado = resultSet.getBoolean("Estado_PAC");
		
		return new Paciente(codPac, DNI, provincia, localidad, nombre, apellido, correo, 
						sexo, nacionalidad, fechaNacimiento, direccion, telefono, estado);
	}

	@Override
	public boolean insert(Paciente paciente) {
	    PreparedStatement statement;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    boolean isInsert = false;
	    try {
	        statement = conexion.prepareStatement(insert);
	        statement.setString(1, paciente.getDNI());
	        statement.setLong(2, paciente.getLocalidad().getCodLocalidad());
	        statement.setLong(3, paciente.getProvincia().getCodProvincia());
	        statement.setString(4, paciente.getNombre());
	        statement.setString(5, paciente.getApellido());
	        statement.setString(6, paciente.getCorreo());
	        statement.setString(7, paciente.getSexo());
	        statement.setString(8, paciente.getNacionalidad());
	        statement.setDate(9, new java.sql.Date(paciente.getFechaNacimiento().getTime()));
	        statement.setString(10, paciente.getDireccion());
	        statement.setString(11, paciente.getTelefono());

	        if (statement.executeUpdate() > 0) {
	            conexion.commit();
	            isInsert = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return isInsert;
	}
	
	@Override
	public boolean update(Paciente paciente) {
		PreparedStatement statement;
		Connection conexion = Conexion.getConexion().getSQLConexion();
		boolean isUpdate = false;
		try{
			statement = conexion.prepareStatement(update);
			statement.setString(1, paciente.getDNI());
		    statement.setInt(2, paciente.getLocalidad().getCodLocalidad());
		    statement.setInt(3, paciente.getProvincia().getCodProvincia());
		    statement.setString(4, paciente.getNombre());
		    statement.setString(5, paciente.getApellido());
		    statement.setString(6, paciente.getCorreo());
		    statement.setString(7, paciente.getSexo());
		    statement.setString(8, paciente.getNacionalidad());
		    statement.setDate(9, new java.sql.Date(paciente.getFechaNacimiento().getTime()));
		    statement.setString(10, paciente.getDireccion());
		    statement.setString(11, paciente.getTelefono());
		    statement.setBoolean(12, paciente.getEstado());
		    statement.setLong(13, paciente.getCodPac());
			
			if(statement.executeUpdate() > 0){
				conexion.commit();
				isUpdate = true;
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return isUpdate;
	}


	@Override
	public boolean delete(int codPaciente) {
		Connection cn = null;
	    boolean isDelete = false;
		try {
			cn = Conexion.getConexion().getSQLConexion();
			PreparedStatement st = cn.prepareStatement(delete);
			st.setInt(1, codPaciente);
			int filasAfectadas = st.executeUpdate();
			
			if(filasAfectadas > 0) {
				cn.commit();
				isDelete = true;
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return isDelete;
	}

	

	
}
