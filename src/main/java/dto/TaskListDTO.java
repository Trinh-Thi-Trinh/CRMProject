
package dto;

import java.sql.Date;

public class TaskListDTO {
    private int id;
    private String taskName;
    private String projectName;
    private String fullname;
    private Date startDate;
    private Date endDate;
    private int statusId;
    private String statusName;

    public TaskListDTO(int id, String taskName, String projectName,
            String fullname, Date startDate, Date endDate,
            int statusId, String statusName) {
        this.id = id;
        this.taskName = taskName;
        this.projectName = projectName;
        this.fullname = fullname;
        this.startDate = startDate;
        this.endDate = endDate;
        this.statusId = statusId;
        this.statusName = statusName;
    }

    public int getId() { return id; }
    public String getTaskName() { return taskName; }
    public String getProjectName() { return projectName; }
    public String getFullname() { return fullname; }
    public Date getStartDate() { return startDate; }
    public Date getEndDate() { return endDate; }
    public int getStatusId() { return statusId; }
    public String getStatusName() { return statusName; }
}
