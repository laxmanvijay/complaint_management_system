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
           <a href="applicationform.jsp" class="w3-bar-item w3-button w3-gray">Application Management</a>
           <a href="displaytechnicians.jsp" class="w3-bar-item w3-button">Technician Management</a>
           
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
                    <button class="w3-bar-item w3-button tablink w3-black" onclick="openTab(event,'viewapplication_tab')">View All Applications</button>
                    <button class="w3-bar-item w3-button tablink" onclick="openTab(event,'addapplication_tab')">Add Application</button>
                      
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
    <div class="tabs" id="viewapplication_tab">
    <div class="w3-card w3-margin">
        <h4>All Applications</h4>
    <table id="applications" class="display w3-table">
        <thead>
            <tr>
                <th>id</th>
                <th>name</th>
                <th>version</th>
                <th>description</th>
            </tr>
        </thead>
        <tbody>
            
        </tbody>

    </table>
    </div>
    </div>
    
    <div id="addapplication_tab" class="tabs" style="display:none">
            <div id="form" class="bg-contact2" style="background-image: url('mountain.jpg');">
                    <div class="container-contact2">
                        <div class="wrap-contact2">
                            <form class="contact2-form validate-form" action="signuptechnician" method="post">
                                <span class="contact2-form-title">
                                    Add Application
                                </span>
                                <label for="name">Application Name</label>
                                <div class="wrap-input2 validate-input" data-validate="Name is required">
                                    <input class="input2" type="text" name="name" required>
                                </div>
                                <label for="version">Version</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                                    <input class="input2" type="text" id="version" name="version" required>
                                </div>
                                <label for="message">Description</label>
                                <div class="wrap-input2 validate-input" data-validate = "Message is required">
                                    <textarea class="input2" name="description"></textarea>
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

$('#applications').DataTable({
    scrollX:true,
    ajax:{
        url:'getallapplications',  
        dataSrc:'',
        type:'POST',
        data:{
            "jwt":localStorage.getItem("jwt")
        }
        },
        columns: [
    { data: 'id' },
    { data: 'name' },
    { data: 'version' },
    { data: 'description' }
]
});
})
});
  </script>
</body>
</html>