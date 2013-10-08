package org.dto;

public class LoginResult {

	private String message;
	private String instructorName;
	private String instructorID;
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getInstructorName() {
		return instructorName;
	}
	public void setInstructorName(String instructorName) {
		this.instructorName = instructorName;
	}
	public String getInstructorID() {
		return instructorID;
	}
	public void setInstructorID(String instructorID) {
		this.instructorID = instructorID;
	}
}
