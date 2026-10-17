
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.Task;
import Model.Project;
import Model.User;
import Model.Status;
import connection.JDBCConnection;
import dto.TaskListDTO;

public class TaskDAO {

	public List<TaskListDTO> searchAndPaginate(
	        String keyword, int limit, int offset) throws SQLException {

	    List<TaskListDTO> list = new ArrayList<>();

	    String sql =
	        "SELECT t.id, t.task_name, p.project_name, u.fullname, " +
	        "t.start_date, t.end_date, t.status_id, s.name_status " +
	        "FROM task t " +
	        "JOIN project p ON t.project_id = p.id " +
	        "JOIN user u ON t.user_id = u.id " +
	        "JOIN status s ON t.status_id = s.id " +
	        "WHERE t.task_name LIKE ? " +
	        "OR p.project_name LIKE ? " +
	        "OR u.fullname LIKE ? " +
	        "OR s.name_status LIKE ? " +
	        "ORDER BY t.id DESC " +
	        "LIMIT ? OFFSET ?";

	    String search = "%" + (keyword == null ? "" : keyword.trim()) + "%";

	    try (Connection con = JDBCConnection.getConnection()) {
	        if (con == null) {
	            throw new SQLException("Khong ket noi duoc database CRM_DB");
	        }

	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setString(1, search);
	            ps.setString(2, search);
	            ps.setString(3, search);
	            ps.setString(4, search);
	            ps.setInt(5, limit);
	            ps.setInt(6, offset);

	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    list.add(new TaskListDTO(
	                        rs.getInt("id"),
	                        rs.getString("task_name"),
	                        rs.getString("project_name"),
	                        rs.getString("fullname"),
	                        rs.getDate("start_date"),
	                        rs.getDate("end_date"),
	                        rs.getInt("status_id"),
	                        rs.getString("name_status")
	                    ));
	                }
	            }
	        }
	    }

	    return list;
	}

	public int countTasks(String keyword) throws SQLException {
	    String sql =
	        "SELECT COUNT(*) " +
	        "FROM task t " +
	        "JOIN project p ON t.project_id = p.id " +
	        "JOIN user u ON t.user_id = u.id " +
	        "JOIN status s ON t.status_id = s.id " +
	        "WHERE t.task_name LIKE ? " +
	        "OR p.project_name LIKE ? " +
	        "OR u.fullname LIKE ? " +
	        "OR s.name_status LIKE ?";

	    String search = "%" + (keyword == null ? "" : keyword.trim()) + "%";

	    try (Connection con = JDBCConnection.getConnection()) {
	        if (con == null) {
	            throw new SQLException("Khong ket noi duoc database CRM_DB");
	        }

	        try (PreparedStatement ps = con.prepareStatement(sql)) {
	            ps.setString(1, search);
	            ps.setString(2, search);
	            ps.setString(3, search);
	            ps.setString(4, search);

	            try (ResultSet rs = ps.executeQuery()) {
	                if (rs.next()) {
	                    return rs.getInt(1);
	                }
	            }
	        }
	    }

	    return 0;
	}
    public List<Project> getProjects() throws SQLException {
        List<Project> list = new ArrayList<>();
        String sql = "SELECT id, project_name, start_date, end_date " +
                     "FROM project ORDER BY id";

        try (Connection con = JDBCConnection.getConnection()) {
            if (con == null) throw new SQLException("Loi ket noi database");

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Project(
                        rs.getInt("id"),
                        rs.getString("project_name"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date")
                    ));
                }
            }
        }

        return list;
    }

    public List<User> getUsers() throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT id, email, password, fullname, phone, country, role_id " +
                     "FROM user ORDER BY fullname";

        try (Connection con = JDBCConnection.getConnection()) {
            if (con == null) throw new SQLException("Loi ket noi database");

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new User(
                        rs.getInt("id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getString("phone"),
                        rs.getString("country"),
                        rs.getInt("role_id")
                    ));
                }
            }
        }

        return list;
    }

    public List<Status> getStatuses() throws SQLException {
        List<Status> list = new ArrayList<>();
        String sql = "SELECT id, name_status FROM status ORDER BY id";

        try (Connection con = JDBCConnection.getConnection()) {
            if (con == null) throw new SQLException("Loi ket noi database");

            try (PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new Status(
                        rs.getInt("id"),
                        rs.getString("name_status")
                    ));
                }
            }
        }

        return list;
    }

    public Task findById(int id) throws SQLException {
        String sql = "SELECT * FROM task WHERE id = ?";

        try (Connection con = JDBCConnection.getConnection()) {
            if (con == null) throw new SQLException("Loi ket noi database");

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, id);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return new Task(
                            rs.getInt("id"),
                            rs.getString("task_name"),
                            rs.getDate("start_date"),
                            rs.getDate("end_date"),
                            rs.getInt("status_id"),
                            rs.getInt("project_id"),
                            rs.getInt("user_id")
                        );
                    }
                }
            }
        }

        return null;
    }

    public boolean insert(Task task) throws SQLException {
        String sql = "INSERT INTO task " +
            "(task_name, start_date, end_date, status_id, project_id, user_id) " +
            "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = JDBCConnection.getConnection()) {
            if (con == null) throw new SQLException("Loi ket noi database");

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, task.getTaskName());
                ps.setDate(2, task.getStartDate());
                ps.setDate(3, task.getEndDate());
                ps.setInt(4, task.getStatusId());
                ps.setInt(5, task.getProjectId());
                ps.setInt(6, task.getUserId());

                return ps.executeUpdate() > 0;
            }
        }
    }

    public boolean update(Task task) throws SQLException {
        String sql = "UPDATE task SET task_name = ?, start_date = ?, " +
            "end_date = ?, status_id = ?, project_id = ?, user_id = ? " +
            "WHERE id = ?";

        try (Connection con = JDBCConnection.getConnection()) {
            if (con == null) throw new SQLException("Loi ket noi database");

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, task.getTaskName());
                ps.setDate(2, task.getStartDate());
                ps.setDate(3, task.getEndDate());
                ps.setInt(4, task.getStatusId());
                ps.setInt(5, task.getProjectId());
                ps.setInt(6, task.getUserId());
                ps.setInt(7, task.getId());

                return ps.executeUpdate() > 0;
            }
        }
    }

    public boolean deleteById(int id) throws SQLException {
        String sql = "DELETE FROM task WHERE id = ?";

        try (Connection con = JDBCConnection.getConnection()) {
            if (con == null) throw new SQLException("Loi ket noi database");

            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
            }
        }
    }
}
