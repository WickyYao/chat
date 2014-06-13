<%inherit file="base.mako"/>
##<div style="height:400px;width:200px;margin:150px auto;border-radius:10px;background-color:white;">
<div style="height:400px;width:200px;margin:150px auto auto auto;">
  <button type="button" onclick="signup()" onmouseover="this.style.backgroundColor='#ff5f00'" onmouseout="this.style.backgroundColor='#ff9f00'" class="btn btn-primary btn-lg btn-block" style="border-color:#e65600;margin-bottom:20px;width:200px;background-color:#ff9f00">
    Signup
  </button>
  <input type="email" id="username" class="form-control input-lg" onkeyup="change_username(this)" placeholder="Enter username">
  <input type="password" id="password" class="form-control input-lg" onkeyup="change_password(this)" placeholder="Enter password" style="margin-top:20px">
  <button type="button" onclick="login()" class="btn btn-primary btn-lg btn-block" style="margin-top:20px;width:200px">
    Login
  </button>

<script>
  function username_popover(content){
    $('#username').data('bs.popover').options.content = content;
    $('#username').popover('show')
  };

  function password_popover(content){
    $('#password').data('bs.popover').options.content = content;
    $('#password').popover('show')
  };

  function change_username(dom){
    if (dom.value != ''){
      $('#username').popover('hide')
    }
    else{
      $('#username').data('bs.popover').options.content = 'user name is empty';
      $('#username').popover('show')
    }
  }

  function change_password(dom){
    if (dom.value != ''){
      $('#password').popover('hide')
    }
    else{
      $('#password').data('bs.popover').options.content = 'password is empty';
      $('#password').popover('show')
    }
  }

  function signup(){
    username = $('#username').val()
    password = $('#password').val()
    if (!username){
      username_popover('username is empty')
    }

    if (!password){
      password_popover('password is empty')
    }
    else if (password.length<=5){
      password_popover('at least 6 digits')
      return
    }

    if (!username | !password){
      return
    }

    $.ajax({
        type: "POST",
        url: "/login",
        cache: true,
        data: {
            ajax: 1,
            signup: 1,
            username: username,
            password: password,
        },
    }).done(function (data) {
         if (data==false){
           username_popover('username has existed')
         }
         else{
           window.location.href = "/";
         }
       })
  }

  function login(){
    username = $('#username').val()
    password = $('#password').val()
    if (!username){
      username_popover('username is empty')
    }

    if (!password){
      password_popover('password is empty')
    }

    if (!username | !password){
      return
    }

    $.ajax({
        type: "POST",
        url: "/login",
        cache: true,
        data: {
            ajax: 1,
            login: 1,
            username: username,
            password: password,
        },
    }).done(function (data) {
         if (data==false){
           username_popover('user name or password is not correct')
         }
         else{
           window.location.href = "/";
         }
       })

  }

$(function ()  
{
  $('#username').popover(
  {
     trigger: 'hover',
     html: true,
     placement: 'right',
     trigger: 'manual',
  });

  $('#password').popover(
  {
     trigger: 'hover',
     html: true,
     placement: 'right',
     trigger: 'manual',
  });
});
</script>

<style>
  .popover {
    border-color: #ff063e;
    background-color: #ff2052;
    color:white;
  }
  
  .popover.right>.arrow:after{
    border-right-color: #ff2052;
  }
  
  .popover.right>.arrow{
    border-right-color: #ff063e;
  }
</style>
