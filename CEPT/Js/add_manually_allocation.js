var oTable;
var old_allocate_data = "";
var allocate_user_data = "";
var disable_status = true;

function bind_sem_course() {
    var sem_code = $('#drpsemester').val();

    if (sem_code == '') {
        bootbox.alert('Please select semester');
        return false;
    }

    var year_code = $('#drpyear').val();

    if (year_code == '') {
        bootbox.alert('Please select year');
        return false;
    }

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_course_data",
        data: "{sem_code : '" + sem_code + "',year_code:'" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));

                for (var i = 0; i < year_data.length; i++) {
                    $('#drcourses').append($("<option></option>").val(year_data[i]["course_code"]).html(year_data[i]["course_code"]));
                }

                $('#drcourses').chosen();
                $('#drcourses').trigger("liszt:updated");
            }
            else {
                $('#drcourses')
                    .find('option')
                    .remove()
                    .end()
                    .append('<option value="">No Student found</option>')
                    .val('');
                $('#drcourses').chosen();

                $('#drcourses').val('').trigger("liszt:updated");
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function get_data_for_allocation() {
    $('#DataList').css('display', 'none');
    $('#btnsave').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var course = $('#drcourses').val();
    if (course == "" || course == null) {
        bootbox.alert('Please select course')
        $('#drcourses').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year of assign')
        $('#drpyear').focus();
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
    var prog_level = $('#drpproglevel').val();
    var batch_year = $('#BthYear').val();

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_all_student_data_for_manaally_allocation",
            data: "{year_code:'" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',sem_code:'" + semester + "',course_code:'" + course + "',prog_level:'" + prog_level + "',batch_year:'" + batch_year + "'}",
        dataType: "json",
        success: function (data) {
            old_allocate_data = '';

            if (data.d[0] != null) {
                //display_student_password_data(data.d);

                if (data.d[1] != null)
                {
                    old_allocate_data = JSON.parse(data.d[1]);
                }
                if (data.d[2] != null) {
                    allocate_user_data = JSON.parse(data.d[2]);
                }

                Display(data.d[0]);
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
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": false,
        "bStateSave": false,
        "sDom": 't',
        //"sScrollY": '400px',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //"oLanguage": {
        //  "sSearch": "Search all columns with Space:"
        //},
        "oTableTools":
        {
            "aButtons": [
            //"copy",
            //"print",
            //{
            //    "sExtends": "collection",
            //    "sButtonText": 'Export',
            //    "aButtons": ["xls"]
            //}
        	]
        },
        "aaData": JSON.parse(data),
        "aoColumns": [
            //{ "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_course" onchange="user_select_change(this)" ></center>' },
            {
                "sTitle": "Select", "mData": null, "bSortable": false, fnRender: function (oObj) {
                    return '<input type="checkbox"  name="check1" value="1" class="chk_course" onchange="user_select_change(this)" id="' + oObj.aData["user_id"] + '" />';
                }
                
            },
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Corse Type","bSortable": false,"mData": null,fnRender: function (oObj) {
                var listItems = '<select class="course_type" id="' + oObj.aData["user_id"] +'">';
                listItems += "<option value='0'>Select</option>";
                listItems += "<option value='M'>Mandatory</option>";
                listItems += "<option value='E'>Elective</option>";
                listItems += '</select>';
                return listItems;
            }
            },
            { "sTitle": "GPA/Non GPA","bSortable": false,"mData": null,fnRender: function (oObj) {
                var listItems = '<select class="gpa" id="' + oObj.aData["user_id"] +'">';
                listItems += "<option value='0'>Select</option>";
                listItems += "<option value='G'>GPA</option>";
                listItems += "<option value='N'>Non GPA</option>";
                listItems += '</select>';
                return listItems;
            }
            }
        ]
    });

    if (old_allocate_data != "")
    {
        $("#example tbody tr").each(function (i)
        {
            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            for (var j = 0; j < old_allocate_data.length; j++)
            {
                if (old_allocate_data[j]["user_id"] == a["user_id"])
                {
                    $(this).find(".chk_course").prop('checked', true);
                    //$(this).find(".chk_course").attr("disabled", true);
                    $(this).find(".course_type").val(old_allocate_data[j]["course_type"]);

                    //if (old_allocate_data[j]["course_type"] == "E") {
                    $(this).find(".gpa").val(old_allocate_data[j]["gpa_nongpa"]);
                    //}
                }
            }
        });
    }


    if (allocate_user_data != "") {
        $("#example tbody tr").each(function (i)
        {
            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            for (var j = 0; j < allocate_user_data.length; j++)
            {
                //if (allocate_user_data[j]["user_id"] == a["user_id"])
                //if ('UI5017' == a["user_id"])
                //{
                    //$('#' + allocate_user_data[j]["user_id"]).attr("disabled", true); // Commit 09082021
                    disable_status = false;  
                //}
            }
            //if (disable_status)
            //{
            //    $('#' + a["user_id"]).attr("disabled", true);
               
            //}
            //disable_status = true;
        });
    }

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

        obj["user_id"] = $(this).children().eq(1).html();
        obj["cancel_flag"] = "Y";

        if ($(this).find(".chk_course").is(':checked')) {
            //obj["user_id"] = $(this).children().eq(1).html();

            obj["gpa_nongpa"] = "";
            if ($(this).find(".course_type").val() != '0') {
                obj["course_type"] = $(this).find(".course_type").val();

                //if ($(this).find(".course_type").val() == "E") {
                    if ($(this).find(".gpa").val() != '0') {
                        obj["gpa_nongpa"] = $(this).find(".gpa").val();
                    }
                    else {
                        //Remove Temparory 16072019
                        //flag = "Y";
                        //bootbox.alert("please select GPA/Non GPA for " + $(this).children().eq(1).html());
                        //return false;
                    }
                //}
            }
            else {
                //Remove Temparory 16072019
                //flag = "Y";
                //bootbox.alert("please select course_type for " + $(this).children().eq(1).html());
                //return false;
            }

            obj["cancel_flag"] = "N";
        }

        datalist.push(obj);
    });

    if (flag == "N") {
        var data = JSON.stringify({ manually_data: JSON.stringify(datalist), course_code: $('#drcourses').val(), sem_code: $('#drpsemester').val(), year: $('#drpyear').val(), dept_code: $('#drpdepartment').val(), prog_code: $('#drpprog').val() });

        $.ajax({
            type: "POST",
            url: "../../WebService.asmx/save_data_for_allocation",
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
                }
            },
            error: function (msg) { alert(msg.d); }
        });
    }
}


function user_select_change(cur_ele) {

    if (cur_ele.checked == false)
    {
        bootbox.confirm('You are sure that the manually allocation has to be removed?', function (result)
        {
            if (result == true) {
                $('#' + cur_ele.id + ' option[value=M]').removeAttr('selected');
                $('#' + cur_ele.id + ' option[value=E]').removeAttr('selected');
                $('#' + cur_ele.id + ' option[value=G]').removeAttr('selected');
                $('#' + cur_ele.id + ' option[value=N]').removeAttr('selected');
            }
            else {
                $('#' + cur_ele.id).attr('checked', true);
            }
        });
    }
}