<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="VF_Disbursement_Report.aspx.cs" Inherits="Admin_Report_VF_Disbursement_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
     <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            var dept_name;

            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindprogrammedata();

            setCurrentSemester();

            $('#btnreterive').on('click', function () {
                dept_name = $("#drpdepartment option:selected").text();
                retrieve_VF_Data();
                return false;
            });

            //$('#drpdepartment').on('change', function () {
            //    if ($('#drpdepartment').val() != '') {
            //        dept_name = $("#drpdepartment option:selected").text();
            //    }
            //});

            $('#btn_print').on('click', function () {

                var print_sem = '';
                if (semester == 'S') print_sem = 'Spring'; else if (semester == 'M') print_sem = 'Monsoon';

                var mywindow = window.open('', 'print_data', 'height=400,width=600');

                mywindow.document.write('');

                //mywindow.document.write('<html><head><title>' + print_sem + ' / ' + year_code + ' / ' + dept_options[dept_code].innerHTML + '</title><script src="../../DesignJS/jquery.min.js" type="text/javascript"><\/script>');

                if (dept_name != null && dept_name != undefined && dept_name != '' && dept_name != '-- Please Select Department --') {
                    //mywindow.document.write('<html><head><title>' + print_sem + ' / ' + year_code + ' / ' + dept_options[dept_code].innerHTML + '</title><script src="../../DesignJS/jquery.min.js" type="text/javascript"><\/script>');
                    mywindow.document.write('<html><head><title>' + print_sem + ' / ' + year_code + ' / ' + dept_name + '</title><script src="../../DesignJS/jquery.min.js" type="text/javascript"><\/script>');
                }
                else {
                    mywindow.document.write('<html><head><title>' + print_sem + ' / ' + year_code + '</title><script src="../../DesignJS/jquery.min.js" type="text/javascript"><\/script>');
                }

                mywindow.document.write('<style>body{margin: 0;} table{border-right: 1px solid black;border-bottom: 1px solid black;} table tr{} table th{padding: 3px;border-top: 1px solid black;border-left: 1px solid black;} table td{padding: 3px;border-top: 1px solid black;border-left: 1px solid black;}');
                //mywindow.document.write(' table thead tr th:nth-last-child(2) {display: none;} table tbody tr td:nth-last-child(2) {display: none;}');
                //mywindow.document.write(' table thead tr th:nth-last-child(3) {display: none;} table tbody tr td:nth-last-child(3) {display: none;}');
                //mywindow.document.write(' table thead tr th:last-child {display: none;} table tbody tr td:last-child {display: none;}');
                mywindow.document.write('</style>');

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />--%>
    
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;VF Disbursement Report
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
                                    Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>
                                    Year of allocation
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td class="cls_dept_prog">
                                    Department
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>
                                    Month
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpmonth">
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
            </div>

        </div>

        <div id="div_stud_list" class="panel panel-default" style="display:none;">
            
            <div class="panel-heading">
                <strong>VF List</strong>
                <span style="display:block;position:absolute;">
                    <%--<button class="btn btn-primary" type="submit" id="btn_print" style="height: 40px;margin-top: -10px;">Print PDF</button>--%>
                   <%-- <button type="submit" id="btn_print" style="margin-top: 20px;margin-left: 450px;">Print PDF</button>--%>
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
            <asp:Button ID="hdn_print_letter" runat="server" ClientIDMode="Static" OnClick="Btn_Print_Letter_Click"/>
        </div>

    </div>
    
    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var month = '';

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                //data: "{type:'course'}",
                data: "{type:'vf_disbursement'}",
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

                            var str_month_html = '';
                            if (cur_grade_sem[0]['sem_code'].toString() == 'S')
                                str_month_html = '<option value="">-- Select Month --</option><option value="2">February</option><option value="3">March</option><option value="4">April</option><option value="5">May</option>';

                            else if (cur_grade_sem[0]['sem_code'].toString() == 'M')
                                str_month_html = '<option value="">-- Select Month --</option><option value="8">August</option><option value="9">September</option><option value="10">October</option><option value="11">November</option>';

                            $('#drpmonth').html(str_month_html);
                            $('#drpmonth').chosen();
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
            if ($('#hdnusertype').val() == 'AC' || $('#hdnusertype').val() == 'FA')
            {

                if ($('#hdnuserid').val() == "AC001") {
                    return false;

                }

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
            if ($('#hdnusertype').val() != 'F') {
                if (dept_code == "") {
                    bootbox.alert('Please select Department');
                    $('#drpdepartment').focus();
                    return false;
                }
            }

            prog_code = $('#drpprog').val();
            //            if (prog_code == "") {
            //                bootbox.alert('Please select Programme');
            //                $('#drpprog').focus();
            //                return false;
            //            }

            month = $('#drpmonth').val();

            var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code, prog: prog_code, month: month };
            $('#hdn_filter').val(JSON.stringify(filter_criteria));

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_disbursement_data",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',month: '" + month + "'}",
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

            var columns = [];

            if (month == '') {
                columns = [{ "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
                            { "sTitle": "VF Code", "mData": "VF_code", "bSortable": false },
                            { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                            { "sTitle": "Beneficiary Name", "mData": "benificiary_name", "bSortable": false },
                            { "sTitle": "PAN", "mData": "pan_card_no", "bSortable": false },
                            { "sTitle": "Bank Account Number", "mData": "bank_account_number", "bSortable": false },
                            { "sTitle": "Account Type", "mData": "account_type", "bSortable": false },
                            { "sTitle": "Name of the Bank", "mData": "name_of_Bank", "bSortable": false },
                            { "sTitle": "IFSC Code", "mData": "ifsc_code", "bSortable": false },
                            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                            { "sTitle": "Program", "mData": "prog_level_desc", "bSortable": false },
                            { "sTitle": "Total Contact Hours", "mData": "total_hrs_in_semester", "bSortable": false },
                            { "sTitle": "Additional Hours", "mData": "additional_hours", "bSortable": false },
                            { "sTitle": "Total Hours", "mData": "total_hrs_add", "bSortable": false },
                            { "sTitle": "Total Amount Payable", "mData": "total_amount_paid", "bSortable": false },
                            { "sTitle": "No of Installments", "mData": "total_installments", "bSortable": false },

                //{ "sTitle": "Installment 1", "mData": "installment1", "bSortable": false, "sClass": "cls_td_installment_1" },
                //{ "sTitle": "Installment 2", "mData": "installment2", "bSortable": false, "sClass": "cls_td_installment_2" },
                //{ "sTitle": "Installment 3", "mData": "installment3", "bSortable": false, "sClass": "cls_td_installment_3" },
                //{ "sTitle": "Installment 4", "mData": "installment4", "bSortable": false, "sClass": "cls_td_installment_4" },

                            {"sTitle": "Installment 1", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", mRender: function (data) {
                                if (data.installment1 != '') {
                                    var temp_date = new Date(data.installment1);
                                    return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                                }
                                else
                                    return '';
                            }
                        },
                            { "sTitle": "Installment 2", "mData": null, "bSortable": false, "sClass": "cls_td_installment_2", mRender: function (data) {
                                if (data.installment2 != '') {
                                    var temp_date = new Date(data.installment2);
                                    return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                                }
                                else
                                    return '';
                            }
                            },
                            { "sTitle": "Installment 3", "mData": null, "bSortable": false, "sClass": "cls_td_installment_3", mRender: function (data) {
                                if (data.installment3 != '') {
                                    var temp_date = new Date(data.installment3);
                                    return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                                }
                                else
                                    return '';
                            }
                            },
                            { "sTitle": "Installment 4", "mData": null, "bSortable": false, "sClass": "cls_td_installment_4", mRender: function (data) {
                                if (data.installment4 != '') {
                                    var temp_date = new Date(data.installment4);
                                    return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                                }
                                else
                                    return '';
                            }
                            },
                            { "sTitle": "Payment 1", "mData": "payment1", "bSortable": false, "sClass": "cls_td_payment_1" },
                            { "sTitle": "Payment 2", "mData": "payment2", "bSortable": false, "sClass": "cls_td_payment_2" },
                            { "sTitle": "Payment 3", "mData": "payment3", "bSortable": false, "sClass": "cls_td_payment_3" },
                            { "sTitle": "Payment 4", "mData": "payment4", "bSortable": false, "sClass": "cls_td_payment_4" }
                        ];
            }
            else {
                columns = [{ "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
                            { "sTitle": "VF Code", "mData": "VF_code", "bSortable": false },
                            { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                            { "sTitle": "Beneficiary Name", "mData": "benificiary_name", "bSortable": false },
                            { "sTitle": "PAN", "mData": "pan_card_no", "bSortable": false },
                            { "sTitle": "Bank Account Number", "mData": "bank_account_number", "bSortable": false },
                            { "sTitle": "Account Type", "mData": "account_type", "bSortable": false },
                            { "sTitle": "Name of the Bank", "mData": "name_of_Bank", "bSortable": false },
                            { "sTitle": "IFSC Code", "mData": "ifsc_code", "bSortable": false },
                            { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                            { "sTitle": "Program", "mData": "prog_level_desc", "bSortable": false },
                            { "sTitle": "Total Contact Hours", "mData": "total_hrs_in_semester", "bSortable": false },
                            { "sTitle": "Additional Hours", "mData": "additional_hours", "bSortable": false },
                            { "sTitle": "Total Hours", "mData": "total_hrs_add", "bSortable": false },
                            { "sTitle": "Total Amount Payable", "mData": "total_amount_paid", "bSortable": false },
                            { "sTitle": "No of Installments", "mData": "total_installments", "bSortable": false },

                            { "sTitle": "Installment", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", mRender: function (data) {
                                if (data.installment_for_selected_month != '') {
                                    var temp_date = new Date(data.installment_for_selected_month);
                                    return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                                }
                                else
                                    return '';
                            }
                            },
                            { "sTitle": "Payment", "mData": "payment_for_selected_month", "bSortable": false, "sClass": "cls_td_payment_1" },
                            { "sTitle": "Payment Status", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data['installment' + data.cur_installment + '_payment_status'] == 'Y') {
                                    return "Paid";
                                }
                                else return "Unpaid";
                            }
                            },
                            { "sTitle": "Send for Review", "mData": null, "bSortable": false, mRender: function (data) {
                                if (data.payment_status_selected_month != 'Y') {
                                    return "<center><button type='button' onclick='sendForReview(this)' class='btn btn-primary btn-small'>Send</button></center>";
                                }
                                else return "";
                            }
                            }
                        ]
            }

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
               // "sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                    //"aButtons": [
                    //"copy",
                    //                        "print",
                    //                        {
                    //                            "sExtends": "collection",
                    //                            "sButtonText": 'Export',
                    //                            "aButtons": ["xls"]
                    //                        }
                   // ]
               // },

                "aaData": JSON.parse(data),
                "aoColumns": columns
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            $('.dt-button.buttons-csv.buttons-html5').css('margin-left', '0px');

            $('#example thead th')[0].style.display = 'none';

            $('#example tbody tr').each(function (i) {
                this.children[0].style.display = 'none';
                var temp_data = this.children[5].innerHTML.toString();
                temp_data = temp_data.substring(2, temp_data.length - 1);
                this.children[5].innerHTML = temp_data;
            });
        }

        //        function setDataTableHeaderFooter(id) {
        //            var table_id = id;

        //            // Header Width
        //            $("#" + table_id + "_wrapper")[0].children[0].style.width = '' + $('#example')[0].offsetWidth + 'px';
        //            // Header Search
        //            $("#" + table_id + "_filter").css('position', 'absolute');
        //            $("#" + table_id + "_filter").css('width', '350px');
        //            $("#" + table_id + "_filter").css('left', '680px');

        //            // Footer Width
        //            $("#" + table_id + "_wrapper")[0].children[2].style.width = '' + $('#example')[0].offsetWidth + 'px';
        //            // Footer Showing entries
        //            $("#" + table_id + "_wrapper")[0].children[2].children[0].children[0].style.position = 'absolute';
        //            // Footer Pagination
        //            $("#" + table_id + "_wrapper")[0].children[2].children[1].children[0].style.position = 'absolute';
        //            $("#" + table_id + "_wrapper")[0].children[2].children[1].children[0].style.width = '330px';
        //            $("#" + table_id + "_wrapper")[0].children[2].children[1].children[0].style.left = '680px';
        //        }

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

        function sendForReview(element) {
            //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;

            var row = element.closest('tr');
            var row_data = oTable.fnGetData(row);

            var instructor_data = { 'instructor_code': row_data['instructor_code'].toString(), 'course_code': row_data['course_code'].toString(), 'sem_code': semester, 'year_code': year_code, 'cur_installment': row_data['cur_installment'].toString() };

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/VFDisbursement_send_for_review",
                //async: false,
                data: "{instructor_data:'" + JSON.stringify(instructor_data) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]") {
                        bootbox.alert(data.d);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
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
</asp:Content>
