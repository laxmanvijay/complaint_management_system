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



@WebServlet("/getallcomplaints")
public class GetAllComplaints extends HttpServlet{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        PrintWriter out = response.getWriter();
        TechnicianDao tdao = new TechniciandaoImpl();
        HttpSession session = request.getSession(false);
        ComplaintDtoDao complaintdao = new ComplaintDtoDaoImpl();
        String json;
        String jwt = request.getParameter("jwt");
        try{
        Context ctx = new InitialContext();
        String key=(String)ctx.lookup("java:comp/env/aes.key");
        System.out.println(key);
        String decrypt = AESController.decrypt(jwt,key);
        String email = new String(decrypt).split(" ")[0];
        String password = new String(decrypt).split(" ")[1]; // value stored in email+" "+password
        Gson gson =new Gson();
        if(tdao.verifyEmailAndPassword(email, password)>0)
            {
            if(tdao.checkIsAdmin(email)){
                json = gson.toJson(complaintdao.getAllComplaints());
            }
            else{
                json = gson.toJson(complaintdao.getComplaintsByComplaintType((String)session.getAttribute("type")));
            }
        }
        else{
            json = gson.toJson(new CombinedComplaintInfo());
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
    catch(Exception e){
        e.printStackTrace();
        request.getRequestDispatcher("/error.jsp").forward(request,response);
    }
    }
}