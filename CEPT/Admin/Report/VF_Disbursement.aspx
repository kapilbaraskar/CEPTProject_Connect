<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="VF_Disbursement.aspx.cs" Inherits="Admin_Report_VF_Disbursement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script type="text/javascript">
        var action = 'S';

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
                mywindow.document.write(' table thead tr th:last-child {display: none;} table tbody tr td:last-child {display: none;}</style>');

                mywindow.document.write('</head>');
                mywindow.document.write('<body>');
                mywindow.document.write('<table id="tbl_VFData" cellpadding="0" cellspacing="0" width="100%" style="width: 100%;">' + $('#example').html() + '</table>');
                mywindow.document.write('<div style="text-align: center;margin-top: 10px;"><b>Note&nbsp;:&nbsp; </b>This is an electronically generated report and does not require an authorised signature.</div></body></html>');

                setTimeout(function () {
                    mywindow.print();
                    mywindow.close();
                }, 500);

                return false;
            });

            $('#mynewModal').on('hidden', function () {
                cur_row_data = '';
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;VF Disbursement
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
                <%--<span style="display:block;position:absolute;">
                    <button type="submit" id="btn_print" style="margin-top: 20px;margin-left: 450px;">Print PDF</button>
                </span>--%>
            </div>

            <div>
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
            <input id="btn_show_modal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal" value="Add Exam" style="height: 40px;margin-top: -10px;display:none;"/>
        </div>
        
        <div class="modal fade" id="mynewModal" style="display:none;top:5%;width:895px;left:38%">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="H1"></h4>
                    </div>

                    <div class="modal-body">
                        <table>
                            <tr><td><b>Course Code</b></td><td><b>&nbsp;:&nbsp;</b></td><td id="td_instructor_course"></td></tr>
                            <tr><td><b>No of Installments</b></td><td><b>&nbsp;:&nbsp;</b></td>
                                <td id="td_no_of_installments">
                                    <select id="drp_no_of_installments" onchange="set_disbursement_detail()">
                                        <option value='0'>-- Select Installments --</option>
                                        <option value='1'>1</option>
                                        <option value='2'>2</option>
                                        <option value='3'>3</option>
                                        <option value='4'>4</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        <table id="tbl_disbursement" class="table table-bordered">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>

                    <div class="modal-footer">
                        <button id="btn_modal_close" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button id="btn_modal_save" type="button" class="btn btn-primary" onclick="updateColumn()">Save changes</button>
                    </div>

                </div>
            </div>
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
        var cur_grade_sem;
        var cur_installment_date;

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
                        cur_grade_sem = JSON.parse(data.d);

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
            if ($('#hdnusertype').val() == 'AC' || $('#hdnusertype').val() == 'FA')
            {
                if ($('#hdnuserid').val() == "AC001")
                {
                    return false;

                }
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

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "oTableTools": {
                    "aButtons": []
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false },
                    { "sTitle": "VF Code", "mData": "VF_code", "bSortable": false },
                    { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Total Amount Payable", "mData": "total_amount_paid", "bSortable": false },
                    { "sTitle": "No of Installments", "mData": null, "bSortable": false, fnRender: function (data) {
                        var return_html = "";

                        if (data.aData.admin_approved == 'Y' || data.aData.installment1_enabled == 'N' || data.aData.installment2_enabled == 'N' || data.aData.installment3_enabled == 'N' || data.aData.installment4_enabled == 'N') {
                            return_html = "<select class='cls_no_of_installment' onchange='rowClick(this)' disabled><option value='0'>-- Select Installments --</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option></select>";
                        }
                        else
                            return_html = "<select class='cls_no_of_installment' onchange='rowClick(this)'><option value='0'>-- Select Installments --</option><option value='1'>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option></select>";

                        return return_html;
                    }
                    },
                    { "sTitle": "Installment 1", "mData": null, "bSortable": false, "sClass": "cls_td_installment_1", fnRender: function (data) {
                        if (data.aData.installment1 != '') {
                            var temp_date = new Date(data.aData.installment1);
                            if (data.aData.admin_approved == 'Y' || data.aData.installment1_enabled == 'N')
                                return '<input type="text" class="cls_installment_date" value="' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear() + '" disabled/>';
                            else
                                return '<input type="text" class="cls_installment_date" value="' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear() + '" />';
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Installment 2", "mData": null, "bSortable": false, "sClass": "cls_td_installment_2", fnRender: function (data) {
                        if (data.aData.installment2 != '') {
                            var temp_date = new Date(data.aData.installment2);
                            if (data.aData.admin_approved == 'Y' || data.aData.installment2_enabled == 'N')
                                return '<input type="text" class="cls_installment_date" value="' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear() + '" disabled/>';
                            else
                                return '<input type="text" class="cls_installment_date" value="' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear() + '" />';
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Installment 3", "mData": null, "bSortable": false, "sClass": "cls_td_installment_3", fnRender: function (data) {
                        if (data.aData.installment3 != '') {
                            var temp_date = new Date(data.aData.installment3);
                            if (data.aData.admin_approved == 'Y' || data.aData.installment3_enabled == 'N')
                                return '<input type="text" class="cls_installment_date" value="' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear() + '" disabled/>';
                            else
                                return '<input type="text" class="cls_installment_date" value="' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear() + '" />';
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Installment 4", "mData": null, "bSortable": false, "sClass": "cls_td_installment_4", fnRender: function (data) {
                        if (data.aData.installment4 != '') {
                            var temp_date = new Date(data.aData.installment4);
                            if (data.aData.admin_approved == 'Y' || data.aData.installment4_enabled == 'N')
                                return '<input type="text" class="cls_installment_date" value="' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear() + '" disabled/>';
                            else
                                return '<input type="text" class="cls_installment_date" value="' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear() + '" />';
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Payment 1", "mData": null, "bSortable": false, "sClass": "cls_td_payment_1", fnRender: function (data) {
                        if (data.aData.payment1 != '') {
                            var temp_date = new Date(data.aData.payment1);
                            //return data.aData.payment1;
                            if (data.aData.admin_approved == 'Y' || data.aData.installment4_enabled == 'N')
                                return '<input type="text" class="" value="' + data.aData.payment1 + '" style="width:75px;" onkeypress="return IsNumeric(event);" disabled />';
                            else
                                return '<input type="text" class="" value="' + data.aData.payment1 + '" style="width:75px;" onkeypress="return IsNumeric(event);" />';
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Payment 2", "mData": null, "bSortable": false, "sClass": "cls_td_payment_2", fnRender: function (data) {
                        if (data.aData.payment2 != '') {
                            var temp_date = new Date(data.aData.payment2);
                            //return data.aData.payment2;
                            if (data.aData.admin_approved == 'Y' || data.aData.installment4_enabled == 'N')
                                return '<input type="text" class="" value="' + data.aData.payment2 + '" style="width:75px;" onkeypress="return IsNumeric(event);" disabled />';
                            else
                                return '<input type="text" class="" value="' + data.aData.payment2 + '" style="width:75px;" onkeypress="return IsNumeric(event);" />';
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Payment 3", "mData": null, "bSortable": false, "sClass": "cls_td_payment_3", fnRender: function (data) {
                        if (data.aData.payment3 != '') {
                            var temp_date = new Date(data.aData.payment3);
                            //return data.aData.payment3;
                            if (data.aData.admin_approved == 'Y' || data.aData.installment4_enabled == 'N')
                                return '<input type="text" class="" value="' + data.aData.payment3 + '" style="width:75px;" onkeypress="return IsNumeric(event);" disabled />';
                            else
                                return '<input type="text" class="" value="' + data.aData.payment3 + '" style="width:75px;" onkeypress="return IsNumeric(event);" />';
                        }
                        else
                            return '';
                    }
                    },
                    { "sTitle": "Payment 4", "mData": null, "bSortable": false, "sClass": "cls_td_payment_4", fnRender: function (data) {
                        if (data.aData.payment4 != '') {
                            var temp_date = new Date(data.aData.payment4);
                            //return data.aData.payment4;
                            if (data.aData.admin_approved == 'Y' || data.aData.installment4_enabled == 'N')
                                return '<input type="text" class="" value="' + data.aData.payment4 + '" style="width:75px;" onkeypress="return IsNumeric(event);" disabled />';
                            else
                                return '<input type="text" class="" value="' + data.aData.payment4 + '" style="width:75px;" onkeypress="return IsNumeric(event);" />';
                        }
                        else
                            return '';
                    }
                    }
                ]
            });

            $('#DataList').css('display', 'block');

            $('#example thead th')[0].style.display = 'none';

            $('#example tbody tr').each(function (i) {
                this.children[0].style.display = 'none';

                var row = oTable.fnGetData(this);
                if (row['total_installments'] != '')
                    this.getElementsByClassName('cls_no_of_installment')[0].value = row['total_installments'];
            });

            $('.cls_no_of_installment').css('width', '90px');
            $('.cls_installment_date').datepicker({ dateFormat: 'dd/mm/yy', minDate: new Date(cur_grade_sem[0]['start_date']), maxDate: new Date(cur_grade_sem[0]['end_date']) });
            $('.cls_installment_date').css('width', '75px');
            $('.cls_installment_date').attr('readOnly', 'true');
            $('.cls_installment_date').on('change', function (e) {
                installment_date_change(e);
            });
            $('.cls_installment_date').on('focus', function (e) {
                fetch_cur_installment_date(e);
            });

            //if ($('#hdnusertype').val() == 'A1') {
            var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                  "<i class='icon-save bigger-160'></i>Save</button></td> " +
                  "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                  "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
            $('#submitBtnDiv').html(str);
            //}

            $('#btnapprove').on('click', function () {
                action = 'A';
                saveData();
            });

            $('#btnsave').on('click', function () {
                saveData();
            });
        }

        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                return true;
            }
            else {
                return false;
            }
        }

        function rowClick(element) {
            var row = element.closest('tr');
            var row_data = oTable.fnGetData(row);
            var no_of_installments = row.getElementsByClassName('cls_no_of_installment')[0].value;
            var total_amount_paid = 0;

            if (row_data['total_amount_paid'].toString() != '') {
                total_amount_paid = parseFloat(row_data['total_amount_paid'].toString());
                var tbody_part1 = '';
                var tbody_part2 = '';
                var payment_to_substract = 0;
                var start_date = new Date(cur_grade_sem[0]['start_date']);

                for (var i = 0; i < 4; i++) {
                    row.getElementsByClassName("cls_td_installment_" + (i + 1))[0].innerHTML = '';
                    row.getElementsByClassName("cls_td_payment_" + (i + 1))[0].innerHTML = '';
                }

                for (var j = 0; j < no_of_installments; j++) {
                    var installment_amount = 0;
                    if ((total_amount_paid / no_of_installments) < (total_amount_paid - payment_to_substract)) {
                        installment_amount = total_amount_paid / no_of_installments;
                    }
                    else {
                        installment_amount = total_amount_paid - payment_to_substract;
                    }
                    
                    //payment_to_substract += installment_amount;
                    payment_to_substract += parseInt(installment_amount.toFixed(0));

                    if ((no_of_installments - 1) == j) {
                        if (total_amount_paid < payment_to_substract)
                            installment_amount = installment_amount - (payment_to_substract - total_amount_paid);
                        else if (total_amount_paid > payment_to_substract)
                            installment_amount = installment_amount + (total_amount_paid - payment_to_substract);
                    }
                    
                    //tbody_part2 = installment_amount.toFixed(0);

                    if (installment_amount != 0) {
                        //tbody_part1 = '<input type="text" class="cls_installment_date" value="07/0' + (2 + j) + '/2016" />';
                        tbody_part1 = '<input type="text" class="cls_installment_date" value="07/' + (start_date.getMonth() + 1 + j) + '/2016" />';
                        tbody_part2 = '<input type="text" value="' + installment_amount.toFixed(0) + '" style="width:75px;" onkeypress="return IsNumeric(event);" />';
                    }
                    else {
                        tbody_part1 = '';
                    }

                    row.getElementsByClassName("cls_td_installment_" + (j + 1))[0].innerHTML = tbody_part1;
                    row.getElementsByClassName("cls_td_payment_" + (j + 1))[0].innerHTML = tbody_part2;
                }

                $('.cls_installment_date').datepicker({ dateFormat: 'dd/mm/yy', minDate: new Date(cur_grade_sem[0]['start_date']), maxDate: new Date(cur_grade_sem[0]['end_date']) });
                $('.cls_installment_date').css('width', '75px');
                $('.cls_installment_date').attr('readOnly', 'true');
                $('.cls_installment_date').on('change', function (e) {
                    installment_date_change(e);
                });
                $('.cls_installment_date').on('focus', function (e) {
                    fetch_cur_installment_date(e);
                });
            }
        }

        var cur_row_data = '';
        function rowClick_old(element) {
            
            $('#H1').html('');
            $('#td_instructor_course').html('');
            $('#tbl_disbursement thead').html('');
            $('#tbl_disbursement tbody').html('');

            var row = element.closest('tr');
            var row_data = oTable.fnGetData(row);
            cur_row_data = row_data;

            $('#H1').html(row_data['VF_code'].toString() + ' - ' + row_data['instructor_name'].toString());
            $('#td_instructor_course').html(row_data['course_code'].toString());

            set_disbursement_detail();

            $('#btn_show_modal').click();
        }

        function fetch_cur_installment_date(e) {
            cur_installment_date = e.currentTarget.value;
        }

        function installment_date_change(e) {
            var row = e.currentTarget.closest('tr');
            var row_data = oTable.fnGetData(row);
            var no_of_installments = row.getElementsByClassName('cls_no_of_installment')[0].value;
            var total_amount_paid = 0;
            var obj_payment = [];

            if (no_of_installments != '4' && row_data['total_amount_paid'].toString() != '') {
                total_amount_paid = parseFloat(row_data['total_amount_paid'].toString());
                var tbody_part1 = '';
                var tbody_part2 = '';
                var payment_to_substract = 0;
                var start_date = new Date(cur_grade_sem[0]['start_date']);

                for (var i = 0; i < 4; i++) {
                    row.getElementsByClassName("cls_td_payment_" + (i + 1))[0].innerHTML = '';
                }

                for (var j = 0; j < no_of_installments; j++) {
                    var installment_amount = 0;
                    if ((total_amount_paid / no_of_installments) < (total_amount_paid - payment_to_substract)) {
                        installment_amount = total_amount_paid / no_of_installments;
                    }
                    else {
                        installment_amount = total_amount_paid - payment_to_substract;
                    }

                    payment_to_substract += parseInt(installment_amount.toFixed(0));

                    if ((no_of_installments - 1) == j) {
                        if (total_amount_paid < payment_to_substract)
                            installment_amount = installment_amount - (payment_to_substract - total_amount_paid);
                        else if (total_amount_paid > payment_to_substract)
                            installment_amount = installment_amount + (total_amount_paid - payment_to_substract);
                    }

                    tbody_part2 = installment_amount.toFixed(0);

                    obj_payment.push(tbody_part2);
                }

                for (var j = 0; j < no_of_installments; j++) {
                    var temp_installment_date = new Date(convertDateFormat(row.getElementsByClassName("cls_td_installment_" + (j + 1))[0].getElementsByClassName('cls_installment_date')[0].value));
                    var payment_index = (temp_installment_date.getMonth() - start_date.getMonth()) + 1;
                    var month_payment = parseInt(obj_payment[j]);

                    if (row.getElementsByClassName("cls_td_payment_" + (payment_index))[0].innerHTML != '') {
                        month_payment += parseInt(row.getElementsByClassName("cls_td_payment_" + (payment_index))[0].innerHTML);
                    }

                    row.getElementsByClassName("cls_td_payment_" + (payment_index))[0].innerHTML = month_payment.toString();
                }
            }
        }

        function set_disbursement_detail() {
            var str_thead = '<tr><th>Total Amount Payable</th><th>No of Installments</th>';

            var no_of_installments = parseInt($('#drp_no_of_installments').val());
            for (var i = 0; i < no_of_installments; i++) {
                str_thead += '<th>Installment ' + (i + 1) + '</th>';
            }
            for (var i = 0; i < no_of_installments; i++) {
                str_thead += '<th>Payment ' + (i + 1) + '</th>';
            }

            str_thead += '</tr>';

            $('#tbl_disbursement thead').html(str_thead);

            var str_tbody = '';
            var total_amount_paid = 0;
            if (cur_row_data['total_amount_paid'].toString() != '') {
                total_amount_paid = parseFloat(cur_row_data['total_amount_paid'].toString());

                for (var i = no_of_installments; i > 0; i--) {
                    str_tbody += '<tr><td>' + total_amount_paid + '</td><td>' + i + '</td>';
                    var tbody_part1 = '';
                    var tbody_part2 = '';
                    var no_of_installments = parseInt($('#drp_no_of_installments').val());

                    var payment_to_substract = 0;
                    for (var j = 0; j < no_of_installments; j++) {
                        var installment_amount = 0;
                        if ((total_amount_paid / i) < (total_amount_paid - payment_to_substract)) {
                            installment_amount = total_amount_paid / i;
                        }
                        else {
                            installment_amount = total_amount_paid - payment_to_substract;
                        }
                        tbody_part2 += '<td>' + installment_amount.toFixed(0) + '</td>';
                        payment_to_substract += installment_amount;

                        if (installment_amount != 0) {
                            tbody_part1 += '<td><input type="text" class="cls_installment_date" value="07/0' + (2 + j) + '/2016" /></td>';
                        }
                        else {
                            tbody_part1 += '<td></td>';
                        }
                    }

                    str_tbody += tbody_part1 + tbody_part2;
                    str_tbody += '</tr>';
                }

                $('#tbl_disbursement tbody').html(str_tbody);
                $('.cls_installment_date').datepicker({ dateFormat: 'dd/mm/yy', minDate: new Date(cur_grade_sem[0]['start_date']), maxDate: new Date(cur_grade_sem[0]['end_date']) });
                $('.cls_installment_date').css('width', '75px');
                $('.cls_installment_date').attr('readOnly', 'true');
                $('.cls_installment_date').on('change', function (e) {
                    installment_date_change(e);
                });
                $('.cls_installment_date').on('focus', function (e) {
                    fetch_cur_installment_date(e);
                });
            } 
        }

        function saveData() {
            var arr_disbursement_data = [];
            var duplicate = false;
            var total_amount_status = { 'status': true };

            $('#example tbody tr').each(function (i) {
                var row = this;
                var row_data = oTable.fnGetData(row);
                var no_of_installments = row.getElementsByClassName('cls_no_of_installment')[0].value;
                var obj_disbursement_data = { 'instructor_code': '', 'course_code': '', 'total_amount_payable': '', 'total_installments': '', 'installment_1': '', 'installment_2': '', 'installment_3': '', 'installment_4': '', 'payment_1': '', 'payment_2': '', 'payment_3': '', 'payment_4': '', 'semester_type': '', 'year_semester': '' };

                obj_disbursement_data.instructor_code = row_data['instructor_code'].toString();
                obj_disbursement_data.course_code = row_data['course_code'].toString();
                obj_disbursement_data.total_amount_payable = row_data['total_amount_paid'].toString();
                obj_disbursement_data.total_installments = no_of_installments;
                obj_disbursement_data.semester_type = semester;
                obj_disbursement_data.year_semester = year_code;

                var total_entered_amount = 0;
                //for (var j = 1; j <= no_of_installments; j++) {
                for (var j = 1; j <= 4; j++) {
                    if (row.getElementsByClassName("cls_td_installment_" + j)[0].innerHTML != '') {
                        var temp_date = convertDateFormat(row.getElementsByClassName("cls_td_installment_" + j)[0].getElementsByClassName("cls_installment_date")[0].value);

                        if (temp_date == '') return false;
                        else obj_disbursement_data['installment_' + j] = temp_date;

                        for (var k = 0; k < j; k++) {
                            if (new Date(temp_date).getMonth() == (new Date(obj_disbursement_data['installment_' + k])).getMonth()) {
                                bootbox.alert('Duplicate Month Not allowed in Installment Date for Instructor : ' + row_data['instructor_name'].toString() + ' and Course : ' + row_data['course_code'].toString());
                                duplicate = true;
                                return false;
                            }
                        }
                    }

                    if (row.getElementsByClassName("cls_td_payment_" + j)[0].innerHTML != '') {
                        if (row.getElementsByClassName("cls_td_payment_" + j)[0].children.length > 0) {
                            //obj_disbursement_data['payment_' + j] = row.getElementsByClassName("cls_td_payment_" + j)[0].innerHTML;
                            obj_disbursement_data['payment_' + j] = row.getElementsByClassName("cls_td_payment_" + j)[0].children[0].value;
                            total_entered_amount += parseFloat(row.getElementsByClassName("cls_td_payment_" + j)[0].children[0].value);
                        }
                    }
                }

                if (no_of_installments != '0') {
                    if (total_entered_amount != parseFloat(row_data['total_amount_paid'].toString())) {
                        total_amount_status['status'] = false;
                        total_amount_status['instructor_name'] = row_data['instructor_name'].toString();
                        total_amount_status['course_code'] = row_data['course_code'].toString();
                        return false;
                    } 
                }

                arr_disbursement_data.push(obj_disbursement_data);
            });

            if (duplicate) return false;

            if (!total_amount_status['status']) {
                bootbox.alert("Total Entered Amount and Total Payable Amount are not same for Instructor '"+total_amount_status['instructor_name']+"' and Course '"+total_amount_status['course_code']+"'");
                return false;
            }

            var All_table_course_data = [arr_disbursement_data, action];
            var json_All_table_course_data = JSON.stringify(All_table_course_data);

            if (json_All_table_course_data.search("'") != -1) {
                json_All_table_course_data = json_All_table_course_data.replace(/\'/g, '\\\'');
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_VF_disbursement_data",

                data: "{ All_table_course_data: '" + json_All_table_course_data + "' }",
                dataType: "json",
                success: function (data) {

                    if (data.d == 'Data Saved Successfully') {
                        if (action == 'A') {
                            bootbox.alert('Data Submitted Successfully', function () {
                                location.reload();
                            });
                        }
                        else {
                            bootbox.alert(data.d, function () {
                                location.reload();
                            });
                        }
                    }
                    else if (data.d != "") {
                        alert(data.d);
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
