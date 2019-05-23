<!DOCTYPE html>
<html>
<title>Complaint Management</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Raleway", Arial, Helvetica, sans-serif}
.myLink {display: none}
</style>
<style>
input{
background-color: rgba(0,0,0,0.1);
color: white;
border: none;
}
select{
background-color: rgba(0,0,0,0.1);
color: white;
border: none;
}
</style>
<body class="w3-light-grey" style="background-color: burlywood">


<!-- Header -->
<header class="w3-display-container w3-content" style="max-width:1500px">
  <img class="w3-image" src="http://www.scribendi.com/images/cms/thumbnails/An-Example-Complaint-Letter_720x370.jpg" alt="London" width="1500" height="700">
  <div class="w3-container w3-display-middle" style="width:80%">
</header>
<br>
<form action="complaint" method="post" class=" w3-card-4 w3-container w3-margin-left" style="width:60%">

  <label>Name</label>
  <input name="name" id="name" class="w3-input" type="text" placeholder="Name" required>
  <br>
  <label>Email</label>
  <input name="email" id="email" class="w3-input" type="text" placeholder="email" required>
      <br>
  <label>Phone Number</label>
  <input name="phone" id="phone" class="w3-input" type="number" placeholder="Phone" required>
 <br>
  <label>Date of Birth</label>
  <input name="dob" id="dob" class="w3-input" type="date" placeholder="date of birth" required>
<br>
  <label>Country</label>
  <select name="country" id="country" class="w3-input" required>
      <option value="India">India</option>
      <option value="USA">USA</option>
      <option value="China">China</option>
      <option value="UK">UK</option>
    </select>
  <br>
  <label>Application</label>
  <select name="application" id="application" class="w3-select" required>
          
  </select>
<br>
  <label>Version</label>
  <select name="version" id="version" class="w3-select" required>
          
  </select>
<br>
  <label>Complaint Type</label>
  <select name="type" id="type" class="w3-select" required>
          <option value="Security">Security issues</option>
          <option value="UI">user interface issues</option>
          <option value="feature">feature issues</option>
  </select>
<br>
  <label>Complaint</label>
  <input name="description" id="description" class="w3-input w3-text" type="text" placeholder="complaint" required>
   <br>
  <input type="submit" value="submit" class="w3-button w3-dark-grey">
  </form>
</div>
<!-- Page content -->
<div class="w3-content" style="max-width:1100px;">

  <!-- Good offers -->
  <div class="w3-container w3-margin-top">
    <h3>All our Apps</h3>
    <h6>Use any app for free.</h6>
  </div>
  <div class="w3-row-padding w3-text-white w3-large">
    <div class="w3-half w3-margin-bottom">
      <div class="w3-display-container">
        <img src="https://cdn-images-1.medium.com/max/1600/1*BWZp1CB1u7QE1CAr6eewrA.jpeg" alt="Cinque Terre" style="width:100%">
        <span class="w3-display-bottomleft w3-padding">ChatBot</span>
      </div>
    </div>
    <div class="w3-half">
      <div class="w3-row-padding" style="margin:0 -16px">
        <div class="w3-half w3-margin-bottom">
          <div class="w3-display-container">
            <img src="https://cdn.windowsreport.com/wp-content/uploads/2018/09/download-Windows-Live-Mail.png" alt="New York" style="width:100%">
            <span class="w3-display-bottomleft w3-padding">Mail</span>
          </div>
        </div>
        <div class="w3-half w3-margin-bottom">
          <div class="w3-display-container">
            <img src="https://image.shutterstock.com/image-illustration/great-attendance-concept-good-chart-260nw-582176428.jpg" alt="San Francisco" style="width:100%">
            <span class="w3-display-bottomleft w3-padding">Attendance Management</span>
          </div>
        </div>
      </div>
      <div class="w3-row-padding" style="margin:0 -16px">
        <div class="w3-half w3-margin-bottom">
          <div class="w3-display-container">
            <img src="https://abm-website-assets.s3.amazonaws.com/rdmag.com/s3fs-public/styles/content_body_image/public/embedded_image/2017/01/SC1701_sound.jpg?itok=h2FwdvgP" alt="Pisa" style="width:100%">
            <span class="w3-display-bottomleft w3-padding">Music Player</span>
          </div>
        </div>
        <div class="w3-half w3-margin-bottom">
          <div class="w3-display-container">
            <img src="https://previews.123rf.com/images/maxxyustas/maxxyustas1601/maxxyustas160100060/52181007-education-concept-bookshelf-with-books-and-textbooks-in-form-of-heart-i-love-reading-3d.jpg" alt="Paris" style="width:100%">
            <span class="w3-display-bottomleft w3-padding">Book Shelf</span>
          </div>
        </div>
      </div>
    </div>
  </div>

</div>

<script>
$(document).on("blur", "#email", function() {
      
    $.post("getappbyemail",{"email":$("#email").val()}, function(responseJson) {   
        console.log(responseJson) 
        var $el = $("#application");
        $el.empty();
        $.each(responseJson, function(key,value) {
        $el.append($("<option></option>")
            .attr("value", value).text(value));
        });
    });
});

$("#application").on('blur', function() {
    $.post("getversionbyapp",{"name":$("#application").val()}, function(responseJson) {   
          console.log(responseJson) 
          var $el = $("#version");
          $el.empty();
          $.each(responseJson, function(key,value) {
          $el.append($("<option></option>")
              .attr("value", value).text(value));
          });
      });
});
</script>

</body>
</html>
