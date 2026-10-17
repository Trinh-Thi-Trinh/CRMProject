package services;

import org.mindrot.jbcrypt.BCrypt;

import Model.User;
import repositories.UserRepository;

public class AuthService {

	private final UserRepository userRepository;

	public AuthService() {
		userRepository = new UserRepository();
	}

	public User login(String email, String password) {
		User user = userRepository.findByEmail(email);
		if (email == null || email.trim().isEmpty()|| password == null || password.trim().isEmpty())
		{
			return null;
		}
		if (user == null) {
			return null;
		}
//	if (!user.getPassword().equals(password)) {
//	return null;
//	}
	// Cu phap dung password bam.
		boolean checkPWValid = BCrypt.checkpw(password, user.getPassword());
		if (!checkPWValid) {
		return null;
	}
//		Cu phap tao pass bam
//		dung khi tao user
//		String hashedPassword = BCrypt.hashpw("123456",BCrypt.gensalt(12));
//		
		return user;
	}
}
