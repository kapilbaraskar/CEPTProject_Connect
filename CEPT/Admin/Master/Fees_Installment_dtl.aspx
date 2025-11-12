<%@ Page Title="Installment Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Fees_Installment_dtl.aspx.cs" Inherits="Admin_Master_Fees_Installment_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js"></script>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script type="text/javascript">
        {
            var sem_code = '';
            var year_code = '';

            $(document).ready(function () {
                bindsemdata();
                binddepartment();
                bindprogrammedata();
                bindyeardata_for_cross_reg();
                bindtype();

                //$("#drpsemester").val("S");
                //$("#drpsemester").trigger("liszt:updated");

                //$("#drpyear").val("2022");
                //$("#drpyear").trigger("liszt:updated");

                //$("#drptype").val("S");
                //$("#drptype").trigger("liszt:updated");

                $('#btnreterive').on('click', function () {
                    if ($('#drptype').val() == 'F') {
                        $(".for_scholarship").css("display", "none");
                        get_data_for_installment();
                        return false;
                    }
                    else if ($('#drptype').val() == 'S') {
                        $("#hdn_sem").val($("#drpsemester").val());
                        $("#hdn_year").val($("#drpyear").val());
                        get_data_for_Scholarship();
                        return false;
                    }
                });

                $('#btn_download').on('click', function () {
                    var selectedStudents = [];
                    $('input[type=checkbox]:checked').each(function (i, ob) {
                        selectedStudents.push(ob.classList[1]);
                    });

                    if (selectedStudents.length > 0) {
                        $("#hdn_student_ids").val('');
                        $("#hdn_student_ids").val(selectedStudents);
                        $("#btnDownloadExcelDocuments").click();
                        return false;
                    } else {
                        alert("Please select Student IDs.");
                        return false;
                    }
                });

            });


            function get_data_for_installment() {

                sem_code = $('#drpsemester').val();
                if (sem_code == "") {
                    bootbox.alert('Please select semester')
                    $('#drpsemester').focus();
                    return false;
                }
                year_code = $('#drpyear').val();

                if (year_code == "") {
                    bootbox.alert('Please select Year of assign')
                    $('#drpyear').focus();
                    return false;
                }
                var type = $('#drptype').val();
                if (type == "") {
                    bootbox.alert('Please select Type')
                    $('#drptype').focus();
                    return false;
                }
                var user_id = '';
                var installment_no = '';

                $.ajax(
                    {
                        type: "POST",
                        url: "../../WebService.asmx/Get_Fees_installment_details",
                        data: "{user_id:'" + user_id + "',installment_no:'" + installment_no + "',sem_code:'" + sem_code + "',year_code:'" + year_code + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != null && data.d != "") {
                                installment_dtl(data.d);
                            }
                            else {
                                bootbox.alert('There is No data Found');
                                return false;
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                return false;
            }

            function rowClick(row) {
                var data_value = row.id.split('_');
                var origin = window.location.origin;
                //window.open(origin + '\\' + 'MedicalCertificate' + '\\' + $('#lbl_medical_Cert_file_name').text(),);
                // window.location = "Edit_Installment_dtl.aspx?c=" + data_value[0] + "&i=" + data_value[1] + "&s=" + sem_code + "&y=" + year_code,"_blank";
                window.open("Edit_Installment_dtl.aspx?c=" + data_value[0] + "&i=" + data_value[1] + "&s=" + sem_code + "&y=" + year_code, "_blank");
            }
            function rowClick_scholar(row) {
                var data_value = row.id;
                var origin = window.location.origin;

                window.open("Scholarship_amount_dtl.aspx?c=" + row.id + "&s=" + sem_code + "&y=" + year_code, "_blank");
            }
            // Display Data

            function installment_dtl(data) {

                if (oTable != null) {
                    oTable.fnDestroy();
                    $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
                }

                oTable = $("#example").dataTable({

                    "bPaginate": false,
                    "bSortable": false,
                    "bSort": false,
                    //"bStateSave": true,
                    "iDisplayLength": 60,
                    "sDom": 'b',
                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    "oLanguage": {
                        "sSearch": "Search all columns with Space:"
                    },
                    //"sDom": 'T<"clear">lfrtip',
                    "oTableTools": {
                        "aButtons": [
                            //"copy",
                            "print",
                            {
                                "sExtends": "collection",
                                "sButtonText": 'Export',
                                "aButtons": ["xls"]
                            }
                        ]
                    },
                    "aaData": JSON.parse(data),
                    "aoColumns": [
                        { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                        { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                        { "sTitle": "Total Fees Amount", "mData": "fees_amount", "bSortable": false },
                        { "sTitle": "Installment Fees Amount", "mData": "installmentfess", "bSortable": false },

                        {
                            "sTitle": "Installment Number", "mData": "installment_no", "bSortable": false, fnRender: function (data) {
                                var installment_number = data.aData.installment_no;
                                installment_number = installment_number.substring(installment_number.length, installment_number.length - 1);
                                return installment_number;
                            }
                        },
                        {
                            "sTitle": "Action", "mData": null, "bSortable": false, fnRender: function (data) {
                                var installment_number = data.aData.installment_no;
                                installment_number = installment_number.substring(installment_number.length, installment_number.length - 1);//is_installment1_paid
                                var installment_text = 'is_installment' + installment_number + '_paid';
                                if (data.aData[installment_text] != 'Y') {
                                    var but_id = data.aData["user_id"] + '_' + installment_number;
                                    return '<center><button type="button" id=' + but_id + ' onclick="rowClick(this)">Edit</button></center>';
                                }
                                else { return '<center>Paid</center>' };
                            }
                        }
                    ]
                }).rowGrouping();

                $('#DataList').css('display', 'block');

            }

            function bindtype() {
                $('#drptype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
                $('#drptype').append($("<option></option>").val("F").html("Fees Installment"));
                $('#drptype').append($("<option></option>").val("S").html("ScholarShip"));


                $('#drptype').chosen();
            }

            function get_data_for_Scholarship() {

                sem_code = $('#drpsemester').val();
                if (sem_code == "") {
                    bootbox.alert('Please select semester')
                    $('#drpsemester').focus();
                    return false;
                }
                year_code = $('#drpyear').val();

                if (year_code == "") {
                    bootbox.alert('Please select Year of assign')
                    $('#drpyear').focus();
                    return false;
                }
                var type = $('#drptype').val();
                if (type == "") {
                    bootbox.alert('Please select Type')
                    $('#drptype').focus();
                    return false;
                }
                var user_id = '';
                var installment_no = '';

                $.ajax(
                    {
                        type: "POST",
                        url: "../../WebService.asmx/Get_Fees_Scholarship_details",
                        data: "{user_id:'" + user_id + "',sem_code:'" + sem_code + "',year_code:'" + year_code + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != null && data.d != "") {
                                bind_scholarship_dtl(data.d);
                                $(".for_scholarship").css("display", "");
                            }
                            else {
                                bootbox.alert('There is No data Found');
                                return false;
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                return false;
            }

            function bind_scholarship_dtl(data) {

                if (oTable != null) {
                    oTable.fnDestroy();
                    $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
                }

                oTable = $("#example").dataTable({

                    "bPaginate": false,
                    "bSortable": false,
                    "bSort": false,
                    //"bStateSave": true,
                    "iDisplayLength": 60,
                    "sDom": 'b',
                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    "oLanguage": {
                        "sSearch": "Search all columns with Space:"
                    },
                    //"sDom": 'T<"clear">lfrtip',
                    "oTableTools": {
                        "aButtons": [
                            //"copy",
                            "print",
                            {
                                "sExtends": "collection",
                                "sButtonText": 'Export',
                                "aButtons": ["xls"]
                            }
                        ]
                    },
                    "aaData": JSON.parse(data),
                    "aoColumns": [
                        {
                            "sTitle": "Select", "mData": null, "sClass": "cls_select", "bSortable": false, fnRender: function (data) {
                                return '<center><input type="checkbox" class="chk_stud_ids ' + data.aData["user_id"] + '" name="user" class="chk_selection_user_id"/></center>';
                            }
                        },
                        { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                        { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                        { "sTitle": "Total Fees Amount", "mData": "fees_amount", "bSortable": false },

                        {
                            "sTitle": "Action", "mData": null, "bSortable": false, fnRender: function (data) {

                                return '<center><button type="button" id=' + data.aData["user_id"] + ' onclick="rowClick_scholar(this)">Edit</button></center>';

                            }
                        }
                    ]
                });

                $('#DataList').css('display', 'block');

            }

            function GetFileNameFromPath(strFilepath) {

                var objRE = new RegExp(/([^\/\\]+)$/);
                var strName = objRE.exec(strFilepath);

                if (strName == null) {
                    return null;
                }
                else {
                    return strName[0];
                }
            }

            function CheckMarksDocumentExtension(file) {
                try {
                    var flag = true;
                    var extension = file.substr((file.lastIndexOf('.') + 1));

                    switch (extension) {
                        case 'xlsx':
                            flag = true;
                            break;
                        default:
                            flag = false;
                    }

                    return flag;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                }
            }

            function UploadData() {
                try {
                    var fileToUpload = GetFileNameFromPath($('#userid_document').val());

                    if (CheckMarksDocumentExtension(fileToUpload)) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Upload_Scholarship_Data.ashx',
                            secureuri: false,
                            data: { 'UploadType': 'userid_document'},
                            fileElementId: 'userid_document',
                            dataType: 'json',
                            success: function (data, status) {
                                debugger;
                                if (data == null) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert("No Student IDs Found in Excel.");
                                    $('#userid_document').val('');
                                }
                                else if (data.length > 0) {
                                    if (data[0]["Remark"] == "Error while Uploading Excel.") {
                                        alert(data[0]["Remark"]);
                                        $('#userid_document').val('');
                                    }
                                    else if (data[0]["Remark"] != undefined) {
                                        $("#UploadingProgress").fadeOut(200);
                                        alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                        $('#userid_document').val('');
                                    }
                                    else {
                                        for (var i = 0; i < data.length; i++) {
                                            $("." + data[i]["USER_ID"]).prop("checked", true);
                                        }
                                        alert("Student IDs selected successfully.");
                                        $('#userid_document').val('');
                                    }
                                }
                                else {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                    $('#userid_document').val('');
                                }
                            },
                            error: function (data, status, e) {
                                $("#UploadingProgress").fadeOut(200);
                                alert(data.responseText);
                                //window.location.reload();
                                $('#userid_document').val('');
                            }
                        });
                    }
                    else {
                        alert('Invalid File Type. Please upload .xlsx file');
                        $('#userid_document').val('');
                    }
                    return false;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                    $('#userid_document').val('');
                }
            }

            function UploadScholarshipData() {
                try {
                    var fileToUpload = GetFileNameFromPath($('#scholarship_data').val());

                    if (CheckMarksDocumentExtension(fileToUpload)) {
                        $("#UploadingProgress").fadeIn(200);
                        $.ajaxFileUpload({
                            url: '../../Handler/Upload_Scholarship_Data.ashx',
                            secureuri: false,
                            data: { 'UploadType': 'scholarship_data' },
                            fileElementId: 'scholarship_data',
                            dataType: 'json',
                            success: function (data, status) {
                                debugger;
                                if (data == null) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert("No Scholarship data Found in Excel.");
                                    $('#scholarship_data').val('');
                                }
                                else if (data.length > 0) {
                                    if (data[0]["Remark"] == "Error while Uploading Excel.") {
                                        alert(data[0]["Remark"]);
                                        $('#scholarship_data').val('');
                                    }
                                    else if (data[0]["Remark"] != undefined) {
                                        $("#UploadingProgress").fadeOut(200);
                                        //alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                        bootbox.alert(data[0]["Remark"]);
                                        $('#scholarship_data').val('');
                                    }
                                    else {// if (data[0]["Remark"] == "Scholarship saved Successfully.") 
                                        debugger;
                                        bootbox.alert(data[0]["Remark"]);
                                        $('#scholarship_data').val('');
                                    }
                                }
                                else {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                    $('#scholarship_data').val('');
                                }
                            },
                            error: function (data, status, e) {
                                $("#UploadingProgress").fadeOut(200);
                                alert(data.responseText);
                                //window.location.reload();
                                $('#scholarship_data').val('');
                            }
                        });
                    }
                    else {
                        alert('Invalid File Type. Please upload .xlsx file');
                        $('#scholarship_data').val('');
                    }
                    return false;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                    $('#scholarship_data').val('');
                }
            }
            
        }
    </script>
    <style>
        label {
            float: left;
            clear: none;
            display: block;
            padding: 0px 1em 0px 8px;
        }

        input[type=radio],
        input.radio {
            float: left;
            clear: none;
        }

        .cls_select {
            width: 5% !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Student Wise Installment Details
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>Semester Type :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Type :</td>
                            <td>
                                <select class="chosen-select" id="drptype">
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

            <div class="panel-body for_scholarship" style="margin-top: 10px; border: 1px solid #ddd; height: 430px; display: none; border-left: 0px; border-right: 0px;">
                <table style="width:100%;">
                    <caption style="text-align:left;"><b><u>Steps:</u></b></caption>
                    <thead>
                        <tr style="text-align:left;">
                            <th>Sr No</th>
                            <th>Procedure</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>1.</td>
                            <td>Download Excel Format and Add Student IDs</td>
                            <td><a href="../../ExcelFormatFiles/ScholarshipUserID.xlsx" download>Download Excel Format</a></td>
                        </tr>
                        <tr>
                            <td>2.</td>
                            <td>Upload above Downloaded File to Select Student IDs </td>
                            <td><input id="userid_document" type="file" name="userid_document" onchange="javascript:return UploadData();" /></td>
                        </tr>
                        <tr>
                            <td>3.</td>
                            <td>Download Fees Data of Selected Student IDs</td>
                            <td><button style="line-height: 17px; width: 91px;" type="button" id="btn_download">Download</button></td>
                        </tr>
                        <tr>
                            <td>4.</td>
                            <td>APPROVE DATE Excel Format</td>
                            <td><b>DD-MM-YYYY</b></td>
                        </tr>
                         <tr>
                            <td>5.</td>
                            <td><b>Scholarship Type</b><br />
                                <ul>
                                <li>Tution Fee Waiver <br /></li>
                                <li>Sponsorship <br /></li>
                                <li>Special Case <br /></li>
                                <li>PSP SPONSORED <br /></li>
                                <li>Merit <br /></li>
                                <li>Means <br /></li>
                                <li>Government Seat <br /></li>
                                <li>SPECIAL COVID <br /></li>
                                <li>BUD Assistance <br /></li>
                                    </ul>
                            </td>
                             <td><b>Excel Format Scholarship Type </b><br />
                                 - TFW<br />
                                 - SPN<br />
                                 - SPL<br />
                                 - PSP<br />
                                 - MER<br />
                                 - MEAN<br />
                                 - GS<br />
                                 - COVID<br />
                                 - BUDA<br />
                             </td>
                        </tr>
                         <tr>
                            <td>6.</td>
                            <td>If any <b>Installment Paid</b> then write</td>
                            <td>- Y</td>
                        </tr>
                        <tr>
                            <td>7.</td>
                            <td>Excel Format <b>Mandatory Fields</b></td>
                            <td>- SCHOLARSHIP PERCENTAGE, APPROVE SCHOLARSHIP AMOUNT, APPROVE DATE,<br /> REF NO/VOUCHER NO, CARRY FORWARD AMOUNT, SCHOLARSHIP TYPE</td>
                        </tr>
                         <tr>
                            <td>8.</td>
                            <td>Upload Scholarship Data which you want to Save finally</td>
                            <td><input id="scholarship_data" type="file" name="scholarship_data" onchange="javascript:return UploadScholarshipData();" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <div id="DataList" style="display: none; overflow: auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>

        </div>

    </div>
    <asp:HiddenField ID="hdn_sem" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_year" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_student_ids" runat="server" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadExcelDocuments_Click" ClientIDMode="Static" />
</asp:Content>

