var oTable;
var count = 1;
var asInitVals = new Array();
$(document).ready(function () {
    $("#header").css("display", "none");
    //binddepartment();
    //bindyeardata();
    //bindprogrammedata();
    //bindsemdata();
    //bindstudent();
    
    
    if ($('#hdn_icode').val() == 'undefined' || $('#hdn_icode').val() == undefined) {
    }
    else if ($('#hdn_icode').val() != '') {
        debugger;
        get_Student_personal_data_profile($('#hdn_icode').val());
    }
    
    function get_Student_personal_data_profile(stud_code) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/get_TA_instructor_data",
            async: false,
            data: "{instructor_code:'" + $('#hdn_icode').val() + "',sem_code:'" + $('#hdn_isem').val() + "',year_code:'" + $('#hdn_iyear').val() + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d[0] != "") {

                    var personldata = JSON.parse(data.d[0]);
                    //$('#txt_first_name').val(personldata[0].first_name);
                    //$('#txt_middle_name').val(personldata[0].middle_name);
                    //$('#txt_last_name').val(personldata[0].last_name);
                    $('#txt_full_name').html(personldata[0].first_name + ' ' + personldata[0].last_name);
                    $('#drop_bloodgroup').html(personldata[0].blood_group);
                    var temp_dob = personldata[0].dob.split(" ");
                    $('#txt_date_of_birth').html(temp_dob[0]);
                    $('#drppyear').html(personldata[0].year_desc);
                    $('#drppprog').html(personldata[0].prog_desc);
                    $('#login_email').html(personldata[0].mail);
                    $('#text_award').html(personldata[0].achievements);
                    $('#text_areas').html(personldata[0].area_of_interest);
                    $('#text_brief').html(personldata[0].edu_work_description);


                    $('#txt_bank_account_no').html(personldata[0].bank_account_number);
                    $('#txt_account_type').html(personldata[0].account_type);
                    $('#txt_name_bank').html(personldata[0].name_of_Bank);
                    $('#txt_branch_name').html(personldata[0].branch_name);
                    $('#txt_ifsc_code').html(personldata[0].ifsc_code);

                    $('#txt_nationality').html(personldata[0].country);
                    $('#txt_passport_no').html(personldata[0].passport_no);
                    $('#txt_hig_qua').html(personldata[0].highest_qualification);
                    $('#txt_total_experience').html(personldata[0].total_experiance);
                    $('#txt_gst_no').html(personldata[0].gst_number);
                    $('#txt_aadhar_no').html(personldata[0].aadhaar_no);
                    $('#txt_coa_reg_no').html(personldata[0].coa_registration_no);

                    $('#txt_home_address1').html(personldata[0].permanent_address.replace('@#',' '));
                    $('#txt_home_city').html(personldata[0].city);
                    $('#txt_phone_no').html(personldata[0].mobile_no);
                    $('#guardian_name').html(personldata[0].emergency_contact_name);
                    $('#guardian_mobile_no').html(personldata[0].emergency_contact_number);
                    


                    if (personldata[0].profile_photo != null && personldata[0].profile_photo != "") {
                       //$('#img_photo').attr("src", "../" + personldata[0].profile_photo);
                        $("#img_photo").attr("src", "../../UserPersonalPhoto/" + personldata[0].profile_photo + "?" + (new Date()).getTime());
                    } else {
                        $('#img_photo').attr("src", "../../UserProfilePhoto/Default_Avtar.png" + "?" + (new Date()).getTime());
                    }

                }
                if (data.d[1] != null) {
                    eductionbindata(data.d[1]);
                }
                if (data.d[2] != null) {
                    debugger
                    contactdatabind(data.d[2]);
                    
                }
                $('#DataList').css('display', 'none');
                $('#Student_Profile').css('display', 'block');
                $("#header").css("display", "block");
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
        var studio_string = '';
        var course_string = '';
        for (var i = 0; i < contactdata.length; i++)
        {
            if (contactdata[i]["apply_type"] == '23')
            {
                if (studio_string == "")
                {
                    studio_string += contactdata[i]["dept_name"];
                }
                else
                {
                    studio_string += " , " + contactdata[i]["dept_name"];
                }
            }
            else if (contactdata[i]["apply_type"] == '24') {
                if (course_string == "") { course_string += contactdata[i]["dept_name"]; }
                else { course_string += " , " + contactdata[i]["dept_name"]; }
            }
            
            

        }
        $('#apply_course').html(course_string);
        $('#apply_studio').html(studio_string);

        $('#txt_home_address1').html(contactdata[0].permanent_address);
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
        $("#tblworkexp tbody").html('');
        $("#tblreferences tbody").html('');
        debugger;
        for (var i = 0; i < E_details.length; i++) {
            if (E_details[i].detail_type == "education")
            {
                var str_edu = "<tr><td><span style='width: 202px;' type='text' class='degree_" + E_details[i].sr_no +" '></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='specialization_" + E_details[i].sr_no +"'></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='university_" + E_details[i].sr_no +"'></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='edu_start_date_" + E_details[i].sr_no +"'></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='edu_end_date_" + E_details[i].sr_no +"'></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='edu_type_" + E_details[i].sr_no +"'></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='edu_percentage_" + E_details[i].sr_no +"'></span></td> ";
                str_edu += "<td><span style='width: 202px;' type='text' class='edu_mode_" + E_details[i].sr_no +"'></span></td> ";
                $('#tbleducation tbody').append(str_edu);
                
            }
            if (E_details[i].detail_type == "work")
            {
                var str_work = "<tr><td><span style='width: 202px;' type='text' class='work_institute_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='work_designation_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='work_experience_type_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='work_start_date_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='work_end_date_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='work_experience_months_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='work_mode_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='work_week_per_hours_" + E_details[i].sr_no +"'></span></td> ";
                $('#tblworkexp tbody').append(str_work);

            }
            if (E_details[i].detail_type == "reference") {
                var str_work = "<tr><td><span style='width: 202px;' type='text' class='referee_name_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='referee_mobile_no_" + E_details[i].sr_no +"'></span></td> ";
                str_work += "<td><span style='width: 202px;' type='text' class='referee_email_id_" + E_details[i].sr_no +"'></span></td> ";
                $('#tblreferences tbody').append(str_work);

            }

        }

        $("#tbleducation tbody tr").each(function (j) {
            for (var i = 0; i < E_details.length; i++) {
                if (E_details[i].detail_type == "education") {

                
                 
                    $(this).find(".degree_" + E_details[i].sr_no +"").html(E_details[i].degree);
                    $(this).find(".specialization_" + E_details[i].sr_no +"").html(E_details[i].specialization);
                    $(this).find(".university_" + E_details[i].sr_no +"").html(E_details[i].university);
                    $(this).find(".edu_start_date_" + E_details[i].sr_no +"").html(E_details[i].edu_start_date);
                    $(this).find(".edu_end_date_" + E_details[i].sr_no +"").html(E_details[i].edu_end_date);
                    $(this).find(".edu_type_" + E_details[i].sr_no +"").html(E_details[i].edu_type);
                    $(this).find(".edu_percentage_" + E_details[i].sr_no +"").html(E_details[i].edu_percentage);
                    $(this).find(".edu_mode_" + E_details[i].sr_no +"").html(E_details[i].edu_mode);
                    
                }

                

            }
        });


        $("#tblworkexp tbody tr").each(function (j) {
            for (var i = 0; i < E_details.length; i++) {
                if (E_details[i].detail_type == "work") {


                   
                    $(this).find(".work_institute_" + E_details[i].sr_no +"").html(E_details[i].work_institute);
                    $(this).find(".work_designation_" + E_details[i].sr_no +"").html(E_details[i].work_designation);
                    $(this).find(".work_experience_type_" + E_details[i].sr_no +"").html(E_details[i].work_experience_type);
                    $(this).find(".work_start_date_" + E_details[i].sr_no +"").html(E_details[i].work_start_date);
                    $(this).find(".work_end_date_" + E_details[i].sr_no +"").html(E_details[i].work_end_date);
                    $(this).find(".work_experience_months_" + E_details[i].sr_no +"").html(E_details[i].work_experience_months);
                    $(this).find(".work_mode_" + E_details[i].sr_no +"").html(E_details[i].work_mode);
                    $(this).find(".work_week_per_hours_" + E_details[i].sr_no +"").html(E_details[i].work_week_per_hours);
                    
                }

            }
        });

        $("#tblreferences tbody tr").each(function (j) {
            for (var i = 0; i < E_details.length; i++) {
                if (E_details[i].detail_type == "reference") {



                    $(this).find(".referee_name_" + E_details[i].sr_no +"").html(E_details[i].referee_name);
                    $(this).find(".referee_mobile_no_" + E_details[i].sr_no +"").html(E_details[i].referee_mobile_no);
                    $(this).find(".referee_email_id_" + E_details[i].sr_no +"").html(E_details[i].referee_email_id);

                }

            }
        });
    }
    $('#txt_modified_on').datepicker({ dateFormat: 'dd/mm/yy' });

    $('#btnreterive').on('click', function () {

        $('#DataList').css('display', 'none');

        var stud_code = $('#drp_student_code').val();
        var dept_code = "";
        var year_code = "";
        var prog_code = "";
        var semester_type = "";
        var year_semester = "";
        var modified_on = "";

        if (stud_code == "") {
            dept_code = $('#drpdepartment').val();
            if (dept_code == "") {
                bootbox.alert('Please select department')
                $('#drpdepartment').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            prog_code = $('#drpprog').val();

            semester_type = $('#drpsemester').val();
            year_semester = $('#drp_year_semester').val();

            if (semester_type != '' && year_semester == '') {
                bootbox.alert('Please select Year Semester')
                $('#drp_year_semester').focus();
                return false;
            }
            else if (semester_type == '' && year_semester != '') {
                bootbox.alert('Please select Semester')
                $('#drpsemester').focus();
                return false;
            }

            modified_on = $('#txt_modified_on').val();
            if (modified_on != '') {
                if (semester_type == '') {
                    bootbox.alert('Please select Semester')
                    $('#drpsemester').focus();
                    return false;
                }
                else if (year_semester == '') {
                    bootbox.alert('Please select Year Semester')
                    $('#drp_year_semester').focus();
                    return false;
                }
                else {
                    modified_on = convertDateFormat($('#txt_modified_on').val());
                    if (modified_on == '') {
                        bootbox.alert('Please Enter valid Date');
                        return false;
                    }
                }
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_user_data",
                data: "{dept_code:'" + dept_code + "',prog_code:'" + prog_code + "',year_code:'" + year_code + "',semester_type:'" + semester_type + "',year_semester:'" + year_semester + "',modified_on:'" + modified_on + "',stud_code:'" + stud_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_student_data(data.d);
                    } else {
                        alert("Student Details Not Found");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });


        } else {
            get_Student_personal_data_profile(stud_code);
        }
        return false;
    });

    var button = document.getElementById("button");
    var makepdf = document.getElementById("makepdf");

    button.addEventListener("click", function () {
        html2pdf().from(makepdf).save();
    });

});



