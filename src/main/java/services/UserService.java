
package services;

import java.sql.SQLException;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import Model.User;
import dto.CreateUserDTO;
import dto.UserListDTO;
import repositories.UserRepository;

public class UserService {

    private final UserRepository userRepository;

    public UserService() {
        userRepository = new UserRepository();
    }

    // Lấy toàn bộ user
    public List<UserListDTO> getAllUser() {
        return userRepository.getAllUser();
    }

    // Thêm user
    public String create(CreateUserDTO dto) {
        if (dto.getEmail() == null || dto.getEmail().trim().isEmpty()
                || dto.getPassword() == null || dto.getPassword().trim().isEmpty()
                || dto.getFullname() == null || dto.getFullname().trim().isEmpty()
                || dto.getPhone() == null || dto.getPhone().trim().isEmpty()) {
            return "Email, mat khau, std va ho ten khong dc de trong";
        }

        User findByEmail = userRepository.findByEmail(dto.getEmail().trim());

        if (findByEmail != null) {
            return "Email da ton tai";
        }

        String hashPassword = BCrypt.hashpw(dto.getPassword(), BCrypt.gensalt(12));

        User user = new User(
                dto.getEmail().trim(),
                hashPassword,
                dto.getFullname().trim(),
                dto.getPhone().trim(),
                dto.getCountry(),
                dto.getRoleId()
        );

        return userRepository.create(user) ? null : "Khong the tao user";
    }

    // Phân trang user
    public List<UserListDTO> getUserPaging(String keywords, int size, int index) {
        return userRepository.userPaging(keywords, size, index);
    }

    // Đếm user
    public int countUsers(String keyword) throws SQLException {
        return userRepository.countUser(keyword);
    }

    // Xóa user
    public String deleteById(int id) throws SQLException {
        try {
            boolean delete = userRepository.deleteById(id);
            return delete ? null : "Khong tim thay user";
        } catch (SQLException e) {
            return "User dang co task khong duoc xoa";
        }
    }

    // Lấy user theo ID
    public User findById(int id) throws SQLException {
        return userRepository.getUserById(id);
    }

    // Cập nhật user
    public String update(User user) throws SQLException {

        // Kiểm tra dữ liệu rỗng
        if (user.getFullname() == null || user.getFullname().trim().isEmpty()
                || user.getPhone() == null || user.getPhone().trim().isEmpty()
                || user.getEmail() == null || user.getEmail().trim().isEmpty()) {
            return "Email, ho ten hoac so dien thoai khong duoc de trong";
        }

        String email = user.getEmail().trim();

        user.setEmail(email);
        user.setFullname(user.getFullname().trim());
        user.setPhone(user.getPhone().trim());

        // Kiểm tra email trùng với tài khoản khác
        User checkEmail = userRepository.findByEmail(email);

        if (checkEmail != null && checkEmail.getId() != user.getId()) {
            return "Email da duoc su dung";
        }

        try {
            boolean check = userRepository.updateUser(user);
            return check ? null : "Loi update";
        } catch (Exception e) {
            e.printStackTrace();
            return "Loi update";
        }
    }
}
