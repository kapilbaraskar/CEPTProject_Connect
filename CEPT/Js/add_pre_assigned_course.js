
var credits = "";
var saved_data = "";

function bindcourse() {

    //    $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
    //    $('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
    //    $('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/get_all_mandatory_course",
        async: false,
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var course_data = JSON.parse(data.d)

                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select Course --"));



                for (var i = 0; i < course_data.length; i++) {

                    $('#drcourses').append($("<option></option>").val(course_data[i]["course_credits"]).html(course_data[i]["course_code"]));
                }

                $('#drcourses').chosen();

            }
            else {
                bootbox.alert("No data found of current semester's course");
            }
        },
        error: function (result) {
            alert(result);
        }
    });

}



function get_data_for_preassigned() {

    debugger;

    $('#DataList').css('display', 'none');

    $('#btnsave').css('display', 'none');

    var course = $('#drcourses :selected').text();
    if (course == "") {
        bootbox.alert('Please select course')
        $('#drcourses').focus();
        return false;
    }



    var dept_code = $('#drpdepartment').val();
    if (dept_code == "") {
        bootbox.alert('Please select department')
        $('#drpdepartment').focus();
        return false;
    }

    var prog_code = $('#drpprog').val();
    if (prog_code == "") {
        bootbox.alert('Please select programme')
        $('#drpprog').focus();
        return false;
    }




    $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_all_student_data_for_pre_assigned",

        data: "{course:'" + course + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "'}",
        dataType: "json",
        success: function (data) {


            if (data.d[0] != null) {

                if (data.d[1] != null) {

                    saved_data = JSON.parse(data.d[1]);

                }
                else {

                    saved_data = "";
                }


                Display(data.d[0]);
                //   display_student_password_data(data.d);

              

            }
            else {
                bootbox.alert('There is No data Found For Selected Department');
                return false;
            }





        },
        error: function (result) {
            alert(result);
        }
    });

    return false;

}

function Display(data) {

    debugger;


    debugger;


    if (oTable != null) {
        oTable.fnDestroy();


        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools":
        {
            "aButtons": [
            //        							"copy",
            //        							"print",
            //        							{
            //        							    "sExtends": "collection",
            //        							    "sButtonText": 'Export',
            //        							    "aButtons": ["xls"]
            //        							}
        						]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [
         { "sTitle": "Select",
             "mData": null,
             "bSortable": false,

             "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_course" ></center>'
         },

                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "user_name", "bSortable": false }
        //                     { "sTitle": "Corse Type",
        //                         "bSortable": false,
        //                         "mData": null,

        //                         fnRender: function (oObj) {

        //                             var listItems = '<select class="course_type">';
        //                             listItems += "<option value='0'>Select</option>";
        //                             listItems += "<option value='M'>Mandatory</option>";
        //                             listItems += "<option value='E'>Elective</option>";
        //                             listItems += '</select>';



        //                             return listItems;



        //                         }
        //                    }

        //                    ,  { "sTitle": "GPA/Non GPA",
        //                          "bSortable": false,
        //                          "mData": null,

        //                          fnRender: function (oObj) {

        //                              var listItems = '<select class="gpa">';
        //                              listItems += "<option value='0'>Select</option>";
        //                              listItems += "<option value='G'>GPA</option>";
        //                              listItems += "<option value='N'>Non GPA</option>";
        //                              listItems += '</select>';



        //                              return listItems;



        //                          }
        //                      },

           ]

    });

    $("#example tbody tr").each(function (i) {

        if (saved_data != "") {

            for (var i = 0; i < saved_data.length; i++) {

                if (saved_data[i]["user_id"] == $(this).children().eq(1).html()) {

                    $(this).find(".chk_course").prop('checked', true);

                }

            }
        }

    });

    $('#DataList').css('display', 'block');
    $('#btnsave').css('display', 'block');
}

function save_data_for_allocation() {

    var oSettings = oTable.fnSettings();
    for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
        oSettings.aoPreSearchCols[iCol].sSearch = '';
    }
    oSettings.oPreviousSearch.sSearch = '';
    oTable.fnDraw();

    var flag = "N";

    var datalist = [];
    $("#example tbody tr").each(function (i) {

        var obj = {};

        debugger;
        if ($(this).find(".chk_course").is(':checked')) {

            obj["user_id"] = $(this).children().eq(1).html();

            datalist.push(obj);
        }

    });

    debugger;

    if (flag == "N") {

        var data = JSON.stringify({ manually_data: JSON.stringify(datalist), course_code: $('#drcourses :selected').text(), course_credits: $('#drcourses').val(), dept_code: $('#drpdepartment').val(), prog_code: $('#drpprog').val() });

        $.ajax({
            type: "POST",
            url: "../../WebService.asmx/save_pre_assigned_data",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                if (data.d != "") {

                    if (data.d == "error on course") {
                        bootbox.alert("Course data is nor retrieve");
                        return false;
                    }



                    bootbox.alert(data.d);

                    $('#DataList').css('display', 'none');
                    $('#btnsave').css('display', 'none');

                }


            },
            error: function (msg) { alert(msg.d); }
        });


    }



}