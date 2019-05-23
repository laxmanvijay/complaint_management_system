package subcontrollers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/addapplication")
public class AddApplication extends HttpServlet{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        
        PrintWriter out=response.getWriter();
        response.setContentType("text/html");

        String name = request.getParameter("name");
        String version = request.getParameter("version");
        String description = request.getParameter("description");
        
        ApplicationDto ad = new ApplicationDto()
                            .setApplicationName(name)
                            .setApplicationDescription(description);
        
        ApplicationDtoDao adao = new ApplicationDtoDaoImpl();
        if(adao.insert(ad, Integer.parseInt(version))>0){
            out.println("ok");
        }                    
        else{
            out.println("err");
        }   
        out.close();
    }
}
