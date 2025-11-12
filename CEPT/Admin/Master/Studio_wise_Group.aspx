<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Studio_wise_Group.aspx.cs" Inherits="Admin_Master_Studio_wise_Group" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .cls_td_instructor {
            border-top: none !important;
            padding-top: 0 !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Retrieve Course Data</span></strong>
            </div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Semester :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpsem">
                            <option value="M">Monsoon</option>
                            <option value="S">Spring</option>
                        </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Year :
                    </div>
                    <div id="div_cur_sem_course" class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpyear">
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <button class="btn btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                        <button style="display: none;" class="btn btn-primary" type="button" id="btnRetrievetest">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Program :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpprog">
                        </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Program Level :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpproglevel">
                        </select>
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px; display: none;">
                        Department
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px; display: none;">
                        <select class="chosen-select" id="drpdepartment">
                        </select>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Course :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpcourse">
                        </select>
                    </div>
                    <div class="form-group col-md-1" style="padding-top: 8px;">
                        Sub Studio :
                    </div>
                    <div class="form-group col-md-3" style="padding-top: 6px;">
                        <select class="chosen-select" id="drpsubstudio">
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div style="display: none;" id="div_select_group_data" class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Select Group</span></strong>
            </div>
            <div style="padding: 15px;" id="div1">
                <div class="row">
                    <div class="form-group col-md-2" style="">
                        Select Group Type:
                    </div>
                    <div class="form-group col-md-8" style="">
                        <div class="form-group col-md-2" style="">
                            <input type="radio" id="radioindividual" name="group" value="I" checked />
                            Individual
                        </div>
                        <div class="form-group col-md-2" style="">
                            <input type="radio" id="radiogroups" name="group" value="G" />
                            Groups<br>
                        </div>
                    </div>
                </div>
                <div class="row" id="div_group" style="display: none; margin-top: 15px;">
                    <div class="form-group col-md-1" style="">
                        Select Group :
                    </div>
                    <div class="form-group col-md-3" style="">
                        <select class="chosen-select" id="drpgroup">
                            <option value="0">--Select Group--</option>
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                            <option value="19">19</option>
                            <option value="20">20</option>
                        </select>
                    </div>
                    <div class="form-group col-md-1" style="">
                        Project :
                    </div>
                    <div class="form-group col-md-3" style="">
                        <select class="chosen-select" id="drpproject">
                            <option value="Y">Yes</option>
                            <option value="N">No</option>
                        </select>
                    </div>
                </div>

                <div id="div_group_title_instructor" class="row" style="margin-top: 15px;">
                </div>

                <div id="div_photo_for_projects" class="row" style="margin-top: 0;">
                </div>
            </div>
        </div>
        <div id="DataList" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Select Student Group</span></strong>
            </div>
            <div id="studiocourse" class="tab-pane">
                <div>
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <table style="width: 100%; margin-top: 10px;">
            <tr>
                <td align="center" style="padding-left: 75px;">
                    <button id="btnsave" type="button" style="display: none" class="btn btn-lg btn-primary">
                        <i class="icon-save bigger-160"></i>Save
                    </button>
                </td>
            </tr>
        </table>
    </div>
    <script type="text/javascript">
        var oTable1;
        var student_data = '';
        var course_instructor_data = '';
        var student_saved_data = '';
        var course_saved_data = '';
        var instructor_group_saved_data = '';

        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindprogrammedata();
            bindproglevel();
            binddepartment();
            get_fauser_detail();

            var cur_sem;
            var cur_year;
            var prog_code;
            var prog_level_code;
            var course_code;
            var sub_studio;

            $('#btnRetrievetest').on('click', function () {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/test_sp",
                    async: false,
                    data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',course_code: '" + course_code + "',studio_type:''}",
                    dataType: "json",
                    success: function (data) {
                    }
                });
            });

            $('#btnRetrieve').on('click', function () {
                $('#radioindividual').prop('checked', true);
                $('#div_group').css('display', 'none');

                $('#div_group_title_instructor').html('');
                $('#div_photo_for_projects').html('');
                $('#drpgroup').val('0');

                cur_sem = $('#drpsem').val();
                if (cur_sem == "") {
                    bootbox.alert('Please select semester');
                    $('#drpsem').focus();
                    return false;
                }

                cur_year = $('#drpyear').val();
                if (cur_year == "") {
                    bootbox.alert('Please select Year');
                    $('#drpyear').focus();
                    return false;
                }

                course_code = $('#drpcourse').val();
                if (course_code == "") {
                    bootbox.alert('Please select course');
                    $('#drpcourse').focus();
                    return false;
                }

                sub_studio = $('#drpsubstudio').val();
                if (sub_studio == "" || sub_studio == null) {
                    //bootbox.alert('Please select sub studio');
                    //$('#drpsubstudio').focus();
                    //return false;
                    //sub_studio = course_code;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_studio_course_allocate_student_data_list",
                    async: false,
                    data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',course_code: '" + course_code + "' ,sub_studio :'" + sub_studio + "'}",
                    dataType: "json",
                    success: function (data) {
                        //display_data(data.d);
                        if (data.d[5] != null) {
                            bootbox.alert(data.d[5]);
                            return false;
                        }

                        if (data.d[1] != null) {
                            course_instructor_data = JSON.parse(data.d[1]);
                        }
                        else {
                            course_instructor_data = '';
                        }

                        if (data.d[2] != null) {
                            student_saved_data = JSON.parse(data.d[2]);
                        }
                        else {
                            student_saved_data = '';
                        }

                        if (data.d[3] != null) {
                            course_saved_data = JSON.parse(data.d[3]);
                        }
                        else {
                            course_saved_data = '';
                        }

                        if (data.d[4] != null) {
                            instructor_group_saved_data = JSON.parse(data.d[4]);
                        }
                        else {
                            course_saved_data = '';
                        }

                        if (data.d[0] != null) {

                            display_data(data.d[0])
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                //var contact = {
                //    "Name": "John Doe",
                //    "PermissionToCall": true,
                //    "PhoneNumbers": [
                //  {
                //      "Location": "Home",
                //      "Number": "555-555-1234"
                //  },
                //  {
                //      "Location": "Work",
                //      "Number": "555-555-9999 Ext. 123"
                //  }
                //]
                //           };

                //$.ajax({
                //    type: "POST",
                //    contentType: "application/json; charset=utf-8",
                //    url: "../../WebService.asmx/test_json",
                //    async: false,
                //    data: "{contact :'" + JSON.stringify(contact) + "' }",
                //    dataType: "json",
                //    success: function (data) {

                //    },
                //    error: function (result) {
                //        alert(result);
                //    }
                //});
            });

            $('#drpgroup').on('change', function () {
                var value = $('#drpgroup').val();

                var listitem = '';

                if (value == 0) {
                    listitem = '';
                }
                var title_data = '';
                var str_photo_for_projects = '';

                for (var i = 1; i <= value; i++) {

                    listitem += '<option value="' + i + '">' + i + '</option>';

                    title_data += '<div class="row" style="padding-left: 15px; padding-right: 15px;"> ' +
                        '<div class="form-group col-md-1" style="">' +
                        '<b>Group ' + i + ' title</b>' +
                        '</div>' +
                        '<div class="form-group col-md-3" style=""><input type="text" id="group_' + i + '_title"> ' +
                        '</div>' +
                        '</div>';

                    //if (course_instructor_data != '') {
                    //    title_data += '<div class="row" style="padding-left: 15px; padding-right: 15px;">';
                    //    title_data += '<div class="form-group col-md-2" style=""><b>Instructor</b></div>';
                    //    title_data += '<div class="form-group col-md-9" style="">';
                    //    title_data += '<table class="table" id="group_' + i + '_instructor"> ';
                    //    for (var j = 0; j < course_instructor_data.length; ) {
                    //        title_data += '<tr> ';
                    //        for (var k = 0; k < 4; k++) {
                    //            if (j >= course_instructor_data.length) {
                    //                break;
                    //            }
                    //            title_data += '<td class="cls_td_instructor"><input type="checkbox" value="' + course_instructor_data[j]["instructor_code"] + '"> ' + course_instructor_data[j]["instructor_name"] + '</td>';
                    //            j++;
                    //        }
                    //        title_data += '</tr>';
                    //    }
                    //    title_data += '</table></div>';
                    //    title_data += '</div>';
                    //}
                }

                if (course_instructor_data != '') {
                    var list_item = '<option value="0">-select-</option>';

                    for (var i = 0; i < course_instructor_data.length; i++) {

                        list_item += '<option value="' + (i + 1) + '">' + (i + 1) + '</option>';
                    }

                    title_data += '<div class="row" style="padding-left: 15px; padding-right: 15px;">';
                    title_data += '<div class="form-group col-md-2" style=""><b>Instructor</b></div>';
                    title_data += '<div class="form-group col-md-9" style="">';
                    title_data += '<table class="table" id="group_instructor"> ';

                    for (var j = 0; j < course_instructor_data.length;) {
                        title_data += '<tr> ';

                        for (var k = 0; k < 4; k++) {
                            if (j >= course_instructor_data.length) {
                                break;
                            }

                            title_data += '<td class="cls_td_instructor"><select class="priority" style="width: 50px;" class="chosen-select" id="' + course_instructor_data[j]["instructor_code"] + '">' + list_item + ' </select> ' + course_instructor_data[j]["instructor_name"] + '</td>';
                            j++;
                        }

                        title_data += '</tr>';
                    }

                    title_data += '</table></div>';
                    title_data += '</div>';


                    str_photo_for_projects += '<div class="form-group col-md-2"><b>Use Photo For Projects Portal</b></div>';
                    str_photo_for_projects += '<div class="form-group col-md-9">';
                    str_photo_for_projects += '<table class="table" id="tbl_photo_for_projects"> ';

                    for (var j = 0; j < course_instructor_data.length;) {
                        str_photo_for_projects += '<tr>';

                        for (var k = 0; k < 4; k++) {
                            if (j >= course_instructor_data.length) {
                                break;
                            }

                            str_photo_for_projects += '<td class="cls_td_instructor"><input type="checkbox" id="chk_' + course_instructor_data[j]["instructor_code"] + '" style="margin-top: 0;" />&nbsp;' + course_instructor_data[j]["instructor_name"] + '</td>';
                            j++;
                        }

                        str_photo_for_projects += '</tr>';
                    }

                    str_photo_for_projects += '</table></div>';
                    str_photo_for_projects += '</div>';
                }

                $('#div_group_title_instructor').html('');
                $('#div_photo_for_projects').html('');

                if (value != 0) {
                    $('#div_group_title_instructor').append(title_data);
                    $('#div_photo_for_projects').append(str_photo_for_projects);
                }

                $("#example tbody tr").each(function (i) {
                    var aPos = oTable1.fnGetPosition(this);
                    var aData = oTable1.fnGetData(aPos[i]);
                    var a = aData[i];

                    $(this).find(".cls_student_group_selection").empty();
                    $(this).find(".cls_student_group_selection").append(listitem);

                    if (student_saved_data != "") {
                        for (var j = 0; j < student_saved_data.length; j++) {
                            if (student_saved_data[j]["user_id"] == a["user_id"]) {
                                if (student_saved_data[j]["representative"] == 'Y') {
                                    $(this).find(".chk_group_Representative").prop('checked', true);
                                }
                                if (student_saved_data[j]["group_code"] != '') {
                                    $(this).find(".cls_student_group_selection").val(student_saved_data[j]["group_code"]);
                                }
                            }
                        }
                    }
                });

                if (course_saved_data != '' && course_saved_data != undefined) {
                    for (var i = 0; i < course_saved_data.length; i++) {
                        $('#group_' + course_saved_data[i]["group_code"] + '_title').val(course_saved_data[i]["group_title"]);
                        //var instructor = course_saved_data[i]["primary_instructor"].split('~');
                        //for (var j = 0; j < instructor.length; j++) {
                        //    $("#group_" + course_saved_data[i]["group_code"] + "_instructor :checkbox[value=" + instructor[j] + "]").prop("checked", "true");
                        //}
                    }
                }

                if (instructor_group_saved_data != '' && instructor_group_saved_data != undefined) {
                    for (var i = 0; i < instructor_group_saved_data.length; i++) {
                        $("#" + instructor_group_saved_data[i]["instructor_code"]).val(instructor_group_saved_data[i]["priority"]);

                        if (instructor_group_saved_data[i]["is_photo_for_projects"] == 'Y')
                            $("#chk_" + instructor_group_saved_data[i]["instructor_code"])[0].checked = true;
                        else
                            $("#chk_" + instructor_group_saved_data[i]["instructor_code"])[0].checked = false;
                    }
                }
            });

            $('#drpcourse,#drpsubstudio').on('change', function () {
                $('#DataList,#div_select_group_data,#btnsave').css('display', 'none');
            });

            $('#drpsem,#drpyear,#drpprog,#drpproglevel').on('change', function () {
                $('#DataList,#div_select_group_data,#btnsave').css('display', 'none');

                cur_sem = $('#drpsem').val();
                if (cur_sem == "") {
                    bootbox.alert('Please select semester');
                    $('#drpsem').focus();
                    return false;
                }

                cur_year = $('#drpyear').val();
                if (cur_year == "") {
                    bootbox.alert('Please select Year');
                    $('#drpyear').focus();
                    return false;
                }

                dept_code = $('#drpdepartment').val();
                if (dept_code == "") {
                    bootbox.alert('Please select Department');
                    $('#drpdepartment').focus();
                    return false;
                }

                prog_code = $('#drpprog').val();
                prog_level_code = $('#drpproglevel').val();

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_studio_course_data_for_group_entry",
                    async: false,
                    data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',prog_level_code:'" + prog_level_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        //display_data(data.d);

                        if (data.d != "") {
                            var course_data = JSON.parse(data.d)

                            $('#drpcourse').empty();
                            for (var i = 0; i < course_data.length; i++) {
                                $('#drpcourse').append($("<option></option>").val(course_data[i]["course_code"]).html(course_data[i]["course_code"]));
                            }

                            $('#drpcourse').chosen();
                            $("#drpcourse").trigger("liszt:updated");
                            $('#drpcourse').trigger("change");
                        }
                        else {
                            $('#drpcourse').find('option').remove().end().append('<option value="">No data found</option>').val('');
                            $('#drpcourse').chosen();
                            $('#drpcourse').val('').trigger("liszt:updated");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            });

            $('#drpsem,#drpyear,#drpcourse').on('change', function () {
                $('#DataList,#div_select_group_data,#btnsave').css('display', 'none');
                cur_sem = $('#drpsem').val();
                cur_year = $('#drpyear').val();
                var course_code = $('#drpcourse').val();

                if (cur_sem == '' || cur_year == '' || course_code == '') {
                    $('#drpsubstudio').find('option').remove().end().append('<option value="">No data found</option>').val('');
                    $('#drpsubstudio').chosen();
                    $('#drpsubstudio').val('').trigger("liszt:updated");
                    return false;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_divide_studio_data_list",
                    async: false,
                    data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',course_code: '" + course_code + "',studio_type:'sub'}",
                    dataType: "json",
                    success: function (data) {
                        //display_data(data.d);
                        if (data.d != "") {
                            var studio_data = JSON.parse(data.d)
                            $('#drpsubstudio').empty();
                            for (var i = 0; i < studio_data.length; i++) {
                                $('#drpsubstudio').append($("<option></option>").val(studio_data[i]["sub_studio_name"]).html(studio_data[i]["sub_studio_name"]));
                            }

                            $('#drpsubstudio').chosen();
                            $("#drpsubstudio").trigger("liszt:updated");
                        }
                        else {
                            $('#drpsubstudio').find('option').remove().end().append('<option value="">No data found</option>').val('');
                            $('#drpsubstudio').chosen();
                            $('#drpsubstudio').val('').trigger("liszt:updated");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            });

            $("input[name='group']").click(function () {
                var valuestudio = $('input:radio[name=group]:checked').val();

                if (valuestudio == 'G') {
                    $('#div_group').css('display', 'block');
                    $('#div_group_title_instructor').html('');
                    $('#div_photo_for_projects').html('');
                    $('#drpgroup').change();
                }
                else {
                    var title_data = '';
                    var str_photo_for_projects = '';
                    if (course_instructor_data != '') {
                        var list_item = '<option value="0">-select-</option>';
                        for (var i = 0; i < course_instructor_data.length; i++) {
                            list_item += '<option value="' + (i + 1) + '">' + (i + 1) + '</option>';
                        }

                        title_data += '<div class="row" style="padding-left: 15px; padding-right: 15px;">';
                        title_data += '<div class="form-group col-md-2" style=""><b>Instructor</b></div>';
                        title_data += '<div class="form-group col-md-9" style="">';
                        title_data += '<table class="table" id="group_instructor"> ';
                        for (var j = 0; j < course_instructor_data.length;) {
                            title_data += '<tr> ';

                            for (var k = 0; k < 4; k++) {
                                if (j >= course_instructor_data.length) {
                                    break;
                                }

                                title_data += '<td class="cls_td_instructor"><select class="priority" style="width: 50px;" class="chosen-select" id="' + course_instructor_data[j]["instructor_code"] + '">' + list_item + ' </select> ' + course_instructor_data[j]["instructor_name"] + '</td>';
                                j++;
                            }

                            title_data += '</tr>';
                        }
                        title_data += '</table></div>';
                        title_data += '</div>';

                        str_photo_for_projects += '<div class="form-group col-md-2"><b>Use Photo For Projects Portal</b></div>';
                        str_photo_for_projects += '<div class="form-group col-md-9">';
                        str_photo_for_projects += '<table class="table" id="tbl_photo_for_projects"> ';
                        for (var j = 0; j < course_instructor_data.length;) {
                            str_photo_for_projects += '<tr>';

                            for (var k = 0; k < 4; k++) {
                                if (j >= course_instructor_data.length) {
                                    break;
                                }

                                str_photo_for_projects += '<td class="cls_td_instructor"><input type="checkbox" id="chk_' + course_instructor_data[j]["instructor_code"] + '" style="margin-top: 0;" />&nbsp;' + course_instructor_data[j]["instructor_name"] + '</td>';
                                j++;
                            }

                            str_photo_for_projects += '</tr>';
                        }
                        str_photo_for_projects += '</table></div>';
                        str_photo_for_projects += '</div>';
                    }

                    $('#div_group_title_instructor').html('');
                    $('#div_photo_for_projects').html('');
                    $('#div_group_title_instructor').append(title_data);
                    $('#div_photo_for_projects').append(str_photo_for_projects);

                    if (instructor_group_saved_data != '' && instructor_group_saved_data != undefined) {
                        for (var i = 0; i < instructor_group_saved_data.length; i++) {
                            $("#" + instructor_group_saved_data[i]["instructor_code"]).val(instructor_group_saved_data[i]["priority"]);

                            if (instructor_group_saved_data[i]["is_photo_for_projects"] == 'Y')
                                $("#chk_" + instructor_group_saved_data[i]["instructor_code"])[0].checked = true;
                            else
                                $("#chk_" + instructor_group_saved_data[i]["instructor_code"])[0].checked = false;
                        }
                    }

                    $('#div_group').css('display', 'none');
                }
                $('#drpgroup').val('');
            });

            $('#btnsave').on('click', function () {
                var oSettings = oTable1.fnSettings();
                for (iCol = 0; iCol < oSettings.aoPreSearchCols.length; iCol++) {
                    oSettings.aoPreSearchCols[iCol].sSearch = '';
                }

                oSettings.oPreviousSearch.sSearch = '';
                oTable1.fnDraw();

                var valuestudio = $('input:radio[name=group]:checked').val();

                var datalist = [];
                var instructor_datalist = [];

                var flag = 'Y';

                if (valuestudio == 'G') {
                    if ($('#drpgroup').val() == 0) {
                        bootbox.alert('Please select Group');
                        return false;
                    }

                    var value = $('#drpgroup').val();
                    for (var i = 1; i <= value; i++) {
                        var obj = {};

                        obj["selected_group"] = $('#drpgroup').val();
                        obj["group_code"] = i;
                        obj["project"] = $('#drpproject').val();

                        if ($('#group_' + i + '_title').val() != '') {
                            obj["group_title"] = $('#group_' + i + '_title').val();
                        }
                        else {
                            bootbox.alert('Please Enter title of Group ' + i);
                            flag = 'N';
                            break;
                            return false;
                        }
                        obj["group_type"] = 'G';

                        //var instructor = '';

                        //if ($('#group_' + i + '_instructor input[type=checkbox]:checked').length == 0) {

                        //    bootbox.alert('Please select Instructors for group ' + i);
                        //    flag = 'N';
                        //    break;
                        //    return false;
                        //}

                        ////if ($('#group_' + i + '_instructor input[type=checkbox]:checked').length < 2) {

                        ////    bootbox.alert('Please select 2 Instructors for group ' + i);
                        ////    flag = 'N';
                        ////    break;
                        ////    return false;
                        ////}

                        //if ($('#group_' + i + '_instructor input[type=checkbox]:checked').length > 2) {

                        //    bootbox.alert('Please select only 2 Instructors for group ' + i);
                        //    flag = 'N';
                        //    break;
                        //    return false;
                        //}

                        //for (var j = 0; j < $('#group_' + i + '_instructor input[type=checkbox]:checked').length; j++) {
                        //    if (j != 0) {
                        //        instructor += '~';
                        //    }
                        //    instructor += $('#group_' + i + '_instructor input[type=checkbox]:checked')[j].value;
                        //}

                        //if (instructor == '') {

                        //    bootbox.alert('Please select Instructors for group ' + i);
                        //    flag = 'N';
                        //    break;
                        //    return false;
                        //}

                        //obj["primary_instructor"] = instructor;

                        datalist.push(obj);
                    }
                }
                else {
                    var obj = {};

                    obj["selected_group"] = $('#drpgroup').val();
                    obj["group_code"] = '0';
                    obj["project"] = $('#drpproject').val();
                    obj["group_title"] = '';
                    obj["group_type"] = 'I';

                    datalist.push(obj);
                }

                $("#group_instructor td").each(function (i) {
                    if ($(this).find('.priority').val() == 0) {
                        bootbox.alert('Please Select Priority for ' + this.innerText);
                        flag = 'N';
                        return false;
                    }

                    var ob = {};

                    ob["instructor_code"] = $(this).find('.priority').attr('id');
                    ob["priority"] = $(this).find('.priority').val();

                    if ($('#chk_' + $(this).find('.priority').attr('id'))[0].checked) ob["is_photo_for_projects"] = 'Y';
                    else ob["is_photo_for_projects"] = 'N';

                    instructor_datalist.push(ob);
                });

                var student_datalist = [];

                $("#example tbody tr").each(function (i) {
                    //if ($('#drpsubstudio').val() != "") {
                    if ($(this).find(".chk_substudio_user_selection").is(':checked')) {

                        var aPos = oTable1.fnGetPosition(this);
                        var a = oTable1.fnGetData(aPos);

                        var ob = {};

                        ob["user_id"] = $(this).children().eq(1).html();
                        ob["representative"] = 'N';
                        if ($(this).find(".chk_group_Representative").is(':checked')) {
                            ob["representative"] = 'Y';
                        }

                        var valuestudio = $('input:radio[name=group]:checked').val();
                        if (valuestudio == 'I') {
                            ob["group_code"] = '';
                        }
                        else {
                            ob["group_code"] = $(this).find(".cls_student_group_selection").val();
                        }

                        ob["course_type"] = a["course_type"];

                        student_datalist.push(ob);
                    }

                    //}
                    //else {
                    //    if ($(this).find(".chk_substudio_user_selection").is(':checked')) {
                    //        var ob = {};

                    //        ob["user_id"] = $(this).children().eq(1).html();
                    //        ob["representative"] = 'N';
                    //        if ($(this).find(".chk_group_Representative").is(':checked')) {
                    //            ob["representative"] = 'Y';
                    //        }
                    //        var valuestudio = $('input:radio[name=group]:checked').val();
                    //        if (valuestudio == 'I') {
                    //            ob["group_code"] = '';
                    //        }
                    //        else {
                    //            ob["group_code"] = $(this).find(".cls_student_group_selection").val();
                    //        }

                    //        student_datalist.push(ob);
                    //    }
                    //}
                });

                //var sub_studio_name;
                //if ($('#drpsubstudio').val() == '') {
                //    sub_studio_name = $('#drpcourse').val();
                //}
                //else {
                //    sub_studio_name = $('#drpsubstudio').val();
                //}

                if (flag == 'Y') {

                    var data = JSON.stringify({ course_group: JSON.stringify(datalist), student_group: JSON.stringify(student_datalist), instructor_data: JSON.stringify(instructor_datalist), course_code: $('#drpcourse').val(), sem_code: $('#drpsem').val(), year_code: $('#drpyear').val(), sub_studio: $('#drpsubstudio').val() });

                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/Save_course_studio_wise_group_data",
                        data: data,
                        contentType: "application/json; charset=utf-8",
                        datatype: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "Fail to Save Details.") {
                                    bootbox.alert(data.d);
                                    return false;
                                }

                                if (data.d == "Data Saved Successfully") {
                                    bootbox.alert(data.d);
                                    return false;
                                }

                                bootbox.alert(data.d);
                            }
                        },
                        error: function (msg) { alert(msg.d); }
                    });
                }
            });
        });

        $(document).on("change", ".priority", function (event) {
            var val = $(this).val();

            $("#group_instructor td").each(function (i) {
                if ($(this).find('.priority').val() != '0') {
                    if ((parseInt(val) - parseInt(1)) == $(this).find(".priority").val()) {
                        flag = 'Y';
                        generateSelectedAreas();
                        return false;
                    }
                    else {
                        flag = 'N';
                    }
                }
            });

            generateSelectedAreas();
        });

        function generateSelectedAreas() {
            var selectedValues = [];
            var nNodes = oTable1.fnGetNodes();

            $("#group_instructor td").each(function (i) {
                $(this).find('.priority option').each(function () {
                    $(this).css('display', 'block');
                });
            });

            $("#group_instructor td").each(function (i) {
                $(this).find('.priority option:selected').each(function () {
                    var select = $(this).parent();
                    optValue = $(this).val();
                    if ($(this).val() != '0') {
                        //$(this).not(select).children().css('display', 'none');
                        $('.priority').not(select).children().filter(function (e) {
                            if ($(this).val() == optValue)
                                return e
                        }).css('display', 'none');
                    }
                });
            });
        }

        $(document).on("click", ".cls_group_title", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable1.fnGetData(row);
        });

        function display_data(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList").html('<div class="panel-heading"><strong><span class="panel-headingfont">Select Student Group</span></strong></div> <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example").dataTable({
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
                "aaData": JSON.parse(data),
                "aoColumns": [{
                    "sTitle": "Select", "bSortable": false, "mData": null, fnRender: function (oObj) {
                        var listItems = '';
                        
                        if (oObj.aData.user_id == oObj.aData.saved_user_id && oObj.aData.sub_studio_name != $('#drpsubstudio').val()) {
                            listItems = '';
                        }
                        else {
                            listItems = '<center><input type="checkbox" name="substudio_user" class="chk_substudio_user_selection" ></center>';
                        }

                        return listItems;
                    }
                },
                { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                //{ "sTitle": " Group Representative",
                //    "mData": null,
                //    "bSortable": false,
                //    "sDefaultContent": '<center><input type="checkbox" name="check2" value="Y" class="chk_group_Representative" ></center>'
                //},
                {
                    "sTitle": " Group Representative", "bSortable": false, "mData": null, fnRender: function (oObj) {
                        var listItems = '';
                        if (oObj.aData.user_id == oObj.aData.saved_user_id && oObj.aData.sub_studio_name != $('#drpsubstudio').val()) {
                            listItems = '<center><input type="checkbox" name="check2" value="Y" class="chk_group_Representative" disabled></center>';
                        }
                        else {
                            listItems = '<center><input type="checkbox" name="check2" value="Y" class="chk_group_Representative" ></center>';
                        }

                        return listItems;
                    }
                },
                {
                    "sTitle": "Select Group", "bSortable": false, "mData": null, fnRender: function (oObj) {
                        var listItems = '';

                        if (oObj.aData.user_id == oObj.aData.saved_user_id && oObj.aData.sub_studio_name != $('#drpsubstudio').val()) {
                            listItems = '<select class="cls_student_group_selection" disabled>';
                            listItems += '</select>';
                        }
                        else {
                            listItems = '<select class="cls_student_group_selection">';
                            listItems += '</select>';
                        }
                        return listItems;
                    }
                }
                ]
            });

            $('#DataList,#div_select_group_data,#btnsave').css('display', 'block');

            if (course_saved_data != '' && course_saved_data != undefined) {

                $('#drpgroup').val(course_saved_data[0]["selected_group"]);
                $('#drpproject').val(course_saved_data[0]["project"])

                if (course_saved_data[0]["group_type"] == 'G') {
                    $('#drpgroup').change();
                    $('#radiogroups').prop('checked', true);
                    $('#div_group').css('display', 'block');
                }
                else {
                    $('#radioindividual').prop('checked', true);
                    $('#radioindividual').click();
                    $('#div_group').css('display', 'none');
                }
            }
            else {
                $('#radioindividual').click();
            }
            //else {
            //    var title_data = '';
            //    if (course_instructor_data != '') {
            //        var list_item = '<option value="0">-select-</option>';
            //        for (var i = 0; i < course_instructor_data.length; i++) {
            //            list_item += '<option value="' + (i + 1) + '">' + (i + 1) + '</option>';
            //        }
            //        title_data += '<div class="row" style="padding-left: 15px; padding-right: 15px;">';
            //        title_data += '<div class="form-group col-md-2" style=""><b>Instructor</b></div>';
            //        title_data += '<div class="form-group col-md-9" style="">';
            //        title_data += '<table class="table" id="group_instructor"> ';
            //        for (var j = 0; j < course_instructor_data.length; ) {
            //            title_data += '<tr> ';
            //            for (var k = 0; k < 4; k++) {
            //                if (j >= course_instructor_data.length) {
            //                    break;
            //                }
            //                title_data += '<td class="cls_td_instructor"><select class="priority" style="width: 50px;" class="chosen-select" id="' + course_instructor_data[j]["instructor_code"] + '">' + list_item + ' </select> ' + course_instructor_data[j]["instructor_name"] + '</td>';
            //                j++;
            //            }
            //            title_data += '</tr>';
            //        }
            //        title_data += '</table></div>';
            //        title_data += '</div>';
            //    }
            //    $('#div_group_title_instructor').html('');
            //    $('#div_group_title_instructor').append(title_data);
            //}

            if ($('#drpsubstudio').val() == "") {

                //  $(".chk_substudio_user_selection").prop('checked', true);
                // $(".chk_substudio_user_selection").prop('disabled', 'disabled');
                if (student_saved_data == "") {
                    $(".chk_substudio_user_selection").prop('checked', true);
                }
            }

            $("#example tbody tr").each(function (i) {
                var aPos = oTable1.fnGetPosition(this);
                var aData = oTable1.fnGetData(aPos[i]);
                var a = aData[i];

                if (student_saved_data != "") {
                    for (var j = 0; j < student_saved_data.length; j++) {
                        if (student_saved_data[j]["user_id"] == a["user_id"]) {
                            if (student_saved_data[j]["representative"] == 'Y') {
                                $(this).find(".chk_group_Representative").prop('checked', true);
                            }
                            if (student_saved_data[j]["group_code"] != '') {
                                $(this).find(".cls_student_group_selection").val(student_saved_data[j]["group_code"]);
                            }

                            $(this).find(".chk_substudio_user_selection").prop('checked', true);
                        }
                    }
                }
            });
        }

        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)

                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpyear').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindprogrammedata() {
            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_Admin_wise_Program_user_dtl",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                $('#drpprog').empty();

                                for (var i = 0; i < user_data.length; i++) {
                                    if (user_data[i]['prog_code'] == "1") {
                                        $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "2") {
                                        $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "3") {
                                        $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                    }
                                }
                            }
                            else {
                                $('#drpprog').val('1');
                                $("#drpprog").attr('disabled', 'disabled');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else if ($('#hdn_utype').val() == 'PC') {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_programme_coordinator_dtl",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);

                                $('#drpprog').empty();

                                for (var i = 0; i < user_data.length; i++) {
                                    if (user_data[i]['prog_code'] == "1") {
                                        $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "2") {
                                        $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                    }
                                    else if (user_data[i]['prog_code'] == "3") {
                                        $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                    }
                                }
                                //$('#drpprog').val(user_data[0]['prog_code']);
                            }
                            else {
                                $('#drpprog').val('1');
                                $("#drpprog").attr('disabled', 'disabled');
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else {
                $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
                $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

                if ($("#hdn_utype").val() != 'PC' && $("#hdn_utype").val() != 'FA') {
                    $('#drpprog').chosen();
                }
            }
        }

        function bindproglevel() {
            //$('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            //$('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
            //$('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_program_level_data_rights_wise",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var prog_level_data = JSON.parse(data.d)

                        $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Prog-Level --"));

                        for (var i = 0; i < prog_level_data.length; i++) {
                            $('#drpproglevel').append($("<option></option>").val(prog_level_data[i]["prog_level_code"]).html(prog_level_data[i]["prog_level_desc"]));
                        }

                        //if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                        $('#drpproglevel').chosen();
                        //}
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function binddepartment() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                async: false,
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

        function get_fauser_detail() {
            if ($('#hdnusertype').val() == 'FA') {
                //$('.cls_dept_prog').css('display', 'none');

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/get_department_wise_user_dtl",
                        async: false,
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                var user_data = JSON.parse(data.d);
                                $('#drpdepartment').val(user_data[0]['dept_code']);
                                //$('#drpprog').val(user_data[0]['prog_code']);
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
        }
    </script>
</asp:Content>
