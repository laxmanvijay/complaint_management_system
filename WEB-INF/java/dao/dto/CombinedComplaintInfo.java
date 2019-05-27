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

    public CombinedComplaintInfo(){
        complaint_id=-1;
        complaint_description="";
        complaint_type="";
        timestamp=null;
        version=-1;
        user_id=-1;
        app_id=-1;
        app_name="";
        email="";
    }

    @Override
    public String toString(){
        return "complaint_id: "+complaint_id+"complaint_type: "+complaint_type+"complaint_description: "+complaint_description+
                "timestamp: "+timestamp+"version: "+version+"user_id: "+user_id+"app_id: "+app_id+"app_name: "+app_name+"email: "+email;
    }
}