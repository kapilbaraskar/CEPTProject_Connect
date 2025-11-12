<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="VF_payment_made_reference.aspx.cs" Inherits="Admin_Report_VF_payment_made_reference" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
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

            $('#btn_print').on('click', function () {

                var print_sem = '';
                if (semester == 'S') print_sem = 'Spring'; else if (semester == 'M') print_sem = 'Monsoon';

                var mywindow = window.open('', 'print_data', 'height=400,width=600');

                mywindow.document.write('');

                mywindow.document.write('<html><head><title>' + print_sem + ' / ' + year_code + ' / ' + dept_options[dept_code].innerHTML + '</title><script src="../../DesignJS/jquery.min.js" type="text/javascript"><\/script>');
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

            $('#drpsemester,#drpyear').on('change', function () {
                get_acuser_detail();
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />--%>
    
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Payment Made Reference
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
                    <%--<button type="submit" id="btn_print" style="margin-top: 20px;margin-left: 450px;">Print PDF</button>--%>
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
    
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>

    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var month = '';
        var page_load = true;

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

                if (page_load) {
                    dept_options = $('#drpdepartment').children();
                    page_load = false;
                }

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
            $('#submitBtnDiv').html('');

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
            if (month == "") {
                bootbox.alert('Please select Month');
                $('#drpmonth').focus();
                return false;
            }

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

                //{ "sTitle": "Total Amount Payable", "mData": "total_amount_paid", "bSortable": false },
                            {"sTitle": "Total Amount Payable", "mData": null, "bSortable": false, fnRender: function (data) {
                                var cur_installment = parseInt(data.aData.cur_installment);
                                var amount = parseFloat(data.aData.total_amount_paid);
                                for (var i = 1; i < cur_installment; i++) {
                                    if (data.aData['installment' + i + '_payment_status'] == 'Y') {
                                        amount = amount - parseFloat(data.aData["payment" + i]);
                                    }
                                }
                                return amount.toFixed(0);
                            }
                        },

                            { "sTitle": "No of Installments", "mData": "total_installments", "bSortable": false },

                            { "sTitle": "Installment", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                                if (data.aData.installment_for_selected_month != '') {
                                    var temp_date = new Date(data.aData.installment_for_selected_month);
                                    return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                                }
                                else
                                    return '';
                            }
                            },
                            { "sTitle": "Payment", "mData": "payment_for_selected_month", "bSortable": false, "sClass": "cls_td_payment_1" },
                            { "sTitle": "TDS", "mData": null, "bSortable": false, fnRender: function (data) {
                                if (data.aData.payment_for_selected_month != '' && data.aData.payment_for_selected_month != null) {
                                    var amount = parseFloat(data.aData.payment_for_selected_month);
                                    var str_amount = (amount * 10) / 100;
                                    //return str_amount.toFixed(2);
                                    return Math.ceil(str_amount);
                                }
                                else return "";
                            }
                            },
                            { "sTitle": "Payable Amount", "mData": null, "bSortable": false, "sClass": "cls_payable_amount", fnRender: function (data) {
                                if (data.aData.payment_for_selected_month != '' && data.aData.payment_for_selected_month != null) {
                                    var amount = parseFloat(data.aData.payment_for_selected_month);
                                    var str_amount = amount - ((amount * 10) / 100);
                                    //return str_amount.toFixed(2);
                                    return parseInt(str_amount);
                                }
                                else return "";
                            }
                            },
                            { "sTitle": "Payment Reference", "mData": null, "bSortable": false, fnRender: function (data) {
                                if (data.aData['installment' + data.aData.cur_installment + '_payment_status'] == 'Y') {
                                    return data.aData['installment' + data.aData.cur_installment + '_payment_ref'];
                                }
                                else if (data.aData.admin_approved == 'Y')
                                    return "<center><input type='text' class='cls_payment_ref' /></center>";
                                else return "";
                            }
                            },
                            { "sTitle": "Payment Reference Date", "mData": null, "bSortable": false, fnRender: function (data) {
                                if (data.aData['installment' + data.aData.cur_installment + '_payment_status'] == 'Y') {
                                    if (data.aData['installment' + data.aData.cur_installment + '_payment_ref_date'] != '') {
                                        var temp_date = new Date(data.aData['installment' + data.aData.cur_installment + '_payment_ref_date']);
                                        return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                                    }
                                    else return '';
                                }
                                else if (data.aData.admin_approved == 'Y')
                                    return "<center><input type='text' class='cls_payment_ref_date' /></center>";
                                else return "";
                            }
                            },
                            { "sTitle": "Disbursement Amount", "mData": null, "bSortable": false, "sClass": "cls_td_disbursement_amount", fnRender: function (data) {
                                if (data.aData['installment' + data.aData.cur_installment + '_payment_status'] == 'Y') {
                                    return data.aData['installment' + data.aData.cur_installment + '_disbursement_amount'];
                                }
                                else if (data.aData.admin_approved == 'Y')
                                    return "<center><input type='text' class='cls_disbursement_amount' onkeypress='return IsNumeric(event);' /></center>";
                                else return "";
                            }
                            },
                            { "sTitle": "Payment Status", "mData": null, "bSortable": false, fnRender: function (data) {
                                if (data.aData['installment' + data.aData.cur_installment + '_payment_status'] == 'Y') {
                                    return "Paid";
                                }
                                else if (data.aData.admin_approved == 'Y')
                                    return "<center><input type='radio' name='" + data.aData.instructor_code + "_" + data.aData.course_code + "' class='cls_rdo_payment' /></center>";
                                else if (data.aData.admin_approved == 'N')
                                    return "Not Approved";
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
                    //                        "print",
                    //                        {
                    //                            "sExtends": "collection",
                    //                            "sButtonText": 'Export',
                    //                            "aButtons": ["xls"]
                    //                        }
                    ]
                },

                "aaData": JSON.parse(data),
                "aoColumns": columns
            });

            $('#DataList').css('display', 'block');

            $('#example thead th')[0].style.display = 'none';

            $('#example tbody tr').each(function (i) {
                this.children[0].style.display = 'none';
                var temp_data = this.children[5].innerHTML.toString();
                temp_data = temp_data.substring(2, temp_data.length - 1);
                this.children[5].innerHTML = temp_data;
            });

            $('.cls_payment_ref').css('width', '150px');
            $('.cls_payment_ref_date').datepicker({ dateFormat: 'dd/mm/yy' });
            $('.cls_payment_ref_date').css('width', '75px');
            //$('.cls_payment_ref_date').attr('readOnly', 'true');
            $('.cls_disbursement_amount').css('width', '150px');
            $('.cls_td_disbursement_amount').css('display', 'none');

            //if ($('#hdnusertype').val() == 'A1') {
            var str = "<table style='width: 50%'><tr><td align='right' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                  "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
            $('#submitBtnDiv').html(str);
            //}

            $('#btnapprove').on('click', function () {
                var payment_data = [];

                $('#example tbody tr').each(function (i) {
                    var row = this;
                    var row_data = oTable.fnGetData(row);

                    if (row_data['payment_status_selected_month'].toString() != 'Y' && row.getElementsByClassName('cls_rdo_payment').length > 0) {
                        if (row.getElementsByClassName('cls_rdo_payment')[0].checked) {
                            var payment_row = { 'instructor_code': row_data['instructor_code'].toString(), 'course_code': row_data['course_code'].toString(), 'sem_code': semester, 'year_code': year_code, 'cur_installment': row_data['cur_installment'].toString(), 'payment_ref': '', 'payment_ref_date': '', 'disbursement_amount': '', 'destination_mail': row_data['mail'].toString(), 'bank_account_no': row_data['bank_account_number'].toString(), 'instructor_name': row_data['instructor_name'].toString(), 'dept_code': row_data['dept_code'].toString(), 'payable_amount': row.getElementsByClassName('cls_payable_amount')[0].innerHTML, 'cur_installment': row_data['cur_installment'].toString(), 'title': 'Prof.', 'sem_code': semester, 'year_code': year_code, 'total_installments': row_data['total_installments'].toString() };
                            payment_row.payment_ref = row.getElementsByClassName('cls_payment_ref')[0].value;

                            if (row.getElementsByClassName('cls_payment_ref_date')[0].value != '') {
                                payment_row.payment_ref_date = convertDateFormat(row.getElementsByClassName('cls_payment_ref_date')[0].value);
                            }

                            payment_row.disbursement_amount = row.getElementsByClassName('cls_disbursement_amount')[0].value;

                            payment_row.bank_account_no = payment_row.bank_account_no.toString().replace(/"/g, '');
                            payment_row.bank_account_no = payment_row.bank_account_no.toString().replace(/=/g, '');

                            payment_data.push(payment_row);
                        }
                    }
                });

                if (payment_data.length > 0) {
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/VF_submit_payment",
                        //async: false,
                        data: "{payment_data:'" + JSON.stringify(payment_data) + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "" && data.d != "[]") {
                                var res = JSON.parse(data.d);
                                if (res['status'] == "False") {
                                    bootbox.alert(data.d);
                                }
                                else if (res['status'] == "True") {
                                    bootbox.alert(res['message'], function () {
                                        location.reload();
                                    });
                                } 
                            }

                            //if (data.d == 'Problem in Submit DATA.') bootbox.alert(data.d);
                            //else if (data.d != "" && data.d != "[]") {
                            //    bootbox.alert(data.d, function () {
                            //        location.reload();
                            //    });
                            //}
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }
                else {
                    bootbox.alert('No Data Found to Submit');
                    return false;
                }
            });
        }

        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                return true;
            }
            else {
                return false;
            }
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

        function convertDateFormat(str_date) {
            if (str_date != '') {
                if (str_date.split('/').length == 3) {
                    var date_split = str_date.split('/');
                    var temp_date = new Date(date_split[1] + '/' + date_split[0] + '/' + date_split[2]);
                    if (temp_date.toString() == 'Invalid Date') {
                        bootbox.alert('Please Enter Date in valid format');
                        return '';
                    }
                    else {
                        return '' + (temp_date.getMonth() + 1) + '/' + temp_date.getDate() + '/' + temp_date.getFullYear();
                    }
                }
                else {
                    bootbox.alert('Please Enter Date in valid format');
                    return '';
                }
            }
            else
                return str_date;
        }
    </script>
</asp:Content>

