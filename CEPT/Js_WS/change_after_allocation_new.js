

var saved_data = "";
var oTable;

function get_allocate_data() {
    $('#datalist_saved').css('display', 'none');

    $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService_WS.asmx/get_saved_registerd_course_for_drop_course",

        data: "{flag:'C'}",
        dataType: "json",
        success: function (data) {
            if (data.d != null) {


                if (data.d[1] != "") {

                    saved_data = JSON.parse(data.d[1]);
                    Display_saved_Data(data.d[1]);
                    //   display_student_password_data(data.d);


                }
                else {
                    bootbox.alert('There is No data Found For Selected Student');
                    return false;
                }



            }
            else {

                bootbox.alert('There is No data Found For Selected student');
            }

        },
        error: function (result) {
            alert(result);
        }
    });

    return false;

}

function Display_saved_Data(data) {

    $('#datalist_saved').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();


        $("#datalist_saved").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_saved" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#datatable_saved").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "bSort": false,
        "sDom": 't',
        //  "sScrollY": '400px',

        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools": {
            "aButtons": [
            //	"copy",
            //	"print",
            //	{
            //        							    "sExtends": "collection",
            //        							    "sButtonText": 'Export',
            //        							    "aButtons": ["xls"]
            //     							}
        						]
        },

        "aaData": JSON.parse(data),

        "aoColumns": [

                    { "sTitle": "Course", "mData": "course", "sWidth": "500px" },
                { "sTitle": "Faculty", "mData": "dept_name" },
                { "sTitle": "Course Type", "mData": "course_type" },
              { "sTitle": "Cancel",
                  "mData": null,


                  "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_cancel" ></center>'
              }


           ]

    });
    debugger;






    $('#btnsave').css('display', 'block');
    $('#datalist_saved').css('display', 'block');
}





function save_changes() {

    var datalist = [];

    bootbox.confirm("Are you sure to drop selected courses?", function (result) {


        if (result == true) {


            $("#datalist_saved tbody tr").each(function (i) {

                debugger;
                var aPos = oTable.fnGetPosition(this);
                var aData = oTable.fnGetData(aPos[i]);
                var a = aData[i];

                var obj = {};

                if ($(this).find(".chk_cancel").is(':checked')) {
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

            var student = $('#drpstudent').val();


            debugger;
            var data = JSON.stringify({ course_data: JSON.stringify(datalist), flag: 'C' });

            $.ajax({
                type: "POST",
                url: "../WebService_WS.asmx/Save_change_allocation_data",
                data: data,
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {

                    if (data.d != "") {

                        if (data.d == "semester") {
                            bootbox.alert("semester details not found for selected student");
                            return false;
                        }


                        bootbox.alert(data.d);

                        get_allocate_data();
                        // bootbox.alert(data.d);

                    }


                },
                error: function (msg) { alert(msg.d); }
            });

        }
    });
}

function get_allocate_data_for_gpa_nongpa() {
    $('#datalist_saved').css('display', 'none');


    //    var semester = $('#drpsemester').val();
    //    if (semester == "") {
    //        bootbox.alert('Please select semester')
    //        $('#drpsemester').focus();
    //        return false;
    //    }





    $.ajax(

    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService_WS.asmx/get_saved_registerd_course_for_drop_course",

        data: "{flag:'G'}",
        dataType: "json",
        success: function (data) {
            if (data.d != null) {


                if (data.d[1] != "") {

                    saved_data = JSON.parse(data.d[1]);
                    Display_Assigned_gpa_nongpa_Data(data.d[1]);
                    //   display_student_password_data(data.d);


                }
                else {
                    bootbox.alert('There is No data Found For Selected Student');
                    return false;
                }



            }
            else {

                bootbox.alert('There is No data Found For Selected student');
            }

        },
        error: function (result) {
            alert(result);
        }
    });

    return false;

}




function Display_Assigned_gpa_nongpa_Data(data) {

    $('#datalist_saved').css('display', 'block');

    if (oTable != null) {
        oTable.fnDestroy();


        $("#datalist_saved").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="datatable_saved" width="100%"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#datatable_saved").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "bSort": false,
        "sDom": 't',
        //  "sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        "oTableTools": {
            "aButtons": [
            //	"copy",
            //	"print",
            //	{
            //        							    "sExtends": "collection",
            //        							    "sButtonText": 'Export',
            //        							    "aButtons": ["xls"]
            //     							}
        						]
        },

        "aaData": JSON.parse(data),
        "aoColumns": [

                    { "sTitle": "Course", "mData": "course", "sWidth": "500px" },
                { "sTitle": "Faculty", "mData": "dept_name" },
                { "sTitle": "Course Type", "mData": "course_type" },
              { "sTitle": "GPA/Non GPA",

                  "mData": null,

                  fnRender: function (oObj) {

                      var listItems = '<select class="gpa">';
                      listItems += "<option value='0'>Select</option>";
                      listItems += "<option value='G'>GPA</option>";
                      listItems += "<option value='N'>Non GPA</option>";
                      listItems += '</select>';



                      return listItems;



                  }
              }


           ]

    });


    debugger;

    $("#datalist_saved tbody tr").each(function (i) {

        debugger;
        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];

        if (saved_data != "") {

            for (var j = 0; j < saved_data.length; j++) {



                if (saved_data[j]["doc_no"] == a["doc_no"]) {




                    if (saved_data[j]["gpa_nongpa"] != '') {
                        if (saved_data[j]["gpa_nongpa"] == "GPA") {
                            $(this).find(".gpa").val("G");
                        }
                        else {
                            $(this).find(".gpa").val("N");
                        }


                    }

                }



            }
        }
        else {
            // listItems += "<option  value='" + exporess[i]["Document_number"] + "'>" + exporess[i]["expression"] + "</option>";
        }

    });




    $('#btnsave').css('display', 'block');
    $('#datalist_saved').css('display', 'block');
}

function save_gpa_non_gpa_changes() {

    var datalist = [];

    $("#datalist_saved tbody tr").each(function (i) {

        debugger;
        var aPos = oTable.fnGetPosition(this);
        var aData = oTable.fnGetData(aPos[i]);
        var a = aData[i];

        var obj = {};


        if ($(this).children().eq(2).html() == "E") {
            obj["gpa_nongpa"] = $(this).find(".gpa").val();
        }
        else {
            obj["gpa_nongpa"] = "";
        }


        obj["doc_no"] = a["doc_no"];
        obj["course_code"] = a["course_code"];

        datalist.push(obj);
    });

    var student = $('#drpstudent').val();


    debugger;
    var data = JSON.stringify({ course_data: JSON.stringify(datalist), flag: 'G' });

    $.ajax({
        type: "POST",
        url: "../WebService_WS.asmx/Save_change_allocation_data",
        data: data,
        contentType: "application/json; charset=utf-8",
        datatype: "json",
        success: function (data) {

            if (data.d != "") {

                if (data.d == "semester") {
                    bootbox.alert("semester details not found for selected student");
                    return false;
                }


                bootbox.alert(data.d);

                get_allocate_data_for_gpa_nongpa();
                // bootbox.alert(data.d);

            }


        },
        error: function (msg) { alert(msg.d); }
    });


}