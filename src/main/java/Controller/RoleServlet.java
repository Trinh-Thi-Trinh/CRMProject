
package Controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Model.Role;
import dao.RoleDAO;

@WebServlet(urlPatterns = {
    "/role-table",
    "/role-add",
    "/role-edit",
    "/role-save",
    "/role-delete"
})
public class RoleServlet extends HttpServlet {

    private RoleDAO roleDAO;

    @Override
    public void init() throws ServletException {
        roleDAO = new RoleDAO();
    }

    // =========================
    // HIỂN THỊ CÁC TRANG
    // =========================

@Override
protected void doGet(HttpServletRequest req,
                     HttpServletResponse resp)
        throws ServletException, IOException {

    HttpSession session = req.getSession(false);

    if (session == null
            || session.getAttribute("currentUser") == null) {
        resp.sendRedirect(req.getContextPath() + "/login");
        return;
    }

    String path = req.getServletPath();

    if ("/role-table".equals(path)) {

        req.setCharacterEncoding("UTF-8");

        // Từ khóa tìm kiếm
        String keyword = req.getParameter("keywords");
        if (keyword == null) {
            keyword = "";
        }
        keyword = keyword.trim();

        // Số dòng mỗi trang
        int size = 10;
        try {
            size = Integer.parseInt(req.getParameter("size"));
        } catch (Exception e) {
            size = 10;
        }

        if (size != 5 && size != 10
                && size != 25 && size != 50) {
            size = 10;
        }

        // Trang hiện tại
        int page = 1;
        try {
            page = Integer.parseInt(req.getParameter("page"));
        } catch (Exception e) {
            page = 1;
        }

        if (page < 1) {
            page = 1;
        }

        // Đếm tổng số quyền phù hợp
        int totalRecords = roleDAO.countRoles(keyword);

        // Tính tổng số trang
        int totalPage = (int) Math.ceil(
                (double) totalRecords / size
        );

        if (totalPage < 1) {
            totalPage = 1;
        }

        if (page > totalPage) {
            page = totalPage;
        }

        // Lấy dữ liệu của trang hiện tại
        req.setAttribute(
                "list",
                roleDAO.getPaging(keyword, size, page)
        );

        req.setAttribute("keywords", keyword);
        req.setAttribute("size", size);
        req.setAttribute("page", page);
        req.setAttribute("totalPage", totalPage);
        req.setAttribute("totalRecords", totalRecords);

        req.setAttribute(
                "startRecord",
                totalRecords == 0 ? 0 : (page - 1) * size + 1
        );

        req.setAttribute(
                "endRecord",
                Math.min(page * size, totalRecords)
        );

        req.getRequestDispatcher("/views/role-table.jsp")
                .forward(req, resp);
        return;

    } else if ("/role-add".equals(path)) {

        // Mở trang thêm quyền
        req.setAttribute("mode", "add");

        req.getRequestDispatcher("/views/role-add.jsp")
                .forward(req, resp);
        return;

    } else if ("/role-edit".equals(path)) {

        // Lấy ID quyền cần sửa
        String idParam = req.getParameter("id");

        if (idParam == null
                || !idParam.trim().matches("\\d+")) {
            resp.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "ID quyền không hợp lệ."
            );
            return;
        }

        int id = Integer.parseInt(idParam.trim());
        Role role = roleDAO.findById(id);

        if (role == null) {
            resp.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Không tìm thấy quyền cần sửa."
            );
            return;
        }

        // Truyền dữ liệu quyền cần sửa sang JSP
        req.setAttribute("mode", "edit");
        req.setAttribute("roleEdit", role);

        req.getRequestDispatcher("/views/role-add.jsp")
                .forward(req, resp);
        return;

    } else {

        resp.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
}

    // =========================
    // THÊM, SỬA VÀ XÓA
    // =========================
    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null
                || session.getAttribute("currentUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        req.setCharacterEncoding("UTF-8");

        String path = req.getServletPath();
        String contextPath = req.getContextPath();

        try {

            // THÊM HOẶC SỬA QUA CÙNG MỘT FORM
            if ("/role-save".equals(path)) {

                String idParam = req.getParameter("id");
                String nameRole = req.getParameter("nameRole");
                String description = req.getParameter("description");

                description = description == null
                        ? ""
                        : description.trim();

                // -------------------------
                // TRƯỜNG HỢP THÊM QUYỀN
                // Không có ID
                // -------------------------
                if (idParam == null || idParam.trim().isEmpty()) {

                    if (nameRole == null
                            || nameRole.trim().isEmpty()) {

                        req.setAttribute("mode", "add");
                        req.setAttribute(
                            "error",
                            "Tên quyền không được để trống."
                        );

                        req.getRequestDispatcher("/views/role-add.jsp")
                           .forward(req, resp);
                        return;
                    }

                    Role role = new Role(
                        nameRole.trim(),
                        description
                    );

                    if (roleDAO.insert(role)) {
                        resp.sendRedirect(
                            contextPath + "/role-table?added=1"
                        );
                    } else {
                        req.setAttribute("mode", "add");
                        req.setAttribute(
                            "error",
                            "Không thể thêm quyền. Vui lòng kiểm tra dữ liệu."
                        );

                        req.getRequestDispatcher("/views/role-add.jsp")
                           .forward(req, resp);
                    }

                    return;
                }

                // -------------------------
                // TRƯỜNG HỢP SỬA QUYỀN
                // Có ID cũ
                // -------------------------
                if (!idParam.trim().matches("\\d+")) {
                    resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "ID quyền không hợp lệ."
                    );
                    return;
                }

                int id = Integer.parseInt(idParam.trim());

                if (nameRole == null
                        || nameRole.trim().isEmpty()) {

                    Role role = new Role(
                        id,
                        "",
                        description
                    );

                    req.setAttribute("mode", "edit");
                    req.setAttribute("roleEdit", role);
                    req.setAttribute(
                        "error",
                        "Tên quyền không được để trống."
                    );

                    req.getRequestDispatcher("/views/role-add.jsp")
                       .forward(req, resp);
                    return;
                }

                Role role = new Role(
                    id,
                    nameRole.trim(),
                    description
                );

                if (roleDAO.update(role)) {
                    resp.sendRedirect(
                        contextPath + "/role-table?updated=1"
                    );
                } else {
                    req.setAttribute("mode", "edit");
                    req.setAttribute("roleEdit", role);
                    req.setAttribute(
                        "error",
                        "Cập nhật quyền không thành công."
                    );

                    req.getRequestDispatcher("/views/role-add.jsp")
                       .forward(req, resp);
                }

                return;

            // -------------------------
            // XÓA QUYỀN
            // -------------------------
            } else if ("/role-delete".equals(path)) {

                String idParam = req.getParameter("id");

                System.out.println(
                    "DELETE idParam = [" + idParam + "]"
                );

                if (idParam == null
                        || !idParam.trim().matches("\\d+")) {
                    resp.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "ID bị thiếu hoặc không hợp lệ."
                    );
                    return;
                }

                int id = Integer.parseInt(idParam.trim());

                try {
                    roleDAO.deleteById(id);

                    resp.sendRedirect(
                        contextPath + "/role-table?deleted=1"
                    );

                } catch (SQLException e) {
                    e.printStackTrace();

                    resp.sendRedirect(
                        contextPath + "/role-table?error=used"
                    );
                }

                return;

            } else {

                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }

        } catch (NumberFormatException e) {

            resp.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "ID quyền không hợp lệ."
            );
        }
    }
}
