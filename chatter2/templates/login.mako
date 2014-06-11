<%inherit file="base.mako"/>
##<div style="height:400px;width:200px;margin:150px auto;border-radius:10px;background-color:white;">
<div style="height:400px;width:200px;margin:150px auto auto auto;">
  <button type="button" onmouseover="this.style.backgroundColor='#ff5f00'" onmouseout="this.style.backgroundColor='#ff9f00'" class="btn btn-primary btn-lg btn-block" style="border-color:#e65600;margin-bottom:20px;width:200px;background-color:#ff9f00">
    Signup
  </button>
  <input type="email" id="l_username" class="form-control input-lg" placeholder="Enter username">
  <input type="password" id="l_password" class="form-control input-lg" placeholder="Enter password" style="margin-top:20px">
  <button type="button" class="btn btn-primary btn-lg btn-block" style="margin-top:20px;width:200px">
    Login
  </button>
  ##<h4 style="color:#ff6633">
  ##  Don't have an account?
  ##  <span class="glyphicon glyphicon-circle-arrow-right" style=";float:right;margin-left:10px"></span>
  ##  <span class="label label-default" style="background-color:#ff6633;float:right">Signup</span>
  ##</h4>

  ##<div style="margin:30px auto;text-align:center;font-weight:bold;color:#ff9f00">OR</div>
  ##<div class="circle" onclick="';">
  ##  Signup!
  ##</div>
</div>

<style>
.circle
{
width: 100px;
height: 100px;
margin:auto;
background-color: #ff9f00;
border-radius: 50%;
padding: 5px;
text-align: center;
line-height: 90px;
color: white;
font-family: arial, serif;
font-size: 20px;
cursor:pointer;
}

.circle:hover
{
background-color: #ff5f00;
}
</style>
