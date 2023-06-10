package daoImpl;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import conexi�n.Conexion;
import dao.IPacienteDao;
import entidades.Localidad;
import entidades.Paciente;
import entidades.Provincia;

public class PacienteDao extends GeneralDao implements IPacienteDao {
	private static final String insert = "INSERT INTO personas(dni, nombre, apellido) VALUES(?, ?, ?)";
	private static final String delete = "DELETE FROM personas WHERE dni = ?";
	private static final String readall = "SELECT * FROM pacientes";
	private static final String existeDni = "SELECT * FROM personas WHERE dni = ?";
	private static final String update = "UPDATE personas SET nombre = ?, apellido = ? WHERE dni = ?";

	public List<Paciente> readAll() {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Paciente> pacientes = new ArrayList<Paciente>();

		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			statement = conexion.prepareStatement(readall);
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
	
	public List<String> getColumns() {
	    return super.getColumns("pacientes", "CodPac_PAC");
	}
	
	public List<Paciente> getPacientesByFilter(String column, String text) {

		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Paciente> pacientes = new ArrayList<Paciente>();
		Connection conexion = Conexion.getConexion().getSQLConexion();
		try{
			String query = "SELECT * FROM pacientes WHERE " + column + " LIKE ?";
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
	
	private Paciente getPaciente(ResultSet resultSet) throws SQLException {
		
		int codigoPaciente = resultSet.getInt("CodPac_PAC");
		LocalidadDao localidadNeg = new LocalidadDao();
		Localidad unaLocalidad = localidadNeg.obtenerLocalidadPorCodigo(resultSet.getInt("CodLocalidad_PAC"));
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
		
		return new Paciente(codPac, DNI, provincia, localidad, nombre, apellido, correo, sexo, nacionalidad, fechaNacimiento, direccion, telefono, estado);
	}
	
}