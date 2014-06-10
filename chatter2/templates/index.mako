<html>
  <head>
    <title>Chatter!</title>
    <script src="/static/jquery.js" type="text/javascript"></script>
    <script src="/static/socket.io.js" type="text/javascript"></script>
    <script src="/static/handlebars.js" type="text/javascript"></script>
    <script src="/static/underscore.js" type="text/javascript"></script>
    <script src="/static/backbone.js" type="text/javascript"></script>
    <script src="/static/chatter.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/static/styles.css" />

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
    <nav class="navbar navbar-inverse" role="navigation" style="border-radius:0px">
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
  <input type="hidden" id="user_id" value="${user_data.get('_id')}">
  %if login_flag:
    <form id="user_data_form" method="post">
      <div style="float:right;width:250px;background-color:white">
          <a href="/logout">logout</a>
          <input type="hidden" id="e_user_id" name="e_user_id" value="${user_data.get('_id')}">
          <p>username: ${user_data.get('username')}</p>
          <p>nickname: <input type="text" name="e_nickname" id ="e_nickname" value="${user_data.get('nickname')}" style="width:150px"></p>
          <p>text color:
              <select id="e_textcolor" name="e_textcolor">
                  <option value="#d42b55" ${'selected' if user_data.get('textcolor') == '#d42b55' else ''}>red</option>
                  <option value="#9873da" ${'selected' if user_data.get('textcolor') == '#9873da' else ''}>purple</option>
                  <option value="#0fa9f0" ${'selected' if user_data.get('textcolor') == '#0fa9f0' else ''}>blue</option>
                  <option value="#000000" ${'selected' if user_data.get('textcolor') == '#000000' else ''}>black</option>
              </select>
          </p>
          <button type="submit" id="submit">Save</button>
      </div>
    </form>
  %endif
  <div class="panel panel-default" style="border-radius:10px;width:700px;height:80%;margin-left:auto;margin-right:auto;-webkit-box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);
-moz-box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);
box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);">
    <div class="panel-heading" style="border-radius:10px 10px 0 0">
      <h3 class="panel-title">Chat Box</h3>
    </div>
    <div class="panel-body" id="chatlog" style="height:80%">
    </div>
    %if login_flag:
        <form id="chat_form">
          <input type="text" id="chatbox"></input>
          <button type="submit" id="submit">Send</button>
        </form>
    %else:
        <form id="login_form" method="post" onsubmit="return validate_form('l')">
          <a style="margin-right:10px">login:</a>
          <input type="text" id="l_username" name='l_username' placeholder="user name">
          <input type="password" id="l_password" name='l_password' placeholder="password">
          <button type="submit">login</button>
          <br>
          <a>or <a id='signup' href="javascript:void(0)" onclick="document.getElementById('login_form').style.display='none';document.getElementById('signup_form').style.display='';">signup</a></a>
        </form>
    %endif
        <form id="signup_form" method="post" style="display:none" onsubmit="return validate_form('s')">
          <a style="margin-right:10px">signup:</a>
          <input type="text" id="s_username" name='s_username' placeholder="user name">
          <input type="password" id="s_password" name='s_password' placeholder="password">
          <button type="submit">signup</button>
          <br>
          <a>or <a id='login' href="javascript:void(0)" onclick="document.getElementById('signup_form').style.display='none';document.getElementById('login_form').style.display='';">login</a></a>
        </form>
    <a id="writing"></a>
  </div>
  </body>
</html>

