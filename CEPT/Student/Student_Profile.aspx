<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Student_Profile.aspx.cs" Inherits="Student_Student_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .img-thumbnail
        {
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

        .file-upload input
        {
            position: absolute;
            top: 0;
            left: 0;
            margin: 0;
            font-size: 10pt;
            opacity: 0;
        }
    </style>
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script type="text/javascript">
        var count = 1;
        //var str = "<tr><td><span style='width: 202px;' type='text' class='degree'></span></td> ";
        //str += "<td><span style='width: 202px;' type='text' class='Institution'></span></td> ";
        //str += "<td><span style='width: 202px;' type='text' class='university'></span></td> ";
        //str += "<td><span style='width: 50px;' type='text' maxlength='4' class='year_of_completion' onkeypress='return isNumber(event);'></span></td> ";

        $(document).ready(function () {
            get_Student_personal_data();

            $('#btnsave').click(function () {

                var obj_data = {};

                if ($('#txt_first_name').val() == "") {
                    alert("First Name required ");
                    return false;
                }
                if ($('#txt_last_name').val() == "") {
                    alert("Last Name required ");
                    return false;
                }
                obj_data.first_name = $('#txt_first_name').val();
                obj_data.middle_name = $('#txt_middle_name').val();
                obj_data.last_name = $('#txt_last_name').val();
                if ($('#drop_bloodgroup').val() == "") {
                    obj_data.blood_group = "";
                } else {
                    obj_data.blood_group = $('#drop_bloodgroup').val();
                }


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../WebService.asmx/save_student_profile",
                    async: false,
                    data: "{str_req_data:'" + JSON.stringify(obj_data) + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var response = JSON.parse(data.d);

                            if (response['status'] == 'true') {
                                bootbox.alert(response['message'], function () {
                                    location.reload();
                                }); 
                               // bootbox.alert(response['message']);
                                return false;

                            }
                            else if (response['status'] == 'false') {
                                bootbox.alert(response['message']);
                                return false;
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            });
        });

        function get_Student_personal_data() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../WebService.asmx/get_Studentpersonal_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d[0] != "") {
                        var personldata = JSON.parse(data.d[0]);
                        $('#txt_first_name').val(personldata[0].first_name);
                        $('#txt_middle_name').val(personldata[0].middle_name);
                        $('#txt_last_name').val(personldata[0].last_name);
                        $('#drop_bloodgroup').val(personldata[0].blood_group);
                        var temp_dob = personldata[0].dob.split(" ");
                        $('#txt_date_of_birth').html(temp_dob[0]);
                        $('#drpyear').html(personldata[0].year_desc);
                        $('#drpprog').html(personldata[0].prog_desc);
                        $('#login_email').html(personldata[0].mail);
                        if (personldata[0].profile_photo != null && personldata[0].profile_photo != "")
                            $('#img_photo').attr("src", personldata[0].profile_photo);
                    }
                    if (data.d[1] != null) {
                        eductionbindata(data.d[1]);
                    }
                    if (data.d[2] != null) {
                        contactdatabind(data.d[2]);
                    }
                    //if (data.d[3] != null) {
                    //    workexperience(data.d[3]);
                    //}
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function contactdatabind(data) {
            var contactdata = JSON.parse(data);
            $('#txt_home_address1').html(contactdata[0].applicant_address_house_no);
            $('#txt_home_city').html(contactdata[0].applicant_address_city);
            $('#txt_home_pincode').html(contactdata[0].applicant_address_pincode);
            $('#txt_phone_no').html(contactdata[0].applicant_mobile_no);
            $('#applicant_email_id').html(contactdata[0].applicant_email_id);
            $('#applicant_mobile_no').html(contactdata[0].applicant_mobile_no);

            $('#preferred_mailing_address_house_no').html(contactdata[0].preferred_mailing_address_house_no);
            $('#preferred_mailing_address_city').html(contactdata[0].preferred_mailing_address_city);
            $('#preferred_mailing_address_pincode').html(contactdata[0].preferred_mailing_address_pincode);

            $('#guardian_name').html(contactdata[0].guardian_name);
            $('#guardian_address_house_no').html(contactdata[0].guardian_address_house_no);
            $('#guardian_address_pincode').html(contactdata[0].guardian_address_pincode);
            $('#guardian_address_city').html(contactdata[0].guardian_address_city);
            $('#guardian_mobile_no').html(contactdata[0].guardian_mobile_no);
            $('#guardian_email_id').html(contactdata[0].guardian_email_id);

        }

        function eductionbindata(data) {
            var E_details = JSON.parse(data);
            $("#tbleducation tbody").html('');

            for (var i = 0; i < E_details.length; i++) {
                var str_edu = "<tr><td><span style='width: 202px;' type='text' class='degree'></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='Institution'></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='university'></span></td> ";
                str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='year_of_completion' onkeypress='return isNumber(event);'></span></td> ";

                $('#tbleducation tbody').append(str_edu);
                count++;
            }

            $("#tbleducation tbody tr").each(function (j) {
                for (var i = 0; i < E_details.length; i++) {
                    if (j == i) {
                        $(this).find(".degree").html(E_details[i].degree_type);
                        $(this).find(".Institution").html(E_details[i].education_institution);
                        $(this).find(".university").html(E_details[i].education_university_type);
                        $(this).find(".year_of_completion").html(E_details[i].education_passing_year);
                    }
                }
            });
        }

        function workexperience(data) {
            var E_details = JSON.parse(data);
            $("#tblworkexp tbody").html('');

            for (var i = 0; i < E_details.length; i++) {

                var str_edu = " <tr><td><span style='width: 202px;' type='text' class='orgname'></span></td> ";
                str_edu += " <td><span style='width: 202px;' type='text' class='desgnname'></span></td> ";
                str_edu += " <td><span style='width: 202px;' type='text' class='resp'></span></td> ";

                $('#tblworkexp tbody').append(str_edu);
                //count++;
            }

            $("#tblworkexp tbody tr").each(function (j) {
                for (var i = 0; i < E_details.length; i++) {
                    if (j == i) {
                        $(this).find(".orgname").html(E_details[i].experience_organization_name);
                        $(this).find(".desgnname").html(E_details[i].experience_designation);
                        $(this).find(".resp").html(E_details[i].experience_major_job_responsibility);
                    }
                }
            });
        }

        $(document).ready(function () {
            if (getParameterByName("dtl") == 'inc') {
                bootbox.alert('Please fill your personal detail before you register your courses.', function () {
                    location.replace('Student_Profile.aspx');
                });
            }
        });

        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Personal Detail
            </h1>
        </div>
        <div>
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Personal Detail</strong>
                      <button class="btn btn-primary" type="button" id="btnsave" style="margin-left:80%; border:0px ;padding :0px 24px 1px"; >
                                    Save
                                </button>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_personal_detail1" style="width: 100%;">
                        <tr>
                            <td style="width: 20%;">First Name <span style="color:red">*</span>
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_first_name" />
                            </td>
                            <td style="width: 20%;">Middle Name
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_middle_name" />
                            </td>
                            <td rowspan="3">
                                <img id="img_photo" src="../UserProfilePhoto/avatar-placeholder.png"
                                    alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;"
                                    class="img-thumbnail" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Last Name<span style="color:red">*</span>
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_last_name" />
                            </td>

                            <td style="width: 20%;">Blood Group</td>
                            <td style="width: 30%;">
                                <%--<input type="text" id="txt_blood_group" /></td>--%>
                                <select id="drop_bloodgroup">
                                    <option value=""><---- Select Blood Group -----></option>
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
                            <td style="width: 20%;">Date of Birth</td>
                            <td style="width: 30%;">
                                <span id="txt_date_of_birth"></span></td>
                            <td style="width: 20%;">Email Id
                            </td>
                            <td style="width: 30%;">
                                <%-- <input type="text" id="login_email" disabled />--%>
                                <span id="login_email"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Year of Enrollment
                            </td>
                            <td>
                                <%--<select id="drpyear">
                                </select>--%>
                                <span id="drpyear"></span>
                            </td>
                            <td style="width: 20%;">Program Title
                            </td>
                            <td style="width: 30%;">
                                <%--<select id="drpprog">
                                </select>--%>
                                <span id="drpprog"></span>
                            </td>
                        </tr>
                        <tr id="tr_txt_other_prog" style="display: none;">
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <input type="text" id="txt_other_prog" />
                            </td>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                        </tr>
                        <tr>

                            <%-- <td style="width: 20%;">Alternate Email Id
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="alternate_email" />
                            </td>--%>
                        </tr>
                        <%--<tr>
                            <td>Photograph
                                <br />
                                (use a white background. This photograph will be used for the ID card)</td>
                            <td colspan="3">
                                <div class="row" style="padding: 15px;">
                                    <div class="col-lg-12">
                                        <img id="img_photo" ng-model="data.image" src="/../../image/Avtar_1.jpg"
                                            alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;"
                                            class="img-thumbnail" />
                                        <label id="lbl_img" class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                            <span><strong>Upload Photo</strong></span>
                                            <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadPhoto();" /></label><br />
                                        <label id="lbl_image_name" style="display: none" ng-model="data.image_name">
                                        </label>
                                    </div>
                                </div>
                            </td>
                        </tr>--%>
                    </table>

                </div>
            </div>

            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Contact Details</strong>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_communication_preferences" class="data-table table table-bordered table-striped" style="width: 100%;">

                        <%--  <tr>
                            <td style="padding: 15px 0 15px 0;" colspan="4">
                                <div style="border: 1px solid #ddd;">
                                </div>
                            </td>
                        </tr>--%>
                        <%--<tr>
                            <td>Home Address</td>
                            <td>
                                <input type="text" id="txt_home_address" />
                            </td>
                            <td>Home City</td>
                            <td>
                                <input type="text" id="txt_home_city" />
                            </td>
                        </tr>--%>

                        <tr style="display: none;">
                            <td>Home Address
                            </td>
                            <td colspan="3">
                                <textarea id="txt_home_address" rows="2" style="width: 86%"></textarea>
                            </td>

                        </tr>
                        <%--<tr>
                            <td colspan="4">
                                <strong>Home address/Permanent Address</strong>
                            </td>
                        </tr>--%>

                        <tr>
                            <td>Address
                            </td>
                            <td colspan="1">
                                <span id="txt_home_address1" style="width: 86%"></span>
                            </td>
                        </tr>
                        <%-- <tr>
                            <td>Line 2 
                            </td>
                            <td colspan="3">
                                <textarea id="txt_home_address2" rows="2" style="width: 86%"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Line 3
                            </td>
                            <td colspan="3">
                                <textarea id="txt_home_address3" rows="2" style="width: 86%"></textarea>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>City
                            </td>
                            <td>
                                <span type="text" id="txt_home_city"></span>
                            </td>

                        </tr>
                        <%-- <tr>
                            <td>Country
                            </td>
                            <td>

                                <select id="txt_home_country">
                                </select>
                            </td>
                            <td>State
                            </td>
                            <td>
                                <input type="text" id="txt_home_state" />
                                <select id="drp_home_state" style="display: none;">
                                </select>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>PinCode
                            </td>
                            <td>
                                <span type="text" id="txt_home_pincode"></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Phone No
                            </td>
                            <td style="width: 30%;">
                                <span id="txt_phone_no"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Email
                            </td>
                            <td>
                                <span type="text" id="applicant_email_id"></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Phone No
                            </td>
                            <td style="width: 30%;">
                                <span id="applicant_mobile_no"></span>
                            </td>
                        </tr>
                    </table>

                    <div class="panel-heading">
                        <strong>Preferred Correspondence Address</strong>
                    </div>

                    <table id="Table1" class="data-table table table-bordered table-striped" style="width: 100%;">
                         
                        <tr>
                            <td>Address
                            </td>
                            <td colspan="1">
                                <span  type="text" id="preferred_mailing_address_house_no" style="width: 86%"></span>
                            </td>
                        </tr>

                        <tr>
                            <td>City
                            </td>
                            <td>
                                <span id="preferred_mailing_address_city"></span>
                            </td>

                        </tr>

                        <tr>
                            <td>PinCode
                            </td>
                            <td>
                                <span type="text" id="preferred_mailing_address_pincode"></span>
                            </td>
                        </tr>
                    </table>
                    <div class="panel-heading">
                        <strong>Emergency Contact Details</strong>
                    </div>
                    <table id="Table2" class="data-table table table-bordered table-striped" style="width: 100%;">

                        <%--  <tr>
                            <td style="padding: 15px 0 15px 0;" colspan="4">
                                <div style="border: 1px solid #ddd;">
                                </div>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>Name of Contact Person</td>
                            <td>
                                <span id="guardian_name"></span>
                            </td>
                        </tr>

                        <%--<tr>
                            <td colspan="4">
                                <strong>Home address/Permanent Address</strong>
                            </td>
                        </tr>--%>

                        <tr>
                            <td>Address
                            </td>
                            <td colspan="1">
                                <span id="guardian_address_house_no" style="width: 86%"></span>
                            </td>
                        </tr>
                        <%-- <tr>
                            <td>Line 2 
                            </td>
                            <td colspan="3">
                                <textarea id="txt_home_address2" rows="2" style="width: 86%"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>Line 3
                            </td>
                            <td colspan="3">
                                <textarea id="txt_home_address3" rows="2" style="width: 86%"></textarea>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>City
                            </td>
                            <td>
                                <span type="text" id="guardian_address_city"></span>
                            </td>

                        </tr>
                        <%-- <tr>
                            <td>Country
                            </td>
                            <td>

                                <select id="txt_home_country">
                                </select>
                            </td>
                            <td>State
                            </td>
                            <td>
                                <input type="text" id="txt_home_state" />
                                <select id="drp_home_state" style="display: none;">
                                </select>
                            </td>
                        </tr>--%>
                        <tr>
                            <td>PinCode
                            </td>
                            <td>
                                <span type="text" id="guardian_address_pincode"></span>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Phone No
                            </td>
                            <td style="width: 30%;">
                                <span id="guardian_mobile_no"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>Email
                            </td>
                            <td>
                                <span type="text" id="guardian_email_id"></span>
                            </td>
                        </tr>


                    </table>

                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong><span class="panel-headingfont">Education</span></strong>
                </div>
                <div class="row-fluid" id="dataList_instructor" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">

                    <table class="data-table table table-bordered table-striped" border="0" id="tbleducation">
                        <thead>
                            <tr>
                                <th>Degree Name
                                </th>
                                <th>Institution
                                </th>
                                <th>University
                                </th>
                                <th>Year of Graduation
                                </th>

                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="panel panel-default" style="display:none;">
                <div class="panel-heading">
                    <strong><span class="panel-headingfont">Work Experience</span></strong>
                </div>
                <div class="row-fluid" id="Div1" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px; width: 97%; display: block;">

                    <table class="data-table table table-bordered table-striped" border="0" id="tblworkexp">
                        <thead>
                            <tr>
                                <th>Organization Name
                                </th>
                                <th>Designation
                                </th>
                                <th>Responsibility
                                </th>

                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

