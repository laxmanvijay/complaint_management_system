package subcontrollers;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.*;
import com.google.gson.*;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.*;
import net.sf.jasperreports.engine.design.*;
import net.sf.jasperreports.engine.xml.*;

import dao.daoimpl.*;
import dao.DBConnection;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/generatepdf")
public class GeneratePdf extends HttpServlet{

    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{ 
        try{   
        JasperReport jasperReport = null;
            Map parameters = new HashMap();
            String path = getServletContext().getRealPath("/");
            String requestdata = request.getParameter("data");
            JasperDesign jasperDesign;
            String theQuery;
            if(requestdata.equals("technician")){
                theQuery = "SELECT * FROM technician join technician_details on technician.td_id = technician_details.td_id";
                jasperDesign = JRXmlLoader.load(path+"/technicianreport.jrxml");
            }
            else{
                theQuery = "SELECT * FROM complaint";
                jasperDesign = JRXmlLoader.load(path+"/complaintreport.jrxml");
            }
            JRDesignQuery newQuery = new JRDesignQuery();
            newQuery.setText(theQuery);
            jasperDesign.setQuery(newQuery);
            jasperReport = JasperCompileManager.compileReport(jasperDesign);
            DBConnection db = new DBConnection();
            byte[] byteStream = JasperRunManager.runReportToPdf(jasperReport, parameters,db.getConnection());                            
            OutputStream outStream = response.getOutputStream();
            response.setHeader("Content-Disposition","attachment; filename=report.pdf");
            response.setContentType("application/pdf");
            response.setContentLength(byteStream.length);
            outStream.write(byteStream,0,byteStream.length); 
            }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}