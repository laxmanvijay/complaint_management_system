package dao.daoimpl;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;
import java.sql.*;
import java.util.*;
import dao.DBConnection;

public class ApplicationDtoDaoImpl implements ApplicationDtoDao{
    private Connection con;
    private CustomerDao cdao;

    public ApplicationDtoDaoImpl(){
        con = new DBConnection().getConnection();
        cdao = new CustomerDaoImpl();
    }

    public List<HashMap<String,String>> getAllApplications(){
        try{
        String sql = "select app_name,description,application_details.app_id,version from application_details join application_version on application_details.app_id=application_version.app_id";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        List<HashMap<String,String>> ls = new ArrayList<>();
        while(rs.next()){
            HashMap<String,String> hm = new HashMap<>();
            hm.put("id",String.valueOf(rs.getInt("app_id")));
            hm.put("name",rs.getString("app_name"));
            hm.put("description",rs.getString("description"));
            hm.put("version",String.valueOf(rs.getInt("version")));
            ls.add(hm);
        }
        return ls;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    
    }

    public int getAppIdByName(String name){
        try{
        String sql = "select app_id from application_details where app_name = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, name);
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

    public List<Integer> getVersionOfApp(String name){
        try{
        int appId = getAppIdByName(name);
        String sql = "select version from application_version where app_id = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1,appId);
        ResultSet rs = ps.executeQuery();
        List<Integer> ls = new ArrayList<Integer>();
        while(rs.next()){
            ls.add(rs.getInt(1));
        }
        return ls;
    }
    catch(Exception e){
        e.printStackTrace();
        return null;
    }
    }

    public List<Integer> getAppIdByUserId(int userId){
        try{
        String sql = "select app_id from application_customer_junction where user_id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        List<Integer> ls = new ArrayList<Integer>();
        while(rs.next()){
            ls.add(rs.getInt(1));
        }
        return ls;
    }
    catch(Exception e){
        e.printStackTrace();
        return null;
    }
    }

    public String getAppNameFromAppId(int id){
        try{
        String sql = "select app_name from application_details where app_id=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
            return rs.getString(1);
        }
        return "null";
    }
    catch(Exception e){
        e.printStackTrace();
        return null;
    }
    }

    public List<String> getAppByEmail(String email){
        
        int userId = cdao.getUserIdByEmail(email);
        List<String> ls = new ArrayList<String>();
        getAppIdByUserId(userId).forEach(id->{
            ls.add(getAppNameFromAppId(id));
        });
        return ls;
    }

    public int getAppverIdByAppIdAndVersion(int appId,int version){
        try{
        String sql = "select appver_id from application_version where app_id=? and version=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, appId);
        ps.setInt(2, version);
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

    public int insert(ApplicationDto a, int ver){
        try{
        String sql = "insert into Application_Details(app_name,description) values(?,?)";
        String gencol[] = {"app_id"};
        PreparedStatement ps = con.prepareStatement(sql,gencol);
        ps.setString(1, a.getAppName());
        ps.setString(2, a.getAppDescription());
        int i = ps.executeUpdate();
        if(i>0){
            String sql2 = "insert into Application_Version(version,app_id) values(?,?)";
            String gencon2[] = {"appver_id"};
            PreparedStatement ps2 = con.prepareStatement(sql2,gencon2);
            ResultSet rs = ps.getGeneratedKeys();
            System.out.println(rs);
            if (rs.next()) {
                int id = rs.getInt(1);
                System.out.println("keeeeeeeeeeeee"+id);
                ps2.setInt(2,id); 
            }
            ps2.setInt(1, ver);
            if(ps2.executeUpdate()>0){
                ResultSet rs2 = ps2.getGeneratedKeys();
                if (rs2.next()) {
                    int id = rs2.getInt(1);
                    return id;
                }
            }
        }
        return 0;
        }
        catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }
}