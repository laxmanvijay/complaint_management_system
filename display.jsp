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
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
.myLink {display: none}
#mySidebar{
font-family: 'Times New Roman', Times, serif
}
</style>
</head>
<body>
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
                            else{
                                if(data!=2){
                                    $("#admin").hide()
                                }
                            }
                        }
                    })
                }
            })
        </script>
        <div class="w3-sidebar w3-bar-block w3-collapse w3-card w3-black" style="width:200px;" id="mySidebar">
                 <div id="admin">
                        <a href="display.jsp" class="w3-bar-item w3-button w3-gray">Complaint Management</a>
                        <a href="applicationform.jsp" class="w3-bar-item w3-button ">Application Management</a>
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
        <button class="w3-bar-item w3-button tablink w3-black" onclick="openTab(event,'dashboard_tab')">DashBoard</button>
        <button class="w3-bar-item w3-button tablink" onclick="openTab(event,'complaint_tab')">Complaints</button>
        <button class="w3-bar-item w3-button tablink" onclick="openTab(event,'customer_tab')">Customers</button>
        <button class="w3-bar-item w3-button tablink" onclick="openTab(event,'export_tab')">Export</button>
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
      <div id="dashboard_tab" class="tabs">
        <div class="w3-card w3-margin" id="type_chart"></div>
        <div class="w3-card w3-margin">
            <h3>Number of complaints each day</h3>
            <div id="linechart"></div>
        </div>
        </div>   
    <div id="customer_tab" class="tabs" style="display:none">
    <div class="w3-card w3-margin">
        <h4>All Customers</h4>
    <table id="customers" class="display w3-table">
        <thead>
            <tr>
                <th>id</th>
                <th>name</th>
                <th>email</th>
                <th>phone</th>
                <th>dob</th>
                <th>country</th>
            </tr>
        </thead>
        <tbody>
            
        </tbody>

    </table>
    </div>
    </div>
    <div id="complaint_tab" class="tabs" style="display:none">
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
    </div>
    <div id="export_tab" class="tabs" style="display:none">
        <div class="w3-display-middle w3-card">
        <div class="w3-row w3-margin w3-border">
            <div class="w3-col m4 l4">
                    
                        <button onclick="download('generatecsv?data=complaint')" class="w3-bar-item w3-text w3-button">Generate csv of all complaints</button>
                    </div>
        </div>
        <div class="w3-row w3-margin w3-border">
            <div class="w3-col m4 l4">
                   
                        <button onclick="download('generatepdf?data=complaint')" class="w3-bar-item w3-text w3-button">Generate pdf of all complaints</button>
                    </div>
        </div>
        <div class="w3-row w3-margin w3-border">
            <div class="w3-col m4 l4">
                    
                        <button onclick="download('generatecsv?data=technician')" class="w3-bar-item w3-text w3-button">Generate csv of all technicians</button>
                    </div>
        </div>
        <div class="w3-row w3-margin w3-border">
            <div class="w3-col m4 l4">
                   
                        <button onclick="download('generatepdf?data=technician')" class="w3-bar-item w3-text w3-button">Generate pdf of all technicians</button>
                    </div>
        </div>
        </div>
               
    </div>
    
    </div>
    <script>
        function download(url){
            var req = new XMLHttpRequest();
            req.open("GET", url, true);
            req.responseType = "blob";
            req.onload = function (event) {
                var blob = req.response;
                var fileName = req.getResponseHeader("Content-Disposition").split("=")[1]
                var link=document.createElement('a');
                link.href=window.URL.createObjectURL(blob);
                link.download=fileName;
                link.click();
            };

            req.send();
        }
    </script>
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
if(localStorage.getItem("jwt")===null)
    localStorage.setItem("jwt",'${jwt}');
$.post('getallcomplaints',{'jwt':localStorage.getItem("jwt")},function(data){
    AllComplaintsdata=data;

$('#customers').DataTable({
    scrollX:true,
    ajax:{
        url:'getallcustomers',  
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
    { data: 'country' }
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

    
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {
    var security_count=0;
    var UI_count=0;
    var feature_count=0;
    for(var i=0;i<AllComplaintsdata.length;i++){
        var val=AllComplaintsdata[i].complaint_type;
        if(val=='Security'){
            security_count+=1;
        }
        else if(val=='UI'){
            UI_count+=1;
        }
        else{
            feature_count+=1;
        }
    }
    var data = google.visualization.arrayToDataTable([
    ['Type', 'Number of Complaints'],
    ['Security',security_count ],
    ['UI',  UI_count],
    ['Feature',feature_count ]
    ]);

    var options = {
    title: 'Number of complaints over various types'
    };

    var chart = new google.visualization.PieChart(document.getElementById('type_chart'));

    chart.draw(data, options);
}

google.charts.load('current', {'packages':['line']});
    google.charts.setOnLoadCallback(drawChart2);
    var out = new Array();
    for(var i=0;i<AllComplaintsdata.length;i++){
        out.push(AllComplaintsdata[i].timestamp.split(", ")[0]);
    }
    var obj={};
    for(var i=0;i<out.length;i++){
        if(out[i] in obj){
            obj[out[i]]++;
        }
        else{
            obj[out[i]]=1;
        }
    }
    
    console.log(out);
    console.log(obj);
    function drawChart2() {
        var data =new google.visualization.DataTable();
      data.addColumn('string','Day');
      data.addColumn('number','Count');
      var arr2=[];
    for (const [key, value] of Object.entries(obj)) {
        console.log(key,value)
        var arr = [];
        arr[0] = key;
        arr[1] = value;
        arr2.push(arr);
    }
    data.addRows(arr2);
    console.log(data);
      var options = {
        title: 'Company Performance',
        curveType: 'function',
        legend: { position: 'bottom' }
      };

      var chart = new google.visualization.LineChart(document.getElementById('linechart'));

      chart.draw(data, options);
    }
})
});
  </script>
</body>
</html>