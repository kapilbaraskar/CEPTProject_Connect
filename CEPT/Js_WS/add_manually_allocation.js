var oTable;
var old_allocate_data = "";

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
        url: "../../WebService_WS.asmx/Get_course_data",
        data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d);

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
                    .append('<option value="">No Data found</option>')
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

function bind_ws_course() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_ws_course_data",
        data: "{}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                var year_data = JSON.parse(data.d)

                $('#drcourses').empty().append($("<option></option>").val("").html("-- Please Select course --"));

                for (var i = 0; i < year_data.length; i++) {
                    $('#drcourses').append($("<option></option>").val(year_data[i]["course_code"]).html(year_data[i]["course_code"]));
                }

                $('#drcourses').chosen();
                //$('#drcourses').trigger("liszt:updated");
            }
        },
        error: function (result) {
            alert(result);
        }
    });
}

function get_ws_data_after_allocation() {
    $('#DataList').css('display', 'none');
    $('#div_student_list').css('display', 'none');
    $('#btnsave').css('display', 'none').closest('.copyright').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year of assign')
        $('#drpyear').focus();
        return false;
    }

    var course = $('#drcourses').val();
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
    
    var prog_code = '';
    if (dept_code != 7) {
        prog_code = $('#drpprog').val();

        if (prog_code == "") {
            bootbox.alert('Please select programme')
            $('#drpdepartment').focus();
            return false;
        }
    }
    var type = $('#drptype').val();
    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_all_student_data_for_manually_allocation",
        data: "{year_code:'" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',sem_code:'" + semester + "',course_code:'" + course + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d[0] != null)
            {
                //display_student_password_data(data.d);

                if (data.d[1] != null) {
                    old_allocate_data = JSON.parse(data.d[1]);
                }
                if (type == "T") {
                    debugger;
                    if (data.d[2] != null) {
                        Display_Student(data.d[2]);
                    }
                }
                else { Display(data.d[0]);}
                
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
           // { "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox" id=' + data.user_id + '  name="check1" value="1" class="chk_course" ></center>' },

            {
                "sTitle": "Select", "bSortable": false, "mData": null, fnRender: function (oObj) {
                    
                 return '<center><input type="checkbox" id=' + oObj.aData.user_id + '  name="check1" value="1" class="chk_course" ></center>';
                    
                    
                }
            },
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            {
                "sTitle": "Course Type", "bSortable": false, "mData": null, fnRender: function (oObj) {
                   
                var listItems = '<select class="course_type">';
                listItems += "<option value='0'>Select</option>";
                listItems += "<option value='M'>Mandatory</option>";
                listItems += "<option value='E'>Elective</option>";
                listItems += '</select>';
                return listItems;
            }
            },
            { "sTitle": "GPA/Non GPA","bSortable": false,"mData": null,fnRender: function (oObj) {
                var listItems = '<select class="gpa">';
                listItems += "<option value='0'>Select</option>";
                listItems += "<option value='G'>GPA</option>";
                listItems += "<option value='N'>Non GPA</option>";
                listItems += '</select>';
                return listItems;
            }
            },
            {
                "sTitle": "Select", "bSortable": false, "mData": null, fnRender: function (oObj) {

                    return '<center><input type="button" style="display:none;" id= ' + oObj.aData.user_id + ' onclick="rowClick_deallocate(this)"  class= btn_chk_course value=Deallocate ></center>';


                }
            },
        ]
    });

    if (old_allocate_data != "") {
        $("#example tbody tr").each(function (i) {
            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];

            for (var j = 0; j < old_allocate_data.length; j++) {
                if (old_allocate_data[j]["user_id"] == a["user_id"])
                {
                    $(this).find(".chk_course").hide();
                    $(this).find(".btn_chk_course").css('display','');
                    //$(this).find(".chk_course").prop('checked', true);
                    $(this).find(".course_type").val(old_allocate_data[j]["course_type"]);

                    //if (old_allocate_data[j]["course_type"] == "E") {
                    $(this).find(".gpa").val(old_allocate_data[j]["gpa_nongpa"]);
                    //}
                }
                
            }
        });
    }

    $('#DataList').css('display', 'block');
    $('#div_student_list').css('display', 'block');
    $('#btnsave').css('display', 'block').closest('.copyright').css('display', 'block');
}


