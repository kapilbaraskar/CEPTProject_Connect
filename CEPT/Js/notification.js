

$(document).ready(function () {


    // var username = $('#hdnuserid').val();
    // alert($('#ctl00_hdnuserid').val());

    var user_id = $('#ctl00_hdnuserid').val();

    $.ajax({
        type: "POST",
        url: "WebService.asmx/Get_notification_data",
        data: "{ user_id : '" + user_id + "'}",
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {
            var listItems = "";
            if (data.d != "") {
                var Result = JSON.parse(data.d);

                $('#notfinumber').html(Result.length);


                for (var i = 0; i < Result.length; i++) {

                    var page = Result[i]["NotificationGenerateForm"];
                    var link = page + '?id=' + Result[i]["Document_Number"];

                    listItems += " <li id='" + Result[i]["Document_Number"] + "'><a href= '" + link + "'> <div class='clearfix'><span class='pull-left'><i class='btn btn-mini no-hover btn-pink icon-comment'></i>'" + Result[i]["NotificationDetails"] + "'</span><span id='" + Result[i]["Document_number"] + "' class='pull-right badge badge-info'></span></div></a></li> ";

                }

                $('#notification').append(listItems);
            }
            else {

                $('#notfinumber').html('0');
            }



        },
        error: function (msg) { alert(msg.d); }
    });

});



