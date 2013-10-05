package com.example.listview;

import java.io.Serializable;

public class Friend implements Serializable{
    private String No;
    private String Subject;
    private String Classes;
    private String Time;
    private String Date;
    private String StudentName;
    private String StudentCode;
    
    public Friend(String No){
        this.No = No;
        //this.setChecked(false);
    }
    public String getNo(){
        return this.No;
    }
    public void setSubject(String Subject) {
        this.Subject = Subject;
    }
    public String getSubject() {
        return this.Subject;
    }
    public void setClasses(String Classes) {
        this.Classes = Classes;
    }
    public String getClasses() {
        return this.Classes;
    }
    public void setTime(String Time) {
        this.Time = Time;
    }
    public String getTime() {
        return this.Time;
    }
    public void setDate(String Date) {
        this.Date = Date;
    }
    public String getDate() {
        return this.Date;
    }
    public void setStudentName(String StudentName) {
        this.StudentName = StudentName;
    }
    public String getStudentName() {
        return this.StudentName;
    }
    public void setStudentCode(String StudentCode) {
        this.StudentCode = StudentCode;
    }
    public String getStudentCode() {
        return this.StudentCode;
    }
    @Override
    public boolean equals(Object o) {
        // TODO Auto-generated method stub
        if(o instanceof Friend) {
            Friend f = (Friend)o;
            return this.No.equalsIgnoreCase(f.getNo());
        }
        return false;
    }
    @Override
    public int hashCode() {
        // TODO Auto-generated method stub
        return this.No.hashCode();
    }
}
