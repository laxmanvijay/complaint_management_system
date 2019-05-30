package subcontrollers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.*;
import com.google.gson.*;
import javax.naming.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/verifyemailandpassword")
public class VerifyEmailAndPassword extends HttpServlet{

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        
        PrintWriter out = response.getWriter();
        HttpSession session=request.getSession(false); 
        TechnicianDao tdao = new TechniciandaoImpl();
        String json;
        String jwt = request.getParameter("jwt");
        Gson gson =new Gson();
        try{
            Context ctx = new InitialContext();
            String key=(String)ctx.lookup("java:comp/env/aes.key");
            System.out.println(key);
            String decrypt = AESController.decrypt(jwt,key);
            String email = new String(decrypt).split(" ")[0];
            String password = new String(decrypt).split(" ")[1]; // value stored in email+" "+password
            
            if(tdao.verifyEmailAndPassword(email, password)>0){
                json = gson.toJson(1);
            }
            else{
                json = gson.toJson(0);
            }
        }
        catch(Exception e){
            e.printStackTrace();
            json = gson.toJson(0);
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}