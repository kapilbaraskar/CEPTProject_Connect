<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Fees_Installment_Reminder.aspx.cs" Inherits="Admin_Master_Fees_Installment_Reminder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <script src="../../Js/admin_report.js" type="text/javascript"></script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Installment Reminder Mail
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
                        <table border="0" cellpadding="10" cellspacing="5" style="width:98%;">
                            <tr>
                                <td>
                                    Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester" onchange="change_mail()">
                                    </select>
                                </td>
                                <td>
                                    Year of allocation
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear" onchange="change_mail()">
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Installment
                                </td>
                                <td>
                                    <select class="chosen-select" id="drp_installment_no" onchange="change_mail()">
                                        <option value="">-- Select Installment --</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                    </select>
                                </td>
                                <td>
                                    Due Date
                                </td>
                                <td>
                                    <input type="text" id="txt_due_date" class="marg-btm" onchange="change_mail()" />
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Mail Subject
                                </td>
                                <td colspan="3">
                                    <input type="text" id="txt_mail_subject" class="marg-btm" style="width:87%;" />
                                </td>
                            </tr>
                            
                            <tr style="display:none;">
                                <td style="vertical-align:top;">
                                    Mail Body
                                </td>
                                <td colspan="3">
                                    <textarea id="txt_mail_body" rows="15" style="width:87%;"></textarea>
                                </td>
                            </tr>

                            <tr>
                                <td colspan="4" align="center">
                                    <input type="button" id="btn_send_mail" class="btn btn-primary" value="Send Mail" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>

        </div>
    </div>
    
    <script type="text/javascript">

        $(document).ready(function () {

            $('#txt_due_date').datepicker({ dateFormat: 'dd/mm/yy' });

            bindyeardata_for_cross_reg();
            bindsemdata();
            setCurrentSemester();

            $('#btn_send_mail').on('click', function () {
                send_reminder_mail();
            });

        });

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type:'fees_installment'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function change_mail() {
            if ($('#drpsemester').val() != '' && $('#drpyear').val() != '' && $('#drp_installment_no').val() != '') {
                var mail_subject = '';

                if ($('#drpsemester').val() == 'M') mail_subject += 'Monsoon ';
                else if ($('#drpsemester').val() == 'S') mail_subject += 'Spring ';

                mail_subject += $('#drpyear').val() + ' ';

                if ($('#drp_installment_no').val() == '1') mail_subject += '1st ';
                else if ($('#drp_installment_no').val() == '2') mail_subject += '2nd ';
                else if ($('#drp_installment_no').val() == '3') mail_subject += '3rd ';

                mail_subject += 'Installment Due Date';

                $('#txt_mail_subject').val(mail_subject);
            }
        }

        var semester = '';
        var year_code = '';
        var installment_no = '';
        var due_date = '';
        var mail_subject = '';
        //var dept_code = '';

        function send_reminder_mail() {

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

            installment_no = $('#drp_installment_no').val();
            if (installment_no == "") {
                bootbox.alert('Please select Installment');
                $('#drp_installment_no').focus();
                return false;
            }

            due_date = $('#txt_due_date').val();
            if (due_date == "") {
                bootbox.alert('Please select Due Date');
                $('#txt_due_date').focus();
                return false;
            }

            mail_subject = $('#txt_mail_subject').val();
            if (mail_subject == "") {
                bootbox.alert('Please enter Mail Subject');
                $('#txt_mail_subject').focus();
                return false;
            }

            //dept_code = "1";
            //if (dept_code == "") {
            //    bootbox.alert('Department Not Assigned to Send E-Mail');
            //    return false;
            //}

            var filter_criteria = { sem_code: semester, year: year_code, installment_no: installment_no, due_date: due_date, mail_subject: mail_subject };//, dept_code: dept_code 

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/fees_installment_reminder_mail",
                data: "{req_obj:'" + JSON.stringify(filter_criteria) + "'}",
                dataType: "json",
                success: function (data) {
                    var result = JSON.parse(data.d);
                    if (result['status'] == "True") {
                        bootbox.alert(result['message']);
                    }
                    else {
                        bootbox.alert(result['message']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

    </script>

</asp:Content>

