<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CEPT - Tutors Registration</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css" rel="stylesheet" type="text/css" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery.bootstrapvalidator/0.5.0/css/bootstrapValidator.min.css" rel="stylesheet" type="text/css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-validator/0.4.5/js/bootstrapvalidator.min.js"></script>
    <style>
        #success_message {
            display: none;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('#contact_form').bootstrapValidator({
                feedbackIcons: {
                    valid: 'glyphicon glyphicon-ok',
                    invalid: 'glyphicon glyphicon-remove',
                    validating: 'glyphicon glyphicon-refresh'
                },
                fields: {
                    first_name: {
                        validators: {
                            stringLength: {
                                min: 2,
                            },
                            notEmpty: {
                                message: 'Please enter your First Name'
                            }
                        }
                    },
                    last_name: {
                        validators: {
                            stringLength: {
                                min: 2,
                            },
                            notEmpty: {
                                message: 'Please enter your Last Name'
                            }
                        }
                    },
                    //user_name: {
                    //    validators: {
                    //        stringLength: {
                    //            min: 8,
                    //        },
                    //        notEmpty: {
                    //            message: 'Please enter your Username'
                    //        }
                    //    }
                    //},
                    user_password: {
                        validators: {
                            stringLength: {
                                min: 8,
                            },
                            notEmpty: {
                                message: 'Please enter your Password'
                            }
                        }
                    },
                    confirm_password: {
                        validators: {
                            stringLength: {
                                min: 8,
                            },
                            notEmpty: {
                                message: 'Please confirm your Password'
                            }
                        }
                    },
                    email: {
                        validators: {
                            notEmpty: {
                                message: 'Please enter your Email Address'
                            },
                            emailAddress: {
                                message: 'Please enter a valid Email Address'
                            }
                        }
                    },
                    contact_no: {
                        validators: {
                            stringLength: {
                                min: 10,
                            },
                            notEmpty: {
                                message: 'Please enter your Mobile No.'
                            }
                        },
                        department: {
                            validators: {
                                notEmpty: {
                                    message: 'Please select your Department/Office'
                                }
                            }
                        },
                    }
                }
                ,
                submitHandler: function (validator, form, submitButton) {
                    if ($("#first_name").val() == "") {
                        $("#reg").prop({ disabled: false });
                        alert('Please Enter First Name');
                        return false;
                    }
                    if ($("#last_name").val() == "") {
                        $("#reg").prop({ disabled: false });
                        alert('Please Enter Last Name');
                        return false;
                    }
                    //if ($("#user_name").val() == "") {
                    //    $("#reg").prop({ disabled: false });
                    //    alert('Please Enter Username');
                    //    return false;
                    //}
                    if ($("#mail").val() == "") {
                        $("#reg").prop({ disabled: false });
                        alert('Please Enter E-Mail');
                        return false;
                    }
                    if ($("#password").val() == "") {
                        $("#reg").prop({ disabled: false });
                        alert('Please Enter Password');
                        return false;
                    }
                    if ($("#confirm_password").val() == "") {
                        $("#reg").prop({ disabled: false });
                        alert('Please Enter Confirm Password');
                        return false;
                    }
                    if ($("#mobile_no").val() == "") {
                        $("#reg").prop({ disabled: false });
                        alert('Please Enter Mobile No.');
                        return false;
                    }
                    if ($("#password").val() != $("#confirm_password").val()) {
                        $("#reg").prop({ disabled: false });
                        alert("Password and Confirm Password should be same.");
                        return false;
                    } 
                    if ($("#otp").val() == "") {
                        //$("#reg").prop({ disabled: false });
                        //alert("Please Enter OTP.");
                        //return false;
                    }

                    var data = {
                        'first_name': $("#first_name").val(), 'last_name': $("#last_name").val(), 'mail': $("#mail").val()
                        , 'password': $("#password").val(), 'mobile_no': $("#mobile_no").val(), 'otp': $("#otp").val()
                    };

                    //'user_name': $("#user_name").val(),

                    $("#reg").prop({ disabled: false });

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/create_user_account",
                        data: "{user_data:'" + JSON.stringify(data) + "'}",
                        dataType: "json",
                        success: function (data) {
                            var dataa = JSON.parse(data.d);
                            if (dataa.status == "0") {
                                alert(dataa.message);
                                var url = "Login.aspx";
                                window.open(url, '_self');
                            } else {
                                alert(dataa.message);
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }
            })
                .on('success.form.bv', function (e) {
                    $('#success_message').slideDown({ opacity: "show" }, "slow") // Do something ...
                    //$('#contact_form').data('bootstrapValidator').resetForm();
                    // Prevent form submission
                    e.preventDefault();
                    // Get the form instance
                    var $form = $(e.target);
                    // Get the BootstrapValidator instance
                    var bv = $form.data('bootstrapValidator');
                    //Use Ajax to submit form data
                    $.post($form.attr('action'), $form.serialize(), function (result) {
                        console.log(result);
                    }, 'json');
                });
        });
    </script>
