<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VF_Finance_Report_Print_new.aspx.cs" Inherits="Admin_Report_VF_Finance_Report_Print_new" %>

<html xmlns="https://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    
    <link href="../../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../../Style/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
    <link href="../../media/css/TableTools.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>
    <script src="../../Js/admin_report.js" type="text/javascript"></script>

    <script src="../../DesignJS/bootstrap.min.js" type="text/javascript"></script>
    <script src="../../DesignJS/ace-elements.min.js" type="text/javascript"></script>
    <script src="../../DesignJS/ace.min.js" type="text/javascript"></script>
    <script src="../../DesignJS/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="../../DesignJS/jquery.ui.touch-punch.min.js" type="text/javascript"></script>
    <script src="../../DesignJS/chosen.jquery.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="../../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../DesignJS/jquery.dataTables.columnFilter.js" type="text/javascript"></script>
    <script src="../../Scripts/dataTables.bootstrap.js" type="text/javascript"></script>
    <script src="../../media/js/ZeroClipboard.js" type="text/javascript"></script>
    <script src="../../media/js/TableTools.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindprogrammedata();

            setCurrentSemester();

            $('#btnreterive').on('click', function () {
                retrieve_VF_Data();
                return false;
            });

        });
    </script>
    <style type="text/css">
        @media screen {
            div.divHeader {
                display: none;
            }
            div.divFooter {
                display: none;
            }
        }
        @media print {
            div.divHeader {
                position: fixed;
                top: 0;
            }
            div.divFooter {
                position: fixed;
                bottom: 0;
            }
        }
    </style>
