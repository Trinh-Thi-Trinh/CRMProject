package repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.User;
import connection.JDBCConnection;
import dto.UserListDTO;

public class UserRepository {
public User findByEmail (String email) {
	String query = "select * from user where email=? limit 1";
	try (
			Connection con = JDBCConnection.getConnection();
			PreparedStatement statement = con.prepareStatement(query);
			
			) { statement.setString(1, email);
				ResultSet rs = statement.executeQuery();
				if (rs.next()) {
					return new User (
							rs.getInt("id"),
							rs.getString("email"),
							rs.getString("password"),
							rs.getString("fullname"),
							rs.getString("phone"),
							rs.getString("country"),
							rs.getInt("role_id")
							);
				}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	return null;
}

// ---------- Danh sach User
public List <UserListDTO> getAllUser(){
	List <UserListDTO> users = new ArrayList<UserListDTO>();
	String query = "SELECT u.id, u.email, u.fullname, u.phone, r.name_role FROM user u INNER JOIN role r ON u.role_id = r.id ORDER BY u.id DESC";

	try ( Connection con = JDBCConnection.getConnection();
			PreparedStatement statement = con.prepareStatement(query);
			) { ResultSet rs = statement.executeQuery();
			while(rs.next()) {
				UserListDTO user = new UserListDTO(
				rs.getInt("id"), 
				rs.getString("fullname"), 
				rs.getString("email"),
				rs.getString("phone"), 
				rs.getString("name_role"));
		// them vao list
		users.add(user);
	}		
	} catch (Exception e) {
		e.printStackTrace();
	}
	return users;
}
//  ----------Them moi add
public boolean create (User user) {
	String query = "INSERT INTO user (email, password, fullname, phone, country, role_id )"
			+ "Values (?,?,?,?,?,?)";
	try (Connection con = JDBCConnection.getConnection();
			PreparedStatement pre = con.prepareStatement(query);
			) {pre.setString(1, user.getEmail());
				pre.setString (2,user.getPassword());
				pre.setString(3, user.getFullname());
				pre.setString(4, user.getPhone());
				pre.setString(5, user.getCountry());
				pre.setInt(6, user.getRoleId());
			return pre.executeUpdate() == 1;
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	return false;	
}
//userPaging
	public List<UserListDTO> userPaging(String keywords, int size, int index ){
		List<UserListDTO> users = new ArrayList<>(); 
		// sql
		String sql = "select u.id, fullname, email, u.phone, r.name_role   from `user` u "
				+ "inner join `role` r  "
				+ "on u.role_id  = r.id "
				+ "where u.fullname  like ? " // '%{keyword}%'
				+ "or u.email  like ? "
				+ "Order By u.id DESC "
				+ "limit ? offset ? ";
			
		try(Connection con = JDBCConnection.getConnection()) {
			if(con == null) {// loi neu khong ket noi db duoc
				throw new SQLException("Khong ket noi duoc co so du lieu");
			}
			try(PreparedStatement ps = con.prepareStatement(sql)){
				String searchValue = "%" + keywords + "%";
				ps.setString(1, searchValue);	
				ps.setString(2, searchValue);
				ps.setInt(3, size);
				ps.setInt(4, size * (index - 1));
				
				try(ResultSet rs = ps.executeQuery()){
					while(rs.next()) {
						users.add(new UserListDTO(
							rs.getInt("id"), 
							rs.getString("fullname"), 
							rs.getString("email"),
							rs.getString("phone"), 
							rs.getString("name_role")
						));
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return users;
	}
	// countuser
		public int countUser(String keywords) throws SQLException {
			String sql = "select count(*)   from `user` u "
					+ "inner join `role` r  "
					+ "on u.role_id  = r.id "
					+ "where u.fullname  like ?"
					+ "or u.email  like ?";
			try(Connection conn = JDBCConnection.getConnection()){
				if(conn == null) {// loi neu khong ket noi db duoc
					throw new SQLException("Khong ket noi duoc co so du lieu");
				}
				try(PreparedStatement ps = conn.prepareStatement(sql)){
					String searchValue = "%" + keywords + "%";
					ps.setString(1, searchValue);	
					ps.setString(2, searchValue);
					
					try(ResultSet rs = ps.executeQuery()){
						rs.next();
						return rs.getInt(1);
					}
				}
			}
		}

		// userrepo  DeleteById
		public boolean deleteById(int id) throws SQLException {
			String sql = "DELETE FROM user WHERE id = ?";
			try(Connection conn = JDBCConnection.getConnection()) {
				if(conn == null) {// loi neu khong ket noi db duoc
					throw new SQLException("Khong ket noi duoc co so du lieu");
				}
				try(PreparedStatement ps = conn.prepareStatement(sql)){
					ps.setInt(1, id);
					return ps.executeUpdate() == 1; // co 1 dong thay doi trong db 
				}
				
			}
			
		}
		// get user by id
		public User getUserById (int id) throws SQLException {
			String sql = "SELECT * FROM user Where id = ?";
			try(Connection conn = JDBCConnection.getConnection()) {
				if(conn == null) {// loi neu khong ket noi db duoc
					throw new SQLException("Khong ket noi duoc co so du lieu");
				}
				try(PreparedStatement ps = conn.prepareStatement(sql)){
					ps.setInt(1, id);
					try(ResultSet rs = ps.executeQuery()){
						//
						if(rs.next()) {
							return new User(
									rs.getInt("id"), 
									rs.getString("email"), 
									rs.getString("password"),
									rs.getString("fullname"), 
									rs.getString("phone"), 
									rs.getString("country"),
									rs.getInt("role_id")
									);
							
							
						}
						else {
							return null;
						}
					}
					
					
				}
				
			}
		}	
		// update user
		
		
		public boolean updateUser(User user) throws SQLException{
			String sql = "update user set email=?, "
					+ "fullname=?, phone=?, country=?, role_id=? "
					+ "where id =?";
			try(Connection conn = JDBCConnection.getConnection()) {
				if(conn == null) {// loi neu khong ket noi db duoc
					throw new SQLException("Khong ket noi duoc co so du lieu");
				}
				try(PreparedStatement ps = conn.prepareStatement(sql)){
					ps.setString(1, user.getEmail());
					ps.setString(2, user.getFullname());
					ps.setString(3, user.getPhone());
					ps.setString(4, user.getCountry());
					ps.setInt(5, user.getRoleId());
					ps.setInt(6, user.getId());
					
					return ps.executeUpdate() == 1; // co 1 dong thay doi trong db 
				}
				
			}
			
			
		}
}
