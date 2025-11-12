<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WSRefundDetails.aspx.cs" Inherits="Admin_Report_WSRefundDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../Js/loder.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/fixedcolumns/4.2.2/css/fixedColumns.dataTables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/fixedcolumns/4.2.2/js/dataTables.fixedColumns.min.js"></script>

    
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
           
            bind_ws_semdata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                course_wise_student_dtl();
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

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetStudentWiseFeesRefundDetails",
                data: "{sem_code: '" + semester + "',year_code:'" + year_code + "'}",
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

                    { "sTitle": "Student Code", "mData": "UserId", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Total Allocated Credits", "mData": "TotalAllocatedCredit", "bSortable": false },
                    { "sTitle": "Fees Waiver Credits", "mData": "TotalFeesWaiverCredit", "bSortable": false },
                    { "sTitle": "Total Paid Fees Amount", "mData": "TotalPaidFeesAmount", "bSortable": false },
                    { "sTitle": "Total Refund Amount Request", "mData": "TotalReFundAmount", "bSortable": false },
                    { "sTitle": "Bank Name", "mData": "BankName", "bSortable": false },
                    { "sTitle": "Account Number", "mData": "AccountNumber", "bSortable": false },
                    { "sTitle": "IFSC CODE", "mData": "IFSCCode", "bSortable": false },
                    { "sTitle": "Account Holder Name", "mData": "AccountHolderName", "bSortable": false },
                    { "sTitle": "Bank Address", "mData": "BankAddress", "bSortable": false },
                    //{
                    //    "sTitle": "Bank Details", "mData": null, "bSortable": false, "sWidth": "300px", mRender: function (data) {
                    //        var str = '<p><span>Bank Name : <b>' + data.BankName + '</b></span>'
                    //        str += '</br><span>Account Number : <b>' + data.AccountNumber + '</b></span>'
                    //        str += '</br><span>IFSC CODE : <b>' + data.IFSCCode + '</b></span>'
                    //        str += '</br><span>Account Holder Name : <b>' + data.AccountHolderName + '</b></span>'
                    //        str += '</br><span>Bank Address : <b>' + data.BankAddress + '</b></span>'
                    //        str += '</P>'
                    //        return str;
                            
                            
                    //    }
                    //},


                    {
                        "sTitle": "Remark", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Remark != '')
                            {
                                return '<textarea id=' + data.UserId + ' name="remark" rows="2" cols="50">' + data.Remark + '';
                            }
                            else {
                                return '<textarea id=' + data.UserId + ' name="remark" rows="2" cols="50">';
                            }
                        }
                    },

                    {
                        "sTitle": "Admin Department Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.AdminStatus == 'Y')
                            {
                                return '<span style=color:red;><b>Approved</b></span>';
                            }
                            else {
                                return '<span style=color:red;><b>Pending</b></span>';
                            }
                        }
                    },

                    {
                        "sTitle": "Account Department Status", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.AccountStatus == 'Y')
                            {
                                return '<span style=color:red;><b>Approved</b></span>';
                            }
                            else {
                                return '<span style=color:red;><b>Pending</b></span>';
                            }
                        }
                    },
                    {
                        "sTitle": "Remark Action", "mData": null, "bSortable": false, mRender: function (data) {
                            var actionstatus = 'R'
                            if (data.AdminStatus == 'Y' && data.AccountStatus == 'Y') {
                                return '';
                            }
                            return "<center><button type='button' onclick='sendremark(this, \"" + actionstatus + "\")' class='cls_btn_pdf btn btn-primary btn-small'>Remark</button></center>";
                            
                        }
                    },

                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                            var actionstatus ='A'
                            if (data.AdminStatus == 'N' && $('#hdnusertype').val() == 'A1')
                            {
                                return '<center><button type="button" id="' + data.UserId + '" onclick="sendremark(this,\'' + actionstatus + '\')" class="per_edit btn btn-primary btn-small">Approve</button></center>';
                            }
                            else if (data.AdminStatus == 'Y' && $('#hdnusertype').val() == 'A1')
                            {
                                return '';
                            }
                            else if (data.AccountStatus == 'Y' && $('#hdnusertype').val() == 'AC')
                            {
                                return '';
                            }
                            else if (data.AccountStatus == 'N' && $('#hdnusertype').val() == 'AC')
                            {
                                actionstatus = 'C'
                                return '<center><button type="button" id="' + data.UserId + '" onclick="sendremark(this,\'' + actionstatus + '\')" class="per_edit btn btn-primary btn-small">Approve</button></center>';
                            }
                            else
                            {
                                return '';
                            }
                        }
                    }
                    
                ]
            });
            $('#DataList').css('display', 'block');
            // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        
        function sendremark(element,status) {
            var row = element.closest('tr');
            var aData = oTable.fnGetData(row);
            

            var remark_details = "";
            var remark_id = aData["UserId"];
            if (status == 'R') {

                if ($('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }) == '') {
                    bootbox.alert("Please Enter Remark");
                    return false;
                }
            }

            remark_details =
            {
                "UserId": aData["UserId"],
                "remark": $('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                "status": status,
            };

            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/admin_remark",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',interested_remark_data: '" + json_submit_data + "'}",

                    dataType: "json",
                    success: function (data) {
                        if (data.d == true) {

                            if (status == 'R')
                            {
                                bootbox.alert("Remark Save Successfully")
                            }
                            else if (status == 'A')
                            {
                                $('#' + remark_id).css('display', 'none');
                                bootbox.alert("Admin Department Approved Successfully");
                            }
                            else if (status == 'C')
                            {
                                $('#' + remark_id).css('display', 'none');
                                bootbox.alert("Account Department Approved Successfully");
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

            //$('#hdn_instructor').val(row_data['instructor_code'].toString());
            //$('#hdn_instructor_name').val(row_data['instructor_name'].toString());
            //$('#hdn_dept').val(row_data['dept_name'].toString());
            //$('#hdn_sem').val(semester);
            //$('#hdn_year').val(year_code);

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Check Refund Status
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
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
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
                    <strong>Check Refund Details</strong>
                </div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>

</asp:Content>

