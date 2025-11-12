<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Faculty_apprisal_dtl.aspx.cs" Inherits="Admin_Master_Faculty_apprisal_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

      <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js"></script>
    <link type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="../../Js/faculty_apprisal.js?t=25062025" type="text/javascript"></script>
    <script src="https://cdn.jsdelivr.net/npm/alasql@1.5.5/dist/alasql.min.js"></script>
     <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script> 
  
     
    <style>
        .radio-group {
            display: flex;  
            align-items: center;
        }

            .radio-group label {
                margin-right: 10px;
            }

        .other_input {
            margin-left: 10px;
        }

        .swal2-popup {
            font-size: 0.8rem !important;
            font-family: Georgia, serif;
            font-weight: bold;
            color: blue;
        }

        .focus-red-border:focus {
            border: 2px solid red;
            outline: none; /* Remove the default outline to only show the border */
        }
        #tbl_self_evaluation_upload_doc_dtl tbody tr td{
            text-align:center;
        }
    </style>

    <script type="text/javascript">
        var month_text = '<option value="1"> January </option><option value = "2">February </option>';
        month_text += '<option value="3"> March </option>';
        month_text += '<option value="4"> April </option>';
        month_text += '<option value="5"> May </option>';
        month_text += '<option value="6"> June </option>';
        month_text += '<option value="7"> July </option>';
        month_text += '<option value="8"> August </option>';
        month_text += '<option value="9"> September </option>';
        month_text += '<option value="10"> October </option>';
        month_text += '<option value="11"> November </option>';
        month_text += '<option value="12"> December </option>';
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid" id="for_other" style="display: none;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Faculty Appraisal Details
            </h1>
        </div>
    </div>

    <div class="panel panel-default ">
        <div class="panel-heading">
            <b>Faculty Appraisal Form</b>

            <span style="padding-left: 65%; color: #8f2808;"><b>Faculty Appraisal Form Year <span id="year_self"></span></b></span>
        </div>
        <div style="color: blue; padding: 10px;">
            <span>Note : 1. Please fill in the details for the year 2022-23 – All data pertains to CEPT University.</span><br />
            <span>2. Please verify your details as given below as per University records. Please update if necessary</span><br />
            <span>3. Performance Appraisal Guidelines 2022-2023 : <a href="../../Selfevaluation/Guidelines2022-2023.pdf" target="_blank">Download</a></span><br />
            <span>4. Timeline for Performance Appraisal Process (Annexure 1) : <a href="../../Selfevaluation/Timeline2022-2023.pdf" target="_blank">Download</a></span><br />
        </div>

    </div>

    <div class="panel panel-default ">
        <div class="panel-heading">
            <b>Personal Details</b>
        </div>
        <div style="padding: 10px; overflow: visible;" id="div_personal_detail" class="panel-collapse collapse in">


            <table style="width: 100%;" cellpadding="10" cellspacing="20">

                <tr>
                    <td class="pad-top">Name : </td>
                    <td>
                        <label id="txt_name"></label>
                    </td>
                    <td class="pad-top">Designation : </td>
                    <td>
                        <label id="txt_designation" class="marg-btm"></label>
                    </td>


                </tr>
                <tr>
                    <td class="pad-top">Faculty : </td>
                    <td>
                        <label id="txt_faculty" class="marg-btm"></label>
                    </td>
                    <td class="pad-top">Date of Joining CEPT <span style="color: red;">*</span> : </td>
                    <td>
                        <input type="text" id="txt_joining_date" class="marg-btm" placeholder="DD/MM/YYYY" />
                    </td>



                </tr>

                <tr>
                    <td class="pad-top">Total Years of Experience <span style="color: red;">*</span> : </td>
                    <td>
                        <input type="text" id="txt_year_experience" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="2" style="width: 15%" />
                        <select id="txt_total_experiance_months" class="marg-btm" style="width: 35%">
                            <option value="">--Select Months--</option>
                            <option value="0">0</option>
                            <option value='1'>1</option>
                            <option value='2'>2</option>
                            <option value='3'>3</option>
                            <option value='4'>4</option>
                            <option value='5'>5</option>
                            <option value='6'>6</option>
                            <option value='7'>7</option>
                            <option value='8'>8</option>
                            <option value='9'>9</option>
                            <option value='10'>10</option>
                            <option value='11'>11</option>
                            <option value='12'>12</option>
                        </select>

                    </td>
                    <td class="pad-top">Teaching in the </br> current position since (Years) <span style="color: red;">*</span> : </td>
                    <td>

                        <%-- <select id="txt_year_teaching" class="marg-btm"></select>--%>
                        <input type="text" id="txt_year_teaching" class="marg-btm" placeholder='DD-MM-YYYY' />
                    </td>

                </tr>
                <tr>
                    <td class="pad-top">Total Teaching Experience <span style="color: red;">*</span> : </td>
                    <td>
                        <input type="text" id="txt_teaching_experience" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="2" />

                    </td>
                    <td class="pad-top">Confirmation Date : </td>
                    <td>
                        <input type="text" id="txt_confirmation_date" class="marg-btm" disabled />
                    </td>
                </tr>
            </table>
        </div>

    </div>


    <div class="panel panel-default ">

        <div class="panel panel-default ">
            <div class="panel-heading">
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


    </div>


    <div class="panel panel-default ">

        <div class="panel panel-default ">
            <div class="panel-heading">
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
            <span style="padding-left: 10px;">Please mention the total time spent on teaching courses/Studio/SWS Hours: </span><span>
                <input type="number" name="cours_hours" min="0" max="2000" id="txt_cours_hours" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 2000)" />
            </span>
        </div>


    </div>


    <div class="panel panel-default ">

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>1.2 Mention the number and details of thesis/DRP you have guided at CEPT University (UG/PG/Ph.D.)  </b>
                <input type="button" id="btn_add_rese_drp_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('add_drp');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_drp_thesis" class="panel-collapse collapse in">

                <table id="tbl_drp_thesis_dtl" class="data-table table table-bordered table-striped" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Semester and Year</th>
                        <th>Course Name</th>
                        <th>Action</th>

                    </tr>

                </table>
            </div>
            <span style="padding-left: 10px;">Please mention the total hours spent on this activity : </span><span>
                <input type="number" name="drp_thesis" min="0" max="1000" id="txt_drp_thesis" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 1000)" />
            </span>
        </div>


    </div>


    <div class="panel panel-default ">

        <div class="panel-heading">
            <b>2 RESEARCH & PUBLICATION DURING</b>
        </div>
        <div class="panel-heading">
            <b style="color: blue">Publication</b>
            <input type="button" id="btn_add_rese_publish_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('research_publish');" />
        </div>

        <div style="padding: 10px; overflow: auto;" id="div_rese_publish_dtl" class="panel-collapse collapse in">
            <table id="tbl_rese_publish" style="width: 100%;" cellpadding="10" cellspacing="25">
                <tr>
                    <th>Publication Type <span style="color: red;">*</span></th>
                    <th>Title of Research <span style="color: red;">*</span> </th>
                    <th style="display: none;">Type <span style="color: red;">*</span> </th>
                    <th>Name of Journal/<br>
                        Conference <span style="color: red;">*</span> </th>
                    <th>National/<br>
                        International<span style="color: red;">*</span> </th>
                    <th>Impact Factor of Journal</th>
                    <th style="width: 80%;">Authorship<span style="color: red;">*</span></th>
                    <th>Month of publication</th>
                    <th>year of publication</th>
                    <th>Whether submitted
                        <br>
                        to University/Faculty</th>
                    <th>Action</th>


                </tr>
                <tr>
                    <td>
                        <select style='width: 100px;' name="res_type" class='marg-btm restypedtl' id="res_type_0"></select></td>
                    <%--<td><input type="text" name ="res_name" class="marg-btm res_name" id="res_name_0" style="width: 300px;" /></td>--%>
                    <td>
                        <textarea id="res_name_0" class="marg-btm res_name" name="res_name" rows="1" cols="60" style="width: 300px;"></textarea></td>
                    <td style="display: none;">
                        <select style='width: 100px;' name="restype" class='marg-btm' id="restype">
                            <option value="">Select</option>
                            <option value="Journal">Journal </option>
                            <option value="Conference">Conference</option>
                        </select>
                    </td>

                    <td>
                        <input type="text" name="res_journal" class="marg-btm res_journal" id="res_journal_0" style="width: 90px;" /></td>
                    <%--<td><input type="text" name ="res_national" class="marg-btm" id="res_national_0" style="width: 120px;" /></td>--%>
                    <td>
                        <select style='width: 100%;' name="res_national" class='marg-btm' id="res_national_0">
                            <option value="">Select</option>
                            <option value="National">National </option>
                            <option value="International">International</option>
                            <option value="Conference">Conference</option>
                        </select></td>
                    <td>
                        <input type="text" name="res_factor" class="marg-btm" id="res_factor_0" style="width: 50px;" /></td>
                    <%--<td><input type="text" name ="res_sole_author" class="marg-btm" id="res_sole_author_0" style="width: 120px;" /></td>--%>

                    <td>
                        <select style='width: 100%;' name="res_sole_author" class='marg-btm' id="res_sole_author_0">
                            <option value="">Select</option>
                            <option value="SoleAuthor">Sole Author</option>
                            <option value="Coauthor">Co-author</option>
                        </select></td>


                    <%--<td><input type="text" name ="res_month"  class="marg-btm" id="res_month_0" style="width: 50px;"/></td>--%>
                    <td>
                        <select style='width: 110%;' name="res_month" class='marg-btm' id="res_month_0">
                            <option value="">Select Month </option>
                            <option value="1">January </option>
                            <option value="2">February </option>
                            <option value="3">March </option>
                            <option value="4">April </option>
                            <option value="5">May </option>
                            <option value="6">June </option>
                            <option value="7">July </option>
                            <option value="8">August </option>
                            <option value="9">September </option>
                            <option value="10">October </option>
                            <option value="11">November </option>
                            <option value="12">December </option>

                        </select>

                    </td>
                    <%--<td><input type="text" name ="res_year" class="marg-btm" id="res_year_0" style="width: 50px;"/></td>--%>
                    <td>
                        <select style='width: 108%;' name="res_year" class="marg-btm year_dropdown" id="res_year_0"></select></td>
                    <%--<td><input type="text" name ="res_submitted" class="marg-btm" id="res_submitted_0" style="width: 80px;" /></td>--%>

                    <td>
                        <select style='width: 90px;' name="res_submitted" class='marg-btm' id="res_submitted_0">
                            <option value="">Select</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>

                    </td>
                    <td>
                        <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                    </td>
                </tr>
            </table>
            <div>
                <span>Please Mention The Total Hours Spent on This Activity : </span><span>
                    <input type="number" name="quantity" min="0" max="1000" id="txt_res_publish_year" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 1000)" />
                </span>
            </div>
        </div>
        <br />
        <div class="panel-heading">
            <b style="color: blue">Conferences</b>
            <input type="button" id="btn_add_rese_conferences_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('research_conferences');" />
        </div>

        <div style="padding: 10px; overflow: auto;" id="div_rese_conferences_dtl" class="panel-collapse collapse in">
            <table id="tbl_conferences_publish" style="width: 100%;" cellpadding="10" cellspacing="25">
                <tr>

                    <th>Title of Research <span style="color: red;">*</span> </th>
                    <th>Type <span style="color: red;">*</span> </th>
                    <th>Name of Conference<span style="color: red;">*</span> </th>
                    <th>National/<br>
                        International <span style="color: red;">*</span> </th>
                    <th style="width: 80%;">Authorship<span style="color: red;">*</span></th>
                    <th>Start Date<span style="color: red;">*</span></th>
                    <th>End Date<span style="color: red;">*</span></th>
                    <th>Whether submitted
                        <br>
                        to University/Faculty</th>
                    <th>Action</th>


                </tr>
                <tr>

                    <%--<td><input type="text" name ="res_name" class="marg-btm res_name" id="res_conference_title_0" style="width: 180px;" /></td>--%>
                    <td>
                        <textarea id="res_conference_title_0" class="marg-btm res_name" name="res_name" rows="1" cols="60" style="width: 180px;"></textarea></td>
                    <td>
                        <select style='width: 120px;' name="resconferencetype" class='marg-btm' id="res_conference_type_0">
                            <option value="">--Select Type--</option>
                            <option value="Journal">Journal </option>
                            <option value="Conference">Conference</option>
                            <option value="NotApplicable">Not Applicable</option>
                        </select>
                    </td>
                    <%--<td><input type="text" name ="resnameconference" class="marg-btm res_name_conference" id="res_name_conference_0" style="width: 180px;" /></td>--%>
                    <td>
                        <textarea id="res_name_conference_0" class="marg-btm resnameconference" name="resnameconference" rows="1" cols="60" style="width: 180px;"></textarea></td>
                    <td>
                        <select style='width: 120px;' name="res_conference_national" class='marg-btm' id="res_conference_national_0">
                            <option value="">Select</option>
                            <option value="National">National </option>
                            <option value="International">International</option>
                            <option value="Conference">Conference</option>
                        </select></td>
                    <td>
                        <select style='width: 120px;' name="res_conference_author" class='marg-btm' id="res_conference_author_0">
                            <option value="">Select</option>
                            <option value="SoleAuthor">Sole Author</option>
                            <option value="Coauthor">Co-author</option>
                        </select></td>


                    <td>
                        <input type="text" name="res_conference_startdate" class="marg-btm" id="res_conference_start_date_0" placeholder='MM-YYYY' style="width: 100px;" /></td>

                    <td>
                        <input type="text" name="res_conference_enddate" class="marg-btm" id="res_conference_enddate_0" placeholder='MM-YYYY' style="width: 100px;" /></td>
                    <td>
                        <select style='width: 90px;' name="res_conference_submitted" class='marg-btm' id="res_conference_submitted_0">
                            <option value="">Select</option>
                            <option value="Yes">Yes</option>
                            <option value="No">No</option>
                        </select>

                    </td>
                    <td>
                        <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                    </td>
                </tr>
            </table>
            <div>
                <span>Please Mention The Total Hours Spent on This Activity : </span><span>
                    <input type="number" name="quantity" min="0" max="1000" id="txt_res_conferences_year" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 1000)" />
                </span>
            </div>
        </div>




        </br>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>2.1 Details of Completed/Ongoing Research Projects</b>
                <input type="button" id="btn_add_details_comp_ongoing_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('add_comp_ongoing');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_comp_ongoing_dtl" class="panel-collapse collapse in">
                <table id="tbl_comp_ongoing_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Title <span style="color: red;">*</span></th>
                        <th>Type <span style="color: red;">*</span></th>
                        <th>Description <span style="color: red;">*</span></th>
                        <th>Funding agency <span style="color: red;">*</span></th>
                        <th>Fund available <span style="color: red;">*</span></th>
                        <th>Duration <span style="color: red;">*</span></th>
                        <th>Status <span style="color: red;">*</span></th>
                        <th>Start Date <span style="color: red;">*</span></th>
                        <th>End Date <span style="color: red;">*</span></th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <%--<td><input type="text" class="marg-btm" style="width: 300px;" id="comp_ongoing_0" /></td>--%>
                        <td>
                            <textarea id="comp_ongoing_text_0" class="marg-btm resname" name="resname" rows="1" cols="60" style="width: 300px;"></textarea></td>
                        <td>
                            <select style='width: 100px;' name="comp_ongoing_type" class='marg-btm' id="comp_ongoing_type_0"></select></td>
                        <%--<td><input type="text" class="marg-btm" style="width: 120px;" id="comp_ongoing_desc_0" /></td>--%>
                        <td>
                            <textarea id="comp_ongoing_desc_0" class="marg-btm" name="resdes" rows="1" cols="60" style="width: 180px;"></textarea></td>

                        <td>
                            <input type="text" class="marg-btm" style="width: 120px;" id="comp_ongoing_1" /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 90px;" id="comp_ongoing_2" /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 70px;" id="comp_ongoing_3" /></td>
                        <td>
                            <select class="comp_ongoing_status" style="width: 180px;">
                                <option value="">Please Select Status </option>
                                <option value="completed">completed</option>
                                <option value="ongoing">ongoing</option>
                            </select></td>
                        <td>
                            <input type="text" id="txt_ongoing_start_date" style="width: 80px;" class="marg-btm" placeholder='MM-YYYY'></td>
                        <td>
                            <input type="text" id="txt_ongoing_end_date" style="width: 80px;" class="marg-btm" placeholder='MM-YYYY'></td>
                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>

                    </tr>
                </table>
                <div>
                    <span>Please Mention the total hours spent on this activity <span style="color: red;">*</span> : </span><span>
                        <input type="number" name="quantity" min="0" max="1000" id="txt_res_com_ongoing" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 1000)" />
                    </span>
                </div>
            </div>

        </div>
        </br>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>2.2 Any other research activities/recognition/awards</b>
                <input type="button" id="btn_add_details_other_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('add_other_activity');">
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_other_activity_dtl" class="panel-collapse collapse in">
                <%-- <textarea id="other_activity" name="otheractivity" rows="4" cols="100" style="width:99%;"></textarea>--%>

                <table id="tbl_other_activity" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Title <span style="color: red;">*</span></th>
                        <th>Type <span style="color: red;">*</span></th>
                        <th>Description <span style="color: red;">*</span></th>
                        <th>Date <span style="color: red;">*</span></th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <%-- <td><input type="text" class="marg-btm" id="other_activity_0" /></td>--%>
                        <td>
                            <textarea id='other_activity_0' class='marg-btm addactivitytitle' rows='1' cols='60'></textarea></td>
                        <td>
                            <select name="other_activity_type" class='marg-btm' id="other_activity_type_0"></select></td>
                        <%--<td><input type="text" class="marg-btm" id="other_activity_desc_0" /></td>--%>
                        <td>
                            <textarea id='other_activity_desc_0' class='marg-btm addactivitydesc' rows='1' cols='60'></textarea></td>
                        <td>
                            <input type="text" class="marg-btm" id="other_activity_date_0" placeholder='DD-MM-YYYY' /></td>
                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>

                    </tr>
                </table>

                <div>
                    <span>Please mention total hours spent on Research : </span><span>
                        <input type="number" name="quantity" min="0" max="1000" id="txt_other_activity" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 1000)" />
                    </span>
                </div>
            </div>

        </div>


        </br>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>2.3 Various Activities: List the various activities such as Review / Juries (in CEPT & with others) <span style="color: red;">*</span></b>
                <input type="button" id="btn_add_details_various_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('various_activity');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_various_activity_dtl" class="panel-collapse collapse in">
                <table id="tbl_various_activity_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Type <span style="color: red;">*</span></th>
                        <th>Description <span style="color: red;">*</span></th>
                        <th>Organisation <span style="color: red;">*</span></th>
                        <th>Your role in the activity (Individual or as a team member) <span style="color: red;">*</span></th>
                        <th>Status <span style="color: red;">*</span></th>
                        <th>Start Date <span style="color: red;">*</span></th>
                        <th>End Date <span style="color: red;">*</span></th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <td>
                            <select id="comp_various_title_0" style="width: 100px;">
                                <option value="">Please Select </option>
                                <option value="Review">Review</option>
                                <option value="Juries">Juries</option>
                                <option value="NotApplicable">Not Applicable</option>
                            </select></td>
                        <%--<td><input type="text" class="marg-btm" id="comp_various_0" style="width: 200px;" /></td>--%>
                        <td>
                            <textarea id='comp_various_0' class='marg-btm' rows='1' cols='60'></textarea></td>
                        <td><%--<input type="text" class="marg-btm" id="comp_various_Organisation_0" style="width: 100px;" />--%>
                            <div class="radio-group">
                                <input type="radio" name="source_0" id="CEPT_0" class="source_radio" value="cept" checked>
                                CEPT
                <input type="radio" name="source_0" id="Other_0" class="source_radio" value="other">
                                Other
                <input type="text" class="marg-btm other_input" id="comp_various_Organisation_0" style="width: 100px; display: none; margin-left: 10px; margin-top: 16px;" placeholder="Other Organisation" />
                            </div>

                        </td>
                        <td>
                            <select class="comp_various_type" id="comp_various_type_0" style="width: 100px;"></select></td>
                        <td>
                            <select class="comp_various_status" id="comp_status_0" style="width: 180px;">
                                <option value="">Please Select Status </option>
                                <option value="completed">completed</option>
                                <option value="InProcess">In Process</option>
                                <option value="YettoStart">Yet to Start</option>
                            </select></td>
                        <td>
                            <input type="text" class="marg-btm" id="comp_StartDate_0" style="width: 100px;" placeholder='MM-YYYY' /></td>
                        <td>
                            <input type="text" class="marg-btm" id="comp_EndDate_0" style="width: 100px;" placeholder='MM-YYYY' /></td>

                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>
                    </tr>
                </table>
                <div>
                    <span>Please mention total hours spent on above <span style="color: red;">*</span> : </span><span>
                        <input type="number" name="quantity" min="0" max="1000" id="txt_various_activity" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 100)" />
                    </span>
                </div>
            </div>

        </div>



        </br>
        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>2.4 Details of Professional Development Training programs offered </b>
                <input type="button" id="btn_add_details_professional_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('professional_activity');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_professional_activity_dtl" class="panel-collapse collapse in">
                <table id="tbl_professional_activity_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <%--<th>List the details of various <br>professional development <br> training programmes <span style="color:red;">*</span> </th>--%>
                        <th>Type <span style="color: red;">*</span> </th>
                        <th>Title <span style="color: red;">*</span> </th>
                        <th>Description <span style="color: red;">*</span> </th>
                        <th>Duration <span style="color: red;">*</span> </th>
                        <th>Start Date <span style="color: red;">*</span> </th>
                        <th>End Date <span style="color: red;">*</span> </th>
                        <th>Organizers <span style="color: red;">*</span> </th>
                        <th>Number of<br>
                            participants <span style="color: red;">*</span> </th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <td>
                            <select class="comp_profess_status" style="width: 180px;">
                                <option value="">Please Select </option>
                                <option value="Seminar">Seminar</option>
                                <option value="Workshop">Workshop</option>
                                <option value="LectureOffered ">Lecture, Offered </option>
                                <option value="Organised ">Organised </option>
                                <option value="Facultymeeting">Faculty Meeting</option>
                                <option value="NotApplicable">Not Applicable</option>
                            </select></td>
                        <%--<td><input type="text" class="marg-btm" style="width: 300px;" id="prof_title_0" /></td>--%>
                        <td>
                            <textarea id='prof_title_0' class='marg-btm' rows='1' cols='60' style="width: 300px;"></textarea></td>

                        <%--<td><input type="text" class="marg-btm" style="width: 300px;" id="prof_0" /></td>--%>
                        <td>
                            <textarea id='prof_desc_0' class='marg-btm' rows='1' cols='60' style="width: 300px;"></textarea></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 120px;" id="prof_1" /></td>

                        <td>
                            <input type="text" class="marg-btm" style="width: 120px;" id="prof_Start_Date_0" /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 120px;" id="prof_End_Date_0" /></td>

                        <td>
                            <input type="text" class="marg-btm" style="width: 120px;" id="prof_2" /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 60px;" id="prof_3" /></td>

                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>
                    </tr>
                </table>
                <div>
                    <span>Please mention total hours spent on above <span style="color: red;">*</span> : </span><span>
                        <input type="number" name="quantity" min="0" max="1000" id="txt_profess_activity" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 100)" />
                    </span>
                </div>
            </div>

        </div>


    </div>
    <div class="panel panel-default ">

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>3. Institutional/Administrative Work Assigned/Undertaken  <span style="color: red;">*</span> </b>
                <input type="button" id="btn_add_details_Institutional_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('Institutional_activity');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_Institutional_activity_dtl" class="panel-collapse collapse in">
                <table id="tbl_Institutional_activity_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Title <span style="color: red;">*</span></th>
                        <th>Type <span style="color: red;">*</span></th>
                        <th style="width: 85%;">
                            <center>Description <span style="color: red;">*</span> </center>
                        </th>
                        <th style="width: 10%;">Status <span style="color: red;">*</span></th>
                        <th>Start Date <span style="color: red;">*</span></th>
                        <th>End Date <span style="color: red;">*</span></th>
                        <th>Duration (Hrs) <span style="color: red;">*</span></th>
                        <th>Action</th>
                    </tr>
                    <tr>
                        <%--<td><input type="text" class="marg-btm" style="width: 100px;" id="publish_title_0" /></td>--%>

                        <td>
                            <textarea id='publish_title_0' class='marg-btm' rows='1' cols='60' style='width: 100px;'></textarea></td>
                        <td>
                            <select class="publish_type" id="publish_type_0" style="width: 180px;">
                                <option value="">Please Select </option>
                                <option value="Workassigned">Work assigned</option>
                                <option value="Undertaken">Undertaken</option>
                                <option value="NotApplicable">Not Applicable</option>
                            </select></td>
                        <td>
                            <textarea id="admins_0" class="marg-btm" name="Administrative_text" rows="1" cols="60" style="width: 100%;"></textarea></td>

                        <td>
                            <select class="comp_administrative_status" id='admint_0' style="width: 120px;">
                                <option value="">Please Select Status </option>
                                <option value="completed">completed</option>
                                <option value="InProcess">In Process</option>
                                <option value="YettoStart">Yet to Start</option>
                            </select></td>

                        <td>
                            <input type="text" class="marg-btm" style="width: 100px;" id="publish_StartDate_0" placeholder='DD-MM-YYYY' /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 100px;" id="publish_EndDate_0" placeholder='DD-MM-YYYY' /></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 100px;" id="publish_duration_0" /></td>
                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>
                    </tr>
                </table>
                <div>
                    <span>Please mention total hours spent on above <span style="color: red;">*</span> : </span><span>
                        <input type="number" name="quantity" min="0" max="1000" id="txt_Institutional_activity" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 100)" />
                    </span>
                </div>
            </div>

        </div>


    </div>




    <div class="panel panel-default ">

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>4 List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill <span style="color: red;">*</span> </b>
                <input type="button" id="btn_add_details_skill_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('skill_activity');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_skill_activity_dtl" class="panel-collapse collapse in">
                <table id="tbl_skill_activity_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Title<span style="color: red;">*</span></th>
                        <th>Type<span style="color: red;">*</span></th>
                        <th style="width: 95%;">
                            <center>List any trainings programs attended (Lecture/Conference/Workshop Seminar attended) to enhance your Skill  <span style="color: red;">*</span> </center>
                        </th>
                        <th>Date <span style="color: red;">*</span></th>
                        <th>Organizer<span style="color: red;">*</span></th>
                        <th>Mode of Training<span style="color: red;">*</span></th>
                        <th>Action</th>
                    </tr>
                    <tr>

                        <%--<td><input type="text" class="marg-btm" style="width: 100px;" id="skills_title_0" /></td>--%>
                        <td>
                            <textarea id='skills_title_0' class='marg-btm' rows='1' cols='60' style='width: 100px;'></textarea></td>
                        <td>
                            <select class="skill_type" id="skill_type_0" style="width: 180px;">
                                <option value="">Please Select </option>
                                <option value="Lecture">Lecture</option>
                                <option value="Conference">Conference</option>
                                <option value="Workshop">Workshop</option>
                                <option value="Seminar">Seminar</option>
                                <option value="NotApplicable">Not Applicable</option>
                            </select></td>
                        <td>
                            <textarea id="skill_0" class="marg-btm" name="skill_text" rows="1" cols="60" style="width: 100%;"></textarea></td>
                        <td>
                            <input type="text" class="marg-btm" style="width: 100px;" id="skill_Date_0" placeholder='DD-MM-YYYY' /></td>
                        <td>
                            <textarea id='skill_org_0' class='marg-btm' name='skill_org_text' rows='1' cols='60' style='width: 100%;'></textarea></td>
                        <td>
                            <select class='skill_org_type' id='skill_org_type_0' style='width: 180px;'>
                                <option value=''>Please Select</option>
                                <option value='Online'>Online</option>
                                <option value='OffLine'>OffLine</option>
                            </select></td>

                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>
                    </tr>
                </table>
                <div>
                    <span>Please mention total hours spent on above <span style="color: red;">*</span> : </span><span>
                        <input type="number" name="quantity" min="0" max="1000" id="txt_trainings_activity" style="width: 60px; display: inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 100)" />
                    </span>
                </div>
            </div>

        </div>


    </div>


    <div class="panel panel-default ">

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>5.1 Mention facilitating </b>
                <input type="button" id="btn_add_details_facilitating_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('facilitating_activity');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_facilitating_activity_dtl" class="panel-collapse collapse in">
                <table id="tbl_facilitating_activity_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th style="width: 95%;">
                            <center>Mention facilitating (favourable) factors pertaining to your Role <span style="color: red;">*</span> </center>
                        </th>

                        <th>Action</th>
                    </tr>
                    <tr>
                        <%--<td><input type="text" class="marg-btm" id="facilitating_0" style="width: 95%;" /></td>--%>
                        <td>
                            <textarea id="facilitating_0" class="marg-btm" name="ment_text" rows="4" cols="100" style="width: 100%;"></textarea></td>
                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>
                    </tr>
                </table>
                <%--<div> <span>Please mention total hours spent on above: </span><span><input type="number" name="quantity" min="0" max="100" id="txt_facilitating_activity" style="width:60px;display:inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 100)" disabled />
                </span></div>--%>
            </div>

        </div>


    </div>

    <div class="panel panel-default ">

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>5.2 Mention Inhibiting </b>
                <input type="button" id="btn_add_details_Inhibiting_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('Inhibiting_activity');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_Inhibiting_activity_dtl" class="panel-collapse collapse in">
                <table id="tbl_Inhibiting_activity_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th style="width: 95%;">
                            <center>Mention inhibiting (unfavorable) factors pertaining to your role <span style="color: red;">*</span> </center>
                        </th>

                        <th>Action</th>
                    </tr>
                    <tr>
                        <%--<td><input type="text" class="marg-btm" id="Inhibiting_0" style="width: 95%;" /></td>--%>
                        <td>
                            <textarea id="Inhibiting_0" class="marg-btm" name="ment_text" rows="4" cols="100" style="width: 100%;"></textarea></td>
                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>
                    </tr>
                </table>
                <%--<div> <span>Please mention total hours spent on above: </span><span><input type="number" name="quantity" min="0" max="100" id="txt_facilitating_activity" style="width:60px;display:inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 100)" disabled />
                </span></div>--%>
            </div>

        </div>


    </div>


    <div class="panel panel-default ">

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>6. Trainings required </b>
                <input type="button" id="btn_add_details_training_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('training_activity');" />
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_training_activity_dtl" class="panel-collapse collapse in">
                <table id="tbl_training_activity_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th style="width: 95%;">
                            <center>List any trainings required to update/enhance your knowledge/ skill set <span style="color: red;">*</span> </center>
                        </th>

                        <th>Action</th>
                    </tr>
                    <tr>
                        <%--<td><input type="text" class="marg-btm" id="training_skillg_0" style="width: 95%;" /></td>--%>
                        <td>
                            <textarea id="training_skillg_0" class="marg-btm" name="traning_skill_text" rows="4" cols="100" style="width: 100%;"></textarea></td>
                        <td>
                            <center><i class='icon-trash icon-2x text-blue ' style='cursor: pointer;'></i></center>
                        </td>
                    </tr>
                </table>
                <%--<div> <span>Please mention total hours spent on above: </span><span><input type="number" name="quantity" min="0" max="100" id="txt_facilitating_activity" style="width:60px;display:inline;" placeholder="Hours" onkeypress="return onlyNumberKey(event)" onkeyup="this.value = fnc(this.value, 0, 100)" disabled />
                </span></div>--%>
            </div>

        </div>


    </div>


    <div class="panel panel-default " style="display:none;">

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>7. SELF EVALUATION </b>
                <div style="font-weight: bold; color: brown; align=right;">
                    [ 1 - Completely Disagree | 2 - Partially Disagree | 3 - Neither Agree nor Disagree | 4 - Partially Agree | 5 - Completely Agree ]

                </div>
            </div>

            <div style="padding: 10px; overflow: auto;" id="div_self_evaluation_dtl" class="panel-collapse collapse in">
                <table id="tbl_self_evaluation_dtl" style="width: 100%;" cellpadding="10" cellspacing="20">
                </table>
            </div>

        </div>


    </div>



       <div class="panel panel-default " style="display:block;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>7. Upload Document <span style="color: red;">*</span></b>
                <div style="font-weight: bold; color: brown; align=right;">
                </div>
            </div>
           <hr/>
          <div style="padding: 10px; overflow: auto;" id="div_self_evaluation_upload_dtl" class="panel-collapse collapse in">
    <div>
        <label style="color:blue;">Upload Self-Evaluation : 
        <a href="/ApprisalFileUploads/Evaluation.docx" download style="color:red; text-decoration: underline; margin-left: 10px;">
        Download File Format </a></label>
        <input type="file" class="fileUploader" data-docno="1" />
        <button type="button" class="btnUpload">Upload</button>
    </div>
              <hr />
           
    <div>
        <label style="color:blue;">Upload Actual AWP( Annual work plan -2024-2025)(Only PDF File) : </label>
        <input type="file" class="fileUploader" data-docno="2" />
        <button type="button" class="btnUpload">Upload</button>
    </div>
              <hr/>
    <div>
        <label style="color:blue;">Upload Proposed AWP ( Annual work plan - 2025-2026) (Only PDF File) : </label>
        <input type="file" class="fileUploader" data-docno="3" />
        <button type="button" class="btnUpload">Upload</button>
    </div>
               <hr/>
    <div>
        <label style="color:blue;">Upload Certificate ( Training certificate / Publication certificate / Any Certificate) (Only PDF File UP To 10MB ) : </label>
        <input type="file" class="fileUploader" data-docno="4" />
        <button type="button" class="btnUpload">Upload</button>
    </div>
<hr/>
    <br/>
    <table id="tbl_self_evaluation_upload_doc_dtl" style="width: 100%;" cellpadding="10" cellspacing="20" border="1">
        <thead>
            <tr>
                <th>#</th>
                <th>Document Name</th>
                <th>Download Link</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody></tbody>
    </table>
</div>

        </div>


    </div>


    <div class="panel panel-default" id="comment_section" style="display: none;">

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Comments </b>
            </div>
            <div style="padding: 10px; overflow: auto;" id="div_comments" class="panel-collapse collapse in">

                <table id="tbl_comments_activity_publish" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Dean’s comments (For Training Programs ) : </th>
                        <th>
                            <textarea id="deancomments" name="deancomments" rows="4" cols="100" style="width: 98%;"></textarea></th>
                    </tr>
                    <tr>
                        <th>Over All Comments by the Faculty Dean: </th>
                        <th>
                            <textarea id="deanallcomments" name="deanallcomments" rows="4" cols="100" style="width: 98%;"></textarea></th>
                    </tr>
                    <tr>
                        <th>Comments by review committee : </th>
                        <th>
                            <textarea id="reviewcomments" name="reviewcomments" rows="4" cols="100" style="width: 98%;"></textarea></th>
                    </tr>
                </table>
            </div>

        </div>


    </div>

    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                </div>
                <div id="submitBtnDivhr" class="controls" style="text-align: center; display: none;">
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->

    </div>
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />

    <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <input type="hidden" id="show_hdn_year" runat="server" clientidmode="Static" />


    
<script>
    let docCounter = 1;

   

    $('.btnUpload').on('click', function () {
        const parentDiv = $(this).closest('div');
        const fileInput = parentDiv.find('.fileUploader')[0];
        const $fileInput = $(fileInput); // jQuery wrapper
        const docNo = $fileInput.data('docno');
        var customFileName = '';
        if (docNo == '1')
        {
            customFileName = $('#hdnuserid').val() + '_self_evaluation_2024-2025';
        }
        else if (docNo == '2') {
            customFileName = $('#hdnuserid').val() + '_AWP Actual-2024-2025';
        }
        else if (docNo == '3') {
            customFileName = $('#hdnuserid').val() + '_AWP_Proposed_2025-2026';
        }
        else if (docNo == '4') {
            customFileName = $('#hdnuserid').val() + '_upload_certificate_2025-2026';
        }
        
        

        if (!fileInput.files.length) {
            alert("Please choose a file.");
            return;
        }

        const file = fileInput.files[0];
        const originalExtension = file.name.split('.').pop();
        const newFileName = customFileName
            ? `${customFileName}.${originalExtension}`
            : file.name;

        // Rename file using Blob (if required by server)
        const renamedFile = new File([file], newFileName, { type: file.type });

        const formData = new FormData();
        formData.append("uploadedFile", renamedFile);

        $.ajax({
            url: '../../Handler/ApprisalFileUpload.ashx',
            type: 'POST',
            data: formData,
            contentType: false,
            processData: false,
            success: function (filepath) {
                const fileName = newFileName;
                const existingRow = $('#tbl_self_evaluation_upload_doc_dtl tbody tr').filter(function () {
                    return $(this).find('td:first').text().trim() == docNo;
                });

                if (existingRow.length > 0) {
                    existingRow.find('td:eq(1)').text(fileName);
                    existingRow.find('td:eq(2)').html(`<a href="${filepath}" target="_blank" download>Download</a>`);
                } else {
                    const newRow = `
                    <tr>
                        <td>${docNo}</td>
                        <td>${fileName}</td>
                        <td><a href="${filepath}" target="_blank" download>Download</a></td>
                        <td><button type="button" class="btn btn-danger btn-sm remove-subrow" style="border-radius: 6px;"><i class="fa fa-trash remove-subrow" aria-hidden="true" style="margin-top: 50%;"></i></button></td>
                    </tr>`;
                    $('#tbl_self_evaluation_upload_doc_dtl tbody').append(newRow);
                }
                $(fileInput).prop('disabled', true);
                parentDiv.find('.btnUpload').prop('disabled', true);
            },
            error: function () {
                alert("File upload failed.");
            }
        });
    });

</script>
</asp:Content>

