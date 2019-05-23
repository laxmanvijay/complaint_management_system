package dao.dto;

public class ApplicationDto{
    public ApplicationDto(){
        
    }
    private int app_id;
    private String app_name;
    private String description;

    public ApplicationDto setId(int id){
        this.app_id=id;
        return this;
    }
    public int getId(){
        return this.app_id;
    }

    public ApplicationDto setApplicationName(String name){
        this.app_name=name;
        return this;
    }

    public String getAppName(){
        return this.app_name;
    }

    public ApplicationDto setApplicationDescription(String desc){
        this.description=desc;
        return this;
    }

    public String getAppDescription(){
        return this.description;
    }

}