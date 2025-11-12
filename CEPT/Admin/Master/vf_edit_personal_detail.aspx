<%@ Page Title="Personal Detail" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="vf_edit_personal_detail.aspx.cs" Inherits="Admin_Master_vf_edit_personal_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>

 <%--   <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>--%>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js"></script>
<link type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css" rel="stylesheet" />
     
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <script src="../../Js/vf_edit_personal_detail_21012017.js?t=11112024" type="text/javascript"></script>
    <script src="../../DesignJS/ckeditor2/ckeditor.js" type="text/javascript"></script>
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script> 


    <%--12092020--%><%--18102020--%>
    <%--29012020--%>


    <style type="text/css">
        .img-thumbnail {
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

        .file-upload input {
            position: absolute;
            top: 0;
            left: 0;
            margin: 0;
            font-size: 10pt;
            opacity: 0;
        }

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

        #pdclick:hover {
            text-decoration: underline;
        }
    </style>

      <style>


        .main {
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

.animation {
    display: flex;
}

ul li {
    list-style: none;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin: 0 40px;
}

#lp_disabled{
    margin-right:-1500%;
}

ul li .label {
    font-family: sans-serif;
    letter-spacing: 1px;
    font-size: 14px;
    font-weight: bold;
    color: #1b761b;
}

ul li .step {
    height: 30px;
    width: 30px;
    border-radius: 50%;
    background-color: #d7d7c3;
    margin: 16px 0 10px;
    display: grid;
    place-items: center;
    color: ghostwhite;
    position: relative;
    cursor: pointer;
}

.step::after {
    content: "";
    position: absolute;
    width: 865px;
    height: 3px;
    background-color: #5B9BD5!important;
    right: 30px;
}

.first::after {
    width: 0;
    height: 0;
}

ul li .step .awesome {
    display: none;
}

ul li .step p {
    font-size: 18px;
}

ul li .active {
    background-color: #1b761b;
}

li .active::after {
    background-color: #1b761b;

}

ul li .active p {
    display: none;
}

ul li .active .awesome {
    display: flex;
}
  .step p.step-number {
    margin: 0;
    font-weight: bold;
    color: white;
  }

  .step i.step-icon {
    position: absolute;
    display: none;
    font-size: 24px;
    color: #2aa968;
  }

  .hidden {
    display: none;
  }
    </style>


       <script>
           document.addEventListener("DOMContentLoaded", function () {

               // Your JavaScript code here

               const step2Button = document.getElementById('btnapprove');
               if (step2Button) {
                   step2Button.addEventListener('click', function () {

                       //window.location.href = 'Interested_Program.aspx';
                   });
               }
               function updateProgressBar() {
                   const progressBar = document.querySelector('.progress-container');
                   let progress = 0;
                   const interval = setInterval(() => {
                       progress += 1;
                       progressBar.style.width = progress + '%';
                       if (progress >= 100) {
                           clearInterval(interval);
                           progressBar.classList.add('completed');
                       }
                   }, 100);

                   setTimeout(() => {
                       clearInterval(interval);
                       progressBar.classList.add('completed');
                   }, 3000);
               }

               window.onload = updateProgressBar;
           });

       </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid" id="for_other" style="display: none;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Personal Details 
            </h1>
        </div>
    </div>

    <div class="row" style="margin-top: 11px; width: 100%; border: 0px solid rgba(113, 112, 112, 1); background-color: rgba(255, 255, 255, 1); border-radius: 0; box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6); margin-left: 1px; display: none;" id="for_I2">
        <h5 class="font_8" style="margin-left: 5px; font-size: 18px; margin-top: 3px;">Call for Studio Tutor
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue;"><a href="Studio_Proposal_dtl.aspx">View Submitted Proposal</a></span>
            <%-- <span style="font-size:10pt;float:right;margin-right:0.8%;text-shadow: 0 0 slateblue;">|</span>
            <span style="font-size:10pt;float:right;margin-right:1.2%;text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a></span>--%>
        </h5>
        <div style="margin-left: 1%; border-top: 1px solid #c2c2c2ab; width: 97.8%;"></div>
         <div class="progress-bar">
    <span class="progress-container"></span>
  </div>
        <div class="main">
    <ul class="animation" style="margin-left: -72%;">
        <li>
            <div class="step first" style="background-color:#5B9BD5;">
                 <p><i class="fa fa-check" style="font-size:22px;color:#ffeeee"></i></p>         
            </div>
             <p id="pdclick" style="color: black;">Personal Details</p>
        </li>
        <li>
            <div class="step second"  style=" margin-right: -1500%;">
                 <p><i class="fa fa-close" style="font-size:22px;color:#ffeeee"></i></p>           
            </div>
            <a href="Interested_Program.aspx" id="lp_disabled" style="color: black;">Studio Proposal</a>
        </li>     
    </ul>            
