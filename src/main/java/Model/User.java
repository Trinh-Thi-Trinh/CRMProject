package Model;

public class User {
private int id;
private String email;
private String password;
private String fullname;
private String phone;
private String country;
private int roleId;
public User() {
	
}
public User(String email, String password, String fullname, String phone, String country, int roleId) {
	super();
	this.email = email;
	this.password = password;
	this.fullname = fullname;
	this.phone = phone;
	this.country = country;
	this.roleId = roleId;
}
public User(int id, String email, String password, String fullname, String phone, String country, int roleId) {
	super();
	this.id = id;
	this.email = email;
	this.password = password;
	this.fullname = fullname;
	this.phone = phone;
	this.country = country;
	this.roleId = roleId;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getFullname() {
	return fullname;
}
public void setFullname(String fullname) {
	this.fullname = fullname;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
public String getCountry() {
	return country;
}
public void setCountry(String country) {
	this.country = country;
}
public int getRoleId() {
	return roleId;
}
public void setRoleId(int roleId) {
	this.roleId = roleId;
}

}
