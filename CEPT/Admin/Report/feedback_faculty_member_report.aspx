<%@ Page Title="Print - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="feedback_faculty_member_report.aspx.cs" Inherits="Admin_Report_feedback_faculty_member_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%-- <script src="../../DesignJS/jspdf/swfobject.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/downloadify.min.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.standard_fonts_metrics.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.split_text_to_size.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.from_html.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.addhtml.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.addimage.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.autoprint.js" type="text/javascript"></script>   
    <script src="../../DesignJS/jspdf/jspdf.plugin.cell.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.javascript.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.png_support.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.sillysvgrenderer.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.total_pages.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.PLUGINTEMPLATE.js" type="text/javascript"></script>--%>
    <%-- <script src="ChartJs/canvasjs.min.js" type="text/javascript"></script>--%>

    <script src="../../Scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/knockout-3.0.0.js" type="text/javascript"></script>
    <script src="../../ChartJs/globalize.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/dx.chartjs.js" type="text/javascript"></script>
    <script src="../../Js/feedback_faculty_report_06062018.js" type="text/javascript"></script>
    <script src="../../DesignJS/FileSaver.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.js" type="text/javascript"></script>
    <script src="https://html2canvas.hertzen.com/build/html2canvas.js"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.from_html.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.standard_fonts_metrics.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.split_text_to_size.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.javascript.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.addhtml.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.addimage.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.autoprint.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.cell.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.png_support.js" type="text/javascript"></script>
    <script src="../../DesignJS/jspdf/jspdf.plugin.sillysvgrenderer.js" type="text/javascript"></script>
    <script src="../../Scripts/grabzit.min.js" type="text/javascript"></script>
    <script src="../../Scripts/jspdf.min.js" type="text/javascript"></script>
    <script src="../../Scripts/svgToPdf.js" type="text/javascript"></script>
    <script type="text/javascript" src="https://canvg.github.io/canvg/rgbcolor.js"></script>
    <script type="text/javascript" src="https://canvg.github.io/canvg/StackBlur.js"></script>
    <script type="text/javascript" src="https://canvg.github.io/canvg/canvg.js"></script>

    <style>
        td
        {
            padding-left: 5px;
        }
        <%--.dxc-markers circle
        {
            display: none;
        }--%>
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<div id="content">
        <h3>
            Hello, this is a H3 tag</h3>
        <p>a pararaph</p>
    </div>
    <div id="editor"></div>
    <button id="cmd">generate PDF</button>
    <div class="row-fluid" onload="window.print()">--%>
    <%--<asp:HiddenField ID="hdn" runat="server" Value="1" />--%>
    <%--<canvas id="canvas" width="1000px" height="600px"></canvas>--%>

    <div class="page-header position-relative">
        <h1>
            <i class="icon-desktop"></i>Feedback Faculty Member Report
        </h1>
    </div>
    <div>
        <div>
            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>
                            Year
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear" name="drpyear">
                            </select>
                        </td>
                        <td>
                            Semester
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester" name="drpsemester">
                            </select>
                        </td>
                        <td>
                            Course
                        </td>
                        <td>
                            <select class="chosen-select" id="drcourses" name="drcourses">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <%-- <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>--%>
                        <td>
                            Instructor
                        </td>
                        <td align="center">
                            <select class="chosen-select" id="drp_instructor" name="drp_instructor">
                            </select>
                        </td>
                        <td>
                            Course Type
                        </td>
                        <td align="center">
                            <select class="chosen-select" id="drp_course_type" name="drp_course_type">
                            </select>
                        </td>
                        <td>
                            Department
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" name="drpdepartment">
                            </select>
                        </td>
                        <td>
                            <%--<a id="btnreterive1" class="btn btn-primary" target="_blank">Print</a>--%>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                        <%--<td>
                                <button class="btn btn-primary" type="submit" id="btn_retrieve_new">
                                    Retrieve
                                </button>
                            </td>--%>
                        <td>
                            <%--<a id="btnreterive1" class="btn btn-primary" target="_blank">Print</a>--%>
                            <button class="btn btn-primary" type="button" id="btnprint">
                                Print
                            </button>
                        </td>
                        <td style="display: none">
                            <%--<input type="button" value="Download" runat="server" clientidmode="Static"/>--%>
                            <asp:Button ID="Button1" runat="server" Text="Download" OnClick="Button1_Click" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <%--<tr>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btn_retrieve_2">
                                Retrieve 2
                            </button>
                        </td>
                    </tr>--%>
                </table>
            </div>
        </div>
        <div id="chartContainer" class="containers" style="height: 440px; width: 100%;">
        </div>
        <%--<iframe id="pdf" name="pdf" src="document.pdf">--%>
        <div id="print_data" style="display: block">
            <table cellpadding="0" cellspacing="0" border="0" id="tbl_lecture" class="display table table-striped table-bordered table-hover"
                width="100%">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
        <%--</iframe>--%>
        <%--<div id="div_seminar" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_seminar" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div id="div_workshop" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_workshop" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div id="div_studio" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="tbl_studio" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>--%>
    </div>
    <%--<div class="tab-content">--%>
    <%--</div>--%>
    </div>
</asp:Content>
