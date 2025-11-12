<%@ Page Title="Student Dashboard-CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="Student_dashboard.aspx.cs" Inherits="Student_Student_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script src="../Js/google_analytics_code.js" type="text/javascript"></script>
 
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <%-- <link href="../DesignCss/application.css" rel="stylesheet" type="text/css" />--%>
    <link href="../DesignCss/bootstrap-switch.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/jquery.multi-select.js" type="text/javascript"></script>
    <script src="../DesignJS/application.js" type="text/javascript"></script>
    <script src="../Js/student_course_selection_new2.js" type="text/javascript"></script>
    <script src="../Js/general.js" type="text/javascript"></script>
   
    <script src="../DesignJS/bootstrap-switch.js" type="text/javascript"></script>
    <link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../fancy_box/jquery.fancybox.css" rel="stylesheet" type="text/css" />
    <script src="../fancy_box/jquery.fancybox.pack.js" type="text/javascript"></script>
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script type="text/javascript">
        var str_user_type = '<%= Session["user_type"] %>';

        $(document).ready(function () {
            //            $('#btn_print').prop("disabled", true);
            //            $('#btnonlinepayment').prop("disabled", true);

            debugger;

            //            if ('<%= Session["UserId"] %>' == 'admin') {
            //                $('#div_save_register,#div_save_credit').css('display','block');
            //            }
            //            else {
            //             
            //            }

            //$('#div_save_register').css('display', 'none');
            $('#div_save_register,#div_save_credit').css('display', 'none');

            if ('<%= Session["user_type"] %>' == 'E') {
                $('#div_save_register,#div_save_credit').css('display', 'block');
            }
            else if ('<%= Session["UserId"] %>' == 'UA0111' || '<%= Session["UserId"] %>' == 'UI4315') {
                $('#div_save_register,#div_save_credit').css('display', 'block');
            }


            $('#btn_print').on('click', function () {

                var check_oepn = 0;

                //                  debugger;
                //                  if ('<%= Session["dept_code"] %>' == '7') 
                //                  {
                //                     check_oepn = 1;
                //                  }

                //                 if ('<%= Session["dept_code"] %>' == '1' && '<%= Session["prog_code"] %>' == '1' && '<%= Session["year_code"] %>' == 'Y2015') {
                //                  
                //                     check_oepn = 1;
                //                  }

                //                 if ('<%= Session["dept_code"] %>' == '2' && '<%= Session["prog_code"] %>' == '1' && '<%= Session["year_code"] %>' == 'Y2015') {
                //                  
                //                     check_oepn = 1;
                //                  }

                //                  if (check_oepn == 0) {
                //                  bootbox.alert("Registration has been closed for Summer 2015.");
                //                  return false;
                //                }
                // bootbox.alert("Registration has been closed for Summer 2015.");
                //  return false;

                bootbox.confirm("Please make sure you have saved your courses.  Proceed?", function (result) {

                    if (result == true) {

                        if ('<%= Session["country"] %>' == '2') {
                            window.open('Print_pay_in_slip_other.aspx', 'PrintMe', 'height=600px,width=610,scrollbars=1');
                            return false;
                        }
                        else {
                            window.open('Print_pay_in_slip_new.aspx', 'PrintMe', 'height=650px,width=1150px,scrollbars=1');
                            return false;
                        }
                        return false;
                    }
                    else {

                    }

                });

                return false;

            });
            return false;
        });

        function chkpriorityDeselect() {
            total_creadit = 0;
            bind_sem_course_data();
        }

    </script>
    <style type="text/css">
        .gpa
        {
            width: 48px;
        }
        .priority
        {
            width: 48px;
        }
        tfoot
        {
            display: table-header-group;
        }
        .copyright
        {
            font-size: 12px; /*background: rgba(129,193,229,0.8);*/ /*  background: rgba(255,187,119,0.8);*/
            position: fixed;
            bottom: 0px;
            z-index: 11;
            margin-top: 10px;
        }
        .copyright p
        {
            color: #dadada;
        }
        .copyright a
        {
            margin: 0 5px;
            color: #72c02c;
        }
        .copyright a:hover
        {
            color: #a8f85f;
            -webkit-transition: all 0.4s ease-in-out;
            -moz-transition: all 0.4s ease-in-out;
            -o-transition: all 0.4s ease-in-out;
            transition: all 0.4s ease-in-out;
        }
        .copyright .span8
        {
            padding-top: 15px;
        }
        .copyright .span4
        {
            padding-top: 10px;
        }
        #sidebar:before
        {
            width: 124px;
        }
        #main-content
        {
            margin-left: 113px;
        }
        #sidebar
        {
            width: 124px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <input type="hidden" id="returnUrl" name="returnUrl" value="" />
    <input type="hidden" id="secSignature" name="secSignature" value="" />
    <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
    <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId"
        value="" />
    <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount"
        value="" />
    <input style="display: none" type="text" id="currency" class="text" name="currency"
        value="INR" />
    <div class="row-fluid">
        <div class="page-header position-relative">
            <table>
                <tr>
                    <td>
                        <h1>
                            <i class="icon-desktop"></i>Course Selection
                        </h1>
                    </td>
                    <td style="width: 550px" align="right">
                        <a href="<%= Page.ResolveClientUrl("~/Student/Dashboard.aspx") %>" class="btn btn-sm btn-primary">
                            <i class="icon-on-right icon-arrow-left"></i><span class="bigger-100">Go back to Dashboard</span>
                        </a>
                    </td>
                    <td style="margin-left: 150px; display: none;" align="center">
                        <a href="<%= Page.ResolveClientUrl("~/Student/calender.aspx") %>" class="btn btn-sm btn-primary">
                            <i class="icon-time"></i><span class="bigger-50">View Time Table</span> </a>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table id="div_save_credit" style="display: block;" border="0" cellpadding="1" cellspacing="5">
                <tr>
                    <td>
                        Total Credits Enrolling for(Your Fee would be calculated based on this) :
                    </td>
                    <td>
                        <input type="text" id="txtcredit_choice" />
                    </td>
                    <td width="10px">
                    </td>
                    <td align="right" style="display: block">
                       <%-- <button id="btn_save_credit" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Save
                        </button>--%>
                    </td>
                    <tr>
                        <td>
                            (Maximum 8 Credits can be selected)
                        </td>
                        <td>
                        </td>
                        <td>
                        </td>
                    </tr>
                </tr>
            </table>
        </div>
        <div class="col-sm-8">
            <%--<div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>
                            Sort By Faculty
                        </td>
                        <td>
                            <select class="chosen-select" id="drpfaculty">
                            </select>
                            Or
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Sort By Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester" />
                        </td>
                    </tr>
                </table>
            </div>--%>
        </div>
        <div class="tabbable" style="width: 100%; margin-bottom: 20px;">
            <ul class="nav nav-tabs" id="myTab">
                <%--<li class="active"><a data-toggle="tab" href="#mandatory">Mandatory&nbsp;</a> </li>--%>
                <%-- <li><a data-toggle="tab" href="#elective">Elective &nbsp; </a></li>--%>
                <div align="right">
                    <table cellpadding="5px" cellspacing="0px">
                        <tr>
                            <%-- <td>
                                <label style="color: Red">
                                    Mandatory credits opted :</label>
                            </td>
                            <td style="width: 20px">
                                <label id="lbl_mandatory">
                                </label>
                            </td>--%>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                <label style="color: Red">
                                    Total credits opted :</label>
                            </td>
                            <td>
                                <label id="lbl_elective">
                                </label>
                            </td>
                        </tr>
                    </table>
                </div>
            </ul>
            <div class="tab-content" style="padding: 0 0 0 0; overflow: visible;">
                <div id="elective" class="tab-pane in active">
                    <div id="datalist_elective">
                        <table cellpadding="0" cellspacing="0" border="0" id="elective1" class="display table table-striped table-bordered table-hover">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot id="abc1">
                                <tr>
                                    <th>
                                        Search <i class="icon-on-right icon-arrow-right"></i>
                                        <input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines"
                                            class="search_init" />
                                    </th>
                                    <th>
                                        Deselect
                                        <input type="checkbox" name="priority" id="chkpriority" onchange="chkpriorityDeselect()" />
                                        <%--  <input type="text" style="width: 10px; display: none" name="search_engine" value="Search engines"
                                            class="search_init" />--%>
                                    </th>
                                    <th>
                                        <input type="text" style="width: 30px" name="search_code" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 79px" name="search_name" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 10px" name="search_credits" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 20px;" name="search_pre" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 20px;" name="search_pre" value="" class="search_init" />
                                    </th>
                                    <%-- <th>
                                        <input type="text" style="width: 50px;" name="search_Faculty" value="" class="search_init" />
                                    </th>--%>
                                    <th>
                                        <input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 70px" name="search_time" value="" class="search_init" />
                                    </th>
                                    <%-- <th>
                                        <input type="text" style="width: 142px" name="search_days" value="" class="search_init" />
                                    </th>--%>
                                    <th>
                                        <input type="text" style="width: 94px" name="search_Area" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 25px" name="search_Area" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 1px; display: none" name="search_Area" value="Area"
                                            class="search_init" />
                                    </th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>

            <div id="div_student_passport_dtl" style="margin-top: 20px;margin-bottom: 30px;display:none;">
                <div>
                    <strong>Passport Detail</strong>
                </div>
                <div>
                    <table style="margin:10px;">
                        <tr style="vertical-align: top;">
                            <td>Name as per your Passport</td>
                            <td>&nbsp;:&nbsp;</td>
                            <td><input type="text" id="txt_passport_name" /></td>
                        </tr>
                        <tr style="vertical-align: top;">
                            <td>Passport Number</td>
                            <td>&nbsp;:&nbsp;</td>
                            <td><input type="text" id="txt_passport_number" /></td>
                        </tr>
                        <tr style="vertical-align: top;">
                            <td>Upload scan copy of first and last page of your Passport</td>
                            <td>&nbsp;:&nbsp;</td>
                            <td>
                                <%--<label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload Photo</strong></span>
                                    <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadProfilePhoto();" />
                                </label>--%>
                                <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadProfilePhoto();" style="width: 95px;"/>
                                <span id="spn_image"></span>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <%--<div class="copyright" style="box-shadow: 5px 0 6px 1px black;">
        <div id="div_save_register" class="container" style="display: block; width: 1197px;">
            <div class="row-fluid">
                <div class="span11" style="margin-top: 10px">
                    <table align="center" border="0" cellpadding="3" cellspacing="5">
                        <tr>
                            <td>
                                <button id="btn_save" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>
                            </td>
                            <td>
                                <button id="btn_print" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-print bigger-160"></i>Print Pay-In Slip
                                </button>
                            </td>
                            <td>
                                <button id="btnonlinepayment" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-print bigger-160"></i>Online Payment
                                </button>
                            </td>
                            <td>
                                <button id="btnsave" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Register
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>--%>
    <div id="course_image">
        <%--<img src="../course_image/W13FA007.jpg" />--%>
    </div>

    <script type="text/javascript">

        function UploadProfilePhoto() {
            try {
                var fileToUpload = GetFileNameFromPath($('#imageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../Handler/UserPassportUpload.ashx',
                                secureuri: false,
                                fileElementId: 'imageUpload',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#imageUpload').val("");

                                            FileName = data.upfile;

                                            $('#spn_image').html(FileName);

                                            //$("#img_photo").attr("src", "../UserProfilePhoto/" + FileName);
                                            //$("#img_photo").attr("alt", FileName);
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
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
                    alert('Invalid File Type. Please upload .jpeg file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        //Get File Name From Path
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

        //Check User Photo Extension
        function CheckUserPhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'jpg':
                    case 'jpeg':
                    case 'JPG':
                    case 'JPEG':
                    case 'PNG':
                    case 'png':
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

        
    </script>
</asp:Content>
