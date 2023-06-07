package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import conexión.Conexion;
import dao.ITurnosDao;
import entidades.EstadoTurno;
import entidades.Medico;
import entidades.Paciente;
import entidades.Turno;

public class TurnosDao implements ITurnosDao{
	private static final String consulta = "SELECT Nombre_MED, Nombre_PAC, FechaTurno_TURN, Descripcion_EST " +
            "FROM Turnos " +
            "INNER JOIN Medicos ON CodMed_TURN = CodMed_MED " +
            "INNER JOIN Pacientes ON CodPac_TURN = CodPac_PAC " +
            "INNER JOIN EstadosTurno ON CodEstado_TURN = CodEstado_EST";
	

	public List<Turno> readAll() {
        List<Turno> turnos = new ArrayList<>();

        try {Connection conexion = Conexion.getConexion().getSQLConexion();
             PreparedStatement statement = conexion.prepareStatement(consulta);
             ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                String nombreMedico = resultSet.getString("Nombre_MED");
                String nombrePaciente = resultSet.getString("Nombre_PAC");
                Date fechaTurno = resultSet.getDate("FechaTurno_TURN");
                String descripcionEstado = resultSet.getString("Descripcion_EST");

                Medico medico = new Medico();
                medico.setNombre(nombreMedico);

                Paciente paciente = new Paciente();
                paciente.setNombre(nombrePaciente);

                EstadoTurno estado = new EstadoTurno();
                estado.setDescripcion_EST(descripcionEstado);

                Turno turno = new Turno();
                turno.setMedico(medico);
                turno.setPaciente(paciente);
                turno.setFechaTurno(fechaTurno);
                turno.setEstado(estado);

                turnos.add(turno);
            }
        } catch (Exception e) {
			e.printStackTrace();
	  }
	  finally  {
		  
	  }
	return turnos;
    }
	
}
