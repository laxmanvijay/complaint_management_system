<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Display</title>
    <meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"></link>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
.myLink {display: none}
</style>
</head>
<body>
        <% if (request.getAttribute("error")!=null) { %>
            <script>
            toastr.error("Error occurred! Please try to enter 3 technicians and try again")
            </script>
            <% } %>
            <% if (request.getAttribute("assigned")!=null) { %>
              <script>
              toastr.success("Success, assigned the technicians")
              </script>
              <% } %>
              <% if (request.getAttribute("notadmin")!=null) { %>
                <script>
                toastr.info("You are not an admin")
                </script>
                <% } %>
        <script>
            $(document).ready(function(){
                if(localStorage.getItem("jwt")===null){
                    location.href='signin.jsp'
                }
                else{
                    $.ajax({
                        url:'verifyemailandpassword',
                        type:'POST',
                        data:{
                            'jwt':localStorage.getItem("jwt")
                        },
                        success:function(data){
                            console.log('success')
                            if(data!=1){
                                location.href='signin.jsp'
                            }
                        }
                    })
                }
            })
        </script>
        <div class="w3-sidebar w3-bar-block w3-collapse w3-card" style="width:200px;" id="mySidebar">
            <button class="w3-bar-item w3-button w3-hide-large"
            onclick="w3_close()">Close &times;</button>
            <a href="signout" class="w3-bar-item w3-button" onclick="localStorage.removeItem('jwt');location.href='signout'">SignOut</a>
            <a href="addtechnician.jsp" class="w3-bar-item w3-button">AddTechnician</a>
            <a href="applicationform.jsp" class="w3-bar-item w3-button">Add Application</a>
            <a href="generatepdf?data=technician" class="w3-bar-item w3-button">generate pdf</a>
             <a href="generatecsv?data=technician" class="w3-bar-item w3-button">generate csv</a>
          </div>
          <div class="w3-main" style="margin-left:200px">
        <h5 class="w3-center w3-text w3-white w3-wide">COMPLAINT MANAGEMENT</h5>
    <div class="w3-card w3-margin">
        <h4>All Technicians</h4>
    <table id="technicians" class="display w3-table">
        <thead>
            <tr>
                <th>id</th>
                <th>name</th>
                <th>email</th>
                <th>phone</th>
                <th>dob</th>
                <th>country</th>
                <th>Specialization</th>
                <th>Gender</th>
                <th>Shift Start</th>
                <th>Shift End</th>
                <th>Complaint Handling Start</th>
                <th>Complaint Handling End</th>
            </tr>
        </thead>
        <tbody>
            
        </tbody>

    </table>
    </div>
    <br>
    <div class="w3-table w3-card w3-margin">
    <h4>All Complaints</h4>
    <table id="complaints" class="display w3-table">
            <thead>
                <tr>
                    <th>Complaint ID</th>
                    <th>Type</th>
                    <th>Description</th>
                    <th>Timestamp</th>
                    <th>App Name</th>
                    <th>App Version</th>
                    <th>User Email</th>
                   
                </tr>
            </thead>
            <tbody>
            
            </tbody>
        </table>
    </div>
    <form action="assignapplication" method="post">
            <h3>Create an entry for an application</h3>
              <br>
              <div class="w3-half">
                      <label>Application id</label>
                      <input type="text" name="app_id" id="app_id" required>
              </div>
              <br>
              <div class="w3-half">
                <label>Technician id</label>
                <p>Provide multiple technicians by seperating with commas</p>
                <input type="text" name="technician_id" id="technician_id" required>
                </div>
                <br>
                <input type="hidden" name="jwt" id="jwt">
              <input type="submit" value="submit" class="w3-button w3-dark-grey">
          </form>
   
    </div>
<script>

function logout(){
    console.log("click");
    localStorage.removeItem("jwt");
    location.href="signout";
}
</script>
<script>
    var AllComplaintsdata;
$(document).ready( function () {
    $("#jwt").val(localStorage.getItem("jwt"));
$.post('getallcomplaints',{'jwt':localStorage.getItem("jwt")},function(data){
    AllComplaintsdata=data;

$('#technicians').DataTable({
    scrollX:true,
    ajax:{
        url:'getalltechnicians',  
        dataSrc:'',
        type:'POST',
        data:{
            "jwt":localStorage.getItem("jwt")
        }
        },
        columns: [
    { data: 'id' },
    { data: 'name' },
    { data: 'email' },
    { data: 'phone' },
    { data: 'dob' },
    { data: 'country' },
    { data: 'specialization' },
    { data: 'gender' },
    { data: 'shift_start_time' },
    { data: 'shift_end_time' },
    { data: 'complaint_handling_time_start' },
    { data: 'complaint_handling_time_end' }
]
});

$('#complaints').DataTable({
    scrollX:true,
    ajax:{
        url:'getallcomplaints',
        type:'POST',
        data:{
            'jwt':localStorage.getItem("jwt")
        },
        dataSrc:''
    },
    columns: [
        { data: 'complaint_id' },
        { data: 'complaint_type' },
        { data: 'complaint_description' },
        { data: 'timestamp' },
        {data:'app_name'},
        {data:'version'},
        {data:'email'}
    ]
});

});
});
  </script>
</body>
</html>