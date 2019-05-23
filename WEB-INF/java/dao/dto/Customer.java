package dao.dto;

import java.sql.Date;

public class Customer{
    private int id;
    private String name;
    private String email;
    private String phone;
    private Date dob;
    private String country;

    public Customer setId(int id){
        this.id = id;
        return this;
    }
    public int getId(){
        return this.id;
    }
    public Customer setName(String name){
        this.name = name;
        return this;
    }
    public String getName(){
        return this.name;
    }
    public Customer setEmail(String email){
        this.email = email;
        return this;
    }
    public String getEmail(){
        return this.email;
    }
    public String getPhone(){
        return this.phone;
    }
    public Customer setPhone(String phone){
        this.phone = phone;
        return this;
    }
    public Date getDob(){
        return this.dob;
    }
    public Customer setDob(String dob){
        Date d = Date.valueOf(dob);
        this.dob=d;
        return this;
    }
    public String getCountry(){
        return this.country;
    }
    public Customer setCountry(String country){
        this.country = country;
        return this;
    }

}