package Model;

public class Status {
private int id;
private String nameStatus;
public Status() {

}
public Status(int id, String nameStatus) {
	super();
	this.id = id;
	this.nameStatus = nameStatus;
}

public Status(String nameStatus) {
	super();
	this.nameStatus = nameStatus;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getNameStatus() {
	return nameStatus;
}
public void setNameStatus(String nameStatus) {
	this.nameStatus = nameStatus;
}

}
