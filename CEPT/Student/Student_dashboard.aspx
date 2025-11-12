<%@ Page Title="Student Dashboard-CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" ValidateRequest="false"
    AutoEventWireup="true" CodeFile="Student_dashboard.aspx.cs" Inherits="Student_Student_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <link href="../DesignCss/multi-select.css" rel="stylesheet" type="text/css" />
    <%-- <link href="../DesignCss/application.css" rel="stylesheet" type="text/css" />--%>
    <link href="../DesignCss/bootstrap-switch.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/jquery.multi-select.js" type="text/javascript"></script>
    <script src="../DesignJS/application.js" type="text/javascript"></script>
    <script src="../Js/student_course_selection_new1.js?t=25062018" type="text/javascript"></script>
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
        });

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
            font-size: 12px;
            background: rgba(129,193,229,0.8);
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

        .prog_image_anim
        {
            -webkit-animation: progress-bar-stripes 4s linear infinite;
            background-image: -webkit-linear-gradient(44deg,rgba(255,255,255,.15) 25%,transparent 25%,transparent 50%,rgba(255,255,255,.15) 50%,rgba(255,255,255,.15) 75%,transparent 75%,transparent);
            background-size: 40px 40px;
        }

        .col-md-9
        {
            padding-left: 0;
        }

        .col-md-2
        {
            width:18% !important;
            padding-right: 0;
        }

        .courseimg
        {
            height: 100px;
            /*width: 150px;*/
        }

        #img1, #img2
        {
            height: 200px;
        }

        #mainimg
        {
            margin-bottom: 16px;
        }

        .pddltrt
        {
            padding-left: 0px;
            padding-right: 0px;
        }

        .weekrow
        {
            margin-left: 103px;
            margin-bottom: 3px;
        }

        .cls_div_img
        {
            z-index: 1000;
            float: left;
            margin-right: 5px;
        }

            .cls_div_img:hover
            {
                z-index: 1001;
            }

        .cls_img_up:hover
        {
            -ms-transform: scale(2.2); /* IE 9 */
            -webkit-transform: scale(2.2); /* Safari 3-8 */
            transform: scale(2.2);
        }

            .cls_img_up:hover ~ div
            {
                -ms-transform: scale(3.0); /* IE 9 */
                -webkit-transform: scale(3.0); /* Safari 3-8 */
                transform: scale(3.0);
                position: absolute;
                margin-top: 140px;
                background: #cac3c4;
                font-size: 7px;
                padding: 0 10px;
            }

        .below-caption
        {
            display: none;
        }

        .cls_img_below:hover
        {
            -ms-transform: scale(3.0); /* IE 9 */
            -webkit-transform: scale(3.0); /* Safari 3-8 */
            transform: scale(3.0);
        }

            .cls_img_below:hover ~ div
            {
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

        .align_text
        {
            text-align: justify;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="modal hide fade" id="my_outline" style="margin-left: -442px; width: 70%; overflow: auto; height: 82%;">
        <button style="float: right" class="btn btn-lg btn-primary" id="btn_print_outline">Print outline</button>
        <div class="panel panel-default" id="my_print_outline" style="margin-bottom: 150px;" runat="server" clientidmode="Static">
            <div class="panel-heading">
                <div id="head_data">
                </div>

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
                        <div class="form-group col-md-4" style="padding-left: 0; padding-right:0;">
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

                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        <b>Learing Outcome :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div id="lear_outcome" class="align_text">
                        </div>
                        <div id="lear_outcome1" class="align_text">
                        </div>
                        <div id="lear_outcome2" class="align_text">
                        </div>
                        <div id="lear_outcome3" class="align_text">
                        </div>
                        <div id="lear_outcome4" class="align_text">
                        </div>
                        <div id="lear_outcome5" class="align_text">
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
        <div>
            <table border="0" cellpadding="1" cellspacing="5">
                <tr>
                    <td>Total credits I would like to apply for :
                    </td>
                    <td>
                        <input pattern="[789][0-9]{9}" maxlength='2' type="text" id="txtcredit_choice" onkeypress='return IsNumeric(event);' />
                    </td>
                    <td width="10px"></td>
                    <td align="right" style="display: block" runat="server" id="td_save_credit">
                        <button id="btn_save_credit" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Save
                        </button>
                    </td>
                </tr>
            </table>
        </div>
        <div class="tabbable" style="width: 100%; margin-bottom: 20px; display: block;">
            <ul class="nav nav-tabs" id="myTab">
                <li class="active"><a data-toggle="tab" href="#mandatory">Mandatory&nbsp;</a> </li>
                <li><a data-toggle="tab" href="#elective">Elective &nbsp; </a></li>
                <div align="right">
                    <table cellpadding="5px" cellspacing="0px">
                        <tr>
                            <td>
                                <label style="color: Red">Mandatory credits opted :</label></td>
                            <td style="width: 20px">
                                <label id="lbl_mandatory"></label>
                            </td>
                            <td></td>
                            <td></td>
                            <td>
                                <label style="color: Red">Elective credits opted :</label></td>
                            <td>
                                <label id="lbl_elective"></label>
                            </td>
                        </tr>
                    </table>
                </div>
            </ul>
            <div class="tab-content">
                <div id="mandatory" class="tab-pane in active">
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
                                        <center><input type="text" style="width: 50px" name="search_pre" value="" class="search_init" /></center>
                                    </th>
                                    <th>
                                        <center><input type="text" style="width: 100px" name="search_instructor" value="" class="search_init" /></center>
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
                                        <input type="text" style="width: 25px; display: none" name="search_engine" value="Search engines"
                                            class="search_init" />
                                    </th>
                                    <th>
                                        <input type="text" style="width: 10px; display: none" name="search_engine" value="Search engines"
                                            class="search_init" />
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
            </div>
        </div>
    </div>

    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; display: block;">
        <div id="div_buttons" class="container" runat="server">
            <div class="row-fluid">
                <div class="span11" style="margin-top: 10px">
                    <table align="center" border="0" cellpadding="3" cellspacing="5">
                        <tr>
                            <td>
                                <button id="btn_save" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>
                            </td>

                            <%--<td>
                                <button id="btn_print" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-print bigger-160"></i>Print Pay-In Slip
                                </button>
                            </td>
                            <td>
                                <button id="btnonlinepayment" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-print bigger-160"></i>Online Payment
                                </button>
                            </td>--%>

                            <td>
                                <button id="btnsave" style="display: block; line-height: inherit;" class="btn btn-lg btn-primary">
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
    </div>
</asp:Content>
