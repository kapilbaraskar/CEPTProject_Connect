<%@ Page Title="Clearance Request" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Clearance_Request_From_Students.aspx.cs" Inherits="Admin_Master_Clearance_Request_From_Students" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
     <script src="../../Js/loder.js" type="text/javascript"></script>
    <style type="text/css"> 
         .cls_width {
            width: 25% !important;
        }
         .cls_width_onhold {
            width: 45% !important;
        }

        .show_AC {
            display: none;
            width: 250px;
        }
        .cls_width_text
        {
            width: 15% !important;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var oTable1;
        var oTable2;
        var oTable3;
        var submitted_data = [];
        var sem = "";
        var year = "";
        var RetriveButtonClicked = false;
        $(document).ready(function () {

            //var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#approved'>Approved&nbsp;</a></li><li><a data-toggle='tab' href='#pending'>Pending &nbsp; </a></li><li><a data-toggle='tab' href='#onhold'>OnHold&nbsp;</a></li>" +

            //if ($("#hdnuserid").val() != "CU00200") {
            //    var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pending'>Pending&nbsp;</a></li><li><a data-toggle='tab' href='#onhold'> OnHold&nbsp; </a></li><li><a data-toggle='tab' href='#approved'>Approved&nbsp;</a></li>" +
            //        "</ul>";
            //    $("#div_myTab").html(strHtml);
            //    $("#pending").addClass("in active");

            //    get_pending("", "", "", "");
            //    get_onhold("", "", "", "");
            //    getSubmittedCheck("", "", "", "");
            //}
            //else if ($("#hdnuserid").val() == "CU00200") {
            //    var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pending'>Pending&nbsp;</a></li><li><a data-toggle='tab' href='#approved'>Approved&nbsp;</a></li>" +
            //        "</ul>";
            //    $("#div_myTab").html(strHtml);
            //    $("#pending").addClass("in active");
            //    get_all_approved_clearance_form_for_registrar_approved(sem, year, "", "");
            //    get_all_approved_clearance_form_for_registrar_pending(sem, year, "", "");
            //}
            
            GetDataAccordingly();
            bindyeardata_for_cross_reg();
            bindsemdata();
            if ($("#hdnuserid").val() == "CU00200") {
                //getClearanceSemYear();
            }
            

            if ($("#hdnuserid").val() != "AC004") {
                $("#div_drpdept").css("display", "none");
            }

            if ($("#hdnuserid").val() == "CU00200")
            {
                //get_all_approved_clearance_form_for_registrar_approved(sem, year, "", "Approved");
                //get_all_approved_clearance_form_for_registrar_pending(sem, year, "", "Pending");
                //$("#div_drpcourse").css('display', 'none');
                //$('#div_myTab').css('display', 'block');
                //$('.tab-content').css('display', 'none');
               // get_all_approved_clearance_form_for_registrar(sem, year, "", "");
            }
            else
            {
                //$('#div_myTab').css('display', 'block');
                ////getSubmittedCheck(sem, year, "", "");
                //get_pending("", "", "", "");
                //get_onhold("", "", "", "");
                //getSubmittedCheck("", "", "", "");
               
            }

            bindstudentid('');


            $("#dept_type").change(function () {
                bindstudentid($("#dept_type").val());
                GetDataAccordingly();
            });

            $('#btnRetrieve').on('click', function () {

                if ($('#drpsemester').val() == "") {
                    bootbox.alert('Please Select Semester.');
                    return false;
                }

                if ($('#drpyear').val() == "") {
                    bootbox.alert('Please Select Year.');
                    return false;
                }

                sem = $('#drpsemester').val();
                year = $('#drpyear').val();
                RetriveButtonClicked = true;
                if ($("#hdnuserid").val() == "CU00200") {
                    //$('#div_myTab').css('display', 'none');
                    //$('.tab-content').css('display', 'none');
                    get_all_approved_clearance_form_for_registrar_approved(sem, year, "", "");
                    get_all_approved_clearance_form_for_registrar_pending(sem, year, "", "");
                    // get_all_approved_clearance_form_for_registrar($('#drpsemester').val(), $('#drpyear').val(), $('#drstudent').val(), $('#status').val());
                }

                else {
                    //getSubmittedCheck($('#drpsemester').val(), $('#drpyear').val(), $('#drstudent').val(), $('#status').val());
                    $('#div_myTab').css('display', 'block');
                    get_pending($('#drpsemester').val(), $('#drpyear').val(), $('#drstudent').val(), $('#status').val());
                    get_onhold($('#drpsemester').val(), $('#drpyear').val(), $('#drstudent').val(), $('#status').val());
                    getSubmittedCheck($('#drpsemester').val(), $('#drpyear').val(), $('#drstudent').val(), $('#status').val());

                }


            });

            $('#drpsemester,#drpyear').on('change', function () {
                bindstudentid();
            });
        });
            function getClearanceSemYear() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_current_clearance_form_semester",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var sem_year_data = JSON.parse(data.d)

                            sem = sem_year_data[0]["sem_code"];
                            year = sem_year_data[0]["year_code"];

                            $('#drpsemester').val(sem_year_data[0]['sem_code'].toString());
                            $('#drpyear').val(sem_year_data[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

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

            function bindstudentid(dept_type) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_student_id_submitted_clearance_form",
                    async: false,
                    data: "{ sem_code:'" + $('#drpsemester').val() + "', year_code: '" + $('#drpyear').val() + "', dept_type: '" + $('#dept_type').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var student_data = JSON.parse(data.d)
                            $('#drstudent').empty().append($("<option></option>").val("").html("-- Please Select Student ID --"));
                            for (var i = 0; i < student_data.length; i++) {
                                $('#drstudent').append($("<option></option>").val(student_data[i]["user_id"]).html(student_data[i]["user_id"]));
                            }
                            $('#drstudent').chosen();
                            $('#drstudent').val('').trigger("liszt:updated");
                        } else {
                            $('#drstudent').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                            $('#drstudent').chosen();
                            $('#drstudent').val('').trigger("liszt:updated");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

        
            function get_all_approved_clearance_form_for_registrar(sem, year, user_id, status) {
                $("#clearance_div_").css("display", "block");
                $("#clearance_data_").css("display", "block");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_all_approved_clearance_form_for_registrar",
                    data: "{ sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "', status: '" + status + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var submitted_form_data = JSON.parse(data.d)
                            if (submitted_form_data.length > 0) {
                                if (oTable != null) {
                                    oTable.fnDestroy();
                                    $("#clearance_data_").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_inital_pc" width="100%"><thead></thead><tbody> </tbody></table>');
                                }

                                oTable = $("#clearance_data_").dataTable({
                                    "bPaginate": true,
                                    "bSortable": false,
                                    "bSort": false,
                                    //"bStateSave": true,
                                    "iDisplayLength": 60,
                                    //"sDom": 't',
                                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                    //"sScrollY": '400px',
                                    //"oLanguage": {
                                    //    "sSearch": "Search all columns with Space:"
                                    //},
                                    //"sDom": 'T<"clear">lfrtip',
                                    //"oTableTools": {
                                    //    "aButtons": [
                                    //        //"copy",
                                    //        "print",
                                    //        {
                                    //            "sExtends": "collection",
                                    //            "sButtonText": 'Export',
                                    //            "aButtons": ["xls"]
                                    //        }
                                    //    ]
                                    //},
                                    "aaData": submitted_form_data,
                                    "aoColumns": [
                                        {
                                            "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
                                        },
                                        {
                                            "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
                                        },
                                        {
                                            "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Student Remarks", "mData": "value", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.status == "Approved") {
                                                    str += "<p>" + data.remarks + "</p>";
                                                } else {
                                                    str += '<input type="text" class="cls_remarks"/>';
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
                                                if (data.status == "Approved") {
                                                    var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                                    return str;
                                                }
                                                else if (data.status == "Pending") {
                                                    var str = "";
                                                    str += '<button type="button" onclick="rowClick_A(this,oTable)"  style="margin-left:35px;">Approve</button>';
                                                    //str += '<button type="button" onclick="rowClick_R(this,oTable)">Reject</button>&nbsp;&nbsp;';
                                                    //str += '<button type="button" onclick="rowClick_H(this,oTable)">OnHold</button>';
                                                    return str;
                                                }
                                                //else if (data.aData.status == "On Hold") {
                                                //    var str = "";
                                                //    str += '<div style="float:left;"><button type="button" onclick="rowClick_A(this,oTable)" style="">Approve</button></div>';
                                                //    str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:10px;height:23px;background-color:yellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;color:red;'><b>" + data.aData.status + "</b></p></div>";
                                                //    str += "<br/><br/><p style='color:red;'><b><u>Remarks:</u></b></p>";
                                                //    str += "<p><b>" + data.aData.remarks + "</b></p>";
                                                //    return str;
                                                //}
                                            }
                                        }
                                    ]
                                });
                                $("#clearance_data_").css("display", "");
                            } else {
                                alert("Data Not Found selected Sem and Year.");
                                $("#clearance_data_").css("display", "none");
                                $("#clearance_div_").css("display", "none");
                            }
                        } else {
                            alert("Data Not Found selected Sem and Year.");
                            $("#clearance_data_").css("display", "none");
                            $("#clearance_div_").css("display", "none");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function get_all_approved_clearance_form_for_registrar_pending(sem, year, user_id, status) {
                status = "Pending";
                $("#clearance_div_").css("display", "block");
                $("#clearance_data_pending").css("display", "block");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_all_approved_clearance_form_for_registrar",
                    data: "{ sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "', status: '" + status + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var submitted_form_data = JSON.parse(data.d)
                            if (submitted_form_data.length > 0) {
                                if (oTable1 != null) {
                                    oTable1.fnDestroy();
                                    $("#clearance_data_pending").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_inital_pc" width="100%"><thead></thead><tbody> </tbody></table>');
                                }

                                oTable1 = $("#clearance_data_pending").dataTable({
                                    "bPaginate": true,
                                    "bSortable": false,
                                    "bSort": false,
                                    //"bStateSave": true,
                                    "iDisplayLength": 60,
                                    //"sDom": 't',
                                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                    //"sScrollY": '400px',
                                    //"oLanguage": {
                                    //    "sSearch": "Search all columns with Space:"
                                    //},
                                    //"sDom": 'T<"clear">lfrtip',
                                    //"oTableTools": {
                                    //    "aButtons": [
                                    //        //"copy",
                                    //        "print",
                                    //        {
                                    //            "sExtends": "collection",
                                    //            "sButtonText": 'Export',
                                    //            "aButtons": ["xls"]
                                    //        }
                                    //    ]
                                    //},
                                    "aaData": submitted_form_data,
                                    "aoColumns": [
                                        {
                                            "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
                                        },
                                        {
                                            "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
                                        },
                                        {
                                            "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Student Remarks", "mData": "value", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.status == "Approved") {
                                                    str += "<p>" + data.remarks + "</p>";
                                                } else {
                                                    str += '<input type="text" class="cls_remarks"/>';
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
                                                if (data.status == "Approved") {
                                                    var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                                    return str;
                                                }
                                                else if (data.status == "Pending") {
                                                    var str = "";
                                                    str += '<button type="button" onclick="rowClick_A(this,oTable1)"  style="margin-left:35px;">Approve</button>';
                                                    //str += '<button type="button" onclick="rowClick_R(this,oTable1)">Reject</button>&nbsp;&nbsp;';
                                                    //str += '<button type="button" onclick="rowClick_H(this,oTable1)">OnHold</button>';
                                                    return str;
                                                }
                                                //else if (data.aData.status == "On Hold") {
                                                //    var str = "";
                                                //    str += '<div style="float:left;"><button type="button" onclick="rowClick_A(this,oTable1" style="">Approve</button></div>';
                                                //    str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:10px;height:23px;background-color:yellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;color:red;'><b>" + data.aData.status + "</b></p></div>";
                                                //    str += "<br/><br/><p style='color:red;'><b><u>Remarks:</u></b></p>";
                                                //    str += "<p><b>" + data.aData.remarks + "</b></p>";
                                                //    return str;
                                                //}
                                            }
                                        }
                                    ]
                                });
                                $("#clearance_data_").css("display", "");
                            } else {
                                alert("Pending Data Not Found selected Sem and Year.");
                                $("#clearance_data_pending").css("display", "none");
                                $("#clearance_div_pending").css("display", "none");

                            }
                        } else {
                            alert("Pending Data Not Found selected Sem and Year.");
                            $("#clearance_data_pending").css("display", "none");
                            $("#clearance_div_pending").css("display", "none");

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            function get_all_approved_clearance_form_for_registrar_approved(sem, year, user_id, status) {
                status = "Approved";
                $("#clearance_data").css("display", "block");
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_all_approved_clearance_form_for_registrar",
                    data: "{ sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "', status: '" + status + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var submitted_form_data = JSON.parse(data.d)
                            if (submitted_form_data.length > 0) {
                                if (oTable3 != null) {
                                    oTable3.fnDestroy();
                                    $("#clearance_data").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_inital_pc" width="100%"><thead></thead><tbody> </tbody></table>');
                                }

                                oTable3 = $("#clearance_data").dataTable({
                                    "bPaginate": true,
                                    "bSortable": false,
                                    "bSort": false,
                                    //"bStateSave": true,
                                    "iDisplayLength": 60,
                                    //"sDom": 't',
                                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                    //"sScrollY": '400px',
                                    //"oLanguage": {
                                    //    "sSearch": "Search all columns with Space:"
                                    //},
                                    //"sDom": 'T<"clear">lfrtip',
                                    //"oTableTools": {
                                    //    "aButtons": [
                                    //        //"copy",
                                    //        "print",
                                    //        {
                                    //            "sExtends": "collection",
                                    //            "sButtonText": 'Export',
                                    //            "aButtons": ["xls"]
                                    //        }
                                    //    ]
                                    //},
                                    "aaData": submitted_form_data,
                                    "aoColumns": [
                                        {
                                            "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
                                        },
                                        {
                                            "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
                                        },
                                        {
                                            "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Student Remarks", "mData": "value", "sClass": "cls_desc", "bSortable": false//mail
                                        },
                                        {
                                            "sTitle": "Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.status == "Approved") {
                                                    str += "<p>" + data.remarks + "</p>";
                                                } else {
                                                    str += '<input type="text" class="cls_remarks"/>';
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
                                                if (data.status == "Approved") {
                                                    var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                                    return str;
                                                }
                                                else if (data.status == "Pending") {
                                                    var str = "";
                                                    str += '<button type="button" onclick="rowClick_A(this,oTable3)"  style="margin-left:35px;">Approve</button>';
                                                    //str += '<button type="button" onclick="rowClick_R(this,oTable)">Reject</button>&nbsp;&nbsp;';
                                                    //str += '<button type="button" onclick="rowClick_H(this,oTable)">OnHold</button>';
                                                    return str;
                                                }
                                                //else if (data.aData.status == "On Hold") {
                                                //    var str = "";
                                                //    str += '<div style="float:left;"><button type="button" onclick="rowClick_A(this,oTable3)" style="">Approve</button></div>';
                                                //    str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:10px;height:23px;background-color:yellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;color:red;'><b>" + data.aData.status + "</b></p></div>";
                                                //    str += "<br/><br/><p style='color:red;'><b><u>Remarks:</u></b></p>";
                                                //    str += "<p><b>" + data.aData.remarks + "</b></p>";
                                                //    return str;
                                                //}
                                            }
                                        }
                                    ]
                                });
                                $("#clearance_data").css("display", "");
                            } else {
                                alert("Approved Data Not Found selected Sem and Year.");
                                $("#clearance_data").css("display", "none");
                                $("#clearance_div").css("display", "none");
                            }
                        } else {
                            alert("Approved Data Not Found selected Sem and Year.");
                            $("#clearance_data").css("display", "none");
                            $("#clearance_div").css("display", "none");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            //function getSubmittedCheck(sem, year, user_id, status) {
                
            //    if ($("#dept_type").val() == "" && $("#hdnuserid").val() == "AC004") {
            //        alert('Please select Department');
            //    }

            //    $.ajax({
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/get_submitted_student_clearance_form",
            //        data: "{ sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "', dept_type: '" + $("#dept_type").val() + "', status: '" + status + "'}",
            //        dataType: "json",
            //        async: false,
            //        success: function (data) {
            //            if (data.d != "") {
            //                var submitted_form_data = JSON.parse(data.d)
            //                if (submitted_form_data.length > 0) {
            //                    if (oTable != null) {
            //                        oTable.fnDestroy();
            //                        $("#clearance_data").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_inital_pc" width="100%"><thead></thead><tbody> </tbody></table>');
            //                    }

            //                    oTable = $("#clearance_data").dataTable({
            //                        "bPaginate": false,
            //                        "bSortable": false,
            //                        "bSort": false,
            //                        //"bStateSave": true,
            //                        //"iDisplayLength": 60,
            //                        //"sDom": 't',
            //                        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            //                        //"sScrollY": '400px',
            //                        //"oLanguage": {
            //                        //    "sSearch": "Search all columns with Space:"
            //                        //},
            //                        //"sDom": 'T<"clear">lfrtip',
            //                        //"oTableTools": {
            //                        //    "aButtons": [
            //                        //        //"copy",
            //                        //        "print",
            //                        //        {
            //                        //            "sExtends": "collection",
            //                        //            "sButtonText": 'Export',
            //                        //            "aButtons": ["xls"]
            //                        //        }
            //                        //    ]
            //                        //},

            //                        "aaData": submitted_form_data,
            //                        "aoColumns": [




            //                            //{
            //                            //    "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
            //                            //},
            //                            //{
            //                            //    "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
            //                            //},
            //                            {
            //                                "sTitle": "Student Details", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (data) {
            //                                    var str = "";
            //                                    var mail = data.mail;
            //                                    var alternet_mail = data.alternet_mail;
            //                                    var user_id = data.user_id;

            //                                    var user_name = data.user_name;
            //                                    var applicant_mobile_no = data.applicant_mobile_no;
            //                                    str += "<div>";
            //                                    str += "<p><b>Student Code : </b> " + user_id + "</p>";
            //                                    str += "<p><b>Student Name : </b> " + user_name + "</p>";
            //                                    str += "<p><b>Email ID : </b> " + mail + "</p>";
            //                                    str += "<p><b>Alternet Email ID : </b> " + alternet_mail + "</p>";
            //                                    str += "<p><b>Mobile No : </b> " + applicant_mobile_no + "</p>";
            //                                    str += "</div>";
            //                                    return str;
            //                                }
            //                            },
            //                            //{
            //                            //    "sTitle": "Alternate Email ID", "mData": "alternet_mail", "sClass": "cls_desc", "bSortable": false//mail
            //                            //},
            //                            //{
            //                            //    "sTitle": "Mobile No", "mData": "applicant_mobile_no", "sClass": "cls_desc", "bSortable": false//mail
            //                            //},//return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description + '';
            //                            {
            //                                "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false
            //                            },
            //                            //{
            //                            //    "sTitle": "Student Remarks", "mData": "value", "sClass": "cls_desc", "bSortable": false
            //                            //},

            //                            {
            //                                "sTitle": "Student Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                    var str = "";
            //                                    if (data.value != '') {
            //                                        str += '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.value + '';
            //                                    }
            //                                    else {
            //                                        str += '';
            //                                    }
            //                                    return str;
            //                                }
            //                            },

            //                            {
            //                                "sTitle": "Account Details", "mData": null, "sClass": "show_AC", "bSortable": false, "mRender": function (data) {
            //                                    var str = "";
            //                                    if (data.account_details != undefined && data.account_details != null) {

            //                                        var bank_details = JSON.parse(data.account_details);
            //                                        for (var i = 0; i < 5; i++) {
            //                                            str += "<div>";
            //                                            str += "<p><b>" + bank_details[i]["key"] + " : </b> " + bank_details[i]["value"] + "</p>";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                    else {
            //                                        return str;
            //                                    }

            //                                }
            //                            },
            //                            {
            //                                "sTitle": "Documents", "mData": null, "sClass": "show_AC", "bSortable": false, "mRender": function (data) {
            //                                    var str = "";
            //                                    str += '<button type="button" onclick="Download(this,oTable)">Download Documents</button>';
            //                                    return str;
            //                                }
            //                            },
            //                            {
            //                                "sTitle": "Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                    var str = "";
            //                                    if (data.status == "Approved" && data.status != null && data.status != undefined) {
            //                                        if (data.remarks != null && data.remarks != undefined) {
            //                                            str += "<p>" + data.remarks + "</p>";
            //                                        }
            //                                        else {
            //                                            str += "";
            //                                        }

            //                                    }
            //                                    else {
            //                                        str += '<textarea class="cls_remarks"/>';
            //                                    }
            //                                    return str;
            //                                }
            //                            },
            //                            {
            //                                "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
            //                                    if (data.status == "Approved") {

            //                                        var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
            //                                        return str;
            //                                    }
            //                                    else if (data.status == "Pending") {
            //                                        var str = "";
            //                                        str += '<button type="button" onclick="rowClick_A(this,oTable)">Approve</button>&nbsp;&nbsp;';
            //                                        //str += '<button type="button" onclick="rowClick_R(this,oTable)">Reject</button>&nbsp;&nbsp;';
            //                                        str += '<button type="button" onclick="rowClick_H(this,oTable)">OnHold</button>';
            //                                        return str;
            //                                    }
            //                                    else if (data.status == "On Hold") {
            //                                        var str = "";
            //                                        str += '<div style="float:left;"><button type="button" onclick="rowClick_A(this,oTable)" style="">Approve</button></div>';
            //                                        str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:10px;height:23px;background-color:yellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;color:red;'><b>" + data.status + "</b></p></div>";
            //                                        str += "<br/><br/><p style='color:red;'><b><u>Remarks:</u></b></p>";
            //                                        str += "<p><b>" + data.remarks + "</b></p>";
            //                                        return str;
            //                                    }


            //                                }
            //                            }
            //                        ]
            //                    });
            //                    $("#clearance_div").css("display", "");
            //                    if ($("#hdnusertype").val() == "AC") {
            //                        $(".show_AC").css('display', 'block');
            //                        if ($('#dept_type').val() == "D5") {
            //                            $(".show_AC").css('display', 'none');
            //                        }
            //                    }
            //                } else {
            //                    alert("Data Not Found selected Sem and Year.");
            //                    $("#clearance_div").css("display", "none");
            //                }
            //            } else {
            //                alert("Data Not Found selected Sem and Year.");
            //                $("#clearance_div").css("display", "none");
            //            }
            //        },
            //        error: function (result) {
            //            alert(result);
            //        }
            //    });
            //}


            function getSubmittedCheck(sem, year, user_id, status) {
                if ($("#dept_type").val() == "" && $("#hdnuserid").val() == "AC004") {
                    alert('Please select Department');
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_submitted_student_clearance_form_new",
                    data: "{ sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "', dept_type: '" + $("#dept_type").val() + "', status: 'Approved'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var submitted_form_data = JSON.parse(data.d)
                            if (submitted_form_data.length > 0) {
                                if (oTable3 != null) {
                                    oTable3.fnDestroy();
                                    $("#clearance_data").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_inital_pc" width="100%"><thead></thead><tbody> </tbody></table>');
                                }

                                oTable3 = $("#clearance_data").dataTable({
                                    "bPaginate": true,
                                    "bSortable": false,
                                    "bSort": false,
                                    "iDisplayLength": 60,
                                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                    "aaData": submitted_form_data,
                                    "aoColumns": [




                                        //{
                                        //    "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
                                        //},
                                        //{
                                        //    "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
                                        //},
                                        {
                                            "sTitle": "Student Details", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                var mail = data.mail;
                                                var alternet_mail = data.alternet_mail;
                                                var user_id = data.user_id;

                                                var user_name = data.user_name;
                                                var applicant_mobile_no = data.applicant_mobile_no;
                                                str += "<div>";
                                                str += "<p><b>Student Code : </b> " + user_id + "</p>";
                                                str += "<p><b>Student Name : </b> " + user_name + "</p>";
                                                str += "<p><b>Email ID : </b> " + mail + "</p>";
                                                str += "<p><b>Alternet Email ID : </b> " + alternet_mail + "</p>";
                                                str += "<p><b>Mobile No : </b> " + applicant_mobile_no + "</p>";
                                                if (data.semester_type == 'M') {
                                                    str += "<p><b>Semester : </b>Monsoon</p>";
                                                }
                                                else { str += "<p><b>Semester : </b>Spring</p>"; }
                                                str += "<p><b>Year : </b> " + data.year_semester + "</p>";
                                                str += "<p><b>Department Name : </b> " + data.department_name + "</p>";
                                                str += "</div>";
                                                return str;
                                            }
                                        },




                                        //{
                                        //    "sTitle": "Alternate Email ID", "mData": "alternet_mail", "sClass": "cls_desc", "bSortable": false//mail
                                        //},
                                        //{
                                        //    "sTitle": "Mobile No", "mData": "applicant_mobile_no", "sClass": "cls_desc", "bSortable": false//mail
                                        //},//return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description + '';
                                        {
                                            "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false
                                        },
                                        //{
                                        //    "sTitle": "Student Remarks", "mData": "value", "sClass": "cls_desc", "bSortable": false
                                        //},

                                        {
                                            "sTitle": "Student Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.value != '') {
                                                    str += '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.value + '';
                                                }
                                                else {
                                                    str += '';
                                                }
                                                return str;
                                            }
                                        },

                                        {
                                            "sTitle": "Account Details", "mData": null, "sClass": "show_AC", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.account_details != undefined && data.account_details != null) {

                                                    var bank_details = JSON.parse(data.account_details);
                                                    for (var i = 0; i < 5; i++) {
                                                        str += "<div>";
                                                        str += "<p><b>" + bank_details[i]["key"] + " : </b> " + bank_details[i]["value"] + "</p>";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                                else {
                                                    return str;
                                                }

                                            }
                                        },
                                        {
                                            "sTitle": "Documents", "mData": null, "sClass": "show_AC", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                str += '<button type="button" onclick="Download(this,oTable3)">Download Documents</button>';
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.status == "Approved" && data.status != null && data.status != undefined) {
                                                    if (data.remarks != null && data.remarks != undefined) {
                                                        str += "<p>" + data.remarks + "</p>";
                                                    }
                                                    else {
                                                        str += "";
                                                    }

                                                }
                                                else {
                                                    str += '<textarea class="cls_remarks"/>';
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
                                                if (data.status == "Approved") {

                                                    var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                                    return str;
                                                }
                                                else if (data.status == "Pending") {
                                                    var str = "";
                                                    str += '<button type="button" onclick="rowClick_A(this,oTable3)">Approve</button>&nbsp;&nbsp;';
                                                    //str += '<button type="button" onclick="rowClick_R(this,oTable)">Reject</button>&nbsp;&nbsp;';
                                                    str += '<button type="button" onclick="rowClick_H(this,oTable3)">OnHold</button>';
                                                    return str;
                                                }
                                                else if (data.status == "On Hold") {
                                                    var str = "";
                                                    str += '<div style="float:left;"><button type="button" onclick="rowClick_A(this,oTable3)" style="">Approve</button></div>';
                                                    str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:10px;height:23px;background-color:yellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;color:red;'><b>" + data.status + "</b></p></div>";
                                                    str += "<br/><br/><p style='color:red;'><b><u>Remarks:</u></b></p>";
                                                    str += "<p><b>" + data.remarks + "</b></p>";
                                                    return str;
                                                }


                                            }
                                        }
                                    ]
                                });
                                $("#clearance_div").css("display", "");
                                if ($("#hdnusertype").val() == "AC") {
                                    $(".show_AC").css('display', 'block');
                                    if ($('#dept_type').val() == "D5") {
                                        $(".show_AC").css('display', 'none');
                                    }
                                }
                            } else {
                                alert("Approved Data Not Found selected Sem and Year.");
                                $("#clearance_div").css("display", "none");
                            }
                        } else {
                            alert("Approved Data Not Found selected Sem and Year.");
                            $("#clearance_div").css("display", "none");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function get_pending(sem, year, user_id, status) {
                if ($("#dept_type").val() == "" && $("#hdnuserid").val() == "AC004") {
                    alert('Please select Department');
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_submitted_student_clearance_form_new",
                    data: "{sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "', dept_type: '" + $("#dept_type").val() + "', status: 'Pending'}",
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




                                        //{
                                        //    "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
                                        //},
                                        //{
                                        //    "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
                                        //},
                                        {
                                            "sTitle": "Student Details", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                var mail = data.mail;
                                                var alternet_mail = data.alternet_mail;
                                                var user_id = data.user_id;

                                                var user_name = data.user_name;
                                                var applicant_mobile_no = data.applicant_mobile_no;
                                                str += "<div>";
                                                str += "<p><b>Student Code : </b> " + user_id + "</p>";
                                                str += "<p><b>Student Name : </b> " + user_name + "</p>";
                                                str += "<p><b>Email ID : </b> " + mail + "</p>";
                                                str += "<p><b>Alternet Email ID : </b> " + alternet_mail + "</p>";
                                                str += "<p><b>Mobile No : </b> " + applicant_mobile_no + "</p>";
                                                if (data.semester_type == 'M') {
                                                    str += "<p><b>Semester : </b>Monsoon</p>";
                                                }
                                                else { str += "<p><b>Semester : </b>Spring</p>"; }
                                                str += "<p><b>Year : </b> " + data.year_semester + "</p>";
                                                str += "<p><b>Department Name : </b> " + data.department_name + "</p>";
                                                str += "</div>";
                                                return str;
                                            }
                                        },
                                        //{
                                        //    "sTitle": "Alternate Email ID", "mData": "alternet_mail", "sClass": "cls_desc", "bSortable": false//mail
                                        //},
                                        //{
                                        //    "sTitle": "Mobile No", "mData": "applicant_mobile_no", "sClass": "cls_desc", "bSortable": false//mail
                                        //},//return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description + '';
                                        {
                                            "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false
                                        },
                                        //{
                                        //    "sTitle": "Student Remarks", "mData": "value", "sClass": "cls_desc", "bSortable": false
                                        //},

                                        {
                                            "sTitle": "Student Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.value != '') {
                                                    str += '<textarea id="w3review" name="w3review" rows="4" cols="50" style="height:146px;">' + data.value + '';
                                                }
                                                else {
                                                    str += '';
                                                }
                                                return str;
                                            }
                                        },

                                        {
                                            "sTitle": "Account Details", "mData": null, "sClass": "show_AC", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.account_details != undefined && data.account_details != null) {

                                                    var bank_details = JSON.parse(data.account_details);
                                                    for (var i = 0; i < 5; i++) {
                                                        str += "<div>";
                                                        str += "<p><b>" + bank_details[i]["key"] + " : </b> " + bank_details[i]["value"] + "</p>";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                                else {
                                                    return str;
                                                }

                                            }
                                        },
                                        {
                                            "sTitle": "Documents", "mData": null, "sClass": "show_AC", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                str += '<button type="button" onclick="Download(this,oTable1)">Download Documents</button>';
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Remarks", "mData": null, "bSortable": false, "sClass": "cls_width_text", "mRender": function (data) {
                                                var str = "";
                                                if (data.status == "Approved" && data.status != null && data.status != undefined) {
                                                    if (data.remarks != null && data.remarks != undefined) {
                                                        str += "<p>" + data.remarks + "</p>";
                                                    }
                                                    else {
                                                        str += "";
                                                    }

                                                }
                                                else {
                                                    str += '<textarea class="cls_remarks" style="width: 138px;height:146px;"/>';
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
                                                if (data.status == "Approved") {

                                                    var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                                    return str;
                                                }
                                                else if (data.status == "Pending") {
                                                    var str = "";
                                                    str += '<button type="button" onclick="rowClick_A(this,oTable1)">Approve</button>&nbsp;&nbsp;';
                                                    //str += '<button type="button" onclick="rowClick_R(this,oTable)">Reject</button>&nbsp;&nbsp;';
                                                    str += '<button type="button" onclick="rowClick_H(this,oTable1)">OnHold</button>';
                                                    return str;
                                                }
                                                else if (data.status == "On Hold") {
                                                    var str = "";
                                                    str += '<div style="float:left;"><button type="button" onclick="rowClick_A(this,oTable1)" style="">Approve</button></div>';
                                                    str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:10px;height:23px;background-color:yellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;color:red;'><b>" + data.status + "</b></p></div>";
                                                    str += "<br/><br/><p style='color:red;'><b><u>Remarks:</u></b></p>";
                                                    str += "<p><b>" + data.remarks + "</b></p>";
                                                    return str;
                                                }


                                            }
                                        }
                                    ]
                                });
                                $("#clearance_div").css("display", "");
                                if ($("#hdnusertype").val() == "AC") {
                                    $(".show_AC").css('display', 'block');
                                    if ($('#dept_type').val() == "D5") {
                                        $(".show_AC").css('display', 'none');
                                    }
                                }
                            } else {
                                alert("Pending Data Not Found selected Sem and Year.");
                                $("#clearance_div_pending").css("display", "none");
                            }
                        } else {
                            alert("Pending Data Not Found selected Sem and Year.");
                            $("#clearance_div_pending").css("display", "none");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function get_onhold(sem, year, user_id, status) {
                if ($("#dept_type").val() == "" && $("#hdnuserid").val() == "AC004") {
                    alert('Please select Department');
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_submitted_student_clearance_form_new",
                    data: "{sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "', dept_type: '" + $("#dept_type").val() + "', status: 'On Hold'}",
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
                                    "autoWidth": true,
                                    "aoColumns": [




                                        //{
                                        //    "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
                                        //},
                                        //{
                                        //    "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
                                        //},
                                        {
                                            "sTitle": "Student Details", "mData": null, "sClass": "cls_desc", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                var mail = data.mail;
                                                var alternet_mail = data.alternet_mail;
                                                var user_id = data.user_id;

                                                var user_name = data.user_name;
                                                var applicant_mobile_no = data.applicant_mobile_no;
                                                str += "<div>";
                                                str += "<p><b>Student Code : </b> " + user_id + "</p>";
                                                str += "<p><b>Student Name : </b> " + user_name + "</p>";
                                                str += "<p><b>Email ID : </b> " + mail + "</p>";
                                                str += "<p><b>Alternet Email ID : </b> " + alternet_mail + "</p>";
                                                str += "<p><b>Mobile No : </b> " + applicant_mobile_no + "</p>";
                                                if (data.semester_type == 'M') {
                                                    str += "<p><b>Semester : </b>Monsoon</p>";
                                                }
                                                else { str += "<p><b>Semester : </b>Spring</p>";}
                                                
                                                str += "<p><b>Year : </b> " + data.year_semester + "</p>";
                                                str += "<p><b>Department Name : </b> " + data.department_name + "</p>";
                                                str += "</div>";
                                                return str;
                                            }
                                        },
                                        //{
                                        //    "sTitle": "Alternate Email ID", "mData": "alternet_mail", "sClass": "cls_desc", "bSortable": false//mail
                                        //},
                                        //{
                                        //    "sTitle": "Mobile No", "mData": "applicant_mobile_no", "sClass": "cls_desc", "bSortable": false//mail
                                        //},//return '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.studio_description + '';
                                        {
                                            "sTitle": "Submitted Date", "mData": "created_date", "sClass": "cls_desc", "bSortable": false
                                        },
                                        //{
                                        //    "sTitle": "Student Remarks", "mData": "value", "sClass": "cls_desc", "bSortable": false
                                        //},

                                        {
                                            "sTitle": "Student Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.value != '') {
                                                    str += '<textarea id="w3review" name="w3review" rows="4" cols="50">' + data.value + '';
                                                }
                                                else {
                                                    str += '';
                                                }
                                                return str;
                                            }
                                        },

                                        {
                                            "sTitle": "Account Details", "mData": null, "sClass": "show_AC", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.account_details != undefined && data.account_details != null) {

                                                    var bank_details = JSON.parse(data.account_details);
                                                    for (var i = 0; i < 5; i++) {
                                                        str += "<div>";
                                                        str += "<p><b>" + bank_details[i]["key"] + " : </b> " + bank_details[i]["value"] + "</p>";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                                else {
                                                    return str;
                                                }

                                            }
                                        },
                                        {
                                            "sTitle": "Documents", "mData": null, "sClass": "show_AC", "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                str += '<button type="button" onclick="Download(this,oTable2)">Download Documents</button>';
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
                                                var str = "";
                                                if (data.status == "Approved" && data.status != null && data.status != undefined) {
                                                    if (data.remarks != null && data.remarks != undefined) {
                                                        str += "<p>" + data.remarks + "</p>";
                                                    }
                                                    else {
                                                        str += "";
                                                    }

                                                }
                                                else {
                                                    str += '<textarea class="cls_remarks"/>';
                                                }
                                                return str;
                                            }
                                        },
                                        {
                                            "sTitle": "Action", "mData": null, "sClass": "cls_width_onhold", "bSortable": false, "mRender": function (data) {
                                                if (data.status == "Approved") {

                                                    var str = "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:36px;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;'><b>" + data.status + "</b></p></div>";
                                                    return str;
                                                }
                                                else if (data.status == "Pending") {
                                                    var str = "";
                                                    str += '<button type="button" onclick="rowClick_A(this,oTable2)">Approve</button>&nbsp;&nbsp;';
                                                    //str += '<button type="button" onclick="rowClick_R(this,oTable)">Reject</button>&nbsp;&nbsp;';
                                                    str += '<button type="button" onclick="rowClick_H(this,oTable2)">OnHold</button>';
                                                    return str;
                                                }
                                                else if (data.status == "On Hold") {
                                                    var str = "";
                                                    str += '<div style="float:left;"><button type="button" onclick="rowClick_A(this,oTable2)" style="">Approve</button></div>';
                                                    str += "<div style='float: left;border: 1px ridge #B5B9BB;margin-left:10px;height:23px;background-color:yellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;color:red;'><b>" + data.status + "</b></p></div>";
                                                    str += "<br/><br/><p style='color:red;'><b><u>Remarks:</u></b></p>";
                                                    str += "<p><b>" + data.remarks + "</b></p>";
                                                    return str;
                                                }


                                            }
                                        }
                                    ]
                                });
                                $("#clearance_div").css("display", "");
                                if ($("#hdnusertype").val() == "AC") {
                                    $(".show_AC").css('display', 'block');
                                    if ($('#dept_type').val() == "D5") {
                                        $(".show_AC").css('display', 'none');
                                    }
                                }
                            } else {
                                alert("On Hold Data Not Found selected Sem and Year.");
                                $("#clearance_div_onhold").css("display", "none");
                            }
                        } else {
                            alert("On Hold Data Not Found selected Sem and Year.");
                            $("#clearance_div_onhold").css("display", "none");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
       

        function GetDataAccordingly() {
            if ($("#hdnuserid").val() != "CU00200") {
                var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pending'>Pending&nbsp;</a></li><li><a data-toggle='tab' href='#onhold'> OnHold&nbsp; </a></li><li><a data-toggle='tab' href='#approved'>Approved&nbsp;</a></li>" +
                    "</ul>";
                $("#div_myTab").html(strHtml);
                $('#div_myTab').css('display', 'block');
                $("#pending").addClass("in active");

                get_pending("", "", "", "");
                get_onhold("", "", "", "");
                getSubmittedCheck("", "", "", "");
            }
            else if ($("#hdnuserid").val() == "CU00200") {
                var strHtml = "<ul class='nav nav-tabs' id='myTab'><li class='active'><a data-toggle='tab' href='#pending'>Pending&nbsp;</a></li><li><a data-toggle='tab' href='#approved'>Approved&nbsp;</a></li>" +
                    "</ul>";
                $("#div_myTab").html(strHtml);
                $("#pending").addClass("in active");
                get_all_approved_clearance_form_for_registrar_approved(sem, year, "", "");
                get_all_approved_clearance_form_for_registrar_pending(sem, year, "", "");
            }
        }
        function Download(row, delTable) {
            var uid = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var s = delTable.fnGetData($(row).closest('tr')[0])['semester_type'];
            var y = delTable.fnGetData($(row).closest('tr')[0])['year_semester'];

            var param = {};
            param["uid"] = uid;
            param["s"] = s;
            param["y"] = y;

            $("#hfDocuments").val(JSON.stringify(param));

            $("#btnDownloadDocuments").click();
        }

        function rowClick_A(row, delTable) {
            var rowId = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var s = delTable.fnGetData($(row).closest('tr')[0])['semester_type'];
            var y = delTable.fnGetData($(row).closest('tr')[0])['year_semester'];

            var remarks = "";
            if ($("#hdnusertype").val() == "AC") {
                remarks = row.closest('tr').children[5].children[0].valueOf().value;
            } else {
                remarks = row.closest('tr').children[5].children[0].valueOf().value;
            }

            var r = confirm("Are you sure you want to Approve Clearance Request of '" + rowId + "' ?");
            if (r == true) {
                var action_request = { 'student_id': rowId, 'remarks': remarks, 'action': 'Approved', 'sem': s, 'year': y, 'dept_type': $("#dept_type").val() };
                actionRequest(action_request);
            }
        }

        function rowClick_R(row, delTable) {
            var rowId = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var s = delTable.fnGetData($(row).closest('tr')[0])['semester_type'];
            var y = delTable.fnGetData($(row).closest('tr')[0])['year_semester'];

            var remarks = "";
            if ($("#hdnusertype").val() == "AC") {
                remarks = row.closest('tr').children[5].children[0].valueOf().value;
            } else {
                remarks = row.closest('tr').children[5].children[0].valueOf().value;
            }

            var r = confirm("Are you sure you want to Reject Clearance Request of '" + rowId + "' ?");
            if (r == true) {
                var action_request = { 'student_id': rowId, 'remarks': remarks, 'action': 'Rejected', 'sem': s, 'year': y, 'dept_type': $("#dept_type").val() };
                actionRequest(action_request);
            }
        }

        function rowClick_H(row, delTable) {
            var rowId = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var s = delTable.fnGetData($(row).closest('tr')[0])['semester_type'];
            var y = delTable.fnGetData($(row).closest('tr')[0])['year_semester'];

            var remarks = "";
            if ($("#hdnusertype").val() == "AC") {
                remarks = row.closest('tr').children[5].children[0].valueOf().value;
            } else {
                remarks = row.closest('tr').children[5].children[0].valueOf().value;
            }

            var r = confirm("Are you sure you want to keep on hold Clearance Request of '" + rowId + "' ?");
            if (r == true) {
                var action_request = { 'student_id': rowId, 'remarks': remarks, 'action': 'On Hold', 'sem': s, 'year': y, 'dept_type': $("#dept_type").val() };
                actionRequest(action_request);
            }
        }

        function actionRequest(action_request) {

            action_request = JSON.stringify(action_request);

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_action_for_clearance_form",
                data: "{action_request:'" + action_request + "'}",
                dataType: "json",
                success: function (data) {
                    var dataa = JSON.parse(data.d);
                    if (dataa.status == "0") {
                        alert(dataa.message);
                        //window.location.reload();
                        if (RetriveButtonClicked) {
                            $('#btnRetrieve').click();
                        }
                        else {
                            GetDataAccordingly();
                        }
                    } else {
                        alert(dataa.message);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="course_select" class="panel panel-default">
        <div class="panel-heading">
            <strong><span class="panel-headingfont">Clearance Request From Students</span></strong>
        </div>
        <div style="padding: 15px;" id="div3">
            <div class="row">
                <div id="div_drpsem" class="form-group col-md-4">
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        Semester :
                    </div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drpsemester">
                        </select>
                    </div>
                </div>
                <div id="div_drpyear" class="form-group col-md-3">
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        Year :
                    </div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                    <div class="col-md-8" style="padding: 0 0 0 0;">
                        <select class="chosen-select col-md-12" id="drpyear">
                        </select>
                    </div>
                </div>
                <div id="div_drpcourse" class="form-group col-md-3">
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        Student :
                    </div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drstudent">
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div id="" class="form-group col-md-4">
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        Status :
                    </div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="status">
                            <option value="">Please Select Status</option>
                            <option value="Pending">Pending</option>
                            <option value="On Hold">On Hold</option>
                            <option value="Approved">Approved</option>
                        </select>
                    </div>
                </div>
                <div id="div_drpdept" class="form-group col-md-4">
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        Department :
                    </div>
                    <%--</div>
                    <div class="form-group col-md-2">--%>
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="dept_type">
                            <%--<option value="">Please select Department</option>--%>
                            <option value="D9">Account</option>
                            <option value="D5">Hostel</option>
                        </select>
                    </div>
                </div>
              
            </div>
            <div class="row">
                  <div style="margin-left: 43%;" class="form-group col-md-3">
                    <button class="btn  btn-primary" type="button" id="btnRetrieve">
                        Search
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="div_myTab">

         </div>
      <div class="tab-content" style="overflow:visible !important;">
                  <div id="approved" class="tab-pane">
                <div id="clearance_div" class="tab-pane" style="overflow:auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="clearance_data" class="display table table-striped table-bordered table-hover" width="100%">
                <thead></thead>
                <tbody></tbody>
                </table>
                </div></div>



                  <div id="pending" class="tab-pane" style="overflow:auto;">
                <div id="clearance_div_pending" class="tab-pane">
                <table cellpadding="0" cellspacing="0" border="0" id="clearance_data_pending" class="display table table-striped table-bordered table-hover" width="120%">
                <thead></thead>
                <tbody></tbody>
                </table>
                </div></div>

                  
                  <div id="onhold" class="tab-pane" style="overflow:auto;">
                <div id="clearance_div_onhold" class="tab-pane">
                <table cellpadding="0" cellspacing="0" border="0" id="clearance_data_onhold" class="display table table-striped table-bordered table-hover" width="130%">
                <thead></thead>
                <tbody></tbody>
                </table>
                </div></div>

        



              </div>

  <div id="clearance_div_" class="tab-pane" style="overflow:auto;">
        <table cellpadding="0" cellspacing="0" border="0" id="clearance_data_" class="display table table-striped table-bordered table-hover"
            width="100%">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

     <%-- <div id="process_clearance_div" class="tab-pane" style="overflow:auto;">
        <table cellpadding="0" cellspacing="0" border="0" id="proc_clearance_data" class="display table table-striped table-bordered table-hover"
            width="100%">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>--%>
    <asp:HiddenField ID="hfDocuments" runat="server" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadDocuments_Click" ClientIDMode="Static" />
</asp:Content>

