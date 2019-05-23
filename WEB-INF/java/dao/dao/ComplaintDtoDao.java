package dao.dao;

import dao.dto.*;
import java.util.*;

public interface ComplaintDtoDao{
    int insert(ComplaintDto c);
    boolean insertIntoComplaintMap(int ac_id,int complaint_id);
    List<CombinedComplaintInfo> getAllComplaints();
    List<HashMap<String,String>> getComplaintsByAppName(String name);
    List<HashMap<String,String>> getComplaintsByUserId(int id);
    List<HashMap<String,String>> getComplaintsByComplaintType(String type);
}