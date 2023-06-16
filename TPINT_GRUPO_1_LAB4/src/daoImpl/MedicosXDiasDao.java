package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.Set;

import conexión.Conexion;
import dao.IMedicosXDiasDao;
import entidades.MedicosXDias;

public class MedicosXDiasDao implements IMedicosXDiasDao{
	private static final String insert = "INSERT INTO medicosxdias(CodMed_MXD, Dia_MXD, HoraDesde_MXD, HoraHasta_MXD, Estado_MXD) VALUES(?, ?, ?, ?, ?)";
	private static final String obtenerHorario = "SELECT * FROM medicosxdias WHERE CodMed_MXD = ?";
	private static final String update = "UPDATE medicosxdias SET HoraDesde_MXD = ?, HoraHasta_MXD = ?, Estado_MXD = ? WHERE Dia_MXD = ? AND CodMed_MXD = ?";
	
	@Override
	public boolean insert(int codMed, MedicosXDias horario) {
	    PreparedStatement statement;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    boolean isInsert = false;

	    try {
	    	if (existsMedicoXDia(codMed, horario.getDia())) {
	            isInsert = update(codMed, horario);
	        }
	    	else {
	            statement = conexion.prepareStatement(insert);
	
	            statement.setLong(1, codMed);
	            statement.setString(2, horario.getDia());
	            statement.setTime(3, Time.valueOf(horario.getHorarioDesde()));
	            statement.setTime(4, Time.valueOf(horario.getHorarioHasta()));
	            statement.setBoolean(5, horario.isEstado());
	
	            if (statement.executeUpdate() > 0) {
	                conexion.commit();
	                isInsert = true;
	            }
	    	}
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return isInsert;
	}
	
	@Override
	public boolean update(int codMed, MedicosXDias horario) {
	    PreparedStatement statement;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    boolean isInsert = false;

	    try {
	        statement = conexion.prepareStatement(update);

            statement.setTime(1, Time.valueOf(horario.getHorarioDesde()));
            statement.setTime(2, Time.valueOf(horario.getHorarioHasta()));
            statement.setBoolean(3, horario.isEstado());
            statement.setString(4, horario.getDia());
            statement.setLong(5, codMed);

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
	public Set<MedicosXDias> obtenerHorariosPorMedico(int codigoMedico) {
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    Set<MedicosXDias> horarios = new HashSet<>();
	    ResultSet resultado = null;
	    try {
	        PreparedStatement statement = conexion.prepareStatement(obtenerHorario);
	        statement.setInt(1, codigoMedico);
	        resultado = statement.executeQuery();

	        while (resultado.next()) {
	            MedicosXDias unHorario = new MedicosXDias();
	            unHorario.setDia(resultado.getString("Dia_MXD"));
	            unHorario.setHorarioDesde(LocalTime.parse(resultado.getString("HoraDesde_MXD")));
	            unHorario.setHorarioHasta(LocalTime.parse(resultado.getString("HoraHasta_MXD")));
	            unHorario.setEstado(resultado.getBoolean("Estado_MXD"));
	            horarios.add(unHorario);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return horarios;
	}
	
	@Override
	public boolean existsMedicoXDia(int codMed, String dia) {
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    PreparedStatement statement = null;
	    ResultSet resultSet = null;
	    boolean exists = false;

	    try {
	        statement = conexion.prepareStatement("SELECT COUNT(*) FROM MedicosXDias WHERE CodMed_MXD = ? AND Dia_MXD = ?");
	        statement.setInt(1, codMed);
	        statement.setString(2, dia);
	        resultSet = statement.executeQuery();

	        if (resultSet.next()) {
	            int count = resultSet.getInt(1);
	            exists = count > 0;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } 

	    return exists;
	}
}

