package dao.daoimpl;

import java.sql.*;
import java.util.*;
import java.sql.Timestamp;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;
import dao.DBConnection;
import org.mindrot.jbcrypt.*;

public class TechniciandaoImpl implements TechnicianDao{
    public Connection con;
    
    public TechniciandaoImpl(){
        con = new DBConnection().getConnection();
    }

    public int insert(Technician t){
        try{
            String sql = "insert into technician_details(name,dob,gender,phone,country,salary) values(?,?,?,?,?,?)";
            String gencol[]={"td_id"};
            String salt = BCrypt.gensalt(12);
		    t.password = BCrypt.hashpw(t.password, salt);
            PreparedStatement ps = con.prepareStatement(sql,gencol);
            ps.setString(1, t.name);
            ps.setDate(2, t.dob);
            ps.setString(3, t.gender);
            ps.setString(4, t.phone);
            ps.setString(5, t.country);
            ps.setInt(6, t.salary);
            if(ps.executeUpdate()>0){
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()){
                    sql = "insert into technician(email,password,role,email_verification,specialization,last_login_time,td_id) values(?,?,?,?,?,?,?)";
                    String gencol2[]={"technician_id"};
                    PreparedStatement ps2 = con.prepareStatement(sql,gencol2);
                    ps2.setString(1, t.email);
                    ps2.setString(2, t.password);
                    ps2.setString(3, t.role);
                    ps2.setBoolean(4, false);
                    ps2.setString(5,t.specialization);
                    ps2.setNull(6, Types.TIMESTAMP);
                    ps2.setInt(7, rs.getInt("td_id"));
                    if(ps2.executeUpdate()>0){
                        rs = ps2.getGeneratedKeys();
                        if(rs.next()){
                            return rs.getInt("technician_id");
                        }
                    }
                    else{
                        return 0;
                    }
                }
                else{
                    return 0;
                }
            }
            else{
                return 0;
            }
        }
        catch(Exception e){
            e.printStackTrace();
            return 0;
        }
        return 0;
    }

    @Override
    public int verifyEmailAndPassword(String email, String password) {
        try{
        String sql = "select technician_id,password from technician where email=? limit 1";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            if(BCrypt.checkpw(password,rs.getString("password"))){
                return rs.getInt("technician_id");
            }
            else{
                return -2;
            }
        }
        else{
            return -1;
        }
        }
        catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public boolean checkIsAdmin(String email) {
        try{
            String sql = "select role from technician where email=? limit 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                if(rs.getString("role").equals("admin")){
                    return true;
                }
            }
            return false;
        }
        catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean setLastLoginToNow(String email) {
        try{
            String sql = "update technician set last_login_time=now() where email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            if(ps.executeUpdate()>0){
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