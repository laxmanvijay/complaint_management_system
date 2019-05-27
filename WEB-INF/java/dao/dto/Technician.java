package dao.dto;

import java.sql.Date;

public class Technician{
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

    public Technician setDob(String dob){
        Date d = Date.valueOf(dob);
        this.dob=d;
        return this;
    }
}