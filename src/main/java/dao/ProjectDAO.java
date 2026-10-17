
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Model.Project;
import connection.JDBCConnection;
import dto.TaskDetailDTO;

public class ProjectDAO {

    // 1. Lấy toàn bộ danh sách project
    public List<Project> getAll() {
        List<Project> projects = new ArrayList<>();

        String sql = "SELECT id, project_name, start_date, end_date "
                   + "FROM project ORDER BY id ASC";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql);
            ResultSet rs = statement.executeQuery()
        ) {
            while (rs.next()) {
                Project project = new Project(
                    rs.getInt("id"),
                    rs.getString("project_name"),
                    rs.getDate("start_date"),
                    rs.getDate("end_date")
                );

                projects.add(project);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return projects;
    }

    // 2. Thêm project mới
    public boolean insert(Project project) {
        String sql = "INSERT INTO project "
                   + "(project_name, start_date, end_date) "
                   + "VALUES (?, ?, ?)";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql)
        ) {
            statement.setString(1, project.getProjectName());
            statement.setDate(2, project.getStartDate());
            statement.setDate(3, project.getEndDate());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3. Tìm project theo ID
    public Project findById(int id) {
        String sql = "SELECT id, project_name, start_date, end_date "
                   + "FROM project WHERE id = ?";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql)
        ) {
            statement.setInt(1, id);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return new Project(
                        rs.getInt("id"),
                        rs.getString("project_name"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // 4. Cập nhật project
    public boolean update(Project project) {
        String sql = "UPDATE project "
                   + "SET project_name = ?, start_date = ?, end_date = ? "
                   + "WHERE id = ?";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql)
        ) {
            statement.setString(1, project.getProjectName());
            statement.setDate(2, project.getStartDate());
            statement.setDate(3, project.getEndDate());
            statement.setInt(4, project.getId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 5. Xóa project theo ID
    public void deleteById(int id) throws SQLException {
        String sql = "DELETE FROM project WHERE id = ?";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql)
        ) {
            statement.setInt(1, id);
            statement.executeUpdate();
        }
    }

    // 6. Tìm kiếm project và phân trang
    // page bắt đầu từ 1
    public List<Project> getPaging(String keyword, int size, int page) {
        List<Project> projects = new ArrayList<>();

        if (keyword == null) {
            keyword = "";
        }

        if (size <= 0) {
            size = 5;
        }

        if (page < 1) {
            page = 1;
        }

        String sql = "SELECT id, project_name, start_date, end_date "
                   + "FROM project "
                   + "WHERE project_name LIKE ? "
                   + "ORDER BY id ASC "
                   + "LIMIT ? OFFSET ?";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql)
        ) {
            statement.setString(1, "%" + keyword.trim() + "%");
            statement.setInt(2, size);
            statement.setInt(3, (page - 1) * size);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    Project project = new Project(
                        rs.getInt("id"),
                        rs.getString("project_name"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date")
                    );

                    projects.add(project);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return projects;
    }

    // 7. Đếm tổng số project theo từ khóa tìm kiếm
    public int countProjects(String keyword) {
        if (keyword == null) {
            keyword = "";
        }

        String sql = "SELECT COUNT(*) FROM project "
                   + "WHERE project_name LIKE ?";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql)
        ) {
            statement.setString(1, "%" + keyword.trim() + "%");

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    // 8. Kiểm tra project có task hay không
    public boolean hasTasks(int projectId) {
        String sql = "SELECT COUNT(*) FROM task WHERE project_id = ?";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql)
        ) {
            statement.setInt(1, projectId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();

            // Nếu truy vấn lỗi, không cho xóa để tránh xóa nhầm
            return true;
        }

        return true;
    }

    // 9. Lấy danh sách task thuộc một project
    public List<TaskDetailDTO> getTasksByProjectId(int projectId) {
        List<TaskDetailDTO> taskList = new ArrayList<>();

        String sql = "SELECT "
                   + "t.id, "
                   + "t.task_name, "
                   + "t.start_date, "
                   + "t.end_date, "
                   + "s.id AS status_id, "
                   + "s.name_status, "
                   + "p.project_name "
                   + "FROM task t "
                   + "INNER JOIN status s ON t.status_id = s.id "
                   + "INNER JOIN project p ON t.project_id = p.id "
                   + "WHERE t.project_id = ? "
                   + "ORDER BY t.id ASC";

        try (
            Connection con = JDBCConnection.getConnection();
            PreparedStatement statement = con.prepareStatement(sql)
        ) {
            statement.setInt(1, projectId);

            try (ResultSet rs = statement.executeQuery()) {
                while (rs.next()) {
                    TaskDetailDTO task = new TaskDetailDTO(
                        rs.getInt("id"),
                        rs.getString("task_name"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getInt("status_id"),
                        rs.getString("name_status"),
                        rs.getString("project_name")
                    );

                    taskList.add(task);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return taskList;
    }
}
