<%@ Page Title="Student Dashboard" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" ViewStateEncryptionMode="Never"
    Inherits="Student_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../Js/student_dashboard.js?t=09072025" type="text/javascript"></script>
    <%--01012020--%><%--17072020--%><%--05112020--%><%--26072021--%><%--07052022--%>

    <style type="text/css">
        body { 
            overflow-x: hidden;
        }

        .style1 {
            width: 386px;
        }

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

        .file-upload {
            overflow: hidden;
            display: inline-block;
            position: relative;
            vertical-align: middle;
            text-align: center;
            cursor: pointer;
        }

        .tbl_credits_dtl {
            width: 100%;
            border-right: 1px solid #DDD;
            border-bottom: 1px solid #DDD;
        }

            .tbl_credits_dtl th {
                color: #307ecc;
            }

            .tbl_credits_dtl th, .tbl_credits_dtl td {
                width: 14%;/*20%*/
                text-align: center;
                border-left: 1px solid #DDD;
                border-top: 1px solid #DDD;
            }

        .col_header {
            color: #307ecc;
            font-weight: 600;
        }

        .cls_align_center {
            border: 1px solid black !important;
        }

            .cls_align_center th, .cls_align_center td {
                text-align: center;
                padding: 5px !important;
            }

            .cls_align_center thead tr:last-child th {
                border-top: 1px solid #ddd !important;
            }

            .cls_align_center tr td:first-child {
                text-align: left;
            }

        #tbl_yes_bank_dtl {
            border: 1px solid black !important;
        }

            #tbl_yes_bank_dtl td {
                border: 1px solid #ddd !important;
            }

            #tbl_yes_bank_dtl tr:nth-child(4) td:nth-child(1), #tbl_yes_bank_dtl tr:last-child td:nth-child(1) {
                border-right: none !important;
            }

            #tbl_yes_bank_dtl tr:nth-child(4) td:nth-child(2), #tbl_yes_bank_dtl tr:last-child td:nth-child(2) {
                border-left: none !important;
            }
    </style>

    <script type="text/javascript">
        var certificate_dtl;
        var pic_status = true;
        $(document).ready(function () {
            if (getParameterByName("fees") == 'c') {
                bootbox.alert('Fees Payment for Spring 2018 is closed. Please contact faculty admin.', function () {
                    location.replace('Dashboard.aspx');
                });
            }

            if (getParameterByName("param") == "true" && $('#HdnMsg').val() != '') {
                bootbox.alert($('#HdnMsg').val(), function () {
                    location.replace('Dashboard.aspx');
                });
            }
            get_announcement_dtl();



        });



        function Insurance_click() {
            var student_id = $('#hdn_user_id').val();
            window.open('https://connect.cept.ac.in/Insurancecards/' + student_id + '.pdf', '_blank');
            //window.open('http://localhost:1121/Insurancecards/' + student_id + '.pdf', '_blank');

        }

        function student_id_click() {
            var student_id = $('#hdn_user_id').val();
            window.open('https://connect.cept.ac.in/Student_ID_Card/' + student_id + '.pdf', '_blank');
            //window.open('http://localhost:1121/Student_ID_Card/' + student_id + '.pdf', '_blank');

        }

        function CampusEntry(status) {
            var course_code = "";

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/DatesForCampusEntry",
                data: "{}",
                contentType: "application/json",
                async: false,
                cache: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != "") {
                        course_code = data.d;
                        if (status == '') {
                            //window.open('http://localhost:1121/CampusEntry/' + course_code + '.pdf', '_blank');
                            window.open('https://connect.cept.ac.in/CampusEntry/' + course_code + '.pdf', '_blank');
                        }
                    }
                    else {
                        //$("#campusdates").remove();
                        $("#campusdates").remove();
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
                results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }


        function check_status() {
            var status = true;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/Get_mandatory_certificate_dtl",
                data: "{}",
                contentType: "application/json",
                async: false,
                cache: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != "") {
                        
                        certificate_dtl = JSON.parse(data.d);
                        
                            var pic_slash = certificate_dtl[0]['profile_photo'].split("/");
                        if (pic_slash.length > 1)
                        {
                            pic_status = false;
                        }
                        else {
                            if (certificate_dtl[0]['profile_photo'] != "" && certificate_dtl[0]['profile_photo'] != undefined) {
                                pic_status = true;
                            }
                            else {
                                pic_status = false;
                            }
                        }
                        //if (certificate_dtl[0]['dob'] != "" && certificate_dtl[0]['blood_group'] != "" && certificate_dtl[0]['antiragging_certificate'] != "" && certificate_dtl[0]['medical_certificate'] != "" && certificate_dtl[0]['consent_status'] != "" )
                        //if (certificate_dtl[0]['dob'] != "" && certificate_dtl[0]['blood_group'] != "" && certificate_dtl[0]['antiragging_certificate'] != "" && certificate_dtl[0]['consent_status'] != "" )

                        if (certificate_dtl[0]['dob'] != "" && certificate_dtl[0]['antiragging_certificate'] != "" && certificate_dtl[0]['medical_certificate'] != "" && certificate_dtl[0]['apaaridStatus'] == "Y")
                        {
                            if (certificate_dtl[0]['school_leaving_certificate'] != "")
                            {
                                if (status)
                                {
                                    status = true;
                                }
                            }
                            else if (certificate_dtl[0]['birth_certificate'] != "")
                            {
                                if (status)
                                {
                                    status = true;
                                }
                            }
                            else
                            {
                                status = false;
                            }
                        }
                        else
                        {
                            status = false;

                        }

                        if (status == false) {

                            var str_html = '<table class="tbl_credits_dtl"><tr><th>Name</th><th>Status</th><th>Action</th></tr>';

                            for (var i = 0; i < certificate_dtl.length; i++)
                            {
                                //if (certificate_dtl[i]['dob'] != "") {
                                //    str_html += '<tr><td>Date of Birth</td>' +
                                //        '<td>Submitted</td>' +
                                //        '<td></td></tr>';
                                //}
                                //else {
                                //    str_html += '<tr><td>Date of Birth</td>' +
                                //        '<td>Pending</td>' +
                                //        '<td><a href="' + location.origin + '\\Student\\student_birth_leaving_certificate.aspx">Click Here</a></td></tr>';
                                //}
                                //13072022
                                //if (certificate_dtl[i]['consent_status'] == "A") {
                                //    str_html += '<tr class="sem_tr1"><td>Consent Form</td>' +
                                //        '<td>Submitted</td>' +
                                //        '<td></td></tr>';
                                //}
                                //else {
                                //
                                //    str_html += '<tr class="sem_tr1"><td>Consent Form</td>' +
                                //        '<td>Pending</td>' +
                                //        '<td><a href="' + location.origin + '\\Student\\student_consent_form.aspx">Click Here</a></td></tr>';
                                //
                                //}

                                if (certificate_dtl[i]['apaaridStatus'] == "Y")
                                {
                                    
                                    if (certificate_dtl[i]['apaaridbypass'] != 'N') {
                                        str_html += '<tr class="sem_tr1"><td>Apaar ID</td>' +
                                            '<td>Submitted</td>' +
                                            '<td></td></tr>';
                                    }
                                    
                                }
                                else
                                {
                                    
                                        str_html += '<tr class="sem_tr1"><td>Apaar ID</td>' +
                                            '<td>Pending</td>' +
                                            '<td><a href="' + location.origin + '\\Student\\student_apaar_id.aspx">Click Here</a></td></tr>';
                                    
                                    
                                }


                                if (certificate_dtl[i]['medical_certificate'] != "")
                                {
                                    str_html += '<tr class="sem_tr1"><td>Medical Fitness Certificate</td>' +
                                        '<td>Submitted</td>' +
                                        '<td></td></tr>';
                                }
                                else
                                {
                                    str_html += '<tr class="sem_tr1"><td>Medical Fitness Certificate</td>' +
                                        '<td>Pending</td>' +
                                        '<td><a href="' + location.origin + '\\Student\\student_medical_fintness_certificate.aspx">Click Here</a></td></tr>';
                                }

                                if (certificate_dtl[i]['antiragging_certificate'] != "")
                                {
                                    str_html += '<tr class="sem_tr1"><td>Anti-Ragging Certificate</td>' +
                                        '<td>Submitted</td>' +
                                        '<td></td></tr>';
                                }
                                else
                                {
                                    str_html += '<tr class="sem_tr1"><td>Anti-Ragging Certificate</td>' +
                                        '<td>Pending</td>' +
                                        '<td><a href="' + location.origin + '\\Student\\student_antiragging_certificate.aspx">Click Here</a></td></tr>';
                                }

                                if (certificate_dtl[i]['birth_certificate'] != "")
                                {
                                    str_html += '<tr class="sem_tr1"><td>Proof Of DOB</td>' +
                                        '<td>Submitted</td>' +
                                        '<td></td></tr>';
                                }
                                else if (certificate_dtl[i]['school_leaving_certificate'] != "")
                                {
                                    str_html += '<tr class="sem_tr1"><td>Proof Of DOB</td>' +
                                        '<td>Submitted</td>' +
                                        '<td></td></tr>';
                                }
                                else
                                {
                                    str_html += '<tr class="sem_tr1"><td>Proof Of DOB</td>' +
                                        '<td>Pending</td>' +
                                        '<td><a href="' + location.origin + '\\Student\\student_birth_leaving_certificate.aspx">Click Here</a></td></tr>';
                                }
                                // close by nitinbhai 09072025
                                //if (certificate_dtl[i]['vaccination_status'] != "")
                                //{
                                //    str_html += '<tr class="sem_tr1"><td>Covid Vaccine Certificate</td>' +
                                //        '<td>Submitted</td>' +
                                //        '<td></td></tr>';
                                //}
                                //else
                                //{
                                //    str_html += '<tr class="sem_tr1"><td>Covid Vaccine Certificate</td>' +
                                //        '<td>Pending</td>' +
                                //        '<td><a href="' + location.origin + '\\Student\\student_vaccination_dtl.aspx">Click Here</a></td></tr>';
                                //}

                                if (certificate_dtl[i]['blood_group'] != "")
                                {
                                    str_html += '<tr class="sem_tr1"><td>Blood Group</td>' +
                                        '<td>Submitted</td>' +
                                        '<td></td></tr>';
                                }
                                else
                                {

                                    str_html += '<tr class="sem_tr1"><td>Blood Group</td>' +
                                        '<td>Pending</td>' +
                                        '<td><a href="' + location.origin + '\\Student\\Blood_Group.aspx">Click Here</a></td></tr>';
                                }
                               

                                if (pic_status == false)
                                {
                                    str_html += '<tr class="sem_tr1"><td>Profile Image</td>' +
                                        '<td>Pending</td>' +
                                        '<td><a href="' + location.origin + '\\Student\\Student_Personal_dtl.aspx">Click Here</a></td></tr>';
                                }
                                else
                                {
                                    str_html += '<tr class="sem_tr1"><td>Profile Image</td>' +
                                        '<td>Submitted</td>' +
                                        '<td></td></tr>'
                                }



                            }

                            str_html += '</table>';

                            $('#modal_certificate_status .modal-body').html(str_html);

                            $('#modal_certificate_status .tbl_credits_dtl').css('border', '1px solid rgb(151, 151, 151)');
                            $('#modal_certificate_status .tbl_credits_dtl th').css('border-top', '1px solid rgb(151, 151, 151)');
                            $('.sem_tr1').children().css('border-top', '1px solid rgb(151, 151, 151)');
                            $('.brdr_lft').css('border-left', '1px solid rgb(151, 151, 151)');

                            $('#modal_certificate_status').modal('show');
                            status = false;
                        }
                        //}
                        //else
                        //{
                        //    status = true;
                        //}
                    }
                    else {


                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });

            if (status == true) {
                location.href = location.origin + "/" + "Student/Student_course_selection.aspx";
            }
            else {
                // bootbox.alert("sss");
                return false;
            }


        }

        function get_announcement_dtl() {
            var user_type = $("#hdnusertype").val();
            var origin = window.location.origin;
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_news_announcement_dtl_userwise",
                    //async: false,
                    data: "{user_type:'" + user_type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var str_html = '';
                            var announcement = JSON.parse(data.d);
                            for (var i = 0; i < announcement.length; i++)
                            {
                                str_html += "<p align='justify' style='text-align:justify,font-family: Lato, sans-serif;letter-spacing: 0.05em;'>";
                                str_html += "<img src='../../image/point_left.png' style='width: 25px;height: 22px;position: absolute;'></img>&emsp;";
                                str_html += "<a href='" + location.origin + "\\WSNewsImageUpload\\" + announcement[i]["news_image"] + "' target='_blank' style='font-size: 14px;color: #666;text-justify: inter-character; text-decoration:none;margin-left:17px;font-family: Lato, sans-serif;letter-spacing: 0.05em;'>" + announcement[i]["title"] + "&nbsp;&nbsp;<span style='color:blue;font-family: Lato, sans-serif;letter-spacing: 0.1em;'>" + modify(announcement[i]["date"]) + "</span></a>"
                                str_html += "</p><br/>";
                               // str_html += "<li><a href='" + location.origin + "\\WSNewsImageUpload\\" + announcement[i]["news_image"] + "' target='_blank'>" + announcement[i]["title"] + "</a></li>";
                            }

                            $('#announcement_div').css('display','block');
                            $('#announcement_dtl').append(str_html);
                        }
                        
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function modify(data) {
            var str = data.replace(/-/g, ' ');
            return str;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:HiddenField ID="HdnMsg" runat="server" ClientIDMode="Static" Value="" />

    <div class="modal hide fade" id="myModal" style="left: 50%; width: 48%;">
        <div class="modal-header" style="font-size: 14px;">
            Please fill the following details prior to registration.The data is required for
            updation in your ID cards.
        </div>
        <div class="modal-body" style="height: 350px;">
            <div>
                <img id="img_photo" src="" alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px; height: 100%;"
                    class="img-thumbnail" />
                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                    <span><strong>Upload Photo</strong></span>
                    <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadProfilePhoto();"
                        style="display: none;" />
                </label>
                <br />
                <span style="font-size: 11px;" class="msg_red">(Please upload a photo taken in fullfaceview
                    facing the camera with both eyes open. Maximum 500 KB. <span class="required">*</span>
                    )</span>
            </div>
            <table>
                <tr>
                    <td></td>
                </tr>
                <tr>
                    <td>Name (as per the marksheet)<span class="cls_mendatory" style="color: Red;">*</span>
                        :
                    </td>
                    <td>
                        <input type="text" id="txt_first_name" />
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        Last Name<span class="cls_mendatory" style="color: Red;">*</span> :
                    </td>
                    <td>
                        <input type="text" id="txt_last_name" />
                    </td>
                </tr>--%>
                <tr>
                    <td>Blood Group<span class="cls_mendatory" style="color: Red;">*</span> :
                    </td>
                    <td>
                        <select id="drpbloodgroup">
                            <option value="0">Select Blood Group</option>
                            <option value="O+">O+</option>
                            <option value="O-">O-</option>
                            <option value="A+">A+</option>
                            <option value="A-">A-</option>
                            <option value="B+">B+</option>
                            <option value="B-">B-</option>
                            <option value="AB+">AB+</option>
                            <option value="AB-">AB-</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Gender<span class="cls_mendatory" style="color: Red;">*</span> :
                    </td>
                    <td>
                        <select id="drpgender">
                            <option value='M'>Male</option>
                            <option value='F'>Female</option>
                            <option value='T'>Third Gender</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Date of Birth (dd/mm/yyyy)<span class="cls_mendatory" style="color: Red;">*</span>
                        :
                    </td>
                    <td>
                        <input type="text" id="txt_dob" />
                    </td>
                </tr>
                <tr>
                    <td>Mother/Father's Name<%--<span class="cls_mendatory" style="color: Red;">*</span>--%>:
                    </td>
                    <td>
                        <input type="text" id="txt_father_name" />
                    </td>
                </tr>
                <tr>
                    <td>Mother/Father's Contact No<%--<span class="cls_mendatory" style="color: Red;">*</span>--%>:
                    </td>
                    <td>
                        <input maxlength="10" type="text" id="txt_father_contact_no" onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>
                <tr>
                    <td>Mother/Father's Email Id
                        <%--<span class="cls_mendatory" style="color: Red;">*</span>--%>
                        :
                    </td>
                    <td>
                        <input type="text" id="txt_father_email" />
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        Mother's Name%--<span class="cls_mendatory" style="color: Red;">*</span>--%
                        :
                    </td>
                    <td>
                        <input type="text" id="txt_mother_name" />
                    </td>
                </tr>--%>
                <%--<tr>
                    <td>
                        Mother's Email Id%--<span class="cls_mendatory" style="color: Red;">*</span>--%
                        :
                    </td>
                    <td>
                        <input type="text" id="txt_mother_email" />
                    </td>
                </tr>--%>
                <%--<tr>
                    <td>
                        Mother's Mobile Number%--<span class="cls_mendatory" style="color: Red;">*</span>--%
                        :
                    </td>
                    <td>
                        <input maxlength="10" type="text" id="txt_mother_contact_no" onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>--%>
                <tr>
                    <td>Emergency Contact Name<%--<span class="cls_mendatory" style="color: Red;">*</span>--%>
                        :
                    </td>
                    <td>
                        <input type="text" id="txt_emergency_name" />
                    </td>
                </tr>
                <tr>
                    <td>Relation with Emergency Contact<%--<span class="cls_mendatory" style="color: Red;">*</span>--%>
                        :
                    </td>
                    <td>
                        <input type="text" id="txt_relationship_with_emergency_contact" />
                    </td>
                </tr>
                <tr>
                    <td>Emergency Contact's Mobile No<%--<span class="cls_mendatory" style="color: Red;">*</span>--%>
                        :
                    </td>
                    <td>
                        <input maxlength="10" type="text" id="txt_emergency_contact_number" onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>
                <tr>
                    <td>Emergency Contact's Email Id
                        <%--<span class="cls_mendatory" style="color: Red;">*</span>--%>
                        :
                    </td>
                    <td>
                        <input type="text" id="txt_guardian_email" />
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        Local Guardian Name<span class="cls_mendatory" style="color: Red;">*</span> :
                    </td>
                    <td>
                        <input type="text" id="txt_guardian_name" />
                    </td>
                </tr>
                <tr>
                    <td>
                        Local Guardian Contact Number<span class="cls_mendatory" style="color: Red;">*</span> :
                    </td>
                    <td>
                        <input type="text" id="txt_guardian_contact_number" maxlength="10" onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>--%>
                <%--<tr>
                    <td>
                        Religion <span class="cls_mendatory" style="color: Red;">*</span> :
                    </td>
                    <td>
                        <input type="text" id="txt_religion"  />
                    </td>
                </tr>--%>
                <%--<tr>
                    <td>
                        Students contact number :
                    </td>
                    <td>
                        <input pattern="[789][0-9]{9}" maxlength="10" type="text" id="txt_contact_number"
                            onkeypress='return IsNumeric(event);' />
                    </td>
                </tr>--%>
                <%--<tr>
                    <td>
                        Alternate e-mail :
                    </td>
                    <td>
                        <input type="email" id="txt_alternet_email" />
                    </td>
                </tr>--%>
                <tr>
                </tr>
                <tr>
                    <td style="width: 100%;">
                        <input type="checkbox" id="chkregistration" />
                        The above information is true to the best of my knowledge
                    </td>
                </tr>
            </table>
        </div>
        <div class="modal-footer">
            <center>
                <a href="#" id="btnsavegender" class="btn btn-primary">Submit</a>
            </center>
        </div>
    </div>

    <div class="modal hide fade" id="modal_credit_bifurcation" style="left: 46%; width: 52%;"><%--50/48--%>
        <div class="modal-header" style="font-size: 14px;">
            <b>Credit Bifurcation</b>
        </div>
        <div class="modal-body" style="height: 350px;">
        </div>

        <div class="modal-footer">
            <button id="btn_modal_close" type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
        </div>
    </div>

    <div class="modal hide fade" id="modal_certificate_status" style="left: 50%; width: 48%;">
        <div class="modal-header" style="font-size: 14px;">
            <b>Mandatory Submission</b>
        </div>
        <div class="modal-body" style="height: 210px;">
        </div>

        <div class="modal-footer">
            <button id="btn_modal_close" type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
        </div>
    </div>


    <div class="modal hide fade" id="my_instruction" style="margin-left: -442px; width: 70%;">
        <div class="modal-header">
            <center>
                <b>Important Instructions </b>
            </center>
        </div>
        <div class="modal-body">
            <table cellpadding="2" cellspacing="4">
                <tr>
                    <td>1. Please read the instructions on anti ragging available at 
                        <a href="http://cept.ac.in/student-services/anti-ragging" target="_blank">http://cept.ac.in/student-services/anti-ragging</a> it is compulsory
                        for successful registration you have to submit the affidavit with yours and your parents signature to student service office 
                        at CEPT on or before Friday, 21st July, 2017. The anti ragging form has to be filled every year by all the students of CEPT University.
                    </td>
                </tr>
                <tr>
                    <td>2. To finish the registration the newly admitted students have to submit a certificate
                        from the physician to CEPT University student service office (SSO) the format of the certificate can be download from the link 
                        <%--<a href="http://cept.ac.in/file_manager/files/medicalexaminationform_210415.pdf" target="_blank">http://cept.ac.in/file_manager/files/medicalexaminationform_210415.pdf</a>--%>
                        <a href="http://cept.ac.in/student-services/consult-a-physician" target="_blank">http://cept.ac.in/student-services/consult-a-physician</a>
                        on or before 21st July, 2017
                    </td>
                </tr>
                <tr>
                    <td>3. It is responsibility of a student to choose the mandatory and elective subjects
                        as per the prerequisite given for the course. In case a student does not fulfill the prerequisite for a course he/she will be disqualified.
                    </td>
                </tr>
                <tr>
                    <td>4. It is responsibility of the student not to choose elective which he/she has already
                        finished successfully. In case a student opts for the same course again he/she will be disqualified from the course.
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        3. Please read the instructions on anti-raggingavailable at: <a href="http://cept.ac.in/21/248/student-services/anti-ragging"
                            target="_blank">http://cept.ac.in/21/248/student-services/anti-ragging.</a>
                        It is compulsory for registration to be successful to submit the affidavit with
                        your sign and your parents sign to Student Services Office at CEPT on or before
                        21st July, 20151:30pm.The anti-ragging form has to be filled every year by all the
                        students of CEPT University.
                    </td>
                </tr>
                <tr>
                    <td>
                        4. To finish the registration, the newly admit PG students have to submit a certificate
                        from the physician to CEPT University Student Service Office (SSO). The format of
                        the certificate can be downloaded from the link <a href="http://cept.ac.in/file_manager/files/medicalexaminationform_210415.pdf"
                            target="_blank">http://cept.ac.in/file_manager/files/medicalexaminationform_210415.pdf
                        </a> on or
                        before 21st July, 2015. The CEPT campus doctor will be available on 16th July 2015
                        from 3.00 pm to 6.00 pm if you want to consult him for fitness certificate.
                    </td>
                </tr>--%>
                <tr>
                    <td>5. In case of a conflict, the decision taken by CEPT University management would stand final.
                    </td>
                </tr>
                <tr style="display: none;">
                    <td>
                        <input type="checkbox" id="chk_agree_afidavite" checked />
                        I hereby agree that I would submit the online Anti-Ragging Affidavit duly signed on or before 21st July, 2015 1:30pm.
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox" id="chk_agree_reg_process" />
                        I have read, I understand and agree to abide by the instructions of the registration process.
                    </td>
                </tr>
            </table>
        </div>
        <div class="modal-footer">
            <center>
                <a href="#" id="btn_save_instruction" class="btn btn-primary">Save </a>
            </center>
        </div>
    </div>

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>DashBoard
                <%--<img src="<%= Page.ResolveClientUrl("~/image/logo.png") %>" />--%>
            </h1>
            <table border="0" cellpadding="10" cellspacing="5">
                <tr>
                    <td style="display: none">
                        <h5>Add Total Credit Choice For Current Semester</h5>
                    </td>
                    <td style="display: none">
                        <label id="creadit">
                            <input type="text" id="txtcreditchoice" />
                        </label>
                    </td>
                    <td style="width: 195px">
                        <button style="display: none" class="btn btn-primary" type="submit" id="btn_save">
                            Save
                        </button>
                    </td>
                    <td style="margin-left: 180px" align="right">
                        <%--<a href="<%= Page.ResolveClientUrl("~/Student/student_dashboard.aspx") %>" class="btn btn-sm btn-primary">--%>
                        <%--<a href="<%= Page.ResolveClientUrl("~/Student/Student_course_selection.aspx") %>" class="btn btn-sm btn-primary">
                            <span class="bigger-50">Go To Course Selection</span><i class="icon-on-right icon-arrow-right"></i>
                        </a>--%>
                        <a href="#" onclick="check_status()" class="btn btn-sm btn-primary">
                            <span class="bigger-50">Go To Course Selection</span><i class="icon-on-right icon-arrow-right"></i>
                        </a>

                    </td>
                    <td style="margin-left: 120px" align="right">
                        <a href="<%= Page.ResolveClientUrl("~/Student/calender.aspx") %>" class="btn btn-sm btn-primary">
                            <i class="icon-time"></i><span class="bigger-50">View Time Table</span> </a>
                    </td>
                    <td style="margin-left: 120px" align="right">
                        <a href="http://14.139.122.150/" target="_blank" class="btn btn-sm btn-primary">
                            <span class="bigger-50">Smart Card</span><i class="icon-on-right icon-arrow-right"></i> </a>
                    </td>
                    <td style="margin-left: 120px" align="right">
                        <a href="StudentUserManual.aspx" target="_blank" class="btn btn-sm btn-primary">
                            <span class="bigger-50">User Manual</span><i class="icon-on-right icon-arrow-right"></i>
                        </a>
                    </td>
                </tr>
            </table>
        </div>
        <div class="row">
            <div>
                <!-- PAGE CONTENT BEGINS -->
                <div class="row">
                    <div class="span4" style="margin-left: 50px">
                        <div class="widget-box">
                            <div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i>Registration Guideline : <a href="https://connect.cept.ac.in/ExcelFormatFiles/Registration_guide_Monsoon21.pdf" target="_blank" style="color: red;">Click Here</a>

                                </h4>
                                <h4 class="smaller" style="width: 212px !important">

                                    <i class=""></i>Insurance Card : <a href="#" onclick="Insurance_click()" style="color: red;">Click Here</a>
                                </h4>
                                <h4 class="smaller" style="margin-left: -90px;" id="campusdates">Dates for Campus Entry : <a href="#" onclick="CampusEntry('')" style="color: red;">Click Here</a>
                                </h4>
                                <h4 class="smaller" style="width: 218px !important">

                                    <span>Student ID Card :</span> <a href="#" onclick="student_id_click()" style="color: red;">Click Here</a>
                                </h4>

                            </div>
                            <br />
                         <!--   <div class="widget-header widget-header-flat" style="height: 66px;">
                                <h4 class="smaller">
                                    <i class=""></i>Shortlist / Allocation Status Studio Units 
                                </h4>
                                <br />
                                <a href="https://studioselection.cept.ac.in/shortlist-live-allocation-status" target="_blank" style="color: black; font-size: 15px; margin-left: 0px; float: left;">Click here to see the shortlist and allocation status</a>
                                <br />
                            </div> -->
						<div class="widget-header widget-header-flat" style="height: 66px;">
                                <h4 class="smaller">
                                    <i class=""></i>Shortlist / Allocation Status Studio Units 
                                </h4>
                                <br />
                                <a href="https://cept.ac.in/studio-selection/studio-live-allocation-status" target="_blank" style="color: black; font-size: 15px; margin-left: 0px; float: left;">Click here to see the shortlist and allocation status</a>
                                <br />
                            </div> 
                            <div class="widget-body">
                            </div>
                            <br />
                            <div id="validation_body">
                                <div class="widget-header widget-header-flat" id="validation_status">
                                    <h4 class="smaller">
                                        <i class=""></i>Mandatory Submission Status
                                    </h4>
                                </div>
                                <div class="widget-body">
                                    <div class="widget-main">
                                        <div class="row">
                                            <div id="validation_list" style="width: 85%; margin-left: 7%; font-weight: bold;">
                                            </div>
                                        </div>


                                    </div>
                                </div>

                                <br />
                            </div>
                            <div class="widget-header widget-header-flat">
                                <h4 class="smaller">
                                    <i class=""></i>Registration Status
                                </h4>
                            </div>
                            <div class="widget-body">
                                <div class="widget-main">
                                    <div class="row">
                                        <div style="margin-left: 25px">
                                            <p>
                                                <h5>You have selected/saved the following courses</h5>
                                            </p>
                                        </div>
                                        <div id="datalist_saved" style="margin-left: 15px; margin-right: 15px; display: none;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="datatable_saved" class="display table table-striped table-bordered table-hover"
                                                width="100%">
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
                                        <div>
                                            <h5 style="margin-left: 25px">Fees Status : <span id="lbl_fees_status"></span></h5>
                                            <div id="fees_installment_status">
                                            </div>
                                        </div> <h5 style="margin-left: 25px"> Fees Status Check : <a href="https://connect.cept.ac.in/Student/Fees_Status.aspx" style="color: blue;">Click Here</a></h5>
										
                                    </div>
                                    <b>
                                        <hr />
                                    </b>
                               <!--     <div class="row" id="view_vertical_studio" style="display: none">
                                        <div style="margin-left: 25px">
                                            <p>
                                                <h5>View Vertical Studio Unit Brief</h5>
                                            </p>
                                        </div>
                                        <div id="view_list_course_data_for_student" style="margin-left: 15px; margin-right: 15px; display: none;">
                                            <table cellpadding="0" cellspacing="0" border="0" id="view_course_data_for_student" class="display table table-striped table-bordered table-hover"
                                                width="100%">
                                                <thead>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
									-->
                                    <b id="view_line" style="display: none">
                                        <hr />
                                    </b>

                                    <div class="row">
                                        <div style="margin-left: 25px">
                                            <p>
                                                <h5>You have been assigned following Courses</h5>
                                            </p>
                                        </div>
                                        <div id="datalist_register" style="margin-left: 15px; margin-right: 15px; display: none">
                                            <table cellpadding="0" cellspacing="0" border="0" id="datatable_register" class="display table table-striped table-bordered table-hover">
                                                <thead>
                                                </thead>
                                                <tbody style="cursor: pointer;">
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                    <%--<div id="div_studio_grading_process" class="row" align="center">
                                        <a class="btn btn-small btn-primary" href="../Content/M2017_studio_grading_process.pdf" download>Monsoon 2017 Studio Grading Process</a>
                                    </div>--%>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="span7" style="margin-left: 40px">

                        <div class="row">
                            <div class="widget-header widget-header-flat">
                                <h4 class="smaller">Credits Completed</h4>
                                <input type="button" class="btn btn-small btn-primary" id="btn_credit_bifurcation" value="Credit Bifurcation" style="margin: 5px;" onclick="get_credit_bifurcation()" />
                            </div>
                            <div class="widget-body">
                                <table class="tbl_credits_dtl">
                                    <tr>
                                        <th></th>
                                        <th></th>
                                        <th>Total</th>
                                        <th>Mandatory Courses</th>
                                        <th>Elective Courses</th>
                                        <th>SWS Courses</th>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="col_header">Credits Required</td>
                                        <td id="td_total"></td>
                                        <td id="td_mandatory"></td>
                                        <td id="td_elective"></td>
                                        <td id="td_sws"></td>
                                        
                                        
                                    </tr>
                                    <tr>
                                      <td rowspan="2"><b>Monsoon / Spring</b></td>
                                        <td class="col_header">Credits Alloted</td>
                                        <td id="td_total_alloted"></td>
                                        <td id="td_mandatory_alloted"></td>
                                        <td id="td_elective_alloted"></td>
                                        <td id="td_sws_alloted_"></td>
                                        
                                    </tr>
                                    <tr>
                                        
                                        <td class="col_header">Credits Earned</td>
                                        <td id="td_total_earned"></td>
                                        <td id="td_mandatory_earned"></td>
                                        <td id="td_elective_earned"></td>
                                        <td id="td_sws_earned_"></td>
                                    </tr>
                                    <tr>
                                        <td rowspan="2"><b>SWS</b></td>
                                         <td class="col_header">Credits Alloted</td>
                                        <td id="td_sws_alloted"></td>
                                        <td id="td_sws_alloted_mandatory_credits"></td>
                                        <td id="td_sws_alloted_elective_credits"></td>
                                        <td id=""></td>
                                    </tr>
                                    <tr>
                                        
                                        <td class="col_header">Credits Earned</td>
                                        <td id="td_sws_earned"></td>
                                        <td id="td_sws_earned_mandatory_credits"></td>
                                        <td id="td_sws_earned_elactive_credits"></td>
                                        <td id=""></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="widget-header widget-header-flat" style="margin-top: 2%;">
                                <h4 class="smaller">SWS Parked Credits: <span id="sws_parked_credits"></span></h4>
                            </div>
                        </div>

                        <div class="space-6"></div>

                        <div class="row">
                            <div>
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">Step 1 Payment of Fees</h4>
                                        <%--<div class="widget-toolbar">
                                            <label>
                                                <small class="green"><b>Horizontal</b> </small>
                                                <input id="id-check-horizontal" type="checkbox" class="ace ace-switch ace-switch-6" />
                                                <span class="lbl"></span>
                                            </label>
                                        </div>--%>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <%--<code class="pull-right" id="dt-list-code">&lt;dl&gt;</code>--%>
                                            <%--<dt>Fees can be paid by one of the following three ways:
                                                <br />
                                                <br />
                                                1. Citrus Pay Payment Gateway: Net Banking/ Credit Debit card through online payment gateway.
                                                <br />
                                                2. EazyPay Payment Gateway: Net Banking, Credit Card, Debit Card, CASH/DD.
                                                <br />
                                                3. By printing auto-generated pay-in slip, and cash/demand draft payment at any ICICI bank branch in India. 
                                                Payment through pay-in slip, required to uploading of a counter copy (Institution copy) of pay-in-slip on the 
                                                portal by 16th July 2017 and submit the hard copy to your respective admin by 26th July 2017 for office records.
                                                <br />
                                                %--4. Cheque will be accepted while collecting the fees for this semester, subject to clearance , if returned, additional bank charges of Rs. 500/- will be charged.
                                                <br />--%
                                                <br />
                                                <b>Note: Charges for the different payment gateways are mentioned in the fees payment page.</b>
                                            </dt>
                                            <br />
                                            <dt>Please note that you would <u>not be able to save/register your courses without fee payment.</u></dt>
                                            
                                            <br />--%>

                                            <dt>
                                                <div id="div_loan_letter" runat="server" clientidmode="Static" style="display: none;">
                                                    <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" Text="Loan Letter" OnClick="Download_Student_Loan_Letter" />
                                                    &nbsp;Students seeking bonafide letter for bank loan installment disbursement, may click here.
                                                </div>
                                            </dt> 
											<dt>For Loan Letter, Please email to hansa.gohel@cept.ac.in to the finance department.
											</dt></br>
                                            <dt>Pay fees for quarter (5 cr) , Half (10 cr) or full fees (20 cr) . By paying full fees, other than
                                                mandatory you can choose elective from regular semester or SWS. You are allowed to take
                                                more credits in SWS (beyond 20 credits by paying extra fees)
                                            </dt>

                                            <br />

                                            <dt>Following payment options are available :</dt>

                                            <br />

                                            <dt style="margin-bottom: 5px;">A] Online</dt>

                                            <table class="table table-bordered cls_align_center">
                                                <thead>
                                                    <tr>
                                                        <th rowspan="2">Payment Gateway</th>
                                                        <th colspan="2">Netbanking</th>
                                                        <th colspan="2">Debit Card</th>
                                                        <th colspan="2">Credit Card</th>
                                                    </tr>
                                                    <tr>
                                                        <%--<th></th>--%>
                                                        <th>Available</th>
                                                        <th>Charges</th>
                                                        <th>Available</th>
                                                        <th>Charges</th>
                                                        <th>Available</th>
                                                        <th>Charges</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%--<tr>
                                                        <td>Citrus</td>
                                                        <td>Yes</td>
                                                        <td>Zero</td>
                                                        <td>Yes</td>
                                                        <td>1% plus applicable GST</td>
                                                        <td>Yes</td>
                                                        <td>1% plus applicable GST</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Eazypay</td>
                                                        <td>Yes</td>
                                                        <td>Rs. 10/- per Transaction</td>
                                                        <td>Yes</td>
                                                        <td>1% plus applicable GST</td>
                                                        <td>Yes</td>
                                                        <td>1.10% plus applicable GST</td>
                                                    </tr>--%>
                                                    <tr>
                                                        <td>Kotak</td>
                                                        <td>Yes</td>
                                                        <td>Zero</td>
                                                        <td>Yes</td>
                                                        <td>1% plus applicable GST</td>
                                                        <td>Yes</td>
                                                        <td>1% plus applicable GST</td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                            <br />

                                            <dt style="margin-bottom: 5px;">B] Offline - By printing auto-generated pay-in slip and visiting Bank</dt>
                                            <table class="table table-bordered cls_align_center">
                                                <thead>
                                                    <tr>
                                                        <th rowspan="2">Payment Gateway</th>
                                                        <!--<th colspan="2">Cash</th>-->
                                                        <th colspan="2">Demand Draft</th>
                                                        <th colspan="2">NEFT/RTGS</th>
                                                        <th rowspan="2">To be deposited at</th>
                                                    </tr>
                                                    <tr>
                                                        <%--<th></th>--%>
                                                        <!--<th>Available</th>
                                                        <th>Charges</th>-->
                                                        <th>Available</th>
                                                        <th>Charges</th>
                                                        <th>Available</th>
                                                        <th>Charges</th>
                                                        <%--<th></th>--%>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>ICICI</td>
                                                        <!--<td>Yes</td>
                                                        <td>Zero</td>-->
                                                        <td>Yes</td>
                                                        <td>Zero</td>
                                                        <td colspan="2">No</td>
                                                        <%--<td></td>--%>
                                                        <td>Any branch of ICICI Bank</td>
                                                    </tr>
                                                    <!--<tr>
                                                        <td>Eazypay</td>
                                                        <td>Yes</td>
                                                        <td>Rs. 50/- per transaction</td>
                                                        <td>Yes</td>
                                                        <td>Zero</td>
                                                        <td colspan="2">No</td>
                                                        <%--<td></td>--%>
                                                        <td>Any branch of ICICI Bank</td>
                                                    </tr>-->
                                                    <%--<tr>
                                                        <td>Yes Bank (NEFT)</td>
                                                        <!--<td colspan="2">No</td>
                                                        <%--<td></td>
                                                        <td colspan="2">No</td>
                                                        <%--<td></td>
                                                        <td>Yes</td>
                                                        <td>Zero</td>
                                                        <td>Your Bank</td>
                                                    </tr>--%>
                                                    <!--<tr>
                                                        <td>Kotak Bank</td>
                                                        <td>Yes</td>
                                                        <td>Rs. 20/- per transaction</td>
                                                        <td>Yes</td>
                                                        <td>Rs. 20/- per transaction</td>
                                                        <td colspan="2">No</td>
                                                        <%--<td></td>--%>
                                                        <td>Any branch of Kotak Bank</td>
                                                    </tr>-->
                                                    <tr>
                                                        <td>Kotak (NEFT/RTGS)</td>
                                                        <!--<td colspan="2">No</td>-->
                                                        <%--<td></td>--%>
                                                        <td colspan="2">No</td>
                                                        <%--<td></td>--%>
                                                        <td>Yes</td>
                                                        <td>Zero</td>
                                                        <td>-</td>
                                                    </tr>
                                                </tbody>
                                            </table>

                                            <br />

                                            <dt>Note : </dt>
                                            <dt>
                                                <ol>
                                                    <%--<li>Students opting for offline payment have to compulsorily upload the Payment proof along with DD copy on connect portal, as the they are needed to be approved by UG/ PG office. Only after the approval of UG/ PG office, student would be able to register.</li>
                                                    <li>Students opting to make payment through DD, needs to take auto generated Payslip of ICICI and deposit the same along with Cash or Demand Draft at the respective bank.</li>--%>
                                                    <li>Students opting for offline payment have to compulsorily upload the Payment proof along with DD copy on connect portal, as they are needed to be approved by UG/ PG office. Only after the approval of UG/ PG office, student would be able to register.</li>
                                                    <li>Students opting to make payment through DD, needs to take auto generated Payslip of ICICI and deposit the same along with Demand Draft at the respective bank.</li>
                                                    <li style="display: none;">
                                                        <div>Student opting to make payment through NEFT / RTGS can use YES BANK option and follow THE YES BANK tutorial below. You are required to generate a pay-in slip which contains all the necessary details as shown below. DO NOT reuse any other pay-slip as the details are custom generated per user.</div>

                                                        <table id="tbl_yes_bank_dtl" class="table table-condensed" border="1">
                                                            <tr>
                                                                <td style="width: 185px;">Bank Name
                                                                </td>
                                                                <td>YES BANK
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Beneficiary Name
                                                                </td>
                                                                <td>CEPT UNIVERSITY
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Beneficiary Account Number
                                                                </td>
                                                                <td>
                                                                    <label id="acc_no" runat="server" style="display: inline-block;"></label>
                                                                    <%--<span>(last <label id="digit" runat="server" style="display:inline-block;"></label> digits are your student code)</span>--%>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="border-right: none;"></td>
                                                                <td style="border-left: none;">(last
                                                                    <label id="digit" runat="server" style="display: inline;"></label>
                                                                    digits are your student code)</td>
                                                            </tr>
                                                            <tr>
                                                                <td>Branch Name
                                                                </td>
                                                                <td>CMS NOC MMR
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Branch Code
                                                                </td>
                                                                <td>Last six characters of IFSC Code represent Branch code
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Branch Address
                                                                </td>
                                                                <td>YES BANK TOWER IFC-2 8TH FLOOR SB MARG ELPHINSTONE MUMBAI 400013
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>Account Type
                                                                </td>
                                                                <td>SAVING
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>IFSC Code
                                                                </td>
                                                                <td>YESB0CMSNOC
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="border-right: none;"></td>
                                                                <td style="border-left: none;"><b>Read the 5th digit as numeric “Zero” and 10th digit as alpha “O”</b></td>
                                                            </tr>
                                                        </table>

                                                        <ul>
                                                            <li>Go to <span style="color: Red;">your bank</span> branch and  Ask for NEFT form</li>
                                                            <li>Fill in the beneficiary and IFSC Code above details, along with other details as required by your bank.</li>
                                                            <li>Depending upon your bank’s policy, you will be required to give cheque from your account.Your bank may collect additional charges.</li>
                                                            <li style="color: Red;">If you use wrong details (beneficiary account number & IFSC Code), the amount may initially get debited from your account but within two working days it will get re credited in your account and hence you will have to make payment to CEPT again</li>
                                                        </ul>
                                                    </li>
                                                </ol>
                                            </dt>

                                            <br />

                                            <dt>Dropping of Semester</dt>

                                            <dt style="margin-top: 5px;">
                                                <ul>
                                                    <%--<li>Students who wish to drop the semester after registration of courses should inform the concerned admin offices in writing before 21st August 2021. If you have not intimated your dropping of the semester you will be considered as a registered and bonafide student.</li>
                                                    <li>If you drop the semester after 21st August 2021 for any reason you will not be entitled to the refund of the fees that you have paid. Students who have opted for installment will forfeit the installment amount paid and they also have to pay the balance fees, if any before registering for the next semester.</li>--%>
                                                    <li>Students who wish to drop the semester after registration of courses should inform the concerned admin offices in writing before 13th Aug 2022, 5.00 pm (Sat). If you have not intimated your dropping of the semester you will be considered as a registered and bonafide student.</li>
                                                    <li>If you drop the semester after 13th Aug 2022, 5.00 pm (Sat) for any reason you will not be entitled to the refund of the fees that you have paid. Students who have opted for installment will forfeit the installment amount paid and they also have to pay the balance fees, if any before registering for the next semester.</li>
                                                </ul>
                                            </dt>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="space-6"></div>

                        <div class="row">
                            <div>
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">Step 2 Selection of Mandatory Courses</h4>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <dt>Go to the mandatory course selection page. You will see a list of mandatory courses for your
Faculty. Please select the mandatory courses you want to register by clicking on the courses.
Save your selection from the button given at the bottom of the page. You will also be able
to view the detailed course outline for each course.</b>
                                            </dt>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="space-6"></div>

                        <div class="row">
                            <div>
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">Step 3 Selection of Elective Courses</h4>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <dt>Go to the elective tab. Choose your electives here. You should select the electives of your
choice after reading the course outlines – which are available here. Please look carefully at
the prerequisite of a course before registering for it. You can select maximum 30 credits
(mandatory + elective). Based on the selection made in the elective course section, you
will have to mention the priority of the courses. Please note that the courses would be
offered to you based on the preference given by you.<br>
                                                Please note you would be allowed to drop electives till 6th Aug 2022, 5.00 pm (Sat). All the
