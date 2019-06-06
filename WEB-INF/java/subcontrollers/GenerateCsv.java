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
import net.sf.jasperreports.engine.export.*;

import dao.daoimpl.*;
import dao.DBConnection;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/generatecsv")
public class GenerateCsv extends HttpServlet{

    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{ 
        JasperPrint jasperPrint;        
    ServletOutputStream outputStream = null;
            try
            {
            String path = getServletContext().getRealPath("/");
            JasperDesign jasperDesign;
            String theQuery;
            String requestdata = request.getParameter("data");
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
            JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
            jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<String,Object>(), new DBConnection().getConnection());
            response.setHeader("Content-Disposition", "attachment;filename=report.csv");
            response.setContentType("application/octet-stream");
            //response.setContentLength(4096);
            outputStream = response.getOutputStream();
            JRCsvExporter exporter = new JRCsvExporter();
            exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
            exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
            exporter.exportReport();
            }
        catch(Exception e){
            e.printStackTrace();
        }
    }
}