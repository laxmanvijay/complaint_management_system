package dao.dto;

import java.sql.Timestamp;

public class CombinedComplaintInfo{
    public int complaint_id;
    public String complaint_type;
    public String complaint_description;
    public Timestamp timestamp;
    public int version;
    public int user_id;
    public int app_id;
    public String app_name;
    public String email; 

    @Override
    public String toString(){
        return "complaint_id: "+complaint_id+"complaint_type: "+complaint_type+"complaint_description: "+complaint_description+
                "timestamp: "+timestamp+"version: "+version+"user_id: "+user_id+"app_id: "+app_id+"app_name: "+app_name+"email: "+email;
    }
}