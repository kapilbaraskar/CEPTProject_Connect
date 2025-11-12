<%@ Page Title="Student Report" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="user_master_report.aspx.cs" Inherits="Admin_Master_user_master_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/user_report.js?t=10072023" type="text/javascript"></script>
    <link href="../../DesignCss/jquery.timepicker.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/jquery.timepicker.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style>
        .img-thumbnail
        {
            display: inline-block;
            max-width: 100%;
            height: auto;
            padding: 4px;
            line-height: 1.42857143;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 4px;
            -webkit-transition: all .2s ease-in-out;
            transition: all .2s ease-in-out;
        }

        .file-upload input
        {
            position: absolute;
            top: 0;
            left: 0;
            margin: 0;
            font-size: 10pt;
            opacity: 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-rupee"></i> Student Report
            </h1>
        </div>
        <div class="space">
        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div class="panel-body">
                <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                            Department
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            Year of enrollment
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                        <td>
                            Programme
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester" />
                        </td>
                        <td>
                            Year Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drp_year_semester">
                            </select>
                        </td>
                        <td>
                            Modified On
                        </td>
                        <td>
                            <input type="text" id="txt_modified_on" class="marg-btm" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                           <b>OR</b> 
                        </td>
                        </tr>
                        <tr>
                        <td>
                            Student Code
                        </td>
                        <td>
                            <%--<input type="text" id="txt_student_code" class="marg-btm" placeholder="Enter Student Code"/>--%>
                            <select class="chosen-select" id="drp_student_code" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" align="center">
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        
        <div class="panel panel-default" id="header">
            <div class="panel-heading">
                <strong>Student Detail</strong>
            </div>

            <div style="display: none; width: 100%; overflow:auto;" class="row-fluid" id="DataList">
                <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                    border="0" id="example" width="100%">
                    <tbody>
                    </tbody>
                </table>
            </div>

            <div style="display: none; width: 100%; overflow:auto;" class="row-fluid" id="Student_Profile">
                <div class="panel panel-default ">
                    <div style="padding: 15px;">
                        <table id="tbl_personal_detail1" style="width: 100%;">
                            <tr>
                                <%--<td style="width: 20%;">First Name<span style="color:red"></span></td>
                                <td style="width: 30%;">
                                    <%--<input type="text" id="txt_first_name" />
                                    <span id="txt_first_name"></span>
                                </td>--%>
                                <%--<td style="width: 20%;">Middle Name</td>
                                <td style="width: 30%;">
                                    <%--<input type="text" id="txt_middle_name" />
                                        <span id="txt_middle_name"></span>
                                </td>--%>
                            </tr>
                            <tr>
                                <%--<td style="width: 20%;">Last Name<span style="color:red"></span></td>
                                <td style="width: 30%;">
                                    <%--<input type="text" id="txt_last_name" />
                                        <span id="txt_last_name"></span>
                                </td>--%>
                                <td style="width: 20%;">User Name<span style="color:red"></span></td>
                                <td style="width: 30%;">
                                        <span id="txt_full_name"></span>
                                </td>
                                <td style="width: 20%;">Blood Group</td>
                                <td style="width: 30%;">
                                    <%--<select id="drop_bloodgroup">
                                        <option value=""><---- Select Blood Group ----></option>
                                        <option value="O+">O+</option>
                                        <option value="O-">O-</option>
                                        <option value="A+">A+</option>
                                        <option value="A-">A-</option>
                                        <option value="B+">B+</option>
                                        <option value="B-">B-</option>
                                        <option value="AB+">AB+</option>
                                        <option value="AB-">AB-</option>
                                    </select>--%>
                                    <span id="drop_bloodgroup"></span>
                                </td>
                                <td rowspan="3">
                                    <img id="img_photo" src="../../UserProfilePhoto/avatar-placeholder.png"
                                        alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;vertical-align: top;" class="img-thumbnail" />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%;">Date of Birth</td>
                                <td style="width: 30%;"><span id="txt_date_of_birth"></span></td>
                                <td style="width: 20%;">Email Id</td>
                                <td style="width: 30%;"><span id="login_email"></span></td>
                            </tr>
                            <tr>
                                <td>Year of Enrollment</td>
                                <td><span id="drppyear"></span></td>
                                <td style="width: 20%;">Program Title</td>
                                <td style="width: 30%;"><span id="drppprog"></span></td>
                            </tr>
                            <%--<tr id="tr_txt_other_prog" style="display: none;">
                                <td></td>
                                <td></td>
                                <td></td>
                                <td><input type="text" id="txt_other_prog" /></td>
                            </tr>--%>
                        </table>
                    </div>
                </div>

                <div class="panel panel-default ">
                    <div class="panel-heading">
                        <strong>Contact Details</strong>
                    </div>
                    <div style="padding: 15px;">
                        <table id="tbl_communication_preferences" class="data-table table table-bordered table-striped" style="width: 100%;">
                            <tr style="display: none;">
                                <td>Home Address
                                </td>
                                <td colspan="3">
                                    <textarea id="txt_home_address" rows="2" style="width: 86%"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td>Address
                                </td>
                                <td colspan="1">
                                    <span id="txt_home_address1" style="width: 86%"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>City</td>
                                <td><span type="text" id="txt_home_city"></span></td>
                            </tr>
                            <tr>
                                <td>PinCode
                                </td>
                                <td>
                                    <span type="text" id="txt_home_pincode"></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%;">Phone No
                                </td>
                                <td style="width: 30%;">
                                    <span id="txt_phone_no"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Email
                                </td>
                                <td>
                                    <span type="text" id="applicant_email_id"></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%;">Phone No
                                </td>
                                <td style="width: 30%;">
                                    <span id="applicant_mobile_no"></span>
                                </td>
                            </tr>
                        </table>

                        <div class="panel-heading">
                            <strong>Preferred Correspondence Address</strong>
                        </div>

                        <table id="Table1" class="data-table table table-bordered table-striped" style="width: 100%;">
                         
                            <tr>
                                <td>Address
                                </td>
                                <td colspan="1">
                                    <span  type="text" id="preferred_mailing_address_house_no" style="width: 86%"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>City
                                </td>
                                <td>
                                    <span id="preferred_mailing_address_city"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>PinCode
                                </td>
                                <td>
                                    <span type="text" id="preferred_mailing_address_pincode"></span>
                                </td>
                            </tr>
                        </table>

                        <div class="panel-heading">
                            <strong>Emergency Contact Details</strong>
                        </div>

                        <table id="Table2" class="data-table table table-bordered table-striped" style="width: 100%;">
                            <tr>
                                <td>Name of Contact Person</td>
                                <td>
                                    <span id="guardian_name"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Address
                                </td>
                                <td colspan="1">
                                    <span id="guardian_address_house_no" style="width: 86%"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>City
                                </td>
                                <td>
                                    <span type="text" id="guardian_address_city"></span>
                                </td>

                            </tr>
                            <tr>
                                <td>PinCode
                                </td>
                                <td>
                                    <span type="text" id="guardian_address_pincode"></span>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 20%;">Phone No
                                </td>
                                <td style="width: 30%;">
                                    <span id="guardian_mobile_no"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>Email
                                </td>
                                <td>
                                    <span type="text" id="guardian_email_id"></span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">Education</span></strong>
                    </div>
                    <div class="row-fluid" id="dataList_instructor" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">

                        <table class="data-table table table-bordered table-striped" border="0" id="tbleducation">
                            <thead>
                                <tr>
                                    <th>Degree Name
                                    </th>
                                    <th>Institution
                                    </th>
                                    <th>University</th>
                                    <th>Education Major Subject</th>
                                    <th>Year of Graduation</th>
                                    <th>Education Score</th>
                                    <th>Nata Id</th>
                                    <th>Nata Score</th>
                                    <th>Nata Second Score</th>

                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="panel panel-default" style="display:none;">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">Work Experience</span></strong>
                    </div>
                    <div class="row-fluid" id="Div1" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">

                        <table class="data-table table table-bordered table-striped" border="0" id="tblworkexp">
                            <thead>
                                <tr>
                                    <th>Organization Name
                                    </th>
                                    <th>Designation
                                    </th>
                                    <th>Responsibility
                                    </th>

                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
