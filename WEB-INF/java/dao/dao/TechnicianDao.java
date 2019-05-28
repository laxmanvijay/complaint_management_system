package dao.dao;

import dao.dto.Technician;
import java.util.*;

public interface TechnicianDao{
    public int insert(Technician t);
    public int verifyEmailAndPassword(String email,String password);
    public boolean checkIsAdmin(String email);
    public boolean setLastLoginToNow(String email);
    public int assignComplaintToTechnician(int complaint_id,int technician_id);
    public int getComplaintForTechnician(String email);
    public Technician getTechnicianByEmail(String email);
    public List<Integer> getTechnicianBySpecialization(String spl);
    public int getTechnicianBySpecializationAndMinimumNumberOfIssuesSolved(String spl);
}