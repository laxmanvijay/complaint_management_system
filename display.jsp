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
</style>
</head>
<body>
    <header style="height: 30%;background-color: black">
        <h4 class="w3-text w3-white">Complaint Management System</h4>
    </header>
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
        <div id="type_chart"></div>
    </div>
<script>
$(document).ready( function () {
var AllComplaintsdata,data2;
$.get('getallcomplaints',function(data){
    AllComplaintsdata=data;
    data2=data;
    console.log(data2);
})

$('#customers').DataTable({
    ajax:{
        url:'getallcustomers',  
        dataSrc:''
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
    ajax:{
        url:'getallcomplaints',
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
});
</script>
</body>
</html>