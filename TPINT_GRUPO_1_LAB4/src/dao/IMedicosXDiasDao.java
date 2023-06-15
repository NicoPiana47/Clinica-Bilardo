package dao;

import java.util.Set;

import entidades.MedicosXDias;

public interface IMedicosXDiasDao {

	 public boolean insert(int codMed, MedicosXDias horario);
	 public Set<MedicosXDias> obtenerHorariosPorMedico(int codigoMedico);
	 public boolean existsMedicoXDia(int codMed, String dia);
	 public boolean update(int codMed, MedicosXDias horario);

}
