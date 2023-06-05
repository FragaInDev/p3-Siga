package bd.p3.siga.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import bd.p3.siga.model.AlunoNota;
import bd.p3.siga.model.Notas;

@Repository
public class NotasDAO implements INotasDAO {
	
	@Autowired
	private GenericDAO gDao;

	@Override
	public List<AlunoNota> findNotas(String sigla, String turno) throws SQLException, ClassNotFoundException {
		List<AlunoNota> notas = new ArrayList<>();
		
		Connection c = gDao.getConnection();
		String sql = "SELECT ra, nome_aluno, nota1, nota2, nota3, media_final, situacao FROM fn_media(?, ?)";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, sigla);
		ps.setString(2, turno);
		ResultSet rs = ps.executeQuery();
		
		try {
			
			while (rs.next()) {
				AlunoNota n = new AlunoNota();
				n.setRa(rs.getString("ra"));
				n.setNome(rs.getString("nome_aluno"));
				n.setNota1(rs.getDouble("nota1"));
				n.setNota2(rs.getDouble("nota2"));
				n.setNota3(rs.getDouble("nota3"));
				n.setMedia(rs.getDouble("media_final"));
				n.setSituacao(rs.getString("situacao"));
				
				notas.add(n);
			}
			
			rs.close();
			ps.close();
			c.close();
			
		} catch (Exception e) {
			
			while (rs.next()) {
				AlunoNota n = new AlunoNota();
				n.setRa(rs.getString("ra"));
				n.setNome(rs.getString("nome"));
				n.setNota1(rs.getDouble("nota1"));
				n.setNota2(rs.getDouble("nota2"));
				n.setNota3(rs.getDouble("nota3"));
				n.setMedia(rs.getDouble("media_final"));
				n.setSituacao(rs.getString("situacao"));
				
				notas.add(n);
			}
			
			rs.close();
			ps.close();
			c.close(); 
		}
		
		return notas;
	}

	@Override
	public Notas insertNota(Notas n) throws SQLException, ClassNotFoundException {
		System.out.println(n.getCodAvaliacao());
		Connection c = gDao.getConnection();
		String sql = "INSERT INTO notas (ra_al, cod_disc, cod_av, nota) VALUES (?,?,?,?)";
		PreparedStatement ps = c.prepareStatement(sql);
		
		ps.setString(1, n.getRaAluno());
		ps.setString(2, n.getCodDisciplina());
		ps.setInt(3, n.getCodAvaliacao());
		ps.setDouble(4, n.getNota());
		
		ps.execute();
		ps.close();
		c.close();
		
		return n;
	}

}
