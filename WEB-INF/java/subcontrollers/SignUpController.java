package subcontrollers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.*;
import com.google.gson.*;
import java.sql.Time;
import java.time.*;

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
        ApplicationDtoDao adao = new ApplicationDtoDaoImpl();
        // Instant instant = Instant.now();
        // LocalTime time = instant.atZone(ZoneOffset.UTC).toLocalTime();
        // int hour = instant.atZone(ZoneOffset.UTC).getHour();
        // LocalTime userstarttime = timelist.get(0).toLocalTime();
        // LocalTime userendtime = timelist.get(1).toLocalTime();
        // int x1 = time.compareTo(userstarttime);
        // int x2 = time.compareTo(userendtime);
        t.name = request.getParameter("name");
        t.email = request.getParameter("email");
        t.password = request.getParameter("password");
        t.country = request.getParameter("country");
        t.setDob(request.getParameter("dob"));
        t.phone = request.getParameter("phone");
        t.specialization = request.getParameter("specialization");
        System.out.println(request.getParameter("shift_start_time"));
        t.shift_start_time = Time.valueOf(request.getParameter("shift_start_time")+":00");
        t.shift_end_time = Time.valueOf(request.getParameter("shift_end_time")+":00");
        t.role = request.getParameter("role");
        t.salary = Integer.parseInt(request.getParameter("salary"));
        t.gender = request.getParameter("gender");
        String admin_password = request.getParameter("admin_password");
        String admin_user = (String)session.getAttribute("name");

        TechnicianDao tdao = new TechniciandaoImpl();
        if(tdao.checkIsAdmin(admin_user) && tdao.verifyEmailAndPassword(admin_user, admin_password)>0){
        int x=tdao.insert(t);
        if(x==0){
            request.setAttribute("error",1);
            request.getRequestDispatcher("/addtechnician.jsp").forward(request,response);
        }
        else{
            request.setAttribute("success",x);
            request.getRequestDispatcher("/addtechnician.jsp").forward(request,response);
        }
        }
        else{
            request.setAttribute("error",1);
            request.getRequestDispatcher("/addtechnician.jsp").forward(request,response);
        }
        out.close();
    }
}