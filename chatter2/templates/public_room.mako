<%inherit file="base.mako"/>
  <input type="hidden" id="user_id" value="${user_data.get('_id')}">
  <div class="panel panel-default" style="border-radius:10px;width:700px;height:500px;margin-left:auto;margin-right:auto;margin-top:100px;-webkit-box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);-moz-box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);">
    <div class="panel-heading" style="padding:20px 15px;border-radius:10px 10px 0 0">
      <h3 class="panel-title">Public Room</h3>
    </div>
    <div class="panel-body" id="chatlog" style="height:380px;overflow:auto">
    </div>
    <div class="panel-footer" style="height:60px;margin-top:20px">
      <div class="col-lg-6" style="width:100%">
      <form id="chat_form">
        <div class="input-group">
          <input type="text" class="form-control" id="chatbox">
          <span class="input-group-btn">
            <button class="btn btn-default" type="submit" id='submit'>Send</button>
          </span>
        </div><!-- /input-group -->
        </form>
      </div><!-- /.col-lg-6 -->
    </div>
    <a id="writing"></a>


<div class="modal fade" id="myModal">
  <form class="form-horizontal" role="form" method="post">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title">Settings</h4>
        </div>
        <div class="modal-body">
          <input type="hidden" id="e_user_id" name="e_user_id" value="${user_data.get('_id')}">
          <div class="form-group">
            <label class="col-sm-3 control-label">User Name</label>
            <div class="col-sm-8">
              <p class="form-control-static">${user_data.get('username')}</p>
            </div>
          </div>
          <div class="form-group">
            <label for="inputPassword" class="col-sm-3 control-label">Nick Name</label>
            <div class="col-sm-8">
              <input type="text" class="form-control" id="e_nickname" name="e_nickname" value="${user_data.get('nickname')}" placeholder="Your Nick Name">
            </div>
          </div>
          <div class="form-group">
            <label for="inputPassword" class="col-sm-3 control-label">Text Color</label>
            <div class="col-sm-8">
              <select class="form-control" name="e_textcolor" id="e_textcolor">
                <option value="black" ${'selected' if user_data.get('textcolor') == 'black' else ''}>black</option>
                <option value="red" ${'selected' if user_data.get('textcolor') == 'red' else ''}>red</option>
                <option value="purple" ${'selected' if user_data.get('textcolor') == 'purple' else ''}>purple</option>
                <option value="blue" ${'selected' if user_data.get('textcolor') == 'blue' else ''}>blue</option>
                <option value="pink" ${'selected' if user_data.get('textcolor') == 'pink' else ''}>pink</option>
              </select>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary">Save changes</button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </form>
</div><!-- /.modal -->

<style>
  .red{
    color: #a94442;
    border-color: #ebccd1;
    background-color: #f2dede;
    max-width: 80%;
    word-wrap: break-word;
    padding: 7px;
    border: 1px solid transparent;
    border-radius: 4px;
    margin-bottom: 10px;
    display:inline-block;
  }

  .black{
    color: black;
    border-color: #ccc;
    background-color: #f5f5f5;
    max-width: 80%;
    word-wrap: break-word;
    padding: 7px;
    border: 1px solid transparent;
    border-radius: 4px;
    margin-bottom: 10px;
    display:inline-block;
  }

  .blue{
    color: #31708f;
    border-color: #bce8f1;
    background-color: #d9edf7;
    max-width: 80%;
    word-wrap: break-word;
    padding: 7px;
    border: 1px solid transparent;
    border-radius: 4px;
    margin-bottom: 10px;
    display:inline-block;
  }

  .purple{
    color: #9966cc;
    border-color: #a679d2;
    background-color: #d9c5ec;
    max-width: 80%;
    word-wrap: break-word;
    padding: 7px;
    border: 1px solid transparent;
    border-radius: 4px;
    margin-bottom: 10px;
    display:inline-block;
  }

  .pink{
    color: #fb607f;
    border-color: #fc7993;
    background-color: #fedde3;
    max-width: 80%;
    word-wrap: break-word;
    padding: 7px;
    border: 1px solid transparent;
    border-radius: 4px;
    margin-bottom: 10px;
    display:inline-block;
  }

  .avatar{
    height:52px;
    margin-right:20px;
    width:52px;
    margin-top:5px;
    float:left;
  }
</style>
