<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Add Technician</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"></link>

<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="util.css">
	<link rel="stylesheet" type="text/css" href="main.css">
<style>
body,h1,h2,h3,h4,h5,h6,label {font-family: "Times New Roman", Arial, Helvetica, sans-serif}
.myLink {display: none}
</style>
</head>
<body>
        <script>
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
                            if(data!='1'){
                                location.href='signin.jsp'
                            }
                        }
                    })
                }
        </script>
         <% if (request.getAttribute("error")!=null) { %>
            <script>
            toastr.error("You don't have permission to add an employee or Email already registered")
            </script>
            <% } %>
            <% if (request.getAttribute("success")!=null) { %>
                <script>
                toastr.success('Success,Added a new Technician')
                </script>
                <% } %>
                <div class="w3-sidebar w3-bar-block w3-collapse w3-card w3-black" style="width:200px;" id="mySidebar">
                        <div id="admin">
                       <a href="addtechnician.jsp" class="w3-bar-item w3-button">AddTechnician</a>
                       <a href="applicationform.jsp" class="w3-bar-item w3-button">Add Application</a>
                       <a href="displaytechnicians.jsp" class="w3-bar-item w3-button">Display Technicians</a>
                       
                        ${session.getAttribute("name")}
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
</body>
</html>