<%@ Page Title="View Student Marks" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="View_Student_wise_marks.aspx.cs" Inherits="Admin_Master_View_Student_wise_marks" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/view_student_wise_marks.js?t=22022022" type="text/javascript"></script><%--31102018--%><%--09032020--%><%--13032020--%><%--13082020--%><%--12022021--%><%--17012022--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <style type="text/css">
        .inline_input
        {
            width:35px;
            margin:0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Student Wise Marks
            </h1>
        </div>
    </div>
    
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            
            <div class="panel-heading">
                <strong><span id="spn_course_name" class="panel-headingfont"></span> </strong>
                <span style="float:right;">
                    <%--<input id="btn_add_exam" type="button" class="btn btn-primary" value="Add Assessment" style="height: 40px;margin-top: -10px;" onclick="addModalData()"/>
                    <input id="btn_show_modal" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal" value="Add Exam" style="height: 40px;margin-top: -10px;display:none;"/>--%>
                </span>
            </div>
            
            <div><%--class="panel-body"--%>
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

        <table style="width: 50%;margin-left: 20%;">
            <tr id='tbl_tr_btn'>
                <%--<td align="center">
                    <button id="btn_calc_grade" type="button" class="btn btn-lg btn-primary" onclick="send_for_review()">Send for Review</button>
                </td>
                <td align="left">
                    <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_grade()">Submit</button>
                </td>--%>
            </tr>
        </table>

    </div>


    <input type="hidden" id="hdn_c" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdn_s" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdn_y" runat="server" clientidmode="Static"/>
    <input type="hidden" id="hdn_pc" runat="server" clientidmode="Static"/>

</asp:Content>


