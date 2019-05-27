package dao.dao;

import dao.dto.Technician;

public interface TechnicianDao{
    public int insert(Technician t);
    public int verifyEmailAndPassword(String email,String password);
    public boolean checkIsAdmin(String email);
    public boolean setLastLoginToNow(String email);
}