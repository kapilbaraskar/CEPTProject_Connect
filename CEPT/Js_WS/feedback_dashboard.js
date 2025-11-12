

var oTable;
var oTable1;
var feedback_saved_data = '';

$(document).ready(function () {
    let origin = location.origin;
    var a = document.getElementById('yourlinkId');
    if ($('#hdnusertype').val() == 'HS') {
        a.href = origin + "/Student/sws_course_selection_hs.aspx";
    }
    else
    {
        a.href = origin + "/Student/sws_credit_choice.aspx";
    }
    

    var a = document.getElementById('courselog'); 
    a.href = origin + "/Student/course_allocate_dtl.aspx";

    var a = document.getElementById('dropcourse');
    a.href = origin + "/Student/SWS_Drop_Course.aspx";

    var a = document.getElementById('droprefund');
    a.href = origin + "/Student/RefundRequest.aspx";

    $('#myModal').modal(
    {
        backdrop: 'static',
        keyboard: false
    });

    $('#myModal').modal('hide');

    $('#my_instruction').modal(
    {
        backdrop: 'static',
        keyboard: false
    });

    $('#my_instruction').modal('hide');


    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/check_Gender",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {
            debugger;
            if (data.d == false) {

                $('#myModal').modal('show');

            }
            else {


                $.ajax({
                    type: "POST",
                    url: "../WebService_WS.asmx/check_instruction",
                    data: "{}",
                    contentType: "application/json",
                    async: false,
                    cache: false,
                    datatype: "json",
                    success: function (data) {
                        debugger;
                        if (data.d == false) {

                            $('#my_instruction').modal('show');

                        }
                        else {



                        }

                    },

                    Error: function (data) {

                        alert(data.d);
                    }

                });

            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });


    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/check_session",
        data: "{}",
        contentType: "application/json",
        async: false,
        cache: false,
        datatype: "json",
        success: function (data) {

            if (data.d == false) {

                bootbox.alert('Session expired, Please login to continue.', function () {
                    window.location.href = "../Login.aspx";
                });
            }
            else {
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });



    if (getParameterByName("autho") == 'false') {
        bootbox.alert('You are not authorized to view this page.');
    }



    // binddata();

    bind_saved_data();

    bind_assigned_data();

    getcredit_choice_data();

    get_fees_status();


    $('#btnsavegender').on('click', function () {

        debugger;


        var pattern = /^\d{10}$/;
        if (pattern.test($('#txt_contact_number').val())) {

        }
        else {
            bootbox.alert("Please Enter Only Number In Contact Number");

            return false;
        }

        if (isNaN($('#txt_contact_number').val())) {

            bootbox.alert("Please Enter Only Number In Contact Number");

            return false;
        }


        var contact_no = $('#txt_contact_number').val();

        if (contact_no == "") {

            bootbox.alert("Please Enter Contact Number");

            return false;

        }
        else if (contact_no.length < 10) {
            bootbox.alert("Please Enter 10 Digit Contact Number");

            return false;

        }

        var email = $('#txt_alternet_email').val();

        if (email == "") {
            bootbox.alert('Please Insert Email Address')
            $('#txtemail').focus();
            return false;
        }

        var testEmail = /^[A-Z0-9._%+-]+@([A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
        if (testEmail.test(email)) {

        }
        else {
            bootbox.alert("Please Enter Valid Email");
            $('#txtemail').focus();

            return false;
        }

        var blood_group = $('#drpbloodgroup').val();

        if (blood_group == "0") {

            bootbox.alert("Please Select Blood Group");

            return false;
        }


        if ($('#chkregistration').is(':checked')) {


        }
        else {

            bootbox.alert("Please tick chekbox");

            return false;


        }



        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/Save_Gender_data",
            data: "{'gender' : '" + $('#drpgender').val() + "' , 'contact_no' :'" + contact_no + "', 'email' : '" + email + "', 'blood_grp':'" + blood_group + "'}",
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {

                if (data.d == true) {
                    bootbox.alert("Your Registration data are updated successfully.");
                    $('#myModal').modal('hide');

                    $('#my_instruction').modal('show');
                }
                else {

                    bootbox.alert("Your Registration data are not updated");

                }

            },

            Error: function (data) {

                alert(data.d);
            }

        });

    });


    $('#btn_save_instruction').on('click', function () {

        debugger;




        if ($('#chk_agree_afidavite').is(':checked')) {


        }
        else {

            bootbox.alert("Please tick first chekbox");

            return false;


        }


        if ($('#chk_agree_reg_process').is(':checked')) {


        }
        else {

            bootbox.alert("Please tick Second chekbox");

            return false;


        }



        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/Save_registration_instruction_data",
            data: "{}",
            contentType: "application/json",
            async: false,
            cache: false,
            datatype: "json",
            success: function (data) {

                if (data.d == true) {
                    //  bootbox.alert("Your Gender is updated successfully.");
                    //   $('#myModal').modal('hide');

                    $('#my_instruction').modal('hide');
                }
                else {

                    //  bootbox.alert("Your Gender is not updated");

                }

            },

            Error: function (data) {

                alert(data.d);
            }

        });

    });

    $('#btn_save').on('click', function () {

        var credit = $('#txtcreditchoice').val();

        if (credit == "") {
            bootbox.alert("Please Enter Credit Choice");
            return false;
        }

        if (credit > 24) {
            bootbox.alert("You Can Select Max. 24 credit");
            return false;
        }


        $.ajax({
            type: "POST",
            url: "../WebService_WS.asmx/save_choice_credit_for_student",
            data: "{creadit_choice: '" + credit + "'}",
            contentType: "application/json",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {

                    if (data.d == "There is no current semester detail found.") {

                        bootbox.alert("Your current semester detail is not found in system.");
                        return false;
                    }

                    if (data.d == "allocate") {
                        bootbox.alert("You can not change credit choice for current semester.Course allocation is Completed for current semester");
                        return false;
                    }

                    bootbox.alert('Data Saved Succesfully');

                }
                else {

                }

            },

            Error: function (data) {

                alert(data.d);
            }

        });
        return false;


    });

    $('#datalist_register tbody tr').live('click', function (e) {

        debugger;

        var row = $(this).closest("tr").get(0);
        var aData = oTable1.fnGetData(row);
        var flag = 'Y';
        var course = aData.course_code;
        if (feedback_saved_data != '') {


            for (var j = 0; j < feedback_saved_data.length; j++) {
                debugger;
                if (feedback_saved_data[j]["course"] == aData.course_code) {
                    flag = 'N';
                }

            }
        }

        if (flag == 'Y') {

            var a = "Student_Feedback_form.aspx?course_code=" + course + "&course_name=" + aData.course;
            window.location.href = a;
        }





        // alert(course);

    });

});

