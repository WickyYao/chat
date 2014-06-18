<html>
  <head>
    <title>Chatter!</title>
    <script src="/static/jquery.js" type="text/javascript"></script>
    <script src="/static/socket.io.js" type="text/javascript"></script>
    <script src="/static/handlebars.js" type="text/javascript"></script>
    <script src="/static/underscore.js" type="text/javascript"></script>
    <script src="/static/backbone.js" type="text/javascript"></script>
    <script src="/static/chatter.js" type="text/javascript"></script>
    ##<link rel="stylesheet" type="text/css" href="/static/styles.css" />

    <script src="/static/lib/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/static/lib/bootstrap/css/bootstrap.min.css" />
    <style>
      body { 
        background: url('/static/img/bg_pic.jpg') no-repeat center center fixed; 
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
      }
    </style>
  </head>
  <body>
    <!-- Navbar
    ================================================== -->
    <nav class="navbar navbar-inverse" role="navigation" style="border-radius:0px;position:fixed;width: 100%;top: 0;">
      <div class="container-fluid" style="margin-left:10%;margin-right:2%">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <a class="navbar-brand" href="#">ChatChat</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-9">
          <ul class="nav navbar-nav">
            <li class="active"><a href="#">Home</a></li>
            <li><a href="#">Link</a></li>
            <li><a href="#">Link</a></li>
          </ul>
          <ul class="nav navbar-nav" style="float:right">
            <li><a href="#">Settings</a></li>
            <li><a href="/logout">Logout</a></li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
    </nav>
  <!-- nav end -->

  ${self.body()}

  </body>
</html>

