<%@ Page Title="Feedback Instructor" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Course_Wise_Instructor_Feedback_Enable.aspx.cs" Inherits="Admin_Master_Course_Wise_Instructor_Feedback_Enable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <%-- <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>--%>

    <%--<link href="../../Style/csvstyle.css" rel="stylesheet" />--%>

    <style>
        .mrgnleft {
            margin-left: 5px;
        }
    </style>
    <script type="text/javascript">
        {
            var array;
            var un_check_datalist_user = [];
            $(document).ready(function () {
                bindsemdata();
                binddepartment();
                bindprogrammedata();
                bindyeardata_for_cross_reg();
                bindtype();
                //display_excel();
                //

                $('#drpsemester').on('change', function () {
                    if ($('#drpyear').val() != '') {
                        bind_sem_course();
                    }
                });

                $('#drpyear').on('change', function () {
                    if ($('#drpsemester').val() != '') {
                        bind_sem_course();
                    }
                });
                $('#btnreterive').on('click', function () {

                    get_data_for_allocation();
                    return false;
                });

                $('#btnsave').on('click', function () {
                    var status_flage = false;
                    $("#example tbody tr").each(function (i) {
                        var obj = {};
                        if ($(this).find(".chk_course").is(':checked')) {
                            status_flage = true;
                        }
                    });
                    if (status_flage == true) {
                        save_data_for_feedback();
                        return false;

                    }
                    else {
                        bootbox.alert("Please Select Student Code");
                        return false;
                    }
                });

                $('#btnenble').on('click', function () {
                    var status_flage = false;
                    $("#example tbody tr").each(function (i) {
                        var obj = {};
                        if ($(this).find(".chk_course").is(':checked')) {
                            status_flage = true;
                        }
                    });
                    if (status_flage == true) {
                        Enble_data_for_feedback();
                        return false;

                    }
                    else {
                        bootbox.alert("Please Select Course");
                        return false;
                    }
                });
            });

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

            function bindtype() {
                $('#drtype').empty().append($("<option></option>").val("").html("-- Please Select Type --"));

                $('#drtype').append($("<option></option>").val("E").html("Course Wise Feedback Enable"));
                $('#drtype').append($("<option></option>").val("D").html("Course Wise Feedback Disable"));

                $('#drtype').chosen();
            }


            function get_data_for_allocation() {
                $('#DataList').css('display', 'none');
                $('#btnsave').css('display', 'none');
                $('#btnexcel').css('display', 'none');

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

                var course_code = $('#drcourses').val();

                if (course_code == "") {
                    bootbox.alert('Please Select Course Code')
                    $('#drcourses').focus();
                    return false;
                }
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Get_instrctor_disable_for_feedback",
                        data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',course_code: '" + course_code + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != null && data.d != "") {

                                var student_dtl = JSON.parse(data.d);
                                $('#instructor_count').val(student_dtl[0]['inst_count']);
                                array = JSON.parse(data.d);
                                // $('#instructor_dtl').val(JSON.parse(data.d));
                                //Create_Dynamic_table(student_dtl);
                                Display(data.d);
                            }
                            else {
                                bootbox.alert('There is No data Found');
                                return false;
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                return false;
            }


            function Create_Dynamic_table(data_dtl) {
                var inst_cout;
                inst_cout = data_dtl[0]["inst_count"];
                var htmstr = "";
                htmstr = "<tr><th>Student Code</th><th>Student Name</th>";
                for (var i = 0; i < data_dtl[0]["inst_count"]; i++) {
                    htmstr += "<th>Instrctor</th>";
                }
                for (var k = 0; k < data_dtl.length; k++) {

                }
                $('#example').html(htmstr);
                $('#example').css('display', 'block');
                $('#DataList').css('display', 'block');

            }


            function Display(data) {
                if (oTable != null) {
                    oTable.fnDestroy();
                    $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" style="width:100%;"><thead style="width:100%;"></thead><tbody> </tbody></table>');
                }

                oTable = $("#example").dataTable({
                    "bPaginate": false,
                    "bSortable": false,
                    "bSort": false,
                    //"scrollY": 1000,

                    //"scrollY": "6000px",
                    //"scrollX": "600px",
                    //"sDom": 't',
                    "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                    //"oTableTools":
                    //{
                    //    "aButtons": [
                    //    
                    //	]
                    //},
                    "aaData": JSON.parse(data),

                    "aoColumns": [
                        //{ "sTitle": "Select", "mData": null, "bSortable": false, "sDefaultContent": '<center><input type="checkbox"  name="check1" value="1" class="chk_course" onchange="user_select_change(this)" ></center>' },
                        {
                            "sTitle": "<center><input type='checkbox' id='chk_select_all_student' onchange='select_all_student()' /> Select</center>", "mData": null, "bSortable": false, mRender: function (oObj) {
                                return '<center><input type="checkbox"  name="check_all_student" value="1" class="chk_course" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /></center>';
                            }

                        },
                        { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                        { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_0' onchange='select_all_change_0()' /> <span id='sp_0'>" + array[0]["instr_1"].replace('/E', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_0", mRender: function (oObj) {
                                if (oObj["instr_1"] != "") {
                                    var res = oObj["instr_1"].split(" ");
                                    if (oObj["instr_1"].substr(oObj["instr_1"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_0" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_1"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_0" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_0" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_0" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_1"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_0" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_0" /></center>';
                                    }

                                }
                                else {
                                    return "";
                                }

                            }

                        },

                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_1' onchange='select_all_change_1()' /> <span id='sp_1' >" + array[0]["instr_2"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_1", mRender: function (oObj) {
                                if (oObj["instr_2"] != "") {
                                    var res = oObj["instr_2"].split(" ");
                                    if (oObj["instr_2"].substr(oObj["instr_2"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_1" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_2"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_1" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_1" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_1" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_2"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_1" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_1" /></center>';
                                    }

                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_2' onchange='select_all_change_2()' /> <span id='sp_2' >" + array[0]["instr_3"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_2", mRender: function (oObj) {
                                if (oObj["instr_3"] != "") {
                                    var res = oObj["instr_3"].split(" ");
                                    if (oObj["instr_3"].substr(oObj["instr_3"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_2" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_3"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_2" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_2" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_2" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_3"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_2" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_2" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_3' onchange='select_all_change_3()' /> <span id='sp_3' >" + array[0]["instr_4"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_3", mRender: function (oObj) {
                                if (oObj["instr_4"] != "") {
                                    var res = oObj["instr_4"].split(" ");
                                    if (oObj["instr_4"].substr(oObj["instr_4"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_3" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_4"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_3" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_3" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_3" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_4"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_3" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_3" /></center> ';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_4' onchange='select_all_change_4()' /> <span id='sp_4' >" + array[0]["instr_5"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_4", mRender: function (oObj) {
                                if (oObj["instr_5"] != "") {
                                    var res = oObj["instr_5"].split(" ");
                                    if (oObj["instr_5"].substr(oObj["instr_5"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_4" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_5"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_4" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_4" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_4" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_5"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_4" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_4" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_5' onchange='select_all_change_5()' /> <span id='sp_5' >" + array[0]["instr_6"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_5", mRender: function (oObj) {
                                if (oObj["instr_6"] != "") {
                                    var res = oObj["instr_6"].split(" ");
                                    if (oObj["instr_6"].substr(oObj["instr_6"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_5" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_6"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_5" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_5" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_5" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_6"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_5" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_5" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_6' onchange='select_all_change_6()' /> <span id='sp_6' >" + array[0]["instr_7"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_6", mRender: function (oObj) {
                                if (oObj["instr_7"] != "") {
                                    var res = oObj["instr_7"].split(" ");
                                    if (oObj["instr_7"].substr(oObj["instr_7"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_6" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_7"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_6" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_6" Checked/></center> ';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_6" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_7"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_6" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_6" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_7' onchange='select_all_change_7()' /> <span id='sp_7' >" + array[0]["instr_8"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_7", mRender: function (oObj) {
                                if (oObj["instr_8"] != "") {
                                    var res = oObj["instr_8"].split(" ");
                                    if (oObj["instr_8"].substr(oObj["instr_8"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_7" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_8"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_7" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_7" Checked/></center>';
                                    }
                                    else {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_7" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_8"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_7" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_7" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_8' onchange='select_all_change_8()' /> <span id='sp_8' >" + array[0]["instr_9"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_8", mRender: function (oObj) {
                                if (oObj["instr_9"] != "") {
                                    var res = oObj["instr_9"].split(" ");
                                    if (oObj["instr_9"].substr(oObj["instr_9"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_8" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_9"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_8" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_8" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_8" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_9"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_8" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_8" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_9' onchange='select_all_change_9()' /> <span id='sp_9' >" + array[0]["instr_10"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_9", mRender: function (oObj) {
                                if (oObj["instr_10"] != "") {
                                    var res = oObj["instr_10"].split(" ");
                                    if (oObj["instr_10"].substr(oObj["instr_10"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_9" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_10"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_9" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_9" Checked/></center>';
                                    }
                                    else {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_9" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_10"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_9" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_9" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_10' onchange='select_all_change_10()' /> <span id='sp_10' >" + array[0]["instr_11"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_10", mRender: function (oObj) {
                                if (oObj["instr_11"] != "") {
                                    var res = oObj["instr_11"].split(" ");
                                    if (oObj["instr_11"].substr(oObj["instr_11"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_10" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_11"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_10" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_10" Checked/></center>';
                                    }
                                    else {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_10" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_11"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_10" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_10" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        }, {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_11' onchange='select_all_change_11()' /> <span id='sp_11' >" + array[0]["instr_12"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_11", mRender: function (oObj) {
                                if (oObj["instr_12"] != "") {
                                    var res = oObj["instr_12"].split(" ");
                                    if (oObj["instr_12"].substr(oObj["instr_12"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_11" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_12"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_11" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_11" Checked/></center>';
                                    }
                                    else {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_11" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_12"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_11" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_11" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        },
                        {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_12' onchange='select_all_change_12()' /> <span id='sp_12' >" + array[0]["instr_13"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_12", mRender: function (oObj) {
                                if (oObj["instr_13"] != "") {
                                    var res = oObj["instr_14"].split(" ");
                                    if (oObj["instr_13"].substr(oObj["instr_13"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_12" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_13"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_12" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_12" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_12" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_13"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_12" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_12" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        }, {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_13' onchange='select_all_change_13()' /> <span id='sp_13' >" + array[0]["instr_14"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_13", mRender: function (oObj) {
                                if (oObj["instr_14"] != "") {
                                    var res = oObj["instr_14"].split(" ");
                                    if (oObj["instr_14"].substr(oObj["instr_14"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_13" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_14"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_13" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_13" Checked/></center>';
                                    }
                                    else {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_13" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_14"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_13" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_13" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        }, {
                            "sTitle": "<input type='checkbox'  name='check1' value='1' class='chk_course' id='id_14' onchange='select_all_change_14()' /> <span id='sp_14' >" + array[0]["instr_15"].replace('/E', '').replace('/D', '').trim() + "</span>", "mData": null, "bSortable": false, "sClass": "cls_hide_14", mRender: function (oObj) {
                                if (oObj["instr_15"] != "") {
                                    var res = oObj["instr_15"].split(" ");
                                    if (oObj["instr_15"].substr(oObj["instr_15"].length - 1) == "E" && oObj["Disable_instructor_code"] != "") {
                                        //return '<input type="checkbox"  name="check1" value="1" class="chk_course_14" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" Checked/> '+oObj["instr_15"].replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_14" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_14" Checked/></center>';
                                    }
                                    else {
                                        // return '<input type="checkbox"  name="check1" value="1" class="chk_course_14" onchange="user_select_change(this)" id="' + oObj["user_id"] + '" /> '+oObj["instr_15"].replace('/D',"").replace('/E',"")+' ';
                                        return '<center><input type="checkbox"  name="check1" value="1" class="chk_course_14" onchange="user_select_change(this)" id="' + oObj["user_id"] + '_14" /></center>';
                                    }
                                }
                                else {
                                    return "";
                                }

                            }

                        }
                        //{ "sTitle": "Department Name", "mData": "dept_name", "bSortable": false }
                    ]
                });


                $('#DataList').css('display', 'block');
                $('#btnsave').css('display', 'block');
                $('#btnreterive').css('margin-top', '-35px');

                $('#btnexcel').css('display', 'block');

                for (var k = 0; k < 15; k++) {
                    var inst_count = $('#instructor_count').val();
                    var value = parseInt(inst_count) + parseInt(k);
                    $('.cls_hide_' + value).css('display', 'none');

                }
                $("#example tbody tr").each(function (i) {
                    var value = parseInt(inst_count) + parseInt(3);
                    for (var k = value; k < 15; k++) {                                         //var values = parseInt(inst_count) + parseInt(k) + parseInt(3) ;
                        $('#example tbody tr')[i].children[k].style.display = 'none';
                        $('#example tbody tr')[i].children[k].style.display = 'none';
                    }

                });

            }

            function user_select_change() { }
            function save_data_for_feedback() {
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
                        for (var k = 0; k < $('#instructor_count').val(); k++) {
                            if ($(this).find(".chk_course_" + k).is(':checked')) {
                                obj = {};
                                obj["user_id"] = $(this).children().eq(1).html();

                                //var select_code = parseInt(k) + parseInt($('#instructor_count').val()) ;
                                var select_code = parseInt(k) + parseInt(3);

                                var inst_code = $('#sp_' + k).text().split('('); //$(this).children().eq(select_code).text().split('(');

                                obj["inst_code"] = inst_code[1].trim().replace(')', '').replace('/D', '').replace('/E', '');
                                obj["cancel_flag"] = "Y";
                                datalist.push(obj);
                            }
                            else {
                                obj = {};
                                obj["user_id"] = $(this).children().eq(1).html();
                                var select_code = parseInt(k) + parseInt(3);

                                var inst_code = $('#sp_' + k).text().split('('); //$(this).children().eq(select_code).text().split('(');
                                obj["inst_code"] = inst_code[1].trim().replace(')', '').replace('/D', '').replace('/E', '');
                                //obj["course_code"] = $(this).children().eq(1).html();
                                obj["cancel_flag"] = "N";
                                datalist.push(obj);
                            }

                        }
                    }
                });

                if (flag == "N") {
                    var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val(), course_code: $('#drcourses').val() });

                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/Feedback_Enable_Inst_dtl",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "Problem in save data") {
                                    bootbox.alert("Problem in save data");
                                    return false;
                                }
                                get_data_for_allocation();
                                bootbox.alert("Data Saved Successfully");
                                //return false;
                            }
                        },
                        error: function (msg) { alert(msg.d); }
                    });
                }
            }
            function Enble_data_for_feedback() {
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
                        obj["course_code"] = $(this).children().eq(1).html();
                        obj["cancel_flag"] = "Y";
                        datalist.push(obj);

                    }


                });

                if (flag == "N") {
                    var data = JSON.stringify({ manually_data: JSON.stringify(datalist), sem_code: $('#drpsemester').val(), year_code: $('#drpyear').val(), feedback_disable_type: 'FCD' });

                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/Enable_Feedback_course_dtl",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "Problem in Update data") {
                                    bootbox.alert("Problem in Update data");
                                    return false;
                                }
                                get_data_for_allocation();
                                bootbox.alert("Data Update Successfully");
                                //return false;
                            }
                        },
                        error: function (msg) { alert(msg.d); }
                    });
                }
            }
            function select_all_change_0() {
                check_unchek_inst('0');
            }
            function select_all_change_1() {
                check_unchek_inst('1');
            }
            function select_all_change_2() {
                check_unchek_inst('2');
            }
            function select_all_change_3() {
                check_unchek_inst('3');
            }
            function select_all_change_4() {
                check_unchek_inst('4');
            }


            function select_all_change_5() {

                check_unchek_inst('5');
            }

            function select_all_change_6() {
                check_unchek_inst('6');
            }
            function select_all_change_7() {
                check_unchek_inst('7');
            }
            function select_all_change_8() {
                check_unchek_inst('8');
            }
            function select_all_change_9() {
                check_unchek_inst('9');
            }
            function select_all_change_10() {
                check_unchek_inst('10');
            }

            function select_all_change_11() {
                check_unchek_inst('11');
            }

            function select_all_change_12() {
                check_unchek_inst('12');
            }
            function select_all_change_13() {
                check_unchek_inst('13');
            }

            function select_all_change_14() {
                check_unchek_inst('14');
            }

            function display_excel() {

                var semester = $('#drpsemester').val();
                $('#hdn_semester').val(semester);
                var year_code = $('#drpyear').val();
                $('#hdn_year').val(year_code);
                var course_code = $('#drcourses').val();
                $('#hdn_code').val(course_code);
                $("#btnDownloadExcelDocuments").click();
                return false;
            }

            function check_unchek_inst(id) {
                if ($('#id_' + id)[0].checked) {
                    var status_flage = false;
                    var un_check_status = false;
                    var datalist_user = [];

                    $("#example tbody tr").each(function (i) {
                        var obj = {};
                        if ($(this).find(".chk_course").is(':checked')) {
                            obj["user_id"] = $(this).children().eq(1).html();
                            datalist_user.push(obj);
                            status_flage = true;
                        }
                    });


                    if (status_flage == false) {
                        $('#id_' + id).removeAttr('checked');
                        bootbox.alert("Please Select Student To Assign Instructor");
                        return false;
                    }


                    for (var p = 0; p < datalist_user.length; p++) {
                        $('#' + datalist_user[p]["user_id"] + '_' + id).attr('checked', 'checked');
                    }
                }

                else {
                    $("#example tbody tr").each(function (i) {
                        var obj = {};
                        un_check_datalist_user = [];
                        if ($(this).find(".chk_course").is(':checked')) {
                            obj["user_id"] = $(this).children().eq(1).html();
                            un_check_datalist_user.push(obj);
                            un_check_status = true;
                        }

                        if (un_check_status == true) {
                            for (var p = 0; p < un_check_datalist_user.length; p++) {
                                $('#' + un_check_datalist_user[p]["user_id"] + '_' + id).removeAttr('checked');
                            }
                        }

                    });

                }
            }

            function select_all_student() {
                if ($('#chk_select_all_student')[0].checked) {
                    $("input[name='check_all_student']").attr('checked', 'checked');
                }
                else {
                    $("input[name='check_all_student']").removeAttr('checked');
                }
            }

        }
    </script>
    <style type="text/css">
        tfoot {
            display: table-header-group;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Course Wise FeedBack Instructor Enable
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>Semester Type :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <%-- <td>
                                Course of Assign :
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses">
                                </select>
                            </td>--%>
                            <td>Course Code :
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses">
                                </select>
                            </td>
                        </tr>
                        <tr>

                            <%--<td>Student Programme
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                            <td>Type
                            </td>
                            <td>
                                <select class="chosen-select" id="drtype">
                                </select>
                            </td>--%>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive">
                                    Retrieve
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnsave" style="display: none; margin-top: -5px; float: left;">
                                    Save
                                </button>
                                <input id="btnexcel" type="button" class="btn btn-primary" value="Export Excel" onclick="display_excel()" style="display: none; float: left; margin-left: 29px; margin-top: -5px;" />
                                <%--<button class="btn btn-primary" type="submit" id="btnexcel" onclick="display_excel()" style="display: none;float:right;">
                                    Excel
                                </button>--%>
                                
                            </td>


                        </tr>
                    </table>
                </div>
            </div>

            <div id="DataList" style="display: none; overflow: auto;">
                <%--<div class="panel-heading" id="header_excel" style="color: #333;background-color: #f5f5f5; border-color: #ddd;">
                <strong>Student Details</strong>
                <span style="float: right;">
                    
                   <input id="btn_excel" type="button" class="btn btn-primary" value="Excel" style="height: 40px; margin-top: -10px;" onclick="display_excel()" />
                    
                </span>
            </div>--%>

                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px; display: none;">
                <div class="container">
                    <div class="row-fluid">
                        <div class="span11" style="margin-top: 10px">
                            <table style="width: 100%" align="center" border="0" cellpadding="3" cellspacing="5">
                                <tr>
                                    <td align="center">
                                        <button id="btnsave" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                            <i class="icon-save bigger-160"></i>Save
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <!--/row-fluid-->
                </div>
                <!--/container-->
            </div>
        </div>

    </div>
    <input type="hidden" id="hdn_Course_wise_instructor_dtl" runat="server" clientidmode="Static" />
    <input type="hidden" id="instructor_count" runat="server" clientidmode="Static" />
    <input type="hidden" id="instructor_dtl" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_semester" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadExcelDocuments_Click" ClientIDMode="Static" />
</asp:Content>

