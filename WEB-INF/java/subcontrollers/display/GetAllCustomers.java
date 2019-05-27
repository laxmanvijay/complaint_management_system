package subcontrollers.display;

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
import com.google.gson.*;


@WebServlet("/getallcustomers")
public class GetAllCustomers extends HttpServlet{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        PrintWriter out = response.getWriter();
        TechnicianDao tdao = new TechniciandaoImpl();
        
        CustomerDao customerdao = new CustomerDaoImpl();
        String json;
        String jwt = request.getParameter("jwt");
        try{
        Context ctx = new InitialContext();
        String key=(String)ctx.lookup("java:comp/env/aes.key");
        System.out.println(key);
        String decrypt = AESController.decrypt(jwt,key);
        String email = new String(decrypt).split(" ")[0];
        String password = new String(decrypt).split(" ")[1]; // value stored in email+" "+password
        if(tdao.verifyEmailAndPassword(email, password)>0)
            {
            if(tdao.checkIsAdmin(email)){
                json = new Gson().toJson(customerdao.getAllCustomers());
            }
            else{
                json = new Gson().toJson(customerdao.getCustomerForTechnicians(email));
            }
        }
        else{
            json = new Gson().toJson(new CombinedComplaintInfo());
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