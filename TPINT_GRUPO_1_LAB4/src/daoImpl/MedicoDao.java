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
import java.util.Set;

import conexión.Conexion;
import dao.IMedicoDao;
import entidades.Especialidad;
import entidades.MedicosXDias;
import entidades.Localidad;
import entidades.Medico;
import entidades.Provincia;

public class MedicoDao extends GeneralDao implements IMedicoDao {
	private static final String readall = "SELECT * FROM Medicos";
	private static final String delete = "UPDATE Medicos SET Estado_MED = 0 WHERE CodMed_MED = ?";
	private static final String update = "UPDATE Medicos SET DNI_MED = ?, CodEspecialidad_MED = ?, CodLocalidad_MED = ?, CodProvincia_MED = ?, Nombre_MED = ?, Apellido_MED = ?, Correo_MED = ?, Sexo_MED = ?, Nacionalidad_MED = ?, FechaNacimiento_MED = ?, Direccion_MED = ?, Telefono_MED = ?, Username_MED = ?, Contraseña_MED = ?, Tipo_MED = ?, Estado_MED = ? WHERE CodMed_MED = ?";
	
	public Medico traerMedicoPorNombreUsuario(String username) {		
		Connection cn = Conexion.getConexion().getSQLConexion();
		Medico medico = new Medico();
		  
		try {
			String query = "select * from Medicos where Username_MED = ?";
				 
			PreparedStatement st = cn.prepareStatement(query);
			st.setString(1, username);
			ResultSet rs = st.executeQuery();
			
			while(rs.next()) {
				medico = getMedico(rs);				
			}				 
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return medico;	
	}

	@Override
	public List<Medico> readAll(boolean sinInactivos) {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Medico> medicos = new ArrayList<Medico>();

		Connection conexion = Conexion.getConexion().getSQLConexion();
		try {
			if (sinInactivos) {
	            statement = conexion.prepareStatement(readall + " WHERE Estado_MED = '1'");
	        } else {
	            statement = conexion.prepareStatement(readall);
	        }
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
		EspecialidadDao especialidadDao = new EspecialidadDao();
		MedicosXDiasDao medicosxdiasDao = new MedicosXDiasDao();
		
		Especialidad unaEspecialidad = especialidadDao.obtenerEspecialidadPorCodigo(codigoMedico);
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
		Set<MedicosXDias> horarios = medicosxdiasDao.obtenerHorariosPorMedico(codigoMedico);
		
		return new Medico(codMed, DNI, especialidad, localidad, provincia, correo, username, contraseña, nombre, apellido, sexo, nacionalidad, fechaNacimiento, direccion, telefono, tipo, estado, horarios);
	}

	@Override
	public List<Medico> getMedicosByFilter(String column, String text) {
		PreparedStatement statement;
		ResultSet resultSet; 
		ArrayList<Medico> medicos = new ArrayList<Medico>();
		Connection conexion = Conexion.getConexion().getSQLConexion();
		try{
			String query = createQueryFiltersMedicos(column);
			
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
	
	private String createQueryFiltersMedicos(String column) {
		Map<String, String> columnMappings = new HashMap<>();
		String query = "SELECT * FROM medicos m";

		columnMappings.put("CodProvincia_MED", 
				" INNER JOIN provincias pr ON m.CodProvincia_MED = pr.CodProvincia_PROV WHERE pr.Descripcion_PROV LIKE ?");
		columnMappings.put("CodLocalidad_MED", 
				" INNER JOIN localidades lo ON m.CodLocalidad_MED = lo.CodLocalidad_LOC WHERE lo.Descripcion_LOC LIKE ?");
		columnMappings.put("CodEspecialidad_MED", 
				" INNER JOIN especialidades esp ON m.CodEspecialidad_MED = esp.CodEspecialidad_ESP WHERE esp.Descripcion_ESP LIKE ?");
		
		if (columnMappings.containsKey(column)) {
		    query += columnMappings.get(column);
		} else {
		    query += " WHERE m." + column + " LIKE ?";
		}
		
		return query;
	}

	@Override
	public boolean delete(int codMed) {
		Connection cn = null;
		try {
			cn = Conexion.getConexion().getSQLConexion();
			PreparedStatement st = cn.prepareStatement(delete);
			st.setInt(1, codMed);
			int filasAfectadas = st.executeUpdate();
			
			if(filasAfectadas > 0) {
				cn.commit();
				return true;
			}
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
	    boolean isInsert = false;
	    
		try {
	        connection = Conexion.getConexion().getSQLConexion();
	        String query = "INSERT INTO Medicos (DNI_MED, CodEspecialidad_MED, CodLocalidad_MED, CodProvincia_MED, Nombre_MED, Apellido_MED, Correo_MED, Sexo_MED, Nacionalidad_MED, FechaNacimiento_MED, Direccion_MED, Telefono_MED, Username_MED, Contraseña_MED, Tipo_MED) "
	                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	        statement = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS);

	        statement.setString(1, medico.getDNI());
	        statement.setInt(2, medico.getEspecialidad().getCodEspecialidad());
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

	        MedicosXDiasDao medicoXDiaDao = new MedicosXDiasDao();
	        boolean allHorariosInserted = true;

	        int filasAfectadas = statement.executeUpdate();

	        if (filasAfectadas > 0) {
        		generatedKeys = statement.getGeneratedKeys();
	            if (generatedKeys.next()) {
	                int codMed = generatedKeys.getInt(1);
	                medico.setCodMed(codMed);
	                isInsert = true;
	            }

	            if (medico.getHorarios() != null && !medico.getHorarios().isEmpty()) {
	                for (MedicosXDias horario : medico.getHorarios()) {
	                    if (!medicoXDiaDao.insert(medico.getCodMed(), horario)) {
	                        allHorariosInserted = false;
	                        break; 
	                    }
	                }

	                if (allHorariosInserted) {
	                    connection.commit();
	                } else {
	                    connection.rollback();
	                    isInsert = false;
	                }
	            } else {
	                connection.commit();
	            }
	        }
	    } 
		catch (SQLException e) {
	    	e.printStackTrace();
	    } 
	    
	    return isInsert;
	}

	@Override
	public boolean update(Medico medico) {
		PreparedStatement statement;
		Connection connection = Conexion.getConexion().getSQLConexion();
		boolean isUpdate = false;
		try{
			statement = connection.prepareStatement(update);
			
		    statement.setString(1, medico.getDNI());
	        statement.setInt(2, medico.getEspecialidad().getCodEspecialidad());
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
	        statement.setInt(17, medico.getCodMed());
	        
	        MedicosXDiasDao medicoXDiaDao = new MedicosXDiasDao();
	        boolean allHorariosUpdated = true;

	        if (statement.executeUpdate() > 0) {
	            if (medico.getHorarios() != null && !medico.getHorarios().isEmpty()) {
	                for (MedicosXDias horario : medico.getHorarios()) {
	                    boolean horarioInsertOrUpdated = medicoXDiaDao.insert(medico.getCodMed(), horario);
	                    if (!horarioInsertOrUpdated) {
	                        allHorariosUpdated = false;
	                        break;
	                    }
	                }

	                if (allHorariosUpdated) {
	                    connection.commit();
	                    isUpdate = true;
	                } else {
	                	connection.rollback();
	                    isUpdate = false;
	                }
	            } else {
	                connection.commit();
	                isUpdate = true;
	            }
	        }
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		return isUpdate;	
	}

	@Override
	public boolean usernameRepetido(String username, int cod) {
		Connection cn = Conexion.getConexion().getSQLConexion();
		boolean repetido = true;
		
		try {
			String query = "SELECT CASE "
				+ "WHEN EXISTS (SELECT 1 FROM Medicos WHERE Username_MED = ? AND CodMed_MED <> ?) "
				+ "THEN 1 "
				+ "ELSE 0 "
				+ "END AS Repetido;";
			 
			PreparedStatement st = cn.prepareStatement(query);
			st.setString(1, username);
			st.setInt(2, cod);
			ResultSet rs = st.executeQuery();
			
			while(rs.next()) {
				repetido = rs.getBoolean("Repetido");		
			}				 
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return repetido;
	}

}