</div>
    </div>




        <%--<ol class="show-grid col-md-8 col-md-offset-2" style="margin-left: -8px; width: 100%; margin-bottom: 10px; margin-top: 5px;">
            
            <div id="temp_user">
                <li class="col-md-3 active" id="pd" style="width: 27.5% !important;">
                    <div class="media">
                        <div class="pull-left" href="#">
                            <span class="glyphicon glyphicon-user"></span>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><strong>Step 1:</strong></h5>
                          <p id="pdclick" style="color: black;">Personal Details</p>
                           

                        </div>
                    </div>
                </li>
                <li class="col-md-3 active" id="ip" style="width: 28% !important;">
                    <div class="media">
                        <div class="pull-left" href="#">
                            <span class="glyphicon glyphicon-book"></span>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><strong>Step 2:</strong></h5>
                            <a href="Interested_Program.aspx" id="lp_disabled" style="color: black;">Studio Proposal</a>

                        </div>
                    </div>
                </li>
                <li class="col-md-3 active" id="sd" style="width: 28% !important;">
                    <div class="media">
                        <div class="pull-left" href="#">
                            <span class="glyphicon glyphicon-dashboard"></span>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><strong>Step 3:</strong></h5>
                            <a href="Studio_Details.aspx" id="sp_disabled" style="color: black;">Studio Brief</a>

                        </div>
                    </div>
                </li>
            </div>

            <div id="existing_user" style="display: none;">
                <li class="col-md-3 active" id="pd" style="width: 27.5% !important;">
                    <div class="media">
                        <div class="pull-left" href="#">
                            <span class="glyphicon glyphicon-user"></span>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><strong>Step 1:</strong></h5>
                         <p id="pdclick" style="color: black;">Personal Details</p>
                           

                        </div>
                    </div>
                </li>
                <li class="col-md-3 active" id="ip" style="width: 28% !important;">
                    <div class="media">
                        <div class="pull-left" href="#">
                            <span class="glyphicon glyphicon-book"></span>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><strong>Step 2:</strong></h5>
                            <a href="Existing_Interested_Program.aspx" id="lp_disabled" style="color: black;">Studio Proposal</a>

                        </div>
                    </div>
                </li>
                <li class="col-md-3 active" id="sd" style="width: 28% !important; display: block;">
                    <div class="media">
                        <div class="pull-left" href="#">
                            <span class="glyphicon glyphicon-dashboard"></span>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><strong>Step 3:</strong></h5>
                            <a href="" id="sp_disabled" style="color: black;">Studio Brief</a>

                        </div>
                    </div>
                </li>
            </div>

            
        </ol>
    </div>--%>

    <%--<div class="row-fluid" id="for_I2" style="display: none;">
        <div style="width: 1200px; margin-top: 10px;">
            <a href="" style="text-decoration: none;">
                <div class="style_prevu_kit" style="background-color: #ff1e1eeb; text-align: center; box-shadow: 3px 3px black;" id="pd">
                    <p style="color: white; font-size: 16px; font-family: Open Sans;">Personal Details</p>
                    <i class="arrow down"></i><%--&#8681;
                </div>
            </a>
            <a href="Interested_Program.aspx" style="text-decoration: none;">
                <div class="style_prevu_kit" style="background-color: #b8b3b3; text-align: center;" id="ip">
                    <p style="color: white; font-size: 16px; font-family: Open Sans;">Level/Program</p>
                </div>
            </a>
            <a href="Studio_Details.aspx" style="text-decoration: none;">
                <div class="style_prevu_kit" style="background-color: #b8b3b3; text-align: center;" id="sd">
                    <p style="color: white; font-size: 16px; font-family: Open Sans;">Studio Proposal Details</p>
                </div>
            </a>
            <a href="" style="text-decoration: none;">
                <div class="style_prevu_kit" style="background-color: #b8b3b3; text-align: center;" id="bd">
                    <p style="color: white; font-size: 16px; font-family: Open Sans;">Bank Details</p>
                    <i class="arrow down" id="bdetailsarrow"></i><%--&#8681;
                </div>
            </a>
        </div>
    </div>--%>
    <div class="well" style="background-color: White; margin-top: 1%;">

        <div id="div_filter_criteria" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                           
                            <tr>
                                <td>Instructor Name :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drp_instructor_name">
                                    </select>
                                </td>
                                <td>Instructor Code :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drp_instructor_code">
                                    </select>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-default" id="profile_pic">
            <div class="panel-heading">
                <b>Profile Photo</b>
            </div>

            <div style="padding: 10px; overflow: visible;" class="panel-collapse collapse in">
                <img id="img_photo" src="../../UserProfilePhoto/Default_Avtar.png" alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;"
                    class="img-thumbnail" />

                <label id="lbl_img" class="btn btn-primary file-upload " style="vertical-align: bottom;">
                    <span><strong>Upload Photo</strong></span>
                    <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadUserProfilePhoto();" />
                </label>
                <br />

                <label id="lbl_image_name" style="display: none;" ng-model="data.image_name"></label>
            </div>
        </div>

        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Personal Details</b>
                <%--<p style="color: blue;">
                    Note: Bank Details will be later enabled for approved studios.
                </p>--%>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_personal_detail" class="panel-collapse collapse in">
                
                <table style="width: 100%;" cellpadding="10" cellspacing="20">
                    
                    <tr>
                        <td class="pad-top" style="display:none;">VF Code<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td style="display:none;">
                            <input type="text" id="txt_vf_code" class="marg-btm" disabled />
                        </td>
                        <td class="pad-top">Title<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <select id="drp_title" class="marg-btm">
                                <option value="">--Select Title--</option>
                                <option value="Mr.">Mr.</option>
                                <option value="Ms.">Ms.</option>
                                <option value="Dr.">Dr.</option>
                                <option value="Prof.">Prof.</option>
                            </select>
                        </td>
                    </tr>
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
                        <td class="pad-top" id="bank_6">Blood Group<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td id="bank_7">
                            <%--<input type="text" id="txt_blood_group" class="marg-btm"/>--%>
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

                        <td class="pad-top">Alternate Contact Number<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_alternate_contact_no" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="10" />
                        </td>
                        <td class="pad-top">PAN No<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_pan_card_no" class="marg-btm" />
                        </td>



                    </tr>

                    <tr>
                        <%--<p style="color: blue; font-size: 10px;">
                                If yes, enter your passport no.<br />
                                Otherwise, Please mention your Aadhar Card No.
                            </p>--%>
                        <%-- <select id="country">
                                <option value="ind">India</option>
                                <option value="other_ind">USA</option>
                            </select>--%>
                            <%--<input type="radio" id="ICY" class="" name="indian_citizen" value="Y" style="margin-top: -1px;" />
                            Yes
                            <input type="radio" id="ICN" class="" name="indian_citizen" value="N" style="margin-top: -1px;" />
                            No--%>

                        <%--<td class="pad-top">Do you have a Bank Account as an Indian Citizen (Not as NRI or OCI)<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="radio" id="IBAY" class="" name="ind_bank_account" value="Y" style="margin-top: -1px;" />
                            Yes
                            <input type="radio" id="IBAN" class="" name="ind_bank_account" value="N" style="margin-top: -1px;" />
                            No
                        </td>--%>
                        <td class="pad-top">Nationality <span class="cls_mendatory_I2" style="display: block; color: Red;">*</span></td>
                        <td><select id="txt_country_dtl" class="marg-btm" onchange="changecountry()"></select></td>

                        <td class="pad-top">Do you have a Bank Account as an Indian Citizen (Not as NRI or OCI)<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="radio" id="IBAY" class="" name="ind_bank_account" value="Y" style="margin-top: -1px;" />
                            Yes
                            <input type="radio" id="IBAN" class="" name="ind_bank_account" value="N" style="margin-top: -1px;" />
                            No
                        </td>
                        
                    </tr>

                    <tr>
                        
                        <td class="pad-top" ><span id="oci_card_title">Holder of OCI Card <span class="cls_mendatory_I2" style="display: block; color: Red;">*</span></span></td>
                        <td><span id="oci_card_title1"><input type="radio" id="oci_Y" class="" name="oci_card" value="Y" style="margin-top: -1px;" />
                            Yes <input type="radio" id="oci_N" class="" name="oci_card" value="N" style="margin-top: -1px;"/> 
                            No</span></td>
                       
                       
                         <td class="pad-top"> <span id="div_upload_OCICARD">Upload OCI Card <span style="color: blue;">&nbsp;(File size should not exceed 1 MB - PDF,JPG and PNG File Only)</span><span class="cls_mendatory_I2" style="display: block; color: Red;">*</span></span></td>
                        <td><span id="div_upload_OCICARD1">
                            <div style="padding: 10px; overflow: visible; display:none;"class="panel-collapse collapse in" id="div_upload_OCICARD2">
                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload OCI Card</strong></span>
                                    <input type="file" name="OCICARDUpload" id="OCICARDUpload" onchange="javascript:return UploadOCICARDpdf();" style="display: none;" />
                                </label>
                                <span id="lbl_ocicard_file_name" style="vertical-align: super;"></span>
                            </div>
                            </span>

                        </td>
                       
                        
                        <%--<td class="pad-top">Passport No<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_passport_no" class="marg-btm" />
                        </td>--%>
                        <%--<td class="pad-top">Aadhaar No<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_aadhaar_no" class="marg-btm" />
                        </td>--%>
                    </tr>

                    <tr>
                        <td><span id="oci_card_country_title" style="display:none;">Social Security From Your Country ?</span> </td>
                         <td><span id="oci_card_country_title1" style="display:none;"><input type="radio" id="oci_country_Y" class="" name="oci_country_card" value="Y" style="margin-top: -1px;" />
                            Yes <input type="radio" id="oci_country_N" class="" name="oci_country_card" value="N" style="margin-top: -1px;"/> 
                            No</span></td>

                        <td><span id="ssn_number_title" style="display:none;">Social security number <span class="cls_mendatory_I2" style="display: block;color: Red;">*</span></span> </td>
                        <td><input type="text" id="txt_ssn_no" class="marg-btm" style="display:none;" /></td>
                    </tr>

                    <tr>
                         <td><span id="online_working_title" style="display:none;">Agree to work completely online </span> </td>
                         <td><span id="online_working_title1" style="display:none;"><input type="radio" id="online_working_Y" class="" name="online_working" value="Y" style="margin-top: -1px;" />
                            Yes <input type="radio" id="online_working_N" class="" name="online_working" value="N" style="margin-top: -1px;"/> 
                            No</span></td>

                    </tr>
                    <%--<tr>
                        <td colspan="5"><span class="cls_mendatory" style="display: none; color: Red;">*</span> <span style="color: blue;">It is a regulatory requirement to provide either Aadhar No. Or Passport No.
                            Your data is safe with us.<br />&nbsp;&nbsp;  Passport or Aadhar Card among one is compulsory.</span></td>
                    </tr>--%>
                    <tr>
                        <td colspan="5"><span class="cls_mendatory" style="display: none; color: Red;">*</span> <span style="color: blue;">Passport or Aadhar Card among one is compulsory.<br />&nbsp;&nbsp;  It is a regulatory requirement to provide either Aadhar No. Or Passport No.
                            Your data is safe with us.</span></td>
                    </tr>
                    <tr>
                        <td class="pad-top">Passport No<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_passport_no" class="marg-btm" />
                        </td>


                        <td class="pad-top">Upload Passport<span style="color: blue;">&nbsp;(File size should not exceed 1 MB - PDF,JPG and PNG File Only)</span>
                            <span class="cls_mendatory_I2" style="display: none;color: Red;">*</span>
                        </td>
                        <td>
                            <div style="padding: 10px; overflow: visible;" id="div_upload_passport" class="panel-collapse collapse in">
                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload Passport</strong></span>
                                    <input type="file" name="passportUpload" id="passportUpload" onchange="javascript:return UploadPassportpdf();" style="display: none;" />
                                </label>
                                <span id="lbl_passport_file_name" style="vertical-align: super;"></span>
                            </div>

                        </td>
                    </tr>

                    <tr>
                        <td class="pad-top">Aadhaar No<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_aadhaar_no" class="marg-btm" />
                        </td>


                        <td class="pad-top">Upload Aadhaar Card<span style="color: blue;">&nbsp;(File size should not exceed 1 MB - PDF,JPG and PNG File Only)</span>
                            <span class="cls_mendatory_I2" style="display: none;color: Red;">*</span>
                        </td>
                        <td>
                            <div style="padding: 10px; overflow: visible;" id="div_upload_aadhaar" class="panel-collapse collapse in">
                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload Aadhaar Card</strong></span>
                                    <input type="file" name="aadhaarUpload" id="aadhaarUpload" onchange="javascript:return UploadAadhaarpdf();" style="display: none;" />
                                </label>
                                <span id="lbl_aadhaar_file_name" style="vertical-align: super;"></span>
                            </div>

                        </td>
                        
                    </tr>

                    <tr id="bank_1">
                        <td class="pad-top">GST Number<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_gst_no" class="marg-btm" />
                        </td>
                        <td class="pad-top">Bank Account Number<span class="cls_mendatory_I2" id="stick_bank" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_bank_account_no" class="marg-btm" disabled/>
                        </td>


                    </tr>

                    <tr id="bank_2">

                        <td class="pad-top">Account Type<span class="cls_mendatory_I2" id="stick_account" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <%--<input type="text" id="txt_account_type" class="marg-btm"/>--%>
                            <select id="txt_account_type" class="marg-btm" disabled>
                                <option value="">-- Select Account Type --</option>
                                <option value="Saving">Saving</option>
                                <option value="Current">Current</option>
                            </select>
                        </td>
                        <td class="pad-top">Name of the Bank<span class="cls_mendatory_I2" id="stick_ban_name" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_name_of_the_bank" class="marg-btm" disabled />
                        </td>


                    </tr>

                    <tr id="bank_3">

                        <td class="pad-top">Branch Name<span class="cls_mendatory_I2" id="stick_branch_name" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_branch_name" class="marg-btm" disabled />
                        </td>
                        <td class="pad-top">IFSC Code / Swift Code<span class="cls_mendatory_I2" id="stick_ifsc" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_ifsc_code" class="marg-btm" onkeypress='return IsValidIFSC(event);' maxlength="11" disabled/>
                        </td>


                    </tr>

                    <tr>

                        <td class="pad-top" id="bank_4">Beneficiary Name as per Bank Account<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td id="bank_5">
                            <input type="text" id="txt_benificiary_name" class="marg-btm" disabled/>
                        </td>
                        <td class="pad-top">Date of Birth<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_dob" class="marg-btm" placeholder="DD/MM/YYYY"/>
                        </td>


                    </tr>

                    <tr>
                        <td class="pad-top">Highest Qualification<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <%--<input type="text" id="txt_highest_qualification" class="marg-btm"/>--%>
                            <select id="txt_highest_qualification" class="marg-btm">
                                <option value="">--Select Qualification--</option>
                                <option value='PHD'>PhD/MPhil</option>
                                <option value='PG'>Masters</option>
                                <option value='UG'>Bachelors</option>
                                <option value='HSC'>HSC</option>
                            </select>
                        </td>
                        <td class="pad-top">Total Years of Experience<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                           <%-- <input type="text" id="txt_total_experiance" class="marg-btm" onkeypress='return IsNumeric_TotalExperience(event);' maxlength="2" />--%>
                            <input type="text" id="txt_total_experiance" class="marg-btm" onkeypress='return IsNumeric_TotalExperience(event);' maxlength="2" style="width:25%" placeholder="Enter years"/>
                            <select id="txt_total_experiance_months" class="marg-btm" style="width:35%">
                                <option value="">--Select Months--</option>
                                <option value="0">0</option>
                                <option value='1'>1</option>
                                <option value='2'>2</option>
                                <option value='3'>3</option>
                                <option value='4'>4</option>
                                <option value='5'>5</option>
                                <option value='6'>6</option>
                                <option value='7'>7</option>
                                <option value='8'>8</option>
                                <option value='9'>9</option>
                                <option value='10'>10</option>
                                <option value='11'>11</option>
                                <option value='12'>12</option>
                            </select>
                        </td>


                    </tr>

                    <tr>
                        <td class="pad-top">Total Teaching Experience
                        </td>
                        <td>
                            <input type="text" id="txt_total_teaching_experiance" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="2" />
                        </td>
                        <td class="pad-top">Associated with CEPT Since(optional)<span class="cls_mendat" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <%--<input type="text" id="txt_associated_with_cept_since" class="marg-btm"/>--%>
                            <select id="txt_associated_with_cept_since" class="marg-btm"></select>
                        </td>
                        <%--<td class="pad-top">Total Research Experience
                        </td>
                        <td>
                            <input type="text" id="txt_total_research_experiance" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="2" />
                        </td>--%>
                    </tr>

                    <tr>

                        <%-- <td class="pad-top">Total Industry Experience
                        </td>
                        <td>
                            <input type="text" id="txt_total_industry_experiance" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="2" />
                        </td>--%>
                    </tr>
                    <tr>
                        <td class="pad-top">Emergency Contact Person Name<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_emergency_contact_name" class="marg-btm" />
                        </td>
                        <td class="pad-top">Emergency Contact Mobile Number<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_emergency_contact_no" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="10" />
                        </td>
                    </tr>

                    <tr>
                        <td class="pad-top">COA Registration Number <span style="color: blue; font-size: 10px;">(Council of Architecture)</span><span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_coa_reg_no" class="marg-btm" />
                        </td>
                        <td class="pad-top"> <span id="div_upload_COACARD">Upload COA Registration <span style="color: blue;">&nbsp;(File size should not exceed 1 MB - PDF,JPG and PNG File Only)</span><span class="cls_mendatory_I2" style="display: none; color: Red;">*</span></span></td>
                        <td><span id="div_upload_COACARD1">
                            <div style="padding: 10px; overflow: visible; display:block;"class="panel-collapse collapse in" id="div_upload_COACARD2">
                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload COA Registration</strong></span>
                                    <input type="file" name="COACARDUpload" id="COACARDUpload" onchange="javascript:return UploadCOACARDpdf();" style="display: none;" />
                                </label>
                                <span id="lbl_coacard_file_name" style="vertical-align: super;"></span>
                            </div>
                            </span>

                        </td>


                    </tr>


                    <tr>

                        <td class="pad-top">Permanent Address<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            <%--<p style="color: blue; font-size: 10px;">Please provide address where you are currently residing.</p>--%>
                        </td>
                        <td colspan="4">

                        </td>

                    </tr>
                    <tr>
                        <td class="pad-top">Address Line 1</td>
                    <td>
                        <input type="text" id="txt_permanent_address" class="marg-btm"  />
                    </td>
                        
                        <td class="pad-top">Address Line 2</td>
                    <td>
                        <input type="text" id="txt_permanent_address_1" class="marg-btm"  />
                    </td>
                    </tr>
                    

                    <tr>
                        <td class="pad-top">City<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_city" class="marg-btm" />
                        </td>

                        <td class="pad-top">State<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_state" class="marg-btm" />
                        </td>

                    </tr>

                    <tr>
                        <td class="pad-top">Country<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_country" class="marg-btm" />
                        </td>

                    </tr>
                    <tr>
                        <td>
                           Same As Above? <input type="checkbox" id="same_address_id" class="" name="same_address" value="Y" style="margin-top: -1px;" />
                        </td>
                    </tr>

                    <tr>

                        <td colspan="4" class="pad-top">Residing Address <span style="color: blue; font-size: 10px;">(Please Provide Address Where You Are Currently Residing.)</span><span class="cls_mendatory" style="display: none; color: Red;">*</span>
                            <%--<p style="color: blue; font-size: 10px;">Please provide address where you are currently residing.</p>--%>
                        </td>
                        <%--<td colspan="4">
                           
                        </td>--%>

                    </tr>
                    <tr>
                        <td class="pad-top">Address Line 1</td>
                    <td>
                        <input type="text" id="txt_address" class="marg-btm"  />
                    </td>
                        
                        <td class="pad-top">Address Line 2</td>
                    <td>
                        <input type="text" id="txt_address_1" class="marg-btm"  />
                    </td>
                    </tr>

                    <tr>
                        <td class="pad-top">City
                        </td>
                        <td>
                            <input type="text" id="txt_city_res" class="marg-btm" />
                        </td>

                        <td class="pad-top">State
                        </td>
                        <td>
                            <input type="text" id="txt_state_res" class="marg-btm" />
                        </td>

                    </tr>

                    <tr>
                        <td class="pad-top">Country
                        </td>
                        <td>
                            <input type="text" id="txt_country_res" class="marg-btm" />
                        </td>

                    </tr>

                </table>
            </div>

        </div>

        <div class="panel panel-default">
            <div id="references_tab">

            <div class="panel-heading">
                <b>Provide 3 References </b><span style="color: blue;">(Preferably atleast one who is/was associated with CEPT in any capacity)</span>
                <input type="button" id="btn_add_reference_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('reference');" />
            </div>

            <div style="padding: 10px; overflow: visible; display: none;" id="div_reference" class="panel-collapse collapse in">
                <table style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <td class="pad-top">Name<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_ref_name" class="marg-btm" />
                        </td>
                        <td class="pad-top">Mobile No<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_ref_mobile_no" class="marg-btm" />
                        </td>
                    </tr>

                    <tr>
                        <td class="pad-top">Email ID<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_ref_email_id" class="marg-btm" />
                        </td>
                        <%-- <td class="pad-top">Date of Issuance of Certificate<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_date_of_issuance_certificate" class="marg-btm" />
                        </td>--%>
                    </tr>
                </table>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_reference_dtl" class="panel-collapse collapse in">
                <table id="tbl_reference" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Name</th>
                        <th>Mobile No</th>
                        <th>Email ID</th>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="marg-btm" style="width: 297px;" /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 297px;" /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 297px;" /></td>
                    </tr>
                </table>
            </div>
          </div>
            <div class="panel-heading">
                <b>Academic Qualification </b><span class="cls_mendatory" style="display: block; color: Red;">*</span><span style="color: blue;"> (After 12th std.)</span>
                <input type="button" id="btn_add_academic_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('academic');" />
            </div>

            <div style="padding: 10px; overflow: visible; display: none;" id="div_academic_qualification" class="panel-collapse collapse in">
                <table style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <td class="pad-top">Degree<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_degree" class="marg-btm" />
                        </td>
                        <td class="pad-top">Specialization/Field (if applicable)<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_specialization" class="marg-btm" />
                        </td>
                    </tr>

                    <tr>
                        <td class="pad-top">University / Institute<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_university" class="marg-btm" />
                        </td>
                        <%-- <td class="pad-top">Date of Issuance of Certificate<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_date_of_issuance_certificate" class="marg-btm" style="display:none;"/>
                        </td>--%>
                    </tr>

                    <tr>
                        <td class="pad-top">Start Date<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_edu_start_date" class="marg-btm" />
                        </td>
                        <td class="pad-top">End Date<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_edu_end_date" class="marg-btm" />
                        </td>
                    </tr>

                    <tr>
                        <td class="pad-top">Percentage/ Division<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_edu_percentage" class="marg-btm" />
                        </td>
                        <td class="pad-top">Mode<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_edu_mode" class="marg-btm" />
                        </td>
                    </tr>
                  

                </table>
            </div>

            <div style="padding: 10px; overflow: auto;" id="div_academic_qualification_dtl" class="panel-collapse collapse in">
                <table id="tbl_academic_qualification" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Program</th>
                        <th>Degree</th>
                        <th>Specialization/Field (if applicable)</th>
                        <th>University/Institute</th>
                        <%--<th style="display:none;">Date of Issuance of Certificate</th>--%>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Percentage/CGPA</th>
                        <th>Percentage/ Division</th>
                        <th>Mode</th>
                        <th>Delete</th>
                    </tr>
                    <tr>
                         <td>
                            <select class="program_type1" style="width: 110px;">
                                <option value="">Please Select Mode Type</option>
                                <option value="1">UG</option>
                                <option value="2">PG</option>
                                <option value="3">Doctoral</option>
                            </select>
                        </td>
                        <td>
                            <input type="text" class="marg-btm" /></td>
                        <td>
                            <input type="text" class="marg-btm" /></td>
                        <td>
                            <input type="text" class="marg-btm" /></td>
                        <%-- <td>
                            <input type="text" class="cls_date" placeholder="DD/MM/YYYY" style="display:none;"/>
                        </td>--%>
                        <td>
                            <input type="text" id="startDate_1" class='date-picker' placeholder="MM/YYYY" style="width: 80px;"/></td>
                        <td>
                            <input type="text" id="endDate_1" class='date-picker' placeholder="MM/YYYY" style="width: 80px;"/></td>
                        <td>
                            <select class="per_cgpa_type" style="width: 110px;">
                                <option value="">Please Select Type</option>
                                <option value="Percentage">Percentage</option>
                                <option value="CGPA">CGPA</option>
                            </select>
                        </td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 80px;"/></td>
                        <td>
                            <select class="mode_type" style="width: 110px;">
                                <option value="">Please Select Mode Type</option>
                                <option value="Regular">Regular (Full-time)</option>
                                <option value="Part-time">Part-time</option>
                                <option value="Distance Learning">Distance Learning</option>
                            </select>
                        </td>
                        <td></td>
                    </tr>
                </table>
            </div>

        </div>

        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Work Experience </b><span class="cls_mendatory" style="display: block; color: Red;">*</span>
                <span style="color: blue;">(Please start attaining after your graduation)</span>
                <input type="button" id="btn_add_work_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('work');" />
            </div>

            <div style="padding: 10px; overflow: visible; display: none;" id="div_work_experiance" class="panel-collapse collapse in">
                <table style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <td class="pad-top">
                            <%--Designation<span class="cls_mendatory" style="display:none;color:Red;">*</span>--%>
                            Grade<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_work_designation" class="marg-btm" />
                        </td>
                        <td class="pad-top">Name of Institute / Organization<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_work_institute" class="marg-btm" />
                        </td>
                    </tr>

                    <tr>
                        <td class="pad-top">Start Date (month & year)<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_work_start_date" class="marg-btm" />
                        </td>
                        <td class="pad-top">End Date (month & year)<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_work_end_date" class="marg-btm" />
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 10px; overflow: auto;" id="div_work_experiance_dtl" class="panel-collapse collapse in">
                <table id="tbl_work_experiance" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <%--<th>Designation</th>--%>
                        <%--<th>Grade</th>--%>
                        <th>Name of Institute / Organization</th>
                        <th>Designation</th>
                        <th>Experience Type</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Total Duration in Months</th>
                        <th>Mode</th>
                        <th>Total no of hours per week</th>
                        <th>Year and Month</th>
                        <th class="workexperiencehide">Upload WorkExperience Certificate</th>
                        <th>Delete</th>
                       <%-- <th colspan="2">Total Work Experience (in Years-Months)</th>--%>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="marg-btm" style="width: 180px;" /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 120px;" /></td>
                        <td>
                            <select class="experience_type" style="width: 140px;">
                                <option value="">Please Select Experience Type</option>
                                <option value="Teaching">Teaching</option>
                                <option value="Research">Research</option>
                                <option value="Industry">Industry</option>
                            </select>
                        </td>
                        <td>
                            <input type="text" class="cls_date start_date" id="start_0" style="width: 120px;" placeholder="DD/MM/YYYY" /></td>
                        <td>
                            <input type="text" class="cls_date end_date" id="end_0" style="width: 120px;" placeholder="DD/MM/YYYY" /></td>
                        <td>
                            <input type="text" id="dur_0" class="cls_duration" style="width: 125px;" disabled />
                        </td>
                         <td>
                            <select class="work_mode_type" id ='mode_type_0' style="width: 110px;">
                                <option value="">Please Select Mode Type</option>
                                <option value="Fulltime">Full-time</option>
                                <option value="Parttime">Part-time</option>
                                <option value="Remote">Remote</option>
                            </select>
                        </td>
                        <td><input type="text" class="marg-btm onchangetext" id='total_hrs_0' style="width: 120px;" /></td>

                        <%--<span>Month <input type="number" name="quantity" min="1" max="12"  id="txt_experiance_month" style="width:40px;display:inline;"/></span>--%>
                        <%--<td></td>
                         <td></td>--%>
                        <td><span id='year_month_0'></span></td>
                        <td class="workexperiencehide"><label class='btn btn-primary file-upload' style='vertical-align: bottom;vertical-align: bottom;width: 100px;padding: 0px;margin-left: 25px'><span><strong>Upload</strong></span>
                        <input type = 'file' name = 'experienceupload' class='experienceupload' id = 'experienceupload_0' onchange = 'javascript: return UploadWorkExperienceCertificate(this);' /></label>
                         <span class='lbl_experience_file_name_0'></span>
                        </td>
                        <td></td>
                        
                    </tr>
                </table>
                <div> <span>Total Work Experience (in Years-Months) : </span><span><input type="number" name="quantity" min="0" max="100" id="txt_experiance_year" style="width:60px;display:inline;" placeholder="Year" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 100)" disabled />
                <input type="number" name="quantity" min="0" max="12" id="txt_experiance_month" style="width:60px;display:inline;" placeholder="Month"  onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc_2(this.value, 0, 12)" disabled /> </span></div>
            </div>

        </div>


        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Honors / Awards / Achievements</b>
                <span style="color: blue;">&nbsp;(MAX 150 Words)</span>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_achievements" class="panel-collapse collapse in">
                <div class="row" style="margin-top: 15px;">
                    <%--<div class="form-group col-md-2 color-blue">
                        Course Description : <br/> (Max. 400 Characters)<span class="cls_mendatory" style="display:none;color:Red;">*</span>
                    </div>--%>
                    <div class="form-group col-md-11">
                        <textarea id="txt_achievements" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="achievements"></textarea>
                        <%--<span id="spn_desc" style="float:right;margin-bottom:10px;">total char : 0</span>--%>
                    </div>
                </div>
            </div>

        </div>

        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Areas of Specialization</b>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_area_of_interest" class="panel-collapse collapse in">
                <div class="row" style="margin-top: 15px;">
                    <%--<div class="form-group col-md-2 color-blue">
                        Course Description : <br/> (Max. 400 Characters)<span class="cls_mendatory" style="display:none;color:Red;">*</span>
                    </div>--%>
                    <div class="form-group col-md-11">
                        <textarea id="txt_area_of_interest" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="area_of_interest"></textarea>
                        <%--<span id="spn_desc" style="float:right;margin-bottom:10px;">total char : 0</span>--%>
                    </div>
                </div>
            </div>

        </div>

        <%--kapil08062020--%>
        <div class="panel panel-default">
            <div class="panel-heading">
                <b>Brief Description (Education & Work Profile)</b>
                <span style="color: blue;">&nbsp;(MAX 150 Words)</span>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_eduction_dtl" class="panel-collapse collapse in">
                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-11">
                        <textarea id="txt_eduction_dtl" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="eduction_dtl"></textarea>
                    </div>
                </div>
            </div>
        </div>


        <div class="panel panel-default" id="main_div_crdf" style="display:none;">
            <div class="panel-heading">
                <b>CRDF</b>
            </div>
            <div style="padding: 10px; overflow: visible;" id="div_crdf_dtl" class="panel-collapse collapse in">
                <p style="font-weight:bold; margin-bottom:20px;">Do you have an ongoing or proposed engagement with the CEPT Research and Development Foundation (CRDF) ?
                 <span id="crdf_ques"><input type="radio" id="crdf_Y" class="" name="crdf_ques" value="Y" style="margin-top: -1px;" />  Yes <input type="radio" id="crdf_N" class="" name="crdf_ques" value="N" style="margin-top: -1px;"/>  No</span></p> 
                <div id="crdf_dtl" style="display:none;">
                    <table style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                            <td>CRDF Code</td>
                            <td><input type="text" id="txt_crdf_code" class="marg-btm" /></td>
                            <td>Engagement Status</td>
                            <td>
                                <select id="drp_engagement_status" class="marg-btm">
                                <option value="">--Select Engagement Status--</option>
                                <option value="Ongoing">Ongoing</option>
                                <option value="Proposed">Proposed</option>
                                <option value="Passed">Passed</option>
                            </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Nature of Engagement</td>
                            <td><select id="drp_nature_engagement_status" class="marg-btm" onchange="changenature_time()">
                                <option value="">--Select Nature of Engagement--</option>
                                <option value="Full Time">Full Time</option>
                                <option value="Part Time">Part Time</option></td>
                            <td>Contract Period</td>
                            <td>
                                <span>From <input type="text" id="txt_contract_from_date" class=" cls_date marg-btm"  style="width:70px;" placeholder="DD/MM/YYYY" /> To <input type="text" id="txt_contract_to_date" style="width:70px;"" placeholder="DD/MM/YYYY"  class=" cls_date marg-btm" /></span>
                            </td>
                        </tr>
                            <tr class="part_time_div"  style="display:none;">
                            
                            <td>Engagement Hours per week as per contract</td>
                            <td><input type="text" id="txt_eng_hourse" class="marg-btm" /></td>
                            <td>Name of Centre </td>
                            <td><input type="text" id="txt_center_name" class="marg-btm" /></td>
                       
                            </tr>
                        
                            <tr class="part_time_div_1" style="display:none;">
                           
                            <td >Reporting to</td>
                            <td ><input type="text" id="txt_reporting_to" class="marg-btm" /></td>
                            
                        </tr>
                       
                         
                    </table>
                </div>
            </div>
        </div>


        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Upload CV </b><span class="" id="tutor_show" style="color: Red;">*</span>
                <span style="color: blue;">&nbsp;(File size should not exceed 2 MB - PDF File Only)&nbsp; <span style="color: red;">Upload your latest CV as the remuneration (rate band) will be calculated based on information available on CV.</span> </span>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_upload_cv" class="panel-collapse collapse in">
                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                    <span><strong>Upload CV</strong></span>
                    <input type="file" name="cvUpload" id="cvUpload" onchange="javascript:return UploadProfilePhoto();" style="display: none;">
                </label>
                <span id="lbl_cv_file_name" style="vertical-align: super;"></span>
            </div>

        </div>

        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Upload Portfolio </b><span class="" id="tutor_portfolio_hide" style="color: Red;">*</span>
                <span style="color: blue;">&nbsp;(File size should not exceed 50 MB - PDF File Only)</span>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_upload_port" class="panel-collapse collapse in">
                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                    <span><strong>Upload Portfolio</strong></span>
                    <input type="file" name="portUpload" id="portUpload" onchange="javascript:return UploadPortfolioPhoto();" style="display: none;" />
                </label>
                <span id="lbl_port_file_name" style="vertical-align: super;"></span>
            </div>

        </div>


         <div class="panel panel-default" id="under_mark" style="display:none;">

            <div class="panel-heading">
                <b>UNDERTAKING </b><span class="" style="color: Red;">*</span>
                <span style="color: blue;">&nbsp;</span>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_question_dtl" class="panel-collapse collapse in">
                <p>I the undersigned hereby acknowledge that all the information given in this form is correct and true to best of my knowledge. I fully understand that the acceptance of this application does not mean any confirmation of 
                   engagement. I understand that I may be asked to provide substantiation for the information provided through this form. I also understand that any false or contradictory statement may disqualify me for engagement in this 
                   University. It may, in case I am engaged, further result in dismissal or termination of my contract without notice or compensation. I as well understand that the confirmation of my engagement will be subject to my successfully meeting the required selection criteria as established by the University, and signing of the engagement contract
                   after due process.</p><br/><br/>
                <p style="color: blue;">I Agree that:</p>
                <div id="indian_country" style="display:block;">
                     <span class="q1"><input type="checkbox" id="q1" style="margin-top: -1px;"/>  <span><b> I will be paid ONLY in my name, and not in the name of any other entity.</b></span><br/><br /></span>
                     <span class="q2"><input type="checkbox" id="q2" style="margin-top: -1px;"/>  <span><b> I shall submit with this application the copy of passport attesting my nationality.</b></span></span><br/><br />
                    <span class="q7"><input type="checkbox" id="q7" style="margin-top: -1px;"/>  <span><b>I shall provide my services as per the prevailing laws of india and policies of CEPT University.</b></span></span><br/><br />
                </div>
                <div id="only_oci_user" style="display:none;">
                    <span class="q3"><input type="checkbox" id="q3" style="margin-top: -1px;"/>  <span><b>I Shall submit the copy of my OCI Card With this application.</b></span></span><br/><br />
                </div>
                <div id="only_crdf_user" style="display:none;">
                <span class="q6"><input type="checkbox" id="q6" style="margin-top: -1px;"/>  <span><b>I have taken consent from the centre head to take up this assignment.</b></span></span><br/><br />
                </div>
                <div id="only_other_country" style="display:none;">
                    <span class="q4"><input type="checkbox" id="q4" style="margin-top: -1px;"/>  <span><b>I Shall only provide my services completely online from my own country.</b></span></span><br/><br />
              <span class="q5"><input type="checkbox" id="q5" style="margin-top: -1px;"/>  <span><b>I am not authorised to work in india through this engagement.</b></span></span><br/><br />
                </div>

             
             
              
              
              
              
               <%-- <span id="oci_card_title1"><input type="radio" id="oci_Y" class="" name="oci_card" value="Y" style="margin-top: -1px;" />
                            Yes <input type="radio" id="oci_N" class="" name="oci_card" value="N" style="margin-top: -1px;"/> 
                            No</span>--%>
            </div>

        </div>

        <%--//new kapil 13092021--%>

        <%--            <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Upload Passport </b><span class="" style="color: Red;">*</span>
                <span style="color: blue;">&nbsp;(File size should not exceed 1 MB - PDF,JPG and PNG File Only)</span>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_upload_passport" class="panel-collapse collapse in">
                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                    <span><strong>Upload Passport</strong></span>
                    <input type="file" name="passportUpload" id="passportUpload" onchange="javascript:return UploadPassportpdf();" style="display: none;" />
                </label>
                <span id="lbl_passport_file_name" style="vertical-align: super;"></span>
            </div>

        </div>--%>

        <%-- <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Upload OCI Card </b><span class="" style="color: Red;">*</span>
                <span style="color: blue;">&nbsp;(File size should not exceed 1 MB - PDF,JPG and PNG File Only)</span>
            </div>
            <br />
            <div style="margin-left:13px;font-weight: bold; margin-bottom:11px;">
             <span>Holder of OCI Card, if Foreign National.</span> <input type="radio" id="oci_Y" class="" name="oci_card" value="Y" style="margin-top: -1px;" />
             Yes
             <input type="radio" id="oci_N" class="" name="oci_card" value="N" style="margin-top: -1px;" checked />
             No
            </div>

            <div style="padding: 10px; overflow: visible; display:none;" id="div_upload_OCICARD" class="panel-collapse collapse in" >
                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                    <span><strong>Upload OCI Card</strong></span>
                    <input type="file" name="OCICARDUpload" id="OCICARDUpload" onchange="javascript:return UploadOCICARDpdf();" style="display: none;" />
                </label>
                <span id="lbl_ocicard_file_name" style="vertical-align: super;"></span>
            </div>

        </div>--%>
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
    <asp:HiddenField ID="studio_submit_dtl" runat="server" ClientIDMode="Static" />
    <asp:HiddenField ID="inst_work_load_dtl" runat="server" ClientIDMode="Static" />
    <script type="text/javascript">


        $('#pdclick').click(function (e) {
            var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
            window.open(url, "_self");
        });
        $('#bdclick').click(function (e) {
            if ($("#hdn_tutor_type").val() == "temp") {
                return false;
            } else {
                var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
                window.open(url, "_self");
            }
        });
        $('#tutor_disabled').click(function (e) {
            if ($("#hdn_tutor_type").val() == "temp") {
                return false;
            }
        });
        $('#sp_disabled').click(function (e) {
            if (block) {
                return false;
            }
        });
        $('#lp_disabled').click(function (e) {
            if (block) {
                return false;
            }
            else
            {
               // var url = "Interested_Program.aspx";
               // window.open(url, "_self");
            }
            
        });
        $('#tbl_academic_qualification tbody tr td i.icon-trash').live('click', function (e) {
            var rowCount = $('#tbl_academic_qualification tr').length;
            console.log(rowCount);
            if (rowCount > 2)
            {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {

                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;
                }
            }
            
        });

        $('#tbl_work_experiance tbody tr td i.icon-trash').live('click', function (e) {
            var rowCount = $('#tbl_work_experiance tr').length;
            console.log(rowCount);
            if (rowCount > 2) {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {

                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;
                }
            }

        });
    </script>

     <script type="text/javascript">
         $(document).ready(function () {
             $('.work_mode_type').change(function () {
                 var selectedValue = $(this).val();
                 var inputElement = $(this).closest('td').next().find('.onchangetext');
                 if (selectedValue == 'Fulltime') {
                     inputElement.val('40');
                 }
                 else
                 {
                     inputElement.val('20');
                 }

             });
         });
     </script>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_tutor_type" value="" />
    
   
</asp:Content>

