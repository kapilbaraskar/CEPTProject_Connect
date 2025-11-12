var oTable;
var sem = '';
var year = '';
var course_code = '';
var table_headers;

$(document).ready(function () {

    sem = $('#hdn_s').val();
    year = $('#hdn_y').val();
    course_code = $('#hdn_c').val();
    calculated_grade();

    $('#spn_course_name').text("Course Code : " + course_code);

    if ($('#hdnusertype').val() == "FA") {
        $('#tbl_tr_btn').remove();
    }

    function calculated_grade() {

        $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/calculated_grade_to_commit_grade",
                //async: false,
                data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
                dataType: "json",
                success: function (data) {
                    
                    if (data.d == "The source contains no DataRows.") {
                        bootbox.alert('Please enter Marks then only Grade should Commit.', function (result) {
                            window.location.href = "Commit_Grade.aspx";
                        });
                    }
                    else
                    {
                        data = JSON.parse(data.d);

                        table_headers = [
                            { "sTitle": "Student Code", "mData": "student_code", "bSortable": false },
                            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false }
                        ];

                        table_headers.push({ "sTitle": "Calculated Marks (OLD)", "mData": "new_subject_marks", "bSortable": false });
                        table_headers.push({ "sTitle": "Calculated Grade (OLD)", "mData": "new_course_grade", "bSortable": false });
                        table_headers.push({ "sTitle": "Calculated Grade Point (OLD)", "mData": "new_grade_point", "bSortable": false });

                        table_headers.push({ "sTitle": "Commited Marks (NEW)", "mData": "final_mark", "bSortable": false });
                        table_headers.push({ "sTitle": "Commited Grade (NEW)", "mData": "final_grade", "bSortable": false });
                        table_headers.push({ "sTitle": "Commited Grade Point (NEW)", "mData": "final_grade_point", "bSortable": false });

                        for (var i = 0; i < data.length; i++) {
                            if (data[i].absent_exam_1 == 'AB' || data[i].absent_exam_1 == 'NA') data[i].exam_1 = data[i].absent_exam_1;
                            if (data[i].absent_exam_2 == 'AB' || data[i].absent_exam_2 == 'NA') data[i].exam_2 = data[i].absent_exam_2;
                            if (data[i].absent_exam_3 == 'AB' || data[i].absent_exam_3 == 'NA') data[i].exam_3 = data[i].absent_exam_3;
                            if (data[i].absent_exam_4 == 'AB' || data[i].absent_exam_4 == 'NA') data[i].exam_4 = data[i].absent_exam_4;
                            if (data[i].absent_exam_5 == 'AB' || data[i].absent_exam_5 == 'NA') data[i].exam_5 = data[i].absent_exam_5;
                            if (data[i].absent_exam_6 == 'AB' || data[i].absent_exam_6 == 'NA') data[i].exam_6 = data[i].absent_exam_6;
                            if (data[i].absent_exam_7 == 'AB' || data[i].absent_exam_7 == 'NA') data[i].exam_7 = data[i].absent_exam_7;
                            if (data[i].absent_exam_8 == 'AB' || data[i].absent_exam_8 == 'NA') data[i].exam_8 = data[i].absent_exam_8;
                            if (data[i].absent_exam_9 == 'AB' || data[i].absent_exam_9 == 'NA') data[i].exam_9 = data[i].absent_exam_9;
                            if (data[i].absent_exam_10 == 'AB' || data[i].absent_exam_10 == 'NA') data[i].exam_10 = data[i].absent_exam_10;
                        }

                        if (oTable != null) {
                            oTable.fnDestroy();
                            $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
                        }

                        oTable = $("#example").dataTable({
                            "bPaginate": false,
                            "bSortable": false,
                            "bSort": false,
                            //"bStateSave": true,
                            "iDisplayLength": 60,
                            "sDom": 't',
                            "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                            //"sScrollY": '400px',
                            "oLanguage": {
                                "sSearch": "Search all columns with Space:"
                            },
                            //"sDom": 'T<"clear">lfrtip',
                            "oTableTools": {
                                "aButtons": [
                                    //"copy",
                                    "print",
                                    {
                                        "sExtends": "collection",
                                        "sButtonText": 'Export',
                                        "aButtons": ["xls"]
                                    }
                                ]
                            },
                            //"aaData": JSON.parse(data),
                            "aaData": data,
                            "aoColumns": [
                                { "sTitle": "Student Code", "mData": "student_code", "bSortable": false },
                                { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },

                                { "sTitle": "Calculated Marks (OLD)", "mData": "new_subject_marks", "bSortable": false },
                                { "sTitle": "Calculated Grade (OLD)", "mData": "new_course_grade", "bSortable": false },
                                { "sTitle": "Calculated Grade Point (OLD)", "mData": "new_grade_point", "bSortable": false },

                                { "sTitle": "Commited Marks (NEW)", "mData": "final_mark", "bSortable": false },
                                {
                                    "sTitle": "Commited Grade (NEW)", "mData": "final_grade", "bSortable": false, "fnRender": function (data) {
                                        //if (data.aData.new_course_grade != data.aData.final_grade) {
                                        //    debugger;
                                        //}
                                        return data.aData.final_grade;
                                    }
                                },
                                { "sTitle": "Commited Grade Point (NEW)", "mData": "final_grade_point", "bSortable": false },

                                {
                                    "sTitle": "Grade Changed", "mData": null, "sClass": "hide", "bSortable": false, "fnRender": function (data) {//hide
                                        if (data.aData.new_course_grade != data.aData.final_grade && data.aData.final_grade != "") {
                                            if (data.aData.new_grade_point != data.aData.final_grade_point && data.aData.final_grade_point != "") {
                                                return "YES";
                                            } else {
                                                return "NO";
                                            }
                                        } else {
                                            return "NO";
                                        }
                                    }
                                }
                            ]
                        });

                        $('#DataList').css('display', 'block');

                        //if ($('#hdnusertype').val() == "FA" || $('#hdnusertype').val() == "A") {
                            $("#example tbody tr").each(function (i) {
                                if ($(this).children().eq(8)[0].innerText == "YES") {
                                    $(this).closest('tr').children('td,th').css('background-color', 'rgb(255, 142, 142)');
                                }
                            });
                        //}
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
    }

    $("#commit_grade").click(function () {
        var confirm_commit = confirm("Are you sure you want to Commit Grade?");

        if (confirm_commit) {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/commit_grade",
                    //async: false,
                    data: "{course_code:'" + $('#hdn_c').val() + "', sem_code:'" + sem + "', year_code:'" + year + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == 'Grade Commited Successfully') {
                                bootbox.alert('Grade Commited Successfully', function (result) {
                                    window.location.reload();
                                });
                            }
                            else {
                                bootbox.alert(data.d);
                            }
                        }
                    },
                    error: function (result) {
                        tempData = [];
                        alert(result);
                    }
                });
        }
    });

});