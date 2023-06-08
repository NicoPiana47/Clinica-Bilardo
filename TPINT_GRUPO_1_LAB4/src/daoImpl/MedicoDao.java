package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import conexión.Conexion;
import dao.IMedicoDao;
import entidades.Especialidad;
import entidades.Localidad;
import entidades.Medico;
import entidades.Paciente;
import entidades.Provincia;

public class MedicoDao implements IMedicoDao {
	private static final String readall = "SELECT * FROM Medicos";

	public Medico traerMedicoPorNombreUsuario(String username) {		
		Connection cn = Conexion.getConexion().getSQLConexion();
		Medico x = new Medico();
		  try
		  {
			 String query = "select * from Medicos where Username_MED = ?";
			 
			 PreparedStatement st = cn.prepareStatement(query);
			 st.setString(1, username);
			 ResultSet rs = st.executeQuery();
			
			 while(rs.next()) {
					x.setCodMed(rs.getInt("CodMed_MED")); 
					x.setDNI(rs.getString("DNI_MED"));
					x.getEspecialidad().setCodEspecialidad_ESP(rs.getInt("CodEspecialidad_MED")); 
					x.getLocalidad().setCodLocalidad(rs.getInt("CodLocalidad_MED"));
					x.getLocalidad().getProvincia().setCodProvincia(rs.getInt("CodProvincia_MED"));
					x.setCorreo(rs.getString("Correo_MED")); 
					x.setUsername(rs.getString("Username_MED")); 
					x.setContraseña(rs.getString("Contraseña_MED")); 
					x.setNombre(rs.getString("Nombre_MED")); 
					x.setApellido(rs.getString("Apellido_MED"));
					x.setSexo(rs.getString("Sexo_MED")); 
					x.setNacionalidad(rs.getString("Nacionalidad_MED")); 
					x.setFechaNacimiento(rs.getDate("FechaNacimiento_MED"));
					x.setDireccion(rs.getString("Direccion_MED"));
					x.setTelefono(rs.getString("Telefono_MED"));
					x.setTipo(rs.getBoolean("Tipo_MED"));
					x.setEstado(rs.getBoolean("Estado_MED"));					
			 }				 
		  }
		  catch (Exception e) {
				e.printStackTrace();
		  }
		  finally  {
			  
		  }
		return x;
		
	}

	@Override
	public List<Medico> readAll() {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Medico> medicos = new ArrayList<Medico>();

		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			statement = conexion.prepareStatement(readall);
			resultSet = statement.executeQuery();
			while(resultSet.next()) {
				medicos.add(getMedico(resultSet));
			}
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
		return medicos;
	}
	
	private Medico getMedico(ResultSet resultSet) throws SQLException {
		
		int codigoMedico = resultSet.getInt("CodMed_MED");
		LocalidadDao localidadDao = new LocalidadDao();
		EspecialidadDao espDao = new EspecialidadDao();
		
		Especialidad unaEspecialidad = espDao.obtenerEspecialidadPorCodigo(codigoMedico);
		Localidad unaLocalidad = localidadDao.obtenerLocalidadPorCodigo(resultSet.getInt("CodLocalidad_MED"));
		Provincia unaProvincia = unaLocalidad.getProvincia();
		
		int codMed = codigoMedico;
		String DNI = resultSet.getString("DNI_MED");
		Provincia provincia = unaProvincia;
	    Localidad localidad = unaLocalidad;
	    Especialidad especialidad = unaEspecialidad;
		String nombre = resultSet.getString("Nombre_MED");
		String apellido = resultSet.getString("Apellido_MED");
		String correo = resultSet.getString("Correo_MED");
		String sexo = resultSet.getString("Sexo_MED");
		String nacionalidad = resultSet.getString("Nacionalidad_MED");
		Date fechaNacimiento = resultSet.getDate("FechaNacimiento_MED");
		String direccion = resultSet.getString("Direccion_MED");
		String telefono = resultSet.getString("Telefono_MED");
		String username = resultSet.getString("Username_MED"); 
		String contraseña = resultSet.getString("Contraseña_MED"); 
		boolean estado = resultSet.getBoolean("Estado_MED");
		boolean tipo = resultSet.getBoolean("Tipo_MED");
		
		return new Medico(codMed, DNI, especialidad, localidad, provincia, correo, username, contraseña, nombre, apellido, sexo, nacionalidad, fechaNacimiento, direccion, telefono, tipo, estado);
	}
}
