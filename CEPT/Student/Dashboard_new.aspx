<%@ Page Title="Dashboard - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true"
    CodeFile="Dashboard_new.aspx.cs" Inherits="Student_Dashboard_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Js/student_dashboard.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> DashBoard
            </h1>
            <table border="0" cellpadding="10" cellspacing="5">
                <tr>
                    <td style="width:500px">
                        <h4>
                            Add Total Credit Choice For Current Semester</h4>
                    </td>
                    <td>
                        <label id="creadit">
                            <input type="text" id="txtcreditchoice" />
                        </label>
                    </td>
                    <td>
                        <button class="btn btn-primary" type="submit" id="btn_save">
                            Save
                        </button>
                    </td>
                    <td style="margin-left: 20px; width: 500px" align="right">
                        <a href="<%= Page.ResolveClientUrl("~/Student/student_dashboard.aspx") %>">Go To Course
                            Selection</a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="row">
            <div class="col-xs-100">
                <!-- PAGE CONTENT BEGINS -->
                <div class="row">
                    <div class="col-sm-10 span4" style="margin-left: 50px">
                        <div class="widget-box">
                            <div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i>Registration Status
                                </h4>
                            </div>
                            <div class="widget-body">
                                <div class="widget-main">
                                    <div class="row">
                                        <div style="margin-left: 25px" class="col-xs-12">
                                            <p>
                                                <h4>
                                                    You have Saved the following Course</h4>
                                            </p>
                                        </div>
                                        <div id="datalist_saved" style="margin-left: 30px; display: none;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="datatable_saved" class="display table table-striped table-bordered table-hover"   width="100%">
                                                <thead>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <b>
                                        <hr />
                                    </b>
                                    <div class="row">
                                        <div class="col-xs-12">
                                            <h4 style="margin-left:25px">
                                                Fees Status :</h4>
                                            <p>
                                                <label style="margin-left: 20px" id="lbl_fees_status">
                                                </label>
                                            </p>
                                        </div>
                                    </div>
                                    <b>
                                        <hr />
                                    </b>
                                    <div class="row">
                                        <div style="margin-left: 25px" class="col-xs-12">
                                            <p>
                                                <h4>
                                                    You have Registered the following Course</h4>
                                            </p>
                                        </div>
                                        <div id="datalist_register" style="margin-left: 30px; display: none">
                                            <table cellpadding="0" cellspacing="0" border="0" id="datatable_register" class="display table table-striped table-bordered table-hover">
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
                    </div>
                    <div class="col-sm-8 span7" style="margin-left: 60px">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">
                                            Step 1</h4>
                                        <%--   <div class="widget-toolbar">
                                            <label>
                                                <small class="green"><b>Horizontal</b> </small>
                                                <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
                                                <span class="lbl"></span>
                                            </label>
                                        </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <%--   <code class="pull-right" id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <dl id="dt-list-1">
                                                <dt>Step 1</dt>
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
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">
                                            Step 2</h4>
                                        <%--   <div class="widget-toolbar">
                                            <label>
                                                <small class="green"><b>Horizontal</b> </small>
                                                <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
                                                <span class="lbl"></span>
                                            </label>
                                        </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <%--   <code class="pull-right" id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <dl id="Dl1">
                                                <dt>Step 2</dt>
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
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">
                                            Step 2</h4>
                                        <%--   <div class="widget-toolbar">
                                            <label>
                                                <small class="green"><b>Horizontal</b> </small>
                                                <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
                                                <span class="lbl"></span>
                                            </label>
                                        </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <%--   <code class="pull-right" id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <dl id="Dl2">
                                                <dt>Step 2</dt>
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
