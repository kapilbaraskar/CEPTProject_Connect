<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test_signal_dynamic.aspx.cs" Inherits="Student_test_signal_dynamic" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>

    <style type="text/css">
        .red, .yellow, .green
        {
            width: 18px;
            height: 18px;
            border: 1px solid Black;
            margin-top: 2px;
            border-radius: 10px;
        }
        
        .float_left
        {
            float: left;
            margin-left: 20px;
        }
        
        .div_separate
        {
            width:100%;
            margin:20px;
            border:1px solid black;
        }
    </style>

    <script type="text/javascript">
        var timeInterval = 5;
        var blinkTime = 1;
        var open_signal = 'signal1';
        var total_signal = 4;

        $(document).ready(function () {
            for (var i = 1; i <= total_signal; i++) {
                var timer = (i == 1) ? timeInterval : (timeInterval * (i - 1));

                var str_html = '<div id="signal' + i + '">' +
                               '<span class="float_left">Signal ' + i + ' : </span>' +
                               '<div class="red float_left"></div>' +
                               '<div class="yellow float_left"></div>' +
                               '<div class="green float_left"></div>' +
                               '<div class="timer float_left">' + timer + '</div>' +
                               '<div style="clear: both;"></div>' +
                               '</div><div class="div_separate"></div>';

                $('.div_demo').append(str_html);
            }

            $('.div_demo .green').eq(0).css('background-color', 'green');
            $('.div_demo .red').css('background-color', 'red');
            $('.div_demo .red').eq(0).css('background-color', 'white');

            setInterval(manageSignals, 1000);
        });

        function manageSignals() {
            var obj_timer = {};

            var temp_i = parseInt(open_signal.substr(6));
            if ($('#' + open_signal + ' .timer').html() == '0')
                open_signal = (temp_i == total_signal) ? 'signal1' : 'signal' + (temp_i + 1);

            for (var i = 1; i <= total_signal; i++) {
                var next_signal = (i == total_signal) ? 'signal1' : 'signal' + (i + 1);

                obj_timer['signal' + i] = parseInt($('#signal' + i + ' .timer').html()) - 1;

                if (obj_timer['signal' + i] == -1 && open_signal == next_signal && total_signal!=1) {
                    obj_timer['signal' + i] = (timeInterval * (total_signal - 1)) - 1;

                    $('#signal' + i + ' .red').css('background-color', 'red');
                    $('#signal' + i + ' .yellow').css('background-color', 'white');
                }
                else if (obj_timer['signal' + i] == -1 && open_signal == 'signal' + i) {
                    obj_timer['signal' + i] = (timeInterval - 1);

                    $('#signal' + i + ' .red').css('background-color', 'white');
                    $('#signal' + i + ' .yellow').css('background-color', 'white');
                    $('#signal' + i + ' .green').css('background-color', 'green');
                }
                else if (obj_timer['signal' + i] == blinkTime && open_signal == 'signal' + i) {
                    $('#signal' + i + ' .yellow').css('background-color', 'yellow');
                    $('#signal' + i + ' .green').css('background-color', 'white');
                }

                $('#signal' + i + ' .timer').html(obj_timer['signal' + i]);
            }
        }
    </script>
</head>
<body>
    <div class="div_demo">
        <div class="div_separate"></div>
    </div>
</body>
</html>
