<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="site_joining_report(SJR).aspx.cs" Inherits="ProjectTraining_ProjectTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.timepicker.js"></script>
    <link rel="stylesheet" type="text/css" href="../DesignCss/jquery.timepicker.css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <style>
        .ui-timepicker-wrapper {
             height: 105px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Site Joining Report(SJR)</span></strong>
            </div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div style="" class="form-group col-md-12">
                          <span style="color: red">All Asterisk (*) fields Are Compulsory</span>
                        <table width="100%">
                            <tbody>
                                <tr>
                                    <td class="td1">1.
                                    </td>
                                    <td class="setPadding">Name Of Student
                                    </td>
                                    <td style="width: 65px;">
                                        <input class="col-xs-10" type="text" id="txt_name_student" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">2.
                                    </td>
                                    <td class="setPadding   ">Code
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" id="txt_user_id" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">3.
                                    </td>
                                    <td class="setPadding">Date of Joining
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_date_of_joining' id="txt_date_of_joining" readonly='true' />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">4.
                                    </td>
                                    <td class="setPadding">Project Name
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name="txt_project_name" id="txt_project_name" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">5.
                                    </td>
                                    <td class="setPadding">Name Of The Organization Joined
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_name_of_Organization_join' id="txt_name_of_Organization_join" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">6.
                                    </td>
                                    <td class="setPadding">Reporting To(Name and designation)
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_reporting_to' id="txt_reporting_to" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">7.
                                    </td>
                                    <td class="setPadding">Site address(google)
                                    </td>
                                    <td class="setWidth">
                                        <a href="https://www.google.com" target="_blank" id="location_link">Location</a>
                                    </td>
                                </tr>


                                <tr>
                                    <td class="td1">8.
                                    </td>
                                    <td class="setPadding">Address for Communication(site-in-charge)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <textarea class="cls_disable col-xs-10" rows="3" cols="2" name='txt_address_for_communication' id="txt_address_for_communication"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">State(site)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_address_site_state' id="txt_address_site_state" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">city(site)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_address_site_city' id="txt_address_site_city" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">9.
                                    </td>
                                    <td class="setPadding">Email(site-in-charge)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_email_site' id="txt_email_site" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">10.
                                    </td>
                                    <td class="setPadding">Mobile(site-in-charge)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_mobile_site' id="txt_mobile_site" maxlength="10" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">11.
                                    </td>
                                    <td class="setPadding">Landline(site-in-charge)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input   class="col-xs-10" type="text" name='txt_landline_site' id="txt_landline_site" />
                                    </td>
                                </tr>



                                <tr>
                                    <td class="td1">12.
                                    </td>
                                    <td class="setPadding">Communication Address(student)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <textarea class="cls_disable col-xs-10" rows="3" cols="2" name='txt_communication_address' id="txt_communication_address"></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">State<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_add_Stud_state' id="txt_add_Stud_state" />
                                    </td>
                                </tr>


                                <tr>
                                    <td class="td1"></td>
                                    <td class="setPadding">city<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_add_Stud_city' id="txt_add_Stud_city" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">13.
                                    </td>
                                    <td class="setPadding">Mobile Number(student)<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_mobile_stud' id="txt_mobile_stud" maxlength="10" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">14.
                                    </td>
                                    <td class="setPadding">Email(student)<span class='email-set'>CEPT id as default</span>
                                    </td>
                                    <td class="setWidth">
                                        <input  class="col-xs-10" type="text" name='txt_email_stud' id="txt_email_stud" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">15.
                                    </td>
                                    <td class="setPadding">Working hours<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <div class="col-sm-12">
                                            <input id="from_working_hour" name="from_working_hour" class="cls_disable" style="width: 81px; text-align: center;" />
                                            <span>TO   </span>
                                            <input id="to_working_hour" name="to_working_hour" class="cls_disable" style="width: 81px; text-align: center;" />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="td1">16.
                                    </td>
                                    <td class="setPadding">Lunch Break<span style="color: red">*</span>
                                    </td>
                                    <td class="setWidth">
                                        <div class="col-sm-12">
                                            <input id="from_lunch_hour" name="from_lunch_hour" class="cls_disable" style="width: 81px; text-align: center;" />
                                            <span>TO   </span>
                                            <input id="to_lunch_hour" name="to_lunch_hour" class="cls_disable" style="width: 81px; text-align: center;" />
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <td class="td1">17.
                                    </td>
                                    <td class="setPadding">Additional information If any.
                                    </td>
                                    <td class="setWidth">
                                        <br />
                                        <input  class="col-xs-10" type="text" name='txt_remark' id="txt_remark" />
                                    </td>

                                </tr>

                                <tr id="upload_SJR">

                                    <td class="td1"></td>
                                    <td id="lbl_upload_sjr" class="setPadding"></td>
                                    <td class="setWidth">
                                        <div class="col-xs-12">
                                            <div class="col-xs-6">
                                                <div class="save_submit">
                                                    <div class="col-xs-1">
                                                        <input type="button" class="btn-sm btn_rad btn_hide" id="save" value="save" />
                                                    </div>
                                                    <div class="col-xs-1">
                                                        <input type="button" class="btn-sm btn_rad btn_hide" id="submit" value="Submit" />
                                                    </div>
                                                </div>
                                                <div class="col-xs-1">
                                                    <input type="button" style="margin-left: 20px;" class="btn_rad" id="print_proposal" value="Download SJR" />
                                                </div>
                                                <br />
                                                <br />
                                                <label id="lbl_file_upload" class=" btn btn-sm file-upload " style="vertical-align: bottom; display: block;">
                                                    <span><strong>Upload Files</strong></span>
                                                    <input type="file" name="file_upload" id="file_upload" onchange="javascript:return UploadProfilePhoto();" style="display: none;">
                                                </label>

                                                <span><strong id="upload_result"></strong><span></span><a id='download_link' class="fancybox" download="" rel="group" href="">Download</a>

                                                    <div class="save_uploaded_sjr" style="margin-top: 15px; text-align: center; display: block;">
                                                        <div class="col-xs-3">
                                                            <input type="button" style="display: none" class="btn-sm btn_rad" id="btn_save_uploaded" value="save" />
                                                        </div>
                                                    </div>
                                            </div>
                                            <div class="col-sm-6">
                                            </div>
                                        </div>
                                    </td>
                                </tr>



                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div style="display: none;">
        <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="print_proposal" />
        <input type="hidden" runat="server" ClientIDMode="Static"  id="hdn_data"/>
    </div>
    <style>
        .span-set {
            font-size: smaller;
            margin-left: 4px;
        }

        .setPadding {
            width: 25px;
        }

        .setWidth {
            width: 65px;
        }

        .td1 {
            width: 3%;
        }

        .btn_rad {
            border-radius: 6px;
        }
    </style>
    <script type="text/javascript">
        var finalFileName;
        var myObject = new Object();
        var data = "";
        var obj;
        var upload_file_name;
        var user;
        var user_name;
        debugger;

        if (user == undefined) {

            user = getQueryStringValue('user_id');
            user_name = getQueryStringValue('user_name');
          

            if (user == '') {
                user = ('<%= Session["UserId"] %>');
            }
            else {
                //$('#lbl_file_upload').css('display', 'none');
            }
            
          
        }
      
      
        function getQueryStringValue(key) {
            return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }


        function redirect(str) {
            $('#loading').hide();

            if (user != '') {

            }
            else {
                bootbox.alert('Your Proposal Is Subject To Faculty  Acceptance', function () {
                    window.location.href = "ProposalProject.aspx";
                });
            }
        }
        $(document).ready(function () {
            debugger;
            var user_type = ('<%= Session["User_Type"] %>');
          
            user = getQueryStringValue('user_id');
            user_name = getQueryStringValue('user_name');
            
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_praposal_data",
                data: '{user_id : "' + user + '"}',
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    debugger;
                    if (result.d != "") {
                        obj = JSON.parse(result.d);

                        var status = obj[0]['is_submit'];

                        if (status == "Y") {
                           
                        } else {
                            bootbox.alert('Proposal is not submitted yet', function () {
                                window.location.href = "ProposalProject.aspx";
                            });
                        }
                    } 
                    },
                    error: function (error) {
                        //////console.log(error);
                    }
                });

            var ob = { 'user_id': user, 'user_name': user_name };
            $('#hdn_data').val(JSON.stringify(ob));

                user_name = getQueryStringValue('user_name');

                $('#txt_date_of_joining').datepicker({
                    dateFormat: "dd/mm/yy"
                    //minDate: '26/12/2017'//26/12/2016
                });

                $('#from_working_hour').timepicker(
                    {
                        'minTime': '8:00am',
                        'maxTime': '9:30am'
                    });
                $('#to_working_hour').timepicker(
                    {
                        'minTime': '6:00pm',
                        'maxTime': '9:30pm'
                    });
                $('#from_lunch_hour').timepicker(
                    {
                        'minTime': '8:00am',
                        'maxTime': '9:30pm'
                    });


                $('#to_lunch_hour').timepicker(
                    {
                        'minTime': '8:00am',
                        'maxTime': '9:30pm'
                    });

                $('#aspnetForm').validate({
                    rules:
                {
                    txt_date_of_joining:
                    {
                        required: true
                    },
                    txt_address_site_state:
                    {
                        required: true
                    },
                    txt_address_site_city:
                    {
                        required: true
                    },
                    txt_address_for_communication:
                    {
                        required: true
                    },
                    txt_email_site:
                    {
                        required: true,
                        email: true
                    },
                    txt_mobile_site:
                    {
                        required: true,
                        digits: true,
                        minlength: 10,
                        maxlength: 10
                    },

                    txt_landline_site:
                    {
                        required: true,
                        digits: true
                    },
                    txt_add_Stud_state:
                    {
                        required: true
                    },
                    txt_add_Stud_city:
                    {
                        required: true
                    },
                    txt_add_Stud_city:
                    {
                        required: true
                    }
                ,
                    txt_mobile_stud:
                    {
                        required: true,
                        digits: true,
                        minlength: 10,
                        maxlength: 10
                    }
                ,
                    from_working_hour:
                    {
                        required: true
                    }
                ,
                    to_working_hour:
                    {
                        required: true
                    },
                    from_lunch_hour:
                    {
                        required: true
                    },
                    to_lunch_hour:
                    {
                        required: true
                    }
                },
                    messages:
                  {
                      txt_date_of_joining:
                     {
                         required: "Please Enter Date"
                     },
                      txt_address_site_state:
                      {
                          required: "Please Enter State"
                      },
                      txt_address_site_city:
                      {
                          required: "Please Enter City"
                      },
                      txt_address_for_communication:
                      {
                          required: "Please Enter Address For Communication"
                      },
                      txt_email_site:
                      {
                          required: "Please Enter Email",
                          email: "Please Enter Valid Email"
                      },
                      txt_mobile_site:
                      {
                          required: "Please Enter Phone Number",
                          minlength: "Enter 10 Digit Phone Number",
                          maxlength: "Enter 10 Digit Phone Number"
                      },
                      txt_landline_site:
                      {
                          required: "Please Enter Landline"
                      },
                      txt_add_Stud_state:
                      {
                          required: "Please Enter State "
                      },
                      txt_add_Stud_city:
                      {
                          required: "Please Enter city "
                      },
                      txt_mobile_stud:
                      {
                          required: "Please Enter Phone Number",
                          minlength: "Enter 10 Digit Phone Number",
                          maxlength: "Enter 10 Digit Phone Number"
                      },
                      from_working_hour:
                      {
                          required: "Please Enter From Working Hour"
                      },
                      to_working_hour:
                      {
                          required: "Please Enter To Working Hour"
                      },
                      form_lunch_hour:
                      {
                          required: "Please Enter from Lunch Hour"
                      },
                      to_lunch_hour:
                      {
                          required: "Please Enter To lunch Hour"
                      }
                  }
                });


                //Get_project_training
                $('#txt_project_start_date,#txt_date_of_completion,#txt_date_of_completion_as_per_status').datepicker({
                    dateFormat: "dd/mm/yy"
                });

                $('#txt_user_id').val('<%= Session["UserId"] %>');
                $('#txt_name_student').val('<%= Session["UserName"] %>');
                $('#txt_email_stud').val('<%= Session["email"] %>');
              
            var t = getQueryStringValue('user_id');
               
                debugger;
                if (t != "") {
                    $('#txt_user_id').val(user);
                    $('#txt_name_student').val(user_name);
                    user = getQueryStringValue('user_id');

                }
                else {

                    user = ('<%= Session["UserId"] %>');
                }
                 

                debugger;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/Get_site_join_report_data",
                    data: '{user_id : "' + user + '"}',
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (result) {
                        if (result.d != "") {

                            obj = JSON.parse(result.d)
                            var status = obj[0]['is_submit'];
                            if (status == "Y") {
                                $('input[type="text"], input[type="checkbox"], select').prop("disabled", true);
                                $('.btn_hide').css('display', 'none');
                                $('.save_submit').html(" ");
                                if (user_type == "S") {
                                    $('#lbl_file_upload').css('display', 'inline-flex');
                                    $('#download_link').css('display', 'none');
                                }
                                else {
                                    $('#lbl_file_upload').css('display', 'none');
                                }
                                //$('.save_uploaded_sjr').css('display', '');
                                $('#lbl_upload_sjr').html("Upload Certified SJR Report");
                                $('.cls_disable').attr('disabled', 'disabled');
                            } else {
                                $('#lbl_file_upload').css('display', 'none');
                                $('#download_link').css('display', 'none');
                            }
                            $('#location_link').prop('href', obj[0]['location']);

                            // <a href="https://www.google.com" target="_blank">Google</a>
                            //$('#txt_date_of_joining').val(obj[0]['date_of_join']);
                            $('#txt_date_of_joining').val(obj[0]['date_of_join_sjr']);
                            $('#txt_project_name').val(obj[0]['project_site_name']);

                            //$('#txt_name_of_Organization_join').val(obj[0]['client_name']);
                            $('#txt_name_of_Organization_join').val(obj[0]['name_of_org_join']);
                            //$('#txt_reporting_to').val(obj[0]['reporting_to1']);
                            $('#txt_reporting_to').val(obj[0]['reporting_to']);

                            $('#txt_site_address').val(obj[0]['site_address']);
                            $('#txt_address_for_communication').val(obj[0]['address_from_communication']);
                            $('#txt_email_site').val(obj[0]['site_email']);
                            $('#txt_mobile_site').val(obj[0]['site_mobile']);
                            $('#txt_landline_site').val(obj[0]['landline']);
                            $('#txt_communication_address').val(obj[0]['communication_add_stud']);
                            $('#txt_mobile_stud').val(obj[0]['stud_mobile']);
                            $('#from_working_hour').val(obj[0]['from_working_hour']);
                            $('#to_working_hour').val(obj[0]['to_working_hour']);
                            $('#from_lunch_hour').val(obj[0]['from_lunch_hour']);
                            $('#to_lunch_hour').val(obj[0]['to_lunch_hour']);
                            $('#txt_remark').val(obj[0]['remark']);

                            $('#txt_address_site_state').val(obj[0]['state_site']);
                            $('#txt_address_site_city').val(obj[0]['city_site']);

                            $('#txt_add_Stud_state').val(obj[0]['state_student']);
                            $('#txt_add_Stud_city').val(obj[0]['city_student']);

                            if (obj[0]['file_path'] != "") {
                                $('#download_link').prop('href', ("../ProjectTraining/site_join_report_upload/" + obj[0]['file_path']));
                                upload_file_name = obj[0]['file_path'];
                                //$('#download_link').css('display', 'block');
                            }
                            else {
                                $('#download_link').css('display', 'none');
                                $('#upload_span').css('display', 'none');
                                upload_file_name = '';
                            }


                            user = getQueryStringValue('user_id');
                            if (user != undefined) {
                                //$('#lbl_file_upload').css('display', 'none');
                                $('#txt_email_stud').val(obj[0]['mail'])

                            }
                        }
                    },
                    error: function (error) {
                        //console.log(error);
                    }
                });
                $.validator.addMethod("dateFormat", function (value, element) {
                    debugger;
                    return value.match(/^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$/);
                }, "Please enter a date in the format dd/mm/yyyy.");
                $('#aspnetForm').validate({
                    rules:
                    {
                        txt_project_name:
                        {
                            required: true
                        },

                        txt_date_of_joining:
                       {
                           required: true,
                           dateFormat: true
                       }
                    },
                    messages:
                    {
                        txt_project_name:
                        {
                            required: "Please Enter Project Name"
                        }
                    }
                });

                $('#save').on('click', function () {
                    var result = $('#aspnetForm').valid();

                    if (result == true) {
                        var result = $('#aspnetForm').valid();
                        myObject.userId = $('#txt_user_id').val();
                        myObject.date_of_join = $('#txt_date_of_joining').val();
                        myObject.project_name = $('#txt_project_name').val();
                        myObject.name_of_org_join = $('#txt_name_of_Organization_join').val();


                        myObject.reporting_to = $('#txt_reporting_to').val();
                        myObject.site_address = $('#txt_site_address').val();
                        debugger;
                        myObject.address_from_communication = $('#txt_address_for_communication').val();
                        myObject.site_email = $('#txt_email_site').val();
                        myObject.site_mobile = $('#txt_mobile_site').val();
                        myObject.landline = $('#txt_landline_site').val();
                        myObject.communication_add_stud = $('#txt_communication_address').val();
                        myObject.stud_mobile = $('#txt_mobile_stud').val();
                        myObject.from_working_hour = $('#from_working_hour').val();
                        myObject.to_working_hour = $('#to_working_hour').val();
                        myObject.from_lunch_hour = $('#from_lunch_hour').val();
                        myObject.to_lunch_hour = $('#to_lunch_hour').val();
                        myObject.remark = $('#txt_remark').val();
                        myObject.is_submit = "N";
                        myObject.cancel_flag = "N";

                        myObject.state_site = $('#txt_address_site_state').val();
                        myObject.city_site = $('#txt_address_site_city').val();
                        myObject.state_student = $('#txt_add_Stud_state').val();
                        myObject.city_student = $('#txt_add_Stud_city').val();




                        if (upload_file_name != undefined) {
                            myObject.file_path = upload_file_name;
                        }
                        else {
                            myObject.file_path = "";
                        }

                        data = JSON.stringify({ "data": myObject });

                        $.ajax({
                            type: "POST",
                            url: "../WebService.asmx/project_site_join_report",
                            data: data,
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (result) {
                                bootbox.alert(result.d);

                            },
                            error: function (error) {
                                ////console.log(error);
                            }

                        });
                    }
                });

                $('#submit').on('click', function () {

                    var result = $('#aspnetForm').valid();

                    if (result == true) {

                        myObject.userId = $('#txt_user_id').val();
                        myObject.date_of_join = $('#txt_date_of_joining').val();
                        myObject.project_name = $('#txt_project_name').val();
                        myObject.name_of_org_join = $('#txt_name_of_Organization_join').val();
                        myObject.reporting_to = $('#txt_reporting_to').val();
                        myObject.site_address = $('#txt_site_address').val();
                        myObject.address_from_communication = $('#txt_address_for_communication').val();
                        myObject.site_email = $('#txt_email_site').val();
                        myObject.site_mobile = $('#txt_mobile_site').val();
                        myObject.landline = $('#txt_landline_site').val();
                        myObject.communication_add_stud = $('#txt_communication_address').val();
                        myObject.stud_mobile = $('#txt_mobile_stud').val();
                        myObject.from_working_hour = $('#from_working_hour').val();
                        myObject.to_working_hour = $('#to_working_hour').val();
                        myObject.from_lunch_hour = $('#from_lunch_hour').val();
                        myObject.to_lunch_hour = $('#to_lunch_hour').val();
                        myObject.remark = $('#txt_remark').val();
                        myObject.is_submit = "Y";
                        myObject.cancel_flag = "N";

                        myObject.state_site = $('#txt_address_site_state').val();
                        myObject.city_site = $('#txt_address_site_city').val();
                        myObject.state_student = $('#txt_add_Stud_state').val();
                        myObject.city_student = $('#txt_add_Stud_city').val();


                        if (upload_file_name != undefined) {
                            myObject.file_path = upload_file_name;
                        }
                        else {
                            myObject.file_path = "";
                        }


                        data = JSON.stringify({ "data": myObject });

                        $.ajax({
                            type: "POST",
                            url: "../WebService.asmx/project_site_join_report",
                            data: data,
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (result) {
                                bootbox.alert(result.d, function () {
                                    window.location.reload();
                                });

                            },
                            error: function (error) {
                                ////console.log(error);
                            }

                        });
                    }
                });


                $('#btn_save_uploaded').on('click', function () {

                    var result = $('#aspnetForm').valid();

                    if (result == true) {
                        myObject.userId = $('#txt_user_id').val();
                        myObject.date_of_join = $('#txt_date_of_joining').val();
                        myObject.project_name = $('#txt_project_name').val();
                        myObject.name_of_org_join = $('#txt_name_of_Organization_join').val();
                        myObject.reporting_to = $('#txt_reporting_to').val();
                        myObject.site_address = $('#txt_site_address').val();
                        myObject.address_from_communication = $('#txt_address_for_communication').val();
                        myObject.site_email = $('#txt_email_site').val();
                        myObject.site_mobile = $('#txt_mobile_site').val();
                        myObject.landline = $('#txt_landline_site').val();
                        myObject.communication_add_stud = $('#txt_communication_address').val();
                        myObject.stud_mobile = $('#txt_mobile_stud').val();
                        myObject.from_working_hour = $('#from_working_hour').val();
                        myObject.to_working_hour = $('#to_working_hour').val();
                        myObject.from_lunch_hour = $('#from_lunch_hour').val();
                        myObject.to_lunch_hour = $('#to_lunch_hour').val();
                        myObject.remark = $('#txt_remark').val();
                        myObject.is_submit = "U";
                        myObject.cancel_flag = "N";

                        myObject.state_site = $('#txt_address_site_state').val();
                        myObject.city_site = $('#txt_address_site_city').val();
                        myObject.state_student = $('#txt_add_Stud_state').val();
                        myObject.city_student = $('#txt_add_Stud_city').val();


                        if (upload_file_name != undefined) {
                            myObject.file_path = upload_file_name;
                        }
                        else {
                            myObject.file_path = "";
                        }


                        data = JSON.stringify({ "data": myObject });

                        $.ajax({
                            type: "POST",
                            url: "../WebService.asmx/project_site_join_report",
                            data: data,
                            dataType: 'json',
                            contentType: "application/json",
                            success: function (result) {
                                bootbox.alert(result.d, function () {
                                    window.location.reload();
                                });

                            },
                            error: function (error) {
                                ////console.log(error);
                            }

                        });
                    }
                });




                $('#aspnetForm').validate({
                    rules:
                    {
                        txt_project_name:
                        {
                            required: true
                        }

                    },
                    messages:
                    {
                        txt_project_name:
                        {
                            required: "Please Enter Project Name"
                        }
                    }
                });



                var a = getQueryStringValue('user_id');
                if (a != '') {
                    //$('#lbl_file_upload').css('display', 'none');
                    $('#txt_email_stud').val('');
                    //$('#lbl_file_upload').css('display', 'none');
                }
                debugger;
              

            });



            function UploadProfilePhoto() {
                upload_file_name = '';
                try {
                    debugger;
                    var fileToUpload = GetFileNameFromPath($('#file_upload').val());

                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                    if (CheckUserPhotoExtension(fileToUpload)) {

                        var flag = true;

                        if (filename != "" && filename != null) {

                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../Handler/site_joining_report_handler.ashx',
                                    secureuri: false,
                                    fileElementId: 'file_upload',
                                    dataType: 'json',
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                            }
                                            else {
                                                $('#file_upload').val("");

                                                FileName = data.upfile;
                                                upload_file_name = FileName;

                                                $('#btn_save_uploaded').click();

                                            }
                                        }
                                        $("#UploadingProgress").fadeOut(200);

                                        $('#upload_result').text('file upload successfully.');
                                    },
                                    error: function (data, status, e) {
                                        $("#UploadingProgress").fadeOut(200);
                                        alert(e);
                                    }
                                });
                            }
                        }
                    }
                    else {
                        alert('Invalid File Type. Please upload .pdf file');
                    }
                    return false;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                }
            }

            function GetFileNameFromPath(strFilepath) {

                var objRE = new RegExp(/([^\/\\]+)$/);
                var strName = objRE.exec(strFilepath);

                if (strName == null) {
                    return null;
                }
                else {
                    return strName[0];
                }
            }

            function CheckUserPhotoExtension(file) {
                try {
                    var flag = true;
                    var extension = file.substr((file.lastIndexOf('.') + 1));

                    switch (extension) {
                        case 'pdf':
                        case 'PDF':
                        case 'jpg':
                        case 'jpeg':
                        case 'JPG':
                        case 'JPEG':
                        case 'png':
                        case 'PNG':
                            flag = true;
                            break;
                        default:
                            flag = false;
                    }

                    return flag;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                }
            }

            $('#print_proposal').click(function () {

                $('#hdn_download').click();
            });
          
          

        </script>
</asp:Content>
