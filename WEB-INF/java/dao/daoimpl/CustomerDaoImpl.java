package dao.daoimpl;

import java.sql.*;
import java.util.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;
import dao.DBConnection;

public class CustomerDaoImpl implements CustomerDao{
    public Connection con;
    

    public CustomerDaoImpl(){
        con = new DBConnection().getConnection();
    }

    public boolean addSubscription(int appId,int userId){
        try{
        String sql = "insert into application_customer_junction(user_id,app_id) values(?,?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setInt(2,appId);
        if(ps.executeUpdate()>0){
            return true;
        }
        else{
            return false;
        }
    }
    catch(Exception e){
        e.printStackTrace();
        return false;
    }
    }

    public List<Customer> getAllCustomers(){
        try{
        String sql = "select * from customer";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        List<Customer> ls = new ArrayList<>();
        while(rs.next()){
            Customer c = new Customer()
                            .setId(rs.getInt("user_id"))
                            .setName(rs.getString("user_name"))
                            .setEmail(rs.getString("email"))
                            .setPhone(rs.getString("phone"))
                            .setDob(String.valueOf(rs.getDate("dob")))
                            .setCountry(rs.getString("country"));
            ls.add(c);
        }
        return ls;
    }
    catch(Exception e){
        e.printStackTrace();
        return null;
    }
    }

    public boolean isAlreadyContainsEmail(String email){
        try{
            String sql = "select email from customer where email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
            return false;
        }
        catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public int getSubscribedIdByUserId(int userId,int appId){
        try{
            String sql = "select ac_id from application_customer_junction where user_id = ? and app_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, appId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
            return 0;
        }
        catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    public int getUserIdByEmail(String email){
        try{
            String sql = "select user_id from customer where email = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
            return 0;
        }
        catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
    public boolean insert(Customer c){
        if(isAlreadyContainsEmail(c.getEmail())){
            return true;
        }
        try{
        String sql = "insert into Customer(name,email,phone,dob,country) values(?,?,?,?,?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, c.getName());
        ps.setString(2, c.getEmail());
        ps.setString(3, c.getPhone());
        ps.setDate(4, c.getDob());
        ps.setString(5, c.getCountry());
        int i = ps.executeUpdate();
        if(i>0){
            return true;
        }
        return false;
    }
    catch(Exception e){
        e.printStackTrace();
        return false;
    }
    }
}