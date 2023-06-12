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
import dao.IMedicoDao;
import entidades.Especialidad;
import entidades.Localidad;
import entidades.Medico;
import entidades.Paciente;
import entidades.Provincia;

public class MedicoDao extends GeneralDao implements IMedicoDao {
	private static final String readall = "SELECT * FROM Medicos";
	private static final String delete = "UPDATE Medicos SET Estado_MED = 0 WHERE CodMed_MED = ?";

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
				x = getMedico(rs);				
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
	
	@Override
	public List<String> getColumns() {
	    return super.getColumns("medicos", "CodMed_MED");
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

	@Override
	public List<Medico> getMedicosByFilter(String column, String text) {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Medico> medicos = new ArrayList<Medico>();
		Connection conexion = Conexion.getConexion().getSQLConexion();
		try{
			String query = "SELECT * FROM Medicos WHERE " + column + " LIKE ?";
			statement = conexion.prepareStatement(query);
	        statement.setString(1, "%" + text + "%");
	        
	        resultSet = statement.executeQuery();      
			
			while(resultSet.next()){
				medicos.add(getMedico(resultSet));
			}
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		return medicos;
	}

	@Override
	public boolean delete(int codMed) {
		Connection cn = null;
		try {
			cn = Conexion.getConexion().getSQLConexion();
			PreparedStatement st = cn.prepareStatement(delete);
			st.setInt(1, codMed);
			int filasAfectadas = st.executeUpdate();
			
			if(filasAfectadas > 0) 
				return true;
			return false;
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean create(Medico medico) {
		Connection connection = null;
	    PreparedStatement statement = null;
	    ResultSet generatedKeys = null;

	    try {
	        connection = Conexion.getConexion().getSQLConexion();
	        String query = "INSERT INTO Medicos (DNI_MED, CodEspecialidad_MED, CodLocalidad_MED, CodProvincia_MED, Nombre_MED, Apellido_MED, Correo_MED, Sexo_MED, Nacionalidad_MED, FechaNacimiento_MED, Direccion_MED, Telefono_MED, Username_MED, Contraseña_MED, Tipo_MED, Estado_MED) "
	                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        statement = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);

	        statement.setString(1, medico.getDNI());
	        statement.setInt(2, medico.getEspecialidad().getCodEspecialidad_ESP());
	        statement.setInt(3, medico.getLocalidad().getCodLocalidad());
	        statement.setInt(4, medico.getProvincia().getCodProvincia());
	        statement.setString(5, medico.getNombre());
	        statement.setString(6, medico.getApellido());
	        statement.setString(7, medico.getCorreo());
	        statement.setString(8, medico.getSexo());
	        statement.setString(9, medico.getNacionalidad());
	        statement.setDate(10, new java.sql.Date(medico.getFechaNacimiento().getTime()));
	        statement.setString(11, medico.getDireccion());
	        statement.setString(12, medico.getTelefono());
	        statement.setString(13, medico.getUsername());
	        statement.setString(14, medico.getContraseña());
	        statement.setBoolean(15, medico.getTipo());
	        statement.setBoolean(16, medico.getEstado());

	        int filasAfectadas = statement.executeUpdate();

	        if (filasAfectadas > 0) {
	            generatedKeys = statement.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                int codMed = generatedKeys.getInt(1);
	                medico.setCodMed(codMed);
	            }
	            return true;
	        }
	        return false;
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return false;
	    } finally {
	       
	    }
		
		
		
	}

}
