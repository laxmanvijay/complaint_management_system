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
            out.println("email or password incorrect");
        }
        else{
            session.setAttribute("name",email);
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
                out.println("error");
            }
        }
        out.close();
    }
}