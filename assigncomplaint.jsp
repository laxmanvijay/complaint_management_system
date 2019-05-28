<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Assign complaint</title>
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
        <h5 class="w3-center w3-text w3-white w3-wide">COMPLAINT MANAGEMENT</h5>
    <form action="assigncomplaint" method="post">
        <h3>Create an entry for an application</h3>
          <br>
          <div class="w3-half">
                  <label>Complaint id</label>
                  <input type="text" name="complaint_id" id="complaint_id">
          </div>
          <br>
          <div class="w3-half">
            <label>Technician id</label>
            <input type="text" name="technician_id" id="technician_id">
            </div>
            <br>
            <input type="hidden" name="jwt" id="jwt">
          <input type="submit" value="submit" class="w3-button w3-dark-grey">
      </form>
    <script>
    $(document).ready( function () {
        $("#jwt").val(localStorage.getItem("jwt"));
    })
    </script>
</body>
</html>