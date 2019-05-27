<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Application form</title>
</head>
<body>
        <h5 class="w3-center w3-text w3-white w3-wide">COMPLAINT MANAGEMENT</h5>
    <form action="addapplication" method="post">
        <h3>Create an entry for an application</h3>
          <br>
          <div class="w3-half">
                  <label>Application</label>
                  <input type="text" name="name" id="name">
          </div>
          <br>
          <div class="w3-half">
                  <label>Version</label>
                  <input type="text" name="version" id="version">
          </div>
          <br>
          <div class="w3-half">
            <label>Description</label>
            <input type="text" name="description" id="description">
    </div>
          <br>
          <input type="submit" value="submit" class="w3-button w3-dark-grey">
      </form>
      
</body>
</html>