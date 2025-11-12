<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Divide_Sub_Studio.aspx.cs" Inherits="Admin_Master_Divide_Sub_Studio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                </div>
            </div>
        </div>
        <div style="display: none;" id="div_select_group_data" class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Select Studio</span></strong>
            </div>
            <div style="padding: 15px;" id="div1">
                <div class="row">
                    <div class="form-group col-md-1" style="">
                        Select Studio :
                    </div>
                    <div class="form-group col-md-8" style="">
                        <div class="form-group col-md-2" style="">
                            <input type="radio" id="radiosingle" name="studio" value="single" checked>
                            Single Studio
                        </div>
                        <div class="form-group col-md-2" style="">
                            <input type="radio" id="radiosub" name="studio" value="sub">
                            Sub Studios<br>
                        </div>
                    </div>
                </div>
                <div id="div_sub_studio" style="display: none; margin-top: 15px;">
                    <div class="row">
                        <div class="form-group col-md-2" style="">
                            How Many :
                        </div>
                        <div class="form-group col-md-3" style="">
                            <select class="chosen-select" id="drpsubstudio">
                                <option value="0">--Select Sub Studio--</option>
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
                            </select>
                        </div>
                    </div>
                    <div id="div_group_title_instructor" class="row">
                    </div>
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
    <script>
        var oTable1;
        var studio_data = '';
        var course_instructor_data = '';
        var student_saved_data = '';
        var course_saved_data = '';
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

          

            $('#btnRetrieve').on('click', function () {

                $('#div_group_title_instructor').html('');
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


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_divide_studio_data_list",
                    async: false,
                    data: "{sem_code :'" + cur_sem + "' , year_code :'" + cur_year + "',course_code: '" + course_code + "',studio_type:''}",
                    dataType: "json",
                    success: function (data) {
                        //   display_data(data.d);
                        debugger;
                        $('#div_select_group_data,#btnsave').css('display', 'block');
                        if (data.d != "") {

                            studio_data = JSON.parse(data.d);

                            if (studio_data[0]["studio_type"] == 'single') {
                                $('#radiosingle').prop('checked', true);
                                $('#div_sub_studio').css('display', 'none');
                            }
                            else {
                                $('#radiosub').prop('checked', true);

                                $('#drpsubstudio').val(studio_data[0]["sub_studio_number"]);
                                $('#div_sub_studio').css('display', 'block');

                                var value = studio_data[0]["sub_studio_number"];

                                if (value != '') {

                                    var listitem = '';

                                    var title_data = '';

                                    for (var i = 1; i <= value; i++) {

                                        listitem += '<option value="' + i + '">' + i + '</option>';

                                        title_data += '<div class="row" style="padding-left: 15px; padding-right: 15px;"> ' +
                     '<div class="form-group col-md-2" style="">' +
                        '<b> ' + studio_data[0]["course_code"] + "-" + i + ' : </b>' +
                    '</div>' +
                    '<div class="form-group col-md-3" style=""><input type="text" id="group_' + i + '_title"> ' +
                     '</div>' +
                     '</div>';

                                    }
                                    $('#div_group_title_instructor').html('');
                                    $('#div_group_title_instructor').append(title_data);

                                    if (studio_data != '' && studio_data != undefined) {

                                        for (var i = 0; i < studio_data.length; i++) {

                                            $('#group_' + (i + 1) + '_title').val(studio_data[i]["title"]);

                                        }

                                    }
                                }
                                else {
                                    $('#div_group_title_instructor').html('');
                                }


                            }
                        }
                        else {
                            studio_data = '';
                            $('#radiosingle').prop('checked', true);
                            $('#div_sub_studio').css('display', 'none');
                        }

                        //                        if (data.d[0] != null) {

                        //                            display_data(data.d[0])
                        //                        }


                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

            $('#drpsubstudio').on('change', function () {

                var value = $('#drpsubstudio').val();

                if (value != '') {

                    var listitem = '';

                    var title_data = '';

                    for (var i = 1; i <= value; i++) {

                        listitem += '<option value="' + i + '">' + i + '</option>';

                        title_data += '<div class="row" style="padding-left: 15px; padding-right: 15px;"> ' +
                     '<div class="form-group col-md-2" style="">' +
                        '<b> ' + $('#drpcourse').val() + "-" + i + ' : </b>' +
                    '</div>' +
                    '<div class="form-group col-md-3" style=""><input type="text" id="group_' + i + '_title"> ' +
                     '</div>' +
                     '</div>';


                    }
                    $('#div_group_title_instructor').html('');
                    $('#div_group_title_instructor').append(title_data);

                }
                else {
                    $('#div_group_title_instructor').html('');
                }

            });

            $("input[name='studio']").click(function () {

                var valuestudio = $('input:radio[name=studio]:checked').val();

                if (valuestudio == 'sub') {
                    $('#div_sub_studio').css('display', 'block');
                }
                else {
                    $('#div_sub_studio').css('display', 'none');
                }

                $('#drpsubstudio').val('');
                $('#div_group_title_instructor').html('');

            });



            $('#drpcourse').on('change', function () {
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
                        //   display_data(data.d);

                        if (data.d != "") {


                            var course_data = JSON.parse(data.d)

                            $('#drpcourse').empty();
                            for (var i = 0; i < course_data.length; i++) {


                                $('#drpcourse').append($("<option></option>").val(course_data[i]["course_code"]).html(course_data[i]["course_code"]));
                            }

                            $('#drpcourse').chosen();
                            $("#drpcourse").trigger("liszt:updated");
                        }
                        else {

                            $('#drpcourse')
                .find('option')
                .remove()
                .end()
                .append('<option value="">No data found</option>')
                .val('');
                            $('#drpcourse').chosen();

                            $('#drpcourse').val('').trigger("liszt:updated");
                        }


                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });


            $('#btnsave').on('click', function () {

                debugger;

                var valuestudio = $('input:radio[name=studio]:checked').val();

                var datalist = [];
                var flag = 'Y';

                if (valuestudio == 'single') {
                    var obj = {};

                    obj["studio_type"] = "single";
                    obj["sub_studio_number"] = '';
                    obj["sub_studio_name"] = '';
                    obj["title"] = '';

                    datalist.push(obj);
                }
                else {

                    if ($('#drpsubstudio').val() == 0) {

                        bootbox.alert('Please select Sub Studio Number');
                        return false;
                    }

                    var value = $('#drpsubstudio').val();

                    for (var i = 1; i <= value; i++) {

                        debugger;
                        var obj = {};

                        obj["sub_studio_number"] = $('#drpsubstudio').val();
                        obj["studio_type"] = "sub";
                        obj["sub_studio_name"] = $('#drpcourse').val() + '-' + i;
                        obj["title"] = '';

                        if ($('#group_' + i + '_title').val() != '') {
                            obj["title"] = $('#group_' + i + '_title').val();
                        }
                        else {
                            bootbox.alert('Please Enter title of ' + $('#drpcourse').val() + '-' + i);
                            flag = 'N';
                            break;
                            return false;
                        }

                        datalist.push(obj);
                    }
                }

                if (flag == 'Y') {

                    var data = JSON.stringify({ studio_data: JSON.stringify(datalist), course_code: $('#drpcourse').val(), sem_code: $('#drpsem').val(), year_code: $('#drpyear').val() });

                    $.ajax({
                        type: "POST",
                        url: "../../WebService.asmx/Save_divide_studio_data",
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

        $(document).on("click", ".cls_group_title", function (event) {

            debugger;

            var row = $(this).closest("tr").get(0);
            var aData = oTable1.fnGetData(row);

        });

        function display_data(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList").html('<div class="panel-heading"><strong><span class="panel-headingfont">Select Student Group</span></strong></div> <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example").dataTable({

                "bPaginate": true,
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
                "aoColumns": [
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
             { "sTitle": " Group Representative",
                 "mData": null,
                 "bSortable": false,
                 "sDefaultContent": '<center><input type="checkbox"  name="check2" value="Y" class="chk_group_Representative" ></center>'
             },
             { "sTitle": "Select Group",
                 "bSortable": false,
                 "mData": null,
                 fnRender: function (oObj) {
                     var listItems = '<select class="cls_student_group_selection">';

                     listItems += '</select>';

                     return listItems;
                 }
             }


        ]
            });


            $('#DataList,#div_select_group_data,#btnsave').css('display', 'block');
            debugger;
            if (course_saved_data != '' && course_saved_data != undefined) {

                $('#drpgroup').val(course_saved_data[0]["selected_group"]);
                $('#drpproject').val(course_saved_data[0]["project"])
                $('#drpgroup').change();

            }


            debugger;
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
                            $(this).find(".cls_student_group_selection").val(student_saved_data[j]["group_code"]);
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

            //    $('#drpproglevel').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
            //    $('#drpproglevel').append($("<option></option>").val("E").html("Elective"));
            //    $('#drpproglevel').append($("<option></option>").val("M").html("Mandatory"));

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

                        // if ($("#hdn_utype").val() != 'PC'  && $("#hdn_utype").val() != 'FA') {
                        $('#drpproglevel').chosen();
                        //  }

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

                //     $('.cls_dept_prog').css('display', 'none');

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
