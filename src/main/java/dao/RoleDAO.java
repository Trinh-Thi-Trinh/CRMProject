package dao;

import java.sql.Connection;

import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model.Role;
import connection.JDBCConnection;

public class RoleDAO {

	public List<Role> getAll(){
		List<Role> roles = new ArrayList<Role>();
		String sql = "SELECT * FROM role";
		try (
				Connection con = JDBCConnection.getConnection();
				PreparedStatement statement = con.prepareStatement(sql);
				ResultSet rs = statement.executeQuery();
			)
				{ while (rs.next()) 
				{
					roles.add(new Role(rs.getInt("id"), rs.getString("name_role"), rs.getString("description")));
				}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return roles;
	} 
	
	public boolean insert(Role role) {
	    String sql = "INSERT INTO role (name_role, description) VALUES (?, ?)";

	    try (Connection con = JDBCConnection.getConnection();
	         PreparedStatement statement = con.prepareStatement(sql)) {

	        statement.setString(1, role.getNameRole());
	        statement.setString(2, role.getDescription());

	        return statement.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	public Role findById(int id) {
	    String sql = "SELECT id, name_role, description FROM role WHERE id = ?";

	    try (Connection con = JDBCConnection.getConnection();
	         PreparedStatement statement = con.prepareStatement(sql)) {

	        statement.setInt(1, id);

	        try (ResultSet rs = statement.executeQuery()) {
	            if (rs.next()) {
	                return new Role(
	                    rs.getInt("id"),
	                    rs.getString("name_role"),
	                    rs.getString("description")
	                );
	            }
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return null;
	}
	

public boolean update(Role role) {
    String sql = "UPDATE role SET name_role = ?, description = ? WHERE id = ?";

    try (Connection con = JDBCConnection.getConnection();
         PreparedStatement statement = con.prepareStatement(sql)) {

        statement.setString(1, role.getNameRole());
        statement.setString(2, role.getDescription());
        statement.setInt(3, role.getId());

        return statement.executeUpdate() > 0;

    } catch (Exception e) {
        e.printStackTrace();
        return false;
    }
}

public void deleteById(int id) throws java.sql.SQLException {
    String sql = "DELETE FROM role WHERE id = ?";

    try (Connection con = JDBCConnection.getConnection();
         PreparedStatement statement = con.prepareStatement(sql)) {

        statement.setInt(1, id);
        statement.executeUpdate();
    }
}
//Lấy danh sách quyền theo từ khóa và số trang
public List<Role> getPaging(String keyword, int size, int page) {
 List<Role> roles = new ArrayList<>();

 String sql = "SELECT id, name_role, description FROM role "
            + "WHERE name_role LIKE ? OR description LIKE ? "
            + "ORDER BY id ASC LIMIT ? OFFSET ?";

 try (Connection con = JDBCConnection.getConnection();
      PreparedStatement statement = con.prepareStatement(sql)) {

     String search = "%" + keyword + "%";

     statement.setString(1, search);
     statement.setString(2, search);
     statement.setInt(3, size);
     statement.setInt(4, (page - 1) * size);

     try (ResultSet rs = statement.executeQuery()) {
         while (rs.next()) {
             roles.add(new Role(
                 rs.getInt("id"),
                 rs.getString("name_role"),
                 rs.getString("description")
             ));
         }
     }

 } catch (Exception e) {
     e.printStackTrace();
 }

 return roles;
}

//Đếm tổng số quyền khớp với từ khóa
public int countRoles(String keyword) {
 String sql = "SELECT COUNT(*) FROM role "
            + "WHERE name_role LIKE ? OR description LIKE ?";

 try (Connection con = JDBCConnection.getConnection();
      PreparedStatement statement = con.prepareStatement(sql)) {

     String search = "%" + keyword + "%";

     statement.setString(1, search);
     statement.setString(2, search);

     try (ResultSet rs = statement.executeQuery()) {
         if (rs.next()) {
             return rs.getInt(1);
         }
     }

 } catch (Exception e) {
     e.printStackTrace();
 }

 return 0;
}
}
