<%@ Page Title="Personal Details Edit" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="frm_edit_personal_details.aspx.cs" Inherits="Admin_Master_frm_personal_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/ckeditor2/ckeditor.js" type="text/javascript"></script>
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script type="text/javascript">

        var str = "<tr><td><input style='width: 202px;' type='text' class='degree'/></td> ";
        str += "<td><input style='width: 202px;' type='text' class='Institution'/></td> ";
        str += "<td><input style='width: 202px;' type='text' class='Field'/></td> ";
        str += "<td><input style='width: 50px;' type='text' maxlength='4' class='year_of_completion' onkeypress='return isNumber(event);'/></td> ";
        //str += "<td><input style='width: 200px; ' type='text' class='description'/></td> ";
        str += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

        //var str_course_taught = "<tr><td><input style='width: 600px;' type='text' class='course_taught'/></td> ";
        //str_course_taught += "<td><input style='width: 100px; ' type='text' class='semester_year'/></td> ";
        //str_course_taught += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

        $(document).ready(function () {
            //$('#tbleducation tbody').append(str);
            //$('#tblcoursetaught tbody').append(str_course_taught);
            //$('#txt_name').val('<%= Session["UserName"] %>');
            $('#txt_mail').val('<%= Session["email"] %>');
            disable_text();
            get_profile_details();
          
           
            if ($('#txt_name').val() == '' && $("#hdn_user_name").val() != '') {
                $('#txt_name').val($("#hdn_user_name").val());
            }
            $('#btn_education').on('click', function () {
                $('#tbleducation tbody').append(str);
                return false;
            });

            $('#tbleducation tbody tr td i.icon-trash').live('click', function (e) {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {

                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;
                }
            });

            $('#btn_course_taught').on('click', function () {
                var str_course_taught = "<tr><td><input style='width: 400px;' type='text' class='course_taught'/></td> ";
                str_course_taught += "<td><input style='width: 100px; ' type='text' class='semester_year'/></td> ";

                str_course_taught += "<td><input   checked='checked' name='new_" + $('#tblcoursetaught tbody tr').length + "' style='width: 100px; ' type='radio' class='rb_course_taught_area'/></td> ";
                str_course_taught += "<td><input   name='new_" + $('#tblcoursetaught tbody tr').length + "' style='width: 100px; ' type='radio' class='rb_course_taught_other'/></td> ";
                str_course_taught += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                $('#tblcoursetaught tbody').append(str_course_taught);
                return false;
            });

            $('#tblcoursetaught tbody tr td i.icon-trash').live('click', function (e) {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {

                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;
                }
            });

            $('#btn_area_of_expertise').on('click', function () {
                var str_area_of_expertise = "<tr><td><input style='width: 95%;' type='text' class='cls_area_of_expertise'/></td> ";
                str_area_of_expertise += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                $('#tblareaofexpertise tbody').append(str_area_of_expertise);
                return false;
            });


            $('#tblareaofexpertise tbody tr td i.icon-trash').live('click', function (e) {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {

                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;
                }
            });

            $('#btn_professional_affiliations').on('click', function () {
                var str_area_of_expertise = "<tr><td><input style='width: 95%;' type='text' class='cls_professional_affiliations'/></td> ";
                str_area_of_expertise += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                $('#tblProfessionalAffiliations tbody').append(str_area_of_expertise);
                return false;
            });


            $('#tblProfessionalAffiliations tbody tr td i.icon-trash').live('click', function (e) {
                var r = confirm("Are u sure you want to remove this?");
                if (r == true) {

                    var datalist = [];
                    var flag = 'Y';
                    var ob = {};
                    var thisdata = $(this).closest("tr");
                    $(this).closest("tr").remove();
                    var totalsum = 0;
                }
            });

            $('#btnsave').on('click', function () {
                var data = { image_path: '', supervisor_name: '', qualification: '', public_service: '', designation: '', department: '', area_of_interest: '', projects: '', capstone_project: '', contact: '', email: '', Background: '', office_location: '', research_articles_papers: '', presented_papers_and_invited_lectures: '', professional_honors: '', professional_affiliations: '', education_description: '', upload_cv_path: '' };

                if ($('#lbl_image_name').text().trim() != "") {
                    data.image_path = $('#lbl_image_name').text();
                }
                else {
                    //bootbox.alert('Please Upload Photo');
                    //return false;
                }

                data.qualification = $('#txt_qualification').val();

                data.public_service = $('#txt_public_service').val();

                if ($('#drp_type').val() != '') {
                    data.designation = $('#drp_type').val();
                }
                else {
                    //bootbox.alert('Please select designation');
                    //return false;
                }
                if ($('#txt_name').val().trim() == "") {
                    bootbox.alert('Please enter name');
                    return false;
                }
                else {
                    data.supervisor_name = $('#txt_name').val();
                }

                if ($('#drp_department').val().trim() == "") {
                    bootbox.alert('Please select department');
                    return false;
                }
                else {
                    data.department = $('#drp_department').val();
                }

                data.capstone_project = $('#txt_capstone_project').val().trim();
                data.contact = $('#txt_contact').val().trim();

                var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
                if (testEmail.test($('#txt_mail').val())) {
                    data.email = $('#txt_mail').val().trim();
                }
                else {
                    bootbox.alert("Please Enter Valid Email");
                    $('#txt_mail').focus();
                    return false;
                }

                data.upload_cv_path = $('#hdn_cv_upload').val();

                var education_data_list = [];

                $("#tbleducation tbody tr").each(function (j) {
                    var education_data = { 'degree': '', 'institution': '', 'field': '', 'year_of_completion': '', 'description': '' };

                    education_data.degree = $(this).find(".degree").val();
                    education_data.institution = $(this).find(".Institution").val();

                    education_data.field = $(this).find(".Field").val();
                    education_data.year_of_completion = $(this).find(".year_of_completion").val();
                    //education_data.description = $(this).find(".description").val();
                    education_data.description = "";

                    education_data_list.push(education_data);
                });

                var course_taught_data_list = [];

                $("#tblcoursetaught tbody tr").each(function (j) {
                    var course_taught_data = { 'course_name': '', 'semester_year': '', 'section': '' };

                    course_taught_data.course_name = $(this).find(".course_taught").val();
                    course_taught_data.semester_year = $(this).find(".semester_year").val();

                    course_taught_data.section = '';
                    if ($(this).find('.rb_course_taught_area:checked').val()) {

                        course_taught_data.section = "A";
                    }

                    if ($(this).find('.rb_course_taught_other:checked').val()) {

                        course_taught_data.section = "O";
                    }

                    course_taught_data_list.push(course_taught_data);
                });

                //if (CKEDITOR.instances.txt_education_description.getData() == "") {
                //}
                //else {
                //    data.education_description = CKEDITOR.instances.txt_education_description.getData();
                //}

                data.education_description = $('#txt_education_description').val().trim();

                //if (CKEDITOR.instances.txt_area.getData() == "") {
                //}
                //else {
                //  data.area_of_interest = CKEDITOR.instances.txt_area.getData();
                //}

                $("#tblareaofexpertise tbody tr").each(function (j) {
                    if (j != 0) {
                        data.area_of_interest += '~';
                    }
                    data.area_of_interest += $(this).find('.cls_area_of_expertise').val();
                });

                if (CKEDITOR.instances.txt_projects.getData() == "") {
                }
                else {
                    data.projects = CKEDITOR.instances.txt_projects.getData();
                }

                if (CKEDITOR.instances.txt_Background.getData() == "") {
                    //                    bootbox.alert('Please enter capstone background');
                    //                    return false;
                }
                else {
                    data.Background = CKEDITOR.instances.txt_Background.getData();
                }

                //data.Background = "";

                data.office_location = $('#txt_office_location').val().trim();

                if (CKEDITOR.instances.txt_articles_papers.getData() == "") {
                }
                else {
                    data.research_articles_papers = CKEDITOR.instances.txt_articles_papers.getData();
                }

                if (CKEDITOR.instances.txt_presented_papers_and_invited_lectures.getData() == "") {
                }
                else {
                    data.presented_papers_and_invited_lectures = CKEDITOR.instances.txt_presented_papers_and_invited_lectures.getData();
                }

                if (CKEDITOR.instances.txt_prof_honors.getData() == "") {
                }
                else {
                    data.professional_honors = CKEDITOR.instances.txt_prof_honors.getData();
                }

                //if (CKEDITOR.instances.txt_prof_affiliations.getData() == "") {

                //}
                //else {
                //    data.professional_affiliations = CKEDITOR.instances.txt_prof_affiliations.getData();
                //}


                $("#tblProfessionalAffiliations tbody tr").each(function (j) {
                    if (j != 0) {
                        data.professional_affiliations += '~';
                    }
                    data.professional_affiliations += $(this).find('.cls_professional_affiliations').val();
                });

                if (data.contact.search(/\\/) != -1) { data.contact = data.contact.replace(/\\/g, '\\\\'); }
                if (data.contact.search("\"") != -1) { data.contact = data.contact.replace(/"/g, '\\\"'); }

                if (data.education_description.search(/\\/) != -1) { data.education_description = data.education_description.replace(/\\/g, '\\\\'); }
                if (data.education_description.search("\"") != -1) { data.education_description = data.education_description.replace(/"/g, '\\\"'); }

                if (data.area_of_interest.search(/\\/) != -1) { data.area_of_interest = data.area_of_interest.replace(/\\/g, '\\\\'); }
                if (data.area_of_interest.search("\"") != -1) { data.area_of_interest = data.area_of_interest.replace(/"/g, '\\\"'); }

                if (data.projects.search(/\\/) != -1) { data.projects = data.projects.replace(/\\/g, '\\\\'); }
                if (data.projects.search("\"") != -1) { data.projects = data.projects.replace(/"/g, '\\\"'); }

                if (data.Background.search(/\\/) != -1) { data.Background = data.Background.replace(/\\/g, '\\\\'); }
                if (data.Background.search("\"") != -1) { data.Background = data.Background.replace(/"/g, '\\\"'); }

                if (data.research_articles_papers.search(/\\/) != -1) { data.research_articles_papers = data.research_articles_papers.replace(/\\/g, '\\\\'); }
                if (data.research_articles_papers.search("\"") != -1) { data.research_articles_papers = data.research_articles_papers.replace(/"/g, '\\\"'); }

                if (data.presented_papers_and_invited_lectures.search(/\\/) != -1) { data.presented_papers_and_invited_lectures = data.presented_papers_and_invited_lectures.replace(/\\/g, '\\\\'); }
                if (data.presented_papers_and_invited_lectures.search("\"") != -1) { data.presented_papers_and_invited_lectures = data.presented_papers_and_invited_lectures.replace(/"/g, '\\\"'); }

                if (data.professional_honors.search(/\\/) != -1) { data.professional_honors = data.professional_honors.replace(/\\/g, '\\\\'); }
                if (data.professional_honors.search("\"") != -1) { data.professional_honors = data.professional_honors.replace(/"/g, '\\\"'); }

                if (data.professional_affiliations.search(/\\/) != -1) { data.professional_affiliations = data.professional_affiliations.replace(/\\/g, '\\\\'); }
                if (data.professional_affiliations.search("\"") != -1) { data.professional_affiliations = data.professional_affiliations.replace(/"/g, '\\\"'); }

                var prof_details = [data, education_data_list, course_taught_data_list];

                var json_data = JSON.stringify(prof_details).replace(/\'/g, '\\\'\\\'');

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_profile_data",
                    data: "{'profile_detail' : '" + json_data + "'}",
                    dataType: "json",
                    success: function (data) {
                        //bind_grid();
                        
                        if (data.d != '') {

                            if (data.d == "Email") {
                                bootbox.alert("your Email Id is not match with your Login Email id.");
                            }
                            else {
                                bootbox.alert(data.d);
                            }
                        }
                        return false;
                    },
                    error: function (data) {
                        alert(data.d);
                        return false;
                    }
                });
            });

            $('#btnSubmit').on('click', function () {
                var data = { image_path: '', supervisor_name: '', qualification: '', public_service: '', designation: '', department: '', area_of_interest: '', projects: '', capstone_project: '', contact: '', email: '', Background: '', office_location: '', research_articles_papers: '', presented_papers_and_invited_lectures: '', professional_honors: '', professional_affiliations: '', education_description: '' };

                if ($('#lbl_image_name').text().trim() != "") {
                    data.image_path = $('#lbl_image_name').text();
                }
                else {
                    //bootbox.alert('Please Upload Photo');
                    //return false;
                }
                if ($('#drp_type').val() != '') {
                    data.designation = $('#drp_type').val();
                }
                else {
                    bootbox.alert('Please select designation');
                    return false;
                }
                if ($('#txt_name').val().trim() == "") {
                    bootbox.alert('Please enter name');
                    return false;
                }
                else {
                    data.supervisor_name = $('#txt_name').val();
                }

                //if ($('#txt_qualification').val().trim() == "") {
                //    bootbox.alert('Please enter qualification');
                //    return false;
                //}
                //else {
                data.qualification = $('#txt_qualification').val();
                //}

                data.public_service = $('#txt_public_service').val();

                if ($('#drp_department').val().trim() == "") {
                    bootbox.alert('Please select department');
                    return false;
                }
                else {
                    data.department = $('#drp_department').val();
                }

                data.capstone_project = $('#txt_capstone_project').val().trim();

                if ($('#txt_contact').val().trim() != "") {
                    //if ($('#txt_contact').val().length < 10) {
                    //    bootbox.alert('Please enter 10 digit phone number.');
                    //    return false;
                    //}
                }

                data.contact = $('#txt_contact').val().trim();

                if ($('#txt_mail').val().trim() == "") {
                    bootbox.alert('Please enter mail');
                    return false;
                }

                var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
                if (testEmail.test($('#txt_mail').val())) {
                    data.email = $('#txt_mail').val().trim();
                }
                else {
                    bootbox.alert("Please Enter Valid Email");
                    $('#txt_mail').focus();
                    return false;
                }

                var education_data_list = [];
                var ed_flag = 'Y';

                $("#tbleducation tbody tr").each(function (j) {
                    var education_data = { 'degree': '', 'institution': '', 'field': '', 'year_of_completion': '', 'description': '' };

                    education_data.degree = $(this).find(".degree").val();
                    education_data.institution = $(this).find(".Institution").val();

                    education_data.field = $(this).find(".Field").val();
                    education_data.year_of_completion = $(this).find(".year_of_completion").val();
                    //education_data.description = $(this).find(".description").val();
                    education_data.description = "";

                    education_data_list.push(education_data);
                });

                if (education_data_list.length > 0) {
                    for (var i = 0; i < education_data_list.length; i++) {

                        if (education_data_list[i]['degree'] == '') {
                            ed_flag = 'N';
                            bootbox.alert('Please Enter education Degree');
                            return false;
                        }
                        if (education_data_list[i]['institution'] == '') {
                            ed_flag = 'N';
                            bootbox.alert('Please Enter education Institution');
                            return false;
                        }
                        if (education_data_list[i]['field'] == '') {
                            ed_flag = 'N';
                            bootbox.alert('Please Enter education field');
                            return false;
                        }

                        if (education_data_list[i]['year_of_completion'] == '') {
                            ed_flag = 'N';
                            bootbox.alert('Please Enter education Year of Completion');
                            return false;
                        }
                    }
                }
                else {
                    ed_flag = 'N';
                    bootbox.alert('Please Enter education details');
                    return false;
                }

                if (CKEDITOR.instances.txt_education_description.getData() == "") {
                    bootbox.alert('Please enter brief description of education work');
                    return false;
                }
                else {
                    data.education_description = CKEDITOR.instances.txt_education_description.getData();
                }

                if (CKEDITOR.instances.txt_area.getData() == "") {
                    bootbox.alert('Please enter area');
                    return false;
                }
                else {
                    data.area_of_interest = CKEDITOR.instances.txt_area.getData();
                }

                if (CKEDITOR.instances.txt_projects.getData() == "") {
                    bootbox.alert('Please enter projects');
                    return false;
                }
                else {
                    data.projects = CKEDITOR.instances.txt_projects.getData();
                }

                if (CKEDITOR.instances.txt_Background.getData() == "") {
                    //bootbox.alert('Please enter capstone background');
                    //return false;
                }
                else {
                    data.Background = CKEDITOR.instances.txt_Background.getData();
                }

                //data.Background = "";

                data.office_location = $('#txt_office_location').val().trim();

                //if ($('#txt_office_location').val().trim() == "") {
                //    bootbox.alert('Please enter office location');
                //    return false;
                //}

                if (CKEDITOR.instances.txt_articles_papers.getData() == "") {
                    bootbox.alert('Please enter research articles, presented papers, invited lectures, etc.');
                    return false;
                }
                else {
                    data.research_articles_papers = CKEDITOR.instances.txt_articles_papers.getData();
                }

                if (CKEDITOR.instances.txt_presented_papers_and_invited_lectures.getData() == "") {
                    bootbox.alert('Please enter Presented Papers and Invited Lectures, etc.');
                    return false;
                }
                else {
                    data.presented_papers_and_invited_lectures = CKEDITOR.instances.txt_presented_papers_and_invited_lectures.getData();
                }

                if (CKEDITOR.instances.txt_prof_honors.getData() == "") {
                    bootbox.alert('Please enter professional honors, prizes fellowships');
                    return false;
                }
                else {
                    data.professional_honors = CKEDITOR.instances.txt_prof_honors.getData();
                }

                if (CKEDITOR.instances.txt_prof_affiliations.getData() == "") {
                    bootbox.alert('Please enter professional affiliations');
                    return false;
                }
                else {
                    data.professional_affiliations = CKEDITOR.instances.txt_prof_affiliations.getData();
                }

                if (data.contact.search(/\\/) != -1) { data.contact = data.contact.replace(/\\/g, '\\\\'); }
                if (data.contact.search("\"") != -1) { data.contact = data.contact.replace(/"/g, '\\\"'); }

                if (data.education_description.search(/\\/) != -1) { data.education_description = data.education_description.replace(/\\/g, '\\\\'); }
                if (data.education_description.search("\"") != -1) { data.education_description = data.education_description.replace(/"/g, '\\\"'); }

                if (data.area_of_interest.search(/\\/) != -1) { data.area_of_interest = data.area_of_interest.replace(/\\/g, '\\\\'); }
                if (data.area_of_interest.search("\"") != -1) { data.area_of_interest = data.area_of_interest.replace(/"/g, '\\\"'); }

                if (data.projects.search(/\\/) != -1) { data.projects = data.projects.replace(/\\/g, '\\\\'); }
                if (data.projects.search("\"") != -1) { data.projects = data.projects.replace(/"/g, '\\\"'); }

                if (data.Background.search(/\\/) != -1) { data.Background = data.Background.replace(/\\/g, '\\\\'); }
                if (data.Background.search("\"") != -1) { data.Background = data.Background.replace(/"/g, '\\\"'); }

                if (data.research_articles_papers.search(/\\/) != -1) { data.research_articles_papers = data.research_articles_papers.replace(/\\/g, '\\\\'); }
                if (data.research_articles_papers.search("\"") != -1) { data.research_articles_papers = data.research_articles_papers.replace(/"/g, '\\\"'); }

                if (data.presented_papers_and_invited_lectures.search(/\\/) != -1) { data.presented_papers_and_invited_lectures = data.presented_papers_and_invited_lectures.replace(/\\/g, '\\\\'); }
                if (data.presented_papers_and_invited_lectures.search("\"") != -1) { data.presented_papers_and_invited_lectures = data.presented_papers_and_invited_lectures.replace(/"/g, '\\\"'); }

                if (data.professional_honors.search(/\\/) != -1) { data.professional_honors = data.professional_honors.replace(/\\/g, '\\\\'); }
                if (data.professional_honors.search("\"") != -1) { data.professional_honors = data.professional_honors.replace(/"/g, '\\\"'); }

                if (data.professional_affiliations.search(/\\/) != -1) { data.professional_affiliations = data.professional_affiliations.replace(/\\/g, '\\\\'); }
                if (data.professional_affiliations.search("\"") != -1) { data.professional_affiliations = data.professional_affiliations.replace(/"/g, '\\\"'); }

                var prof_details = [data, education_data_list];
                if (ed_flag == 'Y') {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/save_profile_data",
                        data: "{'profile_detail' : '" + JSON.stringify(prof_details) + "'}",
                        dataType: "json",
                        success: function (data) {
                            //bind_grid();
                            if (data.d != '') {

                                if (data.d == "Email") {
                                    bootbox.alert("your Email Id is not match with your Login Email id.");
                                }
                                else {
                                    bootbox.alert(data.d);
                                }
                            }
                            return false;
                        },
                        error: function (data) {
                            alert(data.d);
                            return false;
                        }
                    });
                }
            });

           
        });
         // call By Nitinbhai 27072021
        function disable_text() {
            var user_type = $("#hdn_user_type").val();
            
            if (user_type == "TA") {
                $('#txt_capstone_project').attr('disabled', true);
                $('#drp_type').attr('disabled', true);
                $('#txt_name').attr('disabled', true);
                $('#drp_department').attr('disabled', true);
                $('#txt_contact').attr('disabled', true);
                $('#txt_office_location').attr('disabled', true);
                $('#txt_public_service').attr('disabled', true);

            }
        }
        function get_profile_details() {
            $.ajax({
                type: "POST",
                url: "../../WebService.asmx/get_personal_details",
                data: "{instructor_code :''}",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                async: false,
                success: function (data) {
                    if (data.d[0] != null)
                    {
                        var p_details = JSON.parse(data.d[0]);

                        $('#txt_qualification').val(p_details[0]["qualification"]);
                        $('#txt_public_service').val(p_details[0]["public_service"]);
                        $('#drp_type').val(p_details[0]["designation"]);
                        $('#drp_department').val(p_details[0]["department"]);
                        $('#txt_education_description').val(p_details[0]["education_description"]);
                        $('#txt_articles_papers').val(p_details[0]["research_articles_papers"]);
                        $('#txt_presented_papers_and_invited_lectures').val(p_details[0]["presented_papers_and_invited_lectures"]);
                        //$('#txt_area').html('');

                        if (p_details[0]["supervisor_name"] != '') {
                            $('#txt_name').val(p_details[0]["supervisor_name"]);
                        }
                        

                        if (p_details[0]["area_of_interest"] != '') {

                            var a = p_details[0]["area_of_interest"].split('~');
                            for (var i = 0; i < a.length; i++) {
                                var str_area_of_expertise = "<tr><td><input style='width: 95%;' type='text' class='cls_area_of_expertise'/></td> ";
                                str_area_of_expertise += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                                $('#tblareaofexpertise tbody').append(str_area_of_expertise);

                            }

                            $("#tblareaofexpertise tbody tr").each(function (j) {
                                for (var i = 0; i < a.length; i++) {
                                    if (j == i) {
                                        $(this).find(".cls_area_of_expertise").val(a[i]);

                                    }
                                }
                            });
                        }

                        $('#txt_projects').val(p_details[0]["projects"]);
                        $('#txt_contact').val(p_details[0]["contact"]);
                        $('#txt_Background').val(p_details[0]["Background"]);
                        $('#txt_office_location').val(p_details[0]["office_location"]);
                        $('#txt_articles_papers').val(p_details[0]["research_articles_papers"]);
                        $('#txt_prof_honors').val(p_details[0]["professional_honors"]);
                        //$('#txt_prof_affiliations').val(p_details[0]["professional_affiliations"]);

                        if (p_details[0]["professional_affiliations"] != '') {
                            var a = p_details[0]["professional_affiliations"].split('~');
                            for (var i = 0; i < a.length; i++) {
                                var str_professional_affiliations = "<tr><td><input style='width: 95%;' type='text' class='cls_professional_affiliations'/></td> ";
                                str_professional_affiliations += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                                $('#tblProfessionalAffiliations tbody').append(str_professional_affiliations);
                            }

                            $("#tblProfessionalAffiliations tbody tr").each(function (j) {
                                for (var i = 0; i < a.length; i++) {
                                    if (j == i) {
                                        $(this).find(".cls_professional_affiliations").val(a[i]);

                                    }
                                }
                            });
                        }

                        $('#txt_capstone_project').val(p_details[0]["capstone_project"])

                        if (p_details[0]["cv_path"] != '') {
                            $('#lbl_cv_upload').text('file uploaded');
                            $('#hdn_cv_upload').val(p_details[0]["cv_path"]);
                        }

                        if (p_details[0]["image_path"] != "") {
                            $("#img_photo").attr("src", "../../UserPersonalPhoto/" + p_details[0]["image_path"] + "?" + (new Date()).getTime());
                            $('#lbl_image_name').text(p_details[0]["image_path"]);
                        }
                        else { $("#img_photo").attr("src", "../../UserPersonalPhoto/" + 'profile_' + '<%= Session["UserId"] %>' + '.jpg');}
                        document.getElementById("imageUpload").disabled = false;
                    }
                    if (data.d[1] != null) {
                        var E_details = JSON.parse(data.d[1]);
                        $("#tbleducation tbody").html('');

                        for (var i = 0; i < E_details.length; i++) {
                            $('#tbleducation tbody').append(str);
                        }

                        $("#tbleducation tbody tr").each(function (j) {
                            for (var i = 0; i < E_details.length; i++) {
                                if (j == i) {
                                    $(this).find(".degree").val(E_details[i]["degree"]);
                                    $(this).find(".Institution").val(E_details[i]["institution"]);
                                    $(this).find(".Field").val(E_details[i]["field"]);
                                    $(this).find(".year_of_completion").val(E_details[i]["year_of_completion"]);
                                    //$(this).find(".description").val(E_details[i]["description"]);
                                }
                            }
                        });
                    }

                    if (data.d[2] != null) {
                        var CT_details = JSON.parse(data.d[2]);
                        $("#tblcoursetaught tbody").html('');

                        for (var i = 0; i < CT_details.length; i++) {
                            var str_course_taught = "<tr><td><input style='width: 400px;' type='text' class='course_taught'/></td> ";
                            str_course_taught += "<td><input style='width: 100px; ' type='text' class='semester_year'/></td> ";

                            str_course_taught += "<td><input   checked='checked' name='" + CT_details[i]["semester_year"] + '_' + i + "' style='width: 100px; ' type='radio' class='rb_course_taught_area'/></td> ";
                            str_course_taught += "<td><input   name='" + CT_details[i]["semester_year"] + '_' + i + "' style='width: 100px; ' type='radio' class='rb_course_taught_other'/></td> ";
                            str_course_taught += "<td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td></tr>";

                            $('#tblcoursetaught tbody').append(str_course_taught);
                        }

                        $("#tblcoursetaught tbody tr").each(function (j) {
                            for (var i = 0; i < CT_details.length; i++) {
                                if (j == i) {
                                    $(this).find(".course_taught").val(CT_details[i]["course_name"]);
                                    $(this).find(".semester_year").val(CT_details[i]["semester_year"]);

                                    if (CT_details[i]["section"] == 'A') {

                                        $(this).find(".rb_course_taught_area").attr('checked', 'checked');
                                    }
                                    else if (CT_details[i]["section"] == 'O') {
                                        $(this).find(".rb_course_taught_other").attr('checked', 'checked');
                                    }
                                    else {
                                        $(this).find(".rb_course_taught_area").attr('checked', 'checked');
                                    }
                                }
                            }
                        });
                    }
                    if (data.d[0] == null) {
                        $("#img_photo").attr("src", "../../UserPersonalPhoto/" + 'profile_' + '<%= Session["UserId"] %>' + '.jpg');
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        function UploadProfilePhoto() {
            try {
                var fileToUpload = GetFileNameFromPath($('#imageUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/Instructor_photo_upload.ashx',
                                secureuri: false,
                                fileElementId: 'imageUpload',
                                dataType: 'json',
                                data: { name: name },
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#imageUpload').val("");

                                            bootbox.alert("Photo Uploaded Successfully");
                                            FileName = data.upfile;
                                            $("#img_photo").attr("src", "../../UserPersonalPhoto/" + FileName + "?" + (new Date()).getTime());
                                            //$("#img_photo").attr("alt", FileName);
                                            //$('#lbl_image_name').text("UserProfilePhoto/" + FileName);
                                            $('#lbl_image_name').text(FileName);
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    alert('Invalid File Type. Please upload .jpeg file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        //Check User Photo Extension
        function CheckUserPhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'jpg':
                    case 'jpeg':
                    case 'JPG':
                    case 'JPEG':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function UploadCV() {
            try {
                var fileToUpload = GetFileNameFromPath($('#CVUpload').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserCVExtension(fileToUpload)) {
                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/FacultyProfile_CV_Upload.ashx',
                                secureuri: false,
                                fileElementId: 'CVUpload',
                                dataType: 'json',
                                data: { name: name },
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#CVUpload').val("");
                                            //FileName = data.upfile;
                                            $('#hdn_cv_upload').val(data.upfile);
                                            $('#lbl_cv_upload').text('file uploaded');
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    alert('Invalid File Type. Please upload .pdf file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        //Check User Photo Extension
        function CheckUserCVExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'pdf':
                    case 'PDF':
                    case 'Pdf':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        //Get File Name From Path
        function GetFileNameFromPath(strFilepath) {
            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return strName[0];
            }
        }

        function fnWordCount() { }

        function isNumber(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>

    <style type="text/css">
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
        .wysiwyg_viewer_skins_button_BasicButtonb1-link
        {
            border-radius: 0px;
            position: absolute;
            top: 0px;
            bottom: 0px;
            left: 0px;
            right: 0px;
            background-color: rgb(102, 102, 102);
            transition: border-color 0.4s ease 0s, background-color 0.4s ease 0s;
            -webkit-transition: border-color 0.4s ease 0s, background-color 0.4s ease 0s;
            box-shadow: rgba(0, 0, 0, 0.6) 0px 1px 4px 0px;
        }
        .wysiwyg_viewer_skins_button_BasicButtonb1-label
        {
            font: normal normal normal 13px/1.3em arial, 'ｍｓ ｐゴシック' , 'ms pgothic' , 돋움, dotum, helvetica, sans-serif;
            transition: color 0.4s ease 0s;
            -webkit-transition: color 0.4s ease 0s;
            color: rgb(255, 255, 255);
            white-space: nowrap;
            margin: 0px;
            display: inline-block;
            position: relative;
        }
        .required
        {
            color: Red;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="panel panel-default " id="my_print_outline">
            <div class="tabbable">
                <%-- <ul class="nav nav-tabs">
                        <li class="active"><a style="border-top: 2px solid rgb(159,155,27);" href="#InsertEditRace"
                            data-toggle="tab"><b>Profile</b></a> </b> </li>
                    </ul>--%>
                <div class="row" style="padding-bottom: 5px; padding-left: 75px;">
                    <div class="col-md-3">
                        <img id="img_photo" ng-model="data.image" src="UserProfilePhoto/Default_Avtar.png"
                            alt="" style="max-width: 125px; min-width: 125px; min-height: 125px; max-height: 125px;"
                            class="img-thumbnail" />
                        <label id="lbl_img" class="btn btn-primary file-upload " style="vertical-align: bottom;">
                            <span><strong>Upload Photo</strong></span>
                            <input type="file" name="imageUpload" id="imageUpload" onchange="javascript:return UploadProfilePhoto();" />
                        </label><br />
                        <%--<span style="font-size: 11px;" class="msg_gray">(Please upload a photo taken in full
                                    face view facing the camera with both eyes open. Maximum 200 KB. <span class="required"> *</span> )</span>--%>
                        <label id="lbl_image_name" style="display:none;" ng-model="data.image_name">
                        </label>
                        <input type="hidden" id="hdn_doc" ng-model="data.doc_no" />
                    </div>
                </div>
                <div id="Div2" class="tab-pane active" style="padding-left: 75px;">
                    <table width="100%" cellpadding="10" cellspacing="50">
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Name<span class="required"> *</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_name" ng-model="data.supervisor_name" placeholder="Full Name" />
                                        <span style="color: red" ng-show="name.$dirty && name.$invalid">   <%--//1--%>
                                    </div>
                                </div>
                            </td>
                            <td style="display: none;">
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Qualification<span class="required"> *</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_qualification" ng-model="data.qualification" placeholder="Qualification"
                                             />      <%--//2--%>
                                    </div>
                                    <%-- <label>{{ name +' '+ qualification }}</label>--%>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Designation<span class="required"> *</span>
                                    </label>
                                    <div class="controls">
                                        <select id="drp_type" ng-model="data.designation"><%--//3--%>
                                            <option value="Adjunct Professor">Adjunct Professor</option>
                                            <option value="Adjunct Assistant Professor">Adjunct Assistant Professor</option>
                                            <option value="Adjunct Associate Professor">Adjunct Associate Professor</option>
                                            <option value="Assistant Professor">Assistant Professor</option>
                                            <option value="Associate Professor">Associate Professor</option>
                                            <%--<option value="Dean">Dean</option>--%>
                                            <option value="Coordinator">Coordinator</option>
                                            <option value="Director">Director</option>
                                            <option value="President">President</option>
                                            <option value="Professor">Professor</option>
                                            <option value="Visiting Faculty">Visiting Faculty</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="drpcountry">
                                        Link to personal web page
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_capstone_project" ng-model="data.capstone_project" placeholder="Link to personal web page" />
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtdob">
                                        Faculty/Organisation<span class="required"> *</span>
                                    </label>
                                    <div class="controls">
                                        <select id="drp_department" ng-model="data.department">
                                            <option value=''>-- Please Select Depatment --</option>
                                            <%-- <option ng-repeat="x in department" ng-bind="x.dept_name">{{x.dept_code}} </option>--%>
                                            <option value="Architecture">Architecture</option>
                                            <option value="Design">Design</option>
                                            <option value="Management">Management</option>
                                            <option value="Planning">Planning</option>
                                            <option value="Technology">Technology</option>
                                            <option value="University">University</option>
                                            <option value="Others">Others</option>
                                            <option value="CEPT_Shor_Term_Program">CEPT Short Term Program</option>
                                        </select>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Phone number
                                    </label>
                                    <div class="controls">
                                        <%-- <input maxlength="10" type="text" id="txt_contact" ng-model="data.contact" placeholder="Phone number"
                                                onkeypress="return isNumber(event)" />--%>
                                        <input type="text" id="txt_contact" ng-model="data.contact" placeholder="Phone number"
                                             /> <%--//4--%>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="txtfullname">
                                        Email<span class="required"> *</span>
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_mail" ng-model="data.email" placeholder="email" disabled  />
                                    </div>   <%--//5--%>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="control-group">
                                    <label class="control-label" for="drpcountry">
                                        Office Location
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_office_location" ng-model="data.office_location" placeholder=""
                                             /><%--//6--%>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <div class="control-group">
                                    <label class="control-label">
                                        Institutional Roles
                                    </label>
                                    <div class="controls">
                                        <input type="text" id="txt_public_service" placeholder=""/> <%--//7--%>
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan='2'>
                                <div class="control-group">
                                    <label class="control-label" for="drpcountry">
                                        Upload CV
                                    </label>
                                    <label id="Label1" class="btn btn-primary file-upload " style="vertical-align: bottom;
                                        float: left;">
                                        <span><strong>Upload CV</strong></span>
                                        <input type="file" name="CVUpload" id="CVUpload" onchange="javascript:return UploadCV();" /></label>
                                    <label style="float: left;" id="lbl_cv_upload">
                                    </label>
                                    <input style="clear: both;" type="hidden" id="hdn_cv_upload" />
                                </div>
                            </td>
                        </tr>
                    </table>
                    <div class="panel panel-default" style="width: 92%;">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Education</span></strong></div>
                        <div class="row-fluid" id="dataList_instructor" style="margin-top: 15px; margin-bottom: 15px;
                            margin-left: 10px; width: 97%; display: block;">
                            <div class="box-content box-no-padding">
                                <button class="btn  btn-primary" type="button" id="btn_education">
                                    <i class="icon-plus"></i>&nbsp;Add Education
                                </button>
                            </div>
                            <table class="data-table table table-bordered table-striped" border="0" id="tbleducation">
                                <thead>
                                    <tr>
                                        <th>
                                            Degree
                                        </th>
                                        <th>
                                            Institution
                                        </th>
                                        <th>
                                            Field
                                        </th>
                                        <th>
                                            Year of Completion
                                        </th>
                                        <th>
                                            Delete
                                        </th>
                                        <%--  <th>
                                                Brief description of education work
                                            </th>--%>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="panel panel-default" style="width: 92%;">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Courses Taught in the Areas of Expertise</span></strong></div>
                        <div class="row-fluid" id="Div1" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px;
                            width: 97%; display: block;">
                            <div class="box-content box-no-padding">
                                <button class="btn  btn-primary" type="button" id="btn_course_taught">
                                    <i class="icon-plus"></i>&nbsp;Add Course Taught
                                </button>
                            </div>
                            <table class="data-table table table-bordered table-striped" border="0" id="tblcoursetaught">
                                <thead>
                                    <tr>
                                        <th>
                                            Course Name
                                        </th>
                                        <th>
                                            Semester
                                        </th>
                                        <th>
                                            Courses Taught in Area of Expertise
                                        </th>
                                        <th>
                                            Other Course Taught
                                        </th>
                                        <th>
                                            Delete
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td>
                                    Brief Description (Education & Work Profile)<%--<span class="required"> *</span>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="control-group">
                                        <div>
                                            <textarea id="txt_education_description" ng-model="data.education_description" style="width: 91%;
                                                height: 110px" rows="3" cols="50" name="address"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <%--  <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td>
                                    Areas of Expertise
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="control-group">
                                        <div>
                                            <textarea class="ckeditor" id="txt_area" ng-model="data.area_of_interest" style="width: 98%;
                                                height: 110px" rows="3" cols="50" name="address"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>--%>
                    <div class="panel panel-default" style="width: 92%;">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Areas of Expertise</span></strong></div>
                        <div class="row-fluid" id="Div3" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px;
                            width: 97%; display: block;">
                            <div class="box-content box-no-padding">
                                <button class="btn  btn-primary" type="button" id="btn_area_of_expertise">
                                    <i class="icon-plus"></i>&nbsp;Add Areas of Expertise
                                </button>
                            </div>
                            <table class="data-table table table-bordered table-striped" border="0" id="tblareaofexpertise">
                                <thead>
                                    <tr>
                                        <th>
                                            Areas of Expertise
                                        </th>
                                        <th>
                                            Delete
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td>
                                    <%--Research/Design Projects (completed/ongoing) (From Latest)<span class="required"> *</span>--%>
                                    Research/ Design Projects in Areas of Expertise (From Latest last 5 year)
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="control-group">
                                        <div>
                                            <textarea class="ckeditor" id="txt_projects" ng-model="data.projects" style="width: 98%;
                                                height: 110px" rows="3" cols="50" name="address"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table style="display: none;" cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td>
                                    Background (Brief Resume 100 word max)<%--<span class="required"> *</span>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="control-group">
                                        <div>
                                            <textarea class="ckeditor" id="txt_Background" ng-model="data.Background" style="width: 98%;
                                                height: 110px" rows="3" cols="50" name="address"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td>
                                    <%--Research Articles, Presented Papers, Invited Lectures, etc.(Please use APA 6th edition format only) (From Latest)<span class="required"> *</span>--%>
                                    Research Articles and Book Chapters in Areas of Expertise(Please use APA 6th edition
                                    format only) (From Latest)
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="control-group">
                                        <div>
                                            <textarea class="ckeditor" id="txt_articles_papers" ng-model="data.articles_papers"
                                                style="width: 98%; height: 110px" rows="3" cols="50" name="address"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td>
                                    Presented Papers and Invited Lectures in Areas of Expertise (last 5 year)
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="control-group">
                                        <div>
                                            <textarea class="ckeditor" id="txt_presented_papers_and_invited_lectures" style="width: 98%;
                                                height: 110px" rows="3" cols="50" name="address"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td>
                                    Professional Honors, Prizes , Fellowships (From Latest)<%--<span class="required"> *</span>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="control-group">
                                        <div>
                                            <textarea class="ckeditor" id="txt_prof_honors" ng-model="data.prof_honors" style="width: 98%;
                                                height: 110px" rows="3" cols="50" name="address"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <%-- <table cellpadding="0" cellspacing="0" width="100%">
                        <tbody>
                            <tr>
                                <td>
                                    Professional Affiliations
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="control-group">
                                        <div>
                                            <textarea class="ckeditor" id="txt_prof_affiliations" ng-model="data.prof_affiliations"
                                                style="width: 98%; height: 110px" rows="3" cols="50" name="address"></textarea>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="required">* Feilds are mandatory</span>
                                </td>
                            </tr>
                        </tbody>
                    </table>--%>
                    <div class="panel panel-default" style="width: 92%;">
                        <div class="panel-heading">
                            <strong><span class="panel-headingfont">Professional Affiliations</span></strong></div>
                        <div class="row-fluid" id="Div4" style="margin-top: 15px; margin-bottom: 15px; margin-left: 10px;
                            width: 97%; display: block;">
                            <div class="box-content box-no-padding">
                                <button class="btn  btn-primary" type="button" id="btn_professional_affiliations">
                                    <i class="icon-plus"></i>&nbsp;Add Professional Affiliations
                                </button>
                            </div>
                            <table class="data-table table table-bordered table-striped" border="0" id="tblProfessionalAffiliations">
                                <thead>
                                    <tr>
                                        <th>
                                            Professional Affiliations
                                        </th>
                                        <th>
                                            Delete
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <%--</div>--%>
                </div>
            </div>
        </div>
    </div>
    <br />
    <br />
    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1057px; height: 40px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                    <table style="width: 1057px;">
                        <tr>
                            <td align="center">
                                <button id="btnsave" type="button" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
        <input type="hidden" id="hdn_user_name" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_user_type" runat="server" clientidmode="Static" />
    </div>
</asp:Content>
