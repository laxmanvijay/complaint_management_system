package dao.dao;

import dao.dto.Technician;
import java.util.*;
import java.sql.Time;

public interface TechnicianDao{
    public int insert(Technician t);
    public int verifyEmailAndPassword(String email,String password);
    public boolean checkIsAdmin(String email);
    public boolean setLastLoginToNow(String email);
    public int assignComplaintToTechnician(int complaint_id,int technician_id);
    public int assignApplicationToTechnician(int app_id,int technician_id);
    public int getComplaintForTechnician(String email);
    public Technician getTechnicianByEmail(String email);
    public List<Integer> getTechnicianBySpecialization(String spl);
    public int getTechnicianBySpecializationAndMinimumNumberOfIssuesSolved(String spl);
    public List<Integer> getTechnicianByApplicationId(int app);
    public List<Time> getSessionStartAndEndTimeByEmail(String email);
    public boolean setSessionStartAndEndTimeByEmail(Time start,Time end,int id);
    public List<Time> getComplaintHandlingStartAndEndTimeById(int id);
    public boolean setComplaintHandlingStartAndEndTimeByEmail(Time start,Time end,int id);
    public List<Technician> getAllTechnicians();
    public Technician getTechnicianById(int id);
}          