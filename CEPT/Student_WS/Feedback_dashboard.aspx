<%@ Page Title="Feedback Dashboard" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="Feedback_dashboard.aspx.cs" Inherits="Student_Feedback_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Js_WS/feedback_dashboard.js" type="text/javascript"></script>
    <script src="../Js_WS/google_analytics_code.js" type="text/javascript"></script>
    
    <style type="text/css">
        .style1 {
            width: 386px;
        }
    </style>
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> DashBoard
                <%--<img src="<%= Page.ResolveClientUrl("~/image/logo.png") %>" />--%>
            </h1>
            <table style="display: none" border="0" cellpadding="10" cellspacing="5">
                <tr>
                    <td style="display: none">
                        <h5>Add Total Credit Choice For Current Semester</h5>
                    </td>
                    <td style="display: none">
                        <label id="creadit">
                            <input type="text" id="txtcreditchoice" />
                        </label>
                    </td>
                    <td style="width: 300px">
                        <button style="display: none" class="btn btn-primary" type="submit" id="btn_save">
                            Save
                        </button>
                    </td>
                    <td style="margin-left: 180px" align="right">
                        <a href="<%= Page.ResolveClientUrl("~/Student/student_dashboard.aspx") %>" class="btn btn-sm btn-primary">
                            <span class="bigger-50">Go To Course Selection</span><i class="icon-on-right icon-arrow-right"></i>
                        </a>
                    </td>
                    <td style="margin-left: 120px" align="right">
                        <a href="<%= Page.ResolveClientUrl("~/Student/calender.aspx") %>" class="btn btn-sm btn-primary">
                            <i class="icon-time"></i><span class="bigger-50">View Time Table</span> </a>
                    </td>
                </tr>
            </table>
        </div>
       
                
           


        <div class="row">
            <div>
                <!-- PAGE CONTENT BEGINS -->
                <div class="row">
                    <div class="span5" style="margin-left: 50px">
                         <div id="sws_wid" class="widget-box" >
                            <div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i>SW Elective Registration   
                                </h4>
                            </div>
                             <div class="widget-body">
                                <div class="widget-main">
                            <div>
                                <p>
                                    <h5> SW Elective Course Registration : <a id='yourlinkId' href='yourlinkId_'> Click Here </a></h5>
                                    <h5> SW Course Log : <a id='courselog' href='courselog_'> Click Here </a></h5>
                                    <h5> SW Drop Course : <a id='dropcourse' href='dropcourse_'> Click Here </a></h5>
                                    <h5> SW Request for Refund Amount : <a id='droprefund' href='droprefund_'> Click Here </a></h5>
                                </p>
                            </div>
                                    </div>
                                    </div>

                        </div>

                        <div class="widget-box">
                            <div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i>Feedback Status
                                </h4>
                            </div>
                            <div class="widget-body">
                                <div class="widget-main"> 
                                    <div style="display: none" class="row">
                                        <div style="margin-left: 25px">
                                            <p>
                                                <h5>You have selected/saved the following courses</h5>
                                            </p>
                                        </div>
                                        <div id="datalist_saved" style="margin-left: 15px; margin-right: 15px; display: none;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="datatable_saved" class="display table table-striped table-bordered table-hover"
                                                width="100%">
                                                <thead>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <%--<b>
                                        <hr />
                                    </b>--%>
                                    <div style="display: none" class="row">
                                        <div>
                                            <h4 style="margin-left: 25px">Fees Status :</h4>
                                            <p>
                                                <label style="margin-left: 20px" id="lbl_fees_status">
                                                </label>
                                            </p>
                                        </div>
                                    </div>
                                    <%--<b>
                                        <hr />
                                    </b>--%>
                                    <div class="row">
                                        <div style="margin-left: 25px">
                                            <p>
                                                <h5>You have been assigned following Courses</h5>
                                            </p>
                                        </div>
                                        <div id="datalist_register" style="margin-left: 26px; margin-right: 4px; display: none; width: 89%;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="datatable_register" class="display table table-striped table-bordered table-hover">
                                                <thead>
                                                </thead>
                                                <tbody style="cursor: pointer;">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                       
                    </div>

                    <div class="span6" style="margin-left: 60px">
                        <div class="row">
                            <div>
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">Feedback Instructions</h4>
                                        <%--   <div class="widget-toolbar">
                                            <label>
                                                <small class="green"><b>Horizontal</b> </small>
                                                <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
                                                <span class="lbl"></span>
                                            </label>
                                        </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div style="font-size: 14px" class="widget-main">
                                            <%--   <code class="pull-right" id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <%--  <dt>Go to the course selection page. You will see a list of mandatory courses for your
                                                faculty. Please select the mandatory courses you want to register for. Save your
                                                selection from the button given at the bottom of the page.</dt>--%>
                                            1. Click on the course for which you wish to submit the feedback. You will see the
                                            feedback form you are required to fill. Please see the instructions on the form
                                            before you proceed.
                                            <br />
                                            <br />
                                            Check the Course code, Course title and the Name of the Instructor on the feedback
                                            form. (In case you have any query related to Course title and Instructor, please
                                            contact University Staff Office (Summer Winter school office) at uso@cept.ac.in
                                            (summerwinterschool@cept.ac.in) before filling up the form).<br />
                                            <br />
                                            3. Enter your feedback for the selected course and the instructor and click the
                                            SAVE button to save the feedback in between if you wish to do so and you may come
                                            back and complete your feedback later.<br />
                                            <br />
                                            4. Once you finish the feedback form, click the SUBMIT button to finish the feedback
                                            form. Please note once you submit the feedback you may not be able to change the
                                            feedback.
                                            <dl id="dt-list-1">
                                                <%-- <dd>
                                                    A description list is perfect for defining terms.</dd>
                                                <dt>Euismod</dt>
                                                <dd>
                                                    Vestibulum id ligula porta felis euismod semper eget lacinia odio sem nec elit.</dd>
                                                <dd>
                                                    Donec id elit non mi porta gravida at eget metus.</dd>
                                                <dt>Malesuada porta</dt>
                                                <dd>
                                                    Etiam porta sem malesuada magna mollis euismod.</dd>
                                                <dt>Felis euismod semper eget lacinia</dt>
                                                <dd>
                                                    Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum
                                                    massa justo sit amet risus.</dd>--%>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="space-6">
                        </div>
                    </div>
                    <!-- /span -->
                </div>

            
                <!-- PAGE CONTENT ENDS -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </div>
    <%--<div class="col-sm-8">
        <table width="100%">
            <tr>
                <td>
                    <h2>
                        Your Selected Course List For Current Semester
                    </h2>
                </td>
                <td align="right">
                    <a href="<%= Page.ResolveClientUrl("~/Student/student_dashboard.aspx") %>">Go To Course
                        Selection</a>
                </td>
            </tr>
        </table>
    </div>--%>
    <%--  <div class="tab-content">
        <div id="DataList">
            <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>--%>
</asp:Content>
