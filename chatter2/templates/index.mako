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
  </head>
  <body>
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

  <div id="container">
    <h1>Chat with you!</h1>
    <div id="chatlog"></div><br />
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
