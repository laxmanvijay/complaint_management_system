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

@WebServlet("/getcomplaintsbytype")
public class GetComplaintsByType extends HttpServlet{
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        
        PrintWriter out = response.getWriter();
        ComplaintDtoDao complaintdao = new ComplaintDtoDaoImpl();
        HttpSession session = request.getSession(false);
        String json = new Gson().toJson(complaintdao.getComplaintsByComplaintType((String)session.getAttribute("type")));

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
}