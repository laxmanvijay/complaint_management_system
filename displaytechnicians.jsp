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
<link rel="stylesheet" type="text/css" href="util.css">
<link rel="stylesheet" type="text/css" href="main.css">
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
                            if(data<1){
                                location.href='signin.jsp'
                            }
                            else if(data!=2){
                                location.href='display.jsp'
                            }
                        }
                    })
                }
            })
        </script>
       
       <div class="w3-sidebar w3-bar-block w3-collapse w3-card w3-black" style="width:200px;" id="mySidebar">
            <div id="admin">
                    <a href="display.jsp" class="w3-bar-item w3-button">Complaint Management</a>
                    <a href="applicationform.jsp" class="w3-bar-item w3-button">Application Management</a>
                    <a href="displaytechnicians.jsp" class="w3-bar-item w3-button w3-gray">Technician Management</a>
                    
           </div>
         </div>
         <div class="w3-main" style="margin-left:200px">
         <script>
               function w3_open() {
                 document.getElementById("mySidebar").style.display = "block";
               }
               
               function w3_close() {
                 document.getElementById("mySidebar").style.display = "none";
               }
               </script>
               <div class="w3-bar">
               <h5 class="w3-bar-item w3-center w3-text w3-white w3-wide">COMPLAINT MANAGEMENT</h5>
               <button class="w3-button w3-bar-item w3-blue w3-right w3-round w3-margin-right w3-margin-top" onclick="$('#overlay').toggle()"><i class="fa fa-user fa-fw w3-margin-right w3-text-theme"></i>My Profile</button>
                </div>
               <div id="overlay">
                   <div class="w3-card w3-round w3-white">
                       <div class="w3-container">
                        <h4 class="w3-center">My Profile</h4>
                        <p class="w3-center"><img src="https://www.w3schools.com/howto/img_avatar.png" class="w3-circle" style="height:106px;width:106px" alt="Avatar"></p>
                        <hr>
                        <p><i class="fa fa-envelope fa-fw w3-margin-right w3-text-theme"></i> <%=session.getAttribute("name")%></p>
                       
                        <a href="signout" class="w3-bar-item w3-button w3-right w3-block w3-blue w3-margin" onclick="localStorage.removeItem('jwt')">SignOut</a>
                       </div>
                     </div>
               </div>
               <style>
               #overlay {
               position: absolute; /* Sit on top of the page content */
               display: none; /* Hidden by default */
               width: 250px; /* Full width (cover the whole page) */
               height: 250px; /* Full height (cover the whole page) */
               top: 0.1; 
               right:0;
               background-color: rgba(175,175,175,1); /* Black background with opacity */
               z-index: 2; /* Specify a stack order in case you're using a different order for other elements */
               cursor: pointer; /* Add a pointer on hover */
               }
               </style>
               <div class="w3-bar w3-blue w3-round w3-margin">
                    <button class="w3-bar-item w3-button tablink w3-black" onclick="openTab(event,'viewtechnician_tab')">View All Technicians</button>
                    <button class="w3-bar-item w3-button tablink" onclick="openTab(event,'addtechnician_tab')">Add Technician</button>
                    <button class="w3-bar-item w3-button tablink" onclick="openTab(event,'assignapplication_tab')">Assign Application</button>   
                </div>     
                <script>
                        function openTab(evt,name){
                          var i;
                          var x = document.getElementsByClassName("tabs");
                          for (i = 0; i < x.length; i++) {
                              x[i].style.display = "none"; 
                          }
                          tablinks = document.getElementsByClassName("tablink");
                          for (i = 0; i < x.length; i++) {
                              tablinks[i].className = tablinks[i].className.replace(" w3-black", "");
                          }
                          document.getElementById(name).style.display = "block";
                          evt.currentTarget.className += " w3-black";
                        }
                        </script>
    <div class="tabs" id="viewtechnician_tab">
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
    </div>
    <div id="addtechnician_tab" class="tabs" style="display: none">
            <div id="form" class="bg-contact2" style="background-image: url('mountain.jpg');">
                    <div class="container-contact2">
                        <div class="wrap-contact2">
                            <form class="contact2-form validate-form" action="signuptechnician" method="post">
                                <span class="contact2-form-title">
                                    Add Technician
                                </span>
                                <label for="name">Name</label>
                                <div class="wrap-input2 validate-input" data-validate="Name is required">
                                    <input class="input2" type="text" name="name" required>
                                </div>
                                <label for="email">Email</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                                    <input class="input2" type="text" id="email"name="email" required>
                                </div>
                                <label for="specialization">Specialization</label>
                                <div class="wrap-input2 validate-input" data-validate="Specialization is required">
                                    <input class="input2" type="text" name="specialization" required>
                                </div>
            
                                <div class="wrap-input2 validate-input" data-validate="Specialization is required">
                                    <input class="input2" type="time" name="shift_start_time" placeholder="shift start time" required>
                                </div>
            
                                <div class="wrap-input2 validate-input" data-validate="Specialization is required">
                                    <input class="input2" type="time" name="shift_end_time" placeholder="shift end time" required>
                                </div>
                                <label for="role">Role</label>
                                <div class="wrap-input2 validate-input" data-validate = "role is required">
                                    <input class="input2" type="text" id="role" name="role" required>
                                </div>
                                <label for="salary">Salary</label>
                                <div class="wrap-input2 validate-input" data-validate = "salary is required">
                                    <input class="input2" type="number" id="salary" name="salary" required>
                                </div>
            
                                <label for="gender">Gender</label><br>
                                    <label for="Male">Male: </label><input type="radio" name="gender" value="male" checked><br>
                                    <label for="Female">Female: </label><input type="radio" name="gender" value="female">
                                    <br>
                                    <br>
                                <label for="password">Password</label>
                                <div class="wrap-input2 validate-input" data-validate = "password is required">
                                    <input class="input2" type="password" id="password" name="password" required>
                                </div>
                                <label for="phone">Phone</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid phone number is required">
                                        <input class="input2" type="number" name="phone" required>    
                                    </div>
                                <label for="dob">Date of Birth</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid dob is required">
                                        <input class="input2" type="date" name="dob" required>
                                    </div>
                                <label for="Country">Country</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid country is required">
                                        <select name="country" id="country" class="input2" required>
                                                <option value="India">India</option>
                                                <option value="USA">USA</option>
                                                <option value="China">China</option>
                                                <option value="UK">UK</option>
                                              </select>
                                    </div>
                                <label for="admin_password">Admin Password</label>
                                <div class="wrap-input2 validate-input" data-validate = "admin password is required">
                                    <input class="input2" type="password" id="admin_password" name="admin_password" required>
                                </div>
            
                                <div class="container-contact2-form-btn">
                                    <div class="wrap-contact2-form-btn">
                                        <div class="contact2-form-bgbtn"></div>
                                        <button class="contact2-form-btn">
                                            Register Technician
                                        </button>
                                    </div>
                                </div>
                            </form>
                            </div>
                            </div>
                            </div>
    </div>
    <div id="assignapplication_tab" class="tabs" style="display:none">
            <div id="form" class="bg-contact2" style="background-image: url('mountain.jpg');">
                    <div class="container-contact2">
                        <div class="wrap-contact2">
                            <form class="contact2-form validate-form" action="signuptechnician" method="post">
                                <span class="contact2-form-title">
                                    Add Technician
                                </span>
                                <label for="name">Application Id</label>
                                <div class="wrap-input2 validate-input" data-validate="Name is required">
                                    <input class="input2" type="text" name="app_id" required>
                                </div>
                                <label for="email">Technicians Id, provide multiple values seperated by comma</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                                    <input class="input2" type="text" id="technician_id" name="technician_id" required>
                                </div>
                              
                                <div class="container-contact2-form-btn">
                                    <div class="wrap-contact2-form-btn">
                                        <div class="contact2-form-bgbtn"></div>
                                        <button class="contact2-form-btn">
                                            Assign Application with Technician
                                        </button>
                                    </div>
                                </div>
                            </form>
                            </div>
                            </div>
                            </div>
          </div>
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
})
});
  </script>
</body>
</html>