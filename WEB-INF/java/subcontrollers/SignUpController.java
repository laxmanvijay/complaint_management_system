package subcontrollers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.*;
import com.google.gson.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/signuptechnician")
public class SignUpController extends HttpServlet{

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        Technician t = new Technician();
        HttpSession session = request.getSession(false);
        t.name = request.getParameter("name");
        t.email = request.getParameter("email");
        t.password = request.getParameter("password");
        t.country = request.getParameter("country");
        t.setDob(request.getParameter("dob"));
        t.phone = request.getParameter("phone");
        t.specialization = request.getParameter("specialization");
        t.role = request.getParameter("role");
        t.salary = Integer.parseInt(request.getParameter("salary"));
        t.gender = request.getParameter("gender");
        String admin_password = request.getParameter("admin_password");
        String admin_user = (String)session.getAttribute("name");

        TechnicianDao tdao = new TechniciandaoImpl();
        if(tdao.checkIsAdmin(admin_user) && tdao.verifyEmailAndPassword(admin_user, admin_password)>0){
        int x=tdao.insert(t);
        if(x==0){
            out.println("email already registered");
        }
        else{
            out.println("success,the technician id is: "+x);
        }
        }
        else{
            out.println("you dont have permission to add a employee");
        }
        out.close();
    }
}