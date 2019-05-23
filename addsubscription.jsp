<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Add subscription</title>
</head>
<body>
    <form action="addsubscription" method="post">
        <h3>Create an entry for an application</h3>
          <br>
          <div class="w3-half">
                  <label>Application</label>
                  <input type="text" name="appname" id="appname">
          </div>
          <br>
          <div class="w3-half">
            <label>Email</label>
            <input type="text" name="email" id="email">
            </div>
            <br>
          <input type="submit" value="submit" class="w3-button w3-dark-grey">
      </form>
</body>
</html>