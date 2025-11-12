<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test_signal.aspx.cs" Inherits="Student_test_signal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>

    <style type="text/css">
        .div_back
        {
            width: 1000px;
            height: 600px;
            background-color: Black;
            border: 1px solid black;
        }
        
        .div_top
        {
            width: 470px;
            height: 270px;
            background-color: White;
        }
        
        #div_top_left
        {
            float: left;
        }
        #div_top_right
        {
            float: right;
        }
        #div_bottom_left
        {
            margin-top: 60px;
            float: left;
        }
        #div_bottom_right
        {
            margin-top: 60px;
            float: right;
        }
        
        #div_top_left_signal
        {
            margin-top: 180px;
            margin-left: 50px;
        }
        #div_top_right_signal
        {
            margin-top: 20px;
            margin-left: 20px;
        }
        #div_bottom_left_signal
        {
            margin-top: 180px;
            margin-left: 400px;
        }
        #div_bottom_right_signal
        {
            margin-top: 10px;
            margin-left: 350px;
        }
        
        .red, .yellow, .green
        {
            width: 18px;
            height: 18px;
            border: 1px solid Black;
            margin-top: 2px;
            border-radius: 10px;
        }
    </style>

    <script type="text/javascript">
        var timeInterval = 5;
        var blinkTime = 1;
        var open_signal = 'top_left';

        $(document).ready(function () {
            $('#div_top_left .timer').html(timeInterval);
            $('#div_top_right .timer').html(timeInterval);
            $('#div_bottom_right .timer').html(timeInterval * 2);
            $('#div_bottom_left .timer').html(timeInterval * 3);

            $('#div_top_left .green').css('background-color', 'green');
            $('#div_top_right .red').css('background-color', 'red');
            $('#div_bottom_right .red').css('background-color', 'red');
            $('#div_bottom_left .red').css('background-color', 'red');

            setInterval(function () {
                manageSignals();
            }, 1000);
        });

        function manageSignals() {
            var top_left_time = parseInt($('#div_top_left .timer').html()) - 1;
            var top_right_time = parseInt($('#div_top_right .timer').html()) - 1;
            var bottom_left_time = parseInt($('#div_bottom_left .timer').html()) - 1;
            var bottom_right_time = parseInt($('#div_bottom_right .timer').html()) - 1;

            if (top_left_time == -1 && open_signal == 'top_left') open_signal = 'top_right';
            else if (top_right_time == -1 && open_signal == 'top_right') open_signal = 'bottom_right';
            else if (bottom_right_time == -1 && open_signal == 'bottom_right') open_signal = 'bottom_left';
            else if (bottom_left_time == -1 && open_signal == 'bottom_left') open_signal = 'top_left';

            if (top_left_time == -1) {
                if (open_signal == 'top_right') {
                    top_left_time = (timeInterval * 3) - 1;
                    $('#div_top_left .red').css('background-color', 'red');
                    $('#div_top_left .yellow').css('background-color', 'white');
                    $('#div_top_left .green').css('background-color', 'white');
                }
                else if (open_signal == 'top_left') {
                    top_left_time = timeInterval - 1;
                    $('#div_top_left .red').css('background-color', 'white');
                    $('#div_top_left .yellow').css('background-color', 'white');
                    $('#div_top_left .green').css('background-color', 'green');
                }
            }

            if (top_right_time == -1) {
                if (open_signal == 'bottom_right') {
                    top_right_time = (timeInterval * 3) - 1;
                    $('#div_top_right .red').css('background-color', 'red');
                    $('#div_top_right .yellow').css('background-color', 'white');
                    $('#div_top_right .green').css('background-color', 'white');
                }
                else if (open_signal == 'top_right') {
                    top_right_time = timeInterval - 1;
                    $('#div_top_right .red').css('background-color', 'white');
                    $('#div_top_right .yellow').css('background-color', 'white');
                    $('#div_top_right .green').css('background-color', 'green');
                }
            }

            if (bottom_right_time == -1) {
                if (open_signal == 'bottom_left') {
                    bottom_right_time = (timeInterval * 3) - 1;
                    $('#div_bottom_right .red').css('background-color', 'red');
                    $('#div_bottom_right .yellow').css('background-color', 'white');
                    $('#div_bottom_right .green').css('background-color', 'white');
                }
                else if (open_signal == 'bottom_right') {
                    bottom_right_time = timeInterval - 1;
                    $('#div_bottom_right .red').css('background-color', 'white');
                    $('#div_bottom_right .yellow').css('background-color', 'white');
                    $('#div_bottom_right .green').css('background-color', 'green');
                }
            }

            if (bottom_left_time == -1) {
                if (open_signal == 'top_left') {
                    bottom_left_time = (timeInterval * 3) - 1;
                    $('#div_bottom_left .red').css('background-color', 'red');
                    $('#div_bottom_left .yellow').css('background-color', 'white');
                    $('#div_bottom_left .green').css('background-color', 'white');
                }
                else if (open_signal == 'bottom_left') {
                    bottom_left_time = timeInterval - 1;
                    $('#div_bottom_left .red').css('background-color', 'white');
                    $('#div_bottom_left .yellow').css('background-color', 'white');
                    $('#div_bottom_left .green').css('background-color', 'green');
                }
            }

            if (top_left_time == blinkTime && open_signal == 'top_left') {
                $('#div_top_left .yellow').css('background-color', 'yellow');
                $('#div_top_left .green').css('background-color', 'white');
            }
            if (top_right_time == blinkTime && open_signal == 'top_right') {
                $('#div_top_right .yellow').css('background-color', 'yellow');
                $('#div_top_right .green').css('background-color', 'white');
            }
            if (bottom_left_time == blinkTime && open_signal == 'bottom_left') {
                $('#div_bottom_left .yellow').css('background-color', 'yellow');
                $('#div_bottom_left .green').css('background-color', 'white');
            }
            if (bottom_right_time == blinkTime && open_signal == 'bottom_right') {
                $('#div_bottom_right .yellow').css('background-color', 'yellow');
                $('#div_bottom_right .green').css('background-color', 'white');
            }

            $('#div_top_left .timer').html(top_left_time);
            $('#div_top_right .timer').html(top_right_time);
            $('#div_bottom_left .timer').html(bottom_left_time);
            $('#div_bottom_right .timer').html(bottom_right_time);
        }
    </script>
</head>
<body>
    <div class="div_back">
        <div id="div_top_left" class="div_top">
            <div id="div_top_left_signal">
                <div class="timer"></div>
                <div class="red"></div>
                <div class="yellow"></div>
                <div class="green"></div>
            </div>
        </div>

        <div id="div_top_right" class="div_top">
            <div id="div_top_right_signal">
                <div class="timer"></div>
                <div class="red"></div>
                <div class="yellow"></div>
                <div class="green"></div>
            </div>
        </div>

        <div id="div_bottom_left" class="div_top">
            <div id="div_bottom_left_signal">
                <div class="timer"></div>
                <div class="red"></div>
                <div class="yellow"></div>
                <div class="green"></div>
            </div>
        </div>

        <div id="div_bottom_right" class="div_top">
            <div id="div_bottom_right_signal">
                <div class="timer"></div>
                <div class="red"></div>
                <div class="yellow"></div>
                <div class="green"></div>
            </div>
        </div>
    </div>
</body>
</html>
