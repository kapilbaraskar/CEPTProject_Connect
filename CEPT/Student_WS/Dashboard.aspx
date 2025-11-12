<%@ Page Title="Dashboard - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Student_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../Js/student_dashboard_03012016.js" type="text/javascript"></script>
   
    
    <style type="text/css">
        .style1
        {
            width: 386px;
        }
        #sidebar:before
        {
            width: 124px;
        }
        #sidebar
        {
            width: 124px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div id="AllocationAgreeModal" class="modal hide fade" tabindex="-1" role="dialog"
            aria-labelledby="myModalLabel" aria-hidden="true">
            <%-- <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    ×</button>
            </div>--%>
            <div class="modal-body" style="overflow: hidden;">
                <div class="controls">
                    <div class="col-xs-12">
                        <h5>
                            <b>You have been allocated the following courses.please confirm your acceptance.
                            </b>
                        </h5>
                    </div>
                    <br />
                    <div id="datalist_agree">
                        <table cellpadding="0" cellspacing="0" border="0" id="tbl_agree" class="display table table-striped table-bordered table-hover">
                            <thead>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <br />
                    <%--  <div style="text-align:center;">
                        <span style="margin-left: 4px;">
                            <input type="radio" name="agree" value="Y" checked />
                            <b style="vertical-align: bottom;">Accept</b> </span><span style="margin-left: 4px;">
                                <input type="radio" name="agree" value="N" />
                                <b style="vertical-align: bottom;">Drop Courses</b> </span>
                    </div>--%>
                    <b>Note :</b> If you do not want to accept the course, click on 'Drop".<b> Request of
                        changing the course after dropping will not be encouraged. In no case, will the
                        allocated course be changed.</b> You will get the refund after deduction of
                    administrative cost as mentioned on website.
                    <br />
                    <br />

                    <div id="div_chk_drop" style="display:none;">
                        <input type="checkbox" id="chk_drop" />
                        <div style="width: 94%;float: right;text-align: justify;">
                            <b>
                                This is to inform you that though you may have clicked the DROP button, 
                                the date on which the hard copy of refund form and pay slip (student copy) is submitted, 
                                will be considered  as the submission date of your refund application form.
                            </b>
                        </div>
                        
                        <br style="clear:both;" />
                        <br />
                    </div>
                    
                    <b>If not submitted before 5th March 6pm, the allocation will be considered 'accepted'.</b>
                </div>
            </div>
            <div style="text-align: center;" class="modal-footer">
                   <button class="btn btn-primary" id="btn_save_agree" data-style="zoom-in">
                    <span class="ladda-label">Save</span></button>
            </div>
        </div>
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>DashBoard
                <%--<img src="<%= Page.ResolveClientUrl("~/image/logo.png") %>" />--%>
            </h1>
            <table border="0" cellpadding="10" cellspacing="5">
                <tr>
                    <td style="display: none">
                        <h5>
                            Add Total Credit Choice For Current Semester</h5>
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
                        <a href="<%= Page.ResolveClientUrl("~/Student/student_dashboard.aspx") %>" class="btn
    btn-sm btn-primary"><span class="bigger-50">Go To Course Selection</span><i class="icon-on-right
    icon-arrow-right"></i> </a>
                    </td>
                    <%-- <td style="margin-left: 120px" align="right">
    <a href="<%= Page.ResolveClientUrl("~/Student/calender.aspx") %>" class="btn btn-sm
    btn-primary"> <i class="icon-time"></i><span class="bigger-50">View Time Table</span>
    </a> </td>--%>
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
                                                <h5>
                                                    You have selected/saved the following courses</h5>
                                            </p>
                                        </div>
                                        <div id="datalist_saved" style="margin-left: 30px; display: none;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="datatable_saved" class="display table table-striped table-bordered
    table-hover" width="100%">
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
                                            <h4 style="margin-left: 25px">
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
                                                <h5>
                                                    You have been assigned following Courses</h5>
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
                                    <div class="widget-header
    widget-header-flat">
                                        <h4 class="smaller">
                                            Step 1 Selection of Credits to be enrolled</h4>
                                        <%-- <div class="widget-toolbar"> <label> <small class="green"><b>Horizontal</b>
    </small> <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6"
    /> <span class="lbl"></span> </label> </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <%-- <code class="pull-right" id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <dt>Go to the course selection tab on the dash board. Select the number of credits you
                                                would like to choose for this Winter school. This is a mandatory step. Your fees
                                                and the courses allotted to you would be based on your selection of credits. You
                                                can choose maximum 8 credits.</dt>
                                            <dl id="dt-list-1">
                                                <%-- <dd> A description list
    is perfect for defining terms.</dd> <dt>Euismod</dt> <dd> Vestibulum id ligula porta
    felis euismod semper eget lacinia odio sem nec elit.</dd> <dd> Donec id elit non
    mi porta gravida at eget metus.</dd> <dt>Malesuada porta</dt> <dd> Etiam porta sem
    malesuada magna mollis euismod.</dd> <dt>Felis euismod semper eget lacinia</dt>
    <dd> Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut
    fermentum massa justo sit amet risus.</dd>--%>
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
                                            Step 2 Selection of Courses</h4>
                                        <%-- <div class="widget-toolbar"> <label> <small
    class="green"><b>Horizontal</b> </small> <input id="id-check-horizontal" type="checkbox"
    class="ace ace-switch ace-switch-6" /> <span class="lbl"></span> </label> </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <%-- <code class="pull-right"
    id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <dt>Please select the courses you want to register for by clicking on the courses. You
                                                would be prompted to choose the priority of each course you select. Save your selection
                                                from the button given at the bottom of the page. Please note that the courses would
                                                be offered to you based on the preference given by you. Save your selection at every
                                                step.<br />
                                                <br />
                                                <b>Note:</b>In case of time clash of courses you would be shown a warning indicating
                                                a time clash. However, you would be still able to select the courses and you would
                                                be allotted either of the courses based on your preference. </dt>
                                            <br />
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
                                    <div class="widget-header
    widget-header-flat">
                                        <h4 class="smaller">
                                            Step 3 Payment of Fees</h4>
                                        <%-- <div
    class="widget-toolbar"> <label> <small class="green"><b>Horizontal</b> </small>
    <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6"
    /> <span class="lbl"></span> </label> </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <%-- <code class="pull-right" id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <dt>Please save the courses before proceeding for payment of fees. Fees can be paid
                                                through one of the following two ways:
                                                <br />
                                                <br />
                                                1. Net Banking/ Credit Debit card through online payment gateway
                                                <br />
                                                <br />
                                                For online payment you need to click on the “Online Payment” button. It will open
                                                the payment page. Pay the fees using the payment gateway screen. Once you finish
                                                the payment your registration would be complete. </b>
                                                <br />
                                                <br />
                                                Or
                                                <br />
                                                <br />
                                                By printing auto-generated pay-in slip, and cash/demand draft payment at any ICICI
                                                bank branch in India. (This option is not available for international students living
                                                outside India)<br />
                                                Please click the Print Pay in Slip button for payment by cash/ demand draft. Print
                                                the pay in slip and pay fees at nearest ICICI Bank branch. You are required to submit
                                                a counter copy of duly stamped by the Bank in the institution to ManishaAsrani,
                                                in CEPT Summer / Winteroffice.
                                                <br />
                                                <br />
                                                <b>Kindly please note the following necessary steps</b>
                                                <br />
                                                <br />
                                                a) You can scan the counter copy and email tosummerwinterschool@cept.ac.in. Please
                                                note that your process is still incomplete and you would be required to follow the
                                                step 4.
                                                <br />
                                                b) Please check your details in the pay-in slip and in the online payment option.
                                                You would not be able to register your courses without fee payment.
                                                <br />
                                                c) Fees mentioned for professionals are the total amount with service tax. </dt>
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
                                            Step 4 Completing the Registration</h4>
                                        <%-- <div class="widget-toolbar">
    <label> <small class="green"><b>Horizontal</b> </small> <input id="id-check-horizontal"
    type="checkbox" class="ace ace-switch ace-switch-6" /> <span class="lbl"></span>
    </label> </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <%--
    <code class="pull-right" id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <dt>For the student paying fees through online payment gateway the registration would
                                                be complete once fees are paid online.
                                                <br />
                                                <br />
                                                For the students registering through pay-in slip payment method, to finish the registration
                                                you need to send the counter slip to Summer Winter School Office.After the submission
                                                of the same only we will activate the Fees status in the portal and the student
                                                would be able to see the Fees Paid Status in the portal. The student needs to visit
                                                the registration site once again after one working day of fee payment. The dashboard
                                                would show your registration status and status of payment of your fees.
                                                <br />
                                                <br />
                                                <b>Once the fee status appears paid, go to the course selection tab and register your
                                                    courses. Do not forget to click the Registration Button.</b></dt>
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
        <!--
    /.row -->
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
