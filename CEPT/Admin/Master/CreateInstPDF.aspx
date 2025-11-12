<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CreateInstPDF.aspx.cs" Inherits="Admin_Master_CreateInstPDF" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Personal Details</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="../../Js/user_inst_dtl.js?t=12042023" type="text/javascript"></script>
    <link href="../../DesignCss/jquery.timepicker.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/jquery.timepicker.js" type="text/javascript"></script>
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
</head>
<body>
    <form id="form1" runat="server">
         <div class="clearfix" >
        <div class="page-header position-relative">
            <h1>
                <i class="icon-rupee"></i> Personal Details
            </h1>
        </div>
        <div class="space">
        </div>
 
        <div class="panel panel-default" id="header">
            <div class="panel-heading">
                <strong>Personal Details</strong>
            </div>
            <div id="makepdf">
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
                         <span style="color:blue;"> Applying to assist a Course at the faculty of : </span>  <span style="color:red;" id="apply_course"></span></br>
                        <span style="color:blue;" > Applying to assist a Studio at the faculty of : </span>  <span style="color:red;" id="apply_studio"></span></br></br>

                        <table id="tbl_personal_detail1" style="width: 100%;">
                            <tr>
                            </tr>
                            <tr>
                                <td style="width: 20%;padding-bottom: 10px;">User Name<span style="color:red"></span></td>
                                <td style="width: 30%;padding-bottom: 10px;"> <span id="txt_full_name"></span></td>
                                <td style="width: 20%;padding-bottom: 10px;">Blood Group</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="drop_bloodgroup"></span></td>
                                <td rowspan="3"><img id="img_photo" src="../../UserProfilePhoto/avatar-placeholder.png" alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;vertical-align: top;" class="img-thumbnail" /></td>
                            </tr>
                            <tr>
                                <td style="width: 20%;padding-bottom: 10px;">Date of Birth</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="txt_date_of_birth"></span></td>
                                <td style="width: 20%;padding-bottom: 10px;">Email Id</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="login_email"></span></td>
                            </tr>
                            <tr>
                                <td style="width: 20%;padding-bottom: 10px;">Nationality</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="txt_nationality"></span></td>
                                <td style="width: 20%;padding-bottom: 10px;">Passport no</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="txt_passport_no"></span></td>
                            </tr>

                            <tr>
                                <td style="width: 20%;padding-bottom: 10px;">Highest Qualification</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="txt_hig_qua"></span></td>
                                <td style="width: 20%;padding-bottom: 10px;">Total Years of Experience</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="txt_total_experience"></span></td>
                            </tr>

                            <tr>
                                <td style="width: 20%;padding-bottom: 10px;">Aadhaar No</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="txt_aadhar_no"></span></td>
                                <td style="width: 20%;padding-bottom: 10px;">GST Number</td>
                                <td style="width: 30%;padding-bottom: 10px;"><span id="txt_gst_no"></span></td>
                            </tr>
                             <tr>
                                <td style="width: 20%;padding-bottom: 10px;">COA Registration</td>
                                <td style="width: 20%;padding-bottom: 10px;"><span id="txt_coa_reg_no"></span></td>
                            </tr>
                            
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
                            <%--<tr>
                                <td style="width: 20%;">Phone No
                                </td>
                                <td style="width: 30%;">
                                    <span id="applicant_mobile_no"></span>
                                </td>
                            </tr>--%>
                        </table>

                       <%-- <div class="panel-heading">
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
                        </table>--%>

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
                           <%-- <tr>
                                <td>Address
                                </td>
                                <td colspan="1">
                                    <span id="guardian_address_house_no" style="width: 86%"></span>
                                </td>
                            </tr>--%>
                       <%--     <tr>
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
                            </tr>--%>
                            <tr>
                                <td style="width: 20%;">Phone No
                                </td>
                                <td style="width: 30%;">
                                    <span id="guardian_mobile_no"></span>
                                </td>
                            </tr>
                           <%-- <tr>
                                <td>Email
                                </td>
                                <td>
                                    <span type="text" id="guardian_email_id"></span>
                                </td>
                            </tr>--%>
                        </table>
                    </div>
                </div>


                <div class="panel panel-default" style="display:block;">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">Bank Details</span></strong>
                    </div>
                    <div class="row-fluid" id="Div6" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">
                        <div>
                             <table id="tbl_bank_detail" style="width: 100%;">
                            <tr>
                            </tr>
                            <tr style="padding-bottom:10px;">
                                <td style="width: 20%;padding-bottom: 10px;">Bank Account Number<span style="color:red"></span></td>
                                <td style="width: 30%;padding-bottom: 10px;">
                                 <span id="txt_bank_account_no"></span>
                                </td>
                                <td style="width: 20%;padding-bottom: 10px;">Account Type</td>
                                <td style="width: 30%;padding-bottom: 10px;">
                                    <span id="txt_account_type"></span>
                                </td>
                                 </tr>
                            
                                 <tr style="margin-bottom:10%;">
                                <td style="width: 20%;padding-bottom: 10px;">Name Of The Bank</td>
                                <td style="width: 30%;padding-bottom: 10px;">
                                    <span id="txt_name_bank"></span>
                                </td>

                                <td style="width: 20%;padding-bottom: 10px;">Branch Name</td>
                                <td style="width: 30%;padding-bottom: 10px;">
                                    <span id="txt_branch_name"></span>
                                </td>
                                      </tr>
                                 <tr style="padding-bottom:10px;">
                                <td style="width: 20%;padding-bottom: 10px;">IFSC Code / Swift Code</td>
                                <td style="width: 30%;padding-bottom: 10px;">
                                    <span id="txt_ifsc_code"></span>
                                </td>

                                
                            </tr>
                        </table>
                        </div>
                       
                    </div>
                </div>


                <div class="panel panel-default" style="page-break-after: always;">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">Education</span></strong>
                    </div>
                    <div class="row-fluid" id="dataList_instructor" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">

                        <table class="data-table table table-bordered table-striped" border="0" id="tbleducation">
                            <thead>
                                <tr>
                                    <th>Degree
                                    </th>
                                    <th>Specialization/Field (if applicable)
                                    </th>
                                    <th>University/Institute
                                    </th>
                                    <th>Start Date
                                    </th>

                                    <th>End Date
                                    </th>
                                    <th>Percentage/CGPA</th>
                                    <th>Percentage/ Division</th>
                                    <th>Mode</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="panel panel-default" style="display:block;">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">Work Experience</span></strong>
                    </div>
                    <div class="row-fluid" id="Div1" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">

                        <table class="data-table table table-bordered table-striped" border="0" id="tblworkexp">
                            <thead>
                                <tr>
                                    <th>Name of Institute / Organization
                                    </th>
                                    <th>Designation
                                    </th>
                                    <th>Experience Type
                                    </th>
                                    <th>Start Date
                                    </th>
                                    <th>End Date
                                    </th>
                                    <th>Total Duration in Months
                                    </th>
                                    <th>Mode
                                    </th>
                                    <th>Total no of hours per week
                                    </th>

                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="panel panel-default" style="display:block;">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">References</span></strong>
                    </div>
                    <div class="row-fluid" id="Div2" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">

                        <table class="data-table table table-bordered table-striped" border="0" id="tblreferences">
                            <thead>
                                <tr>
                                    <th>Name
                                    </th>
                                    <th>Mobile No
                                    </th>
                                    <th>Email id
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>


                <div class="panel panel-default" style="display:block;">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">Honors / Awards / Achievements</span></strong>
                    </div>
                    <div class="row-fluid" id="Div3" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">
                        <div>
                            <span id="text_award"></span>
                        </div>
                       
                    </div>
                </div>

                <div class="panel panel-default" style="display:block;">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">Areas of Specialization</span></strong>
                    </div>
                    <div class="row-fluid" id="Div4" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">
                        <div>
                            <span id="text_areas"></span>
                        </div>
                       
                    </div>
                </div>

                <div class="panel panel-default" style="display:block;">
                    <div class="panel-heading">
                        <strong><span class="panel-headingfont">Brief Description (Education & Work Profile)</span></strong>
                    </div>
                    <div class="row-fluid" id="Div5" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">
                        <div>
                            <span id="text_brief"></span>
                        </div>
                       
                    </div>
                </div>

            </div>
                </div>
        </div>
    </div>
        <asp:HiddenField ID="hdn_icode" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_isem" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_iyear" runat="server" ClientIDMode="Static" />
    </form>
  
</body>
      
</html>

