<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="WS_VF_Finance_Report.aspx.cs" Inherits="Admin_Report_WS_VF_Finance_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   <%-- <script src="../../Js/admin_report.js?t=21092019" type="text/javascript"></script>--%>
  
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style>
        #DataList #example_wrapper .dt-buttons
        {
            width:500px;
            height:50px;
        }

    </style>

    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindsemdata();
            get_fauser_detail();
            //binddepartment();
            //bindprogrammedata();
            //setCurrentSemester();

            $('#btnreterive').on('click', function () {
                retrieve_VF_Data();
                return false;
            });

            function get_fauser_detail() {

                var url_dept = "";

                if ($('#hdnusertype').val() == 'FA') {
                    url_dept = "../../WebService.asmx/get_ws_department_wise_user_dtl";
                }
                else {
                    url_dept = "../../WebService.asmx/Get_department_data";
                }

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: url_dept,
                        async: false,
                        data: "{}",
                        dataType: "json",
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
            function bindsemdata() {

                $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
                $('#drpsemester').append($("<option></option>").val("S").html("Summer"));

                $('#drpsemester').chosen();

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
            $('#btn_print').on('click', function () {

                var print_sem = '';
                if (semester == 'S') print_sem = 'Spring'; else if (semester == 'M') print_sem = 'Monsoon';

                var mywindow = window.open('', 'print_data', 'height=400,width=600');

                mywindow.document.write('');

                mywindow.document.write('<html><head><title>' + print_sem + ' / ' + year_code + ' / ' + dept_options[dept_code].innerHTML + '</title><script src="../../DesignJS/jquery.min.js" type="text/javascript"><\/script>');
                mywindow.document.write('<style>body{margin: 0;} table{border-right: 1px solid black;border-bottom: 1px solid black;} table tr{} table th{padding: 3px;border-top: 1px solid black;border-left: 1px solid black;} table td{padding: 3px;border-top: 1px solid black;border-left: 1px solid black;}');
                //mywindow.document.write(' table thead tr th:nth-last-child(2) {display: none;} table tbody tr td:nth-last-child(2) {display: none;}');
                //mywindow.document.write(' table thead tr th:nth-last-child(3) {display: none;} table tbody tr td:nth-last-child(3) {display: none;}');
                mywindow.document.write(' table thead tr th:last-child {display: none;} table tbody tr td:last-child {display: none;}</style>');

                mywindow.document.write('</head>');
                mywindow.document.write('<body>');
                mywindow.document.write('<table id="tbl_VFData" cellpadding="0" cellspacing="0" width="100%" style="width: 100%;">' + $('#example').html() + '</table>');
                mywindow.document.write('<div style="text-align: center;margin-top: 10px;"><b>Note&nbsp;:&nbsp; </b>This is an electronically generated report and does not require an authorised signature.</div></body></html>');

                setTimeout(function () {
                    mywindow.print();
                    mywindow.close();
                }, 500);

                //window.open('VF_Finance_Report_Print.aspx?sem=' + semester + '&year=' + year_code + '&dept=' + dept_code + '&prog=' + prog_code, 'PrintMe', 'height=600px,width=610,scrollbars=1');

                return false;

            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;SWS VF Report
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            
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
                                    Year  :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Department :
                                </td>
                                <td >
                                    <select class="chosen-select" id="drpdepartment" />
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
            </div>

        </div>

        <div id="div_stud_list" class="panel panel-default" style="display:none;">
            
            <div class="panel-heading">
                <strong>VF List</strong>
                <span style="display:block;position:absolute;">
                    <%--<button class="btn btn-primary" type="submit" id="btn_print" style="height: 40px;margin-top: -10px;">Print PDF</button>--%>
                    <%--<button type="submit" id="btn_print" style="margin-top: 25px;margin-left: 480px;">Print PDF</button>--%>
                    <%--<asp:Button ID="print_pdf" runat="server" ClientIDMode="Static" class="btn btn-primary" OnClick="Btn_Print_PDF_Click" Text="Print PDF"  style="height: 40px;margin-top: -10px;" />--%>
                </span>
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
            <input type="hidden" id="hdn_filter" runat="server" clientidmode="Static" />
            <%--<asp:Button ID="hdn_print_letter" runat="server" ClientIDMode="Static" OnClick="Btn_Print_Letter_Click"/>--%>
        </div>

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

                            get_acuser_detail();
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
            if ($('#hdnusertype').val() == 'AC' || $('#hdnusertype').val() == 'FA') {

                if ($('#hdnuserid').val() == "AC001") {
                    return false;

                }
                //$('.cls_dept_prog').css('display', 'none');
                var arrayindex = new Array();
                dept_options = $('#drpdepartment').children();

                $('#drpdepartment option').each(function () {
                    var drodownval = $(this).val();
                    arrayindex.push(drodownval);
                });

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

                                //for (var i = 0; i < user_data.length; i++)
                                // {

                                // $('#drpdepartment').append(dept_options[user_data[i]['dept_code']]);
                                //}
                                //$('#drpdepartment').append(dept_options[user_data[0]['dept_code']]);

                                for (var i = 0; i < user_data.length; i++) {
                                    for (var j = 1; j < arrayindex.length; j++) {

                                        if (arrayindex[j] == user_data[i]['dept_code']) {

                                            $('#drpdepartment').append(dept_options[j]);
                                        }
                                    }
                                }

                                $('#drpdepartment').val(user_data[0]['dept_code']);
                                //$('#drpprog').val(user_data[0]['prog_code']);

                                $('#drpdepartment').trigger("liszt:updated");
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
        }

        function retrieve_VF_Data() {
            $('#DataList').css('display', 'none');

            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            dept_code = $('#drpdepartment').val();
            if ($('#hdnusertype').val() == 'FA') {
                if (dept_code == "") {
                    bootbox.alert('Please select Department');
                    $('#drpdepartment').focus();
                    return false;
                }
            }

            prog_code = '';
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
                    url: "../../WebService.asmx/WS_get_VF_Finance_Report_data",
                    data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "'}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "") {
                            display_Student_Data(data.d);
                            $('#div_stud_list').css('display', 'block');
                            setDataTableHeaderFooter('example');
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
                "bPaginate": false,
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
                //        //"print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},

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

                    { "sTitle": "Account Type", "mData": "account_type", "bSortable": false },
                    { "sTitle": "Name of the Bank", "mData": "name_of_Bank", "bSortable": false },
                    { "sTitle": "IFSC Code", "mData": "ifsc_code", "bSortable": false },

                    //{ "sTitle": "Date of Birth", "mData": "dob", "bSortable": false },
                    {
                        "sTitle": "Date", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.dob != '') {
                                var temp_date = new Date(data.dob);
                                return temp_date.format("dd/MM/yyyy");
                            }
                            else return "";
                        }
                    },

                    { "sTitle": "Email ID", "mData": "mail", "bSortable": false },
                    { "sTitle": "Mobile Number", "mData": "mobile_no", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                   // { "sTitle": "Program", "mData": "prog_level_desc", "bSortable": false },
                    //{ "sTitle": "Contact hrs", "mData": "total_contact_hrs", "bSortable": false },
                   // { "sTitle": "Total Contact Hours", "mData": "Contact_Hrs", "bSortable": false },
                    {
                        "sTitle": "Total Contact Hours", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Contact_Hrs != '') {
                                return data.Contact_Hrs
                            }
                            else return "";
                        }
                    },


                    //{ "sTitle": "Additional Hours", "mData": "additional_hours", "bSortable": false },
                    {
                        "sTitle": "Additional Hours", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.additional_hours != '') {
                                return data.additional_hours
                            }
                            else return "";
                        }
                    },

                    //{ "sTitle": "Total Hours", "mData": "total_contact_hrs", "bSortable": false },
                    {
                        "sTitle": "Total Hours", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.total_contact_hrs != '') {
                                return data.total_contact_hrs
                            }
                            else return "";
                        }
                    },

                    { "sTitle": "Preparatory hrs", "mData": "total_preparation_hrs", "bSortable": false },
                    { "sTitle": "Total Weeks", "mData": "total_weeks", "bSortable": false },
                    { "sTitle": "Pay Band", "mData": "final_rate_band", "bSortable": false },
                    { "sTitle": "Total Amount Payable", "mData": "total_amount_paid", "bSortable": false },
                    {
                        "sTitle": "Acceptance Justification", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.acceptance == 'Y') {
                                if (data.acceptance_type == 'D') {
                                    return data.acceptance_justification;
                                }
                                else if (data.acceptance_type == 'A') {
                                    //return "<center><button class='btn btn-primary' type='button' id='btnreterive'>Retrieve</button></center>";
                                    return "<a download style='display: block;' href='../../VFAcceptanceUpload/" + data.acceptance_justification + "' class='btn btn-primary btn-small'>Download</a>";
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
                    {
                        "sTitle": "Acceptance Date", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.acceptance_date != '') {
                                var temp_date = new Date(data.acceptance_date);
                                return temp_date.format("dd/MM/yyyy");
                            }
                            else return "";
                        }
                    },
                    {
                        "sTitle": "Print Letter", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.pdf_path != '') {
                                //return "<center><button type='button' onclick='rowClick(\"" + data.aData.instructor_code + "\")'>Download</button></center>";
                                return "<center><button type='button' id='" + data.pdf_path + "' onclick='rowClick(this)' class='btn btn-primary btn-small'>Download</button></center>";
                            }
                            else return "";
                        }
                    }
                ]
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            $('#example thead th')[0].style.display = 'none';

            $('#example tbody tr').each(function (i) {
                this.children[0].style.display = 'none';
                var temp_data = this.children[5].innerHTML.toString();
                temp_data = temp_data.substring(2, temp_data.length - 1);
                this.children[5].innerHTML = temp_data;
            });
        }

        
        function rowClick(element)
        {
            var row = element.closest('tr');
            var row_data = oTable.fnGetData(row);
            $('#hdn_instructor').val(row_data['instructor_code'].toString());
            $('#hdn_instructor_name').val(row_data['instructor_name'].toString());
            $('#hdn_dept').val(row_data['dept_name'].toString());
            $('#hdn_sem').val(semester);
            $('#hdn_year').val(year_code);
            var file_name = element.id;
            var root = window.location.origin;
            $("body").append('<a id="link" href="' + root + '/' + 'WSLetterPDF' + '/' + file_name + '" download>&nbsp;</a>');
            $('#link')[0].click();
            $('#link')[0].remove();
        }

        


    </script>

</asp:Content>

