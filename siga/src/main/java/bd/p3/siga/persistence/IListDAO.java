package bd.p3.siga.persistence;

import java.sql.SQLException;
import java.util.List;

public interface IListDAO<T> {
	public List<T> list() throws SQLException, ClassNotFoundException;
}