function Display_Student(data) {
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
            // { "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox" id=' + data.user_id + '  name="check1" value="1" class="chk_course" ></center>' },

            
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
            { "sTitle": "Student Course Type", "mData": "course_type", "bSortable": false },
            {
                "sTitle": "Course Type", "bSortable": false, "mData": null, fnRender: function (oObj)
                {
                    var listItems = '<select class="course_type" id=' + oObj.aData.user_id +'_corusetype>';
                    listItems += "<option value='0'>Select</option>";
                    listItems += "<option value='M'>Mandatory</option>";
                    listItems += "<option value='E'>Elective</option>";
                    listItems += '</select>';
                    return listItems;
                }
            },
            {
                "sTitle": "Select", "bSortable": false, "mData": null, fnRender: function (oObj) {

                    return '<center><input type="button" style="display:block;" id= ' + oObj.aData.user_id + ' onclick="rowClick_change_course_type(this)"  class= btn_change_type_course value=Save ></center>';


                }
            },
        ]
    });

    $('#DataList').css('display', 'block');
    $('#div_student_list').css('display', 'block');
    $('#btnsave').css('display', 'block').closest('.copyright').css('display', 'none');
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

        //obj["user_id"] = $(this).children().eq(1).html();
        //obj["cancel_flag"] = "Y";

        if ($(this).find(".chk_course").is(':checked'))
        {
            obj["user_id"] = $(this).children().eq(1).html();
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
            datalist.push(obj);
        }

        //datalist.push(obj);
    });

    if (flag == "N") {
        var data = JSON.stringify({ manually_data: JSON.stringify(datalist), course_code: $('#drcourses').val(), sem_code: $('#drpsemester').val(), year: $('#drpyear').val(), dept_code: $('#drpdepartment').val(), prog_code: $('#drpprog').val() });

        $.ajax({
            type: "POST",
            url: "../../WebService_WS.asmx/save_data_for_allocation",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "error on course") {
                        bootbox.alert("Course data is not retrieve");
                        return false;
                    }

                    bootbox.alert(data.d);

                    $('#example tbody').html('');
                    $('#btnsave').css('display', 'none').closest('.copyright').css('display', 'none');
                    $('#DataList').css('display', 'none');
                    $('#div_student_list').css('display', 'none');
                }
            },
            error: function (msg) { alert(msg.d); }
        });
    }
}

function get_ws_data_before_allocation() {
    $('#DataList').css('display', 'none');
    $('#div_student_list').css('display', 'none');
    $('#btnsave').css('display', 'none').closest('.copyright').css('display', 'none');

    var semester = $('#drpsemester').val();
    if (semester == "") {
        bootbox.alert('Please select semester')
        $('#drpsemester').focus();
        return false;
    }

    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert('Please select Year of assign')
        $('#drpyear').focus();
        return false;
    }

    var course = $('#drcourses').val();
    if (course == "") {
        bootbox.alert('Please select course')
        $('#drcourses').focus();
        return false;
    }

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService_WS.asmx/Get_course_data_for_add_manually_before_allocation",
        data: "{year_code:'" + year_code + "',sem_code: '" + semester + "',course_code: '" + course + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "") {
                Display_data_before_allocation(data.d);
                //display_student_password_data(data.d);
            }
            else {
                bootbox.alert('There is No data Found For Selected Course');
                return false;
            }
        },
        error: function (result) {
            alert(result);
        }
    });

    return false;
}

