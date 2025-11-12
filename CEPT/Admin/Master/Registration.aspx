<%@ Page Title="Registration - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="Registration.aspx.cs" Inherits="Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtstartdate').datepicker();
            $('#txtenddate').datepicker();
            $('#txtdob').datepicker();

            //validation  
            $('#btnSave').on('click', function () {
                var loging = $('#txtloging').val();
                if (loging == "") {
                    bootbox.alert('Please Insert User Name')
                    $('#txtloging').focus();
                    return false;
                }
                var password = $('#txtpassword').val();
                if (password == "") {
                    bootbox.alert('Please insert Password')
                    $('#txtpassword').focus();
                    return false;
                }
                var firstname = $('#txtfirstname').val();
                if (firstname == "") {
                    bootbox.alert('please insert First Name')
                    $('#txtfirstname').focus();
                    return false;
                }
                var middlename = $('#txtmidname').val();
                if (middlename == "") {
                    bootbox.alert('please insert Middle Name')
                    $('#txtmidname').focus();
                    return false;
                }
                var lastname = $('#txtlstname').val();
                if (lastname == "") {
                    bootbox.alert('Please insert last name')
                    $('#txtlstname').focus();
                    return false;
                }
                var fullname = $('#txtfullname').val();
                if (fullname == "") {
                    bootbox.alert('Please Insert Full Name')
                    $('#txtfullname').focus();
                    return false;
                }
                var email = $('#txtemail').val();
                if (email == "") {
                    bootbox.alert('Please Insert Email Address')
                    $('#txtemail').focus();
                    return false;
                }
                var startdate = $('#txtstartdate').val();
                if (startdate == "") {
                    bootbox.alert('Please Select Start Date')
                    $('#txtstartdate').focus();
                    return false;
                }
                var enddate = $('#txtenddate').val();
                if (enddate == "") {
                    bootbox.alert('Please Select End Date')
                    $('#txtenddate').focus();
                    return false;
                }
                var state = $('#drpselect').val();
                if (state == "") {
                    bootbox.alert('Please select State')
                    $('#drpselect').focus();
                    return false;
                }
                var country = $('#drpcountry').val();
                if (country == "") {
                    bootbox.alert('Please Select Country')
                    $('#drpcountry').focus();
                    return false;
                }
                var dob = $('#txtdob').val();
                if (dob == "") {
                    bootbox.alert('Please select Date Of Birth')
                    $('#txtdob').focus();
                    return false;
                }
                var mobile = $('#txtmobile').val();
                if (mobile == "") {
                    bootbox.alert('Please Insert Mobile Number')
                    $('#txtmobile').focus();
                    return false;
                }
                var address = $('#txtaddress').val();
                if (address == "") {
                    bootbox.alert('Please Insert Address')
                    $('#txtaddress').focus();
                    return false;
                }
                var phone = $('#txtphone').val();
                if (phone == "") {
                    bootbox.alert('Please Insert Phone Number')
                    $('#txtphone').focus();
                    return false;
                }

                var data1 = "{'user_id':'" + loging + "','password':'" + password + "','first_name':'" + firstname + "','middle_name':'" + middlename + "','last_name':'" + lastname + "','full_name':'" + fullname + "','mail':'" + email + "','start_date':'" + startdate + "','end_date':'" + enddate + "','state':'" + state + "','country':'" + country + "','dob':'" + dob + "','phone_no':'" + phone + "','mobile_no':'" + mobile + "','address':'"+address+"'}";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "WebService.asmx/Save_user_detail",
                    data: data1,
                    dataType: "json",
                    success: function (data) {
                        // bind_grid();
                        alert(data.d);
                        $('#txtloging').val('');
                        $('#txtpassword').val('');
                        $('#txtfirstname').val('');
                        $('#txtlstname').val('');
                        $('#txtfullname').val('');
                        $('#txtemail').val('');
                        $('#txtstartdate').val('');
                        $('#txtenddate').val('');
                        $('#drpselect').val('0');
                        $('#drpcountry').val('0');
                        $('#txtdob').val('');
                        $('#txtmobile').val('');
                        $('#txtphone').val('');
                        $('#txtaddress').val('');
                        //  $('#drpfimname').val('0');

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
            <li class="active"><a href="#InsertEditRace" data-toggle="tab"><b>Login Detail</b></a>
                </b> </li>
            <%--<li><a href="#ListRace" data-toggle="tab">Races List</a></li>--%>
        </ul>
        <div class="tab-content">
            <div id="Div1" class="tab-pane active">
                <div class="span5">
                    <div class="control-group">
                        <label class="control-label" for="txtloging">
                            User Name :
                        </label>
                        <div class="controls">
                            <input type="text" id="txtloging" placeholder="UserName" />
                        </div>
                    </div>
                </div>
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
                <li class="active"><a href="#InsertEditRace" data-toggle="tab"><b>User Detail</b></a>
                    </b> </li>
                <%--<li><a href="#ListRace" data-toggle="tab">Races List</a></li>--%>
            </ul>
            <div class="tab-content">
                <div id="Div2" class="tab-pane active">
                    <div class="span5">
                        <div class="control-group">
                            <label class="control-label" for="txtfirstname">
                                First Name :
                            </label>
                            <div class="controls">
                                <input type="text" id="txtfirstname" placeholder="First Name" />
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtlstname">
                                    Last name:
                                </label>
                                <div class="controls">
                                    <input type="text" id="txtlstname" placeholder="Middle Name" />
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
                            <div class="control-group">
                                <label class="control-label" for="txtfromdate">
                                    Start Date :
                                </label>
                                <div class="controls">
                                    <input type="text" id="txtstartdate" placeholder="Start Date" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="drpselect">
                                    State :
                                </label>
                                <div class="controls">
                                    <select id="drpselect">
                                        <option value="">Select State</option>
                                        <option value="01">Gujarat</option>
                                        <option value="02">Maharast</option>
                                        <option value="03">Rajasthan</option>
                                        <option value="04">Punjab</option>
                                    </select>
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
                                <label class="control-label" for="txtaddress">
                                    Address:
                                </label>
                                <div class="controls">
                                    <textarea id="txtaddress" class="input-xlarge" name="address" style="width: 210px;
                                        height: 90;">
                            </textarea>
                                </div>
                            </div>
                            <div class="control-group">
                                <div class="controls">
                                    <input type="button" value="Save" class="btn btn-info" id="btnSave" />
                                    <input type="button" value="Cancel" class="btn btn-danger" id="btnCancel" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="span5">
                        <div class="control-group">
                            <label class="control-label" for="txtmidname">
                                Middle Name :
                            </label>
                            <div class="controls">
                                <input type="text" id="txtmidname" placeholder="Login Name" />
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtfullname">
                                    Full Name :
                                </label>
                                <div class="controls">
                                    <input type="text" id="txtfullname" placeholder="Full Name" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label col-xs-12 col-sm-3 no-padding-right">
                                    Gender
                                </label>
                                <div class="controls">
                                    <label>
                                        <input class="ace" type="radio" id='rbtmale' value="1" name="gender" checked="checked"></input><span
                                            class="lbl"> Male </span>
                                    </label>
                                    <label>
                                        <input type="radio" value="2" name="gender" id="female"></input><span class="lbl"> Female
                                        </span>
                                    </label>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtenddate">
                                    End Date :
                                </label>
                                <div class="controls">
                                    <input type="text" id="txtenddate" placeholder="End Date" />
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="drpcountry">
                                    Country :
                                </label>
                                <div class="controls">
                                    <select id="drpcountry">
                                        <option value="">Select Country </option>
                                        <option value="101">India</option>
                                        <option value="102">Srilanka</option>
                                        <option value="103">australia</option>
                                        <option value="104">Keneda</option>
                                    </select>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtmobile">
                                    Mobile No:
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <span class="add-on icon-mobile-phone"></span>
                                        <input type="text" id="txtmobile" placeholder="MobileNo" />
                                    </div>
                                </div>
                            </div>
                            <div class="control-group">
                                <label class="control-label" for="txtphone">
                                    Phone No:
                                </label>
                                <div class="controls">
                                    <div class="input-prepend">
                                        <span class="add-on icon-phone-sign"></span>
                                        <input type="text" id="txtphone" placeholder="Phone No" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
