<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SW_course_wise_allocation.aspx.cs" Inherits="Admin_Report_SW_course_wise_allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

     <%--<script src="../../Js_WS/admin_report.js" type="text/javascript"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../Js/loder.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
           
            bind_ws_semdata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                course_wise_student_dtl();
                return false;
            });
            $('#btn_remove').on('click', function () {
                publish_allocation_data('D');
                return false;
            });

           $('#btn_publish').on('click', function () {
               publish_allocation_data('S');
               return false;
           });

            $('#btn_publish_all').on('click', function () {
                btnLoaderStart('#btn_publish_all', 'please wait...');
                setTimeout(function () {
                    publish_allocation_send_mail("A");
                }, 100);
                return false;
            });
            $('#btn_send_mail').on('click', function () {
                btnLoaderStart('#btn_send_mail', 'please wait...');
                setTimeout(function () {
                    publish_allocation_send_mail("M");
                }, 100);
                return false;
            });

           // return false;
        });

        function bind_ws_semdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
            //    for (var i = 0; i < sem_data.length; i++) {


            //        $('#drpsemester').append($("<option></option>").val(sem_data[i]["semester_code"]).html(sem_data[i]["semester_name"]));

            //    }

            $('#drpsemester').chosen();

        }

        function bindyeardata_for_cross_reg() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService_WS.asmx/Get_year_data",

                data: "{}",
                dataType: "json",
                success: function (data) {




                    if (data.d != "") {


                        var year_data = JSON.parse(data.d)



                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {


                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear').chosen();
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function publish_allocation_data(status_data) {
            var statusdata = status_data;
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

            var course_type = $('#drpcoursetype').val();
            if (course_type == "") {
                bootbox.alert('Please Course Type')
                $('#drpcoursetype').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/sw_publish_allocation_data",
                //data: "{sem_code :'" + semester + "' , year_code : '" + year_code + "', status :'" + statusdata +"' }",
                data: "{status :'" + statusdata + "',course_type :'" + course_type + "' }",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        bootbox.alert(data.d);
                        course_wise_student_dtl();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }
        function course_wise_student_dtl() {
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
            var course_type = $('#drpcoursetype').val();
            if (course_type == "") {
                bootbox.alert('Please Course Type')
                $('#drpcoursetype').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_SWS_course_wise_Reg_student_count",
                data: "{sem_code: '" + semester + "',year_code:'" + year_code + "',course_type:'" + course_type + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {

                        Display_report(data.d);
                        $('#btn_remove').css('display', 'block');
                        $('#btn_publish').css('display', 'block');
                        $('#btn_publish_all').css('display', 'block');
                        $('#btn_send_mail').css('display', 'block');
                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


        function Display_report(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [

                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Available Seat", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "Total Register Student", "mData": "Total_Reg_student", "bSortable": false },
                    /*{ "sTitle": "No of Allocated Students", "mData": "allocated_seat", "bSortable": false }*/
                    {
                        "sTitle": "No of Provisionally Allocated Students", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.Total_pro_student != '') {
                                return data.Total_pro_student;
                            }
                            else {
                                return '0';
                            }
                        }
                    },


                    {
                        "sTitle": "No of Allocated Students", "mData": null, "bSortable": false, mRender: function (data) {

                            if (data.allocated_seat != '') {
                                return data.allocated_seat;
                            }
                            else {
                                return '';
                            }
                        }
                    }
                ]
            });
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function publish_allocation_send_mail(status_flag) {
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
            var course_type = $('#drpcoursetype').val();
            if (course_type == "") {
                bootbox.alert('Please Course Type')
                $('#drpcoursetype').focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/ws_course_allocate_user_for_send_mail",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "', modstatus : '" + status_flag + "', course_type : '" + course_type + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "success") {
                            alert("Mail Send successfully");
                            btnLoaderStop("#btn_publish_all");
                            return false;
                        }
                        else if (data.d == "Allocated") {
                            alert("Allocation Submit successfully");
                            btnLoaderStop("#btn_publish_all");
                            return false;
                        }
                        else
                        {
                            if (status_flag == "M") {
                                alert("Mail Failed");
                            }
                            else { alert("Allocation Failed");}
                           
                            btnLoaderStop("#btn_publish_all");
                            return false;
                        }
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Total Course Selected By Student
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
                            <td>
                                Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                             <td>
                                Year of Allocation :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <td>
                                Course Type :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpcoursetype">
                                    <option value="">--Please Select Type--</option>
                                    <option value="E">Elactive</option>
                                    <option value="M">Mandatory</option>
                                </select>
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
            
            <div id="DataList" class="panel panel-default" style="display: none">
                <div class="panel-heading">
                    <strong>Total Course Selected By Student</strong>
                </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

            <table style="margin-top:10px" width="100%" border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td align="right">
                            <button class="btn btn-primary" style="display:none" type="submit" id="btn_assign">
                                <i class="icon-save bigger-160"></i> Assign 1
                            </button>
                        </td>
                            <td style=" width: 13%;">
                            <button class="btn btn-primary" style="display:none;" type="submit" id="btn_assign2">
                                <i class="icon-save bigger-160"></i> Assign 2
                            </button>
                        </td>
                            <td align="left" style=" width: 26%;">
                            <button class="btn btn-primary" style="display:none;" type="submit" id="btn_remove">
                                <i class="icon-save bigger-160"></i> Remove Old Allocation
                            </button>
                        </td>
                            <td align="left">
                            <button class="btn btn-primary" style="display:none;" type="submit" id="btn_publish">
                                <i class="icon-save bigger-160"></i> Provision Allocation
                            </button>
                        </td>

                           <td align="left">
                            <button class="btn btn-primary" style="display:none;" type="submit" id="btn_publish_all">
                                <i class="icon-save bigger-160"></i> Publish Allocation
                            </button>
                        </td>

                        <td align="left">
                            <button class="btn btn-primary" style="display:none;" type="submit" id="btn_send_mail">
                                <i class="icon-save bigger-160"></i> Send Mail
                            </button>
                        </td>
                    </tr>
            </table>
        </div>
</asp:Content>