</head>
<body style="padding: 10px;">

    <form id="Form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        
        </asp:ScriptManager>
    </form>

    <div class="row-fluid" style="display:none;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;VF Report
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">
        <div class="panel panel-default " style="display:none;">
            
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div> <%--class="panel-body"--%>
                <div>
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
                                    Year of allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td class="cls_dept_prog">
                                    Department :
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                                <td>
                                    Programme :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                    <button class="btn btn-primary" type="submit" id="btn_print">
                                        Print
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>

        <div id="div_stud_list" class="panel panel-default" style="display:none;">
            
            <div class="panel-heading">
                <strong>VF List</strong>
            </div>

            <div> <%--class="panel-body"--%>
                <div id="DataList" style="display: none;overflow:auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

        <div style="display:none;">
            <input type="hidden" id="hdn_instructor" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_instructor_name" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_All_instructor" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_dept" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_prog" runat="server" clientidmode="Static" />
        </div>

        <%--<div class="divFooter">UNCLASSIFIED</div>--%>

    </div>
    
    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type:'course'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            //get_acuser_detail();
                            retrieve_VF_Data();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        var dept_options = [];
        function get_acuser_detail() {
            //if ($('#hdnusertype').val() == 'AC' || $('#hdnusertype').val() == 'FA') {

                //$('.cls_dept_prog').css('display', 'none');

                dept_options = $('#drpdepartment').children();

                semester = $('#drpsemester').val();

                year_code = $('#drpyear').val();

                if (semester == "" || year_code == "") {
                    return false;
                }

                $('#drpdepartment').html('');
                $('#drpdepartment').append(dept_options[0]);
                $('#drpdepartment').trigger("liszt:updated");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_semyearwise_department_user_dtl",
                    async: false,
                    data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);

                            for (var i = 0; i < user_data.length; i++) {
                                $('#drpdepartment').append(dept_options[user_data[i]['dept_code']]);
                            }

                            $('#drpdepartment').val(user_data[0]['dept_code']);
                            //$('#drpprog').val(user_data[0]['prog_code']);

                            $('#drpdepartment').trigger("liszt:updated");

                            retrieve_VF_Data();
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            //}
        }

        function retrieve_VF_Data() {
            $('#DataList').css('display', 'none');

            semester = $('#hdn_sem').val();
            //            if (semester == "") {
            //                bootbox.alert('Please select semester');
            //                $('#drpsemester').focus();
            //                return false;
            //            }

            year_code = $('#hdn_year').val();
            //            if (year_code == "") {
            //                bootbox.alert('Please select Year');
            //                $('#drpyear').focus();
            //                return false;
            //            }

            dept_code = $('#hdn_dept').val();
            //            if ($('#hdnusertype').val() != 'F') {
            //                if (dept_code == "") {
            //                    bootbox.alert('Please select Department');
            //                    $('#drpdepartment').focus();
            //                    return false;
            //                }
            //            }

            prog_code = $('#hdn_prog').val();
            //            if (prog_code == "") {
            //                bootbox.alert('Please select Programme');
            //                $('#drpprog').focus();
            //                return false;
            //            }

            var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code, prog: prog_code };
            $('#hdn_filter').val(JSON.stringify(filter_criteria));

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_VF_Finance_Report_data",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "'}",
                dataType: "json",
                success: function (data) {
                    $('#loading').css('display', 'none');

                    if (data.d != "") {
                        display_Student_Data(data.d);
                        $('#div_stud_list').css('display', 'block');
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester or Year');
                        $('#div_stud_list').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        }

        function display_Student_Data(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
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
                    { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
                    { "sTitle": "VF Code", "mData": "VF_code", "bSortable": false },
                    { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                    { "sTitle": "Beneficiary Name", "mData": "benificiary_name", "bSortable": false },
                    { "sTitle": "PAN", "mData": "pan_card_no", "bSortable": false },

                    { "sTitle": "Bank Account Number", "mData": "bank_account_number", "bSortable": false },
                //                    {"sTitle": "Bank Account Number", "mData": null, "bSortable": false, fnRender: function (data) {
                //                        if (data.aData.bank_account_number != '') {
                //                            var temp_data = data.aData.bank_account_number.toString();
                //                            //temp_data = temp_data.substring(2, temp_data.length - 1);
                //                            return temp_data;
                //                        }
                //                        else return "";
                //                    }
                //                    },

                    {"sTitle": "Account Type", "mData": "account_type", "bSortable": false },
                    { "sTitle": "Name of the Bank", "mData": "name_of_Bank", "bSortable": false },
                    { "sTitle": "IFSC Code", "mData": "ifsc_code", "bSortable": false },

                //{ "sTitle": "Date of Birth", "mData": "dob", "bSortable": false },
                    {"sTitle": "Date", "mData": null, "bSortable": false, fnRender: function (data) {
                        if (data.aData.dob != '') {
                            var temp_date = new Date(data.aData.dob);
                            return temp_date.format("dd/MM/yyyy");
                        }
                        else return "";
                    }
                },

                    { "sTitle": "Email ID", "mData": "mail", "bSortable": false },
                    { "sTitle": "Mobile Number", "mData": "mobile_no", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Program", "mData": "prog_level_desc", "bSortable": false },
                    { "sTitle": "Contact hrs", "mData": "total_contact_hrs", "bSortable": false },
                    { "sTitle": "Preparatory hrs", "mData": "total_preparation_hrs", "bSortable": false },
                    { "sTitle": "Total Weeks", "mData": "total_weeks", "bSortable": false },
                    { "sTitle": "Pay Band", "mData": "final_rate_band", "bSortable": false },
                    { "sTitle": "Total Amount Payable", "mData": "total_amount_paid", "bSortable": false },
                    { "sTitle": "Acceptance Justification", "mData": null, "bSortable": false, fnRender: function (data) {
                        if (data.aData.acceptance == 'Y') {
                            if (data.aData.acceptance_type == 'D') {
                                return data.aData.acceptance_justification;
                            }
                            else if (data.aData.acceptance_type == 'A') {
                                //return "<center><button class='btn btn-primary' type='button' id='btnreterive'>Retrieve</button></center>";
                                return "<a download style='display: block;' href='../../VFAcceptanceUpload/" + data.aData.acceptance_justification + "' class='btn btn-primary btn-small'>Download</a>";
                            }
                            else {
                                return "";
                            }
                        }
                        else {
                            return "";
                        }
                    }
                    },
                    { "sTitle": "Acceptance Date", "mData": null, "bSortable": false, fnRender: function (data) {
                        if (data.aData.acceptance_date != '') {
                            var temp_date = new Date(data.aData.acceptance_date);
                            return temp_date.format("dd/MM/yyyy");
                        }
                        else return "";
                    }
                    }
                ]
            });

            $('#DataList').css('display', 'block');

            $('#example thead th')[0].style.display = 'none';

            $('#example tbody tr').each(function (i) {
                this.children[0].style.display = 'none';
                var temp_data = this.children[5].innerHTML.toString();
                temp_data = temp_data.substring(2, temp_data.length - 1);
                this.children[5].innerHTML = temp_data;
            });

            var tbl_example = $('#example');

            $('body').html('');

            $('body').append(tbl_example);
            //$('#SITE_CONTAINER').append('<div class="divHeader">UNCLASSIFIED</div>');
            //$('#SITE_CONTAINER').append('<div class="divFooter">UNCLASSIFIED</div>');

            //window.print();
            //window.close();
        }

        function rowClick(element) {
            //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

            var row = element.closest('tr');
            var row_data = oTable.fnGetData(row);

            //var instructor_list = [{ 'instructor_code': row_data['instructor_code'].toString(), 'dept_name': row_data['dept_name'].toString(), 'sem_code': semester, 'year_code': year_code}];

            $('#hdn_instructor').val(row_data['instructor_code'].toString());
            $('#hdn_instructor_name').val(row_data['instructor_name'].toString());
            $('#hdn_dept').val(row_data['dept_name'].toString());
            $('#hdn_sem').val(semester);
            $('#hdn_year').val(year_code);
            $('#hdn_print_letter').click();

            //$('#hdn_download').click();
            //download_pdf(JSON.stringify(instructor_list));
        }

        function download_pdf(instructor_list) {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/finance_VFAppointment_letter",
                //async: false,
                data: "{instructor_list:'" + instructor_list + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == null || data.d == '') {
                        bootbox.alert('Problem in Sending Mails.');
                    }
                    else if (data.d != "" && data.d != "[]") {
                        bootbox.alert(data.d);
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


    </script>
</body>
</html>
