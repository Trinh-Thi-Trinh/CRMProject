package services;

import java.sql.SQLException;
import java.util.List;

import dto.TaskDetailDTO;
import repositories.TaskRepository;

public class TaskService {

    private TaskRepository taskRepository = new TaskRepository();

    public List<TaskDetailDTO> getTasksByUserId(int userId)
            throws SQLException {
        return taskRepository.getTasksByUserId(userId);
    }
}