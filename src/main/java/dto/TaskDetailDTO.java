package dto;

import java.sql.Date;

public class TaskDetailDTO {

    private int id;
    private String taskName;
    private Date startDate;
    private Date endDate;
    private int statusId;
    private String statusName;
    private String projectName;

    public TaskDetailDTO() {
    }

    public TaskDetailDTO(int id, String taskName,
            Date startDate, Date endDate,
            int statusId, String statusName,
            String projectName) {
        this.id = id;
        this.taskName = taskName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.statusId = statusId;
        this.statusName = statusName;
        this.projectName = projectName;
    }

    public int getId() {
        return id;
    }

    public String getTaskName() {
        return taskName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public int getStatusId() {
        return statusId;
    }

    public String getStatusName() {
        return statusName;
    }

    public String getProjectName() {
        return projectName;
    }
}