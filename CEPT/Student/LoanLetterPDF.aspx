<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoanLetterPDF.aspx.cs" Inherits="Student_LoanLetterPDF" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>
    <script type="text/javascript">
        var obj_stud_detail;

        $(document).ready(function () {
            if ($("#hdn_stud_detail").val() != '') {
                obj_stud_detail = JSON.parse($("#hdn_stud_detail").val());
            }

            setStudentDetail();
        });

        function setStudentDetail() {

            if (obj_stud_detail != null && obj_stud_detail != undefined) {
                var str_program = '';
                var stud_year_code = obj_stud_detail[0]["year_code"];
                if (obj_stud_detail[0]["year_code"] == 'Y1') stud_year_code = 'Y2013';

                if (obj_stud_detail[0]["prog_desc"] == 'Landscape Architecture') {
                    str_program = 'MASTERS IN LANDSCAPE ARCHITECTURE';
                }
                else if (obj_stud_detail[0]["prog_desc"] == 'Landscape Design') {
                    str_program = 'MASTERS IN LANSCAPE DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '2' && obj_stud_detail[0]['prog_code'] == '1') { // FD UG
                    str_program = 'BACHELOR OF INTERIOR DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '1' && stud_year_code >= 'Y2016') { // FP UG
                    str_program = 'BACHELOR OF URBAN DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '2' && stud_year_code == 'Y2014') { // FP PG
                    str_program = 'MASTER OF PLANNING';
                }
                else if (obj_stud_detail[0]['dept_code'] == '4' && obj_stud_detail[0]['prog_code'] == '2' && stud_year_code >= 'Y2015') { // FP PG
                    str_program = 'MASTER OF URBAN DESIGN';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '1' && stud_year_code <= 'Y2012') { // FT UG
                    str_program = 'BACHELOR OF TECHNOLOGY(HONS. CIVIL-CONSTRUCTION)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '1' && stud_year_code >= 'Y2013') { // FT UG
                    str_program = 'BACHELOR OF CONSTRUCTION TECHNOLOGY';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT1') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (CONSTRUCTION ENGINEERING & MANAGEMENT)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT2') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (GEOMATICS)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT3') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (INFRASTRUCTURE ENGINEERING DESIGN)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT4') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (STRUCTURAL ENGINEERING DESIGN)';
                }
                else if (obj_stud_detail[0]['dept_code'] == '5' && obj_stud_detail[0]['prog_code'] == '2' && obj_stud_detail[0]['prog_level_code'] == 'PT5') { // FT PG
                    str_program = 'MASTER OF TECHNOLOGY (BUILDING ENERGY PERFORMANCE)';
                }
                else if (obj_stud_detail[0]["prog_level_name"] == '') {
                    switch (obj_stud_detail[0]["prog_code"]) {
                        case "1": str_program = "BACHELOR OF " + obj_stud_detail[0]["dept_name"]; break;
                        case "2": str_program = "MASTER OF " + obj_stud_detail[0]["dept_name"]; break;
                    }
                }
                else {
                    str_program = obj_stud_detail[0]["prog_level_name"];
                }

                $('#lbl_prog_name').html(str_program.toLowerCase());

                if (obj_stud_detail[0]['name_of_the_degree'] != '' && obj_stud_detail[0]['name_of_the_degree'] != undefined) {
                    $('#lbl_prog_name').html(obj_stud_detail[0]['name_of_the_degree'].toLowerCase());
                }

                $('#lbl_name').css('text-transform', 'capitalize');
                $('#lbl_prog_name').css('text-transform', 'capitalize');
            }

            $.get($('#img_signature').attr('src')).fail(function () { $('#div_signature').html(''); });
        }
    </script>
    <style type="text/css">
        p
        {
            margin-top: 20px;
            text-align: justify;
            line-height: 25px;
        }

        .cls_pad_left
        {
            padding-left: 20px;
        }
    </style>
</head>
<%--<body class="container" style="color:Black;width:1170px;">--%>
<body style="color: Black; margin: 0px 70px 0px 70px; font-size: 16px;">

    <div style="top: 20px; width: 99%; height: 96px; left: 1px; margin-bottom: 30px;" title="" id="i22byht1" align="right">
        <a style="width: 297px; height: 96px; cursor: pointer; float: right;" href="../Master/Home.aspx" id="i22byht1link">
            <div id="i22byht1img" style="width: 297px; height: 96px; position: relative;">
                <img alt="" style="width: 297px; height: 96px; object-fit: cover;" src="../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage">
            </div>
        </a>
    </div>

    <asp:Label ID="lbl_download_date" runat="server" ClientIDMode="Static" Visible="true"></asp:Label>
    <%--    <div style="display:none;">
    <p style="margin-top:25px;text-align:center;" align="center"><b>TO WHOMSOEVER IT MAY CONCERN</b></p>

    <p style="margin-top:25px;">Dear Sir/Madam,</p>
  
    <p>
        This is to certify that <asp:Label ID="lbl_title" runat="server" ClientIDMode="Static" Visible="true"></asp:Label> 
        <asp:Label ID="lbl_name" runat="server" ClientIDMode="Static" Visible="true"></asp:Label> 
        (Roll No. <asp:Label ID="lbl_user_id" runat="server" ClientIDMode="Static" Visible="true"></asp:Label>) 
        is a bona-fide student of 
        Faculty of <asp:Label ID="lbl_dept_name1" runat="server" ClientIDMode="Static" Visible="true"></asp:Label>, CEPT University, Ahmedabad 
        pursuing <asp:Label ID="lbl_his_her1" runat="server" ClientIDMode="Static" Visible="true"></asp:Label> 
        <asp:Label ID="lbl_total_year" runat="server" ClientIDMode="Static" Visible="true"></asp:Label> years 
        <asp:Label ID="lbl_prog_name" runat="server" ClientIDMode="Static" Visible="true"></asp:Label>.
    </p>

    <p>
        <asp:Label ID="lbl_he_she1" runat="server" ClientIDMode="Static" Visible="true"></asp:Label> is required to register for 
        <asp:Label ID="lbl_his_her2" runat="server" ClientIDMode="Static" Visible="false"></asp:Label> 
        <asp:Label ID="lbl_prev_sem" runat="server" ClientIDMode="Static" Visible="false"></asp:Label>
        <asp:Label ID="lbl_cur_sem" runat="server" ClientIDMode="Static" Visible="true"></asp:Label> semester. 
        <asp:Label ID="lbl_his_her3" runat="server" ClientIDMode="Static" Visible="false"></asp:Label> 
        Registration is scheduled between 14th December 2017 to 26th December 2017 
        and <asp:Label ID="lbl_he_she2" runat="server" ClientIDMode="Static" Visible="true"></asp:Label> has to pay the following fees on or before 26th December 2017.
    </p>

    <table style="margin-top: 20px;">
        <tr>
            <td>Tuition Fee (demand draft in favour of CEPT Faculty of <asp:Label ID="lbl_dept_name2" runat="server" ClientIDMode="Static" Visible="true"></asp:Label>)</td>
            <td class="cls_pad_left">&nbsp;Rs. <asp:Label ID="lbl_fees1" runat="server" ClientIDMode="Static" Visible="true"></asp:Label></td>
        </tr>
        <tr>
            <td></td>
            <td class="cls_pad_left">---------------</td>
        </tr>
        <tr>
            <td align="right">Total</td>
            <td class="cls_pad_left">&nbsp;Rs. <asp:Label ID="lbl_fees2" runat="server" ClientIDMode="Static" Visible="true"></asp:Label></td>
        </tr>
    </table>
    
    <p>
        <asp:Label ID="lbl_he_she3" runat="server" ClientIDMode="Static" Visible="true"></asp:Label> is likely to complete the studies by 
        May <asp:Label ID="lbl_apprx_grad_year" runat="server" ClientIDMode="Static" Visible="true"></asp:Label>.
    </p>
</div>--%>
    <div id="div_content" runat="server">
    </div>
    <div id="div_signature" style="height: 55px;">
        <img alt="" src="" style="height: 55px;" id="img_signature" runat="server" />
    </div>

    <p style="margin-top: 5px;">
        Dy. CFO<br />
        CEPT UNIVERSITY
    </p>

    <input type="hidden" id="hdn_uid" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_stud_detail" runat="server" clientidmode="Static" />
</body>
</html>

