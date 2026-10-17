
package Controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Task;
import dao.TaskDAO;

@WebServlet(urlPatterns = {
    "/task",
    "/task-add",
    "/task-edit",
    "/task-save",
    "/task-delete" 
})
public class TaskController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TaskDAO taskDAO;

    @Override
    public void init() {
        taskDAO = new TaskDAO();
    }

    private boolean checkLogin(HttpServletRequest req,
                               HttpServletResponse resp)
            throws IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return false;
        }

        return true;
    }

    private void loadFormData(HttpServletRequest req)
            throws SQLException {
        req.setAttribute("projects", taskDAO.getProjects());
        req.setAttribute("users", taskDAO.getUsers());
        req.setAttribute("statuses", taskDAO.getStatuses());
    }

    private int readId(String value) {
        if (value == null || !value.matches("\\d+")) {
            throw new IllegalArgumentException("ID khong hop le");
        }
        return Integer.parseInt(value);
    }

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        if (!checkLogin(req, resp)) return;

        req.setCharacterEncoding("UTF-8");

        try {
            String path = req.getServletPath();
            if ("/task".equals(path)) {
                String keyword = req.getParameter("keyword");

                int page = 1;
                int pageSize = 10;

                try {
                    page = Integer.parseInt(req.getParameter("page"));
                } catch (Exception e) {
                    page = 1;
                }

                try {
                    pageSize = Integer.parseInt(req.getParameter("pageSize"));
                } catch (Exception e) {
                    pageSize = 10;
                }

                // Chỉ cho phép các lựa chọn trong giao diện
                if (pageSize != 10 && pageSize != 25
                        && pageSize != 50 && pageSize != 100) {
                    pageSize = 10;
                }

                if (page < 1) {
                    page = 1;
                }

                int totalEntries = taskDAO.countTasks(keyword);

                int totalPages = (int) Math.ceil(
                    (double) totalEntries / pageSize
                );

                if (totalPages == 0) {
                    totalPages = 1;
                }

                if (page > totalPages) {
                    page = totalPages;
                }

                int offset = (page - 1) * pageSize;

                req.setAttribute(
                    "taskList",
                    taskDAO.searchAndPaginate(keyword, pageSize, offset)
                );
                req.setAttribute("keyword", keyword == null ? "" : keyword.trim());
                req.setAttribute("page", page);
                req.setAttribute("pageSize", pageSize);
                req.setAttribute("totalEntries", totalEntries);
                req.setAttribute("totalPages", totalPages);
                req.setAttribute("startEntry",
                    totalEntries == 0 ? 0 : offset + 1);
                req.setAttribute("endEntry",
                    Math.min(offset + pageSize, totalEntries));

                req.getRequestDispatcher("/views/task.jsp")
                   .forward(req, resp);
                return;
            }
            if ("/task-add".equals(path)) {
                loadFormData(req);
                req.setAttribute("mode", "add");
                req.getRequestDispatcher("/views/task-add.jsp")
                   .forward(req, resp);
                return;
            }

            if ("/task-edit".equals(path)) {
                int id = readId(req.getParameter("id"));
                Task task = taskDAO.findById(id);

                if (task == null) {
                    resp.sendRedirect(req.getContextPath()
                        + "/task?error=notfound");
                    return;
                }

                loadFormData(req);
                req.setAttribute("mode", "edit");
                req.setAttribute("taskEdit", task);
                req.getRequestDispatcher("/views/task-add.jsp")
                   .forward(req, resp);
                return;
            }


            resp.sendError(HttpServletResponse.SC_NOT_FOUND);

        } catch (IllegalArgumentException e) {
            resp.sendRedirect(req.getContextPath() + "/task?error=invalid");
        } catch (SQLException e) {
            throw new ServletException("Loi truy van du lieu cong viec", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        if (!checkLogin(req, resp)) return;

        req.setCharacterEncoding("UTF-8");
        String context = req.getContextPath();
        String path = req.getServletPath();

        if ("/task-delete".equals(path)) {
            try {
                int id = readId(req.getParameter("id"));
                boolean deleted = taskDAO.deleteById(id);

                resp.sendRedirect(context + "/task?deleted="
                    + (deleted ? "1" : "0"));

            } catch (IllegalArgumentException e) {
                resp.sendRedirect(context + "/task?error=invalid");
            } catch (SQLException e) {
                throw new ServletException("Khong the xoa cong viec", e);
            }
            return;
        }

        if (!"/task-save".equals(path)) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String idParam = req.getParameter("id");
        String taskName = req.getParameter("taskName");
        String startParam = req.getParameter("startDate");
        String endParam = req.getParameter("endDate");

        boolean edit = idParam != null && !idParam.trim().isEmpty();

        try {
            int id = edit ? readId(idParam) : 0;
            int projectId = readId(req.getParameter("projectId"));
            int userId = readId(req.getParameter("userId"));
            int statusId = readId(req.getParameter("statusId"));

            if (taskName == null || taskName.trim().isEmpty()) {
                throw new IllegalArgumentException("Ten cong viec khong duoc de trong");
            }

            if (startParam == null || startParam.trim().isEmpty()
                    || endParam == null || endParam.trim().isEmpty()) {
                throw new IllegalArgumentException("Ban phai nhap ca hai ngay");
            }

            Date startDate = Date.valueOf(startParam);
            Date endDate = Date.valueOf(endParam);

            if (endDate.before(startDate)) {
                throw new IllegalArgumentException(
                    "Ngay ket thuc khong duoc truoc ngay bat dau");
            }

            Task task = new Task(id, taskName.trim(), startDate, endDate,
                                 statusId, projectId, userId);

            boolean success;

            if (edit) {
                success = taskDAO.update(task);
            } else {
                success = taskDAO.insert(task);
            }

            if (success) {
                resp.sendRedirect(context + "/task?"
                    + (edit ? "updated=1" : "added=1"));
            } else {
                resp.sendRedirect(context + "/task?error=save");
            }

        } catch (IllegalArgumentException e) {
            try {
                loadFormData(req);
                req.setAttribute("mode", edit ? "edit" : "add");
                req.setAttribute("errorMessage", e.getMessage());
                req.getRequestDispatcher("/views/task-add.jsp")
                   .forward(req, resp);
            } catch (SQLException ex) {
                throw new ServletException("Khong tai duoc du lieu form", ex);
            }
        } catch (SQLException e) {
            throw new ServletException("Loi luu cong viec", e);
        }
    }
}
