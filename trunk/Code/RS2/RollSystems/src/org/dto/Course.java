package org.dto;

import java.io.Serializable;

public class Course implements Serializable{
    private String rollID;
    private String subject;
    private String classes;
    private String time;
    private String date;
    private boolean isCurrent;
    
	public String getRollID() {
		return rollID;
	}
	public void setRollID(String rollID) {
		this.rollID = rollID;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getClasses() {
		return classes;
	}
	public void setClasses(String classes) {
		this.classes = classes;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public boolean isCurrent() {
		return isCurrent;
	}
	
	public void setCurrent(boolean isCurrent) {
		this.isCurrent = isCurrent;
	}
    
}  