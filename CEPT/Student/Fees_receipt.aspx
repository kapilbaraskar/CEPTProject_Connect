<%@ Page Title="Fees Receipt" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Fees_receipt.aspx.cs" Inherits="Student_Fees_receipt" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Js/fees_receipt.js?t=22072021"></script>
    <script type="text/javascript">
        var OTable;
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            bindinstallment();
         

            $('#btnreterive').on('click', function () {
               
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

                var installment_no = $('#drp_installment').val();
                if (installment_no == "") {
                    bootbox.alert('Please select Installment')
                    $('#drp_installment').focus();
                    return false;
                }
                
                window.open('../Admin/Master/Print_fees_installment_pay_in_slip_admin.aspx?semester=' + semester + '&year_code=' + year_code + '&installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');

                return false;
            });

            $(document).on("click", ".offline_download", function (event) {
                var paymentmode = $(this).parent().parent().children()[2].innerText;
                var installment_no = $(this).parent().parent().children()[0].innerText;
                //var slip_path =  $(this).parent().parent().children()[6].innerText;
                var semester = $('#drpsemester').val();
                var year_code = $('#drpyear').val();
                if (paymentmode == 'Online') {
                    window.open('../Admin/Master/Print_fees_installment_pay_in_slip_admin.aspx?semester=' + semester + '&year_code=' + year_code + '&installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                    return false;
                }
            });
            $(document).on("click", ".schol_slip_download", function (event) {
                var semester = $('#drpsemester').val();
                var year_code = $('#drpyear').val();
                
              window.open('../Admin/Master/Print_scholarship_pay_in_slip.aspx?user_id=' + $('#hdn_user_id').val() + '&semester=' + semester + '&year_code=' + year_code, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
              return false;
               
            });

            $(document).on("click", ".fine_download", function (event) {
                var paymentmode = $(this).parent().parent().children()[2].innerText;
                var installment_no = $(this).parent().parent().children()[0].innerText;
                //var slip_path =  $(this).parent().parent().children()[6].innerText;
                var semester = $('#drpsemester').val();
                var year_code = $('#drpyear').val();
                if (paymentmode == 'Online') {
                    window.open('../Admin/Master/Print_fees_fine_pay_in_slip.aspx?semester=' + semester + '&year_code=' + year_code + '&installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                    return false;
                }
                else if (paymentmode == 'offline') {
                    window.open('../Admin/Master/Print_fees_fine_pay_in_ofline_slip.aspx?semester=' + semester + '&year_code=' + year_code + '&installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                    return false;
                }
            });
            $('#but_reterive').on('click', function () {
                scholarship_dtl();
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
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Get_fees_Slip_dtl",
                        //async: true,
                        data: "{semester:'" + semester + "',year:'" + year_code + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                display_fees_detail(data.d);
                                $('#div_fees_list').css('display', 'block');
                               
                                
                            }
                            else {
                                $('#div_fees_list').css('display', 'none');
                                bootbox.alert('No data Found For Selected Semester and Year');
                                return false;
                            }

                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                //debugger;
                //window.open('../Admin/Master/Print_fees_installment_pay_in_slip_admin.aspx?semester=' + semester + '&year_code=' + year_code + '&installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');

                return false;
            });



        });


        function scholarship_dtl() {
            var sem_code = $('#drpsemester').val();
            if (sem_code == "") {
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
            var user_id = $('#hdn_user_id').val();
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_scholship_Recept_dtl",
                    //async: true,
                   
                    data: "{user_id:'" + user_id + "',sem_code:'" + sem_code + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            display_scholarship_detail(data.d);
                            //$('#div_schol_list').css('display', 'block');
                            $('#div_schol_list').css('display', 'none');   //Commend 22072021
                            
                        }
                        else {
                            $('#div_schol_list').css('display', 'none');
                            //bootbox.alert('No data Found For Selected Semester and Year');
                            return false;
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            //debugger;
            //window.open('../Admin/Master/Print_fees_installment_pay_in_slip_admin.aspx?semester=' + semester + '&year_code=' + year_code + '&installment_no=' + installment_no, 'PrintMe', 'height=650px,width=1150px,scrollbars=1');

            return false;
        }
        function set_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Installment No", "mData": "installment_no" });
            columns.push({
                "sTitle": "Installment Amount", "mData": null, fnRender: function (data) {

                    if (data.aData.amount != null) {
                        return data.aData.amount;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Fees Mode", "mData": null, fnRender: function (data) {

                    if (data.aData.Payment_Mode != null) {
                        return data.aData.Payment_Mode;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Fine Amount", "mData": null, fnRender: function (data) {

                    if (data.aData.installment_fine != '' && data.aData.installment_fine != null) {
                        return data.aData.installment_fine;
                    }
                    else {
                        return '';
                    }

                }
            });
            columns.push({
                "sTitle": "Paid Fine Amount", "mData": null, fnRender: function (data) {

                    if (data.aData.paid_installment_fine != '' && data.aData.paid_installment_fine != null) {
                        return data.aData.paid_installment_fine;
                    }
                    else {
                        return '';
                    }

                }
            });

            columns.push({
                "sTitle": "Semester", "mData": null, fnRender: function (data) {

                    if (data.aData.semester_type == 'S') {
                        return 'Spring';
                    }
                    else {
                        return 'Monsoon';
                    }
                    return '';

                }
            });
            columns.push({ "sTitle": "Year", "mData": "year_semester" });
            columns.push({
                "sTitle": "Fees Receipt", "mData": null, fnRender: function (data) {
                    //return '<a class="fancybox" target="_blank" rel="group" href="../../UploadPayslip/' + slip_path + '"></a>';
                    if (data.aData.Payment_Mode == 'Online') {
                        return '<a style="cursor:pointer;color:#0B6CBA;" class="offline_download">Download</a>';
                    }
                    else if (data.aData.Payment_Mode == 'offline') {
                        return '<a class="fancybox" target="_blank" rel="group" href="../../UploadPayslip/' + data.aData.Fees_Slip_Path + '">Download</a>';
                    }

                }
            });

            //Fine Recept Command 
            //columns.push({
            //    "sTitle": "Fine Receipt", "mData": null, fnRender: function (data) {
            //        //return '<a class="fancybox" target="_blank" rel="group" href="../../UploadPayslip/' + slip_path + '"></a>';
            //        if (data.aData.installment_fine != '' && data.aData.installment_fine != null) {
            //            return '<a style="cursor:pointer;color:#0B6CBA;" class="fine_download">Download</a>';
            //        }
            //        else {
            //            return '';
            //        }
            //
            //    }
            //});

            return columns;
        }
        function display_fees_detail(data) {
            var oTable = '';
            var columns = set_table_columns(JSON.parse(data)[0]);

            if (oTable != null) {
                // oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');

            // });
        }



        function set_table_sholar_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "Student Code", "mData": "user_id" });
            columns.push({
                "sTitle": "Total Fees Amount", "mData": null, fnRender: function (data) {

                    if (data.aData.fees_amount != null) {
                        return data.aData.fees_amount;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Approve Scholarship Amount", "mData": null, fnRender: function (data) {

                    if (data.aData.apprve_scholarship_amount != null) {
                        return data.aData.apprve_scholarship_amount;
                    }
                    return '';

                }
            });
            columns.push({
                "sTitle": "Approve Date (dd-mm-yyyy)", "mData": null, fnRender: function (data) {

                    if (data.aData.approve_date != '' && data.aData.approve_date != null)
                    {
                        var approvedate = data.aData.approve_date;
                        
                            approvedate = approvedate.substring(0, approvedate.length - 11);
                            var approvedate_ = changeformate(approvedate);
                           
                       
                        return approvedate_;
                    }
                    else {
                        return '';
                    }

                }
            });
            columns.push({
                "sTitle": "Carry Forward Amount", "mData": null, fnRender: function (data) {

                    if (data.aData.carry_forward_amount != '' && data.aData.carry_forward_amount != null) {
                        return data.aData.carry_forward_amount;
                    }
                    else {
                        return '';
                    }

                }
            });

            columns.push({
                "sTitle": "Semester", "mData": null, fnRender: function (data) {

                    if (data.aData.semester_type == 'S') {
                        return 'Spring';
                    }
                    else {
                        return 'Monsoon';
                    }
                    return '';

                }
            });
            
            columns.push({ "sTitle": "Year", "mData": "year_semester"});
            columns.push({
                "sTitle": "ScholarShip Receipt", "mData": null, fnRender: function (data) {
                    var slip_path = '';

                    return '<a style="cursor:pointer;color:#0B6CBA;" class="schol_slip_download">Download</a>';
                    //if (data.aData.Payment_Mode == 'Online') {
                    //    return '<a style="cursor:pointer;color:#0B6CBA;" class="offline_download">Download</a>';
                    //}
                    //else if (data.aData.Payment_Mode == 'offline') {
                    //    return '<a class="fancybox" target="_blank" rel="group" href="../../UploadPayslip/' + data.aData.Fees_Slip_Path + '">Download</a>';
                    //}
                    return '';
           
                }
            });

            

            return columns;
        }


        function display_scholarship_detail(data) {
            var oTable1 = '';
            var columns = set_table_sholar_columns(JSON.parse(data)[0]);

            if (oTable1 != null) {
                // oTable.fnDestroy();
                $("#DataList_Schol").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_Schol" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example_Schol").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,

                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            $('#DataList_Schol').css('display', 'block');

            // });
        }

        function changeformate(values) {
            var parts = values.split('/');
            var year = parts[2].split(' ');
            var dmyDate = parts[1] + '-' + parts[0] + '-' + year[0];
            return dmyDate;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid" style="margin-top: 10px;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Fees Receipt
            </h1>
        </div>
    </div>
    <div id="div_fees_type" class="panel-body">
        <table border="0" cellpadding="5" cellspacing="5">
            <tr>
                <td>Semester :
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
                <td style="display: none;">Installment
                </td>
                <td style="display: none;">
                    <select class="chosen-select" id="drp_installment">
                    </select>
                </td>
                <td colspan="6" align="center" style="display: none;">
                    <button class="btn btn-primary" type="submit" id="btnreterive" style="border: 0px solid;">
                        Print Fee Receipt
                    </button>
                </td>

                <td colspan="6" align="center" style="display: block;">
                    <button class="btn btn-primary" type="submit" id="but_reterive" style="border: 0px solid;">
                        Reterive
                    </button>
                </td>
            </tr>
        </table>
        <div id="div_fees_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Fees Details </strong>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow: auto">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>


                <%--<div id="DataList_Schol" style="display: none; overflow: auto">
                    <table cellpadding="0" cellspacing="0" border="0" id="example_Schol" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>--%>

            </div>
        </div>




         <div id="div_schol_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>ScholarShip Detailes </strong>
            </div>
            <div>
                <div id="DataList_Schol" style="display: none; overflow: auto">
                    <table cellpadding="0" cellspacing="0" border="0" id="example_Schol" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
     <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
</asp:Content>

