package dao.daoimpl;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;
import dao.DBConnection;

public class ComplaintDtoDaoImpl implements ComplaintDtoDao{
    private Connection con;

    public ComplaintDtoDaoImpl(){
        con = new DBConnection().getConnection();
    }

    public boolean insertIntoComplaintMap(int ac_id,int complaint_id){
            try{
                String sql = "insert into application_customer_complaint_junction(ac_id,complaint_id) values(?,?)";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, ac_id);
                ps.setInt(2, complaint_id);
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

    public List<HashMap<String,String>> getComplaintsByAppName(String name){
        try{
            String sql = "select complaint.complaint_id,complaint.complaint_type,complaint.complaint_description"+
            ",complaint.timestamp,application_version.version,application_details.app_id,"+
            "application_details.app_name,application_details.description from complaint"+
            " join application_version on "+
            "application_version.appver_id = complaint.appver_id join applicat"+
            "ion_details on application_details.app_id=application_version.app_id"+
            " where application_details.app_name=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            List<HashMap<String,String>> ls = new ArrayList<>();
            while(rs.next()){
            HashMap<String,String> hm = new HashMap<>();
            hm.put("complaint_id",String.valueOf(rs.getInt("complaint_id")));
            hm.put("complaint_type",rs.getString("complaint_type"));
            hm.put("complaint_description",rs.getString("complaint_description"));
            hm.put("timestamp",rs.getString("timestamp"));
            hm.put("version",rs.getString("version"));
            hm.put("app_id",rs.getString("app_id"));
            hm.put("app_name",rs.getString("app_name"));
            ls.add(hm);
            }
            return ls;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public List<HashMap<String,String>> getComplaintsByUserId(int id){
        try{
            String sql="select application_customer_junction.user_id,application_customer_"+
            "junction.app_id,complaint.complaint_id,complaint.complaint_type,complaint.complaint_description,"+
            "complaint.timestamp,application_version.version from application_customer_junction join "+
            "application_customer_complaint_junction on application_customer_junction.ac_id="+
            "application_customer_complaint_junction.ac_id join complaint on complaint.complaint_id"+
            "=application_customer_complaint_junction.complaint_id join application_version on "+
            "application_version.appver_id=complaint.appver_id where application_customer_junction.user_id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            List<HashMap<String,String>> ls = new ArrayList<>();
            while(rs.next()){
                HashMap<String,String> hm = new HashMap<>();
                hm.put("user_id",String.valueOf(rs.getInt("user_id")));
                hm.put("app_id",String.valueOf(rs.getInt("app_id")));
                hm.put("complaint_id",String.valueOf(rs.getInt("complaint_id")));
                hm.put("complaint_type",rs.getString("complaint_type"));
                hm.put("complaint_description",rs.getString("complaint_description"));
                hm.put("timestamp",rs.getString("timestamp"));
                hm.put("version",rs.getString("version"));
                ls.add(hm);
            }
            return ls;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public List<CombinedComplaintInfo> getComplaintsByComplaintType(String type){
        try{
            String sql="select complaint.complaint_id,complaint.complaint_type,"+
            "complaint.complaint_description,complaint.timestamp,application_version"+
            ".version,application_details.app_id,application_details.app_name,"+
            "application_customer_junction.user_id,email from complaint join application_version"+
            " on complaint.appver_id=application_version.appver_id join application_details"+
            " on application_details.app_id=application_version.app_id join application_custo"+
            "mer_complaint_junction on application_customer_complaint_junction.complaint_id=co"+
            "mplaint.complaint_id join application_customer_junction on application_customer_j"+
            "unction.ac_id=application_customer_complaint_junction.ac_id join customer on custom"+
            "er.user_id=application_customer_junction.user_id where complaint_type=?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, type);
            ResultSet rs = ps.executeQuery();
            List<CombinedComplaintInfo> ls = new ArrayList<>();
            while(rs.next()){
                HashMap<String,String> hm = new HashMap<>();
                CombinedComplaintInfo cci = new CombinedComplaintInfo();
                cci.complaint_id = rs.getInt("complaint_id");
                cci.complaint_type = rs.getString("complaint_type");
                cci.complaint_description = rs.getString("complaint_description");
                cci.timestamp = rs.getTimestamp("timestamp");
                cci.app_id = rs.getInt("app_id");
                cci.version = rs.getInt("version");
                cci.user_id = rs.getInt("user_id");
                cci.app_name = rs.getString("app_name");
                cci.email = rs.getString("email");
            ls.add(cci);
            }
            return ls;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public List<CombinedComplaintInfo> getAllComplaints(){
        try{
        String sql = "select complaint.complaint_id,complaint.complaint_type,complaint_description,"+
                     "timestamp,customer.user_id,application_details.app_id,application_version.vers"+
                      "ion,app_name,email from application_customer_complaint_junction join complaint on "+ 
                     "complaint.complaint_id=application_customer_complaint_junction.complaint_id"+
                     " join application_customer_junction on application_customer_junction.ac_id=app"+
                     "lication_customer_complaint_junction.ac_id join application_version on applica"+
                     "tion_version.appver_id=complaint.appver_id join application_details on applicat"+
                     "ion_details.app_id=application_customer_junction.app_id join customer on custom"+
                     "er.user_id=application_customer_junction.user_id";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        List<CombinedComplaintInfo> ls = new ArrayList<CombinedComplaintInfo>();
        while(rs.next()){
            CombinedComplaintInfo cci = new CombinedComplaintInfo();
            cci.complaint_id = rs.getInt("complaint_id");
            cci.complaint_type = rs.getString("complaint_type");
            cci.complaint_description = rs.getString("complaint_description");
            cci.timestamp = rs.getTimestamp("timestamp");
            cci.app_id = rs.getInt("app_id");
            cci.version = rs.getInt("version");
            cci.user_id = rs.getInt("user_id");
            cci.app_name = rs.getString("app_name");
            cci.email = rs.getString("email");
            ls.add(cci);
        }
        return ls;
    }
    catch(Exception e){
        e.printStackTrace();
        return null;
    }
    }

    public int insert(ComplaintDto c){
        
        try{
        String sql = "insert into Complaint(complaint_type,complaint_description,timestamp,appver_id) values(?,?,?,?)";
        String gencol[] = {"complaint_id"};
        PreparedStatement ps = con.prepareStatement(sql,gencol);
        ps.setString(1, c.getComplaintType());
        ps.setString(2, c.getComplaintDescription());
        ps.setTimestamp(3, c.getTimestamp());
        ps.setInt(4, c.getAppverId());
        int i = ps.executeUpdate();
        if(i>0){
            ResultSet rs = ps.getGeneratedKeys();
            if(rs.next()){
                return rs.getInt(1);
            }
        }
        return 0;
        }
        catch(Exception e){
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<CombinedComplaintInfo> getComplaintsForTechnicians(String email) {
        try{
            String sql = "select complaint.complaint_id,complaint.complaint_type,complaint_description,"+
                         "timestamp,customer.user_id,application_details.app_id,application_version.vers"+
                          "ion,app_name,email from application_customer_complaint_junction join complaint on "+ 
                         "complaint.complaint_id=application_customer_complaint_junction.complaint_id"+
                         " join application_customer_junction on application_customer_junction.ac_id=app"+
                         "lication_customer_complaint_junction.ac_id join application_version on applica"+
                         "tion_version.appver_id=complaint.appver_id join application_details on applicat"+
                         "ion_details.app_id=application_customer_junction.app_id join customer on custom"+
                         "er.user_id=application_customer_junction.user_id join complaint_technician_junction"+
                         " on complaint_technician_junction.complaint_id=complaint.complaint_id where complaint"+
                         "_technician_junction.technician_id in (select technician_id from technician where email=? limit 1)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            List<CombinedComplaintInfo> ls = new ArrayList<CombinedComplaintInfo>();
            while(rs.next()){
                CombinedComplaintInfo cci = new CombinedComplaintInfo();
                cci.complaint_id = rs.getInt("complaint_id");
                cci.complaint_type = rs.getString("complaint_type");
                cci.complaint_description = rs.getString("complaint_description");
                cci.timestamp = rs.getTimestamp("timestamp");
                cci.app_id = rs.getInt("app_id");
                cci.version = rs.getInt("version");
                cci.user_id = rs.getInt("user_id");
                cci.app_name = rs.getString("app_name");
                cci.email = rs.getString("email");
                ls.add(cci);
            }
            return ls;
        }
        catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
}