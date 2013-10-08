package com.example.listview;

public class Student {

	private int studentID;
	private String studentCode;
	private String studentName;
	public int getStudentID() {
		return studentID;
	}
	public void setStudentID(int studentID) {
		this.studentID = studentID;
	}
	public String getStudentCode() {
		return studentCode;
	}
	public void setStudentCode(String studentCode) {
		this.studentCode = studentCode;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	
	public String getCodeName()
	{
		return studentCode + " - " + studentName;
	}
	
	
}
