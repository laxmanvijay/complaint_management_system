package dao.dto;

import java.sql.Date;
import java.sql.Time;

public class Technician{
    public int id;
    public String name;
    public String email;
    public String password;
    public String country;
    public Date dob;
    public String phone;
    public String specialization;
    public String role;
    public int salary;
    public String gender;
    public int currently_working_application;
    public Time shift_start_time;
    public Time shift_end_time;

    public Technician setDob(String dob){
        Date d = Date.valueOf(dob);
        this.dob=d;
        return this;
    }
}