

var oTable;
var oTable1;
var oTableAgree;

$(document).ready(function () {
    $('#AllocationAgreeModal').modal(
       {
           backdrop: 'static',
           keyboard: false
       });

    $('#AllocationAgreeModal').modal('hide');
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

    //  getcredit_choice_data();

    get_fees_status();


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

    $('#btn_save_agree').on('click', function () {

        var datalist = [];



        //        var agree_notagree = "";

        //        if ($('input[name=agree]:checked').val() == 'Y') {
        //            agree_notagree = "Agree";
        //        }
        //        else {
        //            agree_notagree = "Not agree";
        //        }


        $("#datalist_agree tbody tr").each(function (i) {

            debugger;
            var aPos = oTableAgree.fnGetPosition(this);
            //            var aData = oTableAgree.fnGetData(aPos[i]);
            //            var a = aData[i];

            var a = oTableAgree.fnGetData(aPos);

            var obj = {};

            if ($('input[name=' + a["course_code"] + ']:checked').val() == "Y") {
                obj["cancel_flag"] = "Y";
            }
            else {
                obj["cancel_flag"] = "N";
            }
            //        if ($(this).children().eq(3).html() == "E") {
            //            obj["gpa_nongpa"] = $(this).find(".gpa").val();
            //        }
            //        else {
            //            obj["gpa_nongpa"] = "";
            //        }


            obj["doc_no"] = a["doc_no"];
            obj["course_code"] = a["course_code"];

            datalist.push(obj);
        });

        var lst_rdo_drop = $('.cls_temp');
        var checked_flag = false;

        for (var i = 0; i < lst_rdo_drop.length; i++) {
            if ($('.cls_temp')[i].checked) {
                checked_flag = true;
            }
        }

        if (checked_flag) {
            if (!$('#chk_drop')[0].checked) {
                bootbox.alert('Please select the checkbox to proceed.');
                return false;
            } 
        }

        bootbox.confirm("Are you sure you confirm your acceptance?", function (result) {

            if (result == true) {

                $.ajax({
                    type: "POST",
                    url: "../WebService_WS.asmx/save_course_allocation_agree_or_not",
                    data: "{course_data:'" + JSON.stringify(datalist) + "'}",
                    contentType: "application/json",
                    datatype: "json",
                    success: function (data) {
                        debugger;
                        if (data.d != "") {


                            bootbox.alert(data.d, function () {
                                location.reload();
                            });

                            //                            if (data.d == "Data Saved Successfully") {

                            //                                

                            //                              //  bind_assigned_data();
                            //                            }
                            //                            else {
                            //                                bootbox.alert(data.d);
                            //                            }



                        }
                        else {

                        }

                    },

                    Error: function (data) {

                        alert(data.d);
                    }

                });
            }

            else {



            }



        });

        return false;

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

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Get_student_assigned_current_sem_data",
        data: {},
        contentType: "application/json",
        datatype: "json",
        success: function (data) {
            debugger;
            if (data.d[0] != null) {

                Display_registered_Data(data.d[0]);

                if (data.d[1] != null) {

                    if (data.d[1] != '') {

                        $('#AllocationAgreeModal').modal('hide');

                        // var agree_data = JSON.parse(data.d[1]);
                    }

                }
                else {

                    $('#AllocationAgreeModal').modal('show');

                   //$('#AllocationAgreeModal').modal('hide');
                }
            }
            else {

                $('#AllocationAgreeModal').modal('hide');

            }



        },

        Error: function (data) {

            alert(data.d);
        }

    });
    return false;

}

function get_fees_status() {
    debugger;
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

                if (fees_status[0]["fees_status"] == "Y") {
                    $('#lbl_fees_status').text("Fees Paid");
                }
                if (fees_status[0]["fees_status"] == "N") {
                    $('#lbl_fees_status').text("Fees not paid");
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


        $("#datalist_register").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_register"><thead></thead><tbody> </tbody></table>');
    }

    oTable1 = $("#datatable_register").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',


        "aaData": JSON.parse(data),
        "aoColumns": [

                    { "sTitle": "Course", "mData": "course", "bSortable": false },
                { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false }


           ]

    });

    $('#datalist_register').css('display', 'block');



    if (oTableAgree != null) {
        oTableAgree.fnDestroy();


        $("#datalist_agree").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="tbl_agree"><thead></thead><tbody> </tbody></table>');
    }

    oTableAgree = $("#tbl_agree").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',


        "aaData": JSON.parse(data),
        "aoColumns": [
                        { "sTitle": "Course", "mData": "course", "bSortable": false },
                        { "sTitle": "Faculty", "mData": "dept_name", "bSortable": false },
                        { "sTitle": "Accept", "mData": null, "bSortable": false, fnRender: function (oObj) {
                            return '<input type="radio" name=' + oObj.aData.course_code + ' value="N" checked onchange="return rdo_accept_click();" />';
                        }
                        },
                        { "sTitle": "Drop", "mData": null, "bSortable": false, fnRender: function (oObj) {
                            return '<input type="radio" name=' + oObj.aData.course_code + ' value="Y" class="cls_temp" onchange="return rdo_drop_click();" />';
                        }
                        }

           ]
    });
}

function rdo_drop_click() {
    $('#div_chk_drop').css('display', 'block');
}

function rdo_accept_click() {
    var lst_rdo_drop = $('.cls_temp');
    var checked_flag = false;

    for (var i = 0; i < lst_rdo_drop.length; i++) {
        if ($('.cls_temp')[i].checked) {
            checked_flag = true;
        }
    }

    if (!checked_flag) {
        $('#div_chk_drop').css('display', 'none');
        $('#chk_drop')[0].checked = false;
    } 
}

