package dao.daoimpl;

import java.sql.*;
import java.util.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;
import dao.DBConnection;
import org.mindrot.jbcrypt.*;

public class TechniciandaoImpl implements TechnicianDao {
    public Connection con;

    public TechniciandaoImpl() {
        con = new DBConnection().getConnection();
    }

    public int insert(Technician t) {
        try {
            String sql = "insert into technician_details(name,dob,gender,phone,country,salary) values(?,?,?,?,?,?)";
            String gencol[] = { "td_id" };
            String salt = BCrypt.gensalt(12);
            t.password = BCrypt.hashpw(t.password, salt);
            PreparedStatement ps = con.prepareStatement(sql, gencol);
            ps.setString(1, t.name);
            ps.setDate(2, t.dob);
            ps.setString(3, t.gender);
            ps.setString(4, t.phone);
            ps.setString(5, t.country);
            ps.setInt(6, t.salary);
            if (ps.executeUpdate() > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    sql = "insert into technician(email,password,role,email_verification,specialization,last_login_time,td_id,currently_working_application,shift_start_time,shift_end_time) values(?,?,?,?,?,?,?,?,?,?)";
                    String gencol2[] = { "technician_id" };
                    PreparedStatement ps2 = con.prepareStatement(sql, gencol2);
                    ps2.setString(1, t.email);
                    ps2.setString(2, t.password);
                    ps2.setString(3, t.role);
                    ps2.setBoolean(4, false);
                    ps2.setString(5, t.specialization);
                    ps2.setNull(6, Types.TIMESTAMP);
                    ps2.setInt(7, rs.getInt("td_id"));
                    ps2.setInt(8, t.currently_working_application);
                    ps2.setTime(9, t.shift_start_time);
                    ps2.setTime(10, t.shift_end_time);
                    if (ps2.executeUpdate() > 0) {
                        rs = ps2.getGeneratedKeys();
                        if (rs.next()) {
                            return rs.getInt("technician_id");
                        }
                    } else {
                        return 0;
                    }
                } else {
                    return 0;
                }
            } else {
                return 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 0;
    }

    @Override
    public int verifyEmailAndPassword(String email, String password) {
        try {
            String sql = "select technician_id,password from technician where email=? limit 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (BCrypt.checkpw(password, rs.getString("password"))) {
                    return rs.getInt("technician_id");
                } else {
                    return -2;
                }
            } else {
                return -1;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public boolean checkIsAdmin(String email) {
        try {
            String sql = "select role from technician where email=? limit 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getString("role").equals("admin")) {
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean setLastLoginToNow(String email) {
        try {
            String sql = "update technician set last_login_time=now() where email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            if (ps.executeUpdate() > 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<String> getAllTechnician() {
        try {
            String sql = "select technician_id,email from technician where role='technician'";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            List<String> ls = new ArrayList<>();
            while (rs.next()) {
                ls.add(rs.getString("email"));
            }
            return ls;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public int assignComplaintToTechnician(int complaint_id, int technician_id) {
        try {
            String sql = "insert into complaint_technician_junction(complaint_id,technician_id) values(?,?)";
            String[] gencol = { "ct_id" };
            PreparedStatement ps = con.prepareStatement(sql, gencol);
            ps.setInt(1, complaint_id);
            ps.setInt(2, technician_id);
            int x = ps.executeUpdate();
            if (x > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt("ct_id");
                } else {
                    return 0;
                }
            } else {
                return 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public int getComplaintForTechnician(String email) {
        try {
            String sql = "select complaint_id from complaint join technician on technician.specialization=complaint.complaint_type where technician.email=? limit 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("complaint_id");
            }
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public Technician getTechnicianByEmail(String email) {
        try {
            String sql = "select * from technician join technician_details on "
                    + "technician.td_id=technician_details.td_id where email=? limit 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Technician t = new Technician();
                t.country = rs.getString("country");
                t.email = rs.getString("email");
                t.name = rs.getString("name");
                t.specialization = rs.getString("specialization");
                t.role = rs.getString("role");

                return t;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Integer> getTechnicianBySpecialization(String spl) {
        try {
            String sql = "select technician_id from technician where specialization=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, spl);
            ResultSet rs = ps.executeQuery();
            List<Integer> ls = new ArrayList<>();
            while (rs.next()) {
                ls.add(rs.getInt("technician_id"));
            }
            return ls;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int getTechnicianBySpecializationAndMinimumNumberOfIssuesSolved(String spl) {
        try {
            String sql = "select technician.technician_id,min(count) from technician "
                    + "join(select technician_id,count(technician_id) from complaint"
                    + "_technician_junction group by technician_id) as foo on techni"
                    + "cian.technician_id = foo.technician_id where technician.specialization=?"
                    + " group by technician.technician_id";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, spl);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("technician_id");
            }
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public List<Integer> getTechnicianByApplicationId(int app) {
        try {
            String sql = "select technician_id from technician where currently_working_application=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, app);
            ResultSet rs = ps.executeQuery();
            List<Integer> ls = new ArrayList<>();
            while (rs.next()) {
                ls.add(rs.getInt("technician_id"));
            }
            return ls;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<Time> getSessionStartAndEndTimeByEmail(String email) {
        try {
            String sql = "select shift_start_time,shift_end_time from technician where email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            List<Time> ls = new ArrayList<>();
            while(rs.next()){
                ls.add(rs.getTime("shift_start_time"));
                ls.add(rs.getTime("shift_end_time"));
            }
            return ls;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Technician> getAllTechnicians(){
        try {
            String sql = "select * from technician join technician_details on technician.td_id=technician_details.td_id";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            List<Technician> ls = new ArrayList<>();
            while(rs.next()){
                Technician t = new Technician();
                t.country = rs.getString("country");
                t.currently_working_application = rs.getInt("currently_working_application");
                t.dob = rs.getDate("dob");
                t.email = rs.getString("email");
                t.id = rs.getInt("technician_id");
                t.gender = rs.getString("gender");
                t.name = rs.getString("name");
                t.phone = rs.getString("phone");
                t.role = rs.getString("role");
                t.salary = rs.getInt("salary");
                t.specialization = rs.getString("specialization");
                ls.add(t);
            }
            return ls;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}