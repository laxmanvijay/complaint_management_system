package subcontrollers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/addsubscription")
public class AddSubscription extends HttpServlet{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        
        PrintWriter out=response.getWriter();
        response.setContentType("text/html");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String country = request.getParameter("country");
        String appName = request.getParameter("appname");
        String email = request.getParameter("email");
        CustomerDao customerdao = new CustomerDaoImpl();
        ApplicationDtoDao applicationdao = new ApplicationDtoDaoImpl();
        Customer c = new Customer()
                        .setName(name)
                        .setCountry(country)
                        .setDob(dob)
                        .setEmail(email)
                        .setPhone(phone);
        
        if(customerdao.insert(c)){
            int appId = applicationdao.getAppIdByName(appName);
            int userId = customerdao.getUserIdByEmail(email);
            customerdao.addSubscription(appId, userId);
            request.getRequestDispatcher("/index.jsp").forward(request,response);
        }
        else{
            request.getRequestDispatcher("/error.jsp").forward(request,response);
        }
        out.close();
    }
}