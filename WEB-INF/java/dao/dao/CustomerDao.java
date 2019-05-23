package dao.dao;
import dao.dto.*;
import java.util.List;
public interface CustomerDao{
    boolean insert(Customer c);
    int getUserIdByEmail(String email);
    boolean addSubscription(int appId,int userId);
    int getSubscribedIdByUserId(int appId,int userId);
    boolean isAlreadyContainsEmail(String email);
    List<Customer> getAllCustomers();

}