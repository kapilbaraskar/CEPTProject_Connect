<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="level3_choice_reg.aspx.cs" Inherits="Student_level3_choice_reg" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function ()
        {
            Get_semester_data();
            $('#btnsubmit').on('click', function ()
            {
                var origin = window.location.origin;
                window.open(origin + "/Student/" + "level3_choice_reg_dtl.aspx");
            });

        });


        function Get_semester_data() {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_cept_current_sem_data",
                    data: "{type:'L3_Choice_Reg'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var sem_data = JSON.parse(data.d);
                            $('#sem_year').text(sem_data[0]["sem_desc"] + ' ' + sem_data[0]["year_code"]);
                            if (sem_data[0]["sem_code"] == 'S') {
                                var year_code_new = parseInt(sem_data[0]["year_code"]) - parseInt(1);
                                $('#pre_sem_year').text('Monsoon' + ' ' + year_code_new);
                            }
                            else if (sem_data[0]["sem_code"] == 'M')
                            {
                                var year_code_new = parseInt(sem_data[0]["year_code"]) + parseInt(1);
                                $('#pre_sem_year').text('Spring' + ' ' + year_code_new);
                            }
                            $('#sem_year_heding').text(sem_data[0]["sem_desc"] + ' ' + sem_data[0]["year_code"]);
                            $('#sem_year_heding_2').text(sem_data[0]["sem_desc"] + ' ' + sem_data[0]["year_code"]);
                            $('#sem_year').text(sem_data[0]["sem_desc"] + ' ' + sem_data[0]["year_code"]);
                        }
                        else {
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; L3 Choice Preference For <span id="sem_year_heding"></span>
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
      <p><b>L3 Preference Survey : <span id="sem_year_heding_2"></b></p>
        <p>1. It will be conducted every semester.</p>
<p>2. The purpose of the "Preference survey" is to identify the number of students for whom L3 studios need to be planned in the forthcoming semester. </p>
<p>3. The survey will be open to all students who have completed/scheduled to complete 4 x L2 Studios by S0 (current semester)</p>
<p>4. In the survey the students are required to confirm their preference for the S1 (forthcoming semester) from among the following: </p>

        <%--<p><b>1.</b> All students who have completed/scheduled to complete 4 x L2 Studios by <span id="pre_sem_year"></span> should confirm their preference for the <span id="sem_year"></span> from among the following: </p>--%>
        <p>
            <ul>
            <li>Studio Unit </li>
            <li>Internship </li>
            <li>DRP (only eligible after completing 2 L3 Studio Units)</li>
           </ul>
         </p>
        
        <p>5. This preference will be recorded on the Connect portal and will be locked after it is entered.  </p>
<p>6. It can be altered, only once in the entire student lifecycle and only with the recommendation of the Dean and the approval of the Provost and. </p>
<p>7. In case, a student does not indicate his/her preference by completing the survey on time, it will be understood that the student is not going to register for the forthcoming semester and he/she will not be able to take up registration during the registration window. </p>
<p>7. Timeline: the preference survey will be floated on the Connect portal before the end of Wk 10 (17 March '23) of the semester. Students will have 2 weeks to fill out the preferences. The final preferences will be available on the portal by end of Wk 12 (31 March '23).  </p>

        <%--<p><b>2.</b> This preference will be recorded on the Connect portal and will be locked after it is entered </p>
        <p><b>Condition :</b></p>
        <p>
            Only under exceptional health or family circumstances, with the recommendation of the Dean 
            and the approval of the Provost, these can be altered once in the entire student lifecycle.
            Such alteration will be done only by the UG or PG office after due approval.
         </p>
         <p><b>3.</b> In case, a student does not indicate their preference by completing the survey on time, it will be understood
            that the student is not going to register for the Monsoon 2023 and they will not be able to take up registration
            during the registration window.
         </p>--%>
        <div style="margin-left:45%;"> <button class="btn btn-primary" id="btnsubmit">Click For L3 choice<br />Registration</button> </div>
        
    </div>
</asp:Content>

