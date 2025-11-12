<%@ Page Language="C#" AutoEventWireup="true" CodeFile="medical_fitness_certificate.aspx.cs" Inherits="Student_medical_fitness_certificate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../DesignJS/jquery.min.js"></script>
    <script>
        {
$(document).ready(function () 
{
get_student_dtl();
});
   function get_student_dtl() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_student_dtl",
                    async: false,
                    data: "{student_code : '" + $("#hdn_stud_code").val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            var student_data = JSON.parse(data.d);
                            $('#stu_name').text(student_data[0]["user_name"]);
                            $('#blood').text(student_data[0]["blood_group"]);
                            $('#stu_mail_id').text(student_data[0]["mail"]);
                            $('#stu_application').text(student_data[0]["user_id"]);
                            if(student_data[0]["gender"] == 'M'){$('#gender').text('Male');}else if(student_data[0]["gender"] == 'F'){$('#gender').text('FeMale');}
  
                        }
                        else {

                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
}
    </script>
    <style>
        table, td {
            border: 1px solid black;
            padding-left: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }
        body {
            font-family: Helvetica Neue,Helvetica,Arial,sans-serif;
            margin: 12px 40px 0px 25px;
            font-size: 16px;color: #333;
        }
    </style>
    <title></title>
</head>
<body>
    <div>
        <%--<div style="float: right;">
            <img style="margin-top: 5px; margin-left: 5px; width: 66%; height: 50%;" src="../image/Capture.PNG" />
        </div>--%>
        <table style="border:none;">
<tr>
<td style="border:none;"><img style="margin-top: 5px;margin-left: 25px; width: 25%;height:110%;float: right;" src="../image/Capture.PNG" /></br><span id="annex" style="padding-left: 400px; font-weight:bold;font-size: 20px;">Annexure - 6</span></td>
</tr>
</table>
        <div id='title_text' style='text-align: center; font-size: 24px;margin-bottom: -13px;'>
            <h3>PERSONAL FITNESS CERTIFICATE</h3>
        </div>
        <p><b>Student Profile Details:</b></p>
        <table>
            <tr>
                <td style='width: 25%;' colspan='2'>Student's Name:</td>
                <td style='width: 75%;' colspan='7' id="stu_name"></td>
            </tr>
            <tr>
                <td style='width: 25%;' colspan='2'>Student’s Mobile Number:</td>
                <td style='width: 25%;' colspan='2' id="stu_mobile"></td>
                <td style='width: 25%;'>Parent’s Mobile Number:</td>
                <td style='width: 25%;' colspan='3' id="stu_part_mobile"></td>
            </tr>
            <tr>
                <td style='width: 25%; height: 35px;' colspan='2'>Code No/Application No:</td>
                <td style='width: 25%; height: 35px;' colspan='2' id="stu_application"></td>
                <td style='width: 25%; height: 35px;'>Enrolled in:</td>
                <td style='width: 12.5%; height: 35px;'>UG</td>
                <td style='width: 12.5%; height: 35px;'>PG</td>
            </tr>
            <tr>
                <td style='width: 25%;' colspan='2'>Email ID:</td>
                <td style='width: 75%;' colspan='6' id="stu_mail_id"></td>
            </tr>

            <tr>
                <td style='width: 12.5%;'>Age:</td>
                <td style='width: 12.5%;'></td>
                <td style='width: 12.5%;'>Sex:</td>
                <td style='width: 12.5%;' id="gender"></td>
                <td style='width: 25%;'>Blood Group:</td>
                <td style='width: 25%;' colspan='3' id="blood"></td>
            </tr>
            <tr>
                <td style='width: 3%;'>Permanent Address:</td>
                <td style='width: 95%;' colspan='6'></td>
            </tr>
        </table>
        <p><b>A.Medical Information:</b></p>
        <table>
            <tr>
                <td style='width: 100%;' colspan='4'>Specific Identification Marks (minimum 2 if possible)</td>
            </tr>
            <tr>
                <td style='width: 50%;' colspan='2'>1.</td>
                <td style='width: 50%;' colspan='2'>2.</td>
            </tr>
            <tr>
                <td style='width: 15%;'>Routine Complaints:</td>
                <td colspan='3'></td>
            </tr>
            <tr>
                <td style='width: 15%;'>Known allergy to drugs/food:</td>
                <td></td>
                <td colspan='1' style='width: 15%;'>Disability:</td>
                <td></td>
            </tr>
        </table>
        <p><b>B.Past history of major illness:</b></p>
        <table>
            <tr>
                <td style='width: 15%;'>
                    <ul>
                        <li>TB :</li>
                        <li>Asthma :</li>
                        <li>Epilepsy :</li>
                    </ul>
                </td>
                <td></td>
                <td colspan='1' style='width: 25%;'>
                    <ul>
                        <li>Any majorinjury &/ or
operation :</li>
                        <li>Any major prolonged illness :</li>
                    </ul>
                </td>
                <td></td>
            </tr>
        </table>
        </br>
        <table>
            <tr>
                <td style='width: 40%;' colspan='2'>Any habit/addiction (smoking, alcohol etc.):</td>
                <td style='width: 50%;' colspan='2'></td>
            </tr>
        </table>
        <p><b>C.Family History :</b></p>
        <table>
            <tr>
                <td style='width: 15%;'>High blood pressure :</td>
                <td style='width: 35%;'></td>
                <td style='width: 15%;'>Diabetes :</td>
                <td style='width: 35%;'></td>
            </tr>
            <tr>
                <td style='width: 15%;'>Ischemic Heart Disease :</td>
                <td style='width: 35%;'></td>
                <td style='width: 15%;'>Tuberculosis :</td>
                <td style='width: 35%;'></td>
            </tr>
            <tr>
                <td style='width: 15%;'>Thalassemia :</td>
                <td style='width: 35%;'></td>
                <td style='width: 15%;'>Other :</td>
                <td style='width: 35%;'></td>
            </tr>
        </table>
         <p><b>D.Psychological/Emotional Health :</b></p>
        <p style="font-size: 18px; margin-bottom: 10px;">
        a) Do you have any concerns about your emotional health that you would like to address? 
        <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            Yes <input type="checkbox" style="margin-left: 5px;" />
        </label>
        <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            No <input type="checkbox" style="margin-left: 5px;" />
        </label>
    </p>
        <p style="font-size: 18px; margin-bottom: 10px;">
       b) How often have you felt overwhelmed in the past: 
        <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            Never <input type="checkbox" style="margin-left: 5px;" />
        </label>
        <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            Rarely <input type="checkbox" style="margin-left: 5px;" />
        </label>
             <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            Sometimes <input type="checkbox" style="margin-left: 5px;" />
        </label>
             <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            Often <input type="checkbox" style="margin-left: 5px;" />
        </label>
              <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            Always <input type="checkbox" style="margin-left: 5px;" />
        </label>
    </p>
           <p style="font-size: 18px; margin-bottom: 10px;">
        c) Have you experienced any of the following in the past few months? (Select all that apply):
    </p>
    <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            Persistent sadness or hopelessness <input type="checkbox" style="margin-left: auto;" />
        </label>
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            Suicidal thoughts <input type="checkbox" style="margin-left: 100px;" />
        </label>
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            Panic attacks <input type="checkbox" style="margin-left: 100px;" />
        </label>
    </p>
    <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            Anxiety or excessive worry <input type="checkbox" style="margin-left: auto;" />
        </label>
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            None of the above <input type="checkbox" style="margin-left: 94px;" />
        </label>
    </p>


        <p style="font-size: 18px; margin-bottom: 10px;">
        d) On a scale of 1-10, how would you rate your overall mental health in the past few months? </p>
           <span style="margin-left:20px;"> Answer should be a single choice (Circle the answer):</span>
    
        <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            a. 1 (very poor) 
        </label>
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            e. 5(everage) 
        </label>

