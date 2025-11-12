<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test_signal2.aspx.cs" Inherits="Student_test_signal2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>

    <style type="text/css">
        .signalD
        {
            float:left;
            margin:3% 0 3% 40%;
        }
        .signalB
        {
            float:right;
            margin:3% 40% 3% 0;
        }
        .signalC
        {
            clear:both;
        }
        .lbl_signal
        {
            border:1px solid black;
            width:35px;
        }
    </style>

    <script type="text/javascript">
        var timer = 5;
        var direction = 'clock';
        var cur_signal = 'signal1';
        var next_signal = 'signal2';
        var total_signal = 4;
        var stopTimer = false;

        $(document).ready(function () {
            $('.signal1 .timer').html(timer);
            $('.signal2 .timer').html(timer);
            $('.signal3 .timer').html(timer * 2);
            $('.signal4 .timer').html(timer * 3);

            $('.lbl_signal').css('background-color', 'red');
            $('.signal1 .lbl_signal').css('background-color', 'green');

            setSignals();

            $('#drp_direction').on('change', function () {
                stopTimer = true;
                $('.cls_btn').removeAttr('disabled');

                switch ($('#drp_direction').val()) {
                    case 'clock':
                        if (direction == 'anti_clock') {
                            $('.signalB').removeClass('signal4');
                            $('.signalD').removeClass('signal2');
                            $('.signalB').addClass('signal2');
                            $('.signalD').addClass('signal4');

                            set_clock_anticlock_viceversa();
                        }
                        else {
                            set_clock_anticlock_from_ltor_utod('clock');
                        }
                        break;
                    case 'anti_clock':
                        if (direction == 'clock') {
                            $('.signalB').removeClass('signal2');
                            $('.signalD').removeClass('signal4');
                            $('.signalB').addClass('signal4');
                            $('.signalD').addClass('signal2');

                            set_clock_anticlock_viceversa();
                        }
                        else {
                            set_clock_anticlock_from_ltor_utod('anti_clock');
                        }
                        break;
                    case 'ltor':
                        $('.signalA .cls_btn,.signalC .cls_btn').attr('disabled', 'disabled');
                        set_ltor_utod('ltor');
                        break;
                    case 'utod':
                        $('.signalB .cls_btn,.signalD .cls_btn').attr('disabled', 'disabled');
                        set_ltor_utod('utod');
                        break;
                }

                $('.lbl_signal').css('background-color', 'red');
                $('.' + cur_signal + ' .lbl_signal').css('background-color', 'green');
                direction = $('#drp_direction').val();
                stopTimer = false;
            });
        });

        function set_clock_anticlock_viceversa() {
            if (cur_signal != 'signal2' && cur_signal != 'signal4') {
                var temp = $('.signal2 .timer').html();
                $('.signal2 .timer').html($('.signal4 .timer').html());
                $('.signal4 .timer').html(temp);
            }
            else {
                var temp = $('.signal1 .timer').html();
                $('.signal1 .timer').html($('.signal3 .timer').html());
                $('.signal3 .timer').html(temp);
            }

            if (cur_signal == 'signal2') { cur_signal = 'signal4'; next_signal = 'signal1'; }
            else if (cur_signal == 'signal4') { cur_signal = 'signal2'; next_signal = 'signal3'; }
        }

        function set_clock_anticlock_from_ltor_utod(scase) {
            $('.signalA,.signalB,.signalC,.signalD').removeClass('signal1').removeClass('signal2').removeClass('signal3').removeClass('signal4');
            $('.signalA').addClass('signal1');
            $('.signalC').addClass('signal3');

            if (scase == 'clock') {
                $('.signalB').addClass('signal2');
                $('.signalD').addClass('signal4');
            }
            else if (scase == 'anti_clock') {
                $('.signalB').addClass('signal4');
                $('.signalD').addClass('signal2');
            }

            total_signal = 4;
            cur_signal = 'signal1';
            next_signal = 'signal2';

            $('.signal1 .timer').html(timer);
            $('.signal2 .timer').html(timer);
            $('.signal3 .timer').html(timer * 2);
            $('.signal4 .timer').html(timer * 3);
        }

        function set_ltor_utod(scase) {
            $('.signalA,.signalB,.signalC,.signalD').removeClass('signal1').removeClass('signal2').removeClass('signal3').removeClass('signal4');

            if (scase == 'ltor') {
                $('.signalB').addClass('signal2');
                $('.signalD').addClass('signal1');
            }
            else if (scase == 'utod') {
                $('.signalA').addClass('signal1');
                $('.signalC').addClass('signal2');
            }

            total_signal = 2;
            cur_signal = 'signal1';
            next_signal = 'signal2';

            $('.signal1 .timer').html(timer);
            $('.signal2 .timer').html(timer);
        }

        function setSignals() {
            setInterval(function () {
                if (!stopTimer) {
                    var obj_timer = {};

                    if ($('.' + cur_signal + ' .timer').html() == '0') {
                        cur_signal = next_signal;
                        var next = parseInt(next_signal.substr(6));
                        next_signal = (next == total_signal) ? 'signal1' : 'signal' + (next + 1);
                    }

                    for (var i = 1; i <= total_signal; i++) {
                        obj_timer['signal' + i] = parseInt($('.signal' + i + ' .timer').html()) - 1;

                        var temp_next = (i == total_signal) ? 'signal1' : 'signal' + (i + 1);

                        if (obj_timer['signal' + i] == -1 && cur_signal == temp_next) {
                            obj_timer['signal' + i] = (timer * (total_signal - 1)) - 1;
                            $('.signal' + i + ' .lbl_signal').css('background-color', 'red');
                        }
                        else if (obj_timer['signal' + i] == -1 && cur_signal == 'signal' + i) {
                            obj_timer['signal' + i] = timer - 1;
                            $('.signal' + i + ' .lbl_signal').css('background-color', 'green');
                        }

                        $('.signal' + i + ' .timer').html(obj_timer['signal' + i]);
                    } 
                }
            }, 1000);
        }

        function btn_signal_click(cur_btn) {
            stopTimer = true;

            var signal = $(cur_btn).parent().parent()[0].classList[1];

            cur_signal = signal;
            var next = parseInt(signal.substr(6));
            next_signal = (next == total_signal) ? 'signal1' : 'signal' + (next + 1);

            $('.' + cur_signal + ' .timer,.' + next_signal + ' .timer').html(timer);

            if (total_signal == 4) {
                next = (next == total_signal) ? 1 : (next + 1);
                next = (next == total_signal) ? 1 : (next + 1);
                $('.signal' + next + ' .timer').html(timer * 2);

                next = (next == total_signal) ? 1 : (next + 1);
                $('.signal' + next + ' .timer').html(timer * 3);
            }

            $('.lbl_signal').css('background-color', 'red');
            $('.' + cur_signal + ' .lbl_signal').css('background-color', 'green');
            stopTimer = false;
        }

        function setNewTimeInterval() {
            stopTimer = true;

            if ($('#txt_timer').val() != '') {
                timer = parseInt($('#txt_timer').val());

                if (total_signal == 4) {
                    var next = parseInt(next_signal.substr(6));

                    next = (next == total_signal) ? 1 : (next + 1);
                    $('.signal' + next + ' .timer').html(timer + parseInt($('.' + cur_signal + ' .timer').html()));

                    next = (next == total_signal) ? 1 : (next + 1);
                    $('.signal' + next + ' .timer').html((timer * 2) + parseInt($('.' + cur_signal + ' .timer').html()));
                }
            }

            stopTimer = false;
        }
    </script>
