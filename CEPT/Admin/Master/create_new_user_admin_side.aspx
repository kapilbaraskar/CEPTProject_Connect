<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="create_new_user_admin_side.aspx.cs" Inherits="Admin_Master_create_new_user_admin_side" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script src="../../Js/admin_report.js?t=17062021" type="text/javascript"></script>

    <script type="text/javascript">
        var save_status = 'S';
        $(document).ready(function () {

            binddepartment();
            bindproglevel();
            bindprogrammedata();
            get_user_dtl();
            var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                "<i class='icon-save bigger-160'></i>Save</button></td> " +
                "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                "<i class='icon-save bigger-160'></i>Submit</button></td></tr></table>";
            $('#submitBtnDiv').html(str);

            $('#btnsave').on('click', function ()
            {
                if ($('#txt_first_name').val() == '') {
                    bootbox.alert("Please Insert First Name");
                    return false;
                }
                if ($('#txt_last_name').val() == '') {
                    bootbox.alert("Please Insert Last Name");
                    return false;
                }
                if ($('#txt_email').val() == '') {
                    bootbox.alert("Please Insert Email ID");
                    return false;
                }
                if ($('#txt_user_type').val() == '') {
                    bootbox.alert("Please Insert User Type");
                    return false;
                }
                if (save_status == 'A')
                {
                    if ($('#drp_gender').val() == '') {
                        bootbox.alert("Please Select Gender");
                        return false;
                    }
                    if ($('#txt_mobile_no').val() == '') {
                        bootbox.alert("Please Insert Mobile Number");
                        return false;
                    }
                    if ($('#txt_dob').val() == '') {
                        bootbox.alert("Please Insert Date of Birth ");
                        return false;
                    }
                    if ($('#drpdepartment').val() == '') {
                        bootbox.alert("Please Select Department ");
                        return false;
                    }
                }
                var instructor_data = { 'first_name': '', 'last_name': '', 'gender': '', 'mail': '', 'mobile_no': '', 'phone_no': '', 'dob': '', 'blood_group': '', 'dept_code': '', 'prog_code': '', 'prog_level_code': '', 'user_type': '', 'save_sub_status': '', 'user_status_flag': '', 'status': '', 'cancel_flag': '' };

                instructor_data.first_name = $('#txt_first_name').val();
                instructor_data.last_name = $('#txt_last_name').val();
                instructor_data.gender = $('#drp_gender').val();
                instructor_data.mail = $('#txt_email').val();
                instructor_data.mobile_no = $('#txt_mobile_no').val();
                instructor_data.blood_group = $('#txt_blood_group').val();
                instructor_data.phone_no = $('#txt_alternate_contact_no').val();
                if ($('#txt_dob').val() != '') {
                    var str_dob = $('#txt_dob').val().split('/');
                    instructor_data.dob = str_dob[1] + '/' + str_dob[0] + '/' + str_dob[2];
                }
                instructor_data.dept_code = $('#drpdepartment').val();
                instructor_data.prog_code = $('#drpprog').val();
                instructor_data.prog_level_code = $('#drpproglevel').val();
                instructor_data.user_type = $('#txt_user_type').val();
                if (save_status == "S") {
                    instructor_data.save_sub_status = 'S';
                    instructor_data.user_status_flag = 'D';
                    instructor_data.status = 'D';
                    instructor_data.cancel_flag = 'Y';


                }
                else
                {
                    instructor_data.save_sub_status = 'A';
                    instructor_data.user_status_flag = 'A';
                    instructor_data.status = 'A';
                    instructor_data.cancel_flag = 'N';
                }
                

                var All_instructor_data = [instructor_data];
                var json_All_instructor_data = JSON.stringify(All_instructor_data);

                if (json_All_instructor_data.search("'") != -1) {
                    json_All_instructor_data = json_All_instructor_data.replace(/\'/g, '\\\'');
                }
                var url_dtl = '';
                var parameter_dtl = '';
                if ($('#hdn_user_type').val() == 'N')
                {
                    url_dtl = "../../WebService.asmx/create_user_admin_side";
                    parameter_dtl = "{ json_All_instructor_data: '" + json_All_instructor_data + "' }";
                }
                else
                {
                    url_dtl = "../../WebService.asmx/exits_user_admin_side";
                    parameter_dtl = "{ json_All_instructor_data: '" + json_All_instructor_data + "',user_id:'" + $('#hdn_user_id').val()+"' }";
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    //url: "../../WebService.asmx/save_instructor_data",
                    url: url_dtl,
                    async: false,
                    data: parameter_dtl,
                    dataType: "json",
                    success: function (data) {

                        if (data.d == 'Submit successfully. Sign-in on Connect.') {
                          alert('Submit successfully. Sign-in on Connect.');
                        }
                        else if (data.d == "Data Save successfully") {
                         alert('Data Save successfully');
                        }
                        else if (data.d == "Problem In Data") {
                            alert('Problem In Data');
                        }
                        location.reload();
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

            $('#btnapprove').on('click', function ()
            {
                save_status = 'A';
                $('#btnsave').click();
            });

            return false;
        });
        
        function get_user_dtl()
        {
            var parameter_value;
            if ($('#hdn_user_type').val() == 'N') {
                parameter_value = "{user_id: ''}";
            }
            else { parameter_value = "{user_id: '" + $('#hdn_user_id').val()+"'}";}
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_save_user_dtl",
                data: parameter_value,
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if ($('#hdn_user_type').val() != 'N')
                        {
                            var get_data_user = JSON.parse(data.d);
                            $('#txt_first_name').val(get_data_user[0]['first_name']);
                            $('#txt_last_name').val(get_data_user[0]['last_name']);
                            $('#drp_gender').val(get_data_user[0]['gender']);

                            $('#txt_email').val(get_data_user[0]['mail']);
                            $('#txt_mobile_no').val(get_data_user[0]['mobile_no']);

                            $('#txt_blood_group').val(get_data_user[0]['blood_group']);
                            //$('#txt_alternate_contact_no').val(get_data_user[0]['gender']);

                            var dateofbirth = get_data_user[0]['dob'];
                            if (dateofbirth != "" && typeof dateofbirth != 'undefined') {
                                dateofbirth = dateofbirth.substring(0, dateofbirth.length - 11);
                                var dateofbirth_ = changeformate(dateofbirth);
                                $('#txt_dob').val(dateofbirth_);
                            }


                            $('#drpdepartment').val(get_data_user[0]['dept_code']);
                            $('#drpdepartment').change();
                            $('#drpdepartment').trigger("liszt:updated");
                            $('#drpprog').val(get_data_user[0]['prog_code']);
                            $('#drpprog').change();
                            $('#drpprog').trigger("liszt:updated");

                            $('#drpproglevel').val(get_data_user[0]['prog_level_code']);
                            $('#drpproglevel').change();
                            $('#drpproglevel').trigger("liszt:updated");
                            $('#txt_user_type').val(get_data_user[0]['user_type']);

                        }
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

        function changeformate(values) {
            var parts = values.split('/');
            var year = parts[2].split(' ');
            var dmyDate = parts[1] + '/' + parts[0] + '/' + year[0];
            return dmyDate;
        }

    </script>


    <style type="text/css">
        .required {
            color: Red;
        }
    </style>
    <style type="text/css">
        .style_prevu_kit {
            /*display: inline-block;*/
            padding: 15px;
            border: 0;
            width: 170px;
            height: 26px;
            position: relative;
            border-radius: 5px 10px;
            -webkit-transition: all 200ms ease-in;
            -webkit-transform: scale(1);
            -ms-transition: all 200ms ease-in;
            -ms-transform: scale(1);
            -moz-transition: all 200ms ease-in;
            -moz-transform: scale(1);
            transition: all 200ms ease-in;
            transform: scale(1);
            color: #b5e6e3;
            font-weight: 300;
            font-size: 20px;
            font-family: 'Roboto';
            margin-top: 10px;
            margin-left: 10px;
            float: left;
        }

            .style_prevu_kit:hover {
                box-shadow: 0px 0px 150px #000000;
                z-index: 2;
                -webkit-transition: all 200ms ease-in;
                -webkit-transform: scale(1.5);
                -ms-transition: all 200ms ease-in;
                -ms-transform: scale(1.5);
                -moz-transition: all 200ms ease-in;
                -moz-transform: scale(1.5);
                transition: all 200ms ease-in;
                transform: scale(1);
            }

        .arrow {
            border: solid white;
            border-width: 0 3px 3px 0;
            display: inline-block;
            padding: 3px;
        }

        .down {
            transform: rotate(45deg);
            -webkit-transform: rotate(45deg);
        }

        #bdetailsarrow {
            display: none;
        }
    </style>
    <style>
        .show-grid [class^=col-] {
            padding-top: 10px;
            padding-bottom: 10px;
            border: 1px solid #ddd;
            border: 1px solid rgba(86,61,124,.2);
            list-style: none;
        }

        .glyphicon {
            margin-top: 5px;
            margin-bottom: 10px;
            font-size: 35px;
        }

        .inactive {
            color: #ccc;
            background-color: #fafafa;
        }

        .active, .inactive {
            width: 19.6% !important;
        }

        #for_I2 {
            z-index: 1;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid" id="for_other" style="display: none;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Edit Personal Details 
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White; margin-top: 1%;">

        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Edit Personal Details</b>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_personal_detail" class="panel-collapse collapse in">
                <table style="width: 100%;" cellpadding="10" cellspacing="20">

                    <tr>
                        <td class="pad-top">First Name<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_first_name" class="marg-btm" />
                        </td>
                        <td class="pad-top">Last Name<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_last_name" class="marg-btm" />
                        </td>
                    </tr>


                    <tr>

                        <td class="pad-top">Gender<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <select id="drp_gender" class="marg-btm">
                                <option value="">--Select Gender--</option>
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                                <option value="O">Other</option>
                            </select>
                        </td>

                        <td class="pad-top">Email ID<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_email" class="marg-btm" />
                        </td>

                    </tr>

                    <tr>

                        <td class="pad-top">Mobile Number<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_mobile_no" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="10" />
                        </td>
                        <td class="pad-top">Blood Group<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>

                            <select id="txt_blood_group" class="marg-btm">
                                <option value="">--Select Blood Group--</option>
                                <option value='A+'>A+</option>
                                <option value='A-'>A-</option>
                                <option value='B+'>B+</option>
                                <option value='B-'>B-</option>
                                <option value='AB+'>AB+</option>
                                <option value='AB-'>AB-</option>
                                <option value='O+'>O+</option>
                                <option value='O-'>O-</option>
                            </select>
                        </td>

                    </tr>

                    <tr>

                      
                        <td class="pad-top">Date of Birth<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>

                            <input type="text" id="txt_dob" class="marg-btm" placeholder="DD/MM/YYYY" />
                        </td>
                              <td class="pad-top">User Type<span class="" style="display: none; color: Red;">*</span>
                        </td>
                         <td>

                            <select id="txt_user_type" class="marg-btm">
                                <option value="">--Select User Type Group--</option>
                                <option value='I2'>I2</option>
                                <option value='PC'>PC</option>
                                <option value='FA'>FA</option>
                                <%--<option value='D'>Dean-</option>--%>
                            </select>
                        </td>
                    </tr>

                    <tr>

                        <td class="pad-top">Department<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td class="pad-top">Program
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog" />
                        </td>
                    </tr>
                    <tr>

                        <td class="pad-top">Program Level
                        </td>
                        <td>
                            <select class="chosen-select" id="drpproglevel" />
                        </td>
                       
                       

                    </tr>
                </table>
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

    <asp:HiddenField ID="hdn_icode" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="hdn_icode_ex" runat="server" ClientIDMode="Static" />

    <input type="hidden" runat="server" clientidmode="Static" id="hdn_user_type" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_user_id" value="" />


</asp:Content>

