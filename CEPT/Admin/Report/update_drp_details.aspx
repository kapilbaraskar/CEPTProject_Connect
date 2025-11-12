<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="update_drp_details.aspx.cs" Inherits="Admin_Report_update_drp_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=30122021" type="text/javascript"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel='stylesheet' href='https://cdn.datatables.net/s/ju/dt-1.10.10,b-1.1.0,fc-3.2.0,r-2.0.0,sc-1.4.0/datatables.min.css'>

    <style>
        th, td {
            white-space: nowrap;
        }

        div.dataTables_wrapper {
            /* width: 800px;*/
            /*margin: 0 auto;*/
            overflow: auto;
        }

        .ui-widget-header {
            background: none !important;
        }

        #example td:first-child {
            background: url('https://datatables.net/examples/resources/details_open.png') no-repeat center center;
            cursor: pointer;
        }

        #example tr.shown td:first-child {
            background: url('https://datatables.net/examples/resources/details_close.png') no-repeat center center;
        }

        table#bind_sub td:first-child {
            background: none !important;
        }

        table#bind_sub tr.shown td:first-child {
            background: none !important;
        }
    </style>

    <script type="text/javascript">
       
            var table = "";
            var element = "";
            $(document).ready(function () {

                bindyeardata_for_cross_reg();
                bindsemdata();
                binddepartment()
                bindprogrammedata();
                bindproglevel();
                $('#btnreterive').on('click', function () {
                    //if (table != "") {
                    //    $('table#bind_sub').destroy();
                    //}
                    total_course_allocat_new();
                    return false;
                });


               // return false;
            });
            function display_student_Course_allocation(data) {
                var str = "";
                 if (table != "") {
                     table.destroy();
                    }
                var data_dtl = JSON.parse(data);

                for (var i = 0; i < data_dtl.length; i++)
                {
                    str += "<tr>";
                    str += "<td class='sorting_1'></td>";
                    str += "<td>" + data_dtl[i]['drp_code'] + "</td>";
                    str += "<td>" + data_dtl[i]['course_code'] + "</td>";
                    str += "<td>" + data_dtl[i]['course_name'] + "</td>";
                    str += "<td><textarea id='topic' name='topic' rows='4' cols='50'>" + data_dtl[i]['topic'] + "</textarea></td>";
                    str += "<td><textarea id='abstracts' name='abstracts' rows='4' cols='50'>" + data_dtl[i]['abstracts'] + "</textarea></td>";
                    str += "<td>" + data_dtl[i]['reference'] + "</td>";
                    str += "<td>" + data_dtl[i]['full_name'] + "</td>";
                    str += "<td><button type='button' onclick='rowClick_edit_drp(this)' id=" + data_dtl[i]['course_code'] + '_' + data_dtl[i]['drp_code'] + " class='cls_btn_pdf btn btn-primary btn-small'>Edit DRP</button></td>";
                    str += "</tr>";
                }
                $('#Bind_data').html(str);
                table = '';
                table = $('#example').DataTable();
                $('#DataList').css('display', 'block');

                $('#example tbody').off().on('click', 'td:first-child', function () {
                    var tr = $(this).closest('tr');
                    var rowId = $(this).closest('tr').children('td:eq(1)').text();
                    var row = table.row(tr);
                    if (row.child.isShown()) {
                        row.child.hide();
                        tr.removeClass('shown');
                    }
                    else {
                        var test = ShowStudentDetails(rowId);
                        row.child(test).show();
                        tr.addClass('shown');
                    }
                });
            }
            function total_course_allocat_new() {
                $('#DataList').css('display', 'none');

                var semester = $('#drpsemester').val();
                if (semester == "") {
                    bootbox.alert('Please select semester')
                    $('#drpsemester').focus();
                    return false;
                }

                var year_code = $('#drpyear').val();
                if (year_code == "") {
                    bootbox.alert('Please select Year')
                    $('#drpyear').focus();
                    return false;
                }

                var dept_code = $('#drpdepartment').val();
                var prog_code = $('#drpprog').val();
                var prog_level_code = $('#drpproglevel').val();



                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/DRP_Wise_Get_Course_Details",
                    data: "{semester:'" + semester + "' , year : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            display_student_Course_allocation(data.d);
                            //return true;
                        }
                        else {
                            bootbox.alert('There is No data Found For Selected Semester or Year');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

               // return false;
            }
            function ShowStudentDetails(d) {
                var stringdata = "";
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/DRP_Wise_Get_Student_dtl",
                    data: "{semester:'" + $('#drpsemester').val() + "' , year : '" + $('#drpyear').val() + "',drp_code: '" + d + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var json_data = JSON.parse(data.d);

                            if (table != "") {
                                
                            }
                            stringdata += '<table cellpadding="5" cellspacing="0" border="0" id="bind_sub" class="table table-striped table-bordered display">' +
                                '<tr>' +
                                '<th>Student Code</th>' +
                                '<th>Student Name </th>' +
                                '<th>Email </th>' +
                                '<th>Seat Type</th>' +
                                '<th>Action</th>' +
                                '<th>Action</th>' +
                                '</tr > ';
                            for (var i = 0; i < json_data.length; i++) {
                                stringdata += '<tr>' +
                                    '<td>' + json_data[i]['user_id'] + '</td>' +
                                    '<td>' + json_data[i]['full_name'] + '</td>' +
                                    '<td>' + json_data[i]['mail'] + '</td>' +
                                    '<td>' + json_data[i]['seat_type'] + ' </td>';
                                if (json_data[i]['cancel_flag'] == 'N') {
                                    stringdata += '<td>Allocated</td>' +
                                        '<td><button type="button" onclick="rowClick_deallocate(this)" id=' + json_data[i]['drp_code'] + '_' + json_data[i]['user_id'] + ' class="cls_btn_pdf btn btn-primary btn-small">Deallocate</button></td>';
                                }
                                else if (json_data[i]['cancel_flag'] == 'Y') {
                                    stringdata += '<td>Deallocated</td>' +
                                        '<td><button type="button" onclick="rowClick_allocate(this)" id=' + json_data[i]['drp_code'] + '_' + json_data[i]['user_id'] + '  class="cls_btn_pdf btn btn-primary btn-small">Allocate</button></td>';
                                }
                                stringdata += '</tr>';
                            }
                            stringdata += '</table>';
                            return stringdata;
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
                return stringdata;
                // return false;
        }

            function rowClick_allocate(element) {
                var split_studiocode = element.id.split("_");

                var data = JSON.stringify({ manually_data: split_studiocode[1], sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val(), drp_code: split_studiocode[0], flag_status: 'N' });

                $.ajax({
                    type: "POST",
                    url: "../../WebService.asmx/Deallocate_drp_request_v2",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "Problem in save data") {
                                bootbox.alert("Problem in save data");
                                return false;
                            }
                            else {
                                bootbox.alert("Allocated Successfully");
                                //location.reload();

                                if (table) {
                                    //table.destroy();
                                }
                                test();
                                //total_course_allocat_new();
                                return false;
                            }

                            return false;
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
            }


            function rowClick_deallocate(element) {
                var split_studiocode = element.id.split("_");
                var data = JSON.stringify({ manually_data: split_studiocode[1], sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val(), drp_code: split_studiocode[0], flag_status: 'Y' });

                $.ajax({
                    type: "POST",
                    url: "../../WebService.asmx/Deallocate_drp_request_v2",
                    data: data,
                    contentType: "application/json; charset=utf-8",
                    datatype: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "Problem in save data") {
                                bootbox.alert("Problem in save data");
                                return false;
                            }
                            else {
                                bootbox.alert("Deallocated Successfully");
                                //if (table) {
                                //    table.destroy();
                                //}
                                //  location.reload();
                                total_course_allocat_new();
                                // total_course_allocat_new();
                               // return false;
                            }

                            //return false;
                        }
                    },
                    error: function (msg) { alert(msg.d); }
                });
            }

            function test() {
                total_course_allocat_new();
              //  return false;
            }

            function rowClick_edit_drp(drp_course) {
                var split_studiocode = drp_course.id.split("_");

                window.open(location.origin + '/Admin/Master/DRP_Request_form.aspx?c=' + split_studiocode[0] + '&s=' + $('#drpsemester').val() + '&y=' + $('#drpyear').val() + '&d=' + split_studiocode[1], '_blank');
            }



       
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Update DRP Details
            </h1>
        </div>
    </div>
    <div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>Semester :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>Year of allocation :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td>Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>

                    </tr>
                    <tr>
                        <td>Program :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog" />
                        </td>
                        <td>Program Level :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpproglevel" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div>
            <div id="DataList" style="display: none; overflow: auto;" class="panel panel-default">
                <div class="panel-heading">
                    <strong id="panel_head">Update DRP And Student Details</strong>
                </div>
                <table id="example" class="display table table-striped table-bordered table-hover" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th></th>
                            <th>DRP Code</th>
                            <th>Course Code </th>
                            <th>Course Name</th>
                            <th>DRP Topic Name</th>
                            <th>Instractor Name</th>
                            <th>Abstracts</th>
                            <th>Reference</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="Bind_data"></tbody>
                </table>
            </div>

        </div>
    </div>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='https://cdn.datatables.net/s/ju/dt-1.10.10,b-1.1.0,fc-3.2.0,fh-3.1.0,r-2.0.0,sc-1.4.0/datatables.min.js'></script>
</asp:Content>

