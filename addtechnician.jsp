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
        <h5 class="w3-center w3-text w3-white w3-wide">COMPLAINT MANAGEMENT</h5>
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
                    <label for="currently_working_application">Currently working application</label>
                    <div class="wrap-input2 validate-input" data-validate="Specialization is required">
                        <input class="input2" type="text" name="currently_working_application" required>
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