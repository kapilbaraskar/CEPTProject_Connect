<%@ Page Title=" All Approved Clearance Request" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="All_Approved_Clearance_Request.aspx.cs" Inherits="Admin_Report_All_Approved_Clearance_Request" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <style type="text/css">
        .cls_desc_width {
            width: 301px;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var submitted_data = [];
        var sem = "";
        var year = "";

        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            getClearanceSemYear();

            get_all_approved_clearance_form_for_Account(sem, year, "");

            bindstudentid();

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

            //function get_all_approved_clearance_form_for_Account(sem, year, user_id) {
            //    $.ajax({
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/get_all_approved_clearance_form_for_account",
            //        data: "{ sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "'}",
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

            //                    if ($("#hdnuserid").val() == "CU00200") {
            //                        oTable = $("#clearance_data").dataTable({
            //                            "bPaginate": true,
            //                            "bSortable": false,
            //                            "bSort": false,
            //                            //"bStateSave": true,
            //                            "iDisplayLength": 60,
            //                            //"sDom": 't',
            //                            //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            //                            "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            //                            //"sScrollY": '400px',
            //                            "oLanguage": {
            //                                "sSearch": "Search all columns with Space:"
            //                            },
            //                            //"sDom": 'T<"clear">lfrtip',
            //                            //"oTableTools": {
            //                            //    "aButtons": [
            //                            //        //"copy",
            //                            //        "print",
            //                            //        {
            //                            //            "sExtends": "collection",
            //                            //            "sButtonText": 'Export',
            //                            //            "aButtons": ["xls"]
            //                            //        }
            //                            //    ]
            //                            //},
            //                            "aaData": submitted_form_data,
            //                            "aoColumns": [
            //                                {
            //                                    "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
            //                                },
            //                                {
            //                                    "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
            //                                },
            //                                {
            //                                    "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false//mail
            //                                },
            //                                {
            //                                    "sTitle": "Student Submitted Date", "mData": "created_date", "bSortable": false
            //                                },
            //                                {
            //                                    "sTitle": "Registrar Approved Date", "mData": "registrar_created_date", "sClass": "cls_desc", "bSortable": false
            //                                },
            //                                {
            //                                    "sTitle": "Account Processed Date", "mData": null, "bSortable": false, "sClass": "cls_desc_width", "mRender": function (data) {
            //                                        var str = "";

            //                                        if (data.refund_processed == "Y") {
            //                                            str += "<div>";
            //                                            str += "<p>" + data.last_modified_date + "</p>";
            //                                            str += "</div>";
            //                                        } else {
            //                                            str += "<div>";
            //                                            str += "<p>Pending</p>";
            //                                            str += "</div>";
            //                                        }

            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Bank Name", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 0; i < 1; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Account Holder Name", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 1; i < 2; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Account No", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 2; i < 3; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "IFSC Code", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 3; i < 4; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Bank Address", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 4; i < 5; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        if (data.refund_processed == "Y") {
            //                                            str += "<p>" + data.refund_remarks + "</p>";
            //                                        } else {
            //                                            str += '';
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
            //                                        if (data.refund_processed == "Y") {
            //                                            var str = "<div style='border: 1px ridge #B5B9BB;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;text-align: center;'><b>Processed</b></p></div>";
            //                                            return str;
            //                                        }
            //                                        else {
            //                                            var str = "";
            //                                            var str = "<div style='border: 1px ridge #B5B9BB;height:23px;background-color:lightyellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;text-align: center;'><b>Pending</b></p></div>";
            //                                            return str;
            //                                        }
            //                                    }
            //                                }
            //                            ]
            //                        });
            //                    } else {
            //                        oTable = $("#clearance_data").dataTable({
            //                            "bPaginate": true,
            //                            "bSortable": false,
            //                            "bSort": false,
            //                            //"bStateSave": true,
            //                            "iDisplayLength": 60,
            //                            //"sDom": 't',
            //                            "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
            //                            //"sScrollY": '400px',
            //                            "oLanguage": {
            //                                "sSearch": "Search all columns with Space:"
            //                            },
            //                            //"sDom": 'T<"clear">lfrtip',
            //                            //"oTableTools": {
            //                            //    "aButtons": [
            //                            //        //"copy",
            //                            //        "print",
            //                            //        {
            //                            //            "sExtends": "collection",
            //                            //            "sButtonText": 'Export',
            //                            //            "aButtons": ["xls"]
            //                            //        }
            //                            //    ]
            //                            //},
            //                            "aaData": submitted_form_data,
            //                            "aoColumns": [
            //                                {
            //                                    "sTitle": "Student Code", "mData": "user_id", "sClass": "cls_desc", "bSortable": false
            //                                },
            //                                {
            //                                    "sTitle": "Student Name", "mData": "user_name", "sClass": "cls_desc", "bSortable": false//user_name
            //                                },
            //                                {
            //                                    "sTitle": "Email ID", "mData": "mail", "sClass": "cls_desc", "bSortable": false//mail
            //                                },
            //                                {
            //                                    "sTitle": "Student Submitted Date", "mData": "created_date", "bSortable": false
            //                                },
            //                                {
            //                                    "sTitle": "Registrar Approved Date", "mData": "registrar_created_date", "sClass": "cls_desc", "bSortable": false
            //                                },
            //                                {
            //                                    "sTitle": "Account Processed Date", "mData": null, "bSortable": false, "sClass": "cls_desc_width", "mRender": function (data) {
            //                                        var str = "";

            //                                        if (data.refund_processed == "Y") {
            //                                            str += "<div>";
            //                                            str += "<p>" + data.last_modified_date + "</p>";
            //                                            str += "</div>";
            //                                        } else {
            //                                            str += "<div>";
            //                                            str += "<p>Pending</p>";
            //                                            str += "</div>";
            //                                        }

            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Bank Name", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 0; i < 1; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Account Holder Name", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 1; i < 2; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Account No", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 2; i < 3; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "IFSC Code", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 3; i < 4; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Bank Address", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        var bank_details = JSON.parse(data.value);
            //                                        for (var i = 4; i < 5; i++) {
            //                                            str += "<div>";
            //                                            str += "<p>" + bank_details[i]["value"] + "</p>  ";
            //                                            str += "</div>";
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Remarks", "mData": null, "bSortable": false, "mRender": function (data) {
            //                                        var str = "";
            //                                        if (data.refund_processed == "Y") {
            //                                            str += "<p>" + data.refund_remarks + "</p>  ";
            //                                        } else {
            //                                            str += '<input type="text" class="cls_remarks"/>';
            //                                        }
            //                                        return str;
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
            //                                        if (data.refund_processed == "Y") {
            //                                            var str = "<div style='border: 1px ridge #B5B9BB;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;text-align: center;'><b>Processed</b></p></div>";
            //                                            return str;
            //                                        }
            //                                        else {
            //                                            var str = "";
            //                                            str += '<button type="button" onclick="rowClick_P(this,oTable)">Process</button>&nbsp;&nbsp;';
            //                                            return str;
            //                                        }
            //                                    }
            //                                },
            //                                {
            //                                    "sTitle": "Clearance Certificate", "mData": null, "sClass": "cls_width", "bSortable": false, "mRender": function (data) {
            //                                            var str = "";
            //                                            str += '<button type="button" onclick="rowClick_Download(this,oTable)">Download</button>&nbsp;&nbsp;';
            //                                            return str;
            //                                    }
            //                                }
            //                            ]
            //                        });
            //                    }
            //                    $("#clearance_div").css("display", "");
            //                } else {

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
            //    //$('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            //}



            function get_all_approved_clearance_form_for_Account(sem, year, user_id) {
                var typepros = $('#drptype').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_all_approved_clearance_form_for_account",
                    data: "{ sem_code:'" + sem + "', year_code: '" + year + "', student_id: '" + user_id + "',type:'" + typepros+"'}",
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
                                var ColumnVisible = $('#hdnusertype').val() == "FA" || $('#hdnusertype').val() == "A1" ? false : true;
                                if ($("#hdnuserid").val() == "CU00200") {
                                    oTable = $("#clearance_data").dataTable({
                                        "bPaginate": true,
                                        "bSortable": false,
                                        "bSort": false,
                                        //"bStateSave": true,
                                        "iDisplayLength": 60,
                                        //"sDom": 't',
                                        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                        //"sScrollY": '400px',
                                        "oLanguage": {
                                            "sSearch": "Search all columns with Space:"
                                        },
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
                                                "sTitle": "Student Submitted Date", "mData": "created_date", "bSortable": false
                                            },
                                            {
                                                "sTitle": "Registrar Approved Date", "mData": "registrar_created_date", "sClass": "cls_desc", "bSortable": false
                                            },
                                            {
                                                "sTitle": "Account Processed Date", "mData": null, "bSortable": false, "sClass": "cls_desc_width", "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";

                                                    if (data.refund_processed == "Y") {
                                                        str += "<div>";
                                                        str += "<p>" + data.last_modified_date + "</p>";
                                                        str += "</div>";
                                                    } else {
                                                        str += "<div>";
                                                        str += "<p>Pending</p>";
                                                        str += "</div>";
                                                    }

                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Bank Name", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 0; i < 1; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Account Holder Name", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 1; i < 2; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Account No", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 2; i < 3; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "IFSC Code", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 3; i < 4; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Bank Address", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 4; i < 5; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Remarks", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    if (data.refund_processed == "Y") {
                                                        str += "<p>" + data.refund_remarks + "</p>";
                                                    } else {
                                                        str += '';
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    if (data.refund_processed == "Y")
                                                    {
                                                        var str = "<div style='border: 1px ridge #B5B9BB;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;text-align: center;'><b>Processed</b></p></div>";
                                                        return str;
                                                    }
                                                    else {
                                                        var str = "";
                                                        var str = "<div style='border: 1px ridge #B5B9BB;height:23px;background-color:lightyellow;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;text-align: center;'><b>Pending</b></p></div>";
                                                        return str;
                                                    }
                                                }
                                            }
                                        ]
                                    });
                                } else {
                                    oTable = $("#clearance_data").dataTable({
                                        "bPaginate": true,
                                        "bSortable": false,
                                        "bSort": false,
                                        //"bStateSave": true,
                                        "iDisplayLength": 60,
                                        //"sDom": 't',
                                        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                                        //"sScrollY": '400px',
                                        "oLanguage": {
                                            "sSearch": "Search all columns with Space:"
                                        },
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
                                                "sTitle": "Student Submitted Date", "mData": "created_date", "bSortable": false
                                            },
                                            {
                                                "sTitle": "Registrar Approved Date", "mData": "registrar_created_date", "sClass": "cls_desc", "bSortable": false
                                            },
                                            {
                                                "sTitle": "Account Processed Date", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "sClass": "cls_desc_width", "mRender": function (data) {
                                                    var str = "";

                                                    if (data.refund_processed == "Y") {
                                                        str += "<div>";
                                                        str += "<p>" + data.last_modified_date + "</p>";
                                                        str += "</div>";
                                                    } else {
                                                        str += "<div>";
                                                        str += "<p>Pending</p>";
                                                        str += "</div>";
                                                    }

                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Bank Name", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 0; i < 1; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Account Holder Name", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 1; i < 2; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Account No", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 2; i < 3; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "IFSC Code", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 3; i < 4; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Bank Address", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    var bank_details = JSON.parse(data.value);
                                                    for (var i = 4; i < 5; i++) {
                                                        str += "<div>";
                                                        str += "<p>" + bank_details[i]["value"] + "</p>  ";
                                                        str += "</div>";
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Remarks", "mData": null, "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    if (data.refund_processed == "Y") {
                                                        str += "<p>" + data.refund_remarks + "</p>  ";
                                                    } else {
                                                        str += '<input type="text" class="cls_remarks"/>';
                                                    }
                                                    return str;
                                                }
                                            },
                                            {
                                                "sTitle": "Action", "mData": null, "sClass": "cls_width", "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    if (data.refund_processed == "Y") {
                                                        var str = "<div style='border: 1px ridge #B5B9BB;height:23px;background-color:lightgreen;'><p style='margin-left:5px;margin-right:5px;margin-top:1px;text-align: center;'><b>Processed</b></p></div>";
                                                        return str;
                                                    }
                                                    else {
                                                        var str = "";
                                                        str += '<button type="button" onclick="rowClick_P(this,oTable)">Process</button>&nbsp;&nbsp;';
                                                        return str;
                                                    }
                                                }
                                            },
                                            {
                                                "sTitle": "Clearance Certificate", "mData": null, "sClass": "cls_width", "bSortable": false, "bVisible": ColumnVisible, "mRender": function (data) {
                                                    var str = "";
                                                    str += '<button type="button" onclick="rowClick_Download(this,oTable)">Download</button>&nbsp;&nbsp;';
                                                    return str;
                                                }
                                            }
                                        ]
                                    });
                                }
                                $("#clearance_div").css("display", "");
                            } else {

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
                //$('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
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

            function bindstudentid() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_student_id_submitted_clearance_form",
                    async: false,
                    data: "{ sem_code:'" + $('#drpsemester').val() + "', year_code: '" + $('#drpyear').val() + "', dept_type: ''}",
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

                get_all_approved_clearance_form_for_Account($('#drpsemester').val(), $('#drpyear').val(), $('#drstudent').val());
               

            });

            $('#drpsemester,#drpyear').on('change', function () {
                bindstudentid();
            });


        });

        function rowClick_A(row, delTable) {
            var rowId = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var remarks = row.closest('tr').children[4].children[0].valueOf().value;
            var r = confirm("Are you sure you want to Approve Clearance Request of '" + rowId + "' ?");
            if (r == true) {
                var action_request = { 'student_id': rowId, 'remarks': remarks, 'action': 'Approved', 'sem': sem, 'year': year };
                actionRequest(action_request);
            }
        }

        function rowClick_R(row, delTable) {
            var rowId = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var remarks = row.closest('tr').children[4].children[0].valueOf().value;

            var r = confirm("Are you sure you want to Reject Clearance Request of '" + rowId + "' ?");
            if (r == true) {
                var action_request = { 'student_id': rowId, 'remarks': remarks, 'action': 'Rejected', 'sem': sem, 'year': year };
                actionRequest(action_request);
            }
        }

        function rowClick_H(row, delTable) {
            var rowId = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var remarks = row.closest('tr').children[4].children[0].valueOf().value;

            var r = confirm("Are you sure you want to On-Hold Clearance Request of '" + rowId + "' ?");
            if (r == true) {
                var action_request = { 'student_id': rowId, 'remarks': remarks, 'action': 'On Hold', 'sem': sem, 'year': year };
                actionRequest(action_request);
            }
        }

        function rowClick_P(row, delTable) {

            var rowId = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var s = delTable.fnGetData($(row).closest('tr')[0])['semester_type'];
            var y = delTable.fnGetData($(row).closest('tr')[0])['year_semester'];
            
            var remarks = "";
            if ($("#hdnusertype").val() == "AC") {
                remarks = row.closest('tr').children[11].children[0].valueOf().value;
            } else {
                remarks = row.closest('tr').children[11].children[0].valueOf().value;
            }

            var r = confirm("Are you sure you want to Process Clearance Request of '" + rowId + "' ?");
            if (r == true) {
                var action_request = { 'student_id': rowId, 'refund_remarks': remarks, 'action': 'Processed', 'sem': s, 'year': y, 'dept_type': $("#dept_type").val() };
                actionRequest(action_request);
            }
        }

        function rowClick_Download(row, delTable) {

            var rowId = delTable.fnGetData($(row).closest('tr')[0])['user_id'];
            var s = delTable.fnGetData($(row).closest('tr')[0])['semester_type'];
            var y = delTable.fnGetData($(row).closest('tr')[0])['year_semester'];

            $('#hdn_user_id').val(rowId);
            $('#hdn_sem_code').val(s);
            $('#hdn_year_code').val(y);
            $('#btn_download').click();
        }
        

        function actionRequest(action_request) {

            action_request = JSON.stringify(action_request);

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/process_for_clearance_form",
                data: "{action_request:'" + action_request + "'}",
                dataType: "json",
                success: function (data) {
                    var dataa = JSON.parse(data.d);
                    if (dataa.status == "0") {
                        alert(dataa.message);
                        window.location.reload();
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
            <strong><span class="panel-headingfont">Account Details of Clearance Request</span></strong>
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
                <div style="margin-left: 2%;" id="div_drptype" class="form-group col-md-3">
                    <div class="col-md-3" style="padding: 0 0 0 0;">
                        Type :
                    </div>
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drptype">
                           <%-- <option value="">--Please Select Type--</option>--%>
                            <option value="P">Pending</option>
                            <option value="PR">Processed</option>
                        </select>
                    </div>
                </div>

                <div style="margin-left: 12%;" class="form-group col-md-3">
                    <button class="btn  btn-primary" type="button" id="btnRetrieve">
                        Search
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div id="clearance_div" class="tab-pane" style="overflow: auto;">
        <table cellpadding="0" cellspacing="0" border="0" id="clearance_data" class="display table table-striped table-bordered table-hover"
            width="100%">
            <thead>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" />
    <div style="display: none;">
        <asp:Button ID="btn_download" runat="server" ClientIDMode="Static" Text="test" OnClick="Download_CC" />
    </div>
</asp:Content>

