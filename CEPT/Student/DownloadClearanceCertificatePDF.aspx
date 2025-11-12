<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DownloadClearanceCertificatePDF.aspx.cs" Inherits="Student_DownloadClearanceCertificatePDF" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Clearance Certificate</title>
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            if (hdn_clearance_data.value != "") {
                var dept_data = JSON.parse(hdn_clearance_data.value)
                var str = "";
                for (var i = 0; i < dept_data.length; i++) {
                    str += "<tr><td>" + dept_data[i]["department_name"] + "</td>";
                    str += "<td>" + dept_data[i]["status"] + "</td>";
                    str += "<td>" + dept_data[i]["created_date"] + "</td></tr>";
                }
                $("#clearance_data").append(str);
            }
        });
    </script>
    <style>
        body {
            margin-right: 5%;
            margin-left: 5%;
            margin-top: 0%;
            margin-bottom: 2%;
            font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
            font-size: 16px;
            line-height: 2.1;
            
        }

        header#header_div {
            padding-bottom: 115px;
        }

        #title_div {
            border-top: 3px solid black;
            clear: both;
            text-align: center;
            font-size: 23px;
            padding-top: 15px;
        }

        #name_prog {
            text-align: left;
        }

        div#title_div {
            padding-bottom: 5px;
        }

        #line {
            border-bottom: 1px solid black;
            overflow: visible;
            height: 9px;
            margin: 5px 0 10px 0;
        }

            #line span {
                background-color: white;
                padding: 0 5px;
            }

        #table_dtl tbody tr td {
            text-align: center;
        }
    </style>
</head>
<body>
    <form>
        <div id="main">
            <header id="header_div">
                <div style="width: 55%; float: left; font-size: 15px;">
                    <span><b><u>Student Services Office</u></b><br />
                        K.L.Campus,University Road,Navrangpura,<br />
                        Ahmedabad-380009,INDIA<br />
                        Ph: +91-79-2630 2452 / 2740 extn: x 435, x 436 Fax: 91-79-2630 2075<br />
                        <b>Website: <u><a href="https://cept.ac.in/" target="_self">www.cept.ac.in</a></u>      Email: <u><a href="" target="_self">studentservices@cept.ac.in</a></u></b>
                    </span>
                </div>
                <div style="width: 45%; float: right; width: 297px; height: 96px; position: relative;">

                    <img alt="" style="width: 297px; height: 96px; object-fit: cover;" src="../../image/ceptlogo_pdf.jpg">
                </div>

            </header>
            <div id="title_div">
                <span><b><u>Clearance Certificate</u></b></span><br />
            </div>
            <div>
                <p>
                    <span><b>Instructions:</b></span> To be completed by student & submitted to Accounts.<br />
                    <span style="text-indent: 50px;">Submission of the Clearance Certificate is a pre-requisite for Provisional Certificate/
               Degree Certificate/ Refund of Deposit.</span>
                </p>
                <table style="width: 100%;">
                    <tr>
                        <td>Student Name 
                            <span style="border-bottom:1px solid black;"><asp:Label ID="stu_name" runat="server" Text=""></asp:Label></span></td>
                        <td>Code Number 
                            <span style="border-bottom:1px solid black;"><asp:Label ID="code_num" runat="server" Text=""></asp:Label></span></td>
                    </tr>

                    <tr>
                        <td>Name of Program
                            <span style="border-bottom:1px solid black;"><asp:Label ID="name_prog" runat="server" Text=""></asp:Label></span></td>
                        <td>Faculty of
                            <span style="border-bottom:1px solid black;"><asp:Label ID="faculty" runat="server" Text=""></asp:Label></span></td>

                    </tr>
                    <tr>
                        <td colspan="2">
                            <p>This is to certify that nothing is due from the student cited above. (If there is any due indicate in the Remarks’ column)</p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table border="1" style="width: 100%;" id="table_dtl">
                                <thead>
                                    <tr>
                                        <th style="width: 27%;"><b>Office/ Facility</b></th>
                                        <th style="width: 48%;"><b>Approved / Pending / Hold</b></th>
                                        <th style="width: 25%;"><b>Approved Date</b></th>
                                    </tr>
                                </thead>
                                <tbody id="clearance_data">
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <p>
                                <b>Attachments: </b>Please submit the following to your respective Accounts:<br />
                                1. Clearance Certificate  2. Receipt of Deposit
                            </p>
                            <p>Note: In absence of original receipt, students can apply for refund of deposit on INDEMNITY BOND (Rs 10 stamp paper).</p>
                            <p><b>Please submit the following information for future correspondence:</b></p>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">Permanent Address
                            <span style="border-bottom:1px solid black;    font-size: 13px;"><asp:Label ID="per_address" runat="server" Text=""></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td colspan="2">Correspondence Address
                            <span style="border-bottom:1px solid black;    font-size: 13px;"><asp:Label ID="cor_address" runat="server" Text=""></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td colspan="1">CEPT Email ID
                            <span style="border-bottom:1px solid black;"><asp:Label ID="cetp_email" runat="server" Text=""></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td>Personal Email ID
                            <span style="border-bottom:1px solid black;"><asp:Label ID="per_email" runat="server" Text=""></asp:Label></span></td>
                        <td>Contact No.
                            <span style="border-bottom:1px solid black;width:50px;"><asp:Label ID="cont_no" runat="server"></asp:Label></span></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td>Signature of Program Coordinator : 
                            <span style="border-bottom:1px solid black;width:50px;"><asp:Label ID="Label6" runat="server" Text="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:Label></span></td>
                        <td>Date : 
                            <span style="border-bottom:1px solid black;width:50px;"><asp:Label ID="Label7" runat="server" Text="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:Label></span></td>
                    </tr>
                    <tr>
                        <td>Signature of Registrar : 
                            <span style="border-bottom:1px solid black;width:50px;"><asp:Label ID="Label8" runat="server" Text="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:Label></span></td>
                        <td>Date : 
                            <span style="border-bottom:1px solid black;width:50px;"><asp:Label ID="Label9" runat="server" Text="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:Label></span></td>
                    </tr>
                    <tr>
                        <td>Signature of Student : 
                            <span style="border-bottom:1px solid black;width:50px;"><asp:Label ID="Label10" runat="server" Text="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:Label></span></td>
                        <td>Date : 
                            <span style="border-bottom:1px solid black;width:50px;"><asp:Label ID="Label11" runat="server" Text="">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</asp:Label></span></td>
                    </tr>
                </table>
            </div>

        </div>
    </form>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_clearance_data" value="" />
</body>
</html>
