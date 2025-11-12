<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ApplyProvisionalCertificateDtl.aspx.cs" Inherits="Admin_Report_ApplyProvisionalCertificateDtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../Js/loder.js" type="text/javascript"></script>

    <script type="text/javascript">
        var oTable;
        var oTable1;
        $(document).ready(function () {
            bindprogrammedata();
            binddepartment();
            Apply_student_certificate_dtl();
            $('#btnreterive').on('click', function () {
           
                Apply_student_certificate_dtl();
                return false;
            });
          

           // return false;
        });
        function bind_ws_semdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
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
        function Apply_student_certificate_dtl() {
            $('#DataList').css('display', 'none');

            

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetApplyForProvisionalCertificateDel",
                data: "{dept_code:'" + $('#drpdepartment').val() + "',prog_code:'" + $('#drpprog').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {

                        Display_report(data.d);
                        
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
                "scrollX": true,
                "aaData": JSON.parse(data),
                "fixedColumns": {
                    "rightColumns": 4 // Fix the last 3 columns
                },
                "aoColumns": [

                    { "sTitle": "Student Code", "mData": "Student_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Faculty Department Admin Status", "mData": "FAStatustxt", "bSortable": false },
                    { "sTitle": "Admin Department Status", "mData": "AdminStatustxt", "bSortable": false },
                    { "sTitle": "Account Department Status", "mData": "AccountStatustxt", "bSortable": false },
                    { "sTitle": "Examination Departmetn Status", "mData": "ExaminationStatustxt", "bSortable": false },
                    {
                        "sTitle": "Student Remark", "mData": null, "bSortable": false, mRender: function (data) {
                            
                            
                            if ($('#hdnusertype').val().toUpperCase() == 'A1' && data.Student_UGPG_Remark != '')
                            {
                                return '<textarea id=' + data.Student_id + ' name="remark" rows="2" cols="50">' + data.Student_UGPG_Remark + '';
                            }
                            else if ($('#hdnusertype').val().toUpperCase() == 'FA' && data.Student_FA_Remark != '')
                            {
                                return '<textarea id=' + data.Student_id + ' name="remark" rows="2" cols="50">' + data.Student_FA_Remark + '';
                            }
                            else if ($('#hdnusertype').val().toUpperCase() == 'AC' && data.Student_AC_Remark != '')
                            {
                                return '<textarea id=' + data.Student_id + ' name="remark" rows="2" cols="50">' + data.Student_AC_Remark + '';
                            }
                            else if ($('#hdnusertype').val().toUpperCase() == 'EXAM' && data.Student_Exam_Remark != '') {
                                return '<textarea id=' + data.Student_id + ' name="remark" rows="2" cols="50">' + data.Student_Exam_Remark + '';
                            }
                            else
                            {
                                return '<textarea id=' + data.Student_id + ' name="remark" rows="2" cols="50">';
                            }
                            
                        }
                    },
                    {
                        "sTitle": "Internal Remark", "mData": null, "bSortable": false, mRender: function (data)
                        {
                            if (data.Remark != '') {
                                return '<textarea id=INT_' + data.Student_id + ' name="remark" rows="2" cols="50">' + data.Remark + '';
                            }
                            else {
                                return '<textarea id=INT_' + data.Student_id + ' name="remark" rows="2" cols="50">';
                            }
                        }
                    },
                    {
                        "sTitle": "Student Remark", "mData": null, "bSortable": false, mRender: function (data) {
                            var actionstatus = 'R'
                            //if (data.AdminStatus == 'Y' && data.AccountStatus == 'Y') {
                            //    return '';
                            //}
                            return "<center><button type='button' onclick='sendremark(this, \"" + actionstatus + "\", \"" + $('#hdnusertype').val() + "\")' class='cls_btn_pdf btn btn-primary btn-small'>Student Remark</button></center>";
                            
                        }
                    },
                    {
                        "sTitle": "Internal Remark", "mData": null, "bSortable": false, mRender: function (data) {
                            var actionstatus = 'IN'
                            return "<center><button type='button' onclick='sendremark(this, \"" + actionstatus + "\", \"" + $('#hdnusertype').val() + "\")' class='cls_btn_pdf btn btn-primary btn-small'>Internal Remark</button></center>";

                        }
                    },

                    {
                        "sTitle": "Hold", "mData": null, "bSortable": false, mRender: function (data) {
                            var actionstatus = 'H'
                            return "<center><button type='button' onclick='sendremark(this, \"" + actionstatus + "\", \"" + $('#hdnusertype').val() + "\")' class='cls_btn_pdf btn btn-primary btn-small'>Hold</button></center>";

                        }
                    },

                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                            var actionstatus ='A'
                            if ((data.FAStatus == 'N' || data.FAStatus == 'H') && $('#hdnusertype').val() == 'FA')
                            {
                                return '<center><button type="button" id="' + data.Student_id + '" onclick="sendremark(this,\'' + actionstatus + '\',\'' + $('#hdnusertype').val() + '\')" class="per_edit btn btn-primary btn-small">Approve</button></center>';
                            }
                            else if (data.FAStatus == 'A' && $('#hdnusertype').val() == 'FA')
                            {
                                return 'Approved';
                            }

                            if ((data.AdminStatus == 'N' || data.AdminStatus == 'H') && $('#hdnusertype').val() == 'A1')
                            {
                                if (data.FAStatus == 'N' || data.FAStatus == 'H')
                                {
                                    return 'FA has not been approved.';
                                }
                                return '<center><button type="button" id="' + data.Student_id + '" onclick="sendremark(this,\'' + actionstatus + '\',\'' + $('#hdnusertype').val() + '\')" class="per_edit btn btn-primary btn-small">Approve</button></center>';
                            }
                            else if (data.AdminStatus == 'A' && $('#hdnusertype').val() == 'A1')
                            {
                                return 'Approved';
                            }
                            else if (data.AccountStatus == 'N' && $('#hdnusertype').val() == 'AC')
                            {
                                if (data.FAStatus == 'N' || data.FAStatus == 'H') {
                                    return 'FA has not been approved.';
                                }
                                else if (data.AdminStatus == 'N' || data.AdminStatus == 'H')
                                {
                                    return 'Admin has not been approved.';
                                }

                                return '<center><button type="button" id="' + data.Student_id + '" onclick="sendremark(this,\'' + actionstatus + '\',\'' + $('#hdnusertype').val() + '\')" class="per_edit btn btn-primary btn-small">Approve</button></center>';
                            }

                            else if (data.AccountStatus == 'A' && $('#hdnusertype').val() == 'AC')
                            {
                                return 'Approved';
                            }

                            else if (data.ExaminationStatus == 'N' && $('#hdnusertype').val() == 'exam')
                            {
                                if (data.FAStatus == 'N' || data.FAStatus == 'H') {
                                    return 'FA has not been approved.';
                                }
                                else if (data.AdminStatus == 'N' || data.AdminStatus == 'H') {
                                    return 'Admin has not been approved.';
                                }
                                else if (data.AccountStatus == 'N' || data.AccountStatus == 'H') {
                                    return 'Account Department has not been approved.';
                                }

                                return '<center><button type="button" id="' + data.Student_id + '" onclick="sendremark(this,\'' + actionstatus + '\',\'' + $('#hdnusertype').val() + '\')" class="per_edit btn btn-primary btn-small">Approve</button></center>';
                            }
                            else if (data.ExaminationStatus == 'H' && $('#hdnusertype').val() == 'exam')
                            {
                                return '<center><button type="button" id="' + data.Student_id + '" onclick="sendremark(this,\'' + actionstatus + '\',\'' + $('#hdnusertype').val() + '\')" class="per_edit btn btn-primary btn-small">Approve</button></center>';
                            }
                            else if (data.ExaminationStatus == 'A' && $('#hdnusertype').val() == 'exam')
                            {

                                //return 'Approved';
                                return '<center><button class="btn btn-primary" type="button" id=' + data.Student_id + ' onclick="rowclickPDF(this)">Download</button></center>';
                            }
                            else
                            {
                                return '';
                            }
                        }
                    },
                    {
                        "sTitle": "Student Submission Date", "mData": null, "bSortable": false, mRender: function (data)
                        {
                           
                            return data.CreatedDate;

                        }
                    },
                    {
                        "sTitle": "Remark Details", "mData": null, "bSortable": false, mRender: function (data) {

                            var str_FA = '';
                            var str_AC = '';
                            var str_EXAM = '';
                            var str_UGPG = '';

                            if (data.Student_FA_Remark != '')
                            {
                                str_FA = '<span style=color:blue> FA :' + data.Student_FA_Remark + ' </span> <br>';
                            }
                            if (data.Student_AC_Remark != '')
                            {
                                str_AC = '<span style=color:Red> AC : ' + data.Student_AC_Remark + ' </span> <br>';
                            }
                            if (data.Student_Exam_Remark != '')
                            {
                                str_EXAM = '<span style=color:Green> Exam : ' + data.Student_Exam_Remark + '</span> <br>';
                            }
                            if (data.Student_UGPG_Remark != '') {
                                str_UGPG = '<span style=color:Green> UGPG : ' + data.Student_UGPG_Remark + '</span>';
                            }
                            return str_FA + str_AC + str_EXAM + str_UGPG ;
                        }
                    },
                    {
                        "sTitle": "View ", "mData": null, "bSortable": false, mRender: function (data) {

                            var row_value = data.Student_id;
                            return '<center><button type="button" id=' + row_value + ' onclick="rowClick_view(this)" class="cls_btn_pdf btn btn-primary btn-small">View</button></center>';

                        }
                    },


                ]
            });
            $('#DataList').css('display', 'block');
           
        }        
        function sendremark(element, status, type) {
          
            var row = element.closest('tr');
            var aData = oTable.fnGetData(row);
            

            var remark_details = "";
            var remark_id = aData["Student_id"];
            if (status == 'R') {

                if ($('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }) == '') {
                    bootbox.alert("Please Enter Remark");
                    return false;
                }
            }
            else if (status == 'IN') {
                console.log(status + ' ' + remark_id);
                if ($('#INT_' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }) == '')
                {
                    bootbox.alert("Please Enter Internal Remark");
                    return false;
                }
            }

            var remarkdata = '';
            if (status == 'IN')
            {
                remarkdata = $('#INT_' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; });
            }
            else
            {
                remarkdata = $('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; });
            }
            remark_details =
            {
                "Student_id": aData["Student_id"],
                "remark": remarkdata,
                "status": status,
                "type": type,
            };

            
            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/ProvisionalCertificate_remark",
                    data: "{interested_remark_data: '" + json_submit_data + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == true) {

                            if (status == 'R')
                            {
                                bootbox.alert("Remark Save Successfully")
                            }
                            else if (status == 'A')
                            {
                                //$('#' + remark_id).css('display', 'none');
                                bootbox.alert("Approved Successfully");
                            }
                            else if (status == 'H')
                            {
                                //$('#' + remark_id).css('display', 'none');
                                bootbox.alert("Hold Successfully");
                            }
                           
                                return false;
                            
                        }
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

           

        }
        function get_credits_dtl() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_students_completed_credits_sgpa_cgpa_report_data",
                    data: "{enrollment_year : '',dept_code:'',prog_code:''}",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "") {
                            display_student_Credit(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }
        function display_student_Credit(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList1").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example1" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example1").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "aaData": JSON.parse(data),
                "aoColumns": columns,
                "footerCallback": function (row, data, start, end, display) {
                    var api = this.api();

                    // Calculate the total for the "Credits Completed" column (index 3)
                    var totalCreditsCompleted = api
                        .column(3, { page: 'current' })
                        .data()
                        .reduce(function (a, b) {
                            return parseFloat(a) + parseFloat(b);
                        }, 0);

                    // Update footer
                    $(api.column(3).footer()).html(totalCreditsCompleted.toFixed(2));
                }
            });

            // Show the modal after table setup
            $('#dataModal').modal('show');

            $('#DataList1').css('display', 'block');
        }
        function rowclickPDF(row) {

            var user_id = row.id;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/CreateProvisionalCertificatePDF",
                async: false,
                data: "{ user_id: '" + user_id + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null && data.d != "")
                    {
                        var path = JSON.parse(data.d)
                        const pdfUrl = window.location.origin + '/ProvisionalCertificate/' + path.htmlContent;
                        const link = document.createElement('a');
                        link.href = pdfUrl;
                        //link.download = inst + '_' + yearcode + '.pdf'; // Set the file name to download
                        link.download = 'ProvisionalCertificate.pdf'; // Set the file name to download
                        link.style.display = 'none';
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link); // Clean up

                    }
                },
                error: function (result) {
                    hideLoader();
                    alert(result);
                }
            });


            //$('#btndownloadpdf_without').click();
        }
        function rowClick_view(row) {
            console.log(row.id);
            var url = "StudentAccountLedger.aspx?userid=" + row.id ;
            window.open(url, "_blank");
        }
        function binddepartment() {
            var user_url = '../../WebService.asmx/Get_department_data';
            if ($('#hdnusertype').val() == 'FA') {
                user_url = '../../WebService.asmx/Get_cur_FA_department_wise_data'
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: user_url,
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var sem_data = JSON.parse(data.d)

                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));

                        for (var i = 0; i < sem_data.length; i++) {
                            $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                        }

                        $('#drpdepartment').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Apply For Provisional Certificate
            </h1>
        </div>
          </div>
        
     <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Filter Criteria</strong>
                </div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                             <td>
                                Program :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
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
                    <strong>Apply For Provisional Certificate</strong>
                </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>


    <div id="dataModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="dataModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="dataModalLabel">Student Credits</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div id="DataList1">
                    <!-- The table will be dynamically inserted here -->
                    <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example1" width="100%">
                        <thead></thead>
                        <tbody></tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>

            
        </div>
</asp:Content>

