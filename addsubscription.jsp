<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Add Subscription</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css"></link>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<link rel="stylesheet" type="text/css" href="util.css">
	<link rel="stylesheet" type="text/css" href="main.css">
<style>
body,h1,h2,h3,h4,h5,h6 {font-family: "Times New Roman", Arial, Helvetica, sans-serif}
.myLink {display: none}
</style>
</head>
<body>
        <h5 class="w3-center w3-text w3-white w3-wide">COMPLAINT MANAGEMENT</h5>
    <div id="form" class="bg-contact2" style="background-image: url('mountain.jpg');">
        <div class="container-contact2">
            <div class="wrap-contact2">
                <form class="contact2-form validate-form" action="addsubscription" method="post">
                    <span class="contact2-form-title">
                        Sign In
                    </span>

                    <label for="name">Name</label>
                    <div class="wrap-input2 validate-input" data-validate="Name is required">
                        <input class="input2" type="text" name="name">
                    </div>
                    <label for="email">Email</label>
                    <div class="wrap-input2 validate-input" data-validate = "Valid email is required: ex@abc.xyz">
                        <input class="input2" type="text" id="email"name="email">
                    </div>
                    <label for="Phone">Phone</label>
                    <div class="wrap-input2 validate-input" data-validate = "Valid phone number is required">
                            <input class="input2" type="number" name="phone">    
                    </div>
                    <label for="dob">Date of Birth</label>
                    <div class="wrap-input2 validate-input" data-validate = "Valid dob is required">
                            <input class="input2" type="date" name="dob">
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
                        <label for="app">Application Name</label>
                        <div class="wrap-input2 validate-input" data-validate = "Valid app name is required">
                        <select name="appname" id="appname" class="input2" required>
                            <option value="Book Shelf">Book Shelf</option>
                            </select>
                
                        </div>

                    <div class="container-contact2-form-btn">
                        <div class="wrap-contact2-form-btn">
                            <div class="contact2-form-bgbtn"></div>
                            <button class="contact2-form-btn">
                                Sign In
                            </button>
                        </div>
                    </div>
                </form>
</body>
</html>