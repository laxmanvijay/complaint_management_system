package dao;

import javax.naming.*;
import javax.sql.*;
import java.sql.*;
import java.io.*;

public class DBConnection{
    public Context ctx;
    public DataSource ds;
    public Connection con;
    
    public DBConnection(){
        try{
            ctx = new InitialContext();
            ds = (DataSource)ctx.lookup("java:comp/env/jdbc/postgres");
            con = ds.getConnection();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }

    public Connection getConnection(){
        return this.con;
    }
}