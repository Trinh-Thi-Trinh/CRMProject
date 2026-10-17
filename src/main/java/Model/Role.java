package Model;

public class Role {
private int id;
private String nameRole;
private String description;
public Role() {
}
public Role(int id, String nameRole, String description) {
	super();
	this.id = id;
	this.nameRole = nameRole;
	this.description = description;
}

public Role(String nameRole, String description ) {
	super();
	this.nameRole = nameRole;
	this.description = description;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getNameRole() {
	return nameRole;
}
public void setNameRole(String nameRole) {
	this.nameRole = nameRole;
}
public String getDescription() {
	return description;
}
public void setDescription(String description) {
	this.description = description;
}

}
