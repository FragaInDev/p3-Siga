package bd.p3.siga.persistence;

import java.sql.SQLException;
import java.util.List;

import bd.p3.siga.model.AlunoNota;
import bd.p3.siga.model.Notas;

public interface INotasDAO {
	
	public List<AlunoNota> findNotas(String sigla, String turno) throws SQLException, ClassNotFoundException;
	public Notas insertNota(Notas n) throws SQLException, ClassNotFoundException;
}
