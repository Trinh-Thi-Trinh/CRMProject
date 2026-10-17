package repositories;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.JDBCConnection;
import dto.TaskDetailDTO;

public class TaskRepository {

    public List<TaskDetailDTO> getTasksByUserId(int userId)
            throws SQLException {

        List<TaskDetailDTO> tasks = new ArrayList<>();

        String sql = "SELECT t.id, t.task_name, "
                + "t.start_date, t.end_date, "
                + "t.status_id, s.name_status, "
                + "p.project_name "
                + "FROM task t "
                + "INNER JOIN status s ON t.status_id = s.id "
                + "INNER JOIN project p ON t.project_id = p.id "
                + "WHERE t.user_id = ? "
                + "ORDER BY t.start_date ASC";

        try (Connection con = JDBCConnection.getConnection();
             PreparedStatement statement = con.prepareStatement(sql)) {

            statement.setInt(1, userId);

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

                    tasks.add(task);
                }
            }
        }

        return tasks;
    }
}