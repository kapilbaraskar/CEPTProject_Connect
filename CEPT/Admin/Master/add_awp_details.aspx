<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="add_awp_details.aspx.cs" Inherits="Admin_Master_add_awp_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="row-fluid" id="for_other" style="display: none;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Add AWP Details 
            </h1>
        </div>
    </div>


     <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Personal Details</b>
            </div>
            <div style="padding: 10px; overflow: visible;" id="div_personal_detail" class="panel-collapse collapse in">
                
                <table style="width: 100%;" cellpadding="10" cellspacing="20">
                    
                    <tr>
                        <td class="pad-top" style="display:none;">VF Code<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td style="display:none;">
                            <input type="text" id="txt_vf_code" class="marg-btm" disabled />
                        </td>
                        <td class="pad-top">Title<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <select id="drp_title" class="marg-btm">
                                <option value="">--Select Title--</option>
                                <option value="Mr.">Mr.</option>
                                <option value="Ms.">Ms.</option>
                                <option value="Dr.">Dr.</option>
                                <option value="Prof.">Prof.</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td class="pad-top">First Name<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_first_name" class="marg-btm" />
                        </td>
                        <td class="pad-top">Last Name<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_last_name" class="marg-btm" />
                        </td>
                    </tr>


                    <tr>

                        <td class="pad-top">Gender<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <select id="drp_gender" class="marg-btm">
                                <option value="">--Select Gender--</option>
                                <option value="M">Male</option>
                                <option value="F">Female</option>
                                <option value="O">Other</option>
                            </select>
                        </td>

                        <td class="pad-top">Email ID<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_email" class="marg-btm" />
                        </td>

                    </tr>

                    <tr>

                        <td class="pad-top">Mobile Number<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_mobile_no" class="marg-btm" onkeypress='return IsNumeric(event);' maxlength="10" />
                        </td>
                        <td class="pad-top" id="bank_6">Blood Group<span class="" style="display: none; color: Red;">*</span>
                        </td>
                        <td id="bank_7">
                            <%--<input type="text" id="txt_blood_group" class="marg-btm"/>--%>
                            <select id="txt_blood_group" class="marg-btm">
                                <option value="">--Select Blood Group--</option>
                                <option value='A+'>A+</option>
                                <option value='A-'>A-</option>
                                <option value='B+'>B+</option>
                                <option value='B-'>B-</option>
                                <option value='AB+'>AB+</option>
                                <option value='AB-'>AB-</option>
                                <option value='O+'>O+</option>
                                <option value='O-'>O-</option>
                            </select>
                        </td>

                    </tr>      
                    
                      <tr>
                        <td class="pad-top">Designation<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_designation" class="marg-btm" />
                        </td>
                        <td class="pad-top">Faculty<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_faculty_name" class="marg-btm" />
                        </td>
                    </tr>

                    <tr>
                        <td class="pad-top">Date Of Joing CEPT<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_date_of_joing_cept" class="marg-btm" />
                        </td>
                        <td class="pad-top">Academic Year<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td>
                            <input type="text" id="txt_academic_year" class="marg-btm" />
                        </td>
                    </tr> 
                    <tr>
                        <td  class="pad-top">Total Hours of Engagement<br />  as per Contract<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td> 
                            <input type="text" id="txt_enag_hourse" class="marg-btm" />
                        </td>
                        
                    </tr>

                </table>
            </div>

        </div>
     
    <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Teaching Details </b>
            </div>
            <div style="padding-left:15px; padding-top:10px;">
            <span >Studio Unit : </span> <input type="text" id="txt_studio_unit" class="marg-btm" />
        </div>

         <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Mandatory Courses Details </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_mandatory_course" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Elective Courses Details </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_elective_course" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>


         <div class="panel panel-default ">
            <div class="panel-heading">
                <b>DRP Details </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_drp_course" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>

         <div class="panel panel-default ">
            <div class="panel-heading">
                <b>PHD Details </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_phd_course" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>


         <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Faculty Institutional Work </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_institutional_work" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>University Institutional Work </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_university_institutional_work" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>CPP Courses & Mentorship </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_cpp_course_dtl" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>


          <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Research & Publication </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_research_dtl" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>

        <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Projects </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_projects_dtl" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>


         <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Other Work </b>
            </div>
            <div style="padding: 10px; overflow: visible; display: block;" id="div_other_work_dtl" class="panel-collapse collapse in">
               <table class="data-table table table-bordered table-striped" border="0" style="width: 100%;" cellpadding="10" cellspacing="20">
                   <tr>
                       <th>Course Code</th>
                       <th>Course Name</th>
                       <th>Course Credit</th>
                       <th>Semester </th>
                       <th>Year</th>
                   </tr>
               </table>
            </div>

        </div>

        </div>
</asp:Content>