</head>
<body>
    <img src="image/capture.png" height="50px" style="margin-left: 8%; margin-top: 1%;" /><span style="font-size: small"> </span>
    <div class="container">
        <form class="well form-horizontal" onsubmit="return false" id="contact_form" style="margin-top: 1%;">
            <fieldset>

                <!-- Form Name -->
                <legend>
                    <center><h3><b>Tutors Registration/Sign Up</b></h3></center>
					<center><h6><b>Note:</b> Existing tutors are not required to register again, Please login using your connect credentails.</h6></center>
				</legend>

                <!-- Text input-->

                <div class="form-group">
                    <label class="col-md-4 control-label">First Name</label>
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input name="first_name" placeholder="First Name" class="form-control" type="text" id="first_name">
                        </div>
                    </div>
                </div>

                <!-- Text input-->

                <div class="form-group">
                    <label class="col-md-4 control-label">Last Name</label>
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input name="last_name" placeholder="Last Name" class="form-control" type="text" id="last_name">
                        </div>
                    </div>
                </div>

                <%--<div class="form-group">
                    <label class="col-md-4 control-label">Department / Office</label>
                    <div class="col-md-4 selectContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-list"></i></span>
                            <select name="department" class="form-control selectpicker">
                                <option value="">Select your Department/Office</option>
                                <option>Department of Engineering</option>
                                <option>Department of Agriculture</option>
                                <option>Accounting Office</option>
                                <option>Tresurer's Office</option>
                                <option>MPDC</option>
                                <option>MCTC</option>
                                <option>MCR</option>
                                <option>Mayor's Office</option>
                                <option>Tourism Office</option>
                            </select>
                        </div>
                    </div>
                </div>--%>

                <!-- Text input-->

                <%--<div class="form-group">
                    <label class="col-md-4 control-label">Username</label>
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input name="user_name" placeholder="Username" class="form-control" type="text" id="user_name">
                        </div>
                    </div>
                </div>--%>

                <!-- Text input-->
                <div class="form-group">
                    <label class="col-md-4 control-label">E-Mail</label>
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-envelope"></i></span>
                            <input name="email" placeholder="E-Mail Address" class="form-control" type="text" id="mail">
                        </div>
                    </div>
                </div>

                <!-- Text input-->

                <div class="form-group">
                    <label class="col-md-4 control-label">Password</label>
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input name="user_password" placeholder="Password" class="form-control" type="password" id="password">
                             
                        </div>
                        <span style="font-size:12px;color:blue;">(Password should be 8 characters in length.)</span>
                    </div>
                </div>

                <!-- Text input-->

                <div class="form-group">
                    <label class="col-md-4 control-label">Confirm Password</label>
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                            <input name="confirm_password" placeholder="Confirm Password" class="form-control" type="password" id="confirm_password">
                        </div>
                    </div>
                </div>

                <!-- Text input-->

                <div class="form-group">
                    <label class="col-md-4 control-label">Mobile No.</label>
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                            <input name="contact_no" placeholder="10 Digit number" class="form-control" type="text" id="mobile_no">
                        </div>
                    </div>
                    <div class="form-group" style="display:none;">
                        <div class="col-md-4 inputGroupContainer">
                            <div class="input-group">
                                <input type="button" id="btn_send_opt" class="btn btn-success" value="Send OTP" onclick="return sendotpdata()" style="float: center;">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Text input-->

                <div class="form-group" style="display:none;">
                    <label class="col-md-4 control-label">OTP</label>
                    <div class="col-md-4 inputGroupContainer">
                        <div class="input-group">
                            <span class="input-group-addon"><i class="glyphicon glyphicon-earphone"></i></span>
                            <input name="otp" placeholder="Received OTP" class="form-control" type="text" id="otp">
                        </div>
                    </div>
                </div>

                <div class="form-group col-md-4 cls_otp" style="width: 20%; margin-left: 0px; display: block;">
                </div>

                <!-- Select Basic -->

                <!-- Success message -->
                <div class="alert alert-success" role="alert" id="success_message">Success <i class="glyphicon glyphicon-thumbs-up"></i>Success!.</div>

                <!-- Button -->
                <div class="form-group">
                    <label class="col-md-2 control-label"></label>
                    <div class="col-md-3">
                        <br>
                        <button type="submit" class="btn btn-warning" style="margin-left: 20%;" id="reg">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp;REGISTER <span class="glyphicon glyphicon-send"></span>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</button>
                    </div>

                </div>
                <div class="row" style="margin-left:10px;">
                    <span style="color: red;">*</span>Check your inbox / Spam for the confirmation email.                        
                </div>

            </fieldset>
        </form>
    </div>
</body>
<script>
    function sendotpdata() {
        if ($('#mobile_no').val() == "") {
            alert("Please Enter Mobile Number");
            return false;
        }
        if ($('#mobile_no').val() == "") {
            alert("Please Enter Mobile Number");
            return false;
        }
        GenerateOTP();
    }

    function GenerateOTP() {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/GenerateOTP",
            data: "{ mobile_no:'" + $('#mobile_no').val() + "'}",
            dataType: "json",
            async: false,
            success: function (data) {
                if (data.d != "") {
                    var otp_generated = JSON.parse(data.d)
                    alert(otp_generated.message);
                } else {

                }
            },
            error: function (result) {
                alert(result);
            }
        });
    }
</script>
</html>