courses appearing on your Dashboard after that (mandatory and electives) will appear
on your transcript with grades.
                                            </dt>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="space-6"></div>

                        <div class="row">
                            <div>
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">Step 4 Completing the Registration</h4>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <dt>All the information saved will appear under the tab “Confirm Courses” (mandatory and elective
courses selected and credit distribution). Please cross check once again and press the submit
button. You are registered for the course!</dt>

                                            <br />



                                            <dt style="display: none;">Please note the schedule of dropping of elective courses and changing GPA / Non GPA is as below:</dt>

                                            <table class="table table-bordered cls_align_center" style="margin-top: 5px; display: none;">
                                                <thead>
                                                    <tr>
                                                        <td></td>
                                                        <td><b>Last date for dropping electives</b></td>
                                                        <td><b>Last date for changing GPA/NGPA status</b></td>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td><b>For UG-FT & All PG</b></td>
                                                        <td><b>8th January 2018</b></td>
                                                        <td><b>19th January 2018</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td><b>For UG-FA/FD/FP (4th and 5th year students)</b></td>
                                                        <td><b>8th January 2018</b></td>
                                                        <td><b>19th January 2018</b></td>
                                                    </tr>
                                                    <tr>
                                                        <td><b>For UG-FA/FD/FP (1st, 2nd and 3rd year students)</b></td>
                                                        <td><b>19th January 2018</b></td>
                                                        <td><b>19th January 2018</b></td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="space-6"></div>
                        <div class="row" id="announcement_div" style="display:none;">
                            <div>
                                <div class="widget-box">
                                    <div class="widget-header widget-header-flat">
                                        <h4 class="smaller">Announcement</h4>
                                    </div>
                                    <div class="widget-body">
                                        <div class="widget-main">
                                            <dt>
                                                <ul id="announcement_dtl">
                                            </ul>
                                            </dt>
                                            
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
        <!-- /.row -->
    </div>
    <%--Start - Mayur 17/09/2018--%>
    <div id="ifrm_outline" style="display: none;"></div>
    <input type="hidden" id="hdn_course_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_sem_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    <div style="display: none;">
        <asp:Button ID="btn_download" runat="server" ClientIDMode="Static" Text="test" OnClick="Download_OutLine" />
    </div>
    <%--End - Mayur 17/09/2018--%>
</asp:Content>
