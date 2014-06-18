<%inherit file="base.mako"/>
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
  <div class="panel panel-default" style="border-radius:10px;width:700px;height:500px;margin-left:auto;margin-right:auto;margin-top:100px;-webkit-box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);-moz-box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);box-shadow: 0px 0px 22px 1px rgba(0,0,0,0.77);">
    <div class="panel-heading" style="border-radius:10px 10px 0 0">
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

<style>
  .red-color{
    max-width: 90%;
    word-wrap: break-word;
    background-color: #f2dede;
    border-color: #ebccd1;
    color: #a94442;
    padding: 7px;
    border: 1px solid transparent;
    border-radius: 4px;
    margin-bottom: 10px;
    display:inline-block;
  }
</style>
