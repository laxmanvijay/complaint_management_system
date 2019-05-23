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

        String appName = request.getParameter("appname");
        String email = request.getParameter("email");
        CustomerDao customerdao = new CustomerDaoImpl();
        ApplicationDtoDao applicationdao = new ApplicationDtoDaoImpl();

        int appId = applicationdao.getAppIdByName(appName);
        int userId = customerdao.getUserIdByEmail(email);

        if(customerdao.addSubscription(appId,userId)){
            out.println("ok");
        }
        else{
            out.println("err");
        }
        out.close();
    }
}