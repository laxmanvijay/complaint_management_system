package subcontrollers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.*;
import com.google.gson.*;
import javax.naming.*;
import subcontrollers.AESController;
import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/assigncomplaint")
public class AssignComplaint extends HttpServlet{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        PrintWriter out = response.getWriter();
        int complaint_id = Integer.parseInt(request.getParameter("complaint_id"));
        int technician_id = Integer.parseInt(request.getParameter("technician_id"));
        TechnicianDao tdao = new TechniciandaoImpl();
        
        String jwt = request.getParameter("jwt");
        try{
        Context ctx = new InitialContext();
        String key=(String)ctx.lookup("java:comp/env/aes.key");
        System.out.println(key);
        String json;
        String decrypt = AESController.decrypt(jwt,key);
        System.out.println(decrypt);
        String email = new String(decrypt).split(" ")[0];
        String password = new String(decrypt).split(" ")[1]; // value stored in email+" "+password
        if(tdao.verifyEmailAndPassword(email, password)>0)
            {
            if(tdao.checkIsAdmin(email)){
                int x = tdao.assignComplaintToTechnician(complaint_id, technician_id);
                if(x>0){
                json = new Gson().toJson("assigned! with ct_id: "+x);
                }
                else{
                    json = new Gson().toJson("error occurred");
                }
            }
            else{
                json = new Gson().toJson("oops, you are not an admin :-(");
            }
        }
        else{
            json = new Gson().toJson("oops, It seems your username and password is incorrect :-(");
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
    catch(Exception e){
        e.printStackTrace();
        out.println("error");
    }
    }
}