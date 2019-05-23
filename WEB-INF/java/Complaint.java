import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/complaint")
public class Complaint extends HttpServlet{

    private static java.sql.Timestamp getCurrentTimeStamp() {

        java.util.Date today = new java.util.Date();
        return new java.sql.Timestamp(today.getTime());
    
    }

    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        
        PrintWriter out=response.getWriter();
        response.setContentType("text/html");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String country = request.getParameter("country");
        String application = request.getParameter("application");
        String version = request.getParameter("version");
        String type = request.getParameter("type");
        String description = request.getParameter("description");
        String email=request.getParameter("email");
        Customer c = new Customer()
                        .setName(name)
                        .setCountry(country)
                        .setDob(dob)
                        .setEmail(email)
                        .setPhone(phone);
        CustomerDao customerdao = new CustomerDaoImpl();
        
        ApplicationDtoDao applicationdao = new ApplicationDtoDaoImpl();
        int appId = applicationdao.getAppIdByName(application);
        int appverId = applicationdao.getAppverIdByAppIdAndVersion(appId,Integer.parseInt(version));
        ComplaintDto complaintdto = new ComplaintDto()
                            .setComplaintType(type)
                            .setComplaintDescription(description)
                            .setTimestamp(getCurrentTimeStamp())
                            .setAppverId(appverId);

        ComplaintDtoDao complaintdtodao = new ComplaintDtoDaoImpl();
        
        if(customerdao.insert(c)){
            int user_id = customerdao.getUserIdByEmail(email);
            int subscribed_id = customerdao.getSubscribedIdByUserId(user_id,appId);
            if(subscribed_id>0){
                int complaint_id = complaintdtodao.insert(complaintdto);
                if(complaintdtodao.insertIntoComplaintMap(subscribed_id,complaint_id)){
                    out.println("ok");
                }
                else{
                    out.println("err");
                }
            }else{
                out.println("you can't provide complaint about this because you haven't subscribed!");
            }

        System.out.println(name+phone);
        }
        else{
            out.println("err");
        }
        out.close();
    }
}