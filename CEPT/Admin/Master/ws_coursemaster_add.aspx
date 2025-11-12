<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ws_coursemaster_add.aspx.cs" Inherits="Admin_Master_ws_coursemaster_add" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="../../DesignCss/jquery.timepicker.css" rel="stylesheet" type="text/css" />
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
   <%-- <script src="../../Scripts/AjaxFileupload.js"></script>--%>
    <script src="../../Js/jquery.timepicker.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js"></script>
    <link type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css" rel="stylesheet" />
    
    <style type="text/css">
        input.per_load, select.drpinstructor {
            margin-bottom: 0px;
        }
    </style>
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;WS Add New Course
            </h1>
        </div>
    </div>
    <%--//63.3%--%>
        <div class="row" style="margin-top: 11px; width: 100%; border: 0px solid rgba(113, 112, 112, 1); background-color: rgba(255, 255, 255, 1); border-radius: 0; box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6); margin-left: 1px; display: block;margin-bottom: 10px;" id="for_I2">
        <h5 class="font_8" style="margin-left: 5px; font-size: 18px; margin-top: 3px;">Personal Details And Add SWS New Course</h5>
        <div style="margin-left: 1%; border-top: 1px solid #c2c2c2ab; width: 97.8%;"></div>
        <ol class="show-grid col-md-8 col-md-offset-2" style="margin-left: -8px;width:100%;margin-bottom:10px;margin-top:5px;">
             <span style="font-size: 10pt;text-shadow: 0 0 slateblue;"> Step 1 : For Creating a New Course Personal Details must be submit by instructor.</span></br>
             <span style="font-size: 10pt;text-shadow: 0 0 slateblue;"> Step 2 : Fill up the Course details.</span></br>
             <span style="font-size: 10pt;text-shadow: 0 0 slateblue;">Step 3 : Click on the Submit. </span></br>
            <span style="font-size: 10pt;text-shadow: 0 0 slateblue;color:red;"> Note: 1. You can not change once you final Submit Course Details.</span></br>
            <span style="font-size: 10pt;text-shadow: 0 0 slateblue;color:red;"> Note: 2. You can not enter more than one course.</span></br></br>
            <div id="temp_user">
            <li class="col-md-3 active" id="pd" style="width: 27.5% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-user"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 1:</strong></h5>
                        <p id="pdclick" style="color:black;">Personal Details</p>

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="ip"style="width: 28% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-book"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 2:</strong></h5>
                        <a href="" id="lp_disabled" style="color:black;">Create a New course</a>

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="sd" style="width: 28% !important; display:none;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 3:</strong></h5>
                        <a href="Studio_Details.aspx" id="sp_disabled" style="color:black;">Studio Proposal Details</a>

                    </div>
                </div>
            </li>
                </div>

           

            <%--<li class="col-md-3 active" id="bank_tutor" style="width: 18% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 4:</strong></h5>
                        <p id="bdclick" style="color:black;">Bank Details</p>
                    </div>
                </div>
            </li>--%>
        </ol>
    </div>



    <div class="well" style="background-color: White; margin-bottom: 60px;">
        <%--<div class="panel panel-default" style="display:none;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Retrieve Previous Year Course Data</span></strong></div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div class="form-group col-md-5" style="margin-bottom: 10px;">
                        Previous Year Semester :
                        <span id="spnprevsem"></span>
                    </div>
                </div>
                <div class="row">
                                                                        <%--<div class="form-group col-md-1">
                    Semester :
                </div>
                <div class="form-group col-md-2">
                    <select class="chosen-select" id="drpsemester">
                    </select>
                </div>
                <div class="form-group col-md-1">
                    Year :
                </div>
                <div class="form-group col-md-2">
                    <select class="chosen-select" id="drpyear">
                    </select>
                </div>--%
                    <div class="form-group col-md-1" style="padding-top:8px;">
                        Semester :
                    </div>
                    <div class="form-group col-md-3" style="padding-top:6px;">
                            <select class="chosen-select" id="drpsem">
                            <option value="M">Monsoon</option>
                            <option value="S">Spring</option>
                            </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top:8px;">
                        Course :
                    </div>
                    <div id="div_cur_sem_course" class="form-group col-md-3" style="padding-top:6px;">
                            <select class="chosen-select" id="drcourses">
                            </select>
                    </div>
                    <div id="div_other_sem_course" class="form-group col-md-3" style="padding-top:6px;display:none;">
                            <select class="chosen-select" id="drpothercourse">
                            </select>
                    </div>
                    <div class="form-group col-md-2">
                        <button class="btn btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                   
                </div>
                <%--<div class="row">
                    <div style="margin-left: 41%;" class="form-group col-md-12">
                        <button class="btn  btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>--%
                
            </div>
        </div>--%>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Course Details</span></strong>
            </div>
            <div style="padding: 10px; overflow: visible;" id="div_progcoord_panel" class="panel-collapse collapse in">
                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">
                        <%--Course Title <br/> (Max. 125 Characters)<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                        Course Title
                        <br />
                        (Max. 95 Characters)<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-9">
                        <%--<textarea id="txtcourse_title" style="width: 100%;margin-bottom: 0px;" rows="3" cols="50" name="address" maxlength="125" onkeyup="return keyup_charcount(event);" onkeypress="return charcount(event);"></textarea>--%>
                        <textarea id="txtcourse_title" style="width: 100%; margin-bottom: 0px;" rows="3" cols="50" name="address" maxlength="95" onkeyup="return keyup_title_charcount(event);" onkeypress="return title_charcount(event);"></textarea>
                        <span id="spn_title" style="float: right; margin-bottom: 10px;">Total Char : 0</span>
                    </div>
                </div>

                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">
                        <%--Course Description <br/> (Min. 150 Words and <br />Max. 300 Words)<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                        Course Description
                        <br />
                        (Max. 1200 Characters)<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-9">
                        <%--<textarea id="txtcourse_description" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return keyup_wordcount(event,'txtcourse_description','spn_desc');" onkeypress="return wordcount(event,'txtcourse_description');"></textarea>--%>
                        <textarea id="txtcourse_description" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="1200" onkeyup="return keyup_charcount(event,'txtcourse_description','spn_desc');" onkeypress="return charcount(event,'txtcourse_description',1200);"></textarea>
                        <%--<span id="spn_desc" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                        <span id="spn_desc" style="float: right; margin-bottom: 10px;">Total Char : 0</span>
                    </div>
                </div>

                 <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">
                        Learning Outcomes
                        <br />
                        (Max. 600 Characters)<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-9">
                        <textarea id="learning_outcomes" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="600" onkeyup="return keyup_charcount(event,'learning_outcomes','spn_desc2');" onkeypress="return charcount(event,'learning_outcomes',600);"></textarea>
                        <span id="spn_desc2" style="float: right; margin-bottom: 10px;">Total Char : 0</span>
                    </div>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        Inhabitation<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <select id="drp_inhabitation">
                            <option value="">-- Select Inhabitation --</option>
                            <option value="1">Faculty of Architecture</option>
                            <option value="2">Faculty of Design</option>
                            <option value="3">Faculty of Management</option>
                            <option value="4">Faculty of Planning</option>
                            <option value="5">Faculty of Technology</option>
                            <%--<option value="7">Summer Winter</option>--%>
                        </select>
                    </div>

                    <div class="form-group col-md-1 color-blue" style="display: none;">
                        Methodology<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3" style="display: none;">
                        <select id="drp_methodology">
                            <option value="">-- Select Methodology --</option>
                            <option value="Travel based">Travel based</option>
                            <option value="Workshop based">Workshop based</option>
                            <option value="Studio based">Studio based</option>
                            <option value="Lecture based">Lecture based</option>
                            <option value="Travel + Lecture based">Travel + Lecture based</option>
                            <option value="Travel + Studio based">Travel + Studio based</option>
                            <option value="Travel + Workshop based">Travel + Workshop based</option>
                        </select>
                    </div>
                </div>

                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">
                        Course Type<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <select id="drp_course_type" onchange="category_location_change()">
                            <option value="">-- Select Course Type --</option>
                            <option value="M">Mandatory</option>
                            <option value="E">Elective</option>
                        </select>
                    </div>
                  
                </div>

                <%-- <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        Start Date<span class="cls_mendatory" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_start_date" class="marg-btm" onchange="workplan_change()" />
                    </div>
                    <div class="form-group col-md-1 color-blue">
                        End Date<span class="cls_mendatory" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_end_date" class="marg-btm" onchange="workplan_change()" />
                    </div>
                    <div class="form-group col-md-2 color-blue" style="margin-left:-40px;padding:0;">
                        Duration&nbsp;:&nbsp;<span id="spn_duration_in_days"></span>
                    </div>
                </div>--%>

                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">
                        Credits<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <select id="drp_credits" onchange="credits_change()">
                            <option value="">-- Select Credits --</option>
                            <option value="2">2</option>
                            <%--<option value="3">3</option>--%>
                            <option value="4">4</option>
                            <option value="6">6</option>
                        </select>
                    </div>
                    <div class="form-group col-md-1 color-blue">
                        GPA Status<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <select id="drp_gpa_status">
                            <option value="">-- Select GPA Status --</option>
                            <option value="G">GPA</option>
                            <option value="N">NGPA</option>
                            <%--<option value="GN">Both</option>--%>
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                    </div>
                    <div class="form-group col-md-4">
                        Hours : <span id="spn_credits_total_hrs"></span>
                        <br />
                        <span>(Minimum contact hrs required as per SWS norms)</span>
                    </div>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        Category Location Wise<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <select id="drp_category_location_wise" onchange="category_location_change(1)">
                            <option value="">-- Select Category Location Wise --</option>
                            <option value="On CEPT Campus Courses">On CEPT Campus Courses</option>
                            <option value="Travel Based Outside India">Travel Based Outside India</option>
                            <option value="Travel Based Within India">Travel Based Within India</option>
                            <option value="Online Course">Online Course</option>
                        </select>
                    </div>

                    <div class="form-group col-md-1 color-blue cls_location" style="display: none;">
                        Location<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3 cls_location" style="display: none;">
                        <input type="text" id="txt_location" />
                    </div>
                </div>

                 <div class="row" id="tralgroup" style="margin-top: 10px; padding: 10px; overflow: visible; display:none;" >
                <div class="form-group col-md-2 color-blue">
                    Travel Start Date<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                </div>
                <div class="form-group col-md-3">
                    <input type="text" id="txt_tral_start_date" class="marg-btm" placeholder="DD/MM/YYYY" />
                </div>
                <div class="form-group col-md-1 color-blue">
                    Travel End Date<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                </div>
                <div class="form-group col-md-3">
                    <input type="text" id="txt_tral_end_date" class="marg-btm" placeholder="DD/MM/YYYY" />
                </div>
            </div>

                <%--<div class="row">
                    <div class="form-group col-md-2 color-blue">
                        No of Students
                    </div>
                    <div class="form-group col-md-1">
                        Min : <span id="spn_min"></span>
                    </div>
                    <div class="form-group col-md-1">
                        Max : <span id="spn_max"></span>
                    </div>
                </div>--%>

                <div class="panel panel-default" style="margin-top: 10px;">
                    <div class="panel-heading">
                        <b>Course Outputs</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <table class="form-group col-md-11" style="margin-left: 15px;">
                                <tr>
                                    <td>
                                        <input type="checkbox" id="Installations" name="chk_course_output" />
                                        Installations</td>
                                    <td>
                                        <input type="checkbox" id="Models" name="chk_course_output" />
                                        Models</td>
                                    <td>
                                        <input type="checkbox" id="Presentation" name="chk_course_output" />
                                        Presentation</td>
                                    <td>
                                        <input type="checkbox" id="Products" name="chk_course_output" />
                                        Products</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="checkbox" id="Reports" name="chk_course_output" />
                                        Reports (Soft Copy as well)</td>
                                    <td>
                                        <input type="checkbox" id="Posters" name="chk_course_output" />
                                        Posters (Soft Copy as well)</td>
                                    <td>
                                        <input type="checkbox" id="Booklet" name="chk_course_output" />
                                        Booklet (Soft Copy as well)</td>
                                    <td>
                                        <input type="checkbox" id="Photos" name="chk_course_output" />
                                        Photos (Soft Copy as well)</td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="checkbox" id="Others" name="chk_course_output" onchange="other_output_change()" />
                                        Others</td>
                                    <td>
                                        <input type="text" id="txt_other_output" style="display: none;" /></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        Prerequisite For Students<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <%--<textarea id="txtcourse_prerequisite" style="width:100%"" rows="6" cols="50" name="address"></textarea>--%>
                        <input type="text" id="txtcourse_prerequisite" name="address" />
                    </div>

                    


                    <%--<div class="form-group col-md-2 color-blue">
                        No of Students<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <div class="form-group col-md-4">
                            Min : <span id="spn_min"></span>
                        </div>
                        <div class="form-group col-md-4">
                            Max : <span id="spn_max"></span>
                        </div>
                    </div>--%>
                </div>

                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        Is it open for Professionals<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3" style="height: 40px;">
                        <input type="checkbox" id="chk_is_for_professional" class="marg-btm" onchange="chk_change()" />
                    </div>

                    <div class="form-group col-md-5" id="div_professional_prerequisite" style="display: none; padding: 0;">
                        <div class="form-group col-md-5 color-blue" style="padding-right: 8px;">
                            Professionals Prerequisite<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                        </div>
                        <div class="form-group col-md-5">
                            <input type="text" id="txt_professional_prerequisite" class="marg-btm" />
                        </div>
                    </div>
                </div>

                <%--<div class="row" style="margin-top: 10px;margin-bottom: 15px;">
                    <div class="form-group col-md-11" style="padding-left: 0px;padding-right: 60px;">
                        
                        <div class="form-group col-md-2 color-blue" style="margin-top: 10px;">
                            Course Outputs<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                        </div>
                        
                        <div class="form-group" style="margin-top: 10px;padding-left: 30px;float: left;">
                            <select id="drp_course_output1">
                                <option value="">-- Select Course Output --</option>
                                <option value="Installations">Installations</option>
                                <option value="Models">Models</option>
                                <option value="Presentation">Presentation</option>
                                <option value="Products">Products</option>
                                <option value="Reports">Reports (Soft Copy as well)</option>
                                <option value="Posters">Posters (Soft Copy as well)</option>
                                <option value="Booklet">Booklet (Soft Copy as well)</option>
                                <option value="Photos">Photos (Soft Copy as well)</option>
                            </select>
                            <select id="drp_course_output2" style="margin-left: 20px;">
                                <option value="">-- Select Course Output --</option>
                                <option value="Installations">Installations</option>
                                <option value="Models">Models</option>
                                <option value="Presentation">Presentation</option>
                                <option value="Products">Products</option>
                                <option value="Reports">Reports (Soft Copy as well)</option>
                                <option value="Posters">Posters (Soft Copy as well)</option>
                                <option value="Booklet">Booklet (Soft Copy as well)</option>
                                <option value="Photos">Photos (Soft Copy as well)</option>
                            </select>
                            <select id="drp_course_output3" style="margin-left: 20px;">
                                <option value="">-- Select Course Output --</option>
                                <option value="Installations">Installations</option>
                                <option value="Models">Models</option>
                                <option value="Presentation">Presentation</option>
                                <option value="Products">Products</option>
                                <option value="Reports">Reports (Soft Copy as well)</option>
                                <option value="Posters">Posters (Soft Copy as well)</option>
                                <option value="Booklet">Booklet (Soft Copy as well)</option>
                                <option value="Photos">Photos (Soft Copy as well)</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group col-md-11" style="padding-left: 0px;padding-right: 60px;">
                        <input type="checkbox" id="Installations" name="chk_course_output" /> Installations
                        <input type="checkbox" id="Models" name="chk_course_output" /> Models
                        <input type="checkbox" id="Presentation" name="chk_course_output" /> Presentation
                        <input type="checkbox" id="Products" name="chk_course_output" /> Products
                        <input type="checkbox" id="Reports" name="chk_course_output" /> Reports (Soft Copy as well)
                        <input type="checkbox" id="Posters" name="chk_course_output" /> Posters (Soft Copy as well)
                        <input type="checkbox" id="Booklet" name="chk_course_output" /> Booklet (Soft Copy as well)
                        <input type="checkbox" id="Photos" name="chk_course_output" /> Photos (Soft Copy as well)
                    </div>
                </div>--%>
            </div>
        </div>
         <div class="panel panel-default " style="display:none;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Course Budget</span></strong>
            </div>
            <div style="padding: 10px; overflow: visible;"  class="panel-collapse collapse in">

                <div class="row" style="margin-top: 10px; margin-bottom: 10px; display:block;" id="weekly_excerises" >
                            <div class="form-group col-md-2 color-blue">
                                Upload Course Budget File :<span class="" style="color: Red; display:none;">*</span>
                            </div>
                            <div class="form-group col-md-9">                        
                                <div class="form-group col-md-4">
                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload File</strong></span>
                                    <input type="file" name="userid_document" id="userid_document" onchange="javascript:return UploadData();" style="display: none;">
                                </label>
                                <span id="lbl_excercises_file_name" style="vertical-align: super; font-weight:bold;"><b></b></span></div>
                                <div class="form-group col-md-5">
                                 <span style="float:right; color:red;">Download Course Budget Sample File :<a href="../../ExcelFormatFiles/CourseBudget.xlsx" download>Download</a></span>
                             </div>
                           
                            </div>
                             
                        </div>

                

                
            </div>
        </div>


        <div class="panel panel-default" style="margin-top: 10px;">
            <div class="panel-heading">
                <b>Instructor Details</b>
            </div>
            <div class="panel-body">

                <div class="row" style="margin-top: 10px; display: none;">
                    <div class="form-group col-md-2 color-blue">
                        Instructors Involved<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <select id="drp_instructors_involved" onchange="instructors_involved_change()">
                            <%--<option value="">-- Select Instructors Involved --</option>--%>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </div>
                </div>

                <div class="row" style="margin-top: 10px; margin-bottom: 15px;">
                    <div class="form-group col-md-12">
                        <%--<div class="form-group col-md-4 color-blue">
                            Methodology<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                        </div>
                        <div class="form-group col-md-6">
                            <select id="drp_methodology">
                                <option value="">-- Select Methodology --</option>
                                <option value="Travel based">Travel based</option>
                                <option value="Workshop based">Workshop based</option>
                                <option value="Studio based">Studio based</option>
                                <option value="Lecture based">Lecture based</option>
                                <option value="Travel + Lecture based">Travel + Lecture based</option>
                                <option value="Travel + Studio based">Travel + Studio based</option>
                                <option value="Travel + Workshop based">Travel + Workshop based</option>
                            </select>
                        </div>
                        <div class="form-group col-md-4 color-blue" style="margin-top:15px;">
                            Inhabitation<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                        </div>
                        <div class="form-group col-md-6" style="margin-top:10px;">
                            <select id="drp_inhabitation">
                                <option value="">-- Select Inhabitation --</option>
                                <option value="1">Faculty of Architecture</option>
                                <option value="2">Faculty of Design</option>
                                <option value="3">Faculty of Management</option>
                                <option value="4">Faculty of Planning</option>
                                <option value="5">Faculty of Technology</option>
                            </select>
                        </div>--%>

                        <%--<div class="form-group col-md-4 color-blue" style="margin-top:15px;">
                            Category Location Wise<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                        </div>
                        <div class="form-group col-md-6" style="margin-top:15px;">
                            <select id="drp_category_location_wise" onchange="category_location_change()">
                                <option value="">-- Select Category Location Wise --</option>
                                <option value="On CEPT Campus Courses">On CEPT Campus Courses</option>
                                <option value="Travel Based Outside India">Travel Based Outside India</option>
                                <option value="Travel Based Within India">Travel Based Within India</option>
                            </select>
                        </div>
                        <div class="form-group col-md-4 color-blue" style="margin-top:3px;"></div>
                        <div class="form-group col-md-2 color-blue" style="margin-top:3px;">
                            Min : <span id="spn_min"></span>
                        </div>
                        <div class="form-group col-md-2" style="margin-top:3px;">
                            Max : <span id="spn_max"></span>
                        </div>
                        <div class="form-group col-md-4 color-blue" style="margin-top:15px;">
                            Location<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                        </div>
                        <div class="form-group col-md-6" style="margin-top:10px;">
                            <input id="txt_location" type="text" />
                        </div>--%>

                        <div class="row-fluid" id="dataList_instructor" style="float: left; width: 95%; display: block;">
                            <div class="box-content box-no-padding">
                                <button class="btn btn-primary btn-small" type="button" id="btn_instructor" style="display: block;">
                                    <%--button instructor--%>
                                    <i class="icon-plus"></i>&nbsp;Add Instructor
                                </button>
                            </div>
                           <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor">
                                <thead>
                                    <tr>
                                        <th>Instructor
                                        </th>
                                        <th>Contact hrs
                                        </th>
                                        <th>Additional hrs
                                        </th>
                                        <th>Total hrs
                                        </th>
                                        <th>CEPT Faculty
                                        </th>
                                        <th>Visiting Faculty
                                        </th>
                                        <th>International Visiting Faculty
                                        </th>
                                    </tr>
                                    <tr>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>

                        <br />
                        <div class="row-fluid" id="dataList_TA" style="float: left; width: 100%; display: block;">
                            <div class="box-content box-no-padding">
                                <button class="btn btn-primary btn-small" type="button" id="btn_TA" style="display: block;">
                                    <%--button instructor--%>
                                    <i class="icon-plus"></i>&nbsp;Add TA
                                </button>
                            </div>
                            <table class="data-table table table-bordered table-striped" border="0" id="tblTA">
                                <thead>
                                    <tr>
                                        <th>TA&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </th>
                                        <th>Contact hrs
                                        </th>
                                        <th>Additional hrs
                                        </th>
                                        <th>Total hrs
                                        </th>
                                        <th>CEPT Faculty
                                        </th>
                                        <th>Visiting Faculty
                                        </th>
                                        <th>International Visiting Faculty
                                        </th>
                                    </tr>
                                    <tr>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="form-group col-md-5 color-blue" style="padding-left: 13px; display: none;">
                        <%--<div class="row" id="div_based_in_ahmedabad" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-5 color-blue" style="padding-right: 0px;">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad" onchange="based_in_ahmedabad_change(1)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-5 color-blue" style="padding-right:0px;">Travel based Course</div>--%>
                            <div class="form-group col-md-5 color-blue" style="padding-right: 0px;">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-5">
                                <select id="drp_is_travel_based_course" onchange="travel_based_course_change()">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course" class="form-group col-md-11 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-5 color-blue" style="padding-right: 0px;">Accommodation Needed</div>
                            <div class="form-group col-md-5">
                                <select id="drp_accommodation_needed" onchange="accomodation_needed_change()">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed" class="form-group col-md-11 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date" class="marg-btm col-md-7" style="" onchange="accomodation_date_change()" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date" class="marg-btm col-md-7" style="" onchange="accomodation_date_change()" />
                                </div>
                                <div class="form-group col-md-5 color-blue" style="padding-right: 0px;">Total Days</div>
                                <div class="form-group col-md-5">
                                    <input type="text" id="txt_accomodation_total_days" style="width: 187px;" disabled />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="panel panel-default" id="div_desc_faculty1" style="margin-top: 15px; display: none;">
                    <div class="panel-heading">
                        <b id="phead_desc_faculty1">Faculty1</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                <%--Description of <span id="lbl_desc_faculty1"> <br/> (Max. 100 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                Description of <span id="lbl_desc_faculty1">
                                    <br />
                                    (Max. 900 Characters)</span><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_desc_faculty1" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty1','spn_desc_faculty1_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty1');"></textarea>--%>
                                <textarea id="txt_desc_faculty1" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty1','spn_desc_faculty1_words');" onkeypress="return charcount(event,'txt_desc_faculty1','Instructor');"></textarea>
                                <%--<span id="spn_desc_faculty1_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                <span id="spn_desc_faculty1_words" style="float: right; margin-bottom: 10px;">Total Character : 0</span>
                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                        <%--<div class="row" id="div_based_in_ahmedabad1" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad1" onchange="based_in_ahmedabad_change(2,1)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation1" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                            <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-3">
                                <select id="drp_is_travel_based_course1" onchange="travel_based_course_change(1)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course1" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from1" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to1" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation1" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                            <div class="form-group col-md-3">
                                <select id="drp_accommodation_needed1" onchange="accomodation_needed_change(1)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed1" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date1" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(1)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date1" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(1)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;"></div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Total Days</div>
                                    <input type="text" id="txt_accomodation_total_days1" class="marg-btm col-md-7" disabled />
                                </div>
                            </div>
                        </div>

                        <%--</div>
                        </div>--%>
                    </div>
                </div>

                <div class="panel panel-default" id="div_desc_faculty2" style="margin-top: 15px; display: none;">
                    <div class="panel-heading">
                        <b id="phead_desc_faculty2">Faculty2</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                <%--Description of <span id="lbl_desc_faculty2"> <br/> (Max. 75 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                Description of <span id="lbl_desc_faculty2">
                                    <br />
                                    (Max. 400 Characters)</span><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_desc_faculty2" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty2','spn_desc_faculty2_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty2');"></textarea>--%>
                                <textarea id="txt_desc_faculty2" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="400" onkeyup="return keyup_charcount(event,'txt_desc_faculty2','spn_desc_faculty2_words');" onkeypress="return charcount(event,'txt_desc_faculty2','Instructor');"></textarea>
                                <%--<span id="spn_desc_faculty2_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                <span id="spn_desc_faculty2_words" style="float: right; margin-bottom: 10px;">Total Character : 0</span>

                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                        <%--<div class="row" id="div_based_in_ahmedabad2" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad2" onchange="based_in_ahmedabad_change(2,2)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation2" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                            <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-3">
                                <select id="drp_is_travel_based_course2" onchange="travel_based_course_change(2)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course2" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from2" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to2" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation2" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                            <div class="form-group col-md-3">
                                <select id="drp_accommodation_needed2" onchange="accomodation_needed_change(2)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed2" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date2" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(2)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date2" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(2)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;"></div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Total Days</div>
                                    <input type="text" id="txt_accomodation_total_days2" class="marg-btm col-md-7" disabled />
                                </div>
                            </div>
                        </div>

                        <%--</div>
                        </div>--%>
                    </div>
                </div>

                <div class="panel panel-default" id="div_desc_faculty3" style="margin-top: 15px; display: none;">
                    <div class="panel-heading">
                        <b id="phead_desc_faculty3">Faculty3</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                Description of <span id="lbl_desc_faculty3">
                                    <br />
                                    (Max. 250 Characters)</span><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                <textarea id="txt_desc_faculty3" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="250" onkeyup="return keyup_charcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return charcount(event,'txt_desc_faculty3','Instructor');"></textarea>
                                <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                <span id="spn_desc_faculty3_words" style="float: right; margin-bottom: 10px;">Total Character : 0</span>
                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                        <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad3" onchange="based_in_ahmedabad_change(2,3)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation3" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                            <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-3">
                                <select id="drp_is_travel_based_course3" onchange="travel_based_course_change(3)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course3" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from3" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to3" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation3" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                            <div class="form-group col-md-3">
                                <select id="drp_accommodation_needed3" onchange="accomodation_needed_change(3)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed3" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date3" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(3)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date3" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(3)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;"></div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Total Days</div>
                                    <input type="text" id="txt_accomodation_total_days3" class="marg-btm col-md-7" disabled />
                                </div>
                            </div>
                        </div>

                        <%--</div>
                        </div>--%>
                    </div>
                </div>


                <%--kapil--%>
                <div class="panel panel-default" id="div_desc_faculty4" style="margin-top: 15px; display: none;">
                    <div class="panel-heading">
                        <b id="phead_desc_faculty4">Faculty4</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                Description of <span id="lbl_desc_faculty4">
                                    <br />
                                    (Max. 250 Characters)</span><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                <textarea id="txt_desc_faculty4" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty4','spn_desc_faculty4_words');" onkeypress="return charcount(event,'txt_desc_faculty4','Instructor');"></textarea>
                                <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                <span id="spn_desc_faculty4_words" style="float: right; margin-bottom: 10px;">Total Character : 0</span>
                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                        <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad4" onchange="based_in_ahmedabad_change(2,4)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation4" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                            <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-3">
                                <select id="drp_is_travel_based_course4" onchange="travel_based_course_change(4)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course4" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from4" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to4" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation4" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                            <div class="form-group col-md-3">
                                <select id="drp_accommodation_needed4" onchange="accomodation_needed_change(4)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed4" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date4" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(4)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date4" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(4)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;"></div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Total Days</div>
                                    <input type="text" id="txt_accomodation_total_days4" class="marg-btm col-md-7" disabled />
                                </div>
                            </div>
                        </div>

                        <%--</div>
                        </div>--%>
                    </div>
                </div>



                <div class="panel panel-default" id="div_desc_faculty5" style="margin-top: 15px; display: none;">
                    <div class="panel-heading">
                        <b id="phead_desc_faculty5">Faculty5</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                Description of <span id="lbl_desc_faculty5">
                                    <br />
                                    (Max. 250 Characters)</span><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                <textarea id="txt_desc_faculty5" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty5','spn_desc_faculty5_words');" onkeypress="return charcount(event,'txt_desc_faculty5','Instructor');"></textarea>
                                <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                <span id="spn_desc_faculty5_words" style="float: right; margin-bottom: 10px;">Total Character : 0</span>
                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                        <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad5" onchange="based_in_ahmedabad_change(2,5)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation5" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                            <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-3">
                                <select id="drp_is_travel_based_course5" onchange="travel_based_course_change(5)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course5" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from5" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to5" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation5" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                            <div class="form-group col-md-3">
                                <select id="drp_accommodation_needed5" onchange="accomodation_needed_change(5)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed5" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date5" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(5)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date5" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(5)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;"></div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Total Days</div>
                                    <input type="text" id="txt_accomodation_total_days5" class="marg-btm col-md-7" disabled />
                                </div>
                            </div>
                        </div>

                        <%--</div>
                        </div>--%>
                    </div>
                </div>



                <div class="panel panel-default" id="div_desc_faculty6" style="margin-top: 15px; display: none;">
                    <div class="panel-heading">
                        <b id="phead_desc_faculty6">Faculty6</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                Description of <span id="lbl_desc_faculty6">
                                    <br />
                                    (Max. 250 Characters)</span><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                <textarea id="txt_desc_faculty6" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty6','spn_desc_faculty6_words');" onkeypress="return charcount(event,'txt_desc_faculty6','Instructor');"></textarea>
                                <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                <span id="spn_desc_faculty6_words" style="float: right; margin-bottom: 10px;">Total Character : 0</span>
                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                        <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad6" onchange="based_in_ahmedabad_change(2,6)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation6" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                            <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-3">
                                <select id="drp_is_travel_based_course6" onchange="travel_based_course_change(6)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course6" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from6" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to6" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation6" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                            <div class="form-group col-md-3">
                                <select id="drp_accommodation_needed6" onchange="accomodation_needed_change(6)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed6" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date6" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(6)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date6" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(6)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;"></div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Total Days</div>
                                    <input type="text" id="txt_accomodation_total_days6" class="marg-btm col-md-7" disabled />
                                </div>
                            </div>
                        </div>

                        <%--</div>
                        </div>--%>
                    </div>
                </div>




                <div class="panel panel-default" id="div_desc_faculty7" style="margin-top: 15px; display: none;">
                    <div class="panel-heading">
                        <b id="phead_desc_faculty7">Faculty7</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                Description of <span id="lbl_desc_faculty7">
                                    <br />
                                    (Max. 250 Characters)</span><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                <textarea id="txt_desc_faculty7" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty7','spn_desc_faculty7_words');" onkeypress="return charcount(event,'txt_desc_faculty7','Instructor');"></textarea>
                                <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                <span id="spn_desc_faculty7_words" style="float: right; margin-bottom: 10px;">Total Character : 0</span>
                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                        <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad7" onchange="based_in_ahmedabad_change(2,7)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation7" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                            <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-3">
                                <select id="drp_is_travel_based_course7" onchange="travel_based_course_change(7)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course7" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from7" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to7" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation7" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                            <div class="form-group col-md-3">
                                <select id="drp_accommodation_needed7" onchange="accomodation_needed_change(7)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed7" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date7" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(7)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date7" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(7)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;"></div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Total Days</div>
                                    <input type="text" id="txt_accomodation_total_days7" class="marg-btm col-md-7" disabled />
                                </div>
                            </div>
                        </div>

                        <%--</div>
                        </div>--%>
                    </div>
                </div>


                <div class="panel panel-default" id="div_desc_faculty8" style="margin-top: 15px; display: none;">
                    <div class="panel-heading">
                        <b id="phead_desc_faculty8">Faculty8</b>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="form-group col-md-2 color-blue">
                                <%--Description of <span id="lbl_desc_faculty3"> <br/> (Max. 50 Words)</span><span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>--%>
                                Description of <span id="lbl_desc_faculty8">
                                    <br />
                                    (Max. 250 Characters)</span><span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                            </div>
                            <div class="form-group col-md-9">
                                <%--<textarea id="txt_desc_faculty3" style="width: 100%;margin-bottom: 0px;" rows="6" cols="50" name="address" onkeyup="return faculty_keyup_wordcount(event,'txt_desc_faculty3','spn_desc_faculty3_words');" onkeypress="return faculty_wordcount(event,'txt_desc_faculty3');"></textarea>--%>
                                <textarea id="txt_desc_faculty8" style="width: 100%; margin-bottom: 0px;" rows="6" cols="50" name="address" maxlength="900" onkeyup="return keyup_charcount(event,'txt_desc_faculty8','spn_desc_faculty8_words');" onkeypress="return charcount(event,'txt_desc_faculty8','Instructor');"></textarea>
                                <%--<span id="spn_desc_faculty3_words" style="float:right;margin-bottom:10px;">Total Word : 0</span>--%>
                                <span id="spn_desc_faculty8_words" style="float: right; margin-bottom: 10px;">Total Character : 0</span>
                            </div>
                        </div>

                        <%--<div class="row">
                            <div class="form-group col-md-5 color-blue" style="padding-left:13px;">--%>

                        <%--<div class="row" id="div_based_in_ahmedabad3" style="display:none;">--%>
                        <div class="row div_based_in_ahmedabad" style="display: none;">
                            <div class="form-group col-md-2 color-blue">Are you Based In Ahmedabad</div>
                            <div class="form-group col-md-5">
                                <select id="drp_based_in_ahmedabad8" onchange="based_in_ahmedabad_change(2,8)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation8" style="margin-top: 10px; display: none;">
                            <%--<div class="form-group col-md-2 color-blue">Travel based Course</div>--%>
                            <div class="form-group col-md-2 color-blue">Do you require Travel Arrangements</div>
                            <div class="form-group col-md-3">
                                <select id="drp_is_travel_based_course8" onchange="travel_based_course_change(8)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_travel_based_course8" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Source Location</div>
                                    <input type="text" id="txt_is_travel_based_course_from8" class="marg-btm col-md-7" style="" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Dest. Location</div>
                                    <input type="text" id="txt_is_travel_based_course_to8" class="marg-btm col-md-7" style="" />
                                </div>
                            </div>
                        </div>

                        <div class="row cls_travel_accomodation8" style="margin-top: 10px; display: none;">
                            <div class="form-group col-md-2 color-blue">Accommodation Needed</div>
                            <div class="form-group col-md-3">
                                <select id="drp_accommodation_needed8" onchange="accomodation_needed_change(8)">
                                    <option value="">-- Select --</option>
                                    <option value="Y">Yes</option>
                                    <option value="N">No</option>
                                </select>
                            </div>

                            <div id="div_is_accomodation_needed8" class="form-group col-md-6 color-blue" style="padding-right: 0px; display: none;">
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">From Date</div>
                                    <input type="text" id="txt_accomodation_from_date8" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(8)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">To Date</div>
                                    <input type="text" id="txt_accomodation_to_date8" class="marg-btm col-md-7" style="" onchange="accomodation_date_change(8)" />
                                </div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;"></div>
                                <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                                    <div class="form-group col-md-2 color-blue">Total Days</div>
                                    <input type="text" id="txt_accomodation_total_days8" class="marg-btm col-md-7" disabled />
                                </div>
                            </div>
                        </div>

                        <%--</div>
                        </div>--%>
                    </div>
                </div>




                <%--//end--%>
            </div>
        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Expense related to course for students</b>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="form-group col-md-2 color-blue">
                        Intake Capacity<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <select id="drpavailable_seats">
                            <option value="">-- Select Intake Capacity --</option>
                        </select>
                    </div>

                    <div class="form-group col-md-3 color-blue">
                        No of Students &nbsp;(as per SWS norms)<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-2" style="padding-left: 0;">
                        <div class="form-group col-md-3" style="padding-left: 0;">
                            Min : <span id="spn_min"></span>
                        </div>
                        <div class="form-group col-md-3">
                            Max : <span id="spn_max"></span>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">
                        Minimum Intake Capacity<span class="cls_mendatory cls_mini_student" style="display: none; color: Red;">*</span>
                         <br />
                        <span style="color:blue;">(Minimum Student Apply for This Course)</span>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txtmini_student_no" name="student_no" />
                    </div>
                    <div class="form-group col-md-3" style="display:none;">
                        <input type="text" id="is_cancel" name="is_cancel" />
                    </div>
                </div>
                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">Material Cost (INR)</div>
                    <div class="form-group col-md-1">
                        <input type="text" id="txt_material_cost" class="marg-btm" style="width: 80%;" onchange="return calc_cost();" onkeypress='return IsNumeric(event);' />
                    </div>
                    <div class="form-group col-md-2 cls_food_stay color-blue" style="display: none;">Food + Stay (INR)</div>
                    <div class="form-group col-md-1 col-md-pull-1 cls_food_stay" style="display: none;">
                        <input type="text" id="txt_food_stay" class="marg-btm" style="width: 80%;" onchange="return calc_cost();" onkeypress='return IsNumeric(event);' />
                    </div>
                    <div class="form-group col-md-2 cls_spn_local_travel color-blue">Local Travel (INR)</div>
                    <div class="form-group col-md-1 col-md-pull-1 cls_txt_local_travel">
                        <input type="text" id="txt_local_travel" class="marg-btm" style="width: 80%;" onchange="return calc_cost();" onkeypress='return IsNumeric(event);' />
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-2 color-blue" style="height: 40px;">Total approx. expense (INR)</div>
                    <div class="form-group col-md-1">
                        <div id="div_total_approx_expense" class="marg-btm" style="height: 28px; text-align: center; border-bottom: solid 1px black;"></div>
                    </div>
                </div>
                <div class="row" style="display: none;">
                    <div class="form-group col-md-2 color-blue">Travel Expense (INR)</div>
                    <div class="form-group col-md-1">
                        <input type="text" id="txt_travel_expense" class="marg-btm" style="width: 80%;" onchange="return calc_cost();" onkeypress='return IsNumeric(event);' />
                    </div>
                    <div class="form-group col-md-1">
                        <div id="div_total_expense" class="marg-btm" style="height: 28px; text-align: center; border-bottom: solid 1px black;"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Expenses to be taken care by CEPT University for the Course / Instructor</b>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="form-group col-md-2 color-blue">Materials for Work Shop (INR)</div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_material_for_workshop" class="marg-btm" style="" onchange="return calc_cost();" onkeypress='return IsNumeric(event);' />
                    </div>

                    <div class="form-group col-md-2 color-blue">Hall, Equipment, Other Outside Services Rent (INR)</div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_outside_service_rent" class="marg-btm" style="" onchange="return calc_cost();" onkeypress='return IsNumeric(event);' />
                    </div>
                </div>

                <div class="row" style="margin-top: 15px; display: none;">
                    <div class="form-group col-md-2 color-blue">Travel arrangements needed to be done</div>
                    <div class="form-group col-md-3">
                        <select id="drp_travel_arrangement_needed" onchange="travel_arrangement_change()">
                            <option value="">-- Select --</option>
                            <option value="Y">Yes</option>
                            <option value="N">No</option>
                        </select>
                    </div>

                    <div id="div_travel_arrangement_needed" class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px; display: none;">
                        <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                            <div class="form-group col-md-3 color-blue">From&nbsp;&nbsp;&nbsp;:&nbsp;</div>
                            <input type="text" id="txt_travel_arrangement_needed_from" class="marg-btm col-md-6 col-md-pull-1" style="" />
                        </div>
                        <div class="form-group col-md-6 color-blue" style="padding-left: 0px; padding-right: 0px;">
                            <div class="form-group col-md-2 col-md-pull-1 color-blue">To&nbsp;&nbsp;&nbsp;:&nbsp;</div>
                            <input type="text" id="txt_travel_arrangement_needed_to" class="marg-btm col-md-6 col-md-pull-1" style="" />
                        </div>
                    </div>
                </div>

                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">Printing & Stationary (INR)</div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_printing_stationary" class="marg-btm" style="" onkeypress='return IsNumeric(event);' />
                    </div>

                    <div class="form-group col-md-2 color-blue" style="display: none;">Hotel Accommodation Needed for Travel based Course</div>
                    <div class="form-group col-md-3" style="display: none;">
                        <select id="drp_hotel_accommodation">
                            <option value="">-- Select --</option>
                            <option value="Y">Yes</option>
                            <option value="N">No</option>
                        </select>
                    </div>
                </div>

                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-2 color-blue">Contract to be done with any institute</div>
                    <div class="form-group col-md-3">
                        <select id="drp_contract_to_be_done" onchange="contract_to_be_done_change()">
                            <option value="">-- Select --</option>
                            <option value="Y">Yes</option>
                            <option value="N">No</option>
                        </select>
                    </div>

                    <div class="form-group col-md-2 color-blue">Any other major expense (INR)</div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_other_major_expense" class="marg-btm" style="" onkeypress='return IsNumeric(event);' onchange="other_major_expense_change()" />
                    </div>
                </div>

                <div id="div_contract_to_be_done" class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue"><span id="spn_amount" style="display: none;">Amount (INR)</span></div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_contract_to_be_done" class="marg-btm" style="display: none;" onkeypress='return IsNumeric(event);' />
                    </div>

                    <div class="form-group col-md-2 color-blue cls_specify_other_major_expense" style="display: none;">Please Specify</div>
                    <div class="form-group col-md-3 cls_specify_other_major_expense" style="display: none;">
                        <input type="text" id="txt_specify_other_major_expense" class="marg-btm" />
                    </div>
                </div>

            </div>
        </div>

        <div class="panel panel-default ">
            <div class="row" style="margin-top: 10px; padding: 10px; overflow: visible;">
                <div class="form-group col-md-2 color-blue">
                   Course Start Date<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                </div>
                <div class="form-group col-md-3">
                    <input type="text" id="txt_start_date" class="marg-btm" onchange="workplan_change()" placeholder="DD/MM/YYYY" />
                </div>
                <div class="form-group col-md-1 color-blue">
                  Course End Date<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                </div>
                <div class="form-group col-md-3">
                    <input type="text" id="txt_end_date" class="marg-btm" onchange="workplan_change()" placeholder="DD/MM/YYYY" />
                </div>
                <div class="form-group col-md-2 color-blue" style="margin-left: -40px; padding: 0;">
                    Duration&nbsp;:&nbsp;<span id="spn_duration_in_days"></span>
                </div>
            </div>
        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Workplan</span></strong>
            </div>
            <div style="padding: 10px; overflow: visible;" id="div_workplan" class="panel-collapse collapse in">
                <table id="tbl_workplan" class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Day no.</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Hours</th>
                            <th style="display: none;">Topic Covered</th>
                            <th>Description</th>
                            <th>Instructor Involve</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>

                <div>
                    <table id="tbl_workplan_faculty_total">
                        <thead>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Total of Contact Hrs
                                </td>
                                <td>&nbsp;:&nbsp;
                                </td>
                                <td id="td_total_contact_hrs"></td>
                            </tr>
                            <tr>
                                <td>Duration in Days
                                </td>
                                <td>&nbsp;:&nbsp;
                                </td>
                                <td id="td_duration_in_days"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>



         <div class="panel panel-default l2l3_star_show_conso_outline">
                    <div class="panel-heading">
                        <b>Course Assessments</b>&nbsp;<span class="cls_mendatory cls_mendatory_instructor l2l3_star_show_conso_outline"
                            style="display: none; color: Red;">*</span><%--<p style="color:red;">(Not Applicable for L2-L3 studios)</p>--%>
                    </div>
                    <div class="panel-body">
                        <input type="button" id="btn_add_course_assessment" class="btn btn-primary" value="Add Assessment"
                            onclick="addCourseAssessment()" />
                        <table id="tbl_course_assessment" class="table table-bordered">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Exercises
                                    </th>
                                    <th>Assessment Percentage
                                    </th>
                                    <th>Assessment Criteria
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>


        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Upload Images</span></strong>
            </div>
            <div style="padding: 10px; overflow: visible;" id="div_upload_images" class="panel-collapse collapse in">

                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue">
                        Image Related to Course (720px X 540px)<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="courseImageUpload" id="courseImageUpload" onchange="javascript:return UploadCourseImage();" style="display: none;" />
                            </label>
                            <span id="lbl_courseimage_file_name" style="vertical-align: super;"></span>
                        </div>
                        <div>
                            <input type="image" id="img_course_image" src="" style="width: 31%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>
                    <div class="form-group col-md-1 color-blue">
                        Image Source<span class="cls_mendatory cls_mendatory_instructor" style="display: none; color: Red;">*</span>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="text" id="txt_image_source" class="marg-btm" />
                    </div>
                </div>

                <div class="row" style="margin-top: 15px;">
                    <div class="form-group col-md-1 cls_instructor1" style="display: none;">
                    </div>
                    <div class="form-group col-md-2 cls_instructor1" style="display: none;">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="instructorImageUpload1" id="instructorImageUpload1" onchange="javascript:return UploadInstructorImage(this,1);" style="display: none;" />
                            </label>
                        </div>
                        <div style="margin-top: 5%;">
                            <input type="image" id="img_instructor_image1" src="" style="width: 63%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>

                    <div class="form-group col-md-1 cls_instructor2" style="display: none;">
                    </div>
                    <div class="form-group col-md-2 cls_instructor2" style="display: none;">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="instructorImageUpload2" id="instructorImageUpload2" onchange="javascript:return UploadInstructorImage(this,2);" style="display: none;" />
                            </label>
                        </div>
                        <div style="margin-top: 5%;">
                            <input type="image" id="img_instructor_image2" src="" style="width: 63%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>

                    <div class="form-group col-md-1 cls_instructor3" style="display: none;">
                    </div>
                    <div class="form-group col-md-2 cls_instructor3" style="display: none;">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="instructorImageUpload3" id="instructorImageUpload3" onchange="javascript:return UploadInstructorImage(this,3);" style="display: none;" />
                            </label>
                        </div>
                        <div style="margin-top: 5%;">
                            <input type="image" id="img_instructor_image3" src="" style="width: 63%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>

                    <div class="form-group col-md-1 cls_instructor4" style="display: none;">
                        <%--//kapil--%>
                        
                    </div>
                    <div class="form-group col-md-2 cls_instructor4" style="display: none;">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="instructorImageUpload4" id="instructorImageUpload4" onchange="javascript:return UploadInstructorImage(this,4);" style="display: none;" />
                            </label>
                        </div>
                        <div style="margin-top: 5%;">
                            <input type="image" id="img_instructor_image4" src="" style="width: 63%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>

                    <div class="form-group col-md-1 cls_instructor5" style="display: none;">
                        //kapil
                        
                    </div>
                    <div class="form-group col-md-2 cls_instructor5" style="display: none;">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="instructorImageUpload5" id="instructorImageUpload5" onchange="javascript:return UploadInstructorImage(this,5);" style="display: none;" />
                            </label>
                        </div>
                        <div style="margin-top: 5%;">
                            <input type="image" id="img_instructor_image5" src="" style="width: 63%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>



                    <div class="form-group col-md-1 cls_instructor6" style="display: none;">
                        
                        
                    </div>
                    <div class="form-group col-md-2 cls_instructor6" style="display: none;">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="instructorImageUpload6" id="instructorImageUpload6" onchange="javascript:return UploadInstructorImage(this,6);" style="display: none;" />
                            </label>
                        </div>
                        <div style="margin-top: 5%;">
                            <input type="image" id="img_instructor_image6" src="" style="width: 63%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>



                    <div class="form-group col-md-1 cls_instructor7" style="display: none;">
                        
                        
                    </div>
                    <div class="form-group col-md-2 cls_instructor7" style="display: none;">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="instructorImageUpload7" id="instructorImageUpload7" onchange="javascript:return UploadInstructorImage(this,7);" style="display: none;" />
                            </label>
                        </div>
                        <div style="margin-top: 5%;">
                            <input type="image" id="img_instructor_image7" src="" style="width: 63%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>



                    <div class="form-group col-md-1 cls_instructor8" style="display: none;">
                        
                        
                    </div>
                    <div class="form-group col-md-2 cls_instructor8" style="display: none;">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="instructorImageUpload8 id="instructorImageUpload8" onchange="javascript:return UploadInstructorImage(this,8);" style="display: none;" />
                            </label>
                        </div>
                        <div style="margin-top: 5%;">
                            <input type="image" id="img_instructor_image8" src="" style="width: 63%; display: inline-block; border: 1px solid;" />
                        </div>
                    </div>


                </div>

                <%--<div>
                <div id="div_instructor1" class="row" style="margin-top:10px;">
                    <div class="form-group col-md-2">
                        Dr. Balvinder Singh
                    </div>
                    <div class="form-group col-md-2">
                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                            <span><strong>Upload Image</strong></span>
                            <input type="file" name="instructorImageUpload1" id="instructorImageUpload1" onchange="javascript:return UploadInstructorImage();" style="display: none;" />
                        </label>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="image" id="img_instructor_image1" src="../../WSCourseImageUpload/instructor1.png" style="width:32%;height: 100%;display:inline-block;" />
                    </div>
                </div>

                <div id="div_instructor2" class="row" style="margin-top:10px;">
                    <div class="form-group col-md-2">
                        Ajith Kaliyath
                    </div>
                    <div class="form-group col-md-2">
                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                            <span><strong>Upload Image</strong></span>
                            <input type="file" name="instructorImageUpload2" id="instructorImageUpload2" onchange="javascript:return UploadInstructorImage();" style="display: none;" />
                        </label>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="image" id="img_instructor_image2" src="../../WSCourseImageUpload/instructor1.png" style="width:32%;height: 100%;display:inline-block;" />
                    </div>
                </div>

                <div id="div_instructor3" class="row" style="margin-top:10px;">
                    <div class="form-group col-md-2">
                        Biswaroop Das
                    </div>
                    <div class="form-group col-md-2">
                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                            <span><strong>Upload Image</strong></span>
                            <input type="file" name="instructorImageUpload3" id="instructorImageUpload3" onchange="javascript:return UploadInstructorImage();" style="display: none;" />
                        </label>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="image" id="img_instructor_image3" src="../../WSCourseImageUpload/instructor1.png" style="width:32%;height: 100%;display:inline-block;" />
                    </div>
                </div>
                </div>--%>

                <%--<div class="row" style="margin-top:10px;">
                    <div class="form-group col-md-12">
                        <table>
                            <tr>
                                <td>
                                    Dr. Balvinder Singh
                                </td>
                                <td>
                                    <div>
                                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                            <span><strong>Upload Image</strong></span>
                                            <input type="file" name="instructorImageUpload1" id="instructorImageUpload1" onchange="javascript:return UploadInstructorImage();" style="display: none;" />
                                        </label>
                                    </div>
                                    <div>
                                        <input type="image" id="img_instructor_image1" src="../../WSCourseImageUpload/instructor1.png" style="width:32%;display:inline-block;" />
                                    </div>
                                </td>
                                <td>
                                    Ajith Kaliyath
                                </td>
                                <td>
                                    <div>
                                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                            <span><strong>Upload Image</strong></span>
                                            <input type="file" name="instructorImageUpload2" id="instructorImageUpload2" onchange="javascript:return UploadInstructorImage();" style="display: none;" />
                                        </label>
                                    </div>
                                    <div>
                                        <input type="image" id="img_instructor_image2" src="../../WSCourseImageUpload/instructor1.png" style="width:32%;display:inline-block;" />
                                    </div>
                                </td>
                                <td>
                                    Biswaroop Das
                                </td>
                                <td>
                                    <div>
                                        <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                            <span><strong>Upload Image</strong></span>
                                            <input type="file" name="instructorImageUpload3" id="instructorImageUpload3" onchange="javascript:return UploadInstructorImage();" style="display: none;" />
                                        </label>
                                    </div>
                                    <div>
                                        <input type="image" id="img_instructor_image3" src="../../WSCourseImageUpload/instructor1.png" style="width:32%;display:inline-block;" />
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>--%>
            </div>
        </div>


        




        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Portfolio</span></strong>
            </div>
            <div style="padding: 10px; overflow: visible;" id="div_portfolio" class="panel-collapse collapse in">

                <input type="button" id="btn_portfolio_add" value="Add Portfolio" onclick="add_portfolio()" />

                <table id="tbl_portfolio" class="table table-bordered" style="margin-top: 10px;">
                    <thead>
                        <tr>
                            <th style="width: 275px;">Portfolio Title</th>
                            <th style="width: 275px;">Portfolio Link</th>
                            <th>Portfolio Image (Max 5 MB)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%--<tr>
                            <td>
                                <input type="text" id="txt_portfolio_title" class="marg-btm cls_portfolio_title" style="" />
                            </td>
                            <td>
                                <input type="text" id="txt_portfolio_link" class="marg-btm cls_portfolio_link" style="" />
                            </td>
                            <td>
                                <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                    <span><strong>Upload Image</strong></span>
                                    <input type="file" name="portfolioImageUpload" id="portfolioImageUpload" onchange="javascript:return UploadPortfolioImage();" style="display: none;" />
                                </label>
                                <span id="lbl_portfolioimage_file_name" class="cls_portfolio_image_name" style="vertical-align: super;"></span>
                            </td>
                        </tr>--%>
                    </tbody>
                </table>

                <%--<div class="row">
                    <div class="form-group col-md-2 color-blue">Portfolio Title</div>
                    <div class="form-group col-md-3"><input type="text" id="txt_portfolio_title" class="marg-btm" style="" /></div>
                </div>
                <div class="row">
                    <div class="form-group col-md-2 color-blue">Portfolio Link</div>
                    <div class="form-group col-md-3"><input type="text" id="txt_portfolio_link" class="marg-btm" style="" /></div>
                </div>
                <div class="row" style="margin-top:10px;">
                    <div class="form-group col-md-2 color-blue">
                        Portfolio Image<span class="cls_mendatory cls_mendatory_instructor" style="display:none;color:Red;">*</span>
                    </div>
                    <div class="form-group col-md-4">
                        <div>
                            <label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;">
                                <span><strong>Upload Image</strong></span>
                                <input type="file" name="portfolioImageUpload" id="portfolioImageUpload" onchange="javascript:return UploadPortfolioImage();" style="display: none;" />
                            </label>
                            <span id="lbl_portfolioimage_file_name" style="vertical-align: super;"></span>
                        </div>
                        <div>
                            <input type="image" id="img_portfolio_image" src="" style="width:31%;display:inline-block;border:1px solid;" />
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <input class="form-check-input" type="checkbox" value="Y" id="termsandcondition"/> 
                <strong><span class="panel-headingfont">&nbsp;&nbsp;Terms and Condition</span></strong>
            </div>
            <div class="row" style="padding: 20px; overflow: visible;">
                <div class="form-group col-sm-12 color-blue">
                    <label class="form-check-label" for="flexCheckDefault">
                        <p>Part of the Summer Winter School policy, all the work done by the students will be properly archived and kept for the reference for the student as well as faculty. Kindly design a suitable output in form of posters, videos, documentation, Paper, booklet, etc.</p>
                        <br />
                        <p>Please note that ownership of intellectual property such as teaching materials, outputs, products, ideas finalized etc. developed by the full time and adjunct faculty members, visiting faculty, academic associate, teaching associate, students and other participating
                           in the Summer & Winter school programs of CEPT University, including experts will vest with CEPT University.
                        </p>
                        <br />
                        <p>Apart from the above mentioned terms we would request you to please refer to the faculty guidelines given on our SWS website.</p>
                    </label>
                </div>
            </div>
        </div>

        <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_course_code" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_sem" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_year" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_sws" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdnuserid" runat="server" ClientIDMode="Static" />
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

    <script type="text/javascript">

        var action = 'S';
        var btnTAClicked = false;
        $(document).ready(function ()
        {
            //var request = indexedDB.open("MyDatabase", 1);
            //request.onupgradeneeded = function (event) {
            //    var db = event.target.result;
            //    var objectStore = db.createObjectStore("myObjectStore", { keyPath: "id" });
            //    objectStore.createIndex("nameIndex", "name", { unique: false });
            //};

            //request.onsuccess = function (event) {
            //    var db = event.target.result;
            //    console.log("Database opened successfully");
            //};

            //request.onerror = function (event) {
            //    console.error("Database error: ", event.target.errorCode);
            //};

            bindinstructor();
            bindinstructorTA();
            get_intake_criteria();
            if ($('#hdnusertype').val() != 'I2') {
                $('#for_I2').css('display', 'none');
            }
            //$('#txt_start_date').datepicker({ dateFormat: 'dd/mm/yy' });
            //$('#txt_end_date').datepicker({ dateFormat: 'dd/mm/yy' });

            //$("#txt_start_date").change(function () {
            //    var temp_date = convertDateFormat_for_end_date($("#txt_start_date").val());
            //    $("#txt_end_date").datepicker("option", "minDate", temp_date);
            //});

            //$('#txt_accomodation_from_date').datepicker({ dateFormat: 'dd/mm/yy' });
            //$('#txt_accomodation_to_date').datepicker({ dateFormat: 'dd/mm/yy' });

            //for (var i = 1; i <= 3; i++) {
            //    $('#txt_accomodation_from_date' + i).datepicker({ dateFormat: 'dd/mm/yy' });
            //    $('#txt_accomodation_to_date' + i).datepicker({ dateFormat: 'dd/mm/yy' });
            //}

            SetDatePicker('#txt_start_date', '#txt_end_date');
            SetDatePicker('#txt_accomodation_from_date', '#txt_accomodation_to_date');
            SetDatePicker('#txt_tral_start_date', '#txt_tral_end_date');
            var DatePickerString = "";
            for (var i = 1; i <= 3; i++)
            {
                DatePickerString += ", #txt_accomodation_from_date" + i + ", #txt_accomodation_to_date" + i;
                SetDatePicker('#txt_accomodation_from_date' + i, '#txt_accomodation_to_date' + i);
            }
            $('#txt_start_date, #txt_end_date, #txt_accomodation_from_date, #txt_accomodation_to_date,#txt_tral_start_date,#txt_tral_end_date' + DatePickerString).on('focus', function ()
            {
                $('.datepicker-switch').on('click', function () {
                    if (this.parentElement.parentElement.parentElement.parentElement.className == "datepicker-days") {
                        setTimeout(function () {
                            $('.datepicker-months')[0].childNodes[0].childNodes[0].childNodes[0].childNodes[1].click();
                        }, 1);
                    }
                });
            });


            
            if ($('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D' || $('#hdnusertype').val() == 'FA') {
                var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                    "<i class='icon-save bigger-160'></i>Save</button></td> " +
                    "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                    "<i class='icon-save bigger-160'></i>Next</button></td></tr></table>";
                $('#submitBtnDiv').html(str);
            }
            else if ($('#hdnusertype').val() == 'I2') {
                var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='but_preview' type='button' style='display: block' class='btn btn-primary'> << Previous</button></td>" +
                    "<td align='' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'><i class='icon-save bigger-160'></i>Save</button></td> " +
                    "<td align='center' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block;margin-left: -200%;' class='btn btn-primary'> " +
                    "<i class='icon-save bigger-160'></i>Next</button></td></tr></table>";
                $('#submitBtnDiv').html(str);
            }
            else if ($('#hdnusertype').val() == 'WSA' || $('#hdnusertype').val() == 'A') {
                //var str = "<table style='width: 50%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                //    "<i class='icon-save bigger-160'></i>Save</button></td> <td align='center' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block;margin-left: -200%;' class='btn btn-primary'><i class='icon-save bigger-160'></i>Next</button></td></tr></table>";
                //$('#submitBtnDiv').html(str);
                var str = "<table style='width: 100%'><tr><td align='right' style='padding-left:20px;'><button id='btnsave' type='button' style='display: block' class='btn btn-primary'>" +
                    "<i class='icon-save bigger-160'></i>Save</button></td> " +
                    "<td align='left' style='padding-left:40px;'><button id='btnapprove' type='button' style='display: block' class='btn btn-primary'> " +
                    "<i class='icon-save bigger-160'></i>Next</button></td></tr></table>";
                $('#submitBtnDiv').html(str);
            }

            //$('#btn_instructor').on('click', function () {
            //    if ($('#tblinstructor tbody tr').length < 5) {//kapil
            //        var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric(event);' /></td>" +
            //            " <td><center><input type='radio' name='rdo_faculty_type" + $('#tblinstructor tbody tr').length + "' value='1' onchange='category_location_change()' /></center></td>" +
            //            " <td><center><input type='radio' name='rdo_faculty_type" + $('#tblinstructor tbody tr').length + "' value='2' onchange='category_location_change()' /></center></td>" +
            //            " <td><center><input type='radio' name='rdo_faculty_type" + $('#tblinstructor tbody tr').length + "' value='3' onchange='category_location_change()' /></center></td>" +
            //            " <td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
            //        " <td></td></tr>";
            //        $('#tblinstructor tbody').append(str);

            //        category_location_change();
            //        set_faculty_involve_drp();
            //    }
            //    return false;
            //});

            $('#btn_instructor').on('click', function () {
                if ($('#hdnusertype').val() != 'I2') {
                    if ($('#drp_credits').val() == '' || $('#drp_credits').val() == null) {
                        alert('Please select credits before adding instructor');
                        $('#drp_credits').focus();
                        return false;
                    }
                }
                if ($('#tblinstructor tbody tr').length < 8) {//kapil // changes by nitinbhai 11092025
                    var str = " <tr><td>" + instructor + "</td>" +
                    " <td><input style='width: 60px;' type='text' class='per_load' maxlength='5' onkeypress='return IsNumeric(event);' id='ContactHours_" + $('#tblinstructor tbody tr').length + "' onchange='CalculateTotalHours(this)' /></td>" +
                    " <td><input style='width: 60px;' type='text' class='Addtional_Hours' maxlength='5' onkeypress='return IsNumeric(event);' id='AddtionalHours_" + $('#tblinstructor tbody tr').length + "' onchange='CalculateTotalHours(this)' /></td>" +
                    " <td><input style='width: 60px;' type='text' class='Total_Hours' maxlength='5' onkeypress='return IsNumeric(event);' id='TotalHours_" + $('#tblinstructor tbody tr').length + "' disabled='disabled'/></td>" +
                    " <td><center><input type='radio' name='rdo_faculty_type" + $('#tblinstructor tbody tr').length + "' value='1' onchange='category_location_change()' /></center></td>" +
                    " <td><center><input type='radio' name='rdo_faculty_type" + $('#tblinstructor tbody tr').length + "' value='2' onchange='category_location_change()' /></center></td>" +
                    " <td><center><input type='radio' name='rdo_faculty_type" + $('#tblinstructor tbody tr').length + "' value='3' onchange='category_location_change()' /></center></td>" +
                    " <td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                    " <td></td></tr>";
                    $('#tblinstructor tbody').append(str);

                    btnTAClicked = true;
                    category_location_change();
                    set_faculty_involve_drp();
                    SetContactHours();
                    BindTrashIconDeleteEvent();
                }
                return false;
            });

            
            $('#btn_TA').on('click', function () {

                if ($('#drp_credits').val() == '' || $('#drp_credits').val() == null) {
                    alert('Please select credits before adding instructor');
                    $('#drp_credits').focus();
                    return false;
                }
                if ($('#tblTA tbody tr').length < 5) {//kapil
                    var str = "<tr><td>" + TA + "</td>" +
                        " <td><input style='width: 60px;' type='text' class='TAper_load' maxlength='5' onkeypress='return IsNumeric(event);' id='TAContactHours_" + $('#tblTA tbody tr').length + "' onchange='TACalculateTotalHours(this)' /></td>" +
                        " <td><input style='width: 60px;' type='text' class='TAAddtional_Hours' maxlength='5' onkeypress='return IsNumeric(event);' id='TAAddtionalHours_" + $('#tblTA tbody tr').length + "' onchange='TACalculateTotalHours(this)' /></td>" +
                        " <td><input style='width: 60px;' type='text' class='TATotal_Hours' maxlength='5' onkeypress='return IsNumeric(event);' id='TATotalHours_" + $('#tblTA tbody tr').length + "' disabled='disabled'/></td>" +
                        " <td><center><input type='radio' name='TArdo_faculty_type" + $('#tblTA tbody tr').length + "' value='1' onchange='category_location_change()' /></center></td>" +
                        " <td><center><input type='radio' name='TArdo_faculty_type" + $('#tblTA tbody tr').length + "' value='2' onchange='category_location_change()' /></center></td>" +
                        " <td><center><input type='radio' name='TArdo_faculty_type" + $('#tblTA tbody tr').length + "' value='3' onchange='category_location_change()' /></center></td>" +
                        " <td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                    " <td></td></tr>";
                    $('#tblTA tbody').append(str);
                    btnTAClicked = true;
                    category_location_change();
                    set_faculty_involve_drp();
                    SetContactHours();
                    BindTrashIconDeleteEvent();
                }
                return false;
            });

            $('#btnapprove').click(function () {
                action = 'A';
                savedata();
            });

            $('#btnsave').click(function () {
                savedata();
            });

            if ($('#hdn_course_code').val() != '' && $('#hdn_sem').val() != '' && $('#hdn_year').val() != '') {
                get_course_data();
            }
            else if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D') {
                if ($('#tblinstructor tbody tr').length == 0) {
                    $('#btn_instructor').click();

                    if ($('#hdnuserid').val() != 'temp_student') {
                        //$('#tblinstructor tbody .drpinstructor')[0].disabled = true;
                    }

                    $('#tblinstructor tbody tr')[0].children[7].innerHTML = '';
                    $('#tblinstructor tbody .drpinstructor')[0].value = $('#hdnuserid').val();
                    $('#lbl_desc_faculty1').html($('#tblinstructor tbody tr')[0].children[0].children[0].selectedOptions[0].innerHTML + '  <br/> (Max. 100 Words)');
                    $('#phead_desc_faculty1').html($('#tblinstructor tbody tr')[0].children[0].children[0].selectedOptions[0].innerHTML);
                    
                    if (obj_instructor[$('#tblinstructor tbody .drpinstructor')[0].value] == 'instructor')
                        $($('#tblinstructor tbody .drpinstructor')[0]).closest('tr').find('input[type="radio"][value="1"]')[0].checked = true;
                    else if (obj_instructor[$('#tblinstructor tbody .drpinstructor')[0].value] == 'VF')
                        $($('#tblinstructor tbody .drpinstructor')[0]).closest('tr').find('input[type="radio"][value="2"]')[0].checked = true;

                    $('.cls_instructor1')[0].innerHTML = $('#tblinstructor tbody tr')[0].children[0].children[0].selectedOptions[0].innerHTML + '<br />' + '(200px X 240px)';
                }
            }
            
            $("#ip").css('background-color', 'grey');
            $("#pd").css('background-color', 'white');
            $("#pd").addClass("active");
            $("#ip").removeClass("active");
            $('#but_preview').click(function () {
                var url = "personal_detail_sws.aspx?ws=" + $("#hdnuserid").val();
                window.open(url, "_self");
            });
            if ($('#hdnusertype').val() != 'I2')
            {
                $('#for_I2').css('display', 'none');
            }

            $('#txtmini_student_no').keypress(function (e) {

                var charCode = (e.which) ? e.which : event.keyCode

                if (String.fromCharCode(charCode).match(/[^0-9]/g))

                    return false;

            });
          
        });

        function SetDatePicker(StartDateId, EndDateId) {
            $(StartDateId).datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
               // endDate: new Date()
            }).on('changeDate', function (ev) {
                $(EndDateId).datepicker('setStartDate', ev.date);
            });
            $(EndDateId).datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true
                //endDate: new Date()
            }).on('changeDate', function (ev) {
                $(StartDateId).datepicker('setEndDate', ev.date);
            });
        }
        function CalculateTotalHours(E) {
            var Id = E.id.split('_')[1];
            $("#TotalHours_" + Id).val((!isNaN($("#ContactHours_" + Id).val()) && $("#ContactHours_" + Id).val() != null && $("#ContactHours_" + Id).val() != '' ? parseInt($("#ContactHours_" + Id).val()) : 0) + (!isNaN($("#AddtionalHours_" + Id).val()) && $("#AddtionalHours_" + Id).val() != null && $("#AddtionalHours_" + Id).val() != '' ? parseInt($("#AddtionalHours_" + Id).val()) : 0));
        }
        function TACalculateTotalHours(E) {
            var Id = E.id.split('_')[1];
            $("#TATotalHours_" + Id).val((!isNaN($("#TAContactHours_" + Id).val()) && $("#TAContactHours_" + Id).val() != null && $("#TAContactHours_" + Id).val() != '' ? parseInt($("#TAContactHours_" + Id).val()) : 0) + (!isNaN($("#TAAddtionalHours_" + Id).val()) && $("#TAAddtionalHours_" + Id).val() != null && $("#TAAddtionalHours_" + Id).val() != '' ? parseInt($("#TAAddtionalHours_" + Id).val()) : 0));
        }
        function SetContactHours() {
            var ContactHrs = $('#drp_credits').val() * 12;
            var AdditionalHrs = $('#drp_credits').val() * 12;
            var InstructorCount = $('#tblinstructor tbody tr').length;

            for (var i = 0; i < InstructorCount; i++) {
                // if (!(!isNaN($("#ContactHours_" + i).val()) && $("#ContactHours_" + i).val() != null && $("#ContactHours_" + i).val() != '')) {
                //$("#ContactHours_" + i).val(ContactHrs / InstructorCount);
                $("#ContactHours_" + i).val(ContactHrs);
                // 29082023
                $("#AddtionalHours_" + i).val(AdditionalHrs / InstructorCount);
                var add_hrs = (AdditionalHrs / InstructorCount);
                //$("#TotalHours_" + i).val((ContactHrs + AdditionalHrs) / InstructorCount);
                $("#TotalHours_" + i).val(ContactHrs + add_hrs);
                //}
            }

            //var TACount = $('#tblTA tbody tr').length;
            //for (var Id = 0; Id < TACount; Id++) {
            //    $("#TATotalHours_" + Id).val((!isNaN($("#TAContactHours_" + Id).val()) && $("#TAContactHours_" + Id).val() != null && $("#TAContactHours_" + Id).val() != '' ? parseInt($("#TAContactHours_" + Id).val()) : 0) + (!isNaN($("#TAAddtionalHours_" + Id).val()) && $("#TAAddtionalHours_" + Id).val() != null && $("#TAAddtionalHours_" + Id).val() != '' ? parseInt($("#TAAddtionalHours_" + Id).val()) : 0));
            //}

            //var TACount = $('#tblTA tbody tr').length;
            //for (var i = 0; i < TACount; i++) {
            //    $("#TAContactHours_" + i).val(ContactHrs / TACount);
            //    $("#TAAddtionalHours_" + i).val(AdditionalHrs / TACount);
            //    $("#TATotalHours_" + i).val((ContactHrs + AdditionalHrs) / TACount);
            //}
            //$('#tblinstructor tbody tr').length
        }
        function bindinstructorTA() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_faculty_data_TA",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var instructor_data = JSON.parse(data.d)
                        TA = "<select style='width:85%' class='drpinstructor' onchange='set_faculty_involve_drp(1)'><option value=''>&lt; Select Instructor &gt;</option>";
                        for (var i = 0; i < instructor_data.length; i++)
                        {
                            TA = TA + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                            obj_instructor[instructor_data[i]["instructor_code"]] = instructor_data[i]["designation"];
                        }
                        TA = TA + "</select>";
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function IsNumeric(e) {
            //var pattern = /^([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})$/;
            //pattern = /^[+-]?\d+(\.\d+)?$/; // Decimal

            //if (!pattern.test($('#txt_dob').val())) {
            //    bootbox.alert('Please Enter Date of Birth in DD/MM/YYYY format');
            //    action = 'S';
            //    return false;
            //}

            var keyCode = e.which ? e.which : e.keyCode;

            if (keyCode == 8 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
                return true;
            }

            if (keyCode >= 48 && keyCode <= 57) {

                //                if (parseInt($(document.activeElement).val()) > 10) {
                //                    return false;
                //                }
                //                else if (parseInt($(document.activeElement).val()) == 10) {
                //                    if (keyCode != 48) {
                //                        return false;
                //                    }
                //                }

                return true;
            }
            else {
                return false;
            }
        }

        //        function IsNumeric_old(e) {
        //            //alert(e.which + " : " + e.keyCode);

        //            var keyCode = e.which ? e.which : e.keyCode;

        //            if (keyCode == 8 || keyCode == 46 || keyCode == 37 || keyCode == 38 || keyCode == 39 || keyCode == 40 || keyCode == 9) {
        //                return true;
        //            }

        //            if (keyCode >= 48 && keyCode <= 57) {

        //                if (parseInt($(document.activeElement).val()) > 10) {
        //                    return false;
        //                }
        //                else if (parseInt($(document.activeElement).val()) == 10) {
        //                    if (keyCode != 48) {
        //                        return false;
        //                    }
        //                }

        //                return true;

        //            }
        //            else {
        //                return false;
        //            }
        //        }

        function other_output_change() {
            if ($('#Others')[0].checked) $('#txt_other_output').css('display', 'inline-block');
            else $('#txt_other_output').css('display', 'none');
        }

        function setTimepicker() {
            $(".from_time").timepicker({ 'minTime': '8:00am' });
            $(".to_time").timepicker({ 'minTime': '8:00am' });
        }

        function calc_cost() {
            var material_cost = 0;
            var food_stay = 0;
            var local_travel = 0;
            var approx_expense = 0;
            var travel_expense = 0;
            var total_expense = 0;

            if ($('#txt_material_cost').val() != '')
                if (isNaN($('#txt_material_cost').val()) && parseFloat($('#txt_material_cost').val()).toString() == 'NaN') bootbox.alert('Material Cost must be a Numeric value');
                else material_cost = parseFloat($('#txt_material_cost').val());

            if ($('#txt_food_stay').val() != '')
                if (isNaN($('#txt_food_stay').val()) && parseFloat($('#txt_food_stay').val()).toString() == 'NaN') bootbox.alert('Food Stay must be a Numeric value');
                else food_stay = parseFloat($('#txt_food_stay').val());

            if ($('#txt_local_travel').val() != '')
                if (isNaN($('#txt_local_travel').val()) && parseFloat($('#txt_local_travel').val()).toString() == 'NaN') bootbox.alert('Local Travel must be a Numeric value');
                else local_travel = parseFloat($('#txt_local_travel').val());

            approx_expense = material_cost + food_stay + local_travel;
            $('#div_total_approx_expense').html(approx_expense);

            if ($('#txt_travel_expense').val() != '') {
                if (isNaN($('#txt_travel_expense').val()) && parseFloat($('#txt_travel_expense').val()).toString() == 'NaN') bootbox.alert('Travel Expense must be a Numeric value');
                else travel_expense = parseFloat($('#txt_travel_expense').val());
            }

            total_expense = approx_expense + travel_expense;
            $('#div_total_expense').html(total_expense);
        }

        var title_char_cnt_flag = 1;
        function title_charcount(e) {
            //if (e.keyCode == 22 || e.which == 22 || e.keyCode == 108 || e.which == 108)

            //if ($('#txtcourse_title').val().length >= 125) {
            if ($('#txtcourse_title').val().length >= 95) {
                //bootbox.alert('You Exceeds the Character Limit');
                if (title_char_cnt_flag == 1) {
                    title_char_cnt_flag = 0;
                    bootbox.alert('You Exceeds the Character Limit', function () {
                        title_char_cnt_flag = 1;
                    });
                }
                return false;
            }
        }

        function keyup_title_charcount(e) {
            /////Character
            $('#spn_title').html('' + 'Total Char : ' + $('#txtcourse_title').val().length);
        }

        var char_cnt_flag = 1;
        function charcount(e, txt_id, max_length) {

            if (max_length == 'Instructor') max_length = faculty_word_limit;

            //if ($('#txtcourse_title').val().length >= 95) {
            if ($('#' + txt_id).val().length >= max_length) {
                if (char_cnt_flag == 1) {
                    char_cnt_flag = 0;
                    bootbox.alert('You Exceeds the Character Limit', function () {
                        char_cnt_flag = 1;
                    });
                }
                return false;
            }
        }

        function keyup_charcount(e, txt_id, spn_id) {
            //$('#spn_title').html('' + 'Total Char : ' + $('#txtcourse_title').val().length);
            $('#' + spn_id).html('' + 'Total Char : ' + $('#' + txt_id).val().length);
        }

        var word_cnt_flag = 1;
        function wordcount(e, txt_id) {
            //if (e.keyCode == 22 || e.which == 22 || e.keyCode == 108 || e.which == 108)

            //var arr_words = $('#txtcourse_description').val().trim().split(/\n| /g);
            var arr_words = $('#' + txt_id).val().trim().split(/\n| /g);

            while (arr_words.indexOf('') > -1) {
                arr_words.splice(arr_words.indexOf(''), 1);
            }

            var false_flag = false;
            if (arr_words.length == 300)
            {

                //var last_char = $('#txtcourse_description').val()[$('#txtcourse_description').val().length - 1];
                var last_char = $('#' + txt_id).val()[$('#' + txt_id).val().length - 1];

                if (last_char == ' ' || last_char == '\n') {
                    false_flag = true;
                }
            }
            else if (arr_words.length > 300) {
                false_flag = true;
            }

            if (false_flag) {
                //bootbox.alert('You Exceeds the Word Limit');
                if (word_cnt_flag == 1) {
                    word_cnt_flag = 0;
                    bootbox.alert('You Exceeds the Word Limit', function () {
                        word_cnt_flag = 1;
                    });
                }
                return false;
            }
        }
        function keyup_wordcount(e, txt_id, spn_id) {

            //var arr_words = $('#txtcourse_description').val().trim().split(/\n| /g);
            var arr_words = $('#' + txt_id).val().trim().split(/\n| /g);

            while (arr_words.indexOf('') > -1) {
                arr_words.splice(arr_words.indexOf(''), 1);
            }

            //$('#spn_desc').html('' + 'Total Word : ' + arr_words.length);
            $('#' + spn_id).html('' + 'Total Word : ' + arr_words.length);
        }

        var faculty_word_cnt_flag = 1;
        var faculty_word_limit = 100;
        function faculty_wordcount(e, txt_id) {
            var arr_words = $('#' + txt_id).val().trim().split(/\n| /g);

            while (arr_words.indexOf('') > -1) {
                arr_words.splice(arr_words.indexOf(''), 1);
            }

            var false_flag = false;
            if (arr_words.length == faculty_word_limit) {
                var last_char = $('#' + txt_id).val()[$('#' + txt_id).val().length - 1];

                if (last_char == ' ' || last_char == '\n') {
                    false_flag = true;
                }
            }
            else if (arr_words.length > faculty_word_limit) {
                false_flag = true;
            }

            if (false_flag) {
                if (faculty_word_cnt_flag == 1) {
                    faculty_word_cnt_flag = 0;
                    bootbox.alert('You Exceeds the Word Limit', function () {
                        faculty_word_cnt_flag = 1;
                    });
                }
                return false;
            }
        }
        function faculty_keyup_wordcount(e, txt_id, spn_id) {
            var arr_words = $('#' + txt_id).val().trim().split(/\n| /g);

            while (arr_words.indexOf('') > -1) {
                arr_words.splice(arr_words.indexOf(''), 1);
            }

            $('#' + spn_id).html('' + 'Total Word : ' + arr_words.length);
        }

        var FileName = '';
        function UploadCourseImage() {
            try {
                var fileToUpload = GetFileNameFromPath($('#courseImageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/WSCourseImage_upload.ashx',
                                secureuri: false,
                                fileElementId: 'courseImageUpload',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#courseImageUpload').val("");
                                            $('#lbl_courseimage_file_name').html('<b>' + fileToUpload + '</b>');

                                            FileName = data.upfile;

                                            $('#img_course_image').attr('src', '../../WSCourseImageUpload/' + FileName + '?' + (new Date()).getTime());
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
                    alert('Invalid File Type. Please upload jpeg / png file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function add_portfolio() {
            var portfolio_len = $('#tbl_portfolio tbody tr').length;
            if (portfolio_len < 3) {
                var str_portfolio_row = '';

                str_portfolio_row += '<tr><td><input type="text" id="txt_portfolio_title' + (portfolio_len + 1) + '" class="marg-btm cls_portfolio_title" style="" /></td>' +
                    '<td><input type="text" id="txt_portfolio_link' + (portfolio_len + 1) + '" class="marg-btm cls_portfolio_link" style="" /></td>' +
                    '<td><label class="btn btn-primary btn-small file-upload " style="vertical-align: bottom;"><span><strong>Upload Image</strong></span>' +
                    '<input type="file" name="portfolioImageUpload' + (portfolio_len + 1) + '" id="portfolioImageUpload' + (portfolio_len + 1) + '" onchange="javascript:return UploadPortfolioImage(' + (portfolio_len + 1) + ');" style="display: none;" />' +
                    '</label><span id="lbl_portfolioimage_file_name' + (portfolio_len + 1) + '" class="cls_portfolio_image_name" style="vertical-align: super;"></span>' +
                    '</td></tr>';

                $('#tbl_portfolio tbody').append(str_portfolio_row);
            }
        }

        var FileName_Portfolio = '';
        var obj_FileName_Portfolio = {};
        function UploadPortfolioImage(id) {
            try {
                var fileToUpload = GetFileNameFromPath($('#portfolioImageUpload' + id).val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                var extension = fileToUpload.substr((fileToUpload.lastIndexOf('.') + 1));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/WSPortfolioImage_upload.ashx?t=' + (new Date()).getTime() + '.' + extension,
                                secureuri: false,
                                fileElementId: 'portfolioImageUpload' + id,
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#portfolioImageUpload' + id).val("");
                                            $('#lbl_portfolioimage_file_name' + id).html('<b>' + fileToUpload + '</b>');

                                            FileName_Portfolio = data.upfile;
                                            obj_FileName_Portfolio['lbl_portfolioimage_file_name' + id] = data.upfile;

                                            //$('#img_portfolio_image' + id).attr('src', '../../WSPortfolioImageUpload/' + FileName_Portfolio + '?' + (new Date()).getTime());
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
                    alert('Invalid File Type. Please upload jpeg / png file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function UploadInstructorImage(cur_element, element_sr_no) {
            try {
                var fileToUpload = GetFileNameFromPath($('#instructorImageUpload' + element_sr_no).val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;
                    var extension = fileToUpload.substr((fileToUpload.lastIndexOf('.') + 1));
                    var instructor_id = $("#tblinstructor tbody tr")[element_sr_no - 1].getElementsByClassName('drpinstructor')[0].value;
                    $('#img_instructor_image' + element_sr_no).attr('src', '');

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/WSInstructorPhotoUpload.ashx?filename=' + instructor_id + '.' + 'png',//+ extension,
                                secureuri: false,
                                fileElementId: 'instructorImageUpload' + element_sr_no,
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#instructorImageUpload' + element_sr_no).val("");

                                            //$('#img_instructor_image' + element_sr_no).attr('src', '');
                                            $('#img_instructor_image' + element_sr_no).attr('src', '../../UserPersonalPhoto/WS_' + instructor_id + '.' + 'png');/*extension + '?' + (new Date()).getTime());*/
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
                    alert('Invalid File Type. Please upload jpeg / png file');
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

        function savedata() {
           
            var obj_course_data = { 'course_code': '', 'course_title': '', 'category_location_wise': '', 'location': '', 'intake_capacity': '', 'credits': '', 'description': '', 'prerequisite': '', 'is_open_for_professional': '', 'professional_prerequisite': '', 'start_date': '', 'end_date': '', 'gpa_status': '', 'course_image': '', 'image_source': '', 'inhabitation': '', 'methodology': '', 'course_output1': '', 'course_output2': '', 'course_output3': '', 'material_for_workshop': '', 'outside_service_rent': '', 'travel_arrangement_needed': '', 'travel_arrangement_needed_from': '', 'travel_arrangement_needed_to': '', 'is_travel_based_course': '', 'is_travel_based_course_from': '', 'is_travel_based_course_to': '', 'accommodation_needed': '', 'hotel_accommodation': '', 'is_contract_to_be_done': '', 'rs_contract_to_be_done': '', 'other_major_expense': '', 'other_major_expense_specify': '', 'printing_stationary': '', 'instructor': '', 'workplan': '', 'material_cost': '', 'food_stay': '', 'local_travel': '', 'approx_expense': '', 'travel_expense': '', 'total_expense': '', 'workplan': '', 'total_instructors_involved': '', 'is_based_in_ahmedabad': '', 'accommodation_needed_from_date': '', 'accommodation_needed_to_date': '', 'accommodation_needed_total_days': '', 'portfolio': '', 'learning_outcomes': '', 'termsandcondition': '', 'minimum_seat': '', 'coursebudget_filepath': '', 'TravelStartDate': '', 'TravelEndDate': '', 'course_type': '', 'course_assessment': '' };

            obj_course_data.course_code = $('#hdn_course_code').val();

            if ($('#txtcourse_title').val() == '') {
                bootbox.alert('Please Enter Course Title');
                return false;
            }

            if ($('#txtcourse_description').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Course Description');
                return false;
            }

            if ($('#learning_outcomes').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Learning Outcomes');
                return false;
            }

            if ($('#drp_inhabitation').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Inhabitation');
                return false;
            }

            if ($('#drp_credits').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Credits');
                return false;
            }

            if ($('#drp_gpa_status').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select GPA Status');
                return false;
            }

            if ($('#drp_category_location_wise').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Category Location Wise');
                return false;
            }

            if ($('#txt_location').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Location');
                return false;
            }

            //if ($('#txtcourse_title').val() != '' && $('#txtcourse_title').val().length > 125) {
            if ($('#txtcourse_title').val() != '' && $('#txtcourse_title').val().length > 95) {
                bootbox.alert('Course Title Exceeds the Character Limit');
                return false;
            }

            if ($('#drp_course_type').val() == '' ) {
                bootbox.alert('Please Select Course Type');
                return false;
            }


            //for (var i = 0; i < $('.drpinstructor').length; i++) {
            //    if ($('.drpinstructor')[i].value == '') {
            //        bootbox.alert('Please Select Instructor');
            //        return false;
            //    }
            //}

            for (var i = 0; i < $('.drpinstructor').length; i++) {
                if ($('.drpinstructor')[i].value == '') {
                    if ($('.drpinstructor')[i].parentElement.parentElement.parentElement.parentElement.id == "tblinstructor") {
                        bootbox.alert('Please Select Instructor');
                    }
                    else {
                        bootbox.alert('Please Select TA');
                    }
                    return false;
                }
            }

            obj_course_data.course_title = replace_special_char($('#txtcourse_title').val());

            var is_location_travel_based = false;
            obj_course_data.category_location_wise = $('#drp_category_location_wise').val();
            if ($('#drp_category_location_wise').val() == 'Travel Based Outside India' || $('#drp_category_location_wise').val() == 'Travel Based Within India') {
                if ($('#txt_tral_start_date').val() == '')
                {
                    bootbox.alert('Please Select Travel Start Date');
                    return false;
                }
                if ($('#txt_tral_end_date').val() == '')
                {
                    bootbox.alert('Please Select Travel End Date');
                    return false;
                }

                is_location_travel_based = true;
            }
            else if ($('#drp_category_location_wise').val() != '') {
                obj_course_data.is_based_in_ahmedabad = $('#drp_based_in_ahmedabad').val();
                //if ($('#drp_based_in_ahmedabad').val() == 'Y') {
                if ($('#drp_based_in_ahmedabad').val() == 'N') {
                    is_location_travel_based = true;
                }
            }
            if ($('#drp_category_location_wise').val() == 'Travel Based Outside India' || $('#drp_category_location_wise').val() == 'Travel Based Within India') {
                obj_course_data.TravelStartDate = convertDateFormat($('#txt_tral_start_date').val());
                obj_course_data.TravelEndDate = convertDateFormat($('#txt_tral_end_date').val());
            }
            else
            {
                obj_course_data.TravelStartDate = '';
                obj_course_data.TravelEndDate = '';
                
            }

            obj_course_data.course_type = $('#drp_course_type').val();
            obj_course_data.location = $('#txt_location').val();
            obj_course_data.intake_capacity = $('#drpavailable_seats').val();
            
            if (obj_course_data.intake_capacity == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Intake Capacity');
                return false;
            }

            obj_course_data.minimum_seat = $('#txtmini_student_no').val();

            obj_course_data.is_cancel = $('#is_cancel').val();

            if (obj_course_data.minimum_seat == '' && action == 'A') {
                bootbox.alert('Please Enter Minimum Intake Capacity');
                return false;
            }
            if (obj_course_data.minimum_seat != '' && action == 'A' && obj_course_data.intake_capacity != '')
            {
                if (parseInt(obj_course_data.minimum_seat) > parseInt(obj_course_data.intake_capacity))
                {
                    bootbox.alert('Minimum Intake Capacity Less than Intake Capacity');
                    return false;
                }
            }


            obj_course_data.credits = $('#drp_credits').val();
            obj_course_data.gpa_status = $('#drp_gpa_status').val();
            obj_course_data.total_instructors_involved = $('#drp_instructors_involved').val();

            $('#txtcourse_description').keyup();
            //if (parseInt($('#spn_desc').html().split(':')[1].trim()) > 300) {
            if ($('#txtcourse_description').val().length > 1200) {
                bootbox.alert('Course Description Exceeds the Word Limit');
                return false;
            }
            obj_course_data.description = replace_special_char($('#txtcourse_description').val());

            $('#learning_outcomes').keyup();
            if ($('#learning_outcomes').val().length > 600) {
                bootbox.alert('Learning Outcomes Exceeds the Word Limit');
                return false;
            }

            obj_course_data.learning_outcomes = replace_special_char($('#learning_outcomes').val());

            if ($('#txtcourse_prerequisite').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Prerequisite For Students');
                return false;
            }

            obj_course_data.prerequisite = replace_special_char($('#txtcourse_prerequisite').val());

            if ($('#chk_is_for_professional')[0].checked) {
                obj_course_data.is_open_for_professional = 'Y';
                obj_course_data.professional_prerequisite = replace_special_char($('#txt_professional_prerequisite').val());
            }
            else {
                obj_course_data.is_open_for_professional = 'N';
            }

            if ($('#txt_start_date').val() != '') {
                obj_course_data.start_date = convertDateFormat($('#txt_start_date').val());
                if (obj_course_data.start_date == '') {
                    bootbox.alert('Please Enter valid Start Date');
                    return false;
                }
            }

            if ($('#txt_end_date').val() != '') {
                obj_course_data.end_date = convertDateFormat($('#txt_end_date').val());
                if (obj_course_data.end_date == '') {
                    bootbox.alert('Please Enter valid End Date');
                    return false;
                }
            }

            //obj_course_data.course_image = $('#txtcourse_title').val();

            obj_course_data.course_image = FileName;

            obj_course_data.image_source = $('#txt_image_source').val();
            obj_course_data.inhabitation = $('#drp_inhabitation').val();
            obj_course_data.methodology = $('#drp_methodology').val();

            //new 30012023
            obj_course_data.coursebudget_filepath = $('#lbl_excercises_file_name').text();

            //new 21082025

            var lst_course_assessment = [];
            var total_percent = 0;

            if ($('#tbl_course_assessment tbody tr').length > 0) {
                for (var i = 0; i < $('#tbl_course_assessment tbody tr').length; i++) {
                    var row = $('#tbl_course_assessment tbody tr').eq(i);
                    var obj_assessment = { 'exercise': row.find('.cls_exercises').val(), 'percentage': row.find('.cls_percentage').val(), 'criteria': row.find('.cls_criteria').val() };

                    if (obj_assessment.exercise.search(/\\/) != -1) { obj_assessment.exercise = obj_assessment.exercise.replace(/\\/g, '\\\\'); }
                    if (obj_assessment.exercise.search("\"") != -1) { obj_assessment.exercise = obj_assessment.exercise.replace(/"/g, '\\\"'); }

                    if (obj_assessment.criteria.search(/\\/) != -1) { obj_assessment.criteria = obj_assessment.criteria.replace(/\\/g, '\\\\'); }
                    if (obj_assessment.criteria.search("\"") != -1) { obj_assessment.criteria = obj_assessment.criteria.replace(/"/g, '\\\"'); }

                    if (row.find('.cls_percentage').val() != '')
                        total_percent += parseFloat(row.find('.cls_percentage').val());

                    lst_course_assessment.push(obj_assessment);
                }


                if ($('#tbl_course_assessment tbody tr').length > 0 && total_percent != 100) {
                    action = 'S';
                    bootbox.alert('Total of Assessment Percentage should be 100');
                    return false;
                }

                obj_course_data.course_assessment = JSON.stringify(lst_course_assessment);
                if (obj_course_data.course_assessment.search(/\\/) != -1) { obj_course_data.course_assessment = obj_course_data.course_assessment.replace(/\\/g, '\\\\'); }
                if (obj_course_data.course_assessment.search("\"") != -1) { obj_course_data.course_assessment = obj_course_data.course_assessment.replace(/"/g, '\\\"'); }
            } else {
                obj_course_data.course_assessment = "";
            }




            //if ($('#tbl_portfolio tbody tr').length == 0 && action == 'A' && $("#hdn_utype").val() == 'I2')
            //{
            //    bootbox.alert('Please Add Portfolio');
            //    return false;
            //}
            
            var flag_no_title = true;
            var flag_no_link = true;
            var flag_no_image = true;

            var lst_portfolio = [];//09032021 by NitinBhai validation Remove for Portfolio
           
            //for (var i = 0; i < $('#tbl_portfolio tbody tr').length; i++)
            //{
            //    var obj_portfolio = { 'portfolio_title': '', 'portfolio_link': '', 'portfolio_image': '' };

            //    obj_portfolio['portfolio_title'] = replace_special_char($('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_title')[0].value);
            //    if (obj_portfolio['portfolio_title'] == "")
            //    {
            //        if (action == 'A' && $("#hdn_utype").val() == 'I2')
            //        {
            //            bootbox.alert('Please Enter Portfolio Title');
            //            flag_no_title = false;
            //            return false;
            //        }
            //        else if (action == 'S' && $("#hdn_utype").val() == 'I2')
            //        {
            //            flag_no_title = true;
            //        }
            //        else { flag_no_title = true;}
                    
            //    }

            //    obj_portfolio['portfolio_link'] = $('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_link')[0].value;
            //    if (obj_portfolio['portfolio_link'] == "")
            //    {
            //       // bootbox.alert('Please Enter Portfolio Link');
            //       // flag_no_link = false;                  
            //       // return false;
            //        if (action == 'A' && $("#hdn_utype").val() == 'I2')
            //        {
            //           bootbox.alert('Please Enter Portfolio Link');
            //           flag_no_link = false;                  
            //           return false;
            //        }
            //        else if (action == 'S' && $("#hdn_utype").val() == 'I2') {
            //            flag_no_link = true;
            //        }
            //        else { flag_no_link = true; }


            //        //flag_no_link = true;
            //    }

            //    obj_portfolio['portfolio_image'] = obj_FileName_Portfolio['' + $('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_image_name')[0].id];
            //    if (obj_portfolio['portfolio_image'] == "") {
            //       //bootbox.alert('Please Upload Portfolio Image');
            //       //flag_no_image = false;
            //       //return false;

            //        if (action == 'A' && $("#hdn_utype").val() == 'I2') {
            //            bootbox.alert('Please Upload Portfolio Image');
            //            flag_no_image = false;
            //            return false;
            //        }
            //        else if (action == 'S' && $("#hdn_utype").val() == 'I2') {
            //            flag_no_image = true;
            //        }
            //        else { flag_no_image = true; }


            //      // flag_no_image = true;
            //    }

            //    lst_portfolio.push(obj_portfolio);
            //}

            for (var i = 0; i < $('#tbl_portfolio tbody tr').length; i++) {
                var obj_portfolio = { 'portfolio_title': '', 'portfolio_link': '', 'portfolio_image': '' };

                obj_portfolio['portfolio_title'] = replace_special_char($('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_title')[0].value);
                if (obj_portfolio['portfolio_title'] == "") {
                    //bootbox.alert('Please Enter Portfolio Title');
                    // flag_no_title = false;
                    flag_no_title = true;
                    //return false;
                }

                obj_portfolio['portfolio_link'] = $('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_link')[0].value;
                if (obj_portfolio['portfolio_link'] == "") {
                    //bootbox.alert('Please Enter Portfolio Link');
                    //flag_no_link = false;
                    flag_no_link = true;
                    //return false;
                }

                obj_portfolio['portfolio_image'] = obj_FileName_Portfolio['' + $('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_image_name')[0].id];
                if (obj_portfolio['portfolio_image'] == "") {
                    // bootbox.alert('Please Upload Portfolio Image');
                    //flag_no_image = false;
                    flag_no_image = true;
                    // return false;
                }

                lst_portfolio.push(obj_portfolio);
            }



            if (!flag_no_title && action == 'A' && $("#hdn_utype").val() == 'I2')
            {
                bootbox.alert('Please Enter Portfolio Title');
                return false;
            }

            if (!flag_no_link && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Portfolio Link');
                return false;
            }

            if (!flag_no_image && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Upload Portfolio Image');
                return false;
            }
            obj_course_data.portfolio = lst_portfolio;

            if ($('#termsandcondition').is(':checked')) {
                obj_course_data.termsandcondition = "Y";
            } else {
                obj_course_data.termsandcondition = "N";
            }

            //obj_course_data.course_output1 = $('#drp_course_output1').val();
            //obj_course_data.course_output2 = $('#drp_course_output2').val();
            //obj_course_data.course_output3 = $('#drp_course_output3').val();

            var obj_chk_course_output = $('input[name=chk_course_output]:checked');
            obj_course_data.course_output1 = '';

            if (obj_chk_course_output.length == 0 && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Course Outputs');
                return false;
            }

            if (obj_chk_course_output.length > 0) {
                for (var i = 0; i < obj_chk_course_output.length; i++) {
                    if (i != 0) obj_course_data.course_output1 += '~';
                    obj_course_data.course_output1 += obj_chk_course_output[i].id.toString();

                    if (obj_chk_course_output[i].id.toString() == 'Others') {
                        obj_course_data.course_output2 = $('#txt_other_output').val();
                    }
                }
            } 

            if ($('#txt_material_for_workshop').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Expenses of Materials for Work Shop (INR)');
                return false;
            }

            obj_course_data.material_for_workshop = $('#txt_material_for_workshop').val();

            if ($('#txt_outside_service_rent').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Expenses of Hall, Equipment, Other Outside Services Rent (INR)');
                return false;
            }

            obj_course_data.outside_service_rent = $('#txt_outside_service_rent').val();

            obj_course_data.travel_arrangement_needed = $('#drp_travel_arrangement_needed').val();
            if ($('#drp_travel_arrangement_needed').val() == 'Y') {
                obj_course_data.travel_arrangement_needed_from = $('#txt_travel_arrangement_needed_from').val();
                obj_course_data.travel_arrangement_needed_to = $('#txt_travel_arrangement_needed_to').val();
            }

            if (is_location_travel_based) {
                obj_course_data.is_travel_based_course = $('#drp_is_travel_based_course').val();
                if ($('#drp_is_travel_based_course').val() == 'Y') {
                    obj_course_data.is_travel_based_course_from = $('#txt_is_travel_based_course_from').val();
                    obj_course_data.is_travel_based_course_to = $('#txt_is_travel_based_course_to').val();
                }

                obj_course_data.accommodation_needed = $('#drp_accommodation_needed').val();
                if ($('#drp_accommodation_needed').val() == 'Y') {
                    if ($('#txt_accomodation_from_date').val() != '') {
                        obj_course_data.accommodation_needed_from_date = convertDateFormat($('#txt_accomodation_from_date').val());
                        if (obj_course_data.accommodation_needed_from_date == '') {
                            bootbox.alert('Please Enter valid Accomodation From Date');
                            return false;
                        }
                    }

                    if ($('#txt_accomodation_to_date').val() != '') {
                        obj_course_data.accommodation_needed_to_date = convertDateFormat($('#txt_accomodation_to_date').val());
                        if (obj_course_data.accommodation_needed_to_date == '') {
                            bootbox.alert('Please Enter valid Accomodation To Date');
                            return false;
                        }
                    }

                    obj_course_data.accommodation_needed_total_days = total_accomodation_days;
                }
            }

            obj_course_data.hotel_accommodation = $('#drp_hotel_accommodation').val();

            if ($('#drp_contract_to_be_done').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Contract to be done with any institute');
                return false;
            }

            obj_course_data.is_contract_to_be_done = $('#drp_contract_to_be_done').val();
            if ($('#drp_contract_to_be_done').val() == 'Y') {
                obj_course_data.rs_contract_to_be_done = $('#txt_contract_to_be_done').val();
            }

            if ($('#drp_contract_to_be_done').val() == 'Y' && action == 'A' && $("#hdn_utype").val() == 'I2' && $("#txt_contract_to_be_done").val() == '') {
                bootbox.alert('Please Enter Amount (INR)');
                return false;
            }

            if ($('#txt_other_major_expense').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Any other major expense (INR)');
                return false;
            }

            obj_course_data.other_major_expense = $('#txt_other_major_expense').val();

            if ($('#txt_specify_other_major_expense').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Specify other major expense (INR) or write NA');
                return false;
            }

            obj_course_data.other_major_expense_specify = $('#txt_specify_other_major_expense').val();

            if ($('#txt_printing_stationary').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Expenses of Printing & Stationary (INR)');
                return false;
            }

            obj_course_data.printing_stationary = $('#txt_printing_stationary').val();

            obj_course_data.material_cost = $('#txt_material_cost').val();
            if (obj_course_data.material_cost == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Material Cost (INR)');
                return false;
            }

            obj_course_data.food_stay = $('#txt_food_stay').val();
            obj_course_data.local_travel = $('#txt_local_travel').val();
            if (obj_course_data.local_travel == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Local Travel (INR)');
                return false;
            }

            obj_course_data.approx_expense = $('#div_total_approx_expense').html();
            obj_course_data.travel_expense = $('#txt_travel_expense').val();
            obj_course_data.total_expense = $('#div_total_expense').html();

            var flag_no_inst = true;
            var flag_no_contact_hrs = true;
            var flag_no_TA = true;
            var flag_no_contact_hrs_TA = true;
            var flag_inst_description = true;
            var flag_inst_are_you = true;
            var flag_inst_travel_arrangements = true;
            var flag_inst_accommodation_needed = true;
            var flag_inst_travel_from = true;
            var flag_inst_travel_to = true;
            var flag_inst_from_date = true;
            var flag_inst_to_date = true;
            
            var instructor_data_list = [];
            var TA_data_list = [];
            var instructor_char_limit_status = true;
            $('#tblinstructor tbody tr').each(function (i) {
                var instructor_data = { 'instructor_code': '', 'contact_hrs': '', 'instructor_desc': '', 'instructor_type': '', 'is_based_in_ahmedabad': '', 'is_travel_based_course': '', 'is_travel_based_course_from': '', 'is_travel_based_course_to': '', 'accommodation_needed': '', 'accommodation_needed_from_date': '', 'accommodation_needed_to_date': '', 'accommodation_needed_total_days': '' };

                instructor_data.instructor_code = $(this).find(".drpinstructor").val();
                if (instructor_data.instructor_code == "") {
                    flag_no_inst = false;
                    //return false;
                }
                instructor_data.contact_hrs = $(this).find(".per_load").val();
                instructor_data.Addtional_Hours = $(this).find(".Addtional_Hours").val();
                instructor_data.Total_Hours = $(this).find(".Total_Hours").val();
                //if (instructor_data.contact_hrs == "") {
                if (instructor_data.contact_hrs == "" || instructor_data.Addtional_Hours == "" || instructor_data.Total_Hours == "") {
                    flag_no_contact_hrs = false;
                    //return false;
                }
                $('#txt_desc_faculty' + (i + 1)).keyup();
                if (parseInt($('#spn_desc_faculty' + (i + 1) + '_words').html().split(':')[1].trim()) > faculty_word_limit) {
                    //bootbox.alert('Instructor Description Exceeds the Word Limit');
                    //bootbox.alert('Instructor Description Exceeds the Character Limit');
                    //return false;

                    instructor_char_limit_status = false;
                }
                instructor_data.instructor_desc = replace_special_char($('#txt_desc_faculty' + (i + 1)).val());

                if (instructor_data.instructor_desc == "") {
                    flag_inst_description = false;
                    //return false;
                }

                instructor_data.instructor_type = $('input[name=rdo_faculty_type' + i + ']:checked').val();

                var is_location_travel_based1 = false;
                if ($('#drp_category_location_wise').val() == 'Travel Based Outside India' || $('#drp_category_location_wise').val() == 'Travel Based Within India')
                {
                    is_location_travel_based1 = true;
                }
                else if ($('#drp_category_location_wise').val() != '')
                {
                    instructor_data.is_based_in_ahmedabad = $('#drp_based_in_ahmedabad' + (i + 1)).val();
                    //if ($('#drp_based_in_ahmedabad').val() == 'Y') {
                    if ($('#drp_based_in_ahmedabad' + (i + 1)).val() == 'N')
                    {
                        is_location_travel_based1 = true;
                    }
                    if (instructor_data.is_based_in_ahmedabad == "")
                    {
                        //new code 
                        var types = $('input[name=rdo_faculty_type' + i + ']:checked').val();
                        if (types == "2")
                        {
                            flag_inst_are_you = false;
                        }
                        //end code 
                        //old Code
                        // Changes By 17032021 Nitinbhai
                        //for (var i = 0; i < $('#tblinstructor tbody tr').length; i++)
                        //{
                        //    if ($('input[name=rdo_faculty_type' + i + ']:checked').val() != undefined)
                        //    {
                        //        //var types = Math.max(rdo_instructor_type, $('input[name=rdo_faculty_type' + i + ']:checked').val());
                        //        var types = $('input[name=rdo_faculty_type' + i + ']:checked').val();
                        //        if (types == "2")
                        //        { flag_inst_are_you = false; }
                        //        
                        //    }
                        //}
                        //end old code 
                        //return false;
                    }
                }

                if (is_location_travel_based1) {
                    instructor_data.is_travel_based_course = $('#drp_is_travel_based_course' + (i + 1)).val();

                    if (instructor_data.is_travel_based_course == "") {
                        flag_inst_travel_arrangements = false;
                        //return false;
                    }
                    
                    if ($('#drp_is_travel_based_course' + (i + 1)).val() == 'Y') {
                        instructor_data.is_travel_based_course_from = $('#txt_is_travel_based_course_from' + (i + 1)).val();

                        if (instructor_data.is_travel_based_course_from == "") {
                            flag_inst_travel_from = false;
                            //return false;
                        }

                        instructor_data.is_travel_based_course_to = $('#txt_is_travel_based_course_to' + (i + 1)).val();

                        if (instructor_data.is_travel_based_course_to == "") {
                            flag_inst_travel_to = false;
                            //return false;
                        }
                    }

                    instructor_data.accommodation_needed = $('#drp_accommodation_needed' + (i + 1)).val();

                    if (instructor_data.accommodation_needed == "") {
                        flag_inst_accommodation_needed = false;
                        //return false;
                    }

                    if ($('#drp_accommodation_needed' + (i + 1)).val() == 'Y') {
                        if ($('#txt_accomodation_from_date' + (i + 1)).val() != '') {
                            instructor_data.accommodation_needed_from_date = convertDateFormat($('#txt_accomodation_from_date' + (i + 1)).val());
                            if (instructor_data.accommodation_needed_from_date == '') {
                                bootbox.alert('Please Enter valid Accomodation From Date');
                                //return false;
                            }
                        }

                        if (instructor_data.accommodation_needed_from_date == "") {
                            flag_inst_from_date = false;
                            //return false;
                        }

                        if ($('#txt_accomodation_to_date' + (i + 1)).val() != '') {
                            instructor_data.accommodation_needed_to_date = convertDateFormat($('#txt_accomodation_to_date' + (i + 1)).val());
                            if (instructor_data.accommodation_needed_to_date == '') {
                                bootbox.alert('Please Enter valid Accomodation To Date');
                                //return false;
                            }
                        }

                        if (instructor_data.accommodation_needed_to_date == "") {
                            flag_inst_to_date = false;
                            //return false;
                        }

                        instructor_data.accommodation_needed_total_days = obj_total_accomodation_days[(i + 1).toString()];
                    }
                }

                instructor_data_list.push(instructor_data);
            });

            if (instructor_data_list.length > 0)
            {
                if (hasDuplicates(instructor_data_list)) {
                    alert("The same instructor should not be assigned to the same course more than once.")
                    return false;
                }
            }

            

            $('#tblTA tbody tr').each(function (i) {
                var TA_data = { 'instructor_code': '', 'contact_hrs': '', 'instructor_desc': '', 'instructor_type': '', 'is_based_in_ahmedabad': '', 'is_travel_based_course': '', 'is_travel_based_course_from': '', 'is_travel_based_course_to': '', 'accommodation_needed': '', 'accommodation_needed_from_date': '', 'accommodation_needed_to_date': '', 'accommodation_needed_total_days': '' };

                TA_data.instructor_code = $(this).find(".drpinstructor").val();
                if (TA_data.instructor_code == "") {
                    flag_no_TA = false;
                    //return false;
                }
                // TA_data.contact_hrs = $(this).find(".per_load").val();
                TA_data.contact_hrs = $(this).find(".TAper_load").val();
                TA_data.Addtional_Hours = $(this).find(".TAAddtional_Hours").val();
                TA_data.Total_Hours = $(this).find(".TATotal_Hours").val();
                if (TA_data.contact_hrs == "" || TA_data.Addtional_Hours == "" || TA_data.Total_Hours == "") {
                    flag_no_contact_hrs_TA = false;
                    //return false;
                }
                //$('#txt_desc_faculty' + (i + 1)).keyup();
                //if (parseInt($('#spn_desc_faculty' + (i + 1) + '_words').html().split(':')[1].trim()) > faculty_word_limit) {
                //    //bootbox.alert('Instructor Description Exceeds the Word Limit');
                //    //bootbox.alert('Instructor Description Exceeds the Character Limit');
                //    //return false;

                //    instructor_char_limit_status = false;
                //}
                // TA_data.instructor_desc = replace_special_char($('#txt_desc_faculty' + (i + 1)).val());

                // if (TA_data.instructor_desc == "") {
                //     flag_inst_description = false;
                //     //return false;
                // }

                TA_data.instructor_type = $('input[name=TArdo_faculty_type' + i + ']:checked').val();
                TA_data_list.push(TA_data);
            });

            if (TA_data_list.length > 0) {
          
                if (hasDuplicates(TA_data_list)) {
                    alert("The same TA should not be assigned to the same course more than once.")
                    return false;
                }
            }

            if (!flag_no_inst && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Instructor');
                return false;
            }

            if (!flag_no_contact_hrs && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Instructor Contact Hrs');
                return false;
            }

            if (!flag_no_TA && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select TA');
                return false;
            }

            if (!flag_no_contact_hrs_TA && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter TA Contact Hrs Details');
                return false;
            }

            if (!flag_inst_description && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Description of Instructor');
                return false;
            }

            if (!flag_inst_are_you && action == 'A' && $("#hdn_utype").val() == 'I2')
            {
                bootbox.alert('Please Select Are you Based In Ahmedabad?');
                return false;
            }

            if (!flag_inst_travel_arrangements && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Do you require Travel Arrangements?');
                return false;
            }

            if (!flag_inst_accommodation_needed && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Accommodation Needed?');
                return false;
            }

            if (!flag_inst_travel_from && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Source Location');
                return false;
            }

            if (!flag_inst_travel_to && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Destination Location');
                return false;
            }

            if (!flag_inst_from_date && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Accommodation From Date');
                return false;
            }

            if (!flag_inst_to_date && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Accommodation To Date');
                return false;
            }

            if (!instructor_char_limit_status) {
                //bootbox.alert('Instructor Description Exceeds the Word Limit');
                bootbox.alert('Instructor Description Exceeds the Character Limit');
                return false;
            }

            obj_course_data.instructor = instructor_data_list;
            obj_course_data.TA = TA_data_list;

            var flag_no_from_date = true;
            var flag_no_to_date = true;
            var flag_no_description = true;

            var workplan_data_list = [];
            if ($('#tbl_workplan tbody tr').length > 0) {
                $('#tbl_workplan tbody tr').each(function (i) {
                    var workplan_data = { 'workplan_date': '', 'from_time': '', 'to_time': '', 'topic_covered': '', 'methodology': '', 'no_of_hrs': '', 'faculty_involve': '' };

                    workplan_data.workplan_date = convertDateFormat($(this).find(".cls_workplan_date").html().trim());
                    //if (workplan_data.workplan_date == '') return false;//16022022 Nitinbhai

                    workplan_data.from_time = $(this).find(".from_time").val();

                    if (workplan_data.from_time == "") {
                        flag_no_from_date = false;
                        //return false;//16022022 Nitinbhai
                    }

                    workplan_data.to_time = $(this).find(".to_time").val();

                    if (workplan_data.to_time == "") {
                        flag_no_to_date = false;
                        //return false;//16022022 Nitinbhai
                    }

                    workplan_data.topic_covered = $(this).find(".cls_topic_covered").val();

                    workplan_data.methodology = replace_special_char($(this).find(".cls_Methodology").val());

                    if (workplan_data.methodology == "") {
                        flag_no_description = false;
                        //return false;//16022022 Nitinbhai
                    }

                    workplan_data.no_of_hrs = $(this).find(".cls_total_hrs").html();
                    //workplan_data.faculty_involve = $(this).find(".cls_faculty_involve").val();

                    var arr_faculty_involve = $(this).find(".cls_chk_faculty_involve:checked");
                    var str_faculty_involve = '';
                    for (var i = 0; i < arr_faculty_involve.length; i++) {
                        if (i != 0) str_faculty_involve = str_faculty_involve + '~';
                        str_faculty_involve = str_faculty_involve + arr_faculty_involve[i].value;
                    }
                    workplan_data.faculty_involve = str_faculty_involve;

                    workplan_data_list.push(workplan_data);
                });
            }

            if ($('#txt_start_date').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select Start Date');
                return false;
            }

            if ($('#txt_end_date').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select End Date');
                return false;
            }

            if (!flag_no_from_date && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select From Time in Workplan');
                return false;
            }

            if (!flag_no_to_date && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Select To Time in Workplan');
                return false;
            }

            if (!flag_no_description && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Description of Workplan');
                return false;
            }

            obj_course_data.workplan = workplan_data_list;

            if (FileName == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Upload Image Related to Course');
                return false;
            }

            if ($('#txt_image_source').val() == '' && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Enter Image Source');
                return false;
            }

            if (obj_course_data.termsandcondition != "Y" && action == 'A' && $("#hdn_utype").val() == 'I2') {
                bootbox.alert('Please Accept Terms and Condition');
                return false;
            }

            var sem_code = $('#hdn_sem').val();
            var year_code = $('#hdn_year').val();
            var All_table_course_data = [obj_course_data, action];
            var json_All_table_course_data = JSON.stringify(All_table_course_data);

            if (json_All_table_course_data.search("'") != -1) {
                json_All_table_course_data = json_All_table_course_data.replace(/\'/g, '\\\'');
            }

            

            if (sem_code != "" && year_code != "") {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/edit_WS_course_data_save",

                    data: "{ All_table_course_data: '" + json_All_table_course_data + "',sem_code1: '" + sem_code + "',year_code: '" + year_code + "' }",
                    dataType: "json",
                    success: function (data) {

                        if (data.d == 'Course Code is already Available , You can not enter same Course Code again') {
                            bootbox.alert(data.d);
                        }
                        else if (data.d == 'Data Saved Successfully') {
                            if (action == 'A') {
                                bootbox.alert("Course Submitted Successfully", function ()
                                {
                                    window.location = "WS_Course_Dashboard.aspx";
                                });
                            }
                            else {
                                bootbox.alert(data.d, function () {
                                    //location.reload(); // as per request Nitin Bhai 22092023
                                   // location.reload(); // as per request Nitin Bhai 09022024 open Reload Funcation 
                                });
                            }
                        }
                        else if (data.d == "2" && action == 'A')
                        {
                            window.location.href = "ws_course_budget_dtl.aspx?c=" + $('#hdn_course_code').val() + "&s=" + sem_code + "&y=" + year_code;

                        }
                        else if (data.d == "2" && action == 'S') {
                            bootbox.alert('Data Saved Successfully');

                        }
                        else if (data.d != "") {
                            alert(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            else {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_WS_course_data",

                    data: "{ All_table_course_data: '" + json_All_table_course_data + "' }",
                    dataType: "json",
                    success: function (data) {

                        if (data.d == 'Course Code is already Available , You can not enter same Course Code again') {
                            bootbox.alert(data.d);
                        }
                        else if (data.d == 'Data Saved Successfully') {
                            if (action == 'A')
                            {
                                bootbox.alert("Course Submitted Successfully", function () {
                                    window.location = "WS_Course_Dashboard.aspx";
                                });
                            }
                            else {
                                bootbox.alert(data.d, function () {
                                    location.reload(); 
                                    // as per request Nitin Bhai 22092023 Close Reload Funcation 
                                    // as per request Nitin Bhai 09022024 open Reload Funcation 
                                });
                            }
                        }
                        else if (data.d == "2" && action == 'S') {
                            bootbox.alert('Data Saved Successfully');
                           // window.open("ws_course_budget_dtl.aspx?c=" + $('#hdn_course_code').val() + '&s=' + sem_code + '&y=' + year_code, '_blank');
                        
                        }
                        else if (data.d != "") {
                            alert(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
        }

        function hasDuplicates(arr)
        {
            var seen = {};
            for (var i = 0; i < arr.length; i++) {
                if (seen[arr[i].instructor_code]) {
                    return true; // Duplicate found
                }
                seen[arr[i].instructor_code] = true;
            }
            return false; // No duplicates
        }

        var obj_instructor = {};
        function bindinstructor() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_faculty_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var instructor_data = JSON.parse(data.d);
                        //bindindexdb(instructor_data);
                        var startTime = performance.now();
                        instructor = "<select style='width:85%' class='drpinstructor' onchange='set_faculty_involve_drp(1)'><option value=''>&lt; Select Instructor &gt;</option>";
                        for (var i = 0; i < instructor_data.length; i++)
                        {
                            instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                            obj_instructor[instructor_data[i]["instructor_code"]] = instructor_data[i]["designation"];
                        }
                        instructor = instructor + "</select>";

                        var endTime = performance.now();

                        // Log the time taken
                        console.log("Time taken to bind data: " + (endTime - startTime) + " milliseconds");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        

        var intake_criteria;
        function get_intake_criteria() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_student_intake_criteria",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        intake_criteria = JSON.parse(data.d)
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        //$('#tblinstructor tbody tr td i.icon-trash').live('click', function (e) {
        //    //if ($("#hdn_utype").val() != 'I2') {
        //    var r = confirm("Are u sure you want to remove this?");
        //    if (r == true) {
        //        var datalist = [];
        //        var flag = 'Y';
        //        var ob = {};
        //        var thisdata = $(this).closest("tr");
        //        $(this).closest("tr").remove();
        //        var totalsum = 0;

        //        category_location_change();
        //        set_faculty_involve_drp();
        //    }
        //    //}
        //});


        function BindTrashIconDeleteEvent() {
            $('#tblinstructor tbody tr td i.icon-trash').on('click', function (e) {
                //if ($("#hdn_utype").val() != 'I2') {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {
                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;

                    category_location_change();
                    set_faculty_involve_drp();
                    SetContactHours();
                }
                //}
            });
            $('#tblTA tbody tr td i.icon-trash').on('click', function (e) {
                //if ($("#hdn_utype").val() != 'I2') {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {
                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;

                    category_location_change();
                    set_faculty_involve_drp();
                    SetContactHours();
                }
                //}
            });
        }

        function get_course_data() {
            
            var course_code = $('#hdn_course_code').val();
            if (course_code == '') return;

            var sem_code = $('#hdn_sem').val();
            if (sem_code == '') return;

            var year_code = $('#hdn_year').val();
            if (year_code == '') return;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_all_ws_course_proposal_data",
                async: false,
                data: "{course_code:'" + course_code + "',sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d[0] != null) {

                        var course_data = JSON.parse(data.d[0]);

                        $('#txtcourse_title').val(course_data[0]["course_name"]);
                        $('#drp_category_location_wise').val(course_data[0]["category_location_wise"]);
                        $('#txt_location').val(course_data[0]["location"]);

                        if (course_data[0]["available_seat"] != '') {
                            $('#drpavailable_seats').append('<option id="' + course_data[0]["available_seat"] + '">' + course_data[0]["available_seat"] + '</option>');
                        }
                        $('#drpavailable_seats').val(course_data[0]["available_seat"]);

                        $('#txtmini_student_no').val(course_data[0]["minimum_seat"]);

                        $('#is_cancel').val(course_data[0]["is_cancel"]);

                        $('#drp_credits').val(course_data[0]["course_credits"]);
                        $('#drp_gpa_status').val(course_data[0]["gpa_status"]);
                        $('#txtcourse_description').val(course_data[0]["course_desc"]);
                        $('#drp_course_type').val(course_data[0]["course_type"]);
                        $('#learning_outcomes').val(course_data[0]["learning_outcomes"]);

                        if (course_data[0]["termsandcondition"] == "Y") {
                            $("#termsandcondition").prop("checked", true);
                        } else {
                            $("#termsandcondition").prop("checked", false);
                        }

                        $('#txtcourse_prerequisite').val(course_data[0]["prerequisite"]);
                        $('#drp_instructors_involved').val(course_data[0]["total_instructors_involved"]);

                        if (course_data[0]["is_open_for_professional"] == 'Y') {
                            $('#chk_is_for_professional')[0].checked = true;
                            $('#txt_professional_prerequisite').val(course_data[0]["prerequisite_for_prof"]);
                            $('#chk_is_for_professional').change();
                        }

                        //$('#txt_start_date').val(course_data[0]["start_date"]);
                        if (course_data[0]["start_date"] != '') {
                            var temp_date = new Date(course_data[0]["start_date"]);
                            $('#txt_start_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }

                        //$('#txt_end_date').val(course_data[0]["end_date"]);
                        if (course_data[0]["end_date"] != '') {
                            var temp_date = new Date(course_data[0]["end_date"]);
                            $('#txt_end_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }

                        if (course_data[0]["TravelStartDate"] != '') {
                            var temp_date = new Date(course_data[0]["TravelStartDate"]);
                            $('#txt_tral_start_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }

                        //$('#txt_end_date').val(course_data[0]["end_date"]);
                        if (course_data[0]["TravelEndDate"] != '') {
                            var temp_date = new Date(course_data[0]["TravelEndDate"]);
                            $('#txt_tral_end_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }


                        FileName = course_data[0]["image_name"];
                        $('#img_course_image').attr('src', '../../WSCourseImageUpload/' + FileName + '?' + (new Date()).getTime());

                        $('#lbl_courseimage_file_name').html(course_data[0]["image_name"]);
                        $('#txt_image_source').val(course_data[0]["image_source"]);
                        $('#drp_inhabitation').val(course_data[0]["inhabitation"]);
                        $('#drp_methodology').val(course_data[0]["methodology"]);

                        $('#tbl_portfolio tbody tr').html('');
                        if (course_data[0]["portfolio"] != '' && course_data[0]["portfolio"] != null && course_data[0]["portfolio"] != undefined) {
                            lst_portfolio = JSON.parse(course_data[0]["portfolio"]);
                            if (lst_portfolio.length > 0) {
                                for (var i = 0; i < lst_portfolio.length; i++) {
                                    add_portfolio();
                                    $('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_title')[0].value = lst_portfolio[i]['portfolio_title'];
                                    $('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_link')[0].value = lst_portfolio[i]['portfolio_link'];
                                    $('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_image_name')[0].innerHTML = lst_portfolio[i]['portfolio_image'];
                                    obj_FileName_Portfolio['' + $('#tbl_portfolio tbody tr')[i].getElementsByClassName('cls_portfolio_image_name')[0].id] = lst_portfolio[i]['portfolio_image'];
                                    //$('#img_portfolio_image').attr('src', '../../WSPortfolioImageUpload/' + FileName_Portfolio + '?' + (new Date()).getTime());
                                }
                            }
                        }

                        //$('#drp_course_output1').val(course_data[0]["course_output1"]);
                        //$('#drp_course_output2').val(course_data[0]["course_output2"]);
                        //$('#drp_course_output3').val(course_data[0]["course_output3"]);

                        $('#txt_other_output').val('');
                        if (course_data[0]["course_output1"] != '') {
                            var obj_course_output = course_data[0]["course_output1"].split('~');
                            for (var i = 0; i < obj_course_output.length; i++) {
                                $('#' + obj_course_output[i]).attr('checked', 'checked');

                                if (obj_course_output[i] == 'Others') $('#txt_other_output').val(course_data[0]["course_output2"]);
                            }
                            $('#Others').change();
                        }

                        $('#txt_material_for_workshop').val(course_data[0]["material_for_workshop"]);
                        $('#txt_outside_service_rent').val(course_data[0]["outside_service_rent"]);

                        $('#drp_travel_arrangement_needed').val(course_data[0]["travel_arrangement_needed"]);
                        if (course_data[0]["travel_arrangement_needed"] == 'Y') {
                            $('#txt_travel_arrangement_needed_from').val(course_data[0]["travel_arrangement_needed_from"]);
                            $('#txt_travel_arrangement_needed_to').val(course_data[0]["travel_arrangement_needed_to"]);
                            $('#div_travel_arrangement_needed').css('display', 'block');
                        }

                        $('#drp_is_travel_based_course').val(course_data[0]["is_travel_based_course"]);
                        if (course_data[0]["is_travel_based_course"] == 'Y') {
                            $('#txt_is_travel_based_course_from').val(course_data[0]["is_travel_based_course_from"]);
                            $('#txt_is_travel_based_course_to').val(course_data[0]["is_travel_based_course_to"]);
                            $('#div_is_travel_based_course').css('display', 'block');
                        }

                        $('#drp_based_in_ahmedabad').val(course_data[0]["based_in_ahmedabad"]);
                        $('#drp_accommodation_needed').val(course_data[0]["accommodation_needed"]);
                        if (course_data[0]["accommodation_needed"] == 'Y') {
                            if (course_data[0]["accommodation_needed_from_date"] != '') {
                                var temp_date = new Date(course_data[0]["accommodation_needed_from_date"]);
                                $('#txt_accomodation_from_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                            }

                            if (course_data[0]["accommodation_needed_to_date"] != '') {
                                var temp_date = new Date(course_data[0]["accommodation_needed_to_date"]);
                                $('#txt_accomodation_to_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                            }

                            $('#txt_accomodation_total_days').val(course_data[0]["accommodation_needed_total_days"]);
                            total_accomodation_days = course_data[0]["accommodation_needed_total_days"];
                        }

                        $('#drp_accommodation_needed').change();
                        $('#drp_hotel_accommodation').val(course_data[0]["hotel_accommodation"]);

                        $('#drp_contract_to_be_done').val(course_data[0]["is_contract_to_be_done"]);
                        if (course_data[0]["is_contract_to_be_done"] == 'Y') {
                            $('#txt_contract_to_be_done').val(course_data[0]["rs_contract_to_be_done"]);
                            //$('#div_contract_to_be_done').css('display', 'block');
                            $('#txt_contract_to_be_done').css('display', 'block');
                            $('#spn_amount').css('display', 'block');
                        }

                        $('#txt_other_major_expense').val(course_data[0]["other_major_expense"]);
                        $('#txt_specify_other_major_expense').val(course_data[0]["other_major_expense_specify"]);
                        $('#txt_printing_stationary').val(course_data[0]["printing_stationary"]);

                        $('#txt_material_cost').val(course_data[0]["material_cost"]);
                        $('#txt_food_stay').val(course_data[0]["food_stay"]);
                        $('#txt_local_travel').val(course_data[0]["local_travel"]);
                        $('#div_total_approx_expense').html(course_data[0]["approx_expense"]);
                        $('#txt_travel_expense').val(course_data[0]["travel_expense"]);
                        $('#div_total_expense').html(course_data[0]["total_expense"]);
                        //Changes 30012023
                        if (course_data[0]["coursebudget_filepath"] != '') {
                            //$('#lbl_excercises_file_name').html(course_data[0]["coursebudget_filepath"]);
                            $('#lbl_excercises_file_name').html('<a href="../../CourseBudget/' + course_data[0]["coursebudget_filepath"] +'"  download>' + course_data[0]["coursebudget_filepath"]+'</a>');
                        }
                        else { $('#lbl_excercises_file_name').html('');}
                        

                        if (course_data[0]["course_assessment"] != '' && course_data[0]["course_assessment"] != '[]') {
                            var obj_course_assessment = JSON.parse(course_data[0]["course_assessment"]);

                            for (var i = 0; i < obj_course_assessment.length; i++) {
                                $('#btn_add_course_assessment').click();
                                var row = $('#tbl_course_assessment tbody tr').eq(i);
                                row.find('.cls_exercises').val(obj_course_assessment[i]['exercise']);
                                row.find('.cls_percentage').val(obj_course_assessment[i]['percentage']);
                                row.find('.cls_criteria').val(obj_course_assessment[i]['criteria']);
                            }
                        }



                        $('#txtcourse_title').keyup();
                        $('#txtcourse_description').keyup();
                        $('#learning_outcomes').keyup();
                        $('#txt_other_major_expense').change();
                        $('#drp_credits').change();
                    }

                    //$("#tblinstructor tbody").html('');
                    //if (data.d[1] != null) {

                    //    $("#tblinstructor tbody").html('');
                    //    var course_instructor_data = JSON.parse(data.d[1]);

                    //    for (var i = 0; i < course_instructor_data.length; i++) {
                    //        //                            if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                    //        //                                var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric(event);' disabled/></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                    //        //                            }
                    //        //                            else {
                    //        var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric(event);' /></td>" +
                    //            " <td><center><input type='radio' name='rdo_faculty_type" + i + "' value='1' onchange='category_location_change()' /></center></td>" +
                    //            " <td><center><input type='radio' name='rdo_faculty_type" + i + "' value='2' onchange='category_location_change()' /></center></td>" +
                    //            " <td><center><input type='radio' name='rdo_faculty_type" + i + "' value='3' onchange='category_location_change()' /></center></td>" +
                    //            //" <td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                    //            " <td></td></tr>";
                    //        //                            }
                    //        $('#tblinstructor tbody').append(str);
                    //    }

                    //    $("#tblinstructor tbody tr").each(function (j) {
                    //        for (var i = 0; i < course_instructor_data.length; i++)
                    //        {
                    //            if (j == i)
                    //            {
                    //                $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);
                    //                $(this).find(".per_load").val(course_instructor_data[i]["contact_hrs"]);
                    //                $(this).find("input[value=" + course_instructor_data[i]["instructor_type"] + "]").attr('checked', 'checked');
                    //                //$(this).find(".drpinstructor").chosen();
                    //                //$(this).find(".drpinstructor").trigger("liszt:updated");

                    //                $('#txt_desc_faculty' + (j + 1)).val(course_instructor_data[i]["instructor_desc"]);
                    //                $('#txt_desc_faculty' + (j + 1)).keyup();

                    //                $('#drp_based_in_ahmedabad' + (j + 1)).val(course_instructor_data[i]["based_in_ahmedabad"]);
                    //                if (course_instructor_data[i]["based_in_ahmedabad"] == 'N') {
                    //                    $('.cls_travel_accomodation' + (j + 1)).css('display', 'block');
                    //                }

                    //                $('#drp_is_travel_based_course' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course"]);
                    //                if (course_instructor_data[i]["is_travel_based_course"] == 'Y') {
                    //                    $('#txt_is_travel_based_course_from' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course_from"]);
                    //                    $('#txt_is_travel_based_course_to' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course_to"]);

                    //                    $('#div_is_travel_based_course' + (j + 1)).css('display', 'block');
                    //                }

                    //                $('#drp_accommodation_needed' + (j + 1)).val(course_instructor_data[i]["accommodation_needed"]);
                    //                if (course_instructor_data[i]["accommodation_needed"] == 'Y') {
                    //                    if (course_instructor_data[i]["accommodation_needed_from_date"] != '') {
                    //                        var temp_date = new Date(course_instructor_data[i]["accommodation_needed_from_date"]);
                    //                        $('#txt_accomodation_from_date' + (j + 1)).val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                    //                    }

                    //                    if (course_instructor_data[i]["accommodation_needed_to_date"] != '') {
                    //                        var temp_date = new Date(course_instructor_data[i]["accommodation_needed_to_date"]);
                    //                        $('#txt_accomodation_to_date' + (j + 1)).val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                    //                    }

                    //                    $('#txt_accomodation_total_days' + (j + 1)).val(course_instructor_data[i]["accommodation_needed_total_days"]);
                    //                    obj_total_accomodation_days['' + (j + 1)] = course_instructor_data[i]["accommodation_needed_total_days"];

                    //                    $('#div_is_accomodation_needed' + (j + 1)).css('display', 'block');
                    //                }
                    //            }
                    //        }
                    //    });

                    //    if ($('#tblinstructor tbody tr').length > 0) {
                    //        if ($('#hdnuserid').val() != 'temp_student') {
                    //            //$('#tblinstructor tbody .drpinstructor')[0].disabled = true;
                    //        }
                    //        $('#tblinstructor tbody tr')[0].children[5].innerHTML = '';
                    //    }
                    //}



                    $("#tblinstructor tbody").html('');
                    if (data.d[1] != null) {

                        $("#tblinstructor tbody").html('');
                        var course_instructor_data = JSON.parse(data.d[1]);

                        for (var i = 0; i < course_instructor_data.length; i++) {
                            // if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            //     var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric(event);' disabled/></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            // }
                            // else {
                            var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric(event);' id='ContactHours_" + i + "' onchange='CalculateTotalHours(this)'/></td>" +
                                " <td><input style='width: 60px;' type='text' class='Addtional_Hours' maxlength='5' onkeypress='return IsNumeric(event);' id='AddtionalHours_" + i + "' onchange='CalculateTotalHours(this)' /></td>" +
                                " <td><input style='width: 60px;' type='text' class='Total_Hours' maxlength='5' onkeypress='return IsNumeric(event);' id='TotalHours_" + i + "' disabled='disabled'/></td>" +
                                " <td><center><input type='radio' name='rdo_faculty_type" + i + "' value='1' onchange='category_location_change()' /></center></td>" +
                                " <td><center><input type='radio' name='rdo_faculty_type" + i + "' value='2' onchange='category_location_change()' /></center></td>" +
                                " <td><center><input type='radio' name='rdo_faculty_type" + i + "' value='3' onchange='category_location_change()' /></center></td>" +
                                //" <td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                                " <td></td></tr>";
                            //                            }
                            
                            $('#tblinstructor tbody').append(str);
                        }

                        $("#tblinstructor tbody tr").each(function (j) {
                            for (var i = 0; i < course_instructor_data.length; i++) {
                                if (j == i) {
                                    $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);
                                    $(this).find(".per_load").val(course_instructor_data[i]["contact_hrs"]);
                                    $(this).find(".Addtional_Hours").val(course_instructor_data[i]["AdditionalHours"]);
                                    $(this).find(".Total_Hours").val(course_instructor_data[i]["TotalHours"]);
                                    $(this).find("input[value=" + course_instructor_data[i]["instructor_type"] + "]").attr('checked', 'checked');
                                    //$(this).find(".drpinstructor").chosen();
                                    //$(this).find(".drpinstructor").trigger("liszt:updated");

                                    $('#txt_desc_faculty' + (j + 1)).val(course_instructor_data[i]["instructor_desc"]);
                                    $('#txt_desc_faculty' + (j + 1)).keyup();

                                    $('#drp_based_in_ahmedabad' + (j + 1)).val(course_instructor_data[i]["based_in_ahmedabad"]);
                                    if (course_instructor_data[i]["based_in_ahmedabad"] == 'N') {
                                        $('.cls_travel_accomodation' + (j + 1)).css('display', 'block');
                                    }

                                    $('#drp_is_travel_based_course' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course"]);
                                    if (course_instructor_data[i]["is_travel_based_course"] == 'Y') {
                                        $('#txt_is_travel_based_course_from' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course_from"]);
                                        $('#txt_is_travel_based_course_to' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course_to"]);

                                        $('#div_is_travel_based_course' + (j + 1)).css('display', 'block');
                                    }

                                    $('#drp_accommodation_needed' + (j + 1)).val(course_instructor_data[i]["accommodation_needed"]);
                                    if (course_instructor_data[i]["accommodation_needed"] == 'Y') {
                                        if (course_instructor_data[i]["accommodation_needed_from_date"] != '') {
                                            var temp_date = new Date(course_instructor_data[i]["accommodation_needed_from_date"]);
                                            $('#txt_accomodation_from_date' + (j + 1)).val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                                        }

                                        if (course_instructor_data[i]["accommodation_needed_to_date"] != '') {
                                            var temp_date = new Date(course_instructor_data[i]["accommodation_needed_to_date"]);
                                            $('#txt_accomodation_to_date' + (j + 1)).val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                                        }

                                        $('#txt_accomodation_total_days' + (j + 1)).val(course_instructor_data[i]["accommodation_needed_total_days"]);
                                        obj_total_accomodation_days['' + (j + 1)] = course_instructor_data[i]["accommodation_needed_total_days"];

                                        $('#div_is_accomodation_needed' + (j + 1)).css('display', 'block');
                                    }
                                }
                            }
                        });

                        if ($('#tblinstructor tbody tr').length > 0) {
                            if ($('#hdnuserid').val() != 'temp_student') {
                                //$('#tblinstructor tbody .drpinstructor')[0].disabled = true;
                            }
                            $('#tblinstructor tbody tr')[0].children[7].innerHTML = '';
                        }
                    }

                    $("#tblTA tbody").html('');
                    if (data.d[3] != null) {

                        $("#tblTA tbody").html('');
                        var course_instructor_data = JSON.parse(data.d[3]);

                        for (var i = 0; i < course_instructor_data.length; i++) {
                            // if ($("#hdn_utype").val() == 'I2' || $("#hdn_utype").val() == 'D' || $("#hdn_utype").val() == 'CW') {
                            //     var str = "<tr><td>" + instructor + "</td><td><input style='width: 60px;' type='text' class='per_load' maxlength='3' onkeypress='return IsNumeric(event);' disabled/></td><td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                            // }
                            // else {
                            var str = "<tr><td>" + TA + "</td><td><input style='width: 60px;' type='text' class='TAper_load' maxlength='3' onkeypress='return IsNumeric(event);' id='TAContactHours_" + i + "' onchange='TACalculateTotalHours(this)'/></td>" +
                                " <td><input style='width: 60px;' type='text' class='TAAddtional_Hours' maxlength='5' onkeypress='return IsNumeric(event);' id='TAAddtionalHours_" + i + "' onchange='TACalculateTotalHours(this)' /></td>" +
                                " <td><input style='width: 60px;' type='text' class='TATotal_Hours' maxlength='5' onkeypress='return IsNumeric(event);' id='TATotalHours_" + i + "' disabled='disabled'/></td>" +
                                " <td><center><input type='radio' name='TArdo_faculty_type" + i + "' value='1' onchange='category_location_change()' /></center></td>" +
                                " <td><center><input type='radio' name='TArdo_faculty_type" + i + "' value='2' onchange='category_location_change()' /></center></td>" +
                                " <td><center><input type='radio' name='TArdo_faculty_type" + i + "' value='3' onchange='category_location_change()' /></center></td>" +
                                //" <td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";
                                " <td></td></tr>";
                            //
                            $('#tblTA tbody').append(str);
                        }

                        $("#tblTA tbody tr").each(function (j) {
                            for (var i = 0; i < course_instructor_data.length; i++) {
                                if (j == i) {
                                    $(this).find(".drpinstructor").val(course_instructor_data[i]["instructor_code"]);
                                    $(this).find(".TAper_load").val(course_instructor_data[i]["ContactHrs"]);
                                    $(this).find(".TAAddtional_Hours").val(course_instructor_data[i]["AdditionalHrs"]);
                                    $(this).find(".TATotal_Hours").val(course_instructor_data[i]["TotalHrs"]);
                                    $(this).find("input[value=" + course_instructor_data[i]["instructor_type"] + "]").attr('checked', 'checked');

                                    // $(this).find(".drpinstructor").chosen();
                                    // $(this).find(".drpinstructor").trigger("liszt:updated");

                                    // $('#txt_desc_faculty' + (j + 1)).val(course_instructor_data[i]["instructor_desc"]);
                                    // $('#txt_desc_faculty' + (j + 1)).keyup();
                                    // 
                                    // $('#drp_based_in_ahmedabad' + (j + 1)).val(course_instructor_data[i]["based_in_ahmedabad"]);
                                    // if (course_instructor_data[i]["based_in_ahmedabad"] == 'N') {
                                    //     $('.cls_travel_accomodation' + (j + 1)).css('display', 'block');
                                    // }
                                    // 
                                    // $('#drp_is_travel_based_course' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course"]);
                                    // if (course_instructor_data[i]["is_travel_based_course"] == 'Y') {
                                    //     $('#txt_is_travel_based_course_from' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course_from"]);
                                    //     $('#txt_is_travel_based_course_to' + (j + 1)).val(course_instructor_data[i]["is_travel_based_course_to"]);
                                    // 
                                    //     $('#div_is_travel_based_course' + (j + 1)).css('display', 'block');
                                    // }
                                    // 
                                    // $('#drp_accommodation_needed' + (j + 1)).val(course_instructor_data[i]["accommodation_needed"]);
                                    // if (course_instructor_data[i]["accommodation_needed"] == 'Y') {
                                    //     if (course_instructor_data[i]["accommodation_needed_from_date"] != '') {
                                    //         var temp_date = new Date(course_instructor_data[i]["accommodation_needed_from_date"]);
                                    //         $('#txt_accomodation_from_date' + (j + 1)).val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                                    //     }
                                    // 
                                    //     if (course_instructor_data[i]["accommodation_needed_to_date"] != '') {
                                    //         var temp_date = new Date(course_instructor_data[i]["accommodation_needed_to_date"]);
                                    //         $('#txt_accomodation_to_date' + (j + 1)).val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                                    //     }
                                    // 
                                    //     $('#txt_accomodation_total_days' + (j + 1)).val(course_instructor_data[i]["accommodation_needed_total_days"]);
                                    //     obj_total_accomodation_days['' + (j + 1)] = course_instructor_data[i]["accommodation_needed_total_days"];
                                    // 
                                    //     $('#div_is_accomodation_needed' + (j + 1)).css('display', 'block');
                                    // }
                                }
                            }
                        });

                        if ($('#tblTA tbody tr').length > 0) {
                            // if ($('#hdnuserid').val() != 'temp_student') {
                            //     //$('#tblinstructor tbody .drpinstructor')[0].disabled = true;
                            // }
                            $('#tblTA tbody tr')[0].children[7].innerHTML = '';
                        }
                    }

                    $("#tbl_workplan tbody").html('');
                    if (data.d[2] != null) {

                        $("#tbl_workplan tbody").html('');
                        var course_workplan_data = JSON.parse(data.d[2]);

                        for (var i = 0; i < course_workplan_data.length; i++) {
                            var temp_workplan_date = '';
                            var temp_date;
                            if (course_workplan_data[i]["workplan_date"] != '') {
                                temp_date = new Date(course_workplan_data[i]["workplan_date"]);
                                temp_workplan_date = '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                            }

                            var str_tbody = '<tr id="' + temp_date + '"><td>Day' + (i + 1) + '</td>' +
                                '<td class="cls_workplan_date">' + temp_workplan_date + '</td>' +
                                '<td><input style="width: 60px;" type="text" class="from_time" onchange="calcTotalHour(this)" value="' + course_workplan_data[i]["from_time"] + '"/> - <input style="width: 60px;" type="text" class="to_time" onchange="calcTotalHour(this)" value="' + course_workplan_data[i]["To_time"] + '"/></td>' +
                                '<td><span class="cls_total_hrs">' + course_workplan_data[i]["no_of_hrs"] + '</span></td>' +
                                '<td style="display:none;"><input type="text" class="cls_topic_covered" style="width:90%;" value="' + course_workplan_data[i]["topic_covered"] + '" /></td>' +
                                '<td><input type="text" class="cls_Methodology" style="width:90%;" value="' + course_workplan_data[i]["methodology"] + '" /></td>' +
                                '<td><select class="cls_faculty_involve" style="width: 100px;" onchange="calc_faculty_workplan_total()"><option value="">-- Select Faculty --</option><option value="' + course_workplan_data[i]["faculty_involve"] + '">' + course_workplan_data[i]["faculty_involve"] + '</option></select><div class="cls_div_chk_faculty_involve"></div></td></tr>';

                            $('#tbl_workplan tbody').append(str_tbody);

                            $('#tbl_workplan tbody tr:last-child').find('.cls_Methodology').val(course_workplan_data[i]["methodology"]);


                            var arr_faculty_involve = course_workplan_data[i]["faculty_involve"].split('~');
                            var str_chk_faculty = '';
                            for (var j = 0; j < arr_faculty_involve.length; j++) {
                                if (j != 0) str_chk_faculty += '<br/>';
                                str_chk_faculty += '<input type="checkbox" class="cls_chk_faculty_involve" value="' + arr_faculty_involve[j] +
                                    '" onchange="calc_faculty_workplan_total()" checked /> ' + arr_faculty_involve[j];
                            }
                            $(document.getElementById(temp_date)).find('.cls_div_chk_faculty_involve').html(str_chk_faculty);


                            $('#tbl_workplan tbody tr')[i].getElementsByClassName("cls_faculty_involve")[0].value = course_workplan_data[i]["faculty_involve"];
                        }
                        set_faculty_involve_drp();
                        setTimepicker();
                        $('#tbl_workplan tbody tr')[0].getElementsByClassName("from_time")[0].onchange();
                    }
                    else {
                        set_faculty_involve_drp();
                    }

                    category_location_change();
                    if (data.d[0] != null)
                    {
                        var course_data = JSON.parse(data.d[0]);
                        if (course_data[0]["TravelStartDate"] != '') {
                            var temp_date = new Date(course_data[0]["TravelStartDate"]);
                            $('#txt_tral_start_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }

                        //$('#txt_end_date').val(course_data[0]["end_date"]);
                        if (course_data[0]["TravelEndDate"] != '') {
                            var temp_date = new Date(course_data[0]["TravelEndDate"]);
                            $('#txt_tral_end_date').val('' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear());
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function instructors_involved_change() {
            if (parseInt($('#drp_instructors_involved').val()) > $('#tblinstructor tbody tr').length) {
                for (var i = $('#tblinstructor tbody tr').length; i < parseInt($('#drp_instructors_involved').val()); i++) {
                    $('#btn_instructor').click();
                }
            }
            else if (parseInt($('#drp_instructors_involved').val()) < $('#tblinstructor tbody tr').length) {
                for (var i = $('#tblinstructor tbody tr').length; i > parseInt($('#drp_instructors_involved').val()); i--) {
                    $('#tblinstructor tbody tr')[i - 1].remove();
                }
                category_location_change();
                set_faculty_involve_drp();
            }
        }

        function category_location_change(req_flag)
        {
            if ($('#drp_course_type').val() == "")
            {
                bootbox.alert("Please Select Course Type");
                return false;
            }
            var min = 0;
            var max = 0;
            var cur_intake_capacity = $('#drpavailable_seats').val();
            if ($('#drp_category_location_wise').val() != '')
            {
                var rdo_instructor_type = 0;
                var str_instructor_type = '';
                for (var i = 0; i < $('#tblinstructor tbody tr').length; i++)
                {
                    if ($('input[name=rdo_faculty_type' + i + ']:checked').val() != undefined)
                    {
                        rdo_instructor_type = Math.max(rdo_instructor_type, $('input[name=rdo_faculty_type' + i + ']:checked').val());
                    }
                }
                switch (rdo_instructor_type) {
                    case 1: str_instructor_type = 'I2'; break;
                    case 2: str_instructor_type = 'VF'; break;
                    case 3: str_instructor_type = 'IVF'; break;
                }
                for (var i = 0; i < intake_criteria.length; i++) {
                    //if (intake_criteria[i]['intake_desc'] == $('#drp_category_location_wise').val() && intake_criteria[i]['instructor_type'] == $('#hdn_utype').val()) {
                    if (intake_criteria[i]['intake_desc'] == $('#drp_category_location_wise').val() && intake_criteria[i]['instructor_type'] == str_instructor_type) {
                        // Kapil 01022024
                        if (intake_criteria[i]['course_type'] == $('#drp_course_type').val())
                        {
                            min = parseInt(intake_criteria[i]['min']);
                            max = parseInt(intake_criteria[i]['max']);
                            if ($('#tblinstructor tbody tr').length > 1)
                            {
                                max = parseInt(intake_criteria[i]['two_faculty_max']);
                            }
                        }
                        
                    }
                }
            }

            $('#spn_min').html(min);
            $('#spn_max').html(max);

            var drpoption = $('#drpavailable_seats option')[0];
            $('#drpavailable_seats').html(drpoption);
            if (min != 0 && max != 0) {
                for (var i = min; i <= max; i++) {
                    $('#drpavailable_seats').append('<option id="' + i + '">' + i + '</option>');
                }
            }

            $('#drpavailable_seats').val(cur_intake_capacity);

            if (req_flag == 1) {
                //$('#div_based_in_ahmedabad').css('display', 'none');
                $('.div_based_in_ahmedabad').css('display', 'none');
                $('#drp_based_in_ahmedabad').val('');
                $('#drp_is_travel_based_course').val('');
                $('#drp_is_travel_based_course').change();
                $('#drp_accommodation_needed').val('');
                $('#drp_accommodation_needed').change();
                $('.cls_travel_accomodation').css('display', 'none');
                $('#txt_location').val('');

                for (var i = 1; i <= 3; i++) {
                    $('#drp_based_in_ahmedabad' + i).val('');
                    $('#drp_is_travel_based_course' + i).val('');
                    $('#drp_is_travel_based_course' + i).change();
                    $('#drp_accommodation_needed' + i).val('');
                    $('#drp_accommodation_needed' + i).change();
                    $('.cls_travel_accomodation' + i).css('display', 'none');
                }
            }

            if ($('#drp_category_location_wise').val() == 'Travel Based Outside India' || $('#drp_category_location_wise').val() == 'Travel Based Within India') {
                if (btnTAClicked) {
                    
                    btnTAClicked = false
                }
                else
                {
                    $('#txt_tral_start_date').val('');
                    $('#txt_tral_end_date').val('');
                }
                
                $('.cls_location').css('display', 'inline-block');
                //$('#txt_location').val('');
                $('#tralgroup').css('display', 'block');
                $('.cls_travel_accomodation').css('display', 'block');
                $('.cls_travel_accomodation1').css('display', 'block');
                $('.cls_travel_accomodation2').css('display', 'block');
                $('.cls_travel_accomodation3').css('display', 'block');//new 21102022
                $('.cls_travel_accomodation4').css('display', 'block');
                $('.cls_travel_accomodation5').css('display', 'block');

                $('.cls_food_stay').css('display', 'block');
                $('.cls_spn_local_travel').addClass('col-md-pull-1');
                $('.cls_txt_local_travel').removeClass('col-md-pull-1');
                $('.cls_txt_local_travel').addClass('col-md-pull-2');
                calc_cost();
            }
            else {
                $('.cls_location').css('display', 'none');
                //$('#txt_location').val('');
                $('#tralgroup').css('display', 'none');
                $('#txt_tral_start_date').val('');
                $('#txt_tral_end_date').val('');
                if ($('#drp_category_location_wise').val() != '') {

                    $('.cls_location').css('display', 'inline-block');

                    if ($('#drp_category_location_wise').val() == "Online Course") {
                        $('#txt_location').val('Online');
                    } else {
                        $('#txt_location').val('CEPT Campus');
                    }

                    //$('#div_based_in_ahmedabad').css('display', 'block');
                    $('.div_based_in_ahmedabad').css('display', 'block');
                    //$('#drp_based_in_ahmedabad').change();
                    based_in_ahmedabad_change();

                    for (var i = 0; i < $('#tblinstructor tbody tr').length; i++) {
                        var rdo_selected = $($('#tblinstructor tbody tr')[i]).find('input[name=rdo_faculty_type' + i + ']:checked');
                        if (rdo_selected.length > 0 && rdo_selected.val() == '1') {
                            $($('.div_based_in_ahmedabad')[i + 1]).css('display', 'none');
                            $('.cls_travel_accomodation' + (i + 1)).css('display', 'none');
                            $('#drp_based_in_ahmedabad' + (i + 1)).val('');
                            based_in_ahmedabad_change();
                        }
                    }
                }

                $('.cls_food_stay').css('display', 'none');
                $('.cls_spn_local_travel').removeClass('col-md-pull-1');
                $('.cls_txt_local_travel').removeClass('col-md-pull-2');
                $('.cls_txt_local_travel').addClass('col-md-pull-1');
                $('#txt_food_stay').val('');
                calc_cost();
            }


        }

        function based_in_ahmedabad_change(req_flag, cur_ele_id) {
            if (req_flag == 1) {
                $('#drp_is_travel_based_course').val('');
                $('#drp_is_travel_based_course').change();
                $('#drp_accommodation_needed').val('');
                $('#drp_accommodation_needed').change();
            }
            else if (req_flag == 2 && cur_ele_id != undefined) {
                $('#drp_is_travel_based_course' + cur_ele_id).val('');
                $('#drp_is_travel_based_course' + cur_ele_id).change();
                $('#drp_accommodation_needed' + cur_ele_id).val('');
                $('#drp_accommodation_needed' + cur_ele_id).change();
            }

            if (req_flag == 2 && cur_ele_id != undefined) {
                $('.cls_travel_accomodation' + cur_ele_id).css('display', 'none');

                if ($('#drp_based_in_ahmedabad' + cur_ele_id).val() == 'N') {
                    $('.cls_travel_accomodation' + cur_ele_id).css('display', 'block');
                }
            }
            else {
                $('.cls_travel_accomodation').css('display', 'none');

                if ($('#drp_based_in_ahmedabad').val() == 'N') {
                    $('.cls_travel_accomodation').css('display', 'block');
                }
            }
        }

        function credits_change() {
            if ($('#drp_credits').val() != '') {
                var credits = parseInt($('#drp_credits').val());

                $('#spn_credits_total_hrs').html(credits * 12);
            }
            else {
                $('#spn_credits_total_hrs').html('');
            }
            SetContactHours();
        }

        function chk_change() {
            if ($('#chk_is_for_professional')[0].checked) {
                $('#div_professional_prerequisite').css('display', 'block');
            }
            else {
                $('#div_professional_prerequisite').css('display', 'none');
            }
        }

        function other_major_expense_change() {
            if ($('#txt_other_major_expense').val() != '') $('.cls_specify_other_major_expense').css('display', 'block');
            else if ($('#txt_other_major_expense').val() == '') $('.cls_specify_other_major_expense').css('display', 'none');
        }

        function workplan_change() {
            if ($('#txt_start_date').val() != '' && $('#txt_end_date').val() != '') {
                var str_start_date = convertDateFormat($('#txt_start_date').val());
                if (str_start_date == '') return false;
                var str_end_date = convertDateFormat($('#txt_end_date').val());
                if (str_end_date == '') return false;

                var workplan_start_date = new Date(str_start_date);
                var workplan_end_date = new Date(str_end_date);

                var str_tbody = '';
                var day_cnt = 0;
                for (var i = workplan_start_date; i <= workplan_end_date; i.setDate(i.getDate() + 1)) {
                    str_tbody += '<tr id="' + i + '"><td>Day' + ++day_cnt + '</td>' +
                        '<td class="cls_workplan_date">' + i.getDate() + '/' + (i.getMonth() + 1) + '/' + i.getFullYear() + '</td>' +
                        '<td><input style="width: 60px;" type="text" class="from_time" onchange="calcTotalHour(this)"/> - <input style="width: 60px;" type="text" class="to_time" onchange="calcTotalHour(this)"/></td>' +
                        '<td><span class="cls_total_hrs"></span></td>' +
                        '<td style="display:none;"><input type="text" class="cls_topic_covered" style="width:90%;" /></td>' +
                        '<td><input type="text" class="cls_Methodology" style="width:90%;" /></td>' +
                        '<td><select class="cls_faculty_involve" style="width: 100px;" onchange="calc_faculty_workplan_total()"><option value="">-- Select Faculty --</option></select><div class="cls_div_chk_faculty_involve"></div></td></tr>';
                }
                $('#tbl_workplan tbody').html(str_tbody);

                setTimepicker();
                set_faculty_involve_drp();
                $('#tbl_workplan tbody tr')[0].getElementsByClassName("from_time")[0].onchange();
            }
            else {
                $('#tbl_workplan tbody').html('');
            }
        }

        var total_accomodation_days = '';
        var obj_total_accomodation_days = { '1': '', '2': '', '3': '' };
        function accomodation_date_change(cur_ele_id) {
            if (cur_ele_id != undefined) {
                if ($('#txt_accomodation_from_date' + cur_ele_id).val() != '' && $('#txt_accomodation_to_date' + cur_ele_id).val() != '') {
                    var str_start_date = convertDateFormat($('#txt_accomodation_from_date' + cur_ele_id).val());
                    if (str_start_date == '') return false;
                    var str_end_date = convertDateFormat($('#txt_accomodation_to_date' + cur_ele_id).val());
                    if (str_end_date == '') return false;

                    var accomodation_start_date = new Date(str_start_date);
                    var accomodation_end_date = new Date(str_end_date);

                    var day_cnt = 0;
                    for (var i = accomodation_start_date; i <= accomodation_end_date; i.setDate(i.getDate() + 1)) {
                        ++day_cnt;
                    }
                    $('#txt_accomodation_total_days' + cur_ele_id).val('' + day_cnt + ' Days');
                    obj_total_accomodation_days[cur_ele_id.toString()] = day_cnt.toString();
                }
                else {
                    $('#txt_accomodation_total_days' + cur_ele_id).val('');
                }
            }
            else {
                if ($('#txt_accomodation_from_date').val() != '' && $('#txt_accomodation_to_date').val() != '') {
                    var str_start_date = convertDateFormat($('#txt_accomodation_from_date').val());
                    if (str_start_date == '') return false;
                    var str_end_date = convertDateFormat($('#txt_accomodation_to_date').val());
                    if (str_end_date == '') return false;

                    var accomodation_start_date = new Date(str_start_date);
                    var accomodation_end_date = new Date(str_end_date);

                    var day_cnt = 0;
                    for (var i = accomodation_start_date; i <= accomodation_end_date; i.setDate(i.getDate() + 1)) {
                        ++day_cnt;
                    }
                    $('#txt_accomodation_total_days').val('' + day_cnt + ' Days');
                    total_accomodation_days = day_cnt.toString();
                }
                else {
                    $('#txt_accomodation_total_days').val('');
                }
            }
        }

        function travel_arrangement_change() {
            if ($('#drp_travel_arrangement_needed').val() == 'Y') {
                $('#div_travel_arrangement_needed').css('display', 'block');
            }
            else {
                $('#div_travel_arrangement_needed').css('display', 'none');
            }
        }

        function travel_based_course_change(cur_ele_id) {
            if (cur_ele_id != undefined) {
                if ($('#drp_is_travel_based_course' + cur_ele_id).val() == 'Y') {
                    $('#div_is_travel_based_course' + cur_ele_id).css('display', 'block');
                }
                else {
                    $('#div_is_travel_based_course' + cur_ele_id).css('display', 'none');
                }
            }
            else {
                if ($('#drp_is_travel_based_course').val() == 'Y') {
                    $('#div_is_travel_based_course').css('display', 'block');
                }
                else {
                    $('#div_is_travel_based_course').css('display', 'none');
                }
            }
        }

        function accomodation_needed_change(cur_ele_id) {
            if (cur_ele_id != undefined) {
                if ($('#drp_accommodation_needed' + cur_ele_id).val() == 'Y') {
                    $('#div_is_accomodation_needed' + cur_ele_id).css('display', 'block');
                }
                else {
                    $('#div_is_accomodation_needed' + cur_ele_id).css('display', 'none');
                }
            }
            else {
                if ($('#drp_accommodation_needed').val() == 'Y') {
                    $('#div_is_accomodation_needed').css('display', 'block');
                }
                else {
                    $('#div_is_accomodation_needed').css('display', 'none');
                }
            }
        }

        function contract_to_be_done_change() {
            if ($('#drp_contract_to_be_done').val() == 'Y') {
                //$('#div_contract_to_be_done').css('display', 'block');
                $('#txt_contract_to_be_done').css('display', 'block');
                $('#spn_amount').css('display', 'block');
            }
            else {
                //$('#div_contract_to_be_done').css('display', 'none');
                $('#txt_contract_to_be_done').css('display', 'none');
                $('#spn_amount').css('display', 'none');
            }
        }

        function set_faculty_involve_drp(drp_change) {
            for (var i = 1; i <= 5; i++) {//kapil
                $('#div_desc_faculty' + i).css('display', 'none');
                $('.cls_instructor' + i).css('display', 'none');
                $('.cls_instructor' + i)[0].innerHTML = '';
                $('#img_instructor_image' + i).attr('src', '');
            }

            //$('.cls_div_chk_faculty_involve').html('');

            if ($('#tblinstructor tbody tr').length > 0) {
                switch ($('#tblinstructor tbody tr').length) {
                    //case 1: faculty_word_limit = 100; break;
                    //case 2: faculty_word_limit = 75; break;
                    //case 3: faculty_word_limit = 50; break; 

                    case 1: faculty_word_limit = 900; break;
                    case 2: faculty_word_limit = 400; break;
                    case 3: faculty_word_limit = 250; break;
                    case 4: faculty_word_limit = 900; break;//kapil
                    case 5: faculty_word_limit = 900; break;
                    case 6: faculty_word_limit = 900; break;
                    case 7: faculty_word_limit = 900; break;
                    case 8: faculty_word_limit = 900; break;
                }

                var options = '';
                var str_chk_faculty = '';
                for (var i = 0; i < $('#tblinstructor tbody tr').length; i++) {
                    options += $('#tblinstructor tbody tr')[i].children[0].children[0].selectedOptions[0].outerHTML;

                    if (i != 0) str_chk_faculty += '<br/>';
                    str_chk_faculty += '<input type="checkbox" class="cls_chk_faculty_involve" value="' +
                        $('#tblinstructor tbody tr')[i].children[0].children[0].selectedOptions[0].value + '" onchange="calc_faculty_workplan_total()" /> ' +
                        $('#tblinstructor tbody tr')[i].children[0].children[0].selectedOptions[0].innerHTML;

                    $('#div_desc_faculty' + (i + 1)).css('display', 'block');
                    document.getElementById('txt_desc_faculty' + (i + 1)).maxLength = faculty_word_limit;
                    //$('#lbl_desc_faculty' + (i + 1)).html($('#tblinstructor tbody tr')[i].children[0].children[0].selectedOptions[0].innerHTML + '  <br/> (Max. ' + faculty_word_limit + ' Words)');
                    $('#lbl_desc_faculty' + (i + 1)).html($('#tblinstructor tbody tr')[i].children[0].children[0].selectedOptions[0].innerHTML + '  <br/> (Max. ' + faculty_word_limit + ' Characters)');
                    $('#phead_desc_faculty' + (i + 1)).html($('#tblinstructor tbody tr')[i].children[0].children[0].selectedOptions[0].innerHTML);

                    $('.cls_instructor' + (i + 1)).css('display', 'block');
                    $('.cls_instructor' + (i + 1))[0].innerHTML = $('#tblinstructor tbody tr')[i].children[0].children[0].selectedOptions[0].innerHTML + '<br />' + '(200 * 240)';
                    $('#img_instructor_image' + (i + 1)).attr('src', '../../UserPersonalPhoto/WS_' + $('#tblinstructor tbody tr')[i].children[0].children[0].selectedOptions[0].value + '.png' + '?' + (new Date()).getTime());
                    //$.get("http://localhost:36267/CEPT/UserPersonalPhoto/WS_I1516000065.png").done(function(){console.log('yes');}).fail(function(){console.log('no')});
                }

                //$('.cls_div_chk_faculty_involve').html('<input type="checkbox" class="cls_chk_faculty_involve" value="A" />A<br/><input type="checkbox" class="cls_chk_faculty_involve" value="B" />B<br/><input type="checkbox" class="cls_chk_faculty_involve" value="C" />C');
                //$('.cls_div_chk_faculty_involve').html(str_chk_faculty);

                for (var i = 0; i < $('.cls_faculty_involve').length; i++) {
                    var cur_faculty_involve = $('.cls_faculty_involve')[i].value;

                    $('.cls_faculty_involve')[i].innerHTML = '<option value="">-- Select Faculty --</option>' + options;

                    $('.cls_faculty_involve')[i].value = cur_faculty_involve;

                    if ($('.cls_faculty_involve')[i].value == '') $('.cls_faculty_involve')[i].value = '';

                    //var arr_faculty_involve = cur_faculty_involve.split('~');
                    var arr_faculty_involve = [];
                    var lst_faculty_involve = $($('.cls_div_chk_faculty_involve')[i]).find('.cls_chk_faculty_involve:checked');

                    for (var j = 0; j < lst_faculty_involve.length; j++) {
                        if (lst_faculty_involve[0].value != '') arr_faculty_involve.push(lst_faculty_involve[j].value);
                    }

                    $('.cls_div_chk_faculty_involve')[i].innerHTML = str_chk_faculty;

                    for (var j = 0; j < arr_faculty_involve.length; j++) {
                        var temp_chk = $($('.cls_div_chk_faculty_involve')[i]).find('.cls_chk_faculty_involve[value=' + arr_faculty_involve[j] + ']')[0];
                        if (temp_chk != undefined) {
                            temp_chk.checked = true;
                        }
                    }
                }

                if (drp_change == 1) {
                    if (obj_instructor[document.activeElement.value] == 'instructor') $(document.activeElement).closest('tr').find('input[type="radio"][value="1"]')[0].checked = true;
                    else if (obj_instructor[document.activeElement.value] == 'VF') $(document.activeElement).closest('tr').find('input[type="radio"][value="2"]')[0].checked = true;
                    else $(document.activeElement).closest('tr').find('input[type="radio"][value="2"]')[0].checked = true;
                }
                else
                {
                   // $(document.activeElement).closest('tr').find('input[type="radio"][value="2"]')[0].checked = true;
                }
            }
            else {
                $('.cls_faculty_involve').html('<option value="">-- Select Faculty --</option>');

                $('.cls_div_chk_faculty_involve').html('');
            }

            //$('.cls_faculty_involve').val('');
            $('.cls_faculty_involve').css('display', 'none');

            calc_faculty_workplan_total();
        }

        function calcTotalHour(cur_element) {
            var total_hour = 0;
            var total_min = 0;

            for (var i = 0; i < $('.ui-timepicker-input').length; i = i + 2) {

                var cur_tr = $('.ui-timepicker-input')[i].closest('tr');

                if ($('.ui-timepicker-input')[i].value != '' && $('.ui-timepicker-input')[i + 1].value != '') {
                    var temp_from = convertTime($('.ui-timepicker-input')[i].value);
                    var temp_to = convertTime($('.ui-timepicker-input')[i + 1].value);

                    var timediff_h = parseInt(temp_to.substring(0, 2)) - parseInt(temp_from.substring(0, 2));

                    var timediff_m;
                    if ((parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5))) < 0) {
                        timediff_h = timediff_h - 1;
                        timediff_m = parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5)) + 60;
                    }
                    else {
                        timediff_m = parseInt(temp_to.substring(3, 5)) - parseInt(temp_from.substring(3, 5));
                    }

                    if (timediff_h < 0 || (timediff_h == 0 && timediff_m < 0)) {
                        if (temp_to != '0.') {
                            bootbox.alert('From_Time is greater than To_Time');
                        }
                    }

                    total_hour = total_hour + timediff_h;
                    total_min = total_min + timediff_m;

                    if (timediff_m >= 60) {
                        timediff_h = timediff_h + 1;
                        timediff_m = timediff_m - 60;
                    }

                    cur_tr.getElementsByClassName('cls_total_hrs')[0].innerHTML = "" + timediff_h + "." + timediff_m + "";
                }
                else {
                    cur_tr.getElementsByClassName('cls_total_hrs')[0].innerHTML = "";
                }
            }

            if (total_min >= 60) {
                //total_hour = total_hour + 1;
                total_hour = total_hour + parseInt(total_min / 60);

                //total_min = total_min - 60;
                total_min = total_min % 60;
            }

            $('#td_total_contact_hrs').html("" + total_hour + "." + total_min);
            $('#td_duration_in_days').html("" + $('#tbl_workplan tbody tr').length);
            $('#spn_duration_in_days').html("" + $('#tbl_workplan tbody tr').length + " Days");
            calc_faculty_workplan_total();
        }

        function calc_faculty_workplan_total() {
            $('#tbl_workplan_faculty_total thead').html('');
            if ($('#tbl_workplan tbody tr').length > 0) {
                var options = $('#tbl_workplan tbody tr')[0].getElementsByClassName("cls_faculty_involve")[0].options;
                var options_total_workload = {};

                for (var i = 0; i < options.length; i++) {
                    if (options[i].value != '') {
                        options_total_workload[options[i].value] = 0;
                    }
                }

                //                //For Single Dropdown
                //                $('#tbl_workplan tbody tr').each(function (i) {
                //                    if ($(this).find('.cls_faculty_involve').val() != '' && parseFloat($(this).find('.cls_total_hrs').html()).toString() != 'NaN') {
                //                        var key = $(this).find('.cls_faculty_involve').val();

                //                        options_total_workload[key] += parseFloat($(this).find('.cls_total_hrs').html());

                //                        options_total_workload[key] = parseFloat(options_total_workload[key].toFixed(2));

                //                        if (options_total_workload[key].toString().split('.').length == 2) {
                //                            if (parseFloat(options_total_workload[key].toString().split('.')[1]) == 6) {
                //                                options_total_workload[key] += 0.40;
                //                            }
                //                        }
                //                    }
                //                });

                //For Multiple Checkboxes
                $('#tbl_workplan tbody tr').each(function (i) {
                    if ($(this).find('.cls_chk_faculty_involve:checked').length > 0 && parseFloat($(this).find('.cls_total_hrs').html()).toString() != 'NaN') {
                        for (var i = 0; i < $(this).find('.cls_chk_faculty_involve:checked').length; i++) {
                            var key = $(this).find('.cls_chk_faculty_involve:checked')[i].value;
                            options_total_workload[key] += parseFloat($(this).find('.cls_total_hrs').html());

                            options_total_workload[key] = parseFloat(options_total_workload[key].toFixed(2));

                            if (options_total_workload[key].toString().split('.').length == 2) {
                                if (parseFloat(options_total_workload[key].toString().split('.')[1]) == 6) {
                                    options_total_workload[key] += 0.40;
                                }
                            }
                        }
                    }
                });

                for (var i = 0; i < options.length; i++) {
                    if (options[i].value != '') {
                        $('#tbl_workplan_faculty_total thead').append('<tr><td>Workload of ' + options[i].innerHTML + '</td><td>&nbsp;:&nbsp;</td><td>' + options_total_workload[options[i].value].toFixed(2) + '</td></tr>');
                    }
                }
            }
        }

        function convertTime(tempTime) {

            if (tempTime.length < 7) {
                tempTime = '0' + tempTime;
            }

            if (tempTime.search('pm') != -1) {
                if (tempTime.substring(0, 2) != '12') {
                    tempTime = (parseInt(tempTime.substring(0, 2)) + 12) + '.' + tempTime.substring(3, 5);
                }
                else {
                    tempTime = tempTime.substring(0, 2) + '.' + tempTime.substring(3, 5);
                }
            }
            else {
                if (tempTime.substring(0, 2) != '12') {
                    tempTime = tempTime.substring(0, 2) + '.' + tempTime.substring(3, 5);
                }
                else {
                    tempTime = '00.' + tempTime.substring(3, 5);
                }
            }

            return tempTime;
        }

        function convertDateFormat(str_date) {
            if (str_date != '') {
                if (str_date.split('/').length == 3) {
                    var date_split = str_date.split('/');
                    var temp_date = new Date(date_split[1] + '/' + date_split[0] + '/' + date_split[2]);
                    if (temp_date.toString() == 'Invalid Date') {
                        bootbox.alert('Please Enter Date in valid format');
                        return '';
                    }
                    else {
                        return '' + (temp_date.getMonth() + 1) + '/' + temp_date.getDate() + '/' + temp_date.getFullYear();
                    }
                }
                else {
                    bootbox.alert('Please Enter Date in valid format');
                    return '';
                }
            }
            else
                return str_date;
        }

        function convertDateFormat_for_end_date(str_date) {
            if (str_date != '') {
                if (str_date.split('/').length == 3) {
                    var date_split = str_date.split('/');
                    var temp_date = new Date(date_split[1] + '/' + date_split[0] + '/' + date_split[2]);
                    if (temp_date.toString() == 'Invalid Date') {
                        bootbox.alert('Please Enter Date in valid format');
                        return '';
                    }
                    else {
                        return '' + temp_date.getDate() + '/' + (temp_date.getMonth() + 1) + '/' + temp_date.getFullYear();
                    }
                }
                else {
                    bootbox.alert('Please Enter Date in valid format');
                    return '';
                }
            }
            else
                return str_date;
        }

        function replace_special_char(data) {
            if (data != '') {
                data = data.replace(/\\/g, '\\\\');
                //data = data.replace(/\'/g, '\\\'')
                data = data.replace(/"/g, '\\\"');
            }
            return data;
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

        function CheckMarksDocumentExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'xlsx':
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

        function UploadData() {
            try {
                var fileToUpload = GetFileNameFromPath($('#userid_document').val());

                if (CheckMarksDocumentExtension(fileToUpload)) {
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../../Handler/Upload_File_Course_Budget.ashx',
                        secureuri: false,
                        data: { 'UploadType': $('#hdnuserid').val() },
                        fileElementId: 'userid_document',
                        dataType: 'text',
                        success: function (data, status)
                        {
                            if (data == null) {
                                $("#UploadingProgress").fadeOut(200);
                                //alert("No Student IDs Found in Excel.");
                                $('#userid_document').val('');
                            }
                            else if (status == "success" && data != "") {
                                $('#lbl_excercises_file_name').text(data);
                            }
                            else {
                                $("#UploadingProgress").fadeOut(200);
                                //alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                                $('#userid_document').val('');
                                $('#lbl_excercises_file_name').text('');
                            }
                        },
                        error: function (data, status, e) {
                            $("#UploadingProgress").fadeOut(200);
                            alert(data.responseText);
                            //window.location.reload();
                            $('#userid_document').val('');
                            $('#lbl_excercises_file_name').text('');
                        }
                    });
                }
                else {
                    alert('Invalid File Type. Please upload .xlsx file');
                    $('#userid_document').val('');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
                $('#userid_document').val('');
            }
        }


        function bindindexdb(instructordata)
        {
           
            var request = indexedDB.open("MyDatabase", 1);

            request.onsuccess = function (event) {
                var db = event.target.result;
                var transaction = db.transaction(["myObjectStore"], "readwrite");
                var objectStore = transaction.objectStore("myObjectStore");
                var data = {
                    id: '1',
                    value: instructordata
                };
                var addRequest = objectStore.add(data);
                addRequest.onsuccess = function (event) {
                    console.log("Data added successfully");
                };

                addRequest.onerror = function (event) {
                    console.error("Error adding data: ", event.target.errorCode);
                };
            };

            request.onerror = function (event) {
                console.error("Database error: ", event.target.errorCode);
            };
        }

        function addCourseAssessment() {
            var total_assessment = $('#tbl_course_assessment tbody tr').length;
            if (total_assessment < 20) {
                var str_html = '<tr class="tr_assessment">' +
                    '<td class="align-pad">Assessment ' + (total_assessment + 1) + '</td>' +
                    '<td><input type="text" class="cls_exercises" value="" /></td>' +
                    '<td><input type="text" class="cls_percentage" value="" onkeypress="return IsNumeric(event);" /></td>' +
                    '<td><input type="text" class="cls_criteria" value="" /></td><td><center><i class="icon-trash icon-2x text-blue" style="cursor:pointer;"></i></center></td></tr>';

                $('#tbl_course_assessment tbody').append(str_html);
            }
        }
        $('#tbl_course_assessment tbody tr td i.icon-trash').live('click', function (e) {
            var r = confirm("Are you sure you want to remove this?");

            if (r == true) {
                var datalist = [];
                var flag = 'Y';
                var ob = {};
                var thisdata = $(this).closest("tr");

                $(this).closest("tr").remove();
                var totalsum = 0;

                $('#tbl_course_assessment tbody tr').each(function (i) {
                    $(this).children().eq(0).html('Assessment ' + (i + 1));
                });
            }
        });
    </script>
</asp:Content>
