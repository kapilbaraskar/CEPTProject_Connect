<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration.aspx.cs"
    Inherits="Alumini_Alumini_Registration" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <title>Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Responsive HTML template for Your company">
    <meta name="author" content="Oskar Żabik (oskar.zabik@gmail.com)">
    <!-- Le styles -->
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/bootstrap-responsive.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/typica-login.css" rel="stylesheet" type="text/css" />
    <link href="../DesignJS/Spinner/ladda-themeless.min.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/Validation.css" rel="stylesheet" />
    <link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css" />
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Le favicon -->
    <link rel="shortcut icon" href="../favicon.ico">
    <style type="text/css">
        
    </style>
</head>
<body>
    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="container">
                <h2>
                    <span class="hidden-phone" style="">
                        <img src="../image/capture.png" height="500px" />
                        <span style="font-size: small"></span></span>
                </h2>
            </div>
        </div>
    </div>
    <form id="frm_sid_registration" style="padding-top: 10px;" runat="server">
    <div class="container" id="div_check_alumini" style="margin-bottom: 0px;">
        <div style="text-align: center; font-size: 30px;">
            <b>CEPT Alumni Registry</b></div>
        <div id="signupbox" style="margin-top: 0px" class="mainbox col-md-8 col-md-offset-2 col-sm-10 col-sm-offset-1">
            <div class="panel panel-info" style="margin-top: 20px;">
                <div class="panel-heading">
                    <div class="panel-title">
                        Register</div>
                </div>
                <div class="panel-body">
                    <asp:ScriptManager ID="ScriptManager11" runat="server">
                        <Services>
                            <asp:ServiceReference Path="~/WebService.asmx" />
                        </Services>
                    </asp:ScriptManager>
                    <div class="row">
                        <%--<div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Year of Enrollment <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <select id="drpyear" name="drpyear">
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Program Name <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <select id="drpprog" name="drpprog">
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Student Name <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="text" id="txt_name" name="txt_name" class="form-control" style="height: 30px;
                                    width: 100%;" />
                            </div>
                        </div>--%>
                        <div class="row">
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3 col-sm-offset-1">
                                    Student Code <span class="required">*</span><br />
                                    (Enter last four digit of Student Code. UA <b>0111</b>)
                                </div>
                                <div class="form-group col-sm-5">
                                    <input type="text" maxlength="4" id="txt_student_code" name="txt_student_code" class="form-control"
                                        style="height: 30px; width: 100%;" />
                                </div>
                            </div>
                        </div>
                        <%--<div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Email Id <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="text" id="txt_email" name="txt_email" class="form-control" style="height: 30px;
                                    width: 100%;" />
                            </div>
                        </div>--%>
                        <div class="row" style="margin-top: 20px;">
                            <div class="form-group col-sm-12">
                                <div class="form-group col-sm-3 col-sm-offset-1">
                                    Date of birth<span class="required">*</span>
                                    <br />
                                    (DD/MM/YYYY)
                                </div>
                                <div class="form-group col-sm-5">
                                    <input type="text" id="txt_dob" name="txt_dob" class="form-control" style="height: 30px;
                                        width: 100%;" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group col-sm-12" style="margin-top: 10px;">
                            <div align="center">
                                <button type="button" id="btnSave" onclick="return Register();" class="btn btn-success">
                                    Register
                                </button>
                            </div>
                            <%--  <div align="center" style="color:Red;margin-top:5px;">
                                    Clicking on the register button will redirect you to a payment gateway
                                </div>--%>
                        </div>
                    </div>
                    <div class="raw">
                        <br />
                        1: Enter the last 4 digits of your student code number (xxxx), and your date of
                        birth (DD/MM/YYYY).
                        <br />
                        2: If your details match our records, an account creation page will open where you
                        may create a login name (your email address) and a password. Optionally, you may
                        also select Google login.
                        <br />
                        3: You will be automatically redirected to the registry page with your details.
                        <br />
                        4: Enter or revise your current details in the form.
                        <br />
                        5. Update your communication preferences if needed.
                        <br />
                        ​If you wish to invite your friends to join the Alumni Registry, you can enter their
                        email addresses here, separated by commas.​
                        <br />
                        In case your details do not match with our records in step 1, a verification form
                        will open instead. Fill in the required information, so that it can be checked manually
                        against our records. Your account will be activated as soon as your information
                        is manually verified.
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container" id="div_save_credential" style="margin-bottom: 0px; display: none;">
        <div id="Div1" style="margin-top: 0px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
            <div class="panel panel-info" style="margin-top: 20px;">
                <div class="panel-heading">
                    <div class="panel-title">
                        create your alumni account</div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Email <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="text" id="txt_email" name="txt_email" class="form-control" style="height: 30px;
                                    width: 100%;" />
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Create Password <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="password" id="txt_password" name="txt_password" class="form-control"
                                    style="height: 30px; width: 100%;" />
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Re-type Password <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="password" id="txt_retype_password" name="txt_retype_password" class="form-control"
                                    style="height: 30px; width: 100%;" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group col-sm-12" style="margin-top: 10px;">
                            <div align="center">
                                <button type="button" id="btn_save_credential_detail" onclick="return save_credential();"
                                    class="btn btn-success">
                                    Save Credentials
                                </button>
                            </div>
                            <%--  <div align="center" style="color:Red;margin-top:5px;">
                                    Clicking on the register button will redirect you to a payment gateway
                                </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container" id="div_save_alumini" style="margin-bottom: 0px; display: none;">
        <div id="Div2" style="margin-top: 0px" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
            <div class="panel panel-info" style="margin-top: 20px;">
                <div class="panel-heading">
                    <div class="panel-title">
                        Fill Details
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Year of Enrollment <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <select id="drpyear" name="drpyear">
                                </select>
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Program Name <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <select id="drpprog" name="drpprog">
                                </select>
                            </div>
                        </div>
                        <div id="tr_txt_other_prog" style="display: none;" class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="text" id="txt_other_prog" />
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Student Name <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="text" id="txt_name" name="txt_name" class="form-control" style="height: 30px;
                                    width: 100%;" />
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Student Code<span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="text" id="txt_student_code_new" name="txt_student_code_new" class="form-control"
                                    style="height: 30px; width: 100%;" />
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Email <span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="text" id="txt_email_new" name="txt_email_new" class="form-control" style="height: 30px;
                                    width: 100%;" />
                            </div>
                        </div>
                        <div class="form-group col-sm-12">
                            <div class="form-group col-sm-3">
                                Date of birth<span class="required">*</span>
                            </div>
                            <div class="form-group col-sm-7">
                                <input type="text" id="txt_dob_new" name="txt_dob_new" class="form-control" style="height: 30px;
                                    width: 100%;" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group col-sm-12" style="margin-top: 10px;">
                            <div align="center">
                                <button type="button" id="Button1" onclick="return save_alumini_details();" class="btn btn-success">
                                    Send for verification
                                </button>
                            </div>
                            <%--  <div align="center" style="color:Red;margin-top:5px;">
                                    Clicking on the register button will redirect you to a payment gateway
                                </div>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="hdn_user_id" />
    </form>
    <%--<footer class="white navbar-fixed-bottom">
      
    </footer>--%>
    <script src="../Scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <script src="../DesignJS/bootstrap.min.js" type="text/javascript"></script>
    <%--<script src="../DesignJS/backstretch.min.js" type="text/javascript"></script>--%>
    <%--<script src="../DesignJS/typica-login.js" type="text/javascript"></script>--%>
    <script src="../Scripts/jquery-ui.js" type="text/javascript"></script>
    <script src="../DesignJS/Spinner/spin.min.js" type="text/javascript"></script>
    <script src="../DesignJS/Spinner/ladda.min.js" type="text/javascript"></script>
    <script src="../DesignJS/bootbox.min.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        $(document).ready(function () {

            //            $('#drp_profession').on('change', function () {
            //                switch ($('#drp_profession').val()) {
            //                    case "CS":
            //                        $('#rdo_cept')[0].checked = true;
            //                        break;
            //                    case "S":
            //                        $('#rdo_student')[0].checked = true;
            //                        break;
            //                    case "SA":
            //                        $('#rdo_sidAlumni')[0].checked = true;
            //                        break;
            //                    case "P":
            //                        $('#rdo_professional')[0].checked = true;
            //                        break;
            //                    case "":
            //                        $('#rdo_cept')[0].checked = false;
            //                        $('#rdo_student')[0].checked = false;
            //                        $('#rdo_sidAlumni')[0].checked = false;
            //                        $('#rdo_professional')[0].checked = false;
            //                        break;
            //                }
            //            });

                  $('#drpprog').on('change', function () {
                if ($('#drpprog').val() == 'O') {
                    $('#tr_txt_other_prog').css('display', '');
                }
                else {
                    $('#tr_txt_other_prog').css('display', 'none');
                }
            });

            $('#txt_dob,#txt_dob_new').datepicker({
                dateFormat: "dd/mm/yy"
            });

            bindyeardata();
            bindprogdata();
            $("#frm_sid_registration").validate({
                rules: {
                    drpyear:
                {
                    required: true
                },

                    drpprog:
                {
                    required: drpprog
                },
                    txt_name: {
                        required: true
                    },

                    txt_email_new: {
                        required: true,
                        email: true
                    },
                    txt_student_code_new:{
                    required: true
                    },
                      txt_dob_new:
                    {
                    required: true
                    },
                    txt_student_code:{
                        required: true,
                        minlength: 4,
                        maxlength: 4
                    },
                    txt_dob:
                    {
                    required: true
                    },
                    txt_password: {
                    required: true
                    },
                    txt_retype_password: {
                    required: true,
           
                    equalTo: "#txt_password"
                    },
                    txt_email: {
                    required: true,
                     email: true
                    }
                    },
                    messages: {
                    drpyear:
                {
                    required: "Please Select Year of enrollment"
                },
                    drpprog:
                {
                    required: "Please Select Program Name"
                },
                    txt_name: {
                        required: "Please Enter Your Name"
                    },

                    txt_email_new: {
                        required: "Please Enter Your EmailID",
                        email: "Enter valid Email"
                    },
                    txt_student_code_new:{
                        required: "Please Enter Student Code"
                    },
                        txt_dob_new:
                    {
                    required: "Please Select Date of birth"
                    },
                     txt_student_code: {
                        required: "Please Enter Student Code",
                        minlength: "Enter Last 4 Digit of Student code",
                        maxlength: "Enter Last 4 Digit of Student code"
                    },
                    txt_dob:
                    {
                      required: "Please Select Date of birth",
                    },
                     txt_password: {
                    required: "Please enter password",
                    },
                    txt_retype_password: {
                    required: "Please enter re type password",
           
                    equalTo: "Password is not match"
                    },
                     txt_email: {
                    required: "Please enter email",
                      email: "Enter valid Email"
                    }
                }
            });
        });

        function bindyeardata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_alumini_year_data",

                data: "{}",
                dataType: "json",
                success: function (data) {


                    if (data.d != "") {


                        var year_data = JSON.parse(data.d)

                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {


                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear').chosen();

                      
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindprogdata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/Get_alumini_prog_data",

                data: "{}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpprog').append($("<option></option>").val(year_data[i]["prog_level_code"]).html(year_data[i]["prog_level_name"]));
                        }

                        $('#drpprog').chosen();

                     
                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function IsNumeric(e) {
            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 37 || keyCode == 38 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {
                return true;
            }
            else {
                return false;
            }
        }

        var reg_res;
        var err;
        var uc;
        var method;
        function Register() {
            var result = $('#frm_sid_registration').valid();
            if (result) {
                debugger;
                //var register_data = { year_code: $('#drpyear').val(), prog_level_code: $('#drpprog').val(), name: $('#txt_name').val(), user_id: $('#txt_student_code').val(), email: $('#txt_email').val() };

                var register_data = {user_id: $('#txt_student_code').val(), dob :$('#txt_dob').val()};

                WebService.alumini_registration(JSON.stringify(register_data), OnCallComplete, OnCallError);
            }
        }

        function OnCallComplete(res, methodName) {
            debugger;
           
             var data = JSON.parse(res);
           
             if (data["status"] == "true") 
             {

                bootbox.alert(data["message"], function () {
                                

                  $('#div_check_alumini').css('display','none')

                $('#hdn_user_id').val(data["user_id"]);
                if (data["verification_status"] == "V")
                {
                    $('#div_save_credential').css('display','block');
                }
                else if (data["verification_status"] == "NV") 
                {
                    $('#div_save_alumini').css('display','block');
                }


                });
             }
             else
             {
                if (data["verification_status"] == "NV") 
                {
                   $('#div_check_alumini').css('display','none')
                 bootbox.alert(data["message"], function () {
                    $('#div_save_alumini').css('display','block');
                      });
                      return false;
                }
                else{
                bootbox.alert(data["message"]);
                }
             }  
        }

        function OnCallError(error, userContext, methodName) {
            err = error;
            uc = userContext;
            method = methodName;
            if (error !== null) {
                alert(error.get_message());
                //Ladda.stopAll();
                return false;
            }
        }

         function save_credential() {
            var result = $('#frm_sid_registration').valid();
            if (result) {
                debugger;
                //var register_data = { year_code: $('#drpyear').val(), prog_level_code: $('#drpprog').val(), name: $('#txt_name').val(), user_id: $('#txt_student_code').val(), email: $('#txt_email').val() };

//                if ($('#txt_password').val() != $('#txt_retype_password').val()) {
//                    alert('');
//                }

                var register_data = {email : $('#txt_email').val(), password :$('#txt_password').val(), user_id : $('#hdn_user_id').val()};

                WebService.save_alumini_credential(JSON.stringify(register_data), OnCallComplete_credential, OnCallError_credential);
            }
        }

         function OnCallComplete_credential(res, methodName) {
            debugger;

            var data = JSON.parse(res);

//            if (res == "True" || res == "true") {
//                window.location.href = "../Login.aspx";
//            }
//            else if(res == "false")
//            {
//                bootbox.alert("Problem in update credential details");
//                return false;
//            }
//            else{
//                 bootbox.alert(res);
//            }

            if (data["status"] == "True") {
                window.location.href = "alumni_personal_detail.aspx";
                return false;
            }
            else
            {
                bootbox.alert(data["message"]);
            }

        }

        function OnCallError_credential(error, userContext, methodName) {
            err = error;
            uc = userContext;
            method = methodName;
            if (error !== null) {
                alert(error.get_message());
                //Ladda.stopAll();
                return false;
            }
        }

         function save_alumini_details() {
            var result = $('#frm_sid_registration').valid();
            if (result) {
                debugger;
                //var register_data = { year_code: $('#drpyear').val(), prog_level_code: $('#drpprog').val(), name: $('#txt_name').val(), user_id: $('#txt_student_code').val(), email: $('#txt_email').val() };

//                if ($('#txt_password').val() != $('#txt_retype_password').val()) {
//                    alert('');
//                }

                 if ($('#drpprog').val() == 'O') 
                 {
                    if ($('#txt_other_prog').val() == '') {
                        bootbox.alert("Please Enter Other Program Name");
                        return;
                    }
                }
                else
                {
                    $('#txt_other_prog').val('');
                }
              //  obj_data.other_prog = $('#txt_other_prog').val();
            
                 var register_data = { year_code: $('#drpyear').val(), prog_level_code: $('#drpprog').val(), name: $('#txt_name').val(), user_id: $('#txt_student_code_new').val(), email: $('#txt_email_new').val() , dob :$('#txt_dob_new').val(),other_prog: $('#txt_other_prog').val(),is_registr:"AL"};

                WebService.save_alumini_details(JSON.stringify(register_data), OnCallComplete_save_alumini, OnCallError_save_alumini);
            }
        }
        
         function OnCallComplete_save_alumini(res, methodName) {
            debugger;
           
             bootbox.alert(res, function () {

                   window.location.reload();             
                                });
           
        }

      function OnCallError_save_alumini(error, userContext, methodName) {
            err = error;
            uc = userContext;
            method = methodName;
            if (error !== null) {
                alert(error.get_message());
                //Ladda.stopAll();
                return false;
            }
        }

    </script>
</body>
</html>
