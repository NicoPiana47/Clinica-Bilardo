package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Time;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

import conexión.Conexion;
import dao.IMedicosXDiasDao;
import entidades.Horario;

public class MedicosXDiasDao implements IMedicosXDiasDao{
	private static final String insert = "INSERT INTO medicosxdias(CodMed_MXD, Dia_MXD, HoraDesde_MXD, HoraHasta_MXD, Estado_MXD) VALUES(?, ?, ?, ?, ?)";

	@Override
	public boolean insert(int codMed, Horario horario) {
	    PreparedStatement statement;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    boolean isInsert = false;

	    try {
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
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return isInsert;
	}
}