function Display_data_before_allocation(data) {
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
            { "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_course" ></center>' },
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            //{ "sTitle": "Student Department", "mData": "dept_name", "bSortable": false }
            {"sTitle": "Corse Type", "bSortable": false, "mData": null, fnRender: function (oObj) {
                var listItems = '<select class="course_type">';
                listItems += "<option value='0'>Select</option>";
                listItems += "<option value='M'>Mandatory</option>";
                listItems += "<option value='E'>Elective</option>";
                listItems += '</select>';
                return listItems;
            }
            },
            { "sTitle": "GPA/Non GPA", "bSortable": false, "mData": null, fnRender: function (oObj) {
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

    $('#DataList').css('display', 'block');
    $('#div_student_list').css('display', 'block');
    $('#btnsave').css('display', 'block').closest('.copyright').css('display', 'block');
}

function save_ws_data_for_allocation() {
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

        if ($(this).find(".chk_course").is(':checked')) {
            obj["user_id"] = $(this).children().eq(1).html();

            obj["gpa_nongpa"] = "";
            if ($(this).find(".course_type").val() != '0') {
                obj["course_type"] = $(this).find(".course_type").val();

                if ($(this).find(".course_type").val() == "E") {
                    if ($(this).find(".gpa").val() != '0') {
                        obj["gpa_nongpa"] = $(this).find(".gpa").val();
                    }
                    else {
                        flag = "Y";
                        bootbox.alert("please select GPA/Non GPA for " + $(this).children().eq(1).html());
                        return false;
                    }
                }
            }
            else {
                flag = "Y";
                bootbox.alert("please select course_type for " + $(this).children().eq(1).html());
                return false;
            }

            datalist.push(obj);
        }
    });

    if (datalist.length == 0) {
        bootbox.alert('Please Select Course');
        return false;
    }

    if (flag == "N") {
        var data = JSON.stringify({ manually_data: JSON.stringify(datalist), course_code: $('#drcourses').val(), sem_code: $('#drpsemester').val(), year: $('#drpyear').val(), dept_code: '', prog_code: '' });

        $.ajax({
            type: "POST",
            url: "../../WebService_WS.asmx/save_ws_data_before_allocation",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {
                if (data.d != "") {
                    if (data.d == "error on course") {
                        bootbox.alert("Course data is not retrieve");
                        return false;
                    }

                    bootbox.alert(data.d);
                    $('#DataList').css('display', 'none');
                    $('#div_student_list').css('display', 'none');
                    $('#btnsave').css('display', 'none').closest('.copyright').css('display', 'none');
                }
            },
            error: function (msg) { alert(msg.d); }
        });
    }
}

function rowClick_deallocate(drp) {
    var sem_code = $('#drpsemester').val();
    if (sem_code == "") {
        bootbox.alert("Please Select Semester Type");
        return false;
    }
    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert("Please Select Year ");
        return false;
    }
    var course_code = $('#drcourses').val();
    if (course_code == "")
    {
        bootbox.alert("Please Select Course Code ");
        return false;
    }
    var r = confirm("Are u sure you want to Deallocate this Student ?");
    if (r == true) {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService_WS.asmx/sws_deallocate_course",
            async: false,
            data: "{course_code : '" + course_code + "',student_code : '" + drp.id + "',sem_code :'" + sem_code+"',year_code :'"+year_code+"'}",
            dataType: "json",
            success: function (data) {
                if (data.d == true) {
                    bootbox.alert('Course Deallocate Successfully', function () {
                        window.location.reload();

                    });
                }
                else {
                    bootbox.alert("Problem In Data");
                }
                return false;
            },
            error: function (result) {
                alert(result);
            }
        });
    }

}

function rowClick_change_course_type(coruse_dtl) {
    var sem_code = $('#drpsemester').val();
    if (sem_code == "") {
        bootbox.alert("Please Select Semester Type");
        return false;
    }
    var year_code = $('#drpyear').val();
    if (year_code == "") {
        bootbox.alert("Please Select Year ");
        return false;
    }
    var course_code = $('#drcourses').val();
    if (course_code == "") {
        bootbox.alert("Please Select Course Code ");
        return false;
    }
    var course_type = $('#' + coruse_dtl.id + '_corusetype').val();
    if (course_type == "")
    {
        bootbox.alert("Please Select Course Type ");
        return false;
    }
    Swal.fire({
        title: "Are u sure you want to change course type this Student ?",
        text: "",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes !"
    }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService_WS.asmx/sws_update_student_course_type",
                async: false,
                data: "{course_code : '" + course_code + "',student_code : '" + coruse_dtl.id + "',sem_code :'" + sem_code + "',year_code :'" + year_code + "',course_type :'" + course_type + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == true) {
                        Swal.fire({
                            text: "Student Change Course Type Successfully !",
                            icon: "success",
                            buttonsStyling: false,
                            confirmButtonText: "Ok, got it!",
                            customClass: {
                                confirmButton: "btn btn-primary"
                            }
                        }).then((result) => {
                            if (result.isConfirmed) {
                                $('#' + coruse_dtl.id).attr('disabled', true);
                                //location.reload();
                            }
                        });

                        //bootbox.alert('Student Change Course Type Successfully', function ()
                        //{
                        //    //    window.location.reload();
                        //    $('#' + coruse_dtl.id).attr('disabled', true);
                        //
                        //    
                        //
                        //
                        //});
                    }
                    else {
                        bootbox.alert("Problem In Data");
                    }
                    return false;
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
    });
}