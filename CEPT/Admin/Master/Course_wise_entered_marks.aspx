<%@ Page Title="Marks Entry" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Course_wise_entered_marks.aspx.cs" Inherits="Admin_Master_Course_wise_entered_marks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/course_wise_entered_marks.js?t=12022021" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">

        $(document).ready(function () {
           
            if (getParameterByName("autho") == 'false') {
                bootbox.alert('You are not authorized to view this page.', function (result) {
                    window.location.replace('Course_wise_entered_marks.aspx');
                });
            }
            else if (getParameterByName("autho") == 'app') {
                if ($('#hdnusertype').val() == 'I2' || $('#hdnusertype').val() == 'PC' || $('#hdnusertype').val() == 'D' || $('#hdnusertype').val() == 'FA') {
                    bootbox.alert('You can not edit student marks after submit.', function (result) {
                        window.location.replace('Course_wise_entered_marks.aspx')
                    });
                }
            }

        });

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>
    <style>
        #myTab {
            margin-bottom: 0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Wise Entered Marks
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>
                                    Year of allocation :
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
                                    Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Course Wise Entered Marks Detail</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
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
        </div>
        <div id="div_btn" style="text-align: center;">
        </div>
        <%--<div id="div_tab" class="tabbable" style="width: 100%; margin-bottom: 20px;">
            <div id="div_myTab">
                <ul class="nav nav-tabs" id="myTab">
                    <li class="active"><a data-toggle="tab" href="#pendingcourse">Course Wise Entered Marks Detail&nbsp;</a></li>
                    <li><a data-toggle="tab" href="#mycourses">My Courses &nbsp; </a></li>
                </ul>
            </div>
            <div class="tab-content">
                <div id="pendingcourse" class="tab-pane in active">
                    <div id="Div1" style="display: none;">
                        <table cellpadding="0" cellspacing="0" border="0" id="Table1" class="display table table-striped table-bordered table-hover"
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
                
            </div>
        </div>--%>
         <input type="hidden" id="hdn_degination" runat="server" clientidmode="Static" />
    </div>
</asp:Content>