function convertDateFormat(str_date) {
    if (str_date != '') {
        if (str_date.split('/').length == 3) {
            var date_split = str_date.split('/');
            var temp_date = new Date(date_split[1] + '/' + date_split[0] + '/' + date_split[2]);
            if (temp_date.toString() == 'Invalid Date') {
                bootbox.alert('Please Enter Date in valid format');
                return '';
            }
            else {
                return '' + (temp_date.getMonth() + 1) + '/' + temp_date.getDate() + '/' + temp_date.getFullYear();
            }
        }
        else {
            bootbox.alert('Please Enter Date in valid format');
            return '';
        }
    }
    else
        return str_date;
}

function display_student_data(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": true,
        "bStateSave": false,
        "bSort": false,
        "iDisplayLength": 30,
        //"sDom": 't',
        //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //"sDom": 'T<"clear">lfrtip',
        //"oTableTools": {
        //    "aButtons": [
        //		"copy",
        //		"print",
        //		{
        //			"sExtends": "collection",
        //			"sButtonText": 'Export',
        //			"aButtons": ["xls", "pdf"]
        //		}
        //    ]
        //},
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "First Name", "mData": "first_name", "bSortable": false },
            { "sTitle": "Middle Name", "mData": "middle_name", "bSortable": false },
            { "sTitle": "Last Name", "mData": "last_name", "bSortable": false },
            { "sTitle": "Program", "mData": "prog_code", "bSortable": false },
            { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
            { "sTitle": "Program Level", "mData": "prog_level_code", "bSortable": false },
            { "sTitle": "Year of Enrollement", "mData": "year_desc", "bSortable": false },
            { "sTitle": "Email", "mData": "mail", "bSortable": false },
            { "sTitle": "Alternat Email", "mData": "alternet_mail", "bSortable": false },
            { "sTitle": "Gender", "mData": "gender", "bSortable": false },
            //{ "sTitle": "Guardian No", "mData": "phone_no", "bSortable": false },
            //{ "sTitle": "Guardian Name", "mData": "guardian_contact_name", "bSortable": false },
            { "sTitle": "Blood Group", "mData": "blood_group", "bSortable": false },
            { "sTitle": "DOB", "mData": "dob", "bSortable": false },
            //{ "sTitle": "Mother/Father's Name", "mData": "father_name", "bSortable": false },
            //{ "sTitle": "Mother/Father's Contact No", "mData": "father_contact_no", "bSortable": false },
            //{ "sTitle": " Mother/Father's Email Id", "mData": "father_email", "bSortable": false },
            //{ "sTitle": "Emergency No", "mData": "mobile_no", "bSortable": false },
            //{ "sTitle": "Emergency Name", "mData": "emergency_contact_name", "bSortable": false },
            //{ "sTitle": " Relation with Emergency Contact", "mData": "relationship_with_emergency_contact", "bSortable": false },
            //{ "sTitle": " Emergency Contact's Email Id", "mData": "guardian_email", "bSortable": false },
            //{ "sTitle": " guardian_email", "mData": "guardian_email", "bSortable": false },
            { "sTitle": " Applicant Landline No", "mData": "applicant_landline_no", "bSortable": false },
            { "sTitle": " Applicant Mobile No", "mData": "applicant_mobile_no", "bSortable": false },
            { "sTitle": " Preferred Mailing Address House No", "mData": "preferred_mailing_address_house_no", "bSortable": false },
            { "sTitle": " State", "mData": "state_name", "bSortable": false },
            { "sTitle": " Guardian Name", "mData": "guardian_name", "bSortable": false },
            { "sTitle": " Guardian Address House No", "mData": "guardian_address_house_no", "bSortable": false },
            { "sTitle": " Guardian Landline No", "mData": "guardian_landline_no", "bSortable": false },
            { "sTitle": " Guardian Mobile No", "mData": "guardian_mobile_no", "bSortable": false },
            { "sTitle": " Guardian Email Id", "mData": "guardian_email_id", "bSortable": false },
            { "sTitle": " Registration Status", "mData": "status", "bSortable": false },
            { "sTitle": " Modified Date", "mData": "modified_date", "bSortable": false },
            { "sTitle": " Reservation Category", "mData": "category_desc", "bSortable": false }
        ]
    });

    var thead = $('<tr class="dt"></tr>');
    $('#example thead th').each(function (i, r) {
        var nm = $('#example thead th').eq($(this).index()).text();
        thead.append('<th></th>');
    });
    $('#example thead').append(thead);

    //adding input box in thead second row 
    for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
        var title = $('#example thead th').eq(i).text();
        $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
    };

    $("thead input").keyup(function () {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("thead input").index(this));
    });

    $("thead input").each(function (i) {
        asInitVals[i] = this.value;
    });

    $("thead input").focus(function () {
        if (this.className == "search_init") {
            this.className = "";
            this.value = "";
        }
    });

    $("thead input").blur(function (i) {
        if (this.value == "") {
            this.className = "search_init";
            this.value = asInitVals[$("thead input").index(this)];
        }
    });


    $('#DataList').css('display', 'block');
    $('#Student_Profile').css('display', 'none');
    $("#header").css("display", "block");
    $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
}

function bindyeardata() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_year_data",
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                $('#drp_year_semester').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                for (var i = 0; i < year_data.length; i++) {
                    $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                    $('#drp_year_semester').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                }

                $('#drpyear').chosen();
                $('#drp_year_semester').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindprogrammedata() {
    $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

    $('#drpprog').chosen();
}

function binddepartment() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_department_data",
        data: "{}",
        dataType: "json",
        aSync: false,
        success: function (data) {
            if (data.d != "") {
                var sem_data = JSON.parse(data.d)

                $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));
                for (var i = 0; i < sem_data.length; i++) {
                    $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                }

                $('#drpdepartment').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function bindstudent() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_student_report_list",
        data: "{}",
        dataType: "json",
        aSync: false,
        success: function (data) {
            if (data.d != "") {
                var stud_data = JSON.parse(data.d)

                $('#drp_student_code').empty().append($("<option></option>").val("").html("-- Select Student Code --"));
                for (var i = 0; i < stud_data.length; i++) {
                    $('#drp_student_code').append($("<option></option>").val(stud_data[i]["user_id"]).html(stud_data[i]["user_id"]));
                }

                $('#drp_student_code').chosen();
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}


function bindsemdata() {
    $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
    $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
    $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

    $('#drpsemester').chosen();
}
