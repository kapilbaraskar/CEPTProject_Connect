<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="FeesBankDtl_Add.aspx.cs" Inherits="Admin_Master_FeesBankDtl_Add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindProgram();
            bindAllocationYear();
            bindSemesterCode();
           
            $('#drpdepartment').on('change', dept_change);
            
            if ($('#hdn_sem').val() == '' || $('#hdn_year').val() == '' || $('#hdn_dept').val() == '' || $('#hdn_prog').val() == '' || $('#hdn_allo_year').val() == '')
            {
                //Hide Row 
                $('table tr:nth-child(n+12)').hide();
                $('#btn_save').css('display', 'block');
                $('#btn_save').on('click', save_fees_detail);
            }
            else {
                retrieveFeesData();
                $('#btn_update').css('display', 'block');
                $('#btn_update').on('click', update_fees_detail);
            }
            //txt_start_date

            $('input[id$=txt_start_date]').datepicker({
               dateFormat: 'dd-mm-yy'
            });

            $('input[id$=txt_end_date]').datepicker({
               dateFormat: 'dd-mm-yy'
            });

            $('input[id$=txt_end_date_two]').datepicker({
               dateFormat: 'dd-mm-yy'
            });

            $('input[id$=txt_end_date_third]').datepicker({
               dateFormat: 'dd-mm-yy'
             });
        });

        function changeformate(values)
        {
            var parts = values.split('/');
            var year = parts[2].split(' ');
            var dmyDate = parts[1] + '-' + parts[0] + '-' + year[0];
            return dmyDate;
        }

        function bindProgram() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Program --"));
            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function bindAllocationYear() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d);
                        $('#drp_allocation_year').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drp_allocation_year').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"] + '-' + (parseInt(year_data[i]["year_desc"]) + 1).toString().substr(2)));
                        }
                        $('#drp_allocation_year').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindSemesterCode() {
            $('#drp_semester_code').empty().append($("<option></option>").val("").html("-- Please Select Semester Code --"));

            for (var i = 1; i <= 10; i++) {
                $('#drp_semester_code').append($("<option></option>").val(i.toString()).html(i.toString()));
            }

            $('#drp_semester_code').chosen();
        }

        function dept_change() {
            $('#txt_account_name').val('');
            $('#txt_bank_code').val('');

            if ($('#drpdepartment').val() != '') {
                switch ($('#drpdepartment').val()) {
                    case '1':
                        $('#txt_account_name').val('CEPT FACULTY OF ARCHITECTURE');
                        $('#txt_bank_code').val('FCCFAR');
                        break;
                    case '2':
                        $('#txt_account_name').val('CEPT FACULTY OF DESIGN');
                        $('#txt_bank_code').val('FCCEFD');
                        break;
                    case '3':
                        $('#txt_account_name').val('CEPT FACULTY OF MANAGEMENT');
                        $('#txt_bank_code').val('FCCFOM');
                        break;
                    case '4':
                        $('#txt_account_name').val('CEPT FACULTY OF PLANNING');
                        $('#txt_bank_code').val('FCCFOP');
                        break;
                    case '5':
                        $('#txt_account_name').val('CEPT FACULTY OF TECHNOLOGY');
                        $('#txt_bank_code').val('FCCPFT');
                        break;
                }
            }
        }
        
        var retrieved_fees_data;
        function retrieveFeesData() {
            
            // Retrieve Using semester_type , year_semester , dept_code , prog_code , year_code
            var obj_fees_data = {
                'semester_type': $('#hdn_sem').val(),
                'year_semester': $('#hdn_year').val(),
                'dept_code': $('#hdn_dept').val(),
                'prog_code': $('#hdn_prog').val(),
                'year_code': $('#hdn_allo_year').val(),
                'nationality': $('#hdn_nationality').val()
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_fees_bank_detail",
                async: false,
                data: "{fees_data:'" + JSON.stringify(obj_fees_data) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != '') {
                        retrieved_fees_data = JSON.parse(data.d);

                        $('#drpsemester').val(retrieved_fees_data[0]['semester_type']);
                        $('#drpyear').val(retrieved_fees_data[0]['year_semester']);
                        $('#drpdepartment').val(retrieved_fees_data[0]['dept_code']);
                        $('#drpprog').val(retrieved_fees_data[0]['prog_code']);
                        $('#txt_account_name').val(retrieved_fees_data[0]['account_name']);
                        $('#txt_bank_code').val(retrieved_fees_data[0]['bank_code']);
                        $('#drp_semester_code').val(retrieved_fees_data[0]['semester_code']);
                        $('#txt_first_fine').val(retrieved_fees_data[0]['fine']);
                        $('#txt_second_fine').val(retrieved_fees_data[0]['fine2']);
                        $('#txt_installment_first').val(retrieved_fees_data[0]['installment1']);
                        $('#txt_installment_second').val(retrieved_fees_data[0]['installment2']);
                        $('#txt_installment_third').val(retrieved_fees_data[0]['installment3']);

                      
                        var startdate = retrieved_fees_data[0]['start_date'];
                        if (startdate != ""  && typeof startdate != 'undefined')
                        {
                            startdate = startdate.substring(0, startdate.length - 11);
                            var startdate_ = changeformate(startdate);
                        }
                        var enddate = retrieved_fees_data[0]['end_date'];
                        if (enddate != "" && typeof enddate != 'undefined')
                        {
                            enddate = enddate.substring(0, enddate.length - 11);
                            var enddate_ = changeformate(enddate);
                        }
                        var enddate2 = retrieved_fees_data[0]['end_date2'];
                        if (enddate2 != "" && typeof enddate2 != 'undefined')
                        {
                            enddate2 = enddate2.substring(0, enddate2.length - 11);
                            var enddate2_ = changeformate(enddate2);
                        }
                        var enddate3 = retrieved_fees_data[0]['end_date3'];
                        if (enddate3 != "" && typeof enddate3 != 'undefined')
                        {
                            enddate3 = enddate3.substring(0, enddate3.length - 11);
                            var enddate3_ = changeformate(enddate3);
                        }
                        

                        $('#txt_start_date').val(startdate_);
                        $('#txt_end_date').val(enddate_);
                        $('#txt_end_date_two').val(enddate2_);
                        $('#txt_end_date_third').val(enddate3_);


                        if (retrieved_fees_data.length == 2)
                        {
                            if (retrieved_fees_data[0]['gender'] == 'M')
                            {
                                $('#txt_male_fees').val(retrieved_fees_data[0]['fees']);
                                $('#txt_female_fees').val(retrieved_fees_data[1]['fees']);
                            }
                            else if (retrieved_fees_data[0]['gender'] == 'F')
                            {
                                $('#txt_male_fees').val(retrieved_fees_data[1]['fees']);
                                $('#txt_female_fees').val(retrieved_fees_data[0]['fees']);
                            }
                        }
                        else if (retrieved_fees_data.length == 1)
                        {
                            if (retrieved_fees_data[0]['gender'] == 'M') {
                                $('#txt_male_fees').val(retrieved_fees_data[0]['fees']);
                            }
                            else if (retrieved_fees_data[0]['gender'] == 'F') {
                                $('#txt_female_fees').val(retrieved_fees_data[0]['fees']);
                            }
                        }

                        if (retrieved_fees_data[0]['year_code'] == "Y1")
                            $('#drp_allocation_year').val('2013');
                        else if (retrieved_fees_data[0]['year_code'] != "")
                            $('#drp_allocation_year').val(retrieved_fees_data[0]['year_code'].substr(1));

                        $("#drpsemester,#drpyear,#drpdepartment,#drpprog,#drp_allocation_year,#drp_semester_code").trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function save_fees_detail() {
            if ($('#drpsemester').val() == '') { bootbox.alert('Please Select Semester'); return false; }
            if ($('#drpyear').val() == '') { bootbox.alert('Please Select Year'); return false; }
            if ($('#drpdepartment').val() == '') { bootbox.alert('Please Select Department'); return false; }
            if ($('#drpprog').val() == '') { bootbox.alert('Please Select Program'); return false; }
            if ($('#txt_account_name').val() == '') { bootbox.alert('Please Enter Account Name'); return false; }
            if ($('#txt_bank_code').val() == '') { bootbox.alert('Please Enter Bank Code'); return false; }
            if ($('#drp_allocation_year').val() == '') { bootbox.alert('Please Select Allocation Year'); return false; }
            if ($('#drp_semester_code').val() == '') { bootbox.alert('Please Select Semester Code'); return false; }
            if ($('#txt_male_fees').val() == '') { bootbox.alert('Please Enter Fees for Male'); return false; }
            if ($('#txt_female_fees').val() == '') { bootbox.alert('Please Enter Fees for Female'); return false; }
            if ($('#txt_first_fine').val() == '') { bootbox.alert('Please Enter Upto 7 Days Fine'); return false; }
            if ($('#txt_second_fine').val() == '') { bootbox.alert('Please Enter Upto 84 Days Fine'); return false; }

            if ($('#txt_start_date').val() == '') { bootbox.alert('Please Enter Start Date'); return false; }
            if ($('#txt_end_date').val() == '') { bootbox.alert('Please Enter End Date'); return false; }
            if ($('#txt_end_date_two').val() == '') { bootbox.alert('Please Enter End Date Two'); return false; }
            if ($('#txt_end_date_third').val() == '') { bootbox.alert('Please Enter End Third'); return false; }


            var obj_fees_data = {
                'semester_type': $('#drpsemester').val(),
                'year_semester': $('#drpyear').val(),
                'dept_code': $('#drpdepartment').val(),
                'prog_code': $('#drpprog').val(),
                'account_name': $('#txt_account_name').val(),
                'bank_code': $('#txt_bank_code').val(),
                'year': '',
                'year_code': '',
                'semester_code': $('#drp_semester_code').val(),
                'male_fees': $('#txt_male_fees').val(),
                'female_fees': $('#txt_female_fees').val(),
                'fine': $('#txt_first_fine').val(),
                'fine2': $('#txt_second_fine').val(),
                'start_date': $('#txt_start_date').val(),
                'end_date': $('#txt_end_date').val(),
                'end_date2' : $('#txt_end_date_two').val(),
                'end_date3': $('#txt_end_date_third').val(),
                'nationality': $('#hdn_nationality').val()
            };

            obj_fees_data.year = $('#drp_allocation_year').val() + '-' + (parseInt($('#drp_allocation_year').val()) + 1).toString().substr(2);

            if ($('#drp_allocation_year').val() == "2013")
                obj_fees_data.year_code = 'Y1';
            else

                obj_fees_data.year_code = 'Y' + $('#drp_allocation_year').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_fees_bank_detail",
                async: false,
                data: "{fees_data:'" + JSON.stringify(obj_fees_data) + "'}",
                dataType: "json",
                success: function (data) {
                    bootbox.alert(JSON.parse(data.d)['message']);
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function update_fees_detail() {
            
            if ($('#drpsemester').val() == '') { bootbox.alert('Please Select Semester'); return false; }
            if ($('#drpyear').val() == '') { bootbox.alert('Please Select Year'); return false; }
            if ($('#drpdepartment').val() == '') { bootbox.alert('Please Select Department'); return false; }
            if ($('#drpprog').val() == '') { bootbox.alert('Please Select Program'); return false; }
            if ($('#txt_account_name').val() == '') { bootbox.alert('Please Enter Account Name'); return false; }
            if ($('#txt_bank_code').val() == '') { bootbox.alert('Please Enter Bank Code'); return false; }
            if ($('#drp_allocation_year').val() == '') { bootbox.alert('Please Select Allocation Year'); return false; }
            if ($('#drp_semester_code').val() == '') { bootbox.alert('Please Select Semester Code'); return false; }
            if ($('#txt_male_fees').val() == '') { bootbox.alert('Please Enter Fees for Male'); return false; }
            if ($('#txt_female_fees').val() == '') { bootbox.alert('Please Enter Fees for Female'); return false; }

             if ($('#txt_first_fine').val() == '') { bootbox.alert('Please Enter Upto 7 Days Fine'); return false; }
            if ($('#txt_second_fine').val() == '') { bootbox.alert('Please Enter Upto 84 Days Fine'); return false; }

            if ($('#txt_start_date').val() == '') { bootbox.alert('Please Enter Start Date'); return false; }
            if ($('#txt_end_date').val() == '') { bootbox.alert('Please Enter End Date'); return false; }
            if ($('#txt_end_date_two').val() == '') { bootbox.alert('Please Enter End Date Two'); return false; }
            if ($('#txt_end_date_third').val() == '') { bootbox.alert('Please Enter End Third'); return false; }


            var obj_fees_data = {
                'semester_type': $('#drpsemester').val(),
                'year_semester': $('#drpyear').val(),
                'dept_code': $('#drpdepartment').val(),
                'prog_code': $('#drpprog').val(),
                'account_name': $('#txt_account_name').val(),
                'bank_code': $('#txt_bank_code').val(),
                'year': '',
                'year_code': '',
                'semester_code': $('#drp_semester_code').val(),
                'male_fees': $('#txt_male_fees').val(),
                'female_fees': $('#txt_female_fees').val(),
                'fine': $('#txt_first_fine').val(),
                'fine2': $('#txt_second_fine').val(),
                'start_date': $('#txt_start_date').val(),
                'end_date': $('#txt_end_date').val(),
                'end_date2' : $('#txt_end_date_two').val(),
                'end_date3' : $('#txt_end_date_third').val(),
                'installment1' : $('#txt_installment_first').val(),
                'installment2' : $('#txt_installment_second').val(),
                'installment3': $('#txt_installment_third').val(),
                'nationality': $('#hdn_nationality').val()

            };

            obj_fees_data.year = $('#drp_allocation_year').val() + '-' + (parseInt($('#drp_allocation_year').val()) + 1).toString().substr(2);

            if ($('#drp_allocation_year').val() == "2013") obj_fees_data.year_code = 'Y1';
            else obj_fees_data.year_code = 'Y' + $('#drp_allocation_year').val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/update_fees_bank_detail",
                async: false,
                data: "{fees_data:'" + JSON.stringify(obj_fees_data) + "'}",
                dataType: "json",
                success: function (data) {
                    bootbox.alert(JSON.parse(data.d)['message']);
                },
                error: function (result)
                {
                    alert(result);
                }
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

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="div_fees_bank_dtl" style="margin-top: 15px;margin-bottom: 40px;" class="panel panel-default">
        <div class="panel-heading">
            <strong>Enter Fees Detail</strong>
        </div>
        <div style="padding-top: 15px;">
            <table border="0" cellpadding="2" cellspacing="2" style="width:100%;" align="center">
                <tr>
                    <td style="padding-left: 15px;">
                        <b>Semester</b>
                    </td>
                    <td>
                        <select class="chosen-select" id="drpsemester"></select>
                    </td>
                        
                    <td>
                        <b>Year</b>
                    </td>
                    <td>
                        <select class="chosen-select" id="drpyear"></select>
                    </td>
                </tr>
                
                <tr><td colspan=4 style="padding-top:6px;"></td></tr>
                
                <tr>
                    <td style="padding-left: 15px;">
                        <b>Department</b>
                    </td>
                    <td>
                        <select class="chosen-select" id="drpdepartment" />
                    </td>
                        
                    <td>
                        <b>Program</b>
                    </td>
                    <td>
                        <select class="chosen-select" id="drpprog"></select>
                    </td>
                </tr>
                
                <tr><td colspan=4 style="padding-top:6px;"></td></tr>
                
                <tr>
                    <td style="padding-left: 15px;">
                        <b>Account Name</b>
                    </td>
                    <td>
                        <input type="text" id="txt_account_name" />
                    </td>
                        
                    <td>
                        <b>Bank Code</b>
                    </td>
                    <td>
                        <input type="text" id="txt_bank_code" />
                    </td>
                </tr>

                <tr>
                    <td style="padding-left: 15px;">
                        <b>Allocation Year</b>
                    </td>
                    <td>
                        <select class="chosen-select" id="drp_allocation_year"></select>
                    </td>
                        
                    <td>
                        <b>Semester Code</b>
                    </td>
                    <td>
                        <select class="chosen-select" id="drp_semester_code"></select>
                    </td>
                </tr>
                
                <tr><td colspan=4 style="padding-top:6px;"></td></tr>
                
                <tr>
                    <td style="padding-left: 15px;">
                        <b>Male Fees</b>
                    </td>
                    <td>
                        <input type="text" id="txt_male_fees" maxlength=7 onkeypress='return IsNumeric(event);' />
                    </td>
                        
                    <td>
                        <b>Female Fees</b>
                    </td>
                    <td>
                        <input type="text" id="txt_female_fees" maxlength=7 onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>
                <tr>

                    <td style="padding-left: 15px;">
                        <b>Upto 7 Days Fine</b>
                    </td>
                    <td>
                        <input type="text" id="txt_first_fine" maxlength=7 onkeypress='return IsNumeric(event);' />
                    </td>
                    <td>
                        <b> Upto 84 Days Fine</b>
                    </td>
                    <td>
                        <input type="text" id="txt_second_fine" maxlength=7 onkeypress='return IsNumeric(event);' />
                    </td>

                </tr>
                <tr>
                       <td style="padding-left: 15px;">
                        <b>Start Date</b>
                    </td>
                    <td>
                        <input type="text" id="txt_start_date" />
                    </td>
                    <td>
                        <b>Inst. 1 - End Date</b>
                    </td>
                    <td>
                        <input type="text" id="txt_end_date"  />
                    </td>

                </tr>

                 <tr>
                       <td style="padding-left: 15px;">
                        <b>Inst. 2 - End Date</b>
                    </td>
                    <td>
                        <input type="text" id="txt_end_date_two" />
                    </td>
                    <td>
                        <b>Inst. 3 - End Date</b>
                    </td>
                    <td>
                        <input type="text" id="txt_end_date_third"  />
                    </td>

                </tr>

                <tr>
                       <td style="padding-left: 15px;">
                        <b>Inst. 1</b>
                    </td>
                    <td>
                        <input type="text" id="txt_installment_first" maxlength=7 onkeypress='return IsNumeric(event);'/>
                    </td>
                    <td>
                        <b>Inst. 2</b>
                    </td>
                    <td>
                        <input type="text" id="txt_installment_second" maxlength=7 onkeypress='return IsNumeric(event);'/>
                    </td>

                </tr>
                <tr>
                    <td style="padding-left: 15px;">
                        <b>Inst. 3</b>
                    </td>
                    <td>
                        <input type="text" id="txt_installment_third" maxlength=7 onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>

                <tr><td colspan=4 style="padding-top:2px;"></td></tr>
                        
                <tr>
                    <td colspan=4 style="padding:10px;background-color: #eff3f8;border-top:1px solid #DDD;">
                        <center>
                            <input type="button"  id="btn_save" style="line-height: inherit;display:none;" class="btn btn-lg btn-primary" value="Save" />
                            <input type="button"  id="btn_update" style="line-height: inherit;display:none;" class="btn btn-lg btn-primary" value="Update" />
                        </center>
                    </td>
                </tr>
            </table>

            <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_dept" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_prog" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_allo_year" runat="server" clientidmode="Static" />
            <input type="hidden" id="hdn_nationality" runat="server" clientidmode="Static" />
        </div>
    </div>
</asp:Content>

