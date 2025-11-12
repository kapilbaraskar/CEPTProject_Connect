<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_Clearance_dtl.aspx.cs" Inherits="Admin_Master_Student_Clearance_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style type="text/css">
        .cls_width {
            width: 25% !important;
        }
        .cls_width_desc {
            width: 25% !important;
        }

        .show_AC {
            display: none;
            width: 250px;
        }
        .cls_width_text
        {
            width: 20% !important;
        }
        #btn_download
        {
            display:none;
        }#btn_approved
        {
            display:none;
        }#btn_pending
        {
            display:none;
        }#btn_onhold
        {
            display:none;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var oTable1;
        var oTable2;
        var oTable3;
        var sem = '';
        var year = '';
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindsemdata();
            
            var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#all'>All&nbsp;</a></li><li><a data-toggle='tab' href='#approved'>Approved&nbsp;</a></li><li><a data-toggle='tab' href='#pending'>Pending &nbsp; </a></li><li><a data-toggle='tab' href='#onhold'>OnHold&nbsp;</a></li>" +
                "</ul>";
            $("#div_myTab").html(strHtml);
            $("#all").addClass("in active");

            get_All_data(sem, year, '');
            getSubmittedCheck(sem, year, 'Approved');
            get_pending(sem, year, 'Pending');
            get_onhold(sem, year, 'On Hold');


            $('#btnRetrieve').on('click', function () {

                //if ($('#drpsemester').val() == "") {
                //    bootbox.alert('Please Select Semester.');
                //    return false;
                //}
                //
                //if ($('#drpyear').val() == "") {
                //    bootbox.alert('Please Select Year.');
                //    return false;
                //}

                //sem = $('#drpsemester').val();
                //year = $('#drpyear').val();
                //var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#all'>All&nbsp;</a></li><li><a data-toggle='tab' href='#approved'>Approved&nbsp;</a></li><li><a data-toggle='tab' href='#pending'>Pending &nbsp; </a></li><li><a data-toggle='tab' href='#onhold'>OnHold&nbsp;</a></li>" +
                //    "</ul>";
                //$("#div_myTab").html(strHtml);
                //$("#all").addClass("in active");
                sem = $('#drpsemester').val();
                year = $('#drpyear').val();
                get_All_data(sem, year, '');
                getSubmittedCheck(sem, year, 'Approved');
                get_pending(sem, year, 'Pending');
                get_onhold(sem, year, 'On Hold');
            });

            $('#btnapproved').on('click', function () {

                
                var semester_type = $('#drpsemester').val();
                var year_semester = $('#drpyear').val();
                $('#hdn_sem_code').val(semester_type);
                $('#hdn_year_code').val(year_semester);
                $('#hdn_status').val('Approved');
                $('#btn_approved').click();

                return false;
               
            });


            $('#btnpending').on('click', function () {


                var semester_type = $('#drpsemester').val();
                var year_semester = $('#drpyear').val();
                $('#hdn_sem_code').val(semester_type);
                $('#hdn_year_code').val(year_semester);
                $('#hdn_status').val('Pending');
                $('#btn_pending').click();

                return false;

            });

            $('#btnonhold').on('click', function () {


                var semester_type = $('#drpsemester').val();
                var year_semester = $('#drpyear').val();
                $('#hdn_sem_code').val(semester_type);
                $('#hdn_year_code').val(year_semester);
                $('#hdn_status').val('On Hold');
                $('#btn_onhold').click();

                return false;

            });
            
            //get_All_data();
            //getSubmittedCheck();
            //get_pending();
            //get_onhold();
        });


        $(document).on("click", ".download", function (event) {
            debugger;
           
            var row = $(this).closest("tr");
            var aData = oTable.fnGetData(row);
            var user_id = aData["user_id"];
            var semester_type = aData["semester_type"];
            var year_semester = aData["year_semester"];
            $('#hdn_user_id').val(user_id);
            $('#hdn_sem_code').val(semester_type);
            $('#hdn_year_code').val(year_semester);
            $('#btn_download').click();

            return false;
        });
        $(document).on("click", ".view", function (event) {
            debugger;
           
            var row = $(this).closest("tr");
            var aData = oTable.fnGetData(row);
            var user_id = aData["user_id"];
            var semester_type = aData["semester_type"];
            var year_semester = aData["year_semester"];

            if (semester_type == "Monsoon") {
                semester_type = 'M';
            }
            else if (semester_type == "Spring") {
                semester_type = 'S';
            }
            $('#hdn_user_id').val(user_id);
            $('#hdn_sem_code').val(semester_type);
            $('#hdn_year_code').val(year_semester);
            var origin = window.location.origin;

            window.open(origin + "\\Student\\" + "Student_Clearance_Status_View.aspx?c=" + user_id + "&s=" + semester_type + "&y=" + year_semester, "_blank");

            return false;
        });
        $(document).on("click", ".view_pending", function (event) {
            debugger;
           
            var row = $(this).closest("tr");
            var aData = oTable1.fnGetData(row);
            var user_id = aData["user_id"];
            var semester_type = aData["semester_type"];
            var year_semester = aData["year_semester"];
            if (semester_type == "Monsoon") {
                semester_type = 'M';
            }
            else if (semester_type == "Spring") {
                semester_type = 'S';
            }

            $('#hdn_user_id').val(user_id);
            $('#hdn_sem_code').val(semester_type);
            $('#hdn_year_code').val(year_semester);
            var origin = window.location.origin;

            window.open(origin + "\\Student\\" + "Student_Clearance_Status_View.aspx?c=" + user_id + "&s=" + semester_type + "&y=" + year_semester, "_blank");

            return false;
        });
        $(document).on("click", ".view_onhold", function (event) {
            debugger;
           
            var row = $(this).closest("tr");
            var aData = oTable2.fnGetData(row);
            var user_id = aData["user_id"];
            var semester_type = aData["semester_type"];
            var year_semester = aData["year_semester"];
            $('#hdn_user_id').val(user_id);
            $('#hdn_sem_code').val(semester_type);
           
            if (semester_type == "Monsoon") {
                semester_type = 'M';
            }
            else if (semester_type == "Spring") {
                semester_type = 'S';
            }
            $('#hdn_year_code').val(year_semester);
            var origin = window.location.origin;

            window.open(origin + "\\Student\\" + "Student_Clearance_Status_View.aspx?c=" + user_id + "&s=" + semester_type + "&y=" + year_semester, "_blank");

            return false;
        });
        $(document).on("click", ".view_all", function (event) {
            
           
            var row = $(this).closest("tr");
            var aData = oTable3.fnGetData(row);
            var user_id = aData["user_id"];
            var semester_type = aData["semester_type"];
            var year_semester = aData["year_semester"];
            if (semester_type == "Monsoon") {
                semester_type = 'M';
            }
            else if (semester_type == "Spring") {
                semester_type = 'S';
            }
            $('#hdn_user_id').val(user_id);
            $('#hdn_sem_code').val(semester_type);
            $('#hdn_year_code').val(year_semester);
            var origin = window.location.origin;

            window.open(origin + "\\Student\\" + "Student_Clearance_Status_View.aspx?c=" + user_id + "&s=" + semester_type + "&y=" + year_semester, "_blank");

            return false;
        });


        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
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

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
        }

       


        function getSubmittedCheck(sem, year, status) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_student_clearance_form_table_dtl",
                data: "{sem_code:'" + sem + "',year_code:'" + year + "',status:'Approved'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var submitted_form_data = JSON.parse(data.d)
                        if (submitted_form_data.length > 0) {
                            if (oTable != null) {
                                oTable.fnDestroy();
                                $("#clearance_data").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_inital_pc" width="100%"><thead></thead><tbody> </tbody></table>');
                            }

                            oTable = $("#clearance_data").dataTable({
                                "bPaginate": true,
                                "bSortable": false,
                                "bSort": false,
                                "iDisplayLength": 60,
                                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                "aaData": submitted_form_data,
                                "aoColumns": [

                                      { "sTitle": "Student Code", "mData": "user_id",  "bSortable": false },
                                    { "sTitle": "Student Name", "mData": "user_name",  "bSortable": false },
                                    { "sTitle": "Email ID", "mData": "mail", "bSortable": false },

                                    {
                                        "sTitle": "Description", "mData": null, "sClass": "cls_width_desc", "bSortable": false, "mRender": function (data) {
                                            var str = "";
                                            str += "<div><div>";
                                            //str += "<div style='width:100%;line-height: 200%;'> <b>Student Code :</b> " + data['user_id'] + "</div>";
                                            //str += "<div style='width:100%;float: left;line-height: 80%;'><b>Student Name :</b> " + data['user_name'] + "</div></br>";


                                            //str += "<div class='row' style='padding-left:15px;'>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>Mail :</b> " + data['mail'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>Semester :</b> " + data['semester_type'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 80%;'><b>Year Semester :</b> " + data['year_semester'] + "</div></br>";
                                            //str += "</div>";


                                            //str += "<div class='row' style='padding-left:15px;'>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>Library :</b> " + data['Library'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>Workshops :</b> " + data['Workshops'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 80%;'><b>CEPT LAB :</b> " + data['CEPT LAB'] + "</div></br>";
                                            //str += "</div>";

                                            str += "<div class='row' style='padding-left:15px;'>";
                                            str += "<div><b>Library :</b> " + data['Library'] + "</div>";
                                            str += "<div><b>Workshops :</b> " + data['Workshops'] + "</div>";
                                            str += "<div><b>CEPT LAB :</b> " + data['CEPT LAB'] + "</div>";
                                             str += "<div><b>IT Office :</b> " + data['IT Office'] + "</div>";
                                             str += "<div><b>Hostel :</b> " + data['Hostel'] + "</div>";
                                            str += "<div><b>Student Services office (Id, etc) :</b> " + data['StudentServicesoffice(Id, etc)'] + "</div>";
                                            str += "<div><b>Campus Office :</b> " + data['Campus Office'] + "</div>";
                                            str += "<div><b>Account Details :</b> " + data['Account Details'] + "</div>";
                                            str += "<div><b>Account Office :</b> " + data['Account Office'] + "</div>";
                                            str += "<div><b>Faculty Admin :</b> " + data['Faculty Admin'] + "</div>";
                                            str += "<div><b>PG Office/UG office :</b> " + data['PGUGoffice'] + "</div>";
                                            str += "<div><b>Registrar :</b> " + data['Registrar'] + "</div></br>";
                                            str += "</div>";



                                            //str += "<div class='row' style='padding-left:15px;'>";
                                            //str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D1_Remarks'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D2_Remarks'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D3_Remarks'] + "</div></br>";
                                            //str += "</div><br>";



                                            //str += "<div class='row' style='padding-left:15px;'>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>IT Office :</b> " + data['IT Office'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>Hostel :</b> " + data['Hostel'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 80%;'><b>Student Services office (Id, etc) :</b> " + data['Student Services office (Id, etc)'] + "</div></br>";
                                            //str += "</div>";

                                            //str += "<div class='row' style='padding-left:15px;'>";
                                            //str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D4_Remarks'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D5_Remarks'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D6_Remarks'] + "</div></br>";
                                            //str += "</div> <br>";



                                           /* str += "<div class='row' style='padding-left:15px;'>";*/
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>Campus Office :</b> " + data['Campus Office'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>Account Details :</b> " + data['Account Details'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 80%;'><b>Account Office :</b> " + data['Account Office'] + "</div></br>";
                                            //str += "</div>";

                                            //str += "<div class='row' style='padding-left:15px;'>";
                                            //str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D7_Remarks'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D8_Remarks'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D9_Remarks'] + "</div></br>";
                                            //str += "</div> <br>";



                                            //str += "<div class='row' style='padding-left:15px;'>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>Faculty Admin :</b> " + data['Faculty Admin'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 80%;'><b>PG Office/UG office :</b> " + data['PGUGoffice'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 80%;'><b>Registrar :</b> " + data['Registrar'] + "</div></br>";
                                            //str += "</div>";

                                            //str += "<div class='row' style='padding-left:15px;'>";
                                            //str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D10_Remarks'] + "</div>";
                                            //str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D11_Remarks'] + "</div>";
                                            //str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['R_Remarks'] + "</div></br>";
                                            //str += "</div>";

                                            str += "</br></br>";
                                            str += "</div>";
                                            str += "</div></div>";

                                            return str;
                                        }
                                    },

                                  
                                    //{ "sTitle": "Mobile No ", "mData": "applicant_mobile_no", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Department Name", "mData": "department_name", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Remarks", "mData": "remarks", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Semester", "mData": "semester_type", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Year Semester", "mData": "year_semester", "sClass": "cls_desc", "bSortable": false },
                                    ///*{ "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false },*/
                                    {
                                        "sTitle": "Action", "mData": null, "sClass": "cls_width1", "bSortable": false, "mRender": function (data) { 
                                            
                                            return '<center><button type="button" class="download">Download</button></center>';
                                        }
                                    },
                                    { "sTitle": "Semester", "mData": "semester_type", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Year Semester", "mData": "year_semester", "sClass": "cls_desc", "bSortable": false },
                                    {
                                        "sTitle": "View", "mData": null, "sClass": "cls_width1", "bSortable": false, "mRender": function (data) {

                                            return '<center><button type="button" class="view">View</button></center>';
                                           
                                        }
                                    }


                                    
                                ]
                            });
                            $("#clearance_div").css("display", "");
                            
                        } else {
                            alert("Data Not Found selected Sem and Year.");
                            $("#clearance_div").css("display", "none");
                        }
                    } else {
                        alert("Data Not Found selected Sem and Year.");
                        $("#clearance_div").css("display", "none");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_pending(sem, year, status) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_student_clearance_form_table_dtl",
                data: "{sem_code:'" + sem + "',year_code:'" + year + "',status:'Pending'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var submitted_form_data = JSON.parse(data.d)
                        if (submitted_form_data.length > 0) {
                            if (oTable1 != null) {
                                oTable1.fnDestroy();
                                $("#clearance_data_pending").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_pending" width="100%"><thead></thead><tbody> </tbody></table>');
                            }

                            oTable1 = $("#clearance_data_pending").dataTable({
                                "bPaginate": false,
                                "bSortable": false,
                                "bSort": false,
                                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                "aaData": submitted_form_data,
                                "aoColumns": [

                                    { "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false },
                                    //{
                                    //    "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (data) {
                                    //        var str = "";
                                    //        str += "<div><div>";
                                    //        str += "<div style='width:100%;line-height: 200%;'> <b>Student Code :</b> " + data['user_id'] + "</div>";
                                    //        str += "<div style='width:100%;float: left;line-height: 80%;'><b>Student Name :</b> " + data['user_name'] + "</div></br>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Mail :</b> " + data['mail'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Semester :</b> " + data['semester_type'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Year Semester :</b> " + data['year_semester'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Library :</b> " + data['Library'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Workshops :</b> " + data['Workshops'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>CEPT LAB :</b> " + data['CEPT LAB'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D1_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D2_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D3_Remarks'] + "</div></br>";
                                    //        str += "</div><br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>IT Office :</b> " + data['IT Office'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Hostel :</b> " + data['Hostel'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Student Services office (Id, etc) :</b> " + data['Student Services office (Id, etc)'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D4_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D5_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D6_Remarks'] + "</div></br>";
                                    //        str += "</div> <br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Campus Office :</b> " + data['Campus Office'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Account Details :</b> " + data['Account Details'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Account Office :</b> " + data['Account Office'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D7_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D8_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D9_Remarks'] + "</div></br>";
                                    //        str += "</div> <br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Faculty Admin :</b> " + data['Faculty Admin'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>PG Office/UG office :</b> " + data['PGUGoffice'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Registrar :</b> " + data['Registrar'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D10_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D11_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['R_Remarks'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "</br></br>";
                                    //        str += "</div>";
                                    //        str += "</div></div>";

                                    //        return str;
                                    //    }
                                    //},


                                    {
                                        "sTitle": "Description", "mData": null, "sClass": "cls_width_desc", "bSortable": false, "mRender": function (data) {
                                            var str = "";
                                            str += "<div><div>";
                                           

                                            str += "<div class='row' style='padding-left:15px;'>";
                                            str += "<div><b>Library :</b> " + data['Library'] + "</div>";
                                            str += "<div><b>Workshops :</b> " + data['Workshops'] + "</div>";
                                            str += "<div><b>CEPT LAB :</b> " + data['CEPT LAB'] + "</div>";
                                            str += "<div><b>IT Office :</b> " + data['IT Office'] + "</div>";
                                            str += "<div><b>Hostel :</b> " + data['Hostel'] + "</div>";
                                            str += "<div><b>Student Services office (Id, etc) :</b> " + data['StudentServicesoffice(Id, etc)'] + "</div>";
                                            str += "<div><b>Campus Office :</b> " + data['Campus Office'] + "</div>";
                                            str += "<div><b>Account Details :</b> " + data['Account Details'] + "</div>";
                                            str += "<div><b>Account Office :</b> " + data['Account Office'] + "</div>";
                                            str += "<div><b>Faculty Admin :</b> " + data['Faculty Admin'] + "</div>";
                                            str += "<div><b>PG Office/UG office :</b> " + data['PGUGoffice'] + "</div>";
                                            str += "<div><b>Registrar :</b> " + data['Registrar'] + "</div></br>";
                                            str += "</div>";
                                            str += "</br></br>";
                                            str += "</div>";
                                            str += "</div></div>";

                                            return str;
                                        }
                                    },
                                    { "sTitle": "Semester", "mData": "semester_type", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Year Semester", "mData": "year_semester", "sClass": "cls_desc", "bSortable": false },
                                    {
                                        "sTitle": "View", "mData": null, "sClass": "cls_width1", "bSortable": false, "mRender": function (data) {

                                            return '<center><button type="button" class="view_pending">View</button></center>';

                                        }
                                    }

                                    //{ "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Mobile No ", "mData": "applicant_mobile_no", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Department Name", "mData": "department_name", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Remarks", "mData": "remarks", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Semester", "mData": "semester_type", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Year Semester", "mData": "year_semester", "sClass": "cls_desc", "bSortable": false },
                                    ///*{ "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false },*/
                                    //{
                                    //    "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
                                    //        if (data.status == "Approved") {

                                    //            var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }
                                    //        else if (data.status == "Pending") {
                                    //            var str = "";
                                    //            str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }
                                    //        else if (data.status == "On Hold") {
                                    //            var str = "";
                                    //            str += "<div style='float: left;border: 1px ridge #B5B9BB;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }


                                    //    }
                                    //}


                                   
                                ]
                            });
                            $("#clearance_div").css("display", "");
                        } else {
                            alert("Data Not Found selected Sem and Year.");
                            $("#clearance_div_pending").css("display", "none");
                        }
                    } else {
                        alert("Data Not Found selected Sem and Year.");
                        $("#clearance_div_pending").css("display", "none");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_onhold(sem, year, status) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_student_clearance_form_table_dtl",
                data: "{sem_code:'" + sem + "',year_code:'" + year + "',status:'On Hold'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var submitted_form_data = JSON.parse(data.d)
                        if (submitted_form_data.length > 0) {
                            if (oTable2 != null) {
                                oTable2.fnDestroy();
                                $("#clearance_data_onhold").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_onhold" width="100%"><thead></thead><tbody> </tbody></table>');
                            }

                            oTable2 = $("#clearance_data_onhold").dataTable({
                                "bPaginate": false,
                                "bSortable": false,
                                "bSort": false,
                                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                "aaData": submitted_form_data,
                                "aoColumns": [

                                    { "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false },

                                    //{
                                    //    "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (data) {
                                    //        var str = "";
                                    //        str += "<div><div>";
                                    //        str += "<div style='width:100%;line-height: 200%;'> <b>Student Code :</b> " + data['user_id'] + "</div>";
                                    //        str += "<div style='width:100%;float: left;line-height: 80%;'><b>Student Name :</b> " + data['user_name'] + "</div></br>";


                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Mail :</b> " + data['mail'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Semester :</b> " + data['semester_type'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Year Semester :</b> " + data['year_semester'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Library :</b> " + data['Library'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Workshops :</b> " + data['Workshops'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>CEPT LAB :</b> " + data['CEPT LAB'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D1_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D2_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D3_Remarks'] + "</div></br>";
                                    //        str += "</div><br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>IT Office :</b> " + data['IT Office'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Hostel :</b> " + data['Hostel'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Student Services office (Id, etc) :</b> " + data['Student Services office (Id, etc)'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D4_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D5_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D6_Remarks'] + "</div></br>";
                                    //        str += "</div> <br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Campus Office :</b> " + data['Campus Office'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Account Details :</b> " + data['Account Details'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Account Office :</b> " + data['Account Office'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D7_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D8_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D9_Remarks'] + "</div></br>";
                                    //        str += "</div> <br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Faculty Admin :</b> " + data['Faculty Admin'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>PG Office/UG office :</b> " + data['PGUGoffice'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Registrar :</b> " + data['Registrar'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D10_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D11_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['R_Remarks'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "</br></br>";
                                    //        str += "</div>";
                                    //        str += "</div></div>";

                                    //        return str;
                                    //    }
                                    //},

                                    {
                                        "sTitle": "Description", "mData": null, "sClass": "cls_width_desc", "bSortable": false, "mRender": function (data) {
                                            var str = "";
                                            str += "<div><div>";


                                            str += "<div class='row' style='padding-left:15px;'>";
                                            str += "<div><b>Library :</b> " + data['Library'] + "</div>";
                                            str += "<div><b>Workshops :</b> " + data['Workshops'] + "</div>";
                                            str += "<div><b>CEPT LAB :</b> " + data['CEPT LAB'] + "</div>";
                                            str += "<div><b>IT Office :</b> " + data['IT Office'] + "</div>";
                                            str += "<div><b>Hostel :</b> " + data['Hostel'] + "</div>";
                                            str += "<div><b>Student Services office (Id, etc) :</b> " + data['StudentServicesoffice(Id, etc)'] + "</div>";
                                            str += "<div><b>Campus Office :</b> " + data['Campus Office'] + "</div>";
                                            str += "<div><b>Account Details :</b> " + data['Account Details'] + "</div>";
                                            str += "<div><b>Account Office :</b> " + data['Account Office'] + "</div>";
                                            str += "<div><b>Faculty Admin :</b> " + data['Faculty Admin'] + "</div>";
                                            str += "<div><b>PG Office/UG office :</b> " + data['PGUGoffice'] + "</div>";
                                            str += "<div><b>Registrar :</b> " + data['Registrar'] + "</div></br>";
                                            str += "</div>";
                                            str += "</br></br>";
                                            str += "</div>";
                                            str += "</div></div>";

                                            return str;
                                        }
                                    },
                                    { "sTitle": "Semester", "mData": "semester_type", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Year Semester", "mData": "year_semester", "sClass": "cls_desc", "bSortable": false },
                                    {
                                        "sTitle": "View", "mData": null, "sClass": "cls_width1", "bSortable": false, "mRender": function (data) {

                                            return '<center><button type="button" class="view_onhold">View</button></center>';

                                        }
                                    }


                                    //{ "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Mobile No ", "mData": "applicant_mobile_no", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Department Name", "mData": "department_name", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Remarks", "mData": "remarks", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Semester", "mData": "semester_type", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Year Semester", "mData": "year_semester", "sClass": "cls_desc", "bSortable": false },
                                    ///*{ "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false },*/
                                    //{
                                    //    "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
                                    //        if (data.status == "Approved") {

                                    //            var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }
                                    //        else if (data.status == "Pending") {
                                    //            var str = "";
                                    //            str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }
                                    //        else if (data.status == "On Hold") {
                                    //            var str = "";
                                    //            str += "<div style='float: left;border: 1px ridge #B5B9BB;height:23px;background-color:lightgreen;'><p><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }


                                    //    }
                                    //}



                                    
                                   
                                ]
                            });
                            $("#clearance_div").css("display", "");
                        } else {
                            alert("Data Not Found selected Sem and Year.");
                            $("#clearance_div_onhold").css("display", "none");
                        }
                    } else {
                        alert("Data Not Found selected Sem and Year.");
                        $("#clearance_div_onhold").css("display", "none");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function get_All_data(sem ,year,status) {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_student_clearance_form_table_dtl",
                data: "{sem_code:'" + sem + "',year_code:'" + year + "',status:'" + status+"'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var submitted_form_data = JSON.parse(data.d)
                        if (submitted_form_data.length > 0) {
                            if (oTable3 != null) {
                                oTable3.fnDestroy();
                                $("#clearance_data_all").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_all" width="100%"><thead></thead><tbody> </tbody></table>');
                            }

                            oTable3 = $("#clearance_data_all").dataTable({
                                "bPaginate": true,
                                "bSortable": false,
                                "bSort": false,
                                "iDisplayLength": 60,
                                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                "aaData": submitted_form_data,
                                "aoColumns": [

                                    { "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false },

                                    //{
                                    //    "sTitle": "Description", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (data) {
                                    //        var str = "";
                                    //        str += "<div><div>";
                                    //        str += "<div style='width:100%;line-height: 200%;'> <b>Student Code :</b> " + data['user_id'] + "</div>";
                                    //        str += "<div style='width:100%;float: left;line-height: 80%;'><b>Student Name :</b> " + data['user_name'] + "</div></br>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Mail :</b> " + data['mail'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Semester :</b> " + data['semester_type'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Year Semester :</b> " + data['year_semester'] + "</div></br>";
                                    //        str += "</div>";


                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Library :</b> " + data['Library'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Workshops :</b> " + data['Workshops'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>CEPT LAB :</b> " + data['CEPT LAB'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D1_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D2_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D3_Remarks'] + "</div></br>";
                                    //        str += "</div><br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>IT Office :</b> " + data['IT Office'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Hostel :</b> " + data['Hostel'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Student Services office (Id, etc) :</b> " + data['Student Services office (Id, etc)'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D4_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D5_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D6_Remarks'] + "</div></br>";
                                    //        str += "</div> <br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Campus Office :</b> " + data['Campus Office'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Account Details :</b> " + data['Account Details'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Account Office :</b> " + data['Account Office'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D7_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D8_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D9_Remarks'] + "</div></br>";
                                    //        str += "</div> <br>";



                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>Faculty Admin :</b> " + data['Faculty Admin'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 80%;'><b>PG Office/UG office :</b> " + data['PGUGoffice'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 80%;'><b>Registrar :</b> " + data['Registrar'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "<div class='row' style='padding-left:15px;'>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D10_Remarks'] + "</div>";
                                    //        str += "<div style='width:30%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['D11_Remarks'] + "</div>";
                                    //        str += "<div style='width:40%;float: left;line-height: 100%;'><b style='color:blue;'>Remark :</b> " + data['R_Remarks'] + "</div></br>";
                                    //        str += "</div>";

                                    //        str += "</br></br>";
                                    //        str += "</div>";
                                    //        str += "</div></div>";

                                    //        return str;
                                    //    }
                                    //},
                                    {
                                        "sTitle": "Description", "mData": null, "sClass": "cls_width_desc", "bSortable": false, "mRender": function (data) {
                                            var str = "";
                                            str += "<div><div>";
                                            str += "<div class='row' style='padding-left:15px;'>";
                                            str += "<div><b>Library :</b> " + data['Library'] + "</div>";
                                            str += "<div><b>Workshops :</b> " + data['Workshops'] + "</div>";
                                            str += "<div><b>CEPT LAB :</b> " + data['CEPT LAB'] + "</div>";
                                            str += "<div><b>IT Office :</b> " + data['IT Office'] + "</div>";
                                            str += "<div><b>Hostel :</b> " + data['Hostel'] + "</div>";
                                            str += "<div><b>Student Services office (Id, etc) :</b> " + data['StudentServicesoffice(Id, etc)'] + "</div>";
                                            str += "<div><b>Campus Office :</b> " + data['Campus Office'] + "</div>";
                                            str += "<div><b>Account Details :</b> " + data['Account Details'] + "</div>";
                                            str += "<div><b>Account Office :</b> " + data['Account Office'] + "</div>";
                                            str += "<div><b>Faculty Admin :</b> " + data['Faculty Admin'] + "</div>";
                                            str += "<div><b>PG Office/UG office :</b> " + data['PGUGoffice'] + "</div>";
                                            str += "<div><b>Registrar :</b> " + data['Registrar'] + "</div></br>";
                                            str += "</div>";
                                            str += "</br></br>";
                                            str += "</div>";
                                            str += "</div></div>";

                                            return str;
                                        }
                                    },
                                    { "sTitle": "Semester", "mData": "semester_type", "sClass": "cls_desc", "bSortable": false },
                                    { "sTitle": "Year Semester", "mData": "year_semester", "sClass": "cls_desc", "bSortable": false },
                                    {
                                        "sTitle": "View", "mData": null, "sClass": "cls_width1", "bSortable": false, "mRender": function (data) {

                                            return '<center><button type="button" class="view_all">View</button></center>';

                                        }
                                    }





                                    //{ "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Mobile No ", "mData": "applicant_mobile_no", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Department Name", "mData": "department_name", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Remarks", "mData": "remarks", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Semester", "mData": "semester_type", "sClass": "cls_desc", "bSortable": false },
                                    //{ "sTitle": "Year Semester", "mData": "year_semester", "sClass": "cls_desc", "bSortable": false },
                                    /*{"sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false},*/
                                    //{
                                    //    "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
                                    //        if (data.status == "Approved") {

                                    //            var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }
                                    //        else if (data.status == "Pending") {
                                    //            var str = "";
                                    //            str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }
                                    //        else if (data.status == "On Hold") {
                                    //            var str = "";
                                    //            str += "<div style='float: left;border: 1px ridge #B5B9BB;height:23px;background-color:lightgreen;'><p'><b>" + data.status + "</b></p></div>";
                                    //            return str;
                                    //        }


                                    //    }
                                    //}
                                ]
                            });
                            $("#clearance_div").css("display", "");
                        }
                        else {
                            alert("Data Not Found selected Sem and Year.");
                            $("#clearance_div_onhold").css("display", "none");
                        }
                    } else {
                        alert("Data Not Found selected Sem and Year.");
                        $("#clearance_div_onhold").css("display", "none");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div id="course_select" class="panel panel-default">
        <div class="panel-heading">
            <strong><span class="panel-headingfont">Students Clearance From Status</span></strong>
        </div>
        <div style="padding: 15px;" id="div3">
            <div class="row">
                <div id="div_drpsem" class="form-group col-md-4">
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        Semester :
                    </div>
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drpsemester">
                        </select>
                    </div>
                </div>
                <div id="div_drpyear" class="form-group col-md-3">
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        Year :
                    </div>
                    <div class="col-md-8" style="padding: 0 0 0 0;">
                        <select class="chosen-select col-md-12" id="drpyear">
                        </select>
                    </div>
                </div>
                <div class="form-group col-md-3">
                    <button class="btn  btn-primary" type="button" id="btnRetrieve">
                        Search
                    </button>
                </div>
                
            </div>

             <div class="row">
                <div class="form-group col-md-6">
                    <button class="btn  btn-primary" type="button" id="btnapproved">
                        Download Approved
                    </button>
                    <button class="btn  btn-primary" type="button" id="btnpending">
                        Download Pending
                    </button>
                    <button class="btn  btn-primary" type="button" id="btnonhold">
                        Download On Hold
                    </button>
                </div>
                 
                
            </div>
        </div>
    </div>

     <div class="well" style="background-color: White;">
         <div id="div_tab" class="tabbable" style="display: block; width: 100%; margin-bottom: 20px;">
         <div id="div_myTab">

         </div>
              <div class="tab-content">

                  <div id="all" class="tab-pane">
                <div id="clearance_div_all" class="tab-pane">
                <table cellpadding="0" cellspacing="0" border="0" id="clearance_data_all" class="display table table-striped table-bordered table-hover" width="100%">
                <thead></thead>
                <tbody></tbody>
                </table>
                </div></div>


                  <div id="approved" class="tab-pane">
                <div id="clearance_div" class="tab-pane">
                <table cellpadding="0" cellspacing="0" border="0" id="clearance_data" class="display table table-striped table-bordered table-hover" width="100%">
                <thead></thead>
                <tbody></tbody>
                </table>
                </div></div>



                  <div id="pending" class="tab-pane">
                <div id="clearance_div_pending" class="tab-pane">
                <table cellpadding="0" cellspacing="0" border="0" id="clearance_data_pending" class="display table table-striped table-bordered table-hover" width="100%">
                <thead></thead>
                <tbody></tbody>
                </table>
                </div></div>

                  
                  <div id="onhold" class="tab-pane">
                <div id="clearance_div_onhold" class="tab-pane">
                <table cellpadding="0" cellspacing="0" border="0" id="clearance_data_onhold" class="display table table-striped table-bordered table-hover" width="100%">
                <thead></thead>
                <tbody></tbody>
                </table>
                </div></div>

        



              </div>

         </div>

    </div>
  
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_status" runat="server" clientidmode="Static" />
     <asp:Button ID="btn_download" runat="server" ClientIDMode="Static" Text="test" OnClick="btn_download_Click" />
    <asp:Button ID="btn_approved" ClientIDMode="Static" runat="server" OnClick="btn_approved_Click" />
    <asp:Button ID="btn_pending" ClientIDMode="Static" runat="server" OnClick="btn_pending_Click" />
    <asp:Button ID="btn_onhold" ClientIDMode="Static" runat="server" OnClick="btn_onhold_Click" />
</asp:Content>

