package dao.dto;

import java.sql.Timestamp;

public class ComplaintDto{
    private int complaint_id;
    private String complaint_description;
    private String complaint_type;
    private Timestamp timestamp;
    private int appver_id;

    public ComplaintDto setId(int id){
        this.complaint_id = id;
        return this;
    }
    public int getId(){
        return this.complaint_id;
    }
    public ComplaintDto setAppverId(int id){
        this.appver_id = id;
        return this;
    }
    public int getAppverId(){
        return this.appver_id;
    }
    public ComplaintDto setComplaintDescription(String description){
        this.complaint_description = description;
        return this;
    }
    public String getComplaintDescription(){
        return this.complaint_description;
    }
    public ComplaintDto setComplaintType(String type){
        this.complaint_type = type;
        return this;
    }
    public String getComplaintType(){
        return this.complaint_type;
    }
    public ComplaintDto setTimestamp(Timestamp ts){
        this.timestamp = ts;
        return this;
    }
    public Timestamp getTimestamp(){
        return this.timestamp;
    }

}