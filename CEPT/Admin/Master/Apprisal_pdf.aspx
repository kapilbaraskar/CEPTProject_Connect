<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Apprisal_pdf.aspx.cs" Inherits="Admin_Master_Apprisal_pdf" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="../../Js/faculty_apprisal_pdf.js?t=17062024" type="text/javascript"></script>
    <link href="../../DesignCss/jquery.timepicker.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/jquery.timepicker.js" type="text/javascript"></script>

    <title>Apprisal PDF</title>
    <style>
        
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
         body {
            font-family: Arial, sans-serif;
        }

        table {
            width: 100%;
            border-collapse: collapse;
           /*page-break-inside: avoid;  Prevent table rows from breaking inside */
        }
         th {
          font-size: 10px;
           
        }

        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
            word-wrap: break-word;
        }

        thead {
            display: table-header-group; /* Ensure table headers repeat on each page */
        }

        /*tfoot {
            display: table-footer-group;*/ /* Ensure table footers repeat on each page */
        /*}

        tr {
            page-break-inside: avoid;*/ /* Prevent table rows from breaking inside */
        /*}*/

        div table {
            page-break-inside: auto !important;
        }
        table {
            page-break-inside: auto !important;
        }
        table tr 
        {
         page-break-inside: avoid !important;
         page-break-after: auto !important;
        }
    </style>
