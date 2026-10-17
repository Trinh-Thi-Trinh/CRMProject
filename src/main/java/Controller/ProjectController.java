
package Controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Project;
import dao.ProjectDAO;
import dto.TaskDetailDTO;

@WebServlet(urlPatterns = {
    "/groupwork",
    "/groupwork-add",
    "/groupwork-edit",
    "/groupwork-save",
    "/groupwork-delete",
    "/groupwork-details"
})
public class ProjectController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProjectDAO projectDAO;

    @Override
    public void init() throws ServletException {
        projectDAO = new ProjectDAO();
    }

    // =========================
    // XU LY CAC REQUEST GET
    // =========================
    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Kiem tra dang nhap
        if (session == null
                || session.getAttribute("currentUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();

        try {

            // =========================
            // 1. DANH SACH DU AN
            // URL: /groupwork
            // =========================
            if ("/groupwork".equals(path)) {

                String keyword = req.getParameter("keywords");

                if (keyword == null) {
                    keyword = "";
                }

                keyword = keyword.trim();

                int size = 10;
                int page = 1;

                try {
                    String sizeParam = req.getParameter("size");

                    if (sizeParam != null) {
                        int selectedSize = Integer.parseInt(sizeParam);

                        if (selectedSize == 5
                                || selectedSize == 10
                                || selectedSize == 25
                                || selectedSize == 50) {
                            size = selectedSize;
                        }
                    }

                    String pageParam = req.getParameter("page");

                    if (pageParam != null) {
                        page = Integer.parseInt(pageParam);
                    }

                } catch (NumberFormatException e) {
                    size = 10;
                    page = 1;
                }

                if (page < 1) {
                    page = 1;
                }

                int totalRecords = projectDAO.countProjects(keyword);

                int totalPage =
                        (int) Math.ceil((double) totalRecords / size);

                if (totalPage > 0 && page > totalPage) {
                    page = totalPage;
                }

                if (totalPage == 0) {
                    page = 1;
                }

                List<Project> list =
                        projectDAO.getPaging(keyword, size, page);

                int startRecord = 0;
                int endRecord = 0;

                if (list != null && !list.isEmpty()) {
                    startRecord = (page - 1) * size + 1;
                    endRecord = startRecord + list.size() - 1;
                }

                req.setAttribute("list", list);
                req.setAttribute("keywords", keyword);
                req.setAttribute("size", size);
                req.setAttribute("page", page);
                req.setAttribute("totalPage", totalPage);
                req.setAttribute("totalRecords", totalRecords);
                req.setAttribute("startRecord", startRecord);
                req.setAttribute("endRecord", endRecord);

                req.getRequestDispatcher("/views/groupwork.jsp")
                   .forward(req, resp);

                return;
            }

            // =========================
            // 2. FORM THEM DU AN
            // URL: /groupwork-add
            // =========================
            if ("/groupwork-add".equals(path)) {

                req.setAttribute("mode", "add");

                req.getRequestDispatcher("/views/groupwork-add.jsp")
                   .forward(req, resp);

                return;
            }

            // =========================
            // 3. FORM SUA DU AN
            // URL: /groupwork-edit?id=1
            // =========================
            if ("/groupwork-edit".equals(path)) {

                String idParam = req.getParameter("id");

                if (idParam == null || !idParam.matches("\\d+")) {
                    resp.sendRedirect(
                            req.getContextPath()
                            + "/groupwork?error=invalid");
                    return;
                }

                int id = Integer.parseInt(idParam);

                Project project = projectDAO.findById(id);

                if (project == null) {
                    resp.sendRedirect(
                            req.getContextPath()
                            + "/groupwork?error=notfound");
                    return;
                }

                req.setAttribute("mode", "edit");
                req.setAttribute("projectEdit", project);

                req.getRequestDispatcher("/views/groupwork-add.jsp")
                   .forward(req, resp);

                return;
            }// Xem chi tiết project và danh sách task thuộc project đó
            if ("/groupwork-details".equals(path)) {

                // 1. Lấy ID project từ URL
                String idParam = req.getParameter("id");

                // 2. Kiểm tra ID có hợp lệ không
                if (idParam == null || !idParam.matches("\\d+")) {
                    resp.sendRedirect(
                        req.getContextPath() + "/groupwork?error=invalid"
                    );
                    return;
                }

                int id = Integer.parseInt(idParam);

                // 3. Tìm thông tin project theo ID
                Project project = projectDAO.findById(id);

                // 4. Nếu không tìm thấy project thì quay lại danh sách
                if (project == null) {
                    resp.sendRedirect(
                        req.getContextPath() + "/groupwork?error=notfound"
                    );
                    return;
                }

                // 5. Lấy danh sách task thuộc project này
                List<TaskDetailDTO> taskList =
                        projectDAO.getTasksByProjectId(id);

                // 6. Gửi dữ liệu project sang JSP
                req.setAttribute("projectDetail", project);

                // 7. Gửi danh sách task sang JSP
                req.setAttribute("taskList", taskList);

                // 8. Mở trang chi tiết project
                req.getRequestDispatcher(
                    "/views/groupwork-details.jsp"
                ).forward(req, resp);

                return;
            }

            // =========================
            // 4. CHI TIET DU AN
            // URL: /groupwork-detail?id=1
            // =========================
       

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(
                    "Loi khi xu ly chuc nang du an", e);
        }
    }

    // =========================
    // XU LY CAC REQUEST POST
    // =========================
    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // Kiem tra dang nhap
        if (session == null
                || session.getAttribute("currentUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();
        String contextPath = req.getContextPath();

        // =========================
        // 1. THEM HOAC SUA DU AN
        // URL: /groupwork-save
        // =========================
        if ("/groupwork-save".equals(path)) {

            String idParam = req.getParameter("id");
            String projectName = req.getParameter("projectName");
            String startDateParam = req.getParameter("startDate");
            String endDateParam = req.getParameter("endDate");

            if (projectName == null) {
                projectName = "";
            }

            projectName = projectName.trim();

            boolean isEdit =
                    idParam != null && !idParam.trim().isEmpty();

            int id = 0;

            if (isEdit) {
                if (!idParam.matches("\\d+")) {
                    resp.sendRedirect(
                            contextPath + "/groupwork?error=invalid");
                    return;
                }

                id = Integer.parseInt(idParam);
            }

            Date startDate = null;
            Date endDate = null;

            try {

                if (projectName.isEmpty()) {
                    throw new IllegalArgumentException(
                            "Ten du an khong duoc de trong.");
                }

                if (startDateParam == null
                        || startDateParam.trim().isEmpty()
                        || endDateParam == null
                        || endDateParam.trim().isEmpty()) {
                    throw new IllegalArgumentException(
                            "Ban phai nhap ngay bat dau va ngay ket thuc.");
                }

                startDate = Date.valueOf(startDateParam);
                endDate = Date.valueOf(endDateParam);

                if (endDate.before(startDate)) {
                    throw new IllegalArgumentException(
                            "Ngay ket thuc khong duoc truoc ngay bat dau.");
                }

                Project project;

                // SUA DU AN
                if (isEdit) {

                    project = new Project(
                            id,
                            projectName,
                            startDate,
                            endDate);

                    if (projectDAO.update(project)) {
                        resp.sendRedirect(
                                contextPath + "/groupwork?updated=1");
                    } else {
                        resp.sendRedirect(
                                contextPath + "/groupwork?error=save");
                    }

                } else {

                    // THEM DU AN MOI
                    project = new Project(
                            projectName,
                            startDate,
                            endDate);

                    if (projectDAO.insert(project)) {
                        resp.sendRedirect(
                                contextPath + "/groupwork?added=1");
                    } else {
                        resp.sendRedirect(
                                contextPath + "/groupwork?error=save");
                    }
                }

            } catch (IllegalArgumentException e) {

                Project project = new Project(
                        id,
                        projectName,
                        startDate,
                        endDate);

                req.setAttribute("mode", isEdit ? "edit" : "add");
                req.setAttribute("projectEdit", project);
                req.setAttribute("errorMessage", e.getMessage());

                req.getRequestDispatcher("/views/groupwork-add.jsp")
                   .forward(req, resp);
            }

            return;
        }

        // =========================
        // 2. XOA DU AN
        // URL: /groupwork-delete
        // =========================
        if ("/groupwork-delete".equals(path)) {

            String idParam = req.getParameter("id");

            if (idParam == null || !idParam.matches("\\d+")) {
                resp.sendRedirect(
                        contextPath + "/groupwork?error=invalid");
                return;
            }

            int id = Integer.parseInt(idParam);

            try {

                // Khong xoa neu du an da co task
                if (projectDAO.hasTasks(id)) {
                    resp.sendRedirect(
                            contextPath + "/groupwork?error=used");
                    return;
                }

                projectDAO.deleteById(id);

                resp.sendRedirect(
                        contextPath + "/groupwork?deleted=1");

            } catch (SQLException e) {
                e.printStackTrace();

                resp.sendRedirect(
                        contextPath + "/groupwork?error=used");
            }

            return;
        }

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
}