</head>
<body>
    <div id="div_signal">
        <div class="signalA signal1" align="center">
            <div class="btn_signal">
                <input type="button" class="cls_btn" value="AA" onclick="btn_signal_click(this)" />
            </div>
            <div class="lbl_signal">A</div>
            <div class="timer"></div>
        </div>

        <div align="center">
            <div class="signalD signal4">
                <div class="btn_signal">
                    <input type="button" class="cls_btn" value="AD" onclick="btn_signal_click(this)" />
                </div>
                <div class="lbl_signal">D</div>
                <div class="timer"></div>
            </div>
            
            <div class="signalB signal2">
                <div class="btn_signal">
                    <input type="button" class="cls_btn" value="AB" onclick="btn_signal_click(this)" />
                </div>
                <div class="lbl_signal">B</div>
                <div class="timer"></div>
            </div>
        </div>

        <div class="signalC signal3" align="center">
            <div class="btn_signal">
                <input type="button" class="cls_btn" value="AC" onclick="btn_signal_click(this)" />
            </div>
            <div class="lbl_signal">C</div>
            <div class="timer"></div>
        </div>
    </div>

    <div style="margin-left: 20px;">
        <span>Direction : </span>
        <select id="drp_direction">
            <option value="clock">Clock</option>
            <option value="anti_clock">Anti Clock</option>
            <option value="ltor">Left to Right</option>
            <option value="utod">Up to Down</option>
        </select>
    </div>

    <div style="margin-left: 20px;">
        <span>Timer : </span>
        <input type="text" id="txt_timer" style="margin-top:10px;" />
        <input type="button" id="btn_timer" value="Set" onclick="setNewTimeInterval()" />
    </div>
</body>
</html>