function getcredit_choice_data() {

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/get_saved_credit_choice_data",
        data: "{}",
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                var data = JSON.parse(data.d);


                $('#txtcreditchoice').val(data[0]["credit_choice"]);


            }
            else {

            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });
    return false;
}

function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
    return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}


function binddata() {

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_student_current_sem_data",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                DisplayData(data.d);


            }
            else {
                bootbox.alert("There is no Selected Course available.Please Select Course For Current Semester");
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });
    return false;

}


function bind_saved_data() {

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_student_saved_current_sem_data",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                Display_saved_Data(data.d);


            }
            else {

            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });
    return false;

}


function bind_assigned_data() {

    debugger;

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_student_assigned_current_sem_data_for_feedback_dashboard",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                Display_registered_Data(data.d);
            }
            else {

            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });
    return false;

}

function get_fees_status() {

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_fees_status",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            //   alert('kamlesh');
            if (data.d != "") {

                fees_status = JSON.parse(data.d);

                if (fees_status[0]["fees_status"] == "F") {
                    $('#lbl_fees_status').text("Paid full fees (for 24 credits)");
                }
                if (fees_status[0]["fees_status"] == "H") {
                    $('#lbl_fees_status').text("Paid half fees (for 12 credits)");
                }



            }
            else {
                $('#lbl_fees_status').text('Fees not paid');
            }

        },

        Error: function (data) {

            alert(data.d);
        }

    });

    return false;


}

function DisplayData(data) {


    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        "oTableTools": {
            "aButtons": [
							"copy",
							"print",
							{
							    "sExtends": "collection",
							    "sButtonText": 'Export',
							    "aButtons": ["xls", "pdf"]
							}
						]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [

                    { "sTitle": "Priority", "mData": "priority", "bSortable": false },
                { "sTitle": "Semester", "mData": "semester_code", "bSortable": false },
                { "sTitle": "Code", "mData": "course_code", "bSortable": false },
                { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                 { "sTitle": "Course Type", "mData": "course_type", "bSortable": false },
                { "sTitle": "Credits", "mData": "credits", "bSortable": false },

                 { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
                 { "sTitle": "GPA/Non GPA", "mData": "gpa_nongpa", "bSortable": false }

           ]

    });

}

function Display_saved_Data(data) {


    if (oTable != null) {
        oTable.fnDestroy();


        $("#datalist_saved").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_saved"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#datatable_saved").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        // "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        //        "oTableTools": {
        //            "aButtons": [
        //							"copy",
        //							"print",
        //							{
        //							    "sExtends": "collection",
        //							    "sButtonText": 'Export',
        //							    "aButtons": ["xls", "pdf"]
        //							}
        //						]
        //        },

        "aaData": JSON.parse(data),
        "aoColumns": [

                    { "sTitle": "Course", "mData": "course", "bSortable": false },
                { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false }


           ]

    });

    $('#datalist_saved').css('display', 'block');
}

function Display_registered_Data(data) {


    if (oTable1 != null) {
        oTable1.fnDestroy();


        $("#datalist_register").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_register"><thead></thead><tbody style="cursor: pointer;"> </tbody></table>');
    }

    oTable1 = $("#datatable_register").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',


        "aaData": JSON.parse(data),
        "aoColumns": [

                    { "sTitle": "Course", "mData": "course", "bSortable": false },
                { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
                { "sTitle": "Status", "mData": "Status", "bSortable": false }


           ]

    });

    $('#datalist_register').css('display', 'block');

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService_WS.asmx/Get_student_saved_feedback_data",
        aSync: false,
        data: "{}",
        dataType: "json",
        success: function (data1) {


            if (data1.d != '') {


                debugger;
                feedback_saved_data = JSON.parse(data1.d);

                $("#datalist_register tbody tr").each(function (i) {
                    debugger;
                    //                    var aPos = oTable1.fnGetPosition(this);
                    //                    var aData = oTable1.fnGetData(aPos[i]);
                    //                    var a = aData[i];

                    var row = $(this).closest("tr").get(0);
                    var aData = oTable1.fnGetData(row);


                    for (var j = 0; j < feedback_saved_data.length; j++) {
                        debugger;
                        if (feedback_saved_data[j]["course"] == aData.course_code) {

                            //$(this.nTr).addClass('row_selected');
                            $(this.nTr).removeClass('row_selected');
                            $(this).css('color', "#D6D5C3");
                            $(this).attr('disabled', 'disabled');
                            // $(this).find('.btnfeedback').prop('disabled', 'disabled');

                        }

                    }


                });
            }
        }

    });
}

