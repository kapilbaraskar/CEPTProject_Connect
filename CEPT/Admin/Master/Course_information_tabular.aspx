<%@ Page Title="Course Information" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Course_information_tabular.aspx.cs" Inherits="Admin_Master_Course_information_tabular" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_dashboard.js?t=10072024" type="text/javascript"></script><%--21092019/25062020--%>

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <%--<script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>--%>
    
    <script type="text/javascript">
        $(document).ready(function () {
            if (getParameterByName("autho") == 'false') {
                bootbox.alert('You are not authorized to view this page.');
            }
        });

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }
    </script>

    <style type="text/css">
        .cls_font
        {
            font-size: 15px;
        }
        .cls_justify
        {
            text-align: justify;
        }
         .courseimg
        {
            height: 200px;
            width: 150px;
        }

        #img1,#img2
        {
            height: 200px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="modal hide fade" id="my_outline" style="margin-left: -500px; width: 70%;
        overflow: auto; height: 82%;">
        <button style="float: right" class="btn btn-lg btn-primary" id="btn_print_outline">
            Print outline</button>
        <div class="panel panel-default " id="my_print_outline">
            <div class="panel-body">
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        Faculty of <span id="spn_faculty"></span>, CEPT University
                    </div>
                </div>
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        <span id="spn_semester"></span> Semester, <span id="spn_year"></span>
                    </div>
                </div>
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        Program : <span id="spn_prog_level_code"></span>
                    </div>
                </div>
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        <b style="font-size: 18px;"><span id="txt_course_code"></span></b>
                    </div>
                </div>
                <div class="row" style="text-align: center;">
                    <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                        Instructors : <span id="spn_instructor"></span>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue" style="display:none;" id="mainimg">
                        <b>Form of Final Output :</b>
                    </div>
                    <div class="form-group col-md-9">
                        <div class="form-group col-md-4">
                            <img id="img1" style="display: none;"></img>
                            <div id="div_caption1"></div>
                        </div>
                        <div class="form-group col-md-4">
                            <img id="img2" style="display: none;"></img>
                            <div id="div_caption2"></div>
                        </div>
                    </div>
                </div>
                <div class=" row" style="margin-top: 10px;">
                    <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 color-blue">
                        <b>Prerequisites : </b>
                    </div>
                </div>
                <div class=" row">
                    <div class="form-group col-md-11 color-blue">
                        <div style="text-align: justify; font-family: arial;" id="txt_Prerequisite">
                        </div>
                    </div>
                </div>
                <div class=" row" style="margin-top: 15px;">
                    <div style="font-size: 15px; font-family: arial;" class="form-group col-md-2 color-blue">
                        <b>Introduction : </b>
                    </div>
                </div>
                <div class=" row">
                    <div class="form-group col-md-11">
                        <div style="text-align: justify; font-family: arial;" id="txtcourse_outline">
                        </div>
                    </div>
                </div>
                <div id="div_weekly_plan" style="display: none; margin-top: 15px;">
                    <div class="cls_font row">
                        <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 color-blue">
                            <b>Detailed Outline & Schedule </b>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 1 :</b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week1">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference1">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference1">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 2 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week2">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference2">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference2">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 3 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week3">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference3">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference3">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 4 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week4">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference4">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference4">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 5 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week5">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference5">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify; font-family: arial;" id="txt_reference5">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080; font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 6 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify; font-family: arial;" id="txt_week6">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference6">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference6">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 7 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week7">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference7">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference7">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 8 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week8">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference8">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference8">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 9 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week9">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference9">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference9">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 10 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week10">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference10">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference10">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 11 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week11">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference11">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference11">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 12 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week12">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference12">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference12">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 13 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week13">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference13">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference13">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 14 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week14">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference14">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class=" row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference14">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 15 :</b>
                        </div>
                    </div>
                    <div class=" row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week15">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference15">
                        <div class=" row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference15">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Session 16 :</b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txt_week16">
                            </div>
                        </div>
                    </div>
                    <div id="div_reference16">
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Readings :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 divweek color-blue">
                                <div style="text-align: justify;font-family: arial;" id="txt_reference16">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="div_course_structure" style="margin-top: 10px; display: none;">
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Course Structure : </b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" id="txtcourse_structure">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 15px;">
                    <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                        <b>References/Reading :</b>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-11 color-blue">
                        <div style="text-align: justify;font-family: arial;" id="txt_reference">
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 15px;">
                    <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                        <b>Evaluation Method :</b>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-11 color-blue">
                        <div style="text-align: justify;font-family: arial;" id="txt_eval_method">
                        </div>
                    </div>
                </div>
                <div class="row" style="margin-top: 10px;">
                    <div class="form-group col-md-2 color-blue" style="display:none;" id="img567">
                        <b>Form of Final Output :</b>
                    </div>
                    <div class="form-group col-md-9">

                        <img id="img3" class="courseimg" style="display: none;"></img>


                        <img id="img4" class="courseimg" style="display: none;"></img>


                        <img id="img5" class="courseimg" style="display: none;"></img>


                        <img id="img6" class="courseimg" style="display: none;"></img>


                        <img id="img7" class="courseimg" style="display: none;"></img>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal hide fade" id="div_download_all_outline" style="margin-left: -500px;width: 70%; overflow: auto; height: 82%;">
        <button style="float:right;margin-top:12px;margin-right:12px;" class="btn btn-lg btn-primary" id="btn_all_download_print">Print outline</button>

        <div id="div_print_all" style="padding:12px;background:lightgrey;"></div>

        <div id="downloadoutline">
            <div class="panel panel-default" style="page-break-after: always;">
                <div class="panel-body">
                    <div class="row" style="text-align: center;">
                        <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                            Faculty of <span class="spn_faculty"></span>, CEPT University
                        </div>
                    </div>
                    <div class="row" style="text-align: center;">
                        <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                            <span class="spn_semester"></span> Semester, <span class="spn_year"></span>
                        </div>
                    </div>
                    <div class="row" style="text-align: center;">
                        <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                            Program : <span class="spn_prog_level_code"></span>
                        </div>
                    </div>
                    <div class="row" style="text-align: center;">
                        <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                            <b style="font-size: 18px;"><span class="txt_course_code"></span></b>
                        </div>
                    </div>
                    <div class="row" style="text-align: center;">
                        <div style="font-family: arial;" class="form-group col-md-11 color-blue">
                            Instructors : <span class="spn_instructor"></span>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px;">
                        <div style="font-size: 15px;font-family: arial;" class="cls_font form-group col-md-5 color-blue">
                            <b>Prerequisites : </b>
                        </div>
                    </div>
                    <div class="row">
                        <div class=" form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" class="txt_Prerequisite">
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px;font-family: arial;" class="cls_font form-group col-md-2 color-blue">
                            <b>Introduction : </b>
                        </div>
                    </div>
                    <div class="cls_justify row">
                        <div class="form-group col-md-11">
                            <div style="text-align: justify;font-family: arial;" class="txtcourse_outline">
                            </div>
                        </div>
                    </div>
                    <div class="divweeklyplan" style="display: none; margin-top: 15px;">
                        <div class="row">
                            <div style="font-size: 15px;font-family: arial;" class=" form-group col-md-5 color-blue">
                                <b>Detailed Outline & Schedule </b>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 1 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week1">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference1">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference1">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 2 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week2">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference2">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference2">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 3 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week3">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference3">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference3">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 4 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week4">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference4">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference4">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 5 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week5">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference5">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference5">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 6 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week6">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference6">
                            <div class="cls_font row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference6">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 7 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week7">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference7">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference7">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 8 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week8">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference8">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference8">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 9 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week9">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference9">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference9">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="cls_font row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 10 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week10">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference10">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference10">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 11 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week11">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference11">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference11">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 12 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week12">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference12">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference12">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 13 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week13">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference13">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference13">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 14 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week14">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference14">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference14">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 15 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week15">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference15">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference15">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px; color: #000080;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Session 16 :</b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txt_week16">
                                </div>
                            </div>
                        </div>
                        <div class="div_reference16">
                            <div class="row" style="margin-top: 15px;">
                                <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                    <b>Readings :</b>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col-md-11 divweek color-blue">
                                    <div style="text-align: justify;font-family: arial;" class="txt_reference16">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="divcoursestructure" style="margin-top: 10px; display: none;">
                        <div class="row" style="margin-top: 15px;">
                            <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                                <b>Course Structure : </b>
                            </div>
                        </div>
                        <div class="row">
                            <div class="form-group col-md-11 color-blue">
                                <div style="text-align: justify;font-family: arial;" class="txtcourse_structure">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>References/Reading :</b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" class="txt_reference">
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 15px;">
                        <div style="font-size: 15px;font-family: arial;" class="form-group col-md-5 divweek color-blue">
                            <b>Evaluation Method :</b>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group col-md-11 color-blue">
                            <div style="text-align: justify;font-family: arial;" class="txt_eval_method">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div id="div_wel" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Dashboard</span></strong></div>
            <div style="padding-top: 10px; padding-left: 10px;">
                <div class="row">
                    <div id="wel_msg" class="form-group col-md-12" align="center">
                        <h1>
                            Welcome</h1>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Retrieve Course Data</span></strong>
                <a target="_blank" href="Course_information.aspx" class="panel-headingfont" style="float: right;"><u>View as Without Tabular</u></a>
            </div>
            
            <div style="padding: 15px;" id="div3">
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
                    </div>--%>
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Semester :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpsem">
                            <option value="M">Monsoon</option>
                            <option value="S">Spring</option>
                        </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Year :
                    </div>
                    <div id="div_cur_sem_course" class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpyear">
                        </select>
                    </div>
                   

                    
                </div>
                <div class="row">
                     <div class="form-group col-md-1" style="padding-top: 8px;">
                        Faculty :
                    </div>
                    <div id="div_cur_sem_faculty" class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpdepartment">
                        </select>
                    </div>
                     <div class="form-group col-md-1" style="padding-top: 8px;">
                        Program :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpprog">
                        </select>
                    </div>
                </div>
                <div class="row" style="padding-top:8px;">
                   
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Program Level :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpproglevel">
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <button class="btn btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                    <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static" />
                </div>
                <%--<div class="row">
                    <div style="margin-left: 41%;" class="form-group col-md-12">
                        <button class="btn  btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>--%>
            </div>
        </div>
        <%--<div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Courses Pending for Approval</span></strong></div>
            <div style="padding-top: 10px; padding-left: 10px;">
                <div id="DataList" style="display: none">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>--%>
        <div id="div_tab" class="tabbable" style="display: none; width: 100%; margin-bottom: 20px;">
            <div id="div_myTab">
                <%--<ul class="nav nav-tabs" id="myTab">
                <li class="active"><a data-toggle="tab" href="#pendingcourse">Courses Pending for Approval&nbsp;</a>
                </li>
                <li><a data-toggle="tab" href="#mycourses">My Courses &nbsp; </a></li>
                </ul>--%>
            </div>
            <div class="tab-content">
                <div id="pendingcourse" class="tab-pane">
                    <%-- in active">--%>
                    <div id="DataList" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="inital_pendingcourse" class="tab-pane">
                    <div id="DataList_inital_PC" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_inital_pc" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="mycourses" class="tab-pane">
                    <div id="DataList_mycourse" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_mycourse" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div id="approvedcourses" class="tab-pane">
                    <div style="position: absolute;">
                        <button class="btn btn-primary" type="button" id="btn_download_all" style="display: none;">
                            <i class="icon-download"></i>&nbsp; Download All
                        </button>
                    </div>
                    <div id="DataList_approvedcourses" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_approvedcourses" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                 <div id="allapprovedcourses" class="tab-pane">
                    
                    <div id="DataList_allapprovedcourses" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_allapprovedcourses" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="approvedcourses_fa" class="tab-pane">
                    <div id="DataList_approvedcourses_fa" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_approvedcourses_fa" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div id="allpendingcac" class="tab-pane">
                    <div id="DataList_pending_CAC" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="example_pending_CAC" class="display table table-striped table-bordered table-hover"
                            width="100%">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="ifrm_outline" style="display:none;"></div>
    <input type="hidden" id="hdn_course_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" />
    <div style="display: none;">
        <asp:Button ID="btn_download" runat="server" ClientIDMode="Static" Text="test" OnClick="Download_OutLine" />
    </div>
</asp:Content>