<label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            j. 10 Excellent 
        </label>
        
    </p>

         <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            b. 2 
        </label>
             <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
           f. 6 
        </label>
        
        
    </p>

         <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            c. 3 
        </label>
             <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            g. 7 
        </label>
        
        
    </p>


         <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            d. 4 
        </label>
             <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            h. 8 
        </label>
        
        
    </p>

        <p style="font-size: 18px; margin-bottom: 10px;">
            <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
             
        </label>
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            i. 9 
        </label>
        
        
    </p>








        <p style="font-size: 18px; margin-bottom: 10px;">
        e) Which of the following have you used to cope with stress or negative feelings in the past few months? </p>
           <span style="margin-left:20px;"> (Select all that apply) The answer should be a multiple choice :</span>
    
        <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            a. Exercise
        </label>
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            c. Meditation or mindfulness practices
        </label>

<label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            e. Substance use (alcohol, drugs)
        </label>
        
    </p>

         <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            b. Watching TV or movies
        </label>
             <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
           d. Talking to a friend or family member
        </label>

             <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
           f. None of the above
        </label>
        
        
    </p>



         <p style="font-size: 18px; margin-bottom: 10px;">
        f) How effective have your coping strategies been in managing stress or negative feelings? </p>
           <span style="margin-left:20px;"> The answer should be a single choice (Circle the answer) :</span>
    
        <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            a. Not effective at all
        </label>
            <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            b. Somewhat effective
        </label>
            <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            c. Moderately effective 
        </label>
           
        
    </p>

        <p style="font-size: 18px; margin-bottom: 10px;">
        
            <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            d.Very effective
        </label>
            <label style="display: inline-flex; align-items: center; width: 250px;margin-left: 27px;">
            e. Extremely effective
        </label>
        
    </p>
        <br />
        <br />
        <br />
        <br />


        <p style="font-size: 18px; margin-bottom: 10px;">
        g) Have you sought help for mental health issues in the past? <span> answer should be a single choice: </span>
        <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            Yes <input type="checkbox" style="margin-left: 5px;" />
        </label>
        <label style="display: inline-flex; align-items: center; margin-left: 10px;">
            No <input type="checkbox" style="margin-left: 5px;" />
        </label>
    </p>




        <p style="font-size: 18px; margin-bottom: 10px;">
        h) If you answered yes to question g), what resources did you use? </p>
           <span style="margin-left:20px;"> (Select all that apply) The answer should be a multiple choice :</span>
    
        <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 280px;margin-left: 27px;">
            a. Therapy or counselling services Exercise
        </label>
        <label style="display: inline-flex; align-items: center; width: 280px;margin-left: 27px;">
            c. Online resources or self-help materials
        </label>

<label style="display: inline-flex; align-items: center; width: 280px;margin-left: 27px;">
            e. Support groups
        </label>
        
    </p>

         <p style="font-size: 18px; margin-bottom: 10px;">
        <label style="display: inline-flex; align-items: center; width: 280px;margin-left: 27px;">
            b. Medication prescribed by a doctor
        </label>
             <label style="display: inline-flex; align-items: center; width: 280px;margin-left: 27px;">
           d. None of the above
        </label>

             <label style="display: inline-flex; align-items: center; width: 280px;margin-left: 27px;">
           f. N/A
        </label>
        
        
    </p>

       <p style="font-size: 18px; margin-bottom: 10px; line-height: 2.5; margin-right:10px;">
    i) Please provide a brief description of your problem if applicable :
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
   
</p>

         <p style="font-size: 18px; margin-bottom: 10px; line-height: 2.5; margin-right:10px;">
    j) Family History (if any) :
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    _______________________________________________________________________________________________
    
</p>
        <p style="page-break-before: avoid; page-break-after: always;">*All records, including this form, are kept securely and maintain confidentially.</p>

        <%--<span style="position: fixed; bottom: 0; width: 100%; text-align: center; background-color: white; padding: 10px; font-size: 14px;">*All records, including this form, are kept securely and maintain confidentially</span>--%>
        <br />
        <br />
        

        <div id='title_text_medical' style='text-align: center; font-size: 24px;margin-bottom: -13px;'>
            <h3>MEDICAL FITNESS CERTIFICATE</h3>
        </div>

        <p><b>E.General Examination :</b></p>
        <table>
            <tr>
                <td style='width: 15%;'>Height :</td>
                <td style='width: 35%;'></td>
                <td style='width: 15%;'>Weight :</td>
                <td style='width: 35%;'></td>
            </tr>
            <tr>
                <td style='width: 15%;'>Color blindness :</td>
                <td style='width: 35%;'></td>
                <td style='width: 15%;'>Vision ability :</td>
                <td style='width: 35%;'></td>
            </tr>
            <tr>
                <td style='width: 15%;'>Color of the eye :</td>
                <td style='width: 35%;' colspan='3'></td>
            </tr>
        </table>

        <p><b>F.Examination :</b></p>
        <table>
            <tr>
                <td style='width: 15%;'>Pulse :</td>
                <td style='width: 35%;'></td>
                <td style='width: 15%;'>Blood Pressure :</td>
                <td style='width: 35%;'></td>
            </tr>
            <tr>
                <td style='width: 15%;'>Respiratory (Chest screening) :</td>
                <td style='width: 35%;'></td>
                <td style='width: 15%;'>Cardio Vascular System :</td>
                <td style='width: 35%;'></td>
            </tr>
            <tr>
                <td style='width: 15%;'>Per Abdomen :</td>
                <td style='width: 35%;'></td>
                <td style='width: 15%;'>Central Nervous System :</td>
                <td style='width: 35%;'></td>
            </tr>
        </table>
        </br>
        <table>
            <tr>
                <td style='width: 50%;'><b>G.Remarks</b></td>
                <td style='width: 50%;'><b>H.Recommendations</b></td>
            </tr>
            <tr>
                <td style='width: 50%; height: 25%;'>
                    <div style="height: 150px; overflow: hidden;"></div>
                </td>
                <td style='width: 50%; height: 25%;'>
                    <div style="height: 150px; overflow: hidden;"></div>
                </td>
            </tr>
        </table>
        </br>

        <%--<table style="border:none;">
            <tr>
                <td style="width:50%;height:300px;border:none;"><div style='width: 50%; height: 45%; border-radius: 25px;padding-bottom: 100px; margin-left: 20%; border:solid 2px black;'></div></td>
                <td style="width:50%;height:300px; border:none;"><div style='width: 50%; height: 45%; border-radius: 25px;padding-bottom: 100px;  margin-left: 20%;border:solid 2px black;'></div></td>
            </tr>
        </table>--%>
        <div>
        <div style='width: 100%; height:100%;'>
          
            <div style="border: 2px solid black;padding: 10px;border-radius: 25px;width:40%;height:115px; float:left;"></div>
             <div style="border: 2px solid black;padding: 10px;border-radius: 25px;width:40%;height:115px;float:right;"></div>

        </div>
        </br>
        <div style='width: 100%; padding-bottom: 15px;'>
            <div style="width:40%;float:left;text-align:center;padding-top: 15px;"><b>Signature of Allopathy doctor (MBBS & above) with Registration Number of Govt. Medical Council</b></div>
           
            <div style="width:40%;float:right;text-align:center;padding-top: 15px;"><b>Stamp of Doctor</b></div>
           
        </div>
            </div>
        <br />
        <br />
        

    </div>
    <div class="row" style="margin-top: 30%;margin-left:1%;">
            <p style="text-align:center;">I HEREBY CERTIFY that the information provided in this form is complete, true, and correct to the best of my knowledge.</p>

         <div style='width: 100%; padding-bottom: 15px; margin-top:5%;'>
            <div style="width:40%;float:left;text-align:center;padding-top: 15px;"><b>Student Signature : _______________ </b></div>
           
            <div style="width:40%;float:right;text-align:center;padding-top: 15px;"><b>Date : _________________</b></div>
           
        </div>
        <br />
        
        </div>
    <input type="hidden" id="hdn_stud_code" runat="server" clientidmode="Static" />
</body>
</html>
