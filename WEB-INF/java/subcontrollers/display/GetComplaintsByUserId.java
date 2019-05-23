package subcontrollers.display;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.*;
import com.google.gson.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;
import com.google.gson.*;

@WebServlet("/getcomplaintsbyuserid")
public class GetComplaintsByUserId extends HttpServlet{
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        
        PrintWriter out = response.getWriter();
        ComplaintDtoDao complaintdao = new ComplaintDtoDaoImpl();
        String json = new Gson().toJson(complaintdao.getComplaintsByUserId(Integer.parseInt(request.getParameter("id"))));

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}