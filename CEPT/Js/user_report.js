var oTable;
var count = 1;
var asInitVals = new Array();
var stud_code = '';
$(document).ready(function () {
    $("#header").css("display","none");
    binddepartment();
    bindyeardata();
    bindprogrammedata();
    bindsemdata();
    bindstudent();
    var url_type = '';
    var url_Data = '';
    url_type = "../../WebService.asmx/get_Student_personal_data_profile";
    url_Data = "{stud_code:'" + stud_code + "'}";
    function get_Student_personal_data_profile(stud_code) {
        url_Data = "{stud_code:'" + stud_code + "'}";
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: url_type,
            async: false,
            data: url_Data,
            dataType: "json",
            success: function (data) {
                if (data.d[0] != "") {
                    
                    var personldata = JSON.parse(data.d[0]);
                    //$('#txt_first_name').val(personldata[0].first_name);
                    //$('#txt_middle_name').val(personldata[0].middle_name);
                    //$('#txt_last_name').val(personldata[0].last_name);
                    $('#txt_full_name').html(personldata[0].user_name);
                    $('#drop_bloodgroup').html(personldata[0].blood_group);
                    var temp_dob = personldata[0].dob.split(" ");
                    $('#txt_date_of_birth').html(temp_dob[0]);
                    $('#drppyear').html(personldata[0].year_code);
                    $('#drppprog').html(personldata[0].prog_desc);
                    $('#login_email').html(personldata[0].mail);
                    
                    if (personldata[0].profile_photo != null && personldata[0].profile_photo != "") {
                        $('#img_photo').attr("src", "../../UserProfilePhoto/" + personldata[0].profile_photo);
                    } else {
                        $('#img_photo').attr("src", "../../UserProfilePhoto/Default_Avtar.png");
                    }

                }
                if (data.d[1] != null) {
                    eductionbindata(data.d[1]);
                }
                if (data.d[2] != null) {
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
            str_edu += "<td><span style='width: 202px;' type='text' class='education_major_subject'></span></td> ";
            str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='year_of_completion' onkeypress='return isNumber(event);'></span></td> ";
            str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='education_score' onkeypress='return isNumber(event);'></span></td> ";
            str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='nata_id' onkeypress='return isNumber(event);'></span></td> ";
            str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='nata_score' onkeypress='return isNumber(event);'></span></td> ";
            str_edu += "<td><span style='width: 50px;' type='text' maxlength='4' class='nata_second_score' onkeypress='return isNumber(event);'></span></td> ";

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
                    $(this).find(".nata_id").html(E_details[i].nata_id);
                    $(this).find(".nata_score").html(E_details[i].nata_score);
                    $(this).find(".nata_second_score").html(E_details[i].nata_second_score);
                    $(this).find(".education_major_subject").html(E_details[i].education_major_subject);
                    $(this).find(".education_score").html(E_details[i].education_score);
                }
            }
        });
    }
    $('#txt_modified_on').datepicker({ dateFormat: 'dd/mm/yy' });

    $('#btnreterive').on('click', function () {
        
        $('#DataList').css('display', 'none');

        stud_code = $('#drp_student_code').val();
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


        }
        else
        {
            get_Student_personal_data_profile(stud_code);
        }
        return false;
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
            { "sTitle": " Applicant Address", "mData": "applicant_address_house_no", "bSortable": false },
            { "sTitle": " Applicant City", "mData": "applicant_address_city", "bSortable": false },
            { "sTitle": " Applicant State", "mData": "applicant_state_name", "bSortable": false },
            { "sTitle": " Applicant PinCode", "mData": "applicant_address_pincode", "bSortable": false },
            { "sTitle": " Preferred Mailing Address House No", "mData": "preferred_mailing_address_house_no", "bSortable": false },
            { "sTitle": " City", "mData": "applicant_address_city", "bSortable": false },
            { "sTitle": " State", "mData": "state_name", "bSortable": false },
            { "sTitle": " PinCode", "mData": "applicant_address_pincode", "bSortable": false },
            { "sTitle": " Guardian Name", "mData": "guardian_name", "bSortable": false },
            { "sTitle": " Guardian Address House No", "mData": "guardian_address_house_no", "bSortable": false },
            { "sTitle": " Guardian Landline No", "mData": "guardian_landline_no", "bSortable": false },
            { "sTitle": " Guardian Mobile No", "mData": "guardian_mobile_no", "bSortable": false },
            { "sTitle": " Emergency Contact 1", "mData": "guardian_mobile_no", "bSortable": false },
            { "sTitle": " Emergency Contact 2", "mData": "emergency_contact_2", "bSortable": false },
            { "sTitle": " Guardian Email Id", "mData": "guardian_email_id", "bSortable": false },
            { "sTitle": " Registration Status", "mData": "status", "bSortable": false },
            { "sTitle": " Modified Date", "mData": "modified_date", "bSortable": false },
            { "sTitle": " Reservation Category", "mData": "category_desc", "bSortable": false },
            {
                "sTitle": "Type", "mData": null, "bSortable": false, "mRender": function (data) {
                    if (data["Type"] == "N")
                    {
                        return '<center>Flat/ Relative House</center>';
                    }
                    else if (data["Type"] == "Y") {
                        return '<center>PG/Hostel</center>';
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },

            { "sTitle": " Name ", "mData": "NameOfAddress", "bSortable": false },
           // { "sTitle": " Warden Name / Relationship", "mData": "WardenName", "bSortable": false },

            {
                "sTitle": "Warden Name / Relationship", "mData": null, "bSortable": false, "mRender": function (data) {
                    debugger;
                    if (data["WardenName"] != "") {
                        return data['WardenName'];
                    }
                    else if (data["Relationship"] != "")
                    {
                        return data['Relationship'];
                    }
                    else {
                        return '<center></center>';
                    }

                }
            },


            { "sTitle": " Warden Number", "mData": "WardenNumber", "bSortable": false },
            { "sTitle": " Room Number", "mData": "RoomNumber", "bSortable": false },
            { "sTitle": " Address Field One", "mData": "AddressField1", "bSortable": false },
            { "sTitle": " Address Field Two", "mData": "AddressField2", "bSortable": false },
            { "sTitle": " Area", "mData": "Area", "bSortable": false },
            { "sTitle": " City", "mData": "City", "bSortable": false },
            { "sTitle": " PinCode", "mData": "PinCode", "bSortable": false },
            { "sTitle": " ContactNo", "mData": "ContactNo", "bSortable": false }
            

            
            
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