</head>
<body style="margin-left:-10px !important; margin-right:-10px !important;">
    <form id="form1" runat="server">
        <div class="clearfix">
            <div class="page-header position-relative" style="text-align: center;">
                <h1>
                    <i class="icon-rupee"></i>SELF EVALUATION DETAILS
                </h1>
            </div>
            <div class="space">
            </div>

            <%-- <div class="panel panel-default" id="header">--%>
            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>Personal Details </b>
                </div>
                <div style="display: block; width: 100%; overflow: auto;" class="row-fluid" id="Student_Profile">
                    <div class="panel panel-default ">
                        <div style="padding: 15px;">
                            <table id="tbl_personal_detail1" style="width: 100%;">
                                <tr>
                                </tr>
                                <tr>
                                    <td style="width: 20%; padding-bottom: 10px;">Name<span style="color: red"></span></td>
                                    <td style="width: 30%; padding-bottom: 10px;"><span id="txt_name"></span></td>
                                    <td style="width: 20%; padding-bottom: 10px;">Designation</td>
                                    <td style="width: 30%; padding-bottom: 10px;"><span id="txt_designation"></span></td>
                                </tr>
                                <tr>
                                    <td style="width: 20%; padding-bottom: 10px;">Faculty</td>
                                    <td style="width: 30%; padding-bottom: 10px;"><span id="txt_faculty"></span></td>
                                    <td style="width: 20%; padding-bottom: 10px;">Date of Joining CEPT</td>
                                    <td style="width: 30%; padding-bottom: 10px;"><span id="txt_joining_date"></span></td>
                                </tr>
                                <tr>
                                    <td style="width: 20%; padding-bottom: 10px;">Total Years of Experience</td>
                                    <td style="width: 30%; padding-bottom: 10px;"><span id="txt_year_experience"></span></td>
                                    <td style="width: 20%; padding-bottom: 10px;">Teaching in the </br> current position since (Years)</td>
                                    <td style="width: 30%; padding-bottom: 10px;"><span id="txt_year_teaching"></span></td>

                                </tr>
                                <tr>
                                    <td style="width: 20%; padding-bottom: 10px;">Total Teaching Experience</td>
                                    <td style="width: 30%; padding-bottom: 10px;"><span id="txt_teaching_experience"></span></td>
                                    <td style="width: 20%; padding-bottom: 10px;">Confirmation Date</td>
                                    <td style="width: 30%; padding-bottom: 10px;"><span id="txt_confirmation_date"></span></td>

                                </tr>



                            </table>
                            <%--<span>Teaching in the current position since (Years) &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <span id="txt_year_teaching"></span></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           &nbsp;&nbsp;&nbsp;  <span>Teaching Experience in previous position &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <span id="txt_teaching_experience"></span></span></br>--%>
                        </div>
                    </div>
                </div>

            </div>
            <%--<div class="panel panel-default ">--%>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>Education </b>
                </div>
                <div style="padding: 10px; overflow: auto;" id="div_education" class="panel-collapse collapse in">

                    <table id="tbl_education_dtl" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                            <th>Qualification </th>
                            <th>Discipline</th>
                            <th>University/Board</th>
                            <th>Year</th>

                        </tr>

                    </table>
                </div>
            </div>


            <%--   </div>--%>


            <%-- <div class="panel panel-default ">--%>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>1 TEACHING </b>
                </div>
                <div style="padding: 10px; overflow: auto;" id="div_teaching" class="panel-collapse collapse in">

                    <table id="tbl_teaching_dtl" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                            <th>Sem </th>
                            <th>Course Code</th>
                            <th>Course/Studio/SWS Name</th>
                            <th>Credit</th>
                            <th>Hours</th>
                            <th>Additional Hours</th>
                            <th>No of Times- you have offered the course</th>
                        </tr>

                    </table>
                </div>
                <span style="padding-left: 10px;">Total Hours : <span id="txt_cours_hours"></span></span>
            </div>


            <%-- </div>--%>


            <%--  <div class="panel panel-default ">--%>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>1.2 Mention the number and details of thesis/DRP you have guided at CEPT University (UG/PG/Ph.D.)  </b>
                </div>
                <div style="padding: 10px; overflow: auto;" id="div_drp_thesis" class="panel-collapse collapse in">

                    <table id="tbl_drp_thesis_dtl" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                            <th>Semester and Year</th>
                            <th>Course Name</th>

                        </tr>

                    </table>
                </div>

                <span style="padding-left: 10px;">Total Hours : <span id="txt_drp_thesis"></span></span>
            </div>


            <%--   </div>--%>


            <div class="panel panel-default ">
                <div>
                    <div class="panel-heading" style="background-color: #d1dee5;">
                        <b>2 RESEARCH & PUBLICATION DURING </b>

                    </div>
                    <div style="padding: 10px;width: 100%; overflow-x: auto; overflow-y: auto;" id="div_rese_publish_dtl" class="panel-collapse collapse in" >
                        <table id="tbl_rese_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                            <tr>
                                <th>Publication Type</th>
                                <th>Title of Research</th>
                                <th>Type</th>
                                <th>Name of journa</th>
                                <th>National</th>
                                <th>Impact Factor of Journal</th>
                                <th>Authorship</th>
                                <th>Month of publication</th>
                                <th>year of publication</th>
                                <th>Whether submitted to University/Faculty</th>
                            </tr>

                        </table>
                        <div>
                            <span style="padding-left: 10px;">Total Hours : <span id="txt_res_publish_year"></span></span>
                        </div>
                    </div>


                    <div style="padding: 10px;width: 100%; overflow-x: auto; overflow-y: auto;" id="div_Conferences_publish_dtl" class="panel-collapse collapse in" >
                        <table id="tbl_conferences_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                            <tr>
                                <th>Title of Research</th>
                                <th>Type</th>
                                <th>Name of Conference</th>
                                <th>National</th>
                                <th>Authorship</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Whether submitted to University/Faculty</th>
                            </tr>

                        </table>
                        <div>
                            <span style="padding-left: 10px;">Total Hours : <span id="txt_res_conferences_year"></span></span>
                        </div>
                    </div>

                </div>
            </div>
            
            <div class="panel-heading" style="background-color: #d1dee5;">
                <b>2.1 Details of Completed/Ongoing Research Projects </b>

            </div>
            <div style="padding: 10px; overflow: auto;" id="div_comp_ongoing_dtl" class="panel-collapse collapse in">
                <table id="tbl_comp_ongoing_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Title</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Funding agency</th>
                        <th>Fund available</th>
                        <th>Duration</th>
                        <th>Status</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                    </tr>
                </table>
                <div>
                    <div>
                        <span style="padding-left: 10px;">Total Hours : <span id="txt_res_com_ongoing"></span></span>
                    </div>
                </div>
            </div>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>2.2 Any other research activities/recognition/awards </b>

                </div>
                <div style="padding: 10px; overflow: auto;" id="div_other_activity_dtl" class="panel-collapse collapse in">
                    <span style="padding-left: 10px;" id="other_activity"></span>

                      <table id="tbl_other_activity" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Title</th>
                        <th>Type</th>
                        <th>Description</th>
                        <th>Date </th>
                    </tr>
                </table>

                    </br>
                <div>
                    <span style="padding-left: 10px;">Total Hours : <span id="txt_other_activity"></span></span>
                </div>
                </div>

            </div>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>2.3 Various Activities</b>

                </div>
                <div style="padding: 10px; overflow: auto;" id="div_various_activity_dtl" class="panel-collapse collapse in">
                    <table id="tbl_various_activity_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                            <th>Type </th>
                            <th>List the various activities such as Review / Juries (in CEPT & with others) </th>
                            <th>Organisation</th>
                            <th>Your role in the activity</th>
                            <th>Status </th>
                            <th>Start Date </th>
                            <th>End Date </th>

                        </tr>
                    </table>
                    <div>

                        <span>Total Hours : <span id="txt_various_activity"></span></span>
                    </div>
                </div>

            </div>
            
            <div style="margin-top: 2%;">
                <div class="panel panel-default ">
                    <div class="panel-heading" style="background-color: #d1dee5;">
                        <b>2.4 Details of Professional Development Training programs offered </b>
                    </div>
                    <div style="padding: 10px; overflow: auto;" id="div_professional_activity_dtl" class="panel-collapse collapse in">
                        <table id="tbl_professional_activity_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                            <tr>
                                <th>Type</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Duration</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Organizers</th>
                                <th>Number of participants</th>

                            </tr>

                        </table>
                        <div><span>Total Hours: <span id="txt_profess_activity"></span></span></div>
                    </div>

                </div>
            </div>


            

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>3. Institutional/Administrative Work During</b>

                </div>
                <div style="padding: 10px; overflow: auto;" id="div_Institutional_activity_dtl" class="panel-collapse collapse in">
                    <table id="tbl_Institutional_activity_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                          

                                <th>Title</th>
                                <th>Type</th>
                                <th>Description</th>
                                <th>Status</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Duration (Hrs)</th>
                        </tr>
                    </table>
                    <div><span>Total Hours: <span id="txt_Institutional_activity"></span></span></div>
                </div>

            </div>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>4 List any Trainings Programs Attended</b>
                </div>
                <div style="padding: 10px; overflow: auto;" id="div_skill_activity_dtl" class="panel-collapse collapse in">
                    <table id="tbl_skill_activity_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                                <th>Title</th>
                                <th>Type</th>
                                <th>List any trainings programs</th>
                                <th>Date</th>
                                <th>Organizer</th>
                                <th>Mode of Training</th>
                        </tr>

                    </table>
                    <div>
                        <span>Total Hours: <span id="txt_trainings_activity"></span></span>

                    </div>
                </div>

            </div>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>5.1 Mention facilitating </b>
                </div>
                <div style="padding: 10px; overflow: auto;" id="div_facilitating_activity_dtl" class="panel-collapse collapse in">
                    <table id="tbl_facilitating_activity_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                            <th style="width: 95%;">
                                <center>Mention facilitating (favourable) factors pertaining to your Role</center>
                            </th>
                        </tr>

                    </table>

                </div>

            </div>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>5.2 Mention Inhibiting </b>
                </div>
                <div style="padding: 10px; overflow: auto;" id="div_Inhibiting_activity_dtl" class="panel-collapse collapse in">
                    <table id="tbl_Inhibiting_activity_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                            <th style="width: 95%;">
                                <center>Mention inhibiting (unfavorable) factors pertaining to your role</center>
                            </th>
                        </tr>
                    </table>
                </div>

            </div>

            
            <div style="margin-top: 2%;">
                
                <div class="panel panel-default ">
                    <div class="panel-heading" style="background-color: #d1dee5;">
                        <b>6. Trainings </b>
                    </div>
                    <div style="padding: 10px; overflow: auto;" id="div_training_activity_dtl" class="panel-collapse collapse in">
                        <table id="tbl_training_activity_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                            <tr>
                                <th style="width: 95%;">
                                    <center>List any trainings required to update/enhance your knowledge/ skill set </center>
                                </th>
                            </tr>
                        </table>
                    </div>

                </div>

            </div>

            <div class="panel panel-default ">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>7. SELF EVALUATION (from 1 to 5) </b>
                    <div style="font-weight: bold; color: brown; align=right;">
                        [ 1 - Completely Disagree | 2 - Partially Disagree | 3 - Neither Agree nor Disagree | 4 - Partially Agree | 5 - Completely Agree ]
                               
                    </div>
                </div>
                <div style="padding: 10px; overflow: auto;" id="div_self_evaluation_dtl" class="panel-collapse collapse in">
                    <table id="tbl_self_evaluation_dtl" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr>
                            <th>Question</th>
                            <th>Rating</th>
                        </tr>
                    </table>
                </div>

            </div>

            <div class="panel panel-default comment_div" style="page-break-before: always;">
                <div class="panel-heading" style="background-color: #d1dee5;">
                    <b>Comments </b>
                </div>
                <div style="padding: 10px;" id="div_comments" class="panel-collapse collapse in">

                    <table id="tbl_comments_activity_publish" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                        <tr class="dean_training" style="display: none;">
                            <td><b>Dean’s comments (For Training Programs ) : </b></td>
                            <td>
                                <p id="deancomments"></p>

                            </td>
                        </tr>
                        <tr class="over_all_comment">
                            <td><b>Over All Comments by the Faculty Dean: </b></td>
                            <td>
                                <p id="deanallcomments"></p>
                            </td>
                        </tr>
                        <tr class="comment_committee">
                            <td><b>Comments by review committee : </b></td>
                            <td>
                                <p id="reviewcomments"></p>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>


            
        </div>
        <asp:HiddenField ID="hdn_user_id" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_year" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_iyear" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_user_type" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_comment_type" runat="server" ClientIDMode="Static" />
    </form>
</body>
</html>
