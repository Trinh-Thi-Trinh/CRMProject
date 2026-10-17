package Controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.List;
import dto.TaskDetailDTO;
import Model.User;
import dao.RoleDAO;
import dto.CreateUserDTO;
import services.TaskService;
import services.UserService;

@WebServlet(name = "UserController", urlPatterns = { "/user-table", "/user-add", "/user-delete", "/user-edit",
		"/user-details", "/profile", "/profile-edit", "/blank","/404" })
public class UserController extends HttpServlet {
	private final UserService userService;

	public UserController() {

		userService = new UserService();
	}

	private TaskService taskService = new TaskService();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		switch (path) {
		case "/user-table": {
			String keywords = req.getParameter("keywords");
			String pageParam = req.getParameter("page"); // tu url

			int size = 5;
			int page = 1;
			if (pageParam != null) {
				page = Integer.parseInt(pageParam);
			}
			if (keywords == null) {
				keywords = "";
			}

			try {
				int totalRow = userService.countUsers(keywords);
				// caafn du lieu cua user
				int totalPage = (totalRow + size - 1) / size;

				req.setAttribute("totalPage", totalPage);
				req.setAttribute("page", page);

				System.out.println(totalRow);
				System.out.println(totalPage);
				req.setAttribute("users", userService.getUserPaging(keywords, size, page));
				req.getRequestDispatcher("/views/user-table.jsp").forward(req, resp);

			} catch (SQLException e) {
				throw new ServletException("Không tải được danh sách User", e);
			}
			break;
		}
		case "/user-add": {
			req.setAttribute("roles", new RoleDAO().getAll());
			req.getRequestDispatcher("/views/user-add.jsp").forward(req, resp);
			break;
		}

		case "/user-edit": {
			int id;
			try {
				id = Integer.parseInt(req.getParameter("id"));
			} catch (Exception e) {
				// TODO: handle exception
				return;
			}
			// lay thong tin use tu DB
			try {
				User user = userService.findById(id);
				req.setAttribute("userEdit", user);
			} catch (Exception e) {
				// TODO: handle exception
				return;
			}

			// set gia tri cho jsp

			req.setAttribute("roles", new RoleDAO().getAll());
			req.setAttribute("isEdit", true);
			req.getRequestDispatcher("/views/user-add.jsp").forward(req, resp);
			break;
		}

		case "/user-details": {
			String idParam = req.getParameter("id");

			try {
				int id = Integer.parseInt(idParam);

				// 1. Lấy thông tin thành viên
				User user = userService.findById(id);

				if (user == null) {
					resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy thành viên");
					return;
				}

				// 2. Lấy danh sách công việc của thành viên
				List<TaskDetailDTO> tasks = taskService.getTasksByUserId(id);

				// 3. Đếm số công việc theo trạng thái
				int chuaThucHien = 0;
				int dangThucHien = 0;
				int daHoanThanh = 0;

				for (TaskDetailDTO task : tasks) {
					if (task.getStatusId() == 1) {
						// id = 1: Dang Thuc Hien
						dangThucHien++;
					} else if (task.getStatusId() == 2) {
						// id = 2: Chua Thuc Hien
						chuaThucHien++;
					} else if (task.getStatusId() == 3) {
						// id = 3: Da Hoan Thanh
						daHoanThanh++;
					}
				}

				// 4. Tính phần trăm
				int total = tasks.size();

				int chuaThucHienPercent = 0;
				int dangThucHienPercent = 0;
				int daHoanThanhPercent = 0;

				if (total > 0) {
					chuaThucHienPercent = chuaThucHien * 100 / total;

					dangThucHienPercent = dangThucHien * 100 / total;

					daHoanThanhPercent = daHoanThanh * 100 / total;
				}

				// 5. Gửi dữ liệu sang JSP
				req.setAttribute("user", user);
				req.setAttribute("tasks", tasks);

				req.setAttribute("totalTasks", total);

				req.setAttribute("chuaThucHien", chuaThucHien);
				req.setAttribute("dangThucHien", dangThucHien);
				req.setAttribute("daHoanThanh", daHoanThanh);

				req.setAttribute("chuaThucHienPercent", chuaThucHienPercent);
				req.setAttribute("dangThucHienPercent", dangThucHienPercent);
				req.setAttribute("daHoanThanhPercent", daHoanThanhPercent);

				req.getRequestDispatcher("/views/user-details.jsp").forward(req, resp);

			} catch (NumberFormatException e) {
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID thành viên không hợp lệ");
				return;

			} catch (SQLException e) {
				throw new ServletException("Lỗi khi lấy dữ liệu chi tiết thành viên", e);
			}

			break;
		}

		case "/profile": {
			HttpSession session = req.getSession(false);

			// Kiểm tra người dùng đã đăng nhập chưa
			if (session == null || session.getAttribute("currentUser") == null) {
				resp.sendRedirect(req.getContextPath() + "/login");
				return;
			}

			// Lấy người đang đăng nhập
			User currentUser = (User) session.getAttribute("currentUser");

			// Lấy công việc của chính người đó
			List<TaskDetailDTO> tasks;

			try {
				tasks = taskService.getTasksByUserId(currentUser.getId());
			} catch (SQLException e) {
				throw new ServletException("Lỗi khi lấy danh sách công việc cá nhân", e);
			}
			int chuaThucHien = 0;
			int dangThucHien = 0;
			int daHoanThanh = 0;

			for (TaskDetailDTO task : tasks) {
				if (task.getStatusId() == 1) {
					dangThucHien++;
				} else if (task.getStatusId() == 2) {
					chuaThucHien++;
				} else if (task.getStatusId() == 3) {
					daHoanThanh++;
				}
			}

			int totalTasks = tasks.size();

			int chuaThucHienPercent = 0;
			int dangThucHienPercent = 0;
			int daHoanThanhPercent = 0;
			if (totalTasks > 0) {
				chuaThucHienPercent = chuaThucHien * 100 / totalTasks;

				dangThucHienPercent = dangThucHien * 100 / totalTasks;

				daHoanThanhPercent = daHoanThanh * 100 / totalTasks;
			}

			req.setAttribute("user", currentUser);
			req.setAttribute("tasks", tasks);
			req.setAttribute("totalTasks", totalTasks);

			req.setAttribute("chuaThucHien", chuaThucHien);
			req.setAttribute("dangThucHien", dangThucHien);
			req.setAttribute("daHoanThanh", daHoanThanh);

			req.setAttribute("chuaThucHienPercent", chuaThucHienPercent);
			req.setAttribute("dangThucHienPercent", dangThucHienPercent);
			req.setAttribute("daHoanThanhPercent", daHoanThanhPercent);

			req.getRequestDispatcher("/views/profile.jsp").forward(req, resp);
			break;
		}
		case "/profile-edit": {
			HttpSession session = req.getSession(false);

			if (session == null || session.getAttribute("currentUser") == null) {
				resp.sendRedirect(req.getContextPath() + "/login");
				return;
			}
			User currentUser = (User) session.getAttribute("currentUser");
			try {
				// Lấy thông tin mới nhất từ database
				User userEdit = userService.findById(currentUser.getId());

				if (userEdit == null) {
					resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy thông tin cá nhân");
					return;
				}
				req.setAttribute("userEdit", userEdit);
				req.getRequestDispatcher("/views/profile-edit.jsp").forward(req, resp);

			} catch (SQLException e) {
				throw new ServletException("Lỗi khi lấy thông tin cá nhân", e);
			}

			break;
		}
		case "/blank": {
		    req.getRequestDispatcher("/views/blank.jsp")
		       .forward(req, resp);
		    break;
		}
		case "/404": {
		    req.getRequestDispatcher("/views/404.jsp")
		       .forward(req, resp);
		    break;
		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + path);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String path = req.getServletPath();
		switch (path) {

		case "/user-add": {
			CreateUserDTO dto = new CreateUserDTO();
			dto.setEmail(req.getParameter("email"));
			dto.setPassword(req.getParameter("password"));
			dto.setFullname(req.getParameter("fullname"));
			dto.setPhone(req.getParameter("phone"));
			dto.setCountry(req.getParameter("country"));
			dto.setRoleId(Integer.parseInt(req.getParameter("roleId")));

			String error = userService.create(dto);
			if (error == null) {
				req.setAttribute("error", null);
				resp.sendRedirect(req.getContextPath() + "/user-add? created=1");
				return;
			}
			req.setAttribute("error", error);
			req.setAttribute("roles", new RoleDAO().getAll());
			req.setAttribute("isEdit", true);
			req.getRequestDispatcher("/views/user-add.jsp").forward(req, resp);
			break;
		}
		case "/user-delete": {
			int id;
			try {
				id = Integer.parseInt(req.getParameter("id"));
			} catch (NumberFormatException e) {
				// TODO: handle exception
				resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
				return;
			}
			try {
				String err = userService.deleteById(id);
				if (err == null) {
					resp.sendRedirect(req.getContextPath() + "/user-table?delete=1");
				} else {
					resp.sendRedirect(req.getContextPath() + "/user-table?err=1");
				}
			} catch (Exception e) {
				// TODO: handle exception
			}
			return;
		}
		case "/user-edit": {
			req.setCharacterEncoding("UTF-8");
			int roleId;
			int id;
			try {
				roleId = Integer.parseInt(req.getParameter("roleId"));
				id = Integer.parseInt(req.getParameter("id"));
			} catch (Exception e) {
				// TODO: handle exception
				req.setAttribute("error", "RoleId hoac Id sai dinh dang");
				return;
			}
			// edit casi gif
			User user = new User();
			user.setFullname(req.getParameter("fullname"));
			user.setEmail(req.getParameter("email"));
			user.setPhone(req.getParameter("phone"));
			user.setCountry(req.getParameter("country"));
			user.setRoleId(roleId);
			user.setId(id);

			try {
				String err = userService.update(user);
				if (err == null) {// thanh cong
					resp.sendRedirect(req.getContextPath() + "/user-table");
					return;
				}
				req.setAttribute("error", err);
				req.setAttribute("roles", new RoleDAO().getAll());
				req.setAttribute("isEdit", true); //
				req.setAttribute("userEdit", user); //

				req.getRequestDispatcher("/views/user-add.jsp").forward(req, resp);

			} catch (Exception e) {
				// TODO: handle exception
				return;
			}

			break;
		}
		case "/profile-edit": {
			req.setCharacterEncoding("UTF-8");

			HttpSession session = req.getSession(false);

			if (session == null || session.getAttribute("currentUser") == null) {
				resp.sendRedirect(req.getContextPath() + "/login");
				return;
			}

			// Lấy ID từ session, không lấy ID người dùng từ form
			User currentUser = (User) session.getAttribute("currentUser");

			String fullname = req.getParameter("fullname");
			String email = req.getParameter("email");
			String phone = req.getParameter("phone");
			String country = req.getParameter("country");

			User user = new User();
			user.setId(currentUser.getId());
			user.setFullname(fullname);
			user.setEmail(email);
			user.setPhone(phone);
			user.setCountry(country);

			// Giữ nguyên mật khẩu và quyền hiện tại
			user.setPassword(currentUser.getPassword());
			user.setRoleId(currentUser.getRoleId());

			try {
				String error = userService.update(user);

				if (error == null) {
					// Cập nhật thành công: lấy lại thông tin từ database
					User updatedUser = userService.findById(currentUser.getId());

					if (updatedUser != null) {
						session.setAttribute("currentUser", updatedUser);
					}

					resp.sendRedirect(req.getContextPath() + "/profile");
					return;
				}

				req.setAttribute("error", error);
				req.setAttribute("userEdit", user);
				req.getRequestDispatcher("/views/profile-edit.jsp").forward(req, resp);

			} catch (SQLException e) {
				throw new ServletException("Lỗi khi cập nhật thông tin cá nhân", e);
			}

			break;
		}
		default:
			throw new IllegalArgumentException("Unexpected value: " + path);
		}
	}
}
