<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="personal_detail_sws.aspx.cs" Inherits="Admin_Master_personal_detail_sws" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../../Js/personal_detail_sws.js" type="text/javascript"></script>
<%--    <link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet" />--%>

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
    </style>
    <%--<style>
        .card {
            position: relative;
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-orient: vertical;
            -webkit-box-direction: normal;
            -ms-flex-direction: column;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 0.10rem
        }

        .card-header:first-child {
            border-radius: calc(0.37rem - 1px) calc(0.37rem - 1px) 0 0
        }

        .card-header {
            padding: 0.75rem 1.25rem;
            margin-bottom: 0;
            background-color: #fff;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1)
        }

        .track {
            position: relative;
            background-color: #ddd;
            height: 7px;
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            margin-bottom: 60px;
            margin-top: 50px
        }

            .track .step {
                -webkit-box-flex: 1;
                -ms-flex-positive: 1;
                flex-grow: 1;
                width: 25%;
                margin-top: -18px;
                text-align: center;
                position: relative
            }

                .track .step.active:before {
                    background: #FF5722
                }

                .track .step::before {
                    height: 7px;
                    position: absolute;
                    content: "";
                    width: 100%;
                    left: 0;
                    top: 18px
                }

                .track .step.active .icon {
                    background: #ee5435;
                    color: #fff
                }

            .track .icon {
                display: inline-block;
                width: 40px;
                height: 40px;
                line-height: 40px;
                position: relative;
                border-radius: 100%;
                background: #ddd
            }

            .track .step.active .text {
                font-weight: 400;
                color: #000
            }

            .track .text {
                display: block;
                margin-top: 7px
            }

        .itemside {
            position: relative;
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            width: 100%
        }

            .itemside .aside {
                position: relative;
                -ms-flex-negative: 0;
                flex-shrink: 0
            }

        .img-sm {
            width: 80px;
            height: 80px;
            padding: 7px
        }


        .btn-warning {
            color: #ffffff;
            background-color: #ee5435;
            border-color: #ee5435;
            border-radius: 1px
        }

            .btn-warning:hover {
                color: #ffffff;
                background-color: #ff2b00;
                border-color: #ff2b00;
                border-radius: 1px
            }
    </style>--%>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid" id="for_other" style="display: none;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Edit Personal Details 
            </h1>
        </div>
    </div>
    <%--old code--%>
    <div class="row" style="margin-top: 11px; width: 100%; border: 0px solid rgba(113, 112, 112, 1); background-color: rgba(255, 255, 255, 1); border-radius: 0; box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6); margin-left: 1px; display: block;margin-bottom: 10px;" id="for_I2">
        <h5 class="font_8" style="margin-left: 5px; font-size: 18px; margin-top: 3px;">Personal Details And Add SWS New Course</h5>
        <div style="margin-left: 1%; border-top: 1px solid #c2c2c2ab; width: 97.8%;"></div>
        <ol class="show-grid col-md-8 col-md-offset-2" style="margin-left: -8px; width: 100%; margin-bottom: 10px; margin-top: 5px;">
            <span style="font-size: 10pt; text-shadow: 0 0 slateblue;">Step 1 : For Creating a New Course Personal Details must be submit by instructor.</span></br>
             <span style="font-size: 10pt; text-shadow: 0 0 slateblue;">Step 2 : Fill up the Course details.</span></br>
             <span style="font-size: 10pt; text-shadow: 0 0 slateblue;">Step 3 : Click on the Submit. </span></br>
            <span style="font-size: 10pt; text-shadow: 0 0 slateblue; color: red;">Note: 1. You can not change once you final Submit Course Details.</span></br>
            <span style="font-size: 10pt; text-shadow: 0 0 slateblue; color: red;">Note: 2. You can not enter more than one course.</span></br></br>
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
                            <a href="" id="lp_disabled" style="color: black;">Create a New course</a>

                        </div>
                    </div>
                </li>
                <li class="col-md-3 active" id="sd" style="width: 28% !important; display: none;">
                    <div class="media">
                        <div class="pull-left" href="#">
                            <span class="glyphicon glyphicon-dashboard"></span>
                        </div>
                        <div class="media-body">
                            <h5 class="media-heading"><strong>Step 3:</strong></h5>
                            <a href="Studio_Details.aspx" id="sp_disabled" style="color: black;">Studio Proposal Details</a>

                        </div>
                    </div>
                </li>
            </div>
        </ol>
    </div>


    <div class="well" style="background-color: White; margin-top: 1%;">

        <div id="div_filter_criteria" class="panel panel-default" style="display: none;" >
            <div class="panel-heading">
                <strong>Personal Details And Add SWS New Course</strong>
            </div>
            <div>
                <div>
                    <div>
                        <%--new--%>
                        <div class="card-body">
                            <div style="padding-left:10px;">
                                <span style="font-size: 10pt; text-shadow: 0 0 slateblue;">Step 1 : For Creating a New Course Personal Details must be submit by instructor.</span></br>
                                 <span style="font-size: 10pt; text-shadow: 0 0 slateblue;">Step 2 : Fill up the Course details.</span></br>
                                 <span style="font-size: 10pt; text-shadow: 0 0 slateblue;">Step 3 : Click on the Submit. </span>
                                
                            </div>
                            <div class="track">
                                <div class="step active" id="p1"><span class="icon"><i class="fa fa-user" style="padding-top: 12px;"></i></span><span class="text">Personal Details</span> </div>
                                <div class="step" id="p2"><span class="icon"><i class="fa fa-check" style="padding-top: 12px;"></i></span><span class="text">Create a New course</span> </div>
                            </div>
                            <div style="padding-left:10px;">
                                <span style="font-size: 10pt; text-shadow: 0 0 slateblue; color: blue;">Note: 1. You can not change once you final Submit Course Details.</span></br>
                                <span style="font-size: 10pt; text-shadow: 0 0 slateblue; color: blue;">Note: 2. You can not enter more than one course.</span></br></br>
                            </div>
                        </div>

                        <%--end--%>
                        <%-- <table border="0" cellpadding="10" cellspacing="5">
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
                        </table>--%>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-default ">
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
                <b>Edit Personal Details</b>
                <%--<p style="color: blue;">
                    Note: Bank Details will be later enabled for approved studios.
                </p>--%>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_personal_detail" class="panel-collapse collapse in">
                <table style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <td class="pad-top">VF Code<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
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
                        <td class="pad-top">Blood Group<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
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
                        <td class="pad-top">PAN No<span class="cls_mendatory_I2" style="display: block; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_pan_card_no" class="marg-btm" />
                        </td>



                    </tr>

                    <tr>

                       <%-- <td class="pad-top">Are you a Citizen of India?<span class="" style="display: block; color: Red;">*</span>
                            <p style="color: blue; font-size: 10px;">
                                If yes, enter your passport no.<br />
                                Otherwise, Please mention your Aadhar Card No.
                            </p>
                        </td>
                        <td>
                            <input type="radio" id="ICY" class="" name="indian_citizen" value="Y" style="margin-top: -1px;" />
                            Yes
                            <input type="radio" id="ICN" class="" name="indian_citizen" value="N" style="margin-top: -1px;" />
                            No
                        </td>--%>
                        <td class="pad-top">Nationality <span class="cls_mendatory_I2" style="display: block; color: Red;">*</span></td>
                        <td><select id="txt_country_dtl" class="marg-btm" ></select></td>
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

                        <td class="pad-top">Passport No<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_passport_no" class="marg-btm" />
                        </td>
                        <td class="pad-top">Aadhaar No<span class="cls_mendatory_I2" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_aadhaar_no" class="marg-btm" />
                        </td>



                    </tr>

                    <tr>
                        <td class="pad-top">GST Number<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_gst_no" class="marg-btm" />
                        </td>
                        <td class="pad-top">Bank Account Number<span class="cls_mendatory_I2" id="stick_bank" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_bank_account_no" class="marg-btm" />
                        </td>


                    </tr>

                    <tr>

                        <td class="pad-top">Account Type<span class="cls_mendatory_I2" id="stick_account" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <%--<input type="text" id="txt_account_type" class="marg-btm"/>--%>
                            <select id="txt_account_type" class="marg-btm">
                                <option value="">-- Select Account Type --</option>
                                <option value="Saving">Saving</option>
                                <option value="Current">Current</option>
                            </select>
                        </td>
                        <td class="pad-top">Name of the Bank<span class="cls_mendatory_I2" id="stick_ban_name" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_name_of_the_bank" class="marg-btm" />
                        </td>


                    </tr>

                    <tr>

                        <td class="pad-top">Branch Name<span class="cls_mendatory_I2" id="stick_branch_name" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_branch_name" class="marg-btm" />
                        </td>
                        <td class="pad-top">IFSC Code<span class="cls_mendatory_I2" id="stick_ifsc" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_ifsc_code" class="marg-btm" onkeypress='return IsValidIFSC(event);' maxlength="11" />
                        </td>


                    </tr>

                    <tr>

                        <td class="pad-top">Beneficiary Name as per Bank Account<span class="cls_mendatory_I2" style="display: block; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_benificiary_name" class="marg-btm" />
                        </td>
                        <td class="pad-top">Date of Birth<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_dob" class="marg-btm" placeholder="DD/MM/YYYY" />
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
                        <td class="pad-top">Coa Registration Number<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_coa_reg_no" class="marg-btm" />
                        </td>
                        <td class="pad-top">City<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_city" class="marg-btm" />
                        </td>


                    </tr>

                    <tr>

                        <td class="pad-top">State<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_state" class="marg-btm" />
                        </td>
                        <td class="pad-top">Country<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_country" class="marg-btm" />
                        </td>
                    </tr>

                    <tr>

                        <td class="pad-top">Address<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_address" class="marg-btm" />
                        </td>

                    </tr>

                </table>
            </div>

        </div>

        <div class="panel panel-default ">

            <div class="panel-heading">
                <%--<span class="cls_mendatory" style="display: none; color: Red;">*</span>--%>
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

            <div class="panel-heading">
                <b>Academic Qualification </b><span class="cls_mendatory" style="display: block; color: Red;">*</span>
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
                        <td class="pad-top">Date of Issuance of Certificate<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_date_of_issuance_certificate" class="marg-btm" />
                        </td>
                    </tr>
                </table>
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_academic_qualification_dtl" class="panel-collapse collapse in">
                <table id="tbl_academic_qualification" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Degree</th>
                        <th>Specialization/Field (if applicable)</th>
                        <th>University / Institute</th>
                        <th>Date of Issuance of Certificate</th>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" class="marg-btm" /></td>
                        <td>
                            <input type="text" class="marg-btm" /></td>
                        <td>
                            <input type="text" class="marg-btm" /></td>
                        <td>
                            <input type="text" class="cls_date" placeholder="DD/MM/YYYY" /></td>
                    </tr>
                </table>
            </div>

        </div>

        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Work Experience </b><span class="cls_mendatory" style="display: block; color: Red;">*</span>
                <span style="color: blue;">(Please start from your year of Graduation)</span>
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

            <div style="padding: 10px; overflow: visible;" id="div_work_experiance_dtl" class="panel-collapse collapse in">
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
                            <input type="text" class="cls_date start_date" style="width: 120px;" placeholder="DD/MM/YYYY" /></td>
                        <td>
                            <input type="text" class="cls_date end_date" style="width: 120px;" placeholder="DD/MM/YYYY" /></td>
                        <td>
                            <input type="text" class="cls_duration" style="width: 125px;" disabled /></td>
                    </tr>
                </table>
            </div>

        </div>


        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Honors / Awards / Achievements</b>
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
            </div>

            <div style="padding: 10px; overflow: visible;" id="div_eduction_dtl" class="panel-collapse collapse in">
                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-11">
                        <textarea id="txt_eduction_dtl" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="eduction_dtl"></textarea>
                    </div>
                </div>
            </div>
        </div>


        <div class="panel panel-default ">

            <div class="panel-heading">
                <b>Upload CV </b><span class="" style="color: Red;">*</span>
                <span style="color: blue;">&nbsp;(File size should not exceed 2 MB - PDF File Only)</span>
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
                <b>Upload Portfolio </b><span class="" style="color: Red; display: none;">*</span>
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
    <script type="text/javascript">
        $('#pdclick').click(function (e) {
            var url = "personal_detail_sws.aspx?ws=" + $("#hdnuserid").val();
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
            disable_user();
            if (block) {
                return false;
            }
        });
        function disable_user() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_disable_user_detail",
                data: "{user_id:'" + $('#hdn_user_id').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        $('#hdn_status').val('true');
                       
                    }
                    else { $('#hdn_status').val('false');}
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
    </script>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_tutor_type" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_user_id" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_status" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_message" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_designation" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_skip_personaldtl" value="" />

</asp:Content>

