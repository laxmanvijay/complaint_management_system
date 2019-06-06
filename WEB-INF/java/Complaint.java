import java.io.*;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.Time;
import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

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
        try{
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("HH:mm:ss");
        String application = request.getParameter("application");
        String version = request.getParameter("version");
        String type = request.getParameter("type");
        String description = request.getParameter("description");
        String email=request.getParameter("email");
        String time = dtf.format(LocalTime.now());
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
        TechnicianDao tdao = new TechniciandaoImpl();
            int user_id = customerdao.getUserIdByEmail(email);
            int subscribed_id = customerdao.getSubscribedIdByUserId(user_id,appId);
            if(subscribed_id>0){
                int complaint_id = complaintdtodao.insert(complaintdto);
                if(complaintdtodao.insertIntoComplaintMap(subscribed_id,complaint_id)){
                    List<Integer> ls = tdao.getTechnicianByApplicationId(applicationdao.getAppIdByName(application));
                    ls.forEach(technician_id->{
                        List<Time> tchse = tdao.getComplaintHandlingStartAndEndTimeById(technician_id);
                        System.out.println(tchse);
                        if(compareTime(tchse,time)){
                            tdao.assignComplaintToTechnician(complaint_id, technician_id);
                        }
                        System.out.println("yes");
                    });
                    request.setAttribute("id",complaint_id);
                    request.getRequestDispatcher("/Thankyou.jsp").forward(request,response);
                }
                else{
                    out.println("err");
                }
            }else{
                out.println("you can't provide complaint about this because you haven't subscribed!");
            }
        }
        catch(Exception e){
            e.printStackTrace();
            out.println("error");
        }
        out.close();
    }

    private boolean compareTime(List<Time> tchse, String time_input) {
        LocalTime start = LocalTime.parse(String.valueOf(tchse.get(0)));
        LocalTime end = LocalTime.parse(String.valueOf(tchse.get(1)));
        LocalTime time = LocalTime.parse(time_input);
        Duration d = Duration.between(start, time);
        Duration d2 = Duration.between(end, time);
        if(!d.isNegative()&& d2.isNegative()){
            return true;
        }
        return false;
    }
}