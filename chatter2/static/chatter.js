$(document).ready(function() {
    WEB_SOCKET_SWF_LOCATION = "/static/WebSocketMain.swf";
    WEB_SOCKET_DEBUG = true;

    // connect to the websocket
    var socket = io.connect('/chat');

    $(window).bind("beforeunload", function() {
        socket.disconnect();
    });

    // Listen for the event "chat" and add the content to the log
    socket.on("chat", function(time, msg) {
        $("#chatlog").append(time + ' - ' + msg + "<br />");
        $("#chatlog").stop().animate({scrollTop:$("#chatlog")[0].scrollHeight},1000)
    });

    socket.on("user_disconnect", function() {
        $("#chatlog").append("user disconnected" + "<br />");
    });

    socket.on("user_connect", function(chat_list) {
        $("#chatlog").append("user connected" + "<br />");
        for (i=0;i<chat_list.length;i++){
            $("#chatlog").append(chat_list[i].time + ' - ' + chat_list[i].msg + "<br />");
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

        // send out the "chat" event with the textbox as the only argument
        if (val){
            socket.emit("chat", val);

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
