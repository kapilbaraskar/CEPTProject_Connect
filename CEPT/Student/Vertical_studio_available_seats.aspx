<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vertical_studio_available_seats.aspx.cs" Inherits="Student_Vertical_studio_available_seats" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Available Seats</title>
    <link rel="stylesheet" type="text/css" href="../DesignCss/bootstrap.min.css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>

    <%--<link rel="stylesheet" type="text/css" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css" />--%>
    <script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <style type="text/css">
        body {
            margin-top: 40px;
            margin-left: 50px;
            margin-right: 50px;
            font-size: 17px;
        }

        #tbl_available_seats thead th, #tbl_available_seats tbody td {
            text-align: center;
        }

            #tbl_available_seats tbody td:nth-child(2) {
                text-align: left;
            }

        .ps {
            font-size: 15px !important;
            text-align: center;
        }
    </style>

    <script type="text/javascript">
        var page_no = 0;
        var temp_interval;
        var obj_temp = {};
        var dept_code = '';
        var sub_cat_id = '';
        var course_code = '';

        $(document).ready(function () {
            dept_code = getParameterByName("dept");
            sub_cat_id = getParameterByName("Unit");
            course_code = getParameterByName("coursecode")

            // - Studio Units - Seat Status

            if (dept_code == '1') $('#h3_dept_title').html('Faculty of Architecture');
            else if (dept_code == '2') $('#h3_dept_title').html('Faculty of Design');
            else if (dept_code == '3') $('#h3_dept_title').html('Faculty of Management');
            else if (dept_code == '4') $('#h3_dept_title').html('Faculty of Planning');
            else if (dept_code == '5') $('#h3_dept_title').html('Faculty of Technology');

            if (sub_cat_id == "L2") {
                $('#h3_dept_title').html($('#h3_dept_title').text() + ' - Level 2 Studio Units - Seat Status');
            } else if (sub_cat_id == "L3") {
                $('#h3_dept_title').html($('#h3_dept_title').text() + ' - Level 3 Studio Units - Seat Status');
            } else if (sub_cat_id == "L4") {
                $('#h3_dept_title').html($('#h3_dept_title').text() + ' - Level 4 Studio Units - Seat Status');
            }

            get_available_seat_data();

            temp_interval = setInterval(function () { get_available_seat_data(); }, 60000);//10000
        });

        function get_available_seat_data() {

            //console.log("{page_no:" + (page_no + 1) + ",course_code:'" + course_code + "',dept_code:'" + dept_code + "',sub_cat_id:'" + sub_cat_id + "'}");
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/get_vertical_studio_allocation_status",
                async: false,
                data: "{page_no:" + (page_no + 1) + ",course_code:'" + course_code + "',dept_code:'" + dept_code + "',sub_cat_id:'" + sub_cat_id + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var course_data = JSON.parse(data.d);
                        page_no = parseInt(course_data['status']);

                        $('#div_page_no').html(page_no);

                        if (course_data['message'] != '') {
                            var obj_data = course_data['message'];
                            var str_html = '';

                            for (var i = 0; i < obj_data.length; i++) {
                                var c_code = obj_data[i]['course_code'];

                                if (obj_temp[c_code] != undefined) {
                                    if (obj_temp[c_code]['total_seats'] != obj_data[i]['available_seat'] ||
                                        obj_temp[c_code]['allocated_seats'] != obj_data[i]['allocated_seats'] ||
                                        obj_temp[c_code]['remaining_seats'] != obj_data[i]['remaining_seats']) {

                                        str_html += '<tr style="background-color:mediumaquamarine;">';
                                    }
                                    else { str_html += '<tr>'; }
                                }
                                else { str_html += '<tr>'; }

                                str_html += '<td>' + obj_data[i]['course_code'] + '</td>';
                                str_html += '<td>' + '<b>' + obj_data[i]['instructor_name'] + '</b>' + ' ' + '<br>' + '(' + obj_data[i]['course_name'] + ')' + '</td>';

                                str_html += '<td style="font-size:0.7em;">' + obj_data[i]['short_list_stu'] + '</td>';//removed
                                //str_html += '<td>' + obj_data[i]['course_name'] + '</td>';
                                //str_html += '<td>' + obj_data[i]['instructor_name'] + '</td>';
                                str_html += '<td style="font-size:0.7em;">' + obj_data[i]['allocate_stu'] + '</td>';//removed

                                str_html += '<td>' + obj_data[i]['available_seat'] + ' | ' + obj_data[i]['remaining_seats'] + '</td>';


                                //str_html += '<td>' + obj_data[i]['allocated_seats'] + '</td>';
                                //str_html += '<td>' + obj_data[i]['remaining_seats'] + '</td></tr>';

                                str_html += '<td style="border-right: 1px solid #ddd;padding: 0px !important;">';
                                
                                var count_priority = JSON.parse(obj_data[i]["count_priority"]);

                                if (count_priority.length > 5)
                                {
                                    //Start
                                    str_html += '<table class="ps" style="width:100% !important;text-align:center;">';
                                    str_html += '<tr class="ps"><td class="ps" style="text-align:center;font-weight: bold;    padding: 2px !important;    border:0px !important;width:16.66% !important;">P</td>';
                                    for (var d = 0; d < 5; d++) {
                                        str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;">' + count_priority[d]["priority"] + '</td>';
                                    }

                                    if (count_priority.length != 5) {
                                        for (var v = count_priority.length; v < 5; v++) {
                                            //str_html += '<td class="ps" style="text-align:center;padding: 2px !important; border:0px !important;width:16.66% !important;">' + parseInt(v + 1) + '</td>';
                                            str_html += '<td class="ps" style="text-align:center;padding: 2px !important; border:0px !important;width:16.66% !important;"></td>';
                                        }
                                    }
                                    //else
                                    //{
                                    //    for (var v = count_priority.length; v < 5; v++) {
                                    //        str_html += '<td class="ps" style="text-align:center;padding: 2px !important; border:0px !important;width:16.66% !important;"></td>';
                                    //    }
                                    //}

                                    str_html += '</tr>';

                                    str_html += '<tr class="ps"><td class="ps" style="text-align:center;font-weight: bold;    padding: 2px !important; border:0px !important;width:16.66% !important;">S</td>';

                                    for (var e = 0; e < 5; e++) {
                                        var allocate_sets = count_priority[e]["allocate_sets"];
                                        if (allocate_sets != "" && allocate_sets != 'undefined') {

                                            str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;">' + count_priority[e]["count_priority"] + '</td>';
                                        }
                                        else {
                                            str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;">' + count_priority[e]["count_priority"] + '</td>';
                                        }

                                    }

                                    if (count_priority.length != 5) {
                                        for (var v = count_priority.length; v < 5; v++) {
                                            //    str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;">' + parseInt(0) + '</td>';
                                            str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;"></td>';
                                        }
                                    }
                                    //else {
                                    //    for (var v = count_priority.length; v < 5; v++) {
                                    //        str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;"></td>';
                                    //    }
                                    //}

                                    str_html += '</tr>';
                                    str_html += '</table>';
                                    //End
                                }
                                else
                                {
                                    //Start
                                    str_html += '<table class="ps" style="width:100% !important;text-align:center;">';
                                    str_html += '<tr class="ps"><td class="ps" style="text-align:center;font-weight: bold;    padding: 2px !important;    border:0px !important;width:16.66% !important;">P</td>';
                                    for (var d = 0; d < count_priority.length; d++) {
                                        str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;">' + count_priority[d]["priority"] + '</td>';
                                    }

                                    if (count_priority.length != 5) {
                                        for (var v = count_priority.length; v < 5; v++) {
                                            //str_html += '<td class="ps" style="text-align:center;padding: 2px !important; border:0px !important;width:16.66% !important;">' + parseInt(v + 1) + '</td>';
                                            str_html += '<td class="ps" style="text-align:center;padding: 2px !important; border:0px !important;width:16.66% !important;"></td>';
                                        }
                                    }
                                    //else
                                    //{
                                    //    for (var v = count_priority.length; v < 5; v++) {
                                    //        str_html += '<td class="ps" style="text-align:center;padding: 2px !important; border:0px !important;width:16.66% !important;"></td>';
                                    //    }
                                    //}

                                    str_html += '</tr>';

                                    str_html += '<tr class="ps"><td class="ps" style="text-align:center;font-weight: bold;    padding: 2px !important; border:0px !important;width:16.66% !important;">S</td>';

                                    for (var e = 0; e < count_priority.length; e++) {
                                        var allocate_sets = count_priority[e]["allocate_sets"];
                                        if (allocate_sets != "" && allocate_sets != 'undefined') {

                                            str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;">' + count_priority[e]["count_priority"] + '</td>';
                                        }
                                        else {
                                            str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;">' + count_priority[e]["count_priority"] + '</td>';
                                        }

                                    }

                                    if (count_priority.length != 5) {
                                        for (var v = count_priority.length; v < 5; v++) {
                                            //    str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;">' + parseInt(0) + '</td>';
                                            str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;"></td>';
                                        }
                                    }
                                    //else {
                                    //    for (var v = count_priority.length; v < 5; v++) {
                                    //        str_html += '<td class="ps" style="text-align:center;    padding: 2px !important; border:0px !important;width:16.66% !important;"></td>';
                                    //    }
                                    //}

                                    str_html += '</tr>';
                                    str_html += '</table>';
                                    //End
                                }
                                str_html += '</td>';

                                obj_temp[c_code] = { 'total_seats': obj_data[i]['available_seat'], 'allocated_seats': obj_data[i]['allocated_seats'], 'remaining_seats': obj_data[i]['remaining_seats'] };
                            }

                            $('#tbl_available_seats tbody').html(str_html);
                            $('#tbl_available_seats tbody tr').animate({ backgroundColor: 'white' }, 4000);
                        }
                        else {
                            page_no--;
                        }
                    }
                },
                error: function (result) {
                    //alert(result);
                }
            });
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }



    </script>
</head>

<body>
    <h3 id="h3_dept_title"></h3>
    <div id="div_available_seats">
        <div id="div_page_no" style="display: none;"></div>

        <table id="tbl_available_seats" class="table table-bordered">
            <thead>
                <tr>
                    <th style="width: 8%;">Code</th>
                    <th style="width: 30%;">UNIT</th>
                    <th style="width: 20%;">Short Listed</th>
                    <th style="width: 20%;">Allocated</th>
                    <%--<th style="width:43%;">Instructor Name</th>--%>
                    <th style="width: 8%;">Seats | Remaining</th>
                    <%--Total--%>
                    <%--<th style="width:16%;">Allocated Seats</th>--%>
                    <%--<th style="width:16%;">Remaining Seats</th>--%>
                    <th style="width: 14%;"><i>P: Pref &nbsp;&nbsp;&nbsp; S: Stud</i></th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</body>
</html>
