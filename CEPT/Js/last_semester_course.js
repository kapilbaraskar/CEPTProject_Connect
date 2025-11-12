
var oTable;

$(document).ready(function () {


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/Get_last_sme_data_student_wise",

        data: "{}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {


                display_last_sem_data(data.d);

            }
            else {

                bootbox.alert('There is no registered course data found for selected semester');

                return false;
            }

        },
        error: function (result) {
            alert(result);
        }
    });

});

function display_last_sem_data(data) {

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 60,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
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
          { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
          { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
           { "sTitle": "Credits", "mData": "credits", "bSortable": false },
          { "sTitle": "GPA / NonGPA", "mData": "gpa_nongpa", "bSortable": false }


            ]


    });

  
    $('#DataList').css('display', 'block');
   

}
