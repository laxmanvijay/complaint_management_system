<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Complaint Management System</title>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="util.css">
	<link rel="stylesheet" type="text/css" href="main.css">
<style>
body,h1,h2,h3,h4,h5,h6,label {font-family: "Times New Roman", Arial, Helvetica, sans-serif}
.myLink {display: none}
select {
  outline: none;
}
</style>
</head>
<body background="water.jpg">
    <h5 class="w3-center w3-text w3-white w3-wide">COMPLAINT MANAGEMENT</h5>

    <br>
    <style>
    #display_middle{
        border-style: solid;
        width: 60%;
        color:white;
        position: relative;
        top:100px;
        left: 20%;
    }
    </style>
    <br><br><br>
    <br>
            <div class=" svg-wrapper">
                    <svg height="60" width="500" xmlns="http://www.w3.org/2000/svg">
                      <div class="w3-margin text">
                            Sorry to hear that you have got a complaint about us. :( <br>
                            Anyways leave that here, we will solve it as soon as possible.
                      </div>
                    </svg>
                  </div>

    <br>
    <br>
    <br>
    <br><br>
    <br>
    <br>
    <br>
    <style>
    ::selection {
  background: #b3d3fd;
}
.svg-wrapper {
  position: absolute;
  left:31%;
  top: 34%;
  transform: translateY(-50%);
  margin: 0 auto;
  width: 500px;
}

.text {
  font-family: 'Roboto Condensed';
  font-size: 22px;
  line-height: 32px;
  letter-spacing: 8px;
  color: #fff;
  top: -48px;
  position: relative;
}
    </style>
    <br>
    <br>
    <div class="downArrow bounce" onclick="location.href='index.jsp#form'">
            <img width="90" height="90" alt="" src="http://americanevangelicals.com/wp-content/uploads/intense-cache/icons/plugin/font-awesome/angle-double-down.svg" />
          </div>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <style>
                .grid { 
            
                  display: grid;
                  grid-template-columns: auto auto auto ;
                  align-items: stretch;
                  margin: 30px;
                  }
                .grid container {
                    
                  box-shadow: 2px 2px 6px 0px  rgba(0,0,0,0.3);
                  
                }
                </style>
                <style>
                .container {
  position: relative;
  width: 100%;
}

.image {
  display: block;
  width: 100%;
  height:100%;
}

.overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  height: 100%;
  width: 100%;
  opacity: 0;
  transition: .5s ease;
  background-color: black;
}

.container:hover .overlay {
  opacity: 0.6;
}

.text {
  color: white;
  font-size: 20px;
  position: absolute;
  top: 50%;
  left: 50%;
  -webkit-transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  transform: translate(-50%, -50%);
  text-align: center;
}
                </style>
                <h3 class="w3-margin" style="color:white">All our Apps</h3>
            <div class="grid">
                <div class="container">
                        <img src="http://tripco.in/template/images/trip.jpg" alt="Avatar" class="image">
                        <div class="overlay">
                            <div class="text">Trip Management</div>
                    </div>
                    </div>
                <div class="container">
                        <img src="https://www.psychbytes.com/wp-content/uploads/2018/06/AdobeStock_121719342.jpeg" alt="Avatar" class="image">
                        <div class="overlay">
                            <div class="text">Chat Application</div>
                    </div>
                    </div>
                    <div class="container">
                            <img src="https://previews.123rf.com/images/maxxyustas/maxxyustas1601/maxxyustas160100060/52181007-education-concept-bookshelf-with-books-and-textbooks-in-form-of-heart-i-love-reading-3d.jpg" alt="Avatar" class="image">
                            <div class="overlay">
                                <div class="text">Book Shelf</div>
                        </div>
                        </div>
                    <div class="container">
                            <img src="https://timedotcom.files.wordpress.com/2018/01/money-love-relationships.jpg" alt="Avatar" class="image">
                            <div class="overlay">
                                <div class="text">Money Management</div>
                        </div>
                        </div>
                    <div class="container">
                            <img src="https://compass-ssl.xbox.com/assets/dc/48/dc486960-701e-421b-b145-70d04f3b85be.jpg?n=Game-Hub_Content-Placement-0_New-Releases-No-Copy_740x417_02.jpg" alt="Avatar" class="image">
                            <div class="overlay">
                                <div class="text">Game Engine</div>
                        </div>
                        </div>
                    <div class="container">
                            <img src="https://clipchamp.com/wp-content/uploads/2016/07/video-editors.jpeg" alt="Avatar" class="image">
                            <div class="overlay">
                                <div class="text">Video Editing Software</div>
                        </div>
                        </div>
              </div>
              <br>
              <br><br>
              <br>
              <div id="form" class="bg-contact2" style="background-image: url('mountain.jpg');">
                <div class="container-contact2">
                    <div class="wrap-contact2">
                        <form class="contact2-form validate-form" action="complaint" method="post">
                            <span class="contact2-form-title">
                                Your Complaint
                            </span>
                            
                            <label for="email">Email</label>
                            <div class="wrap-input2 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                                <input class="input2" type="text" id="email"name="email">
                            </div>
                            
                                <label for="app">Application Name</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid app name is required">
                                <select name="application" id="application" class="input2" required>
          
                                    </select>
                        
                                </div>
                                <label for="version">Version</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid version is required">
                                    <select name="version" id="version" class="input2" required>
          
                                    </select>
                                    
                                </div>
                                <label for="type">Type</label>
                                <div class="wrap-input2 validate-input" data-validate = "Valid complaint type is required">
                                <select name="type" id="type" class="input2 " required>
                                        <option value="Security">Security issues</option>
                                        <option value="UI">user interface issues</option>
                                        <option value="feature">feature issues</option>
                                </select>
                            </div>
                            <label for="message">Message</label>
                            <div class="wrap-input2 validate-input" data-validate = "Message is required">
                                <textarea class="input2" name="description"></textarea>
                            </div>
    
                            <div class="container-contact2-form-btn">
                                <div class="wrap-contact2-form-btn">
                                    <div class="contact2-form-bgbtn"></div>
                                    <button class="contact2-form-btn">
                                        Send Your Message
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>        
          <style>
          .downArrow{
	position: absolute;
	top: 70%;
	left: 48%;
}
.bounce {
	-moz-animation: bounce 3s infinite;
	-webkit-animation: bounce 3s infinite;
	animation: bounce 3s infinite;
}
@-moz-keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    -moz-transform: translateY(0);
    transform: translateY(0);
  }
  40% {
    -moz-transform: translateY(-30px);
    transform: translateY(-30px);
  }
  60% {
    -moz-transform: translateY(-15px);
    transform: translateY(-15px);
  }
}
@-webkit-keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    -webkit-transform: translateY(0);
    transform: translateY(0);
  }
  40% {
    -webkit-transform: translateY(-30px);
    transform: translateY(-30px);
  }
  60% {
    -webkit-transform: translateY(-15px);
    transform: translateY(-30px);
  }
}
@keyframes bounce {
  0%, 20%, 50%, 80%, 100% {
    -moz-transform: translateY(0);
    -ms-transform: translateY(0);
    -webkit-transform: translateY(0);
    transform: translateY(0);
  }
  40% {
    -moz-transform: translateY(-30px);
    -ms-transform: translateY(-30px);
    -webkit-transform: translateY(-30px);
    transform: translateY(-30px);
  }
  60% {
    -moz-transform: translateY(-15px);
    -ms-transform: translateY(-15px);
    -webkit-transform: translateY(-15px);
    transform: translateY(-15px);
  }
}
/* Demo Purpose Only*/
.demo {
  font-family: 'Raleway', sans-serif;
	color:#fff;
    display: block;
    margin: 0 auto;
    padding: 15px 0;
    text-align: center;
}
.demo a{
  font-family: 'Raleway', sans-serif;
color: #2ecc71;		
}
          </style>
<script>
  
        $("#email").on("blur", function() {
              
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