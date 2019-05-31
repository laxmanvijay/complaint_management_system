package subcontrollers;

import java.io.*;
import java.sql.Time;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.util.*;
import com.google.gson.*;
import javax.naming.*;
import subcontrollers.AESController;
import dao.daoimpl.*;
import dao.dao.*;
import dao.dto.*;

@WebServlet("/assignapplication")
public class AssignApplication extends HttpServlet{
    public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException{
        PrintWriter out = response.getWriter();
        int app_id = Integer.parseInt(request.getParameter("app_id"));
        String technician_id_string = request.getParameter("technician_id");
        List<String> technician_id_array = Arrays.asList(technician_id_string.split(","));
        String json;
        if(technician_id_array.size()<3){
            json = new Gson().toJson("error occurred");
            response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
        }
        else{
            TechnicianDao tdao = new TechniciandaoImpl();
            List<Technician> technician_list = new ArrayList<>();
            for(String id:technician_id_array){
                technician_list.add(tdao.getTechnicianById(Integer.parseInt(id)));
            }
        String jwt = request.getParameter("jwt");
        try{
        Context ctx = new InitialContext();
        String key=(String)ctx.lookup("java:comp/env/aes.key");
        System.out.println(key);
        String decrypt = AESController.decrypt(jwt,key);
        System.out.println(decrypt);
        String email = new String(decrypt).split(" ")[0];
        String password = new String(decrypt).split(" ")[1]; // value stored in email+" "+password
        if(tdao.verifyEmailAndPassword(email, password)>0)
            {
                int x=0;
            if(tdao.checkIsAdmin(email)){
                int number_of_technicians = technician_list.size();
                List<String[]> shifttime = getShiftTime(number_of_technicians);
                List<String[]> complainthandlinghours = getComplaintHandlingHours(number_of_technicians);
                int i=0;
                for(String[] tx:shifttime){
                    System.out.println(tx[0]+"\t"+tx[1]);
                }
                for(Technician t:technician_list){
                
                Time shift_start = Time.valueOf(shifttime.get(i)[0]);
                Time shift_end = Time.valueOf(shifttime.get(i)[1]);
                Time complaint_start = Time.valueOf(complainthandlinghours.get(i)[0]);
                Time complaint_end = Time.valueOf(complainthandlinghours.get(i)[1]);
                
                tdao.setSessionStartAndEndTimeByEmail(shift_start,shift_end, t.id);
                tdao.setComplaintHandlingStartAndEndTimeByEmail(complaint_start,complaint_end, t.id);
                x = tdao.assignApplicationToTechnician(app_id, t.id);
                i++;
                }
                if(x>0){
                json = new Gson().toJson("assigned!");
                }
                else{
                    json = new Gson().toJson("error occurred");
                }
            }
            else{
                json = new Gson().toJson("oops, you are not an admin :-(");
            }
        }
        else{
            json = new Gson().toJson("oops, It seems your username and password is incorrect :-(");
        }
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }
    catch(Exception e){
        e.printStackTrace();
        request.getRequestDispatcher("/error.jsp").forward(request,response);
    }
    }
}
    private List<String[]> getShiftTime(int number_of_technicians){
        int temp = number_of_technicians;
        List<String[]> ls = new ArrayList<>();
        if(number_of_technicians<8){
            if(number_of_technicians==3){
                ls = shiftTimeCalc(number_of_technicians);
            }
            else if(temp>3&&temp%2!=0){
            temp=temp-1;
            ls = shiftTimeCalc(temp);
            ls.add(ls.get(0));
            }
    }
    else{
        int multiplies = temp/8; // nearest multiplicant value example: if number is 17, then multiplies is 2
        int extra = temp-multiplies*8; // extra values found after multiplies, if number is 17 then extra is 1
        ls = shiftTimeCalc(8); // calculate for 8 values, then repeat the pattern
        for(int i=0;i<(multiplies-1)*8+extra;i++){ 
            ls.add(ls.get(i));
        }
    }
    return ls;
    }

    private List<String[]> shiftTimeCalc(int number_of_technicians) {
        List<String[]> ls = new ArrayList<>();
        if(number_of_technicians==3){
            String[] s = {convertDecimalToTime(0),convertDecimalToTime(8)};
            ls.add(s);
            String[] s1 = {convertDecimalToTime(8),convertDecimalToTime(16)};
            ls.add(s1);
            String[] s2 = {convertDecimalToTime(16),convertDecimalToTime(24)};
            ls.add(s2);
        }
        else{
            String[] s = {convertDecimalToTime(0),convertDecimalToTime(8)};
            ls.add(s);
            float diff = ((24 - number_of_technicians) / number_of_technicians);
            float temp = 0f;
            for (int i = 1; i < number_of_technicians - 1; i++) {
            temp += diff;
            if (number_of_technicians >= 10) {
                temp += (number_of_technicians / 24);
            }
            String[] k = {convertDecimalToTime(temp),convertDecimalToTime(temp+8)};
            ls.add(k);
            }
            String[] s2 = {convertDecimalToTime(16),convertDecimalToTime(24)};
            ls.add(s2);
        
    }
        return ls;
    }

    private List<String[]> getComplaintHandlingHours(int number_of_technicians) {
        float hour_gap = 24/number_of_technicians;
        float temp=0;
        List<String[]> ls = new ArrayList<>();
        for(int i=0;i<number_of_technicians;i++){
            String a = convertDecimalToTime(temp);
            temp+=8;
            String b = convertDecimalToTime(temp);
            String[] arr = {a,b};
            ls.add(arr);
        }
        return ls;
    }

    private static String convertDecimalToTime(float temp) {
        int hour = (int)temp;
        float min = (temp-hour)*60;
        String s = String.valueOf(hour)+":"+String.valueOf((int)min)+":0";
        return s;
    }
}