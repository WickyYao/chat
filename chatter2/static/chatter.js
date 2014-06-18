$(document).ready(function() {
    WEB_SOCKET_SWF_LOCATION = "/static/WebSocketMain.swf";
    WEB_SOCKET_DEBUG = true;

    // connect to the websocket
    var socket = io.connect('/chat');

    $(window).bind("beforeunload", function() {
        socket.disconnect();
    });

    // Listen for the event "chat" and add the content to the log
    socket.on("chat", function(time, msg, nickname, textcolor) {
        $("#chatlog").append("<a style='color:" + textcolor + "'>" + nickname + ' - ' + time + ' - ' + msg + "</a>" + "<br />");
        $("#chatlog").stop().animate({scrollTop:$("#chatlog")[0].scrollHeight},1000)
    });

    socket.on("user_disconnect", function() {
        $("#chatlog").append("user disconnected" + "<br />");
    });

    socket.on("user_connect", function(chat_list) {
        $("#chatlog").append("user connected" + "<br />");
        for (i=0;i<chat_list.length;i++){
            //$("#chatlog").append("<a style='color:" + chat_list[i].textcolor + "'>" + chat_list[i].nickname + ' - ' + chat_list[i].time + ' - ' + chat_list[i].msg + "</a>" + "<br />");
            $("#chatlog").append("<div class='red-color'>" + chat_list[i].nickname + ' - ' + chat_list[i].time + ' - ' + chat_list[i].msg + "</div>" + "<br />");
        }
        $("#chatlog").stop().animate({scrollTop:$("#chatlog")[0].scrollHeight},1000)
    });

    socket.on("writing", function(val) {
        if (val){
            document.getElementById('writing').innerHTML = 'Writing... '+val
        }
        else{
            document.getElementById('writing').innerHTML = ''
        }
    });

    // Execute whenever the form is submitted
    $("#chat_form").submit(function(e) {
        // don't allow the form to submit
        e.preventDefault();

        var val = $("#chatbox").val();
        var user_id = $("#user_id").val()

        // send out the "chat" event with the textbox as the only argument
        if (val){
            socket.emit("chat", val, user_id);

            $("#chatbox").val("");
            socket.emit('writing', '')
        }
        else{
            alert('ITS EMPETY!!!!!')
        }
    });

    $("#join").click(function(e) {
      socket.emit('join', 'test')
    })


    $("#chatbox").keyup(function() {
        var val = $("#chatbox").val();
        socket.emit('writing', val)
    })
});

function validate_form(prefix) {
    var username = document.getElementById(prefix+'_username').value
    var password = document.getElementById(prefix+'_password').value
  
    if (username == null || username == "") {
        alert("user name must be filled out");
        return false;
    }

    if (password == null || password == "") {
        alert("password must be filled out");
        return false;
    }
}
