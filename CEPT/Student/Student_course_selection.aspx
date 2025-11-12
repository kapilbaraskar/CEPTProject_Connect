<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Student_course_selection.aspx.cs" Inherits="Student_Student_course_selection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <%-- <link href="../DesignCss/application.css" rel="stylesheet" type="text/css" />--%>
    <link href="../DesignCss/bootstrap-switch.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/jquery.multi-select.js" type="text/javascript"></script>
    <script src="../DesignJS/application.js" type="text/javascript"></script>
    <script src="../Js/student_course_selection.js?t=11072025" type="text/javascript"></script><%--05072019--%><%--10072019--%><%--17122019--%><%--25122019--%><%--29062020--%><%--18072020--%>
    <script src="../Js/general.js" type="text/javascript"></script>
    <script src="../DesignJS/bootstrap-switch.js" type="text/javascript"></script>
    <link href="../DesignCss/jquery-ui.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        $(function () {
            //if ('<%= Session["dept_code"] %>' == '3') {
            //    $('#btnonlinepayment').prop("disabled", true);
            //}
            //else {
            //    $('#btnonlinepayment').prop("disabled", false);
            //}

            //|| '<%= Session["UserId"] %>' == 'pt1admin'
            //|| '<%= Session["UserId"] %>' == 'pt2admin'
            //|| '<%= Session["UserId"] %>' == 'pt3admin'
            //|| '<%= Session["UserId"] %>' == 'pt4admin'
            //|| '<%= Session["UserId"] %>' == 'ucadmin'
            //|| '<%= Session["UserId"] %>' == 'uiadmin'
            //|| '<%= Session["UserId"] %>' == 'upadmin'

            //if ('<%= Session["UserId"] %>' == 'uiadmin' || '<%= Session["UserId"] %>' == 'ucadmin') 
            //{
            //    $('#div_buttons').css("display", "block");
            //}
            //else {
            //    $('#div_buttons').css("display", "none");
            //}

            //$.fn.dataTableExt.afnFiltering.push(
            //    function (oSettings, aData, iDataIndex) {
            //        var nTr = oSettings.aoData[iDataIndex].nTr;
            //        // test for property on nTr
            //        return true; // or false as required
            //    }
            //);
            //alert('Hi');
            //alert($('.search_init').val(''));
            //$('.search_init').val('');
            //alert($('.search_init').val(''));

            ////$('#mandatory_course').multiSelect(

            ////{
            ////    selectableHeader: "<div class='custom-header'>Please Select Course</div>",
            ////    selectionHeader: "<div class='custom-header'>Selected Course</div>"
            ////}
            ////);

            //New development Check status for

           // bootbox.alert('Hii');
           
        });
    </script>

    <style type="text/css">
        .gpa, .preference_gpa {
            width: 48px;
        }

        .priority, .preference_priority {
            width: 48px;
        }

        tfoot {
            display: table-header-group;
        }

        .copyright {
            font-size: 12px;
            background: rgba(129,193,229,0.8);
            position: fixed;
            bottom: 0px;
            z-index: 11;
            margin-top: 10px;
        }

            .copyright p {
                color: #dadada;
            }

            .copyright a {
                margin: 0 5px;
                color: #72c02c;
            }

                .copyright a:hover {
                    color: #a8f85f;
                    -webkit-transition: all 0.4s ease-in-out;
                    -moz-transition: all 0.4s ease-in-out;
                    -o-transition: all 0.4s ease-in-out;
                    transition: all 0.4s ease-in-out;
                }

            .copyright .span8 {
                padding-top: 15px;
            }

            .copyright .span4 {
                padding-top: 10px;
            }

        .prog_image_anim {
            -webkit-animation: progress-bar-stripes 4s linear infinite;
            background-image: -webkit-linear-gradient(44deg,rgba(255,255,255,.15) 25%,transparent 25%,transparent 50%,rgba(255,255,255,.15) 50%,rgba(255,255,255,.15) 75%,transparent 75%,transparent);
            background-size: 40px 40px;
        }

        .col-md-9 {
            padding-left: 0;
        }

        .col-md-2 {
            width: 18% !important;
            padding-right: 0;
        }

        .courseimg {
            height: 100px;
            /*width: 150px;*/
        }

        #img1, #img2 {
            height: 200px;
        }

        #mainimg {
            margin-bottom: 16px;
        }

        .pddltrt {
            padding-left: 0px;
            padding-right: 0px;
        }

        .weekrow {
            margin-left: 103px;
            margin-bottom: 3px;
        }

        .cls_div_img {
            z-index: 1000;
            float: left;
            margin-right: 5px;
        }

            .cls_div_img:hover {
                z-index: 1001;
            }

        .cls_img_up:hover {
            -ms-transform: scale(2.2); /* IE 9 */
            -webkit-transform: scale(2.2); /* Safari 3-8 */
            transform: scale(2.2);
        }

            .cls_img_up:hover ~ div {
                -ms-transform: scale(3.0); /* IE 9 */
                -webkit-transform: scale(3.0); /* Safari 3-8 */
                transform: scale(3.0);
                position: absolute;
                margin-top: 140px;
                background: #cac3c4;
                font-size: 7px;
                padding: 0 10px;
            }

        .below-caption {
            display: none;
        }

        .cls_img_below:hover {
            -ms-transform: scale(3.0); /* IE 9 */
            -webkit-transform: scale(3.0); /* Safari 3-8 */
            transform: scale(3.0);
        }

            .cls_img_below:hover ~ div {
                -ms-transform: scale(2.0); /* IE 9 */
                -webkit-transform: scale(2.0); /* Safari 3-8 */
                transform: scale(2.0);
                position: absolute;
                margin-top: 110px;
                background: #cac3c4;
                font-size: 7px;
                padding: 0 10px;
                display: block;
            }

        .align_text {
            text-align: justify;
        }

        .cls_tab_a {
            display: none !important;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="modal hide fade" id="my_outline" style="margin-left: -442px; width: 70%; overflow: auto; height: 82%;">
        <button style="float: right" class="btn btn-lg btn-primary" id="btn_print_outline">Print outline</button>
        <div class="panel panel-default" id="my_print_outline" style="margin-bottom: 150px;" runat="server" clientidmode="Static">
            <div class="panel-heading">
                <div id="head_data"></div>
            </div>

            <div class="panel-body">
                <div class="row" style="margin-bottom: 10px">
                    <div class="form-group col-md-2 color-blue">
                        <b>Detailed Course Outline :</b>
                    </div>
                    <div class="form-group col-md-9" style="padding-left: 0;">
                        <div class="form-group col-md-5" style="padding-left: 0;">
                            <div id="course_name">
                            </div>
                        </div>
                        <div class="form-group col-md-2" style="padding-left: 0;">
                            <b>Name of Tutor :</b>
                        </div>
                        <div class="form-group col-md-4" style="padding-left: 0; padding-right: 0;">
                            <div id="tutors">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" id="mainimg" style="display: none;">
                    <div class="form-group col-md-2 color-blue">
                        <b>Form of Final Output :</b>
                    </div>
                    <div class="form-group col-md-9 cls_div_img">
                        <div class="form-group cls_div_img pddltrt" style="margin-right: 20px;">
                            <img id="img1" class="cls_img_up" style="display: none;" />
                            <div id="div_caption1"></div>
                        </div>
                        <div class="form-group cls_div_img">
                            <img id="img2" class="cls_img_up" style="display: none;" />
                            <div id="div_caption2"></div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                        <b>Course Introduction : </b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="txtcourse_outline" class="align_text">
                        </div>
                    </div>
                </div>
                <div id="div_weekly_plan" style="display: none;">
                    <hr />
                    <div class="row" style="float: left;">
                        <div class="form-group col-md-10">
                            <b>Weekly Plan :</b>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt ">
                            <b>Week &nbsp; 1 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week1"></div>
                        </div>
                        <div class="form-group col-md-1 color-blue pddltrt ">
                            <b>Week &nbsp; 2 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week2" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 3 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week3"></div>
                        </div>
                        <div class="form-group col-md-1 color-blue  pddltrt ">
                            <b>Week &nbsp; 4 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt ">
                            <div id="txt_week4" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 5 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week5"></div>
                        </div>
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 6 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt ">
                            <div id="txt_week6" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 7 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week7"></div>
                        </div>
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 8 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week8" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week &nbsp; 9 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week9"></div>
                        </div>
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 10 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week10" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 11 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week11"></div>
                        </div>
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 12 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week12" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 13 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week13"></div>
                        </div>
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 14 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week14" class="align_text"></div>
                        </div>
                    </div>
                    <div class="row weekrow">
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 15 :</b>
                        </div>
                        <div class="form-group col-md-4 divweek color-blue pddltrt">
                            <div id="txt_week15"></div>
                        </div>
                        <div class="form-group col-md-1 color-blue pddltrt">
                            <b>Week 16 :</b>
                        </div>
                        <div class="form-group col-md-5 divweek color-blue pddltrt">
                            <div id="txt_week16" class="align_text"></div>
                        </div>
                    </div>
                </div>
                <div id="div_course_structure" class="row" style="margin-top: 10px; display: none;">
                    <hr />
                    <div class="form-group col-md-2 color-blue">
                        <b>Course Structure :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="txtcourse_structure">
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b>References/Reading :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="txt_reference" class="align_text">
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b>Evaluation Method :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="txt_eval_method" class="align_text">
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue" id="img567" style="display: none;">
                        <b>Form of Final Output :</b>
                    </div>
                    <div class="form-group">
                        <div class="cls_div_img">
                            <img id="img3" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption3" class="below-caption"></div>
                        </div>

                        <div class="cls_div_img">
                            <img id="img4" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption4" class="below-caption"></div>
                        </div>

                        <div class="cls_div_img">
                            <img id="img5" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption5" class="below-caption"></div>
                        </div>

                        <div class="cls_div_img">
                            <img id="img6" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption6" class="below-caption"></div>
                        </div>

                        <div class="cls_div_img">
                            <img id="img7" class="courseimg cls_img_below" style="display: none;" />
                            <div id="div_caption7" class="below-caption"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <input type="hidden" id="returnUrl" name="returnUrl" value="" />
    <input type="hidden" id="secSignature" name="secSignature" value="" />
    <input type="hidden" name="reqtime" id="reqtime" value="<%=System.DateTime.Now.Ticks / 10000 %>" />
    <input style="display: none" type="text" id="merchantTxnId" class="text" name="merchantTxnId" value="" />
    <input style="display: none" type="text" id="orderAmount" class="text" name="orderAmount" value="" />
    <input style="display: none" type="text" id="currency" class="text" name="currency" value="INR" />
    <input type="hidden" id="hdn_outline" runat="server" clientidmode="Static" />

    <div style="display: none;">
        <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="Download_Student_outlet" />
    </div>

    <div class="row-fluid">
        <%--<div class="page-header position-relative"></div>--%>
        <div class="page-header position-relative" style="display: block; top: 4px;">
            <table>
                <tr>
                    <td>
                        <h1>
                            <i class="icon-desktop"></i>&nbsp;Course Selection
                        </h1>
                    </td>
                    <td style="width: 550px;" align="right">
                        <a href="<%= Page.ResolveClientUrl("~/Student/Dashboard.aspx") %>" class="btn btn-sm btn-primary">
                            <i class="icon-on-right icon-arrow-left"></i><span class="bigger-100">Go back to Dashboard</span>
                        </a>
                    </td>
                    <td style="margin-left: 150px;" align="center">
                        <a href="<%= Page.ResolveClientUrl("~/Student/calender.aspx") %>" class="btn btn-sm btn-primary">
                            <i class="icon-time"></i><span class="bigger-50">View Time Table</span> </a>
                    </td>
                </tr>
            </table>
        </div>

        <%--<div class="span6" style="margin-left: 300px; display: none">
            <div class="widget-box">
                <div class="widget-header widget-header-flat">
                    <h4 class="smaller">
                        <i class=""></i>Instructions
                    </h4>
                </div>
                <div style="display: none" class="widget-body">
                    <div class="widget-main">
                        <div class="row">
                            <div style="margin-left: 20px">
                                <dt style="font-weight: normal;">Please note that the students are required to pay full
                                    fees for the exchange program.</dt><br />
                                <dt style="font-weight: normal;">For paying fees, you may either select to pay offline
                                    by printing your pay in slip and depositing your fees at any branch of ICICI bank.
                                    You may also pay fees online using net banking, credit or debit card.</dt><br />
                                <dt style="font-weight: normal;">The fees can be paid by clicking on the appropriate
                                    button at the bottom of the page. Please note that once you pay the fees you are
                                    required to submit the fee payment details to the exchange office to complete your
                                    registration process.</dt>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>--%>

        <div>
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

        <div class="tabbable" style="width: 100%; margin-bottom: 20px; display: block;">
            <div align="right">
                <table style="margin-top: -5px;" cellpadding="5px" cellspacing="0px">
                    <tr>
                        <td style="padding: 2px;">
                            <label style="color: Red">Mandatory credits opted</label></td>
                        <td style="padding: 2px; color: Red;">&nbsp;:&nbsp;</td>
                        <td style="width: 20px; padding: 2px;">
                            <label id="lbl_mandatory" style="text-align: right;"></label>
                        </td>
                        <td style="padding: 2px;">
                            <label style="color: Red">Elective credits opted</label></td>
                        <td style="padding: 2px; color: Red;">&nbsp;:&nbsp;</td>
                        <td style="padding: 2px;">
                            <label id="lbl_elective" style="text-align: right;"></label>
                        </td>
                    </tr>
                    <tr>
                        <%--<td style="padding: 2px;">
                            <label style="color: Red">Elective credits opted</label></td>
                        <td style="padding: 2px; color: Red;">&nbsp;:&nbsp;</td>
                        <td style="padding: 2px;">
                            <label id="lbl_elective" style="text-align: right;"></label>
                        </td>--%>
                    </tr>
                </table>
            </div>

            <ul class="nav nav-tabs" id="myTab" style="margin-bottom:0px;"> <%--margin-top: -30px;--%> <%--changes By Nitinbhai 04072023 --%>
                <li id="li_step1" class="active">
                    <a>1.Credits Selection&nbsp;</a>
                    <a class="cls_tab_a" data-toggle="tab" href="#credit_selection">Credits Selection&nbsp;</a>
                </li>
                <li id="li_step2">
                    <a>2.Mandatory Course Selection&nbsp;</a>
                    <a class="cls_tab_a" data-toggle="tab" href="#mandatory">Mandatory Course Selection&nbsp;</a>
                </li>
                <li id="li_step3">
                    <a>3.Elective Course Selection&nbsp; </a>
                    <a class="cls_tab_a" data-toggle="tab" href="#elective">Elective Course Selection&nbsp; </a>
                </li>
                <li id="li_step4">
                    <a>4.Course Prefrences&nbsp; </a>
                    <a class="cls_tab_a" data-toggle="tab" href="#priority_gpa_ngpa">Course Prefrences&nbsp; </a>
                </li>
                <li id="li_step5">
                    <a>5.Important Instructions&nbsp; </a>
                    <a class="cls_tab_a" data-toggle="tab" href="#imp_inst">Important Instructions&nbsp; </a>
                </li>
                <li id="li_step6">
                    <a>6.Consent Form&nbsp; </a>
                    <a class="cls_tab_a" data-toggle="tab" href="#consent_form">Consent Form&nbsp; </a>
                </li>
                <li id="li_step7">
                    <a>7.Confirm Courses&nbsp; </a>
                    <a class="cls_tab_a" data-toggle="tab" href="#confirm_and_register">Confirm Courses&nbsp; </a>
                </li>
            </ul>

            <div class="tab-content">
                <div id="credit_selection" class="tab-pane in active">
                    <table border="0" cellpadding="1" cellspacing="5">
                        <tr style="display: none;">
                            <td style="vertical-align: sub;">Total credits I would like to apply for</td>
                            <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                            <td>
                                <input maxlength='2' type="text" id="txtcredit_choice" onkeypress='return IsNumeric(event);' disabled /></td>
                            <td width="10px"></td>
                            <td align="right" style="display: block" runat="server" id="td_save_credit">
                                <%--<button id="btn_save_credit" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>--%>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: sub; height: 40px;">Total credits I would like to apply for</td>
                            <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                            <td style="vertical-align: sub;"><b><span id="spn_credit_choice"></span></b></td>
                            <td width="10px"></td>
                            <td align="right" style="display: block" runat="server" id="td1">
                                <%--<button id="btn_save_credit" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>--%>
                            </td>
                        </tr>
                        <tr>
                            <td style="vertical-align: sub;">Mandatory Credits</td>
                            <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                            <td>
                                <input maxlength='2' type="text" id="txt_mandatory_credits" onkeypress='return IsNumeric(event);' /></td>
                            <td style="width: 90px; padding-left: 10px; vertical-align: top;"><a id="view_mand_course" href="#">View Courses</a></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td style="vertical-align: sub;">Elective Credits</td>
                            <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                            <td>
                                <input maxlength='2' type="text" id="txt_elective_credits" onkeypress='return IsNumeric(event);' /></td>
                            <td style="width: 90px; padding-left: 10px; vertical-align: top;"><a id="view_elec_course" href="#">View Courses</a></td>
                            <td></td>
                        </tr>
                        <tr style="display: none;">
                            <td style="vertical-align: sub;">Credits to be parked in SWS</td>
                            <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                            <%--<td><input maxlength='2' type="text" id="txt_sws_credits" onkeypress='return IsNumeric(event);' /></td>--%>
                            <td>
                                <select id="txt_sws_credits">
                                    <option value="0">0</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                </select>
                            </td>
                            <td></td>
                            <td></td>
                        </tr>
                    </table>

                    <div>
                        <p><b>The maximum payable fees are 20 credits and maximum allocated in a semester is 20 (Please refer to Academic Rule Book Number 4.1 General Registration Rules)</b></p>

                        <p>
                            <b>Students admitted in 2016 or later have the option to earn elective credits through SWS courses. 
                        In order to do this, students will need to assign requisite credits towards SWS after payment of fees. 
                        Specific SWS courses can be chosen when the SWS registration is initiated.</b>
                        </p>

                        <p><b>If you have paid full fees for the semester, select the number of credits that you plan to utilise towards your SWS courses in the field above.</b></p>
                    </div>

                    <div align="center">
                        <%--<button id="btn_save_credit" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Next
                        </button>--%>
                    </div>
                </div>

                <div id="mandatory" class="tab-pane">
                    <div style="background: gray;" align="right">
                        <table id="tbl_prog_type" cellpadding="15" cellspacing="5">
                            <tr>
                            </tr>
                        </table>
                    </div>

                    <%--<div class="span12">
                        <div class="portlet-title">
                            <div class="caption">
                                        <i class="icon-reorder"></i>Multiple Select</div>
                            <div class="tools">
                                <a href="javascript:;" class="collapse"></a><a href="#portlet-config" data-toggle="modal"
                                    class="config"></a><a href="javascript:;" class="reload"></a><a href="javascript:;"
                                        class="remove"></a>
                            </div>
                        </div>
                        <div class="portlet-body form">
                            <div class="control-group">
                                <div class="controls">
                                    <select multiple="multiple" id="mandatory_course" name="mandatory_course[]">
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>--%>

                    <div id="DataList">
                        <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot id="abc">
                                <tr>
                                    <th>Search <i class="icon-on-right icon-arrow-right"></i>
                                        <input type="text" style="width: 5px; display: none" name="search_engine" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 35px" name="search_sem" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <center><input id="txt_code" type="text" style="width: 54px;" name="search_Faculty" value="" class="search_init" /></center>
                                    </th>
                                    <th>
                                        <input type="text" style="width: 86px" name="search_semester" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 25px" name="search_code" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <center><input type="text" style="width: 95px" name="search_name" value="" class="search_init" /></center>
                                    </th>
                                    <th>
                                        <center><input type="text" style="width: 47px" name="search_credits" value="" class="search_init" /></center>
                                    </th>
                                    <th>
                                        <center><input type="text" style="width: 50px" name="search_days" value="" class="search_init" /></center>
                                    </th>
                                    <th>
                                        <center><input type="text" style="width: 100px" name="search_instructor" value="" class="search_init" /></center>
                                    </th>
                                    <th>
                                        <center><input type="text" style="width: 100px" name="search_pre" value="" class="search_init" /></center>
                                    </th>
                                    <th></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <div id="elective" class="tab-pane">
                    <div id="datalist_elective">
                        <table cellpadding="0" cellspacing="0" border="0" id="elective1" class="display table table-striped table-bordered table-hover">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                            <tfoot id="abc1">
                                <tr>
                                    <th>Search <i class="icon-on-right icon-arrow-right"></i>
                                        <input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 10px; display: none" name="search_engine" value="Search engines" class="search_init" />
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
                                        <input type="text" style="width: 70px;" name="search_pre" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 50px;" name="search_Faculty" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 78px" name="search_instructor" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 48px" name="search_time" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 48px" name="search_days" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 72px" name="search_Area" value="" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 1px; display: none" name="search_Area" value="Area" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 1px; display: none" name="search_priority" value="Search engines" class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 1px; display: none" name="search_priority" value="Search engines" class="search_init" />
                                    </th>
                                    <th></th>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <div id="priority_gpa_ngpa" class="tab-pane">
                    <div id="datalist_elective_preference">
                        <table cellpadding="0" cellspacing="0" border="0" id="elective_preference" class="display table table-striped table-bordered table-hover" style="text-align: justify;">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="imp_inst" class="tab-pane">
                    <table cellpadding="2" cellspacing="4" style="text-align: justify;">
                        <tr>
                            <td>1. Please read the instructions on anti-ragging available at <a href="http://cept.ac.in/student-services/anti-ragging" target="_blank">http://cept.ac.in/student-services/anti-ragging</a> it is compulsory for successful registration and you have to upload the affidavit with yours and your parent’s signature at <a href="https://docs.google.com/forms/d/e/1FAIpQLSeUeuNZIcgzeBOoVIEwe3QtFJ7hDhJxJboevKDSRkyAzVQ1Bw/viewform" target="_blank">Affidavits 2019 Upload Form - A mandatory requisite</a> on or before Monday, 22nd July, 2019. The anti-ragging form has to be filled & upload every year by all the students of CEPT University.
                            </td>
                        </tr>
                        <tr>
                            <td>2. To finish the registration the newly admitted students have to upload a certificate from the physician at <a href="https://docs.google.com/forms/d/e/1FAIpQLSepGgrK8oU0W1COPr9_Jxh0HvPwGpUlE9oKOk_oU4GKFnsBiw/viewform" target="_blank">MEDICAL FITNESS CERTIFICATE - 2019 Upload Form  - A mandatory requisite</a> to on or before Monday, 22nd July, 2019.
                            </td>
                        </tr>
                        <tr>
                            <td>3. It is responsibility of a student to choose the mandatory and elective subjects as per the prerequisite given for the course. In case a student does not fulfill the prerequisite for a course he/she will be disqualified.
                            </td>
                        </tr>
                        <tr>
                            <td>4. It is responsibility of the student not to choose elective which he/she has already finished successfully. In case a student opts for the same course again he/she will be disqualified from the course.
                            </td>
                        </tr>
                        
                        <%--<tr>
                    <td>
                        3. Please read the instructions on anti-raggingavailable at: <a href="http://cept.ac.in/21/248/student-services/anti-ragging"
                            target="_blank">http://cept.ac.in/21/248/student-services/anti-ragging.</a>
                        It is compulsory for registration to be successful to submit the affidavit with
                        your sign and your parents sign to Student Services Office at CEPT on or before
                        21st July, 20151:30pm.The anti-ragging form has to be filled every year by all the
                        students of CEPT University.
                    </td>
                </tr>
                <tr>
                    <td>
                        4. To finish the registration, the newly admit PG students have to submit a certificate
                        from the physician to CEPT University Student Service Office (SSO). The format of
                        the certificate can be downloaded from the link <a href="http://cept.ac.in/file_manager/files/medicalexaminationform_210415.pdf"
                            target="_blank">http://cept.ac.in/file_manager/files/medicalexaminationform_210415.pdf
                        </a> on or
                        before 21st July, 2015. The CEPT campus doctor will be available on 16th July 2015
                        from 3.00 pm to 6.00 pm if you want to consult him for fitness certificate.
                    </td>
                </tr>--%>
                        <tr>
                            <td>5. In case of a conflict, the decision taken by CEPT University management would stand final.
                            </td>
                        </tr>
                        <%--<tr style="display: none;">
                    <td>
                        <input type="checkbox" id="chk_agree_afidavite" checked />
                        I hereby agree that I would submit the online Anti-Ragging Affidavit duly signed on or before 21st July, 2015 1:30pm.
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="chk_agree_reg_process" />
                        I have read, I understand and agree to abide by the instructions of the registration process.
                    </td>
                </tr>--%>
                    </table>
                </div>

                <div id="consent_form" class="tab-pane">
                    <table cellpadding="2" cellspacing="4" style="text-align: justify;">
                        <tr>
                            <td style="text-align: center; font-size: 22px">
                                <b>Contributor Consent Form
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: center; font-size: 18px">
                                <b>Declaration Form for use of Academic Work, Images and Other Proprietary Material
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td>I, the undersigned, hereby consent to the use of my academic work (includes courses from studio, mandatory, electiveand summer winter school) 
                        as submitted for assessment towards completion of the course, portfolio/ exhibition/ publication, and other proprietary material arising out of all pedagogical 
                        exercises undertaken during my course tenure at CEPT University, in all such publication mediums as deemed suitable by the University while giving due credit of the work to its original author.
                            </td>
                        </tr>
                        <tr>
                            <td>I accept, that the University reserves the right to enter into agreement with inhouse or external publisher(s) 
                        for use of my work set forth above in all media now known or which may be developed in future.The use may include, 
                        but is not limited to, editing, duplication, licensing, distribution and incorporation in other works, in whatever form (e.g. hard copy or electronic), 
                        such as posters, publications, web sites, films or videos, and their unrestricted use, without any obligation on 
                        the part of the University to seek any further authorization by the undersigned.
                            </td>
                        </tr>
                        <tr>
                            <td>The publishers can retain copyright and assign all subsidiary rights as well. 
                        CEPT University shall have the sub-licensable and worldwide right to use my work as set forth above in relation with the material in any manner whatsoever. 
                        This however does not preclude me from using my own work for any future usage including publication with credit to CEPT University.
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>This would in no way curtail my right to publish, disseminate, exhibit my work, while giving due credit to CEPT University.
                                </b>
                            </td>
                        </tr>
                        <tr>
                            <td>I declare being a major, and that I have the full right to make this declaration of consent. 
                                I understand that I will not be entitled to receive any payment in consideration for the use of my work set forth above, pursuant to this declaration of consent.
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td>
                                <input type="checkbox" id="chk_agree_afidavite" checked />
                                I hereby agree that I would submit the online Anti-Ragging Affidavit duly signed on or before 21st July, 2015 1:30pm.
                            </td>
                        </tr>
                        <tr style="display: none;">
                            <td>
                                <input type="checkbox" id="chk_agree_reg_process" checked />
                                I have read, I understand and agree to abide by the instructions of the registration process.
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <b>I confirm, that my work set forth aboveis original and not plagiarized.</b>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="checkbox" id="chk_agree_consent_form" />
                                I Accept.
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="confirm_and_register" class="tab-pane">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong>Credits Selection</strong>
                        </div>
                        <div>
                            <table border="0" cellpadding="5" cellspacing="5">
                                <tr>
                                    <td style="vertical-align: sub;">Total credits I would like to apply for</td>
                                    <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                                    <td style="vertical-align: sub;"><b><span id="spn_credit_choice2"></span></b></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: sub;">Mandatory Credits</td>
                                    <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                                    <td id="td_mandatory_credits"></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: sub;">Elective Credits</td>
                                    <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                                    <td id="td_elective_credits"></td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: sub;">Credits to be parked in SWS</td>
                                    <td style="vertical-align: sub;">&nbsp;:&nbsp;</td>
                                    <td id="td_sws_credits"></td>
                                </tr>
                            </table>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong>Mandatory Course Selection</strong>
                        </div>
                        <div>
                            <table id="tbl_disp_mandatory" border="0" cellpadding="5" cellspacing="5" class="display table table-striped table-bordered table-hover dataTable">
                                <thead>
                                    <tr>
                                        <th>Sem.</th>
                                        <th>Code</th>
                                        <th>Name</th>
                                        <th>Credits</th>
                                        <th>faculty</th>
                                        <th>Time</th>
                                        <th>Days</th>
                                        <th>GPA/Non GPA</th>
                                        <th>Prerequisite</th>
                                        <%--<th>Course Outline</th>--%>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="div_add_guide" class="panel panel-default" style="display: none;">
                        <div class="panel-heading">
                            <strong>Add Guide</strong>
                        </div>
                        <div class="panel-body">
                            <input type="button" id="btn_add_guide" class="btn btn-primary btn-small" value="Add" />
                            <table id="tbl_add_guide" style="margin-top: 10px;">
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="div_thisis_drp_guide" class="panel panel-default" style="display: none;">
                        <div class="panel-heading">
                            <strong>Thesis/DRP Details</strong>
                        </div>
                        <div class="panel-body">
                            <p id="type"></p> <p id="title"></p>
                            <p><b>Guide Name </b></p> <p id="guide_name"></p>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <strong>Elective Course Selection</strong>
                        </div>
                        <div>
                            <table id="tbl_disp_elective" border="0" cellpadding="5" cellspacing="5" class="display table table-striped table-bordered table-hover dataTable">
                                <thead>
                                    <tr>
                                        <th>Priority</th>
                                        <th>Code</th>
                                        <th>Name</th>
                                        <th>Credits</th>
                                        <th>Prerequisite</th>
                                        <th>Faculty</th>
                                        <th>faculty</th>
                                        <th>Time</th>
                                        <th>Days</th>
                                        <th>Area</th>
                                        <th>GPA/Non GPA</th>
                                        <th>Sem</th>
                                        <%--<th>Course Outline</th>--%>
                                    </tr>
                                </thead>
                                <tbody></tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; display: block;">
        <div id="div_buttons" class="container" runat="server">
            <div class="row-fluid">
                <div class="span11" style="margin-top: 5px; margin-bottom: 5px;">
                    <table align="center" border="0" cellpadding="3" cellspacing="5">
                        <%--<tr>
                            <td>
                                <button id="btn_save" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>
                            </td>

                            <td>
                                <button id="btnsave" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Register
                                </button>
                            </td>
                        </tr>--%>

                        <%--<tr id="tr_step1" class="cls_tr_btn">
                            <td>
                                <input type="button" id="btn_save_credit" class="btn btn-lg btn-primary btn_next" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>

                        <tr id="tr_step2" class="cls_tr_btn" style="display: none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next btn_save" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>

                        <tr id="tr_step3" class="cls_tr_btn" style="display: none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next btn_save" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>

                        <tr id="tr_step6" class="cls_tr_btn" style="display: none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next btn_save" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>

                        <tr id="tr_step5" class="cls_tr_btn" style="display: none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next btn_save" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>

                        <tr id="tr_step4" class="cls_tr_btn" style="display: none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next" style="line-height: inherit;" value="Next  >" onclick="saveCoursePreference()" />
                            </td>
                        </tr>

                        <tr id="tr_step7" class="cls_tr_btn" style="display: none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input id="btnsave" type="button" class="btn btn-lg btn-primary btn_next" style="line-height: inherit;" value="Submit" />
                            </td>
                        </tr>--%>

                        <tr id="tr_step1" class="cls_tr_btn">
                            <td>
                                <input type="button" id="btn_save_credit" class="btn btn-lg btn-primary btn_next" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>
                        
                        <tr id="tr_step2" class="cls_tr_btn" style="display:none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next btn_save" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>

                        <tr id="tr_step3" class="cls_tr_btn" style="display:none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next btn_save" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>
                        
                        <tr id="tr_step4" class="cls_tr_btn" style="display:none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next" style="line-height: inherit;" value="Next  >" onclick="saveCoursePreference()" />
                            </td>
                        </tr>

                        <tr id="tr_step5" class="cls_tr_btn" style="display:none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next btn_save_next" style="line-height: inherit;" value="Next  >" />
                            </td>
                        </tr>

                        <tr id="tr_step6" class="cls_tr_btn" style="display:none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_next" style="line-height: inherit;" value="Next  >"  onclick="saveAgree()" />
                            </td>
                        </tr>
                        
                        <tr id="tr_step7" class="cls_tr_btn" style="display:none;">
                            <td>
                                <input type="button" class="btn btn-lg btn-primary btn_prev" style="line-height: inherit;" value="<  Previous" />
                            </td>
                            <td>
                                <input id="btnsave" type="button" class="btn btn-lg btn-primary btn_next" style="line-height: inherit;" value="Submit" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>
</asp:Content>

