<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test_calendar.aspx.cs" Inherits="Student_test_calendar" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>
    <%--<script src="../Scripts/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../Scripts/jquery.validate.unobtrusive.min.js" type="text/javascript"></script>--%>

    <style type="text/css">
        body
        {
            margin-top: 20px;
        }
        table thead th, table tbody td
        {
            border: 1px solid black;
            width: 25px;
            text-align: center;
        }
        #th_select, #drp_month, #drp_year
        {
            height: 25px;
            margin-bottom: 0 !important;
        }
        #drp_month
        {
            width: 31% !important;
            padding-top: 2px;
        }
        #drp_year
        {
            width: 35% !important;
            padding-top: 2px;
        }
    </style>

    <script type="text/javascript">
        var obj_month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var mon_start_date;

        $(document).ready(function () {
            $('#btn_prev').on('click', function () {
                mon_start_date.setMonth(mon_start_date.getMonth() - 1);
                createCalendar(mon_start_date);
            });

            $('#btn_next').on('click', function () {
                mon_start_date.setMonth(mon_start_date.getMonth() + 1);
                createCalendar(mon_start_date);
            });

            $('#th_month_year').on('click', function () {
                $('#drp_month').val(mon_start_date.getMonth());
                $('#drp_year').val(mon_start_date.getFullYear());
                $('#tbl_calendar thead tr:first-child').css('display', 'none');
                $('#tbl_calendar thead tr:nth-child(2)').css('display', '');
            });

            $('#btn_select').on('click', function () {
                $('#tbl_calendar thead tr:first-child').css('display', '');
                $('#tbl_calendar thead tr:nth-child(2)').css('display', 'none');
                createCalendar(new Date((parseInt($('#drp_month').val()) + 1) + '/01/' + $('#drp_year').val()));
            });

            for (var i = 0; i < 12; i++) {
                $('#drp_month').append("<option value='" + i + "'>" + obj_month[i] + "</option>");
            }

            for (var i = 1950; i <= 2050; i++) {
                $('#drp_year').append("<option value='" + i + "'>" + i + "</option>");
            }

            createCalendar(new Date());
        });

        function createCalendar(ddate) {
            $('#tbl_calendar tbody tr td').html('');
            $('#tbl_calendar tbody tr td').css('color', 'black');

            var obj_month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
            if ((ddate.getFullYear() % 4) == 0) obj_month_days[1] = 29;

            var today_date = new Date();

            mon_start_date = ddate;
            mon_start_date.setDate(mon_start_date.getDate() - (mon_start_date.getDate() - 1));

            var mon_start_day = mon_start_date.getDay();
            var cur_month = mon_start_date.getMonth();

            $('#th_month_year').html(obj_month[cur_month] + ' - ' + mon_start_date.getFullYear());

            var temp_date = 0;
            var is_cur_mon = false;
            for (var i = 0; i < 6; i++) {
                for (var j = 0; j < 7; j++) {
                    if (i == 0) {
                        if (j >= mon_start_day) {
                            $('#tbl_calendar tbody tr').eq(i).children()[j].innerHTML = ++temp_date;
                            is_cur_mon = true;
                        }
                        else {
                            if (cur_month == 0)
                                $('#tbl_calendar tbody tr').eq(i).children()[j].innerHTML = (obj_month_days[11] - mon_start_day) + (j + 1);
                            else
                                $('#tbl_calendar tbody tr').eq(i).children()[j].innerHTML = (obj_month_days[cur_month - 1] - mon_start_day) + (j + 1);

                            $('#tbl_calendar tbody tr').eq(i).children()[j].style.color = 'grey';
                            is_cur_mon = false;
                        }
                    }
                    else {
                        if (temp_date == obj_month_days[cur_month]) {
                            temp_date = 0;
                            is_cur_mon = false;
                        }

                        $('#tbl_calendar tbody tr').eq(i).children()[j].innerHTML = ++temp_date;

                        if (!is_cur_mon) {
                            $('#tbl_calendar tbody tr').eq(i).children()[j].style.color = 'grey';
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="container">
    <div>
        <table id="tbl_calendar">
            <thead>
                <tr>
                    <th>
                        <input type="button" id="btn_prev" value="<" />
                    </th>
                    <th id="th_month_year" style="cursor: pointer;" colspan="5">
                    </th>
                    <th>
                        <input type="button" id="btn_next" value=">" />
                    </th>
                </tr>
                <tr style="display: none;">
                    <th id="th_select" colspan="7">
                        <select id="drp_month"></select>
                        <select id="drp_year"></select>
                        <input type="button" id="btn_select" value="Select" />
                    </th>
                </tr>
                <tr>
                    <th>Su</th>
                    <th>Mo</th>
                    <th>Tu</th>
                    <th>We</th>
                    <th>Th</th>
                    <th>Fr</th>
                    <th>Sa</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
