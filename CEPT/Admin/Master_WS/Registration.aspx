<%@ Page Title="Registration - CEPT" Language="C#" MasterPageFile="~/MasterPage_registrarion.master"
    AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--  <script src="../../Js/registration.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
    
$(document).ready(function () {
     $('#Button1').on('click', function () {
     debugger;
        
       // register();
    });


       $('#btnsave').on('click', function () {

        debugger;
        var password = $('#txtpassword').val();
        if (password == "") {
            bootbox.alert('Please insert Password')
            $('#txtpassword').focus();
            return false;
        }

        var fullname = $('#txtfullname').val();
        if (fullname == "") {
            $('#txtfullname').focus();
            bootbox.alert('Please Insert Full Name')

            return false;
        }

        var gender = $('#drpgender').val();
        if (gender == "0") {
            $('#drpgender').focus();
            bootbox.alert('Please Select Gender')

            return false;
        }

        var birthdate = $('#txtdob').val();
        if (birthdate == "") {
            bootbox.alert('Please Select Birth Date')
            $('#txtdob').focus();
            return false;
        }

        var blood_grp = $('#txtbloodgrp').val();
        if (blood_grp == "0") {
            bootbox.alert('Please insert Blood Group')
            $('#txtbloodgrp').focus();
            return false;
        }



        var country = $('#drpcountry').val();
        if (country == "0") {
            bootbox.alert('Please Select Country')
            $('#drpcountry').focus();
            return false;
        }

        var place_of_birth = $('#txtpob').val();
        if (place_of_birth == "") {
            bootbox.alert('Please Insert place of birth')
            $('#txtpob').focus();
            return false;
        }

        var nationality = $('#txtnationality').val();
        if (nationality == "") {
            bootbox.alert('Please Insert Nationality')
            $('#txtnationality').focus();
            return false;
        }



        ///////////////////////// Contact Details //////////////////



        debugger;

        var local_address = $('#txtadd').val();
        if (local_address == "") {
            bootbox.alert('Please Insert Local Address')
            $('#txtadd').focus();
            return false;
        }

        var per_adress = $('#txtperadd').val();
        if (per_adress == "") {
            bootbox.alert('Please Insert Permanent Address')
            $('#txtperadd').focus();
            return false;
        }


        var mobile = $('#txtmobileno').val();
        if (mobile == "") {
            bootbox.alert('Please Insert Mobile Number')
            $('#txtmobileno').focus();
            return false;
        }


        var email = $('#txtemail').val();
        if (email == "") {
            bootbox.alert('Please Insert Email Address')
            $('#txtemail').focus();
            return false;
        }

        var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
        if (testEmail.test(email)) {

        }
        else {
            bootbox.alert("Please Enter Valid Email");
            $('#txtemail').focus();

            return false;
        }

        var alt_email = $('#txtaltemail').val();

        if (alt_email == '') {
            bootbox.alert('Please Insert Alternet Email')
            $('#txtaltemail').focus();
            return false;
        }


        if (alt_email != '') {
            var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
            if (testEmail.test(alt_email)) {

            }
            else {
                bootbox.alert("Please Enter Valid Alternet Email");
                $('#txtaltemail').focus();

                return false;
            }
        }

        var resident_no = $('#txtresidentno').val();

        if (resident_no == "") {
            bootbox.alert('Please Insert Resident No')
            $('#txtresidentno').focus();
            return false;
        }


        ////////////// Educational Details  ////////////////////////


        var acadamic_prog = $('#txtacadamic').val();
        if (acadamic_prog == "") {
            bootbox.alert('Please Insert Acadamic Program')
            $('#txtacadamic').focus();
            return false;
        }

        var year_of_enr = $('#txtyearofenro').val();
        if (year_of_enr == "") {
            bootbox.alert('Please Insert Year of Enrollment')
            $('#txtyearofenro').focus();
            return false;
        }

        var year_of_passing = $('#txtyop').val();
        if (year_of_passing == "") {
            bootbox.alert('Please Insert Year of Passing')
            $('#txtyop').focus();
            return false;
        }

        var name_of_uni = $('#txtnou').val();
        if (name_of_uni == "") {
            bootbox.alert('Please Insert Name of University')
            $('#txtnou').focus();
            return false;
        }

        var name_of_degree = $('#txtnod').val();
        if (acadamic_prog == "") {
            bootbox.alert('Please Insert Full Name of Degree / Diploma')
            $('#txtnod').focus();
            return false;
        }

        var prof_exp = $('#txtprof_exp').val();
        if (prof_exp == "") {
            bootbox.alert('Please Insert Professional Experiance')
            $('#txtprof_exp').focus();
            return false;
        }

        var add_of_university = $('#txtaddofuni').val();
        if (add_of_university == "") {
            bootbox.alert('Please Insert Address of University')
            $('#txtaddofuni').focus();
            return false;
        }

        var marks = $('#txtmarks').val();
        if (marks == "") {
            bootbox.alert('Please Insert Percentage/Aggregate Marks')
            $('#txtmarks').focus();
            return false;
        }


        var about_here = $('#txthere').val();
        if (about_here == "") {
            bootbox.alert('Please Insert How did you hear about this?')
            $('#txthere').focus();
            return false;
        }



        var data1 = "{'password':'" + password + "','fullname':'" + fullname + "','gender':'" + gender + "','birthdate':'" + birthdate + "','blood_grp':'" + blood_grp + "','country':'" + country + "','place_of_birth':'" + place_of_birth + "','nationality':'" + nationality + "','local_address':'" + local_address + "','per_adress':'" + per_adress + "','mobile':'" + mobile + "','email':'" + email + "','alt_email':'" + alt_email + "','resident_no':'" + resident_no + "','acadamic_prog':'" + acadamic_prog + "','year_of_enr':'" + year_of_enr + "','year_of_passing' :'" + year_of_passing + "' ,'name_of_uni':'" + name_of_uni + "','name_of_degree':'" + name_of_degree + "','prof_exp':'" + prof_exp + "','add_of_university':'" + add_of_university + "','marks':'" + marks + "','about_here':'" + about_here + "',}";

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "WebService.asmx/Registration",
            data: data1,
            dataType: "json",
            success: function (data) {
                // bind_grid();


                if (data.d == "Data Registered Successfully") {
                    bootbox.confirm("Are you sure for register?", function (result1) {

                        if (result1 == true) {
                            $('#txtpassword').val('');
                            $('#txtfullname').val('');
                            $('#drpgender').val('0');
                            $('#txtdob').val('');
                            $('#txtbloodgrp').val('0');
                            $('#drpcountry').val('0');
                            $('#txtpob').val('');
                            $('#txtnationality').val('');
                            $('#txtadd').val('');
                            $('#txtperadd').val('');
                            $('#txtmobileno').val('');
                            $('#txtemail').val('');
                            $('#txtaltemail').val('');
                            $('#txtresidentno').val('');
                            $('#txtacadamic').val('');
                            $('#txtyearofenro').val('');
                            $('#txtyop').val('');
                            $('#txtnou').val('');
                            $('#txtnod').val('');
                            $('#txtprof_exp').val('');
                            $('#txtaddofuni').val('');
                            $('#txtmarks').val('');
                            $('#txthere').val('');

                            register();
                        }
                    });
                }
                else {
                    alert(dta.d);
                }





                return false;

            },
            error: function (data) {
                alert(data.d);
                return false;
            }
        });
        return false;

    });






});

        function binddropdown() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "WebService.asmx/Getuserdropdown",
                data: "{}",
                dataType: "json",
                success: function (data) {




                    company = JSON.parse(data.d)


                    $("#drpselect,#drpcountry").empty().append($("<option></option>").val("").html("-- Please Select FIM --"));
                    for (var i = 0; i < company.length; i++) {

                        $("#drpselect,#drpcountry").append($("<option></option>").val(company[i]["drpselect"]).html(company[i]["drpselect"]));
                        $("#drpselect,#drpcountry").append($("<option></option>").val(company[i]["drpcountry"]).html(company[i]["drpcountry"]));
                    }

                },
                error: function (result) {
                    alert("Error");
                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="tabbable">
        <ul class="nav nav-tabs">
            <div align="center">
                <table cellpadding="5px" cellspacing="0px">
                    <tr>
                        <td>
                        </td>
                        <td>
                        </td>
                        <td>
                            <label style="color: Red">
                                All fields are Mandatory</label>
                        </td>
                        <td>
                            <label id="lbl_elective">
                            </label>
                        </td>
                    </tr>
                </table>
            </div>
            <li class="active"><a href="#InsertEditRace" data-toggle="tab"><b>Login Detail</b></a>
                </b> </li>
            <%--<li><a href="#ListRace" data-toggle="tab">Races List</a></li>--%>
        </ul>
        <div class="tab-content">
            <div id="Div1" class="tab-pane active">
                <%--<div class="span5">
                    <div class="control-group">
                        <label class="control-label" for="txtloging">
                            User Name :
                        </label>
                        <div class="controls">
                            <input type="text" id="txtloging" placeholder="UserName" />
                        </div>
                    </div>
                </div>--%>
                <div class="span5">
                    <div class="control-group">
                        <label class="control-label" for="txtpassword">
                            Password :</label>
                        <div class="controls">
                            <input type="password" id="txtpassword" placeholder="password" />
                            <div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div>
        <div class="tabbable">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#InsertEditRace" data-toggle="tab"><b>Personal Detail</b></a>
                    </b> </li>
            </ul>
            <div class="tab-content">
                <div id="Div2" class="tab-pane active">
                    <div class="span4">
                        <div class="control-group">
                            <div class="control-group">
                                <label class="control-label" for="txtfullname">
                                    Full Name :
                                </label>
                                <div class="controls">
                                    <input type="text" id="txtfullname" placeholder="Full Name" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtfullname">
                                    Blood Group :
                                </label>
                                <div class="controls">
                                    <select id="txtbloodgrp">
                                        <option value="0">Select Blood Group</option>
                                        <option value="1">O Positive</option>
                                        <option value="2">O Negative</option>
                                        <option value="3">O Negative</option>
                                        <option value="4">A Positive</option>
                                        <option value="5">A Negative</option>
                                        <option value="6">B Positive</option>
                                        <option value="7">B Negative</option>
                                        <option value="8">AB Positive</option>
                                        <option value="9">AB Negative</option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtmobile">
                                    Nationality:
                                </label>
                                <div class="controls">
                                    <div class="controls">
                                        <input type="text" id="txtnationality" placeholder="Nationality" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="span4">
                        <div class="control-group">
                            <label class="control-label" for="txtdob">
                                Gender :
                            </label>
                            <select id="drpgender">
                                <option value="0">Select Gender</option>
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                            </select>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="drpcountry">
                                Country :
                            </label>
                            <div class="controls">
                                <select id="drpcountry">
                                    <option value="0">Select Country </option>
                                    <option value="1">India</option>
                                    <option value="2">Any Other</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="txtdob">
                            Date Of Birth :
                        </label>
                        <div class="controls">
                            <input type="text" id="txtdob" placeholder="Date Of Birth" />
                        </div>
                    </div>
                    <div class="control-group">
                        <label class="control-label" for="txtfullname">
                            Place of Birth :
                        </label>
                        <div class="controls">
                            <input type="text" id="txtpob" placeholder="Place Of Birth" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div>
        <div class="tabbable">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#InsertEditRace" data-toggle="tab"><b>Contact Detail</b></a>
                    </b> </li>
                <%--<li><a href="#ListRace" data-toggle="tab">Races List</a></li>--%>
            </ul>
            <div class="tab-content">
                <div id="Div3" class="tab-pane active">
                    <div class="span4">
                        <div class="control-group">
                            <div class="control-group">
                                <label class="control-label" for="txtaddress">
                                    Local Address:
                                </label>
                                <div>
                                    <textarea id="txtadd" rows="3" cols="50" name="address"></textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtemail">
                                    Email Id:
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <span class="add-on">@</span>
                                        <input type="text" id="txtemail" placeholder="Email" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="span4">
                        <label class="control-label" for="txtaddress">
                            Permanent Address:
                        </label>
                        <textarea id="txtperadd" rows="3" cols="50" name="address"></textarea>
                        <div class="control-group">
                            <label class="control-label" for="txtemail">
                                Alternet Email Id:
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <span class="add-on">@</span>
                                    <input type="text" id="txtaltemail" placeholder="Alternet Email" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="span3">
                        <div class="control-group">
                            <label class="control-label" for="txtmobile">
                                Mobile No:
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <span class="add-on icon-mobile-phone"></span>
                                    <input type="text" id="txtmobileno" placeholder="MobileNo" />
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="txtphone">
                                Residence (Landline) No:
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <span class="add-on icon-mobile-phone"></span>
                                    <input type="text" id="txtresidentno" placeholder="Residence No" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div>
        <div class="tabbable">
            <ul class="nav nav-tabs">
                <li class="active"><a href="#InsertEditRace" data-toggle="tab"><b>Educational Detail</b></a>
                    </b> </li>
                <%--<li><a href="#ListRace" data-toggle="tab">Races List</a></li>--%>
            </ul>
            <div class="tab-content">
                <div id="Div4" class="tab-pane active">
                    <div class="span4">
                        <div class="control-group">
                            <div class="control-group">
                                <label class="control-label" for="txtaddress">
                                    Academic Program Enrolled Currently:
                                </label>
                                <div class="controls">
                                    <input type="text" id="txtacadamic" placeholder="Academic Program" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtemail">
                                    Name of the University / Institution:
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <input type="text" id="txtnou" placeholder="Name of University" />
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtaddress">
                                    Address of University / Institution:
                                </label>
                                <div class="controls">
                                    <textarea id="txtaddofuni" rows="3" cols="50" name="address"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="span4">
                        <%--<div class="control-group">
                           <%-- <label class="control-label" for="txtmidname">
                                Middle Name :
                            </label>
                            <div class="controls">
                                <input type="text" id="txtmidname" placeholder="Login Name" />
                            </div>--%>
                        <div class="control-group">
                            <label class="control-label" for="txtemail">
                                Year of Enrollment:
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <input type="text" id="txtyearofenro" placeholder="Enrollment" />
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="txtemail">
                                FULL NAME OF DEGREE / DIPLOMA:
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <input type="text" id="txtnod" placeholder="Name of Degree/Diploma" />
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="txtemail">
                                Percentage/Aggregate Marks:
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <input type="text" id="txtmarks" placeholder="Marks" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="span3">
                        <div class="control-group">
                            <label class="control-label" for="txtmobile">
                                Year of Passing:
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <input type="text" id="txtyop" placeholder="Year of Passing" />
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="txtphone">
                                Professional Experience:
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <input type="text" id="txtprof_exp" placeholder="Experience" />
                                </div>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="txtphone">
                                How did you hear about this?
                            </label>
                            <div class="controls">
                                <div class="input-prepend">
                                    <textarea id="txthere" rows="3" cols="50" name="address"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div class="tabbable">
            <div class="row-fluid">
                <div class="span11" style="margin-top: 10px">
                    <table align="center" border="0" cellpadding="3" cellspacing="5">
                        <tr>
                            <td>
                                <button id="btnsave" style="display: block;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Register
                                </button>
                                <button id="Button1" style="display: block;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Register
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
