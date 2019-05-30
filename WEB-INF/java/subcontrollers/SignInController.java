package subcontrollers;

import java.io.*;
import java.sql.Time;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.*;
import com.google.gson.*;
import javax.naming.*;


import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/signin")
public class SignInController extends HttpServlet{

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session=request.getSession();  
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        TechnicianDao tdao = new TechniciandaoImpl();
        int x = tdao.verifyEmailAndPassword(email,password);
        
        if(x<=0){
            request.setAttribute("var",1);
            request.getRequestDispatcher("/signin.jsp").forward(request,response);
        }
        else{
            session.setAttribute("name",email);
            session.setAttribute("type",tdao.getTechnicianByEmail(email).specialization);
            tdao.setLastLoginToNow(email);
            try{
            Context ctx = new InitialContext();
            String key=(String)ctx.lookup("java:comp/env/aes.key");
            String jwt = AESController.encrypt((email+" "+password), key);
            request.setAttribute("jwt",jwt);
            request.getRequestDispatcher("/display.jsp").forward(request,response);
            }
            catch(Exception e){
                e.printStackTrace();
                request.getRequestDispatcher("/error.jsp").forward(request,response);
            }
        }
        out.close();
    }
}