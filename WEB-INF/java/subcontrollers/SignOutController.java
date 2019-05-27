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

@WebServlet("/signout")
public class SignOutController extends HttpServlet{

    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session=request.getSession(false);  
        session.invalidate();
        request.getRequestDispatcher("/index.jsp").forward(request,response);
    }
}