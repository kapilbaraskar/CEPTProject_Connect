<%@ Page Title="Teaching Interest" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Interested_Program.aspx.cs" Inherits="Admin_Master_Interested_Program" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        .unselectable {
            background-color: #ddd;
            cursor: not-allowed;
        }
   .disabled-td {
    pointer-events: none;  
    opacity: 0.5;          
    background-color: #f0f0f0; 
}
    </style>

    <script type="text/javascript">

        $(document).ready(function () {
            var program_data = '';
            var sem = '';
            var year = '';
            var next_prev = false;
            var block = false;
            var step_1_status = true;
            var prog_data = "";
            var instructor = '';
            var bindinst_tobelater_ = '';
            var add_instructor_cnt = 1;
            var inst_dtl = "";
            var old_course_code_bool = false;
            var port_change_type = '';
            //const array = [];
            $("#sd").css('display', 'none');
           

            get_program_list_for_interested_program();

            getInterestedProgramDetails();
            call_for_studio_status_track();
            binddepartment();
            bindyeardata_for_cross_reg();
            bindProgramsByStudioLevels();
            //bindpreviouscoursecode();
            bindsemdata();
            bindyeardata();
            bindinst();//10022022
            bindinst_tobelater();
            var studio_code = getQueryStringValue('studio_code');
            bind_default_inst(studio_code);
            studio_dtl();
            $('#btn_instructor').click();

            $('.hdn_new_proposal').css('display', 'none');
            
            if (studio_code != "") {
                getStudiowiseinst(studio_code);
                getStudioProposalsDetails(studio_code);

            }
            else {
                $('#studio_level').empty().append($("<option></option>").val("").html("-- No Level Found --"));
            }

           

            $('#tblinstructor').on('change', '.drpinstructor', function ()
            {
                var $select = $(this);
                var selectedValue = $select.val();
                var $currentTd = $select.closest('td');
                var $currentRow = $select.closest('tr');
                if (selectedValue == '') {
                    $currentRow.find('input').prop('disabled', false);
                }
                else
                {
                    $currentRow.find('input').prop('disabled', true);
                }

            });


            $('#program_level_code').on('change', function () {
                var data = $('#program_level_code').val();
                $('#studio_level').empty().append($("<option></option>").val("").html("-- Please Select Level --"));
                for (var i = 0; i < prog_data.length; i++) {
                    if (prog_data[i]["prog_level_code"] == data) {//selected_programs
                        $('#drpdepartment').val(prog_data[i]["dept_code"]);
                        $('#prog_id').val(prog_data[i]["prog_code"]);
                        $('#studio_level').append($("<option></option>").val(prog_data[i]["studio_level"]).html(prog_data[i]["studio_level"]));
                    }
                }
            });

            $('#drpsemester_old').on('change', function () {
                if ($('#drpyear_old').val() != '' && $('#drpsemester1_old').val() != '') {
                    bindpreviouscoursecode();
                }
            });

            $('#drpyear_old').on('change', function () {
                if ($('#drpsemester_old').val() != '' && $('#drpsemester1_old').val() != '') {
                    bindpreviouscoursecode();
                }
            });

            $('#drpsemester1_old').on('change', function () {
                if ($('#drpsemester_old').val() != '' && $('#drpyear_old').val() != '') {
                    bindpreviouscoursecode();
                }
            });

            //$('#pre_course_code').on('change', function () {
            //    if ($('#drpsemester_old').val() != '' && $('#drpyear_old').val() != '') {
            //        bindpreviouscoursecodedata();
            //    }
            //});

            $('#pre_course_code').on('change', function () {
                if ($('#drpsemester_old').val() != '' && $('#drpyear_old').val() != '' && $('#drpsemester1_old').val() != '') {
                    get_studio_title_dtl('');
                    //bindpreviouscoursecodedata();
                }
            });

            $('input[name=rdo_proposal_type]:radio').on('change', function () {
                if ($('input[name=rdo_proposal_type]:checked').val() == 'N') {
                    $('.hdn_new_proposal').css('display', 'none');
                }
                else if ($('input[name=rdo_proposal_type]:checked').val() == 'E') {
                    $('.hdn_new_proposal').css('display', '');
                    $(".chzn-container").css('width', '220px');
                    //$('#pre_course_code_chzn').css('width','220px');
                }
            });
            //changes 10022022
          

            function bindinst() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_faculty_data_with_temp",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var instructor_data = JSON.parse(data.d)
                            instructor = "<select style='width:100%' class='drpinstructor'><option value=''>---Select Instructor---</option>";
                            for (var i = 0; i < instructor_data.length; i++) {
                                instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + '(' + instructor_data[i]["designation"] + ')' + " </option>";
                            }
                            instructor = instructor + "</select>";
                            $('#hdn_inst_id').val('')
                            $('#hdn_inst_id').val(instructor);

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function bindinst_tobelater() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_faculty_data",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var instructor_data = JSON.parse(data.d)
                            bindinst_tobelater_ = "<select style='width:100%' class='drpinstructor' disabled><option value=''>---Select Instructor---</option>";
                            for (var i = 0; i < instructor_data.length; i++) {
                                bindinst_tobelater_ = bindinst_tobelater_ + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                            }
                            bindinst_tobelater_ = bindinst_tobelater_ + "</select>";

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            //function bindinst() {

            //    $.ajax({
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/get_instructor_data_with_emailid",
            //        data: "{}",
            //        dataType: "json",
            //        async: false,
            //        success: function (data) {
            //            if (data.d != "") {
            //                var inst_data = JSON.parse(data.d)

            //                $('#instr_code').empty().append($("<option></option>").val("0").html("-- Please Select Instractor --"));

            //                for (var i = 0; i < inst_data.length; i++) {
            //                    //array.push(inst_data[i]["instructor_name"]);
            //                    $('#instr_code').append($("<option></option>").val(inst_data[i]["instructor_code"]).html(inst_data[i]["instructor_name"] + ' - ' + inst_data[i]["um_mail"] + ''));
            //                }
            //                $('#instr_code').chosen();

            //            }
            //        },
            //        error: function (result) {
            //            alert(result);
            //        }
            //    });

            //}

            //$('#inst_dtl').hide();


            //$('#add_inst').on('click', function ()
            //{
            //    if ($('#instr_code').val() == '0')
            //    {
            //        bootbox.alert("Please Select Instractor");
            //        return false;
            //    }
            //    if ($('#tutor').val() == '') {
            //        bootbox.alert("Please Select Tutor");
            //        return false;
            //    }
            //    // dual changes 
            //    var inst_code = $('#instr_code').val();
            //    var inst_name = $("#instr_code option:selected").text();
            //    var inst_split = inst_name.split('-');
            //    var str = "";
            //    str += "<tr><th id='inst_code' style='display:none;'>Instractor Id</th><th>Instractor Name</th><th id='tut_type'>Tutor Type</th><th>Mail</th><th>Action</th></tr>";
            //    str += "<tr id='" + inst_code + "'><td  style='display:none;'>" + inst_code + "</td><td>" + inst_split[0] + "</td><td>" + $("#tutor option:selected").text() + "</td><td>" + inst_split[1] + "</td><td><input type='button' class='btn btn-primary' value='Remove' id='" + inst_code + "' onclick=remove(this) style='line-height: 143.5%;'></td></tr>";
            //    if ($('#table_bind tr').length > '1') {
            //        $('#table_bind').append("<tr id='" + inst_code + "'><td  style='display:none;'>" + inst_code + "</td><td>" + inst_split[0] + "</td><td>" + $("#tutor option:selected").text() + "</td><td>" + inst_split[1] + "</td><td><input type='button' class='btn btn-primary' value='Remove' id='" + inst_code + "' onclick=remove(this) style='line-height: 143.5%;'></td></tr>");
            //    }
            //    else {
            //        $('#table_bind').html(str);
            //    }
            //    $('#dynamic_table').css('display', 'block');
            //    $('#instr_code').val("0");
            //    $('#instr_code').trigger("liszt:updated");
            //    $('#tutor').val("");
            //    $('#tutor').trigger("liszt:updated");
            //});

            //end


            $('#btn_instructor').on('click', function () {
                if ($('#no_of_tutor').val() == '') {
                    bootbox.alert("Please Select No of Tutor");
                    return false;
                }

                if ($('#no_of_tutor').val() == "Dual") {
                    if ($('#tblinstructor tbody tr').length == 2) {
                        bootbox.alert("Maximum Two Instructor Add ");
                        return false;
                    }
                }
                if ($('#no_of_tutor').val() == "Single") {
                    if ($('#tblinstructor tbody tr').length == 1) {
                        bootbox.alert("Maximum One Instructor Add ");
                        return false;
                    }
                }



                var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td>" + instructor + "</td>";
                str += "<td><select  onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                str += "<td><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td><input type='checkbox' class='cls_check'> To be decided later </td></tr>";

                $('#tblinstructor tbody').append(str);
                add_instructor_cnt = add_instructor_cnt + 1;
                $('#co_tutor_note').css('display', 'block');
                $('#co_tutor_note').css('color', 'red');
                return false;
            });

           
            function getStudiowiseinst(s_code) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/getStudiowiseinst",
                    async: false,
                    data: "{studio_code : '" + s_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            inst_dtl = "";
                            inst_dtl = JSON.parse(data.d);

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }


            function getStudioProposalsDetails(s_code) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/getStudioProposalsDetails",
                    async: false,
                    data: "{studio_code : '" + s_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var studio_details = JSON.parse(data.d);

                            //$("#program_level_code").val(studio_details[0]["dept_code"] + "_" + studio_details[0]["prog_code"] + "_" + studio_details[0]["prog_level_code"] + "_" + studio_details[0]["studio_level"]).html(studio_details[0]["prog_level_name"]);
                            $("#program_level_code").val(studio_details[0]["prog_level_code"]);
                            $('#program_level_code').trigger("liszt:updated");
                            $("#studio_title").val(studio_details[0]["studio_title"]);
                            $("#sub_studio_title").val(studio_details[0]["studio_subtitle"]);
                            $("#no_of_tutor").val(studio_details[0]["no_of_tutor"]);
                            $("#teaching_mode").val(studio_details[0]["teaching_mode"]);
                            $("#drpsem").val(studio_details[0]["semester_type"]);
                            var text_remaining = studio_details[0]["studio_description"].split(' ').length;
                            if (text_remaining >= '200') {
                                $('#spn_desc').html('' + 'Total Words : ' + text_remaining);
                                $('#spn_desc').css('color', 'red');
                            }
                            else {
                                $('#spn_desc').html('' + 'Total Words : ' + text_remaining);
                                $('#spn_desc').css('color', 'black');
                            }
                            $("#txt_studio_dtl").val(studio_details[0]["studio_description"]);
                            $("#drpyear").val(studio_details[0]["year_semester"]);
                            $('#drpyear').trigger("liszt:updated");

                            var data_new = $('#program_level_code').val();
                            var arr_data_new = data_new.split('_');
                            var selected_programs_new = arr_data_new[2];
                            $('#studio_level').empty().append($("<option></option>").val("").html("-- Please Select Level --"));

                            for (var i = 0; i < prog_data.length; i++) {
                                if (prog_data[i]["prog_level_code"] == data_new) {//selected_programs_new
                                    $('#drpdepartment').val(prog_data[i]["dept_code"]);
                                    $('#prog_id').val(prog_data[i]["prog_code"]);
                                    $('#studio_level').append($("<option></option>").val(prog_data[i]["studio_level"]).html(prog_data[i]["studio_level"]));
                                }
                            }
                            var old_course_code = studio_details[0]["previous_sem_course_code"];
                            if (old_course_code != '') {
                                $('#drpsemester_old').val(studio_details[0]["previous_sem_code"]);
                                $('#drpyear_old').val(studio_details[0]["previous_year_code"]);

                                $('#drpsemester1_old').val(studio_details[0]["previous_type"]);
                                $('#drpsemester1_old').trigger("liszt:updated");
                                debugger;
                                port_change_type = studio_details[0]["Portfolio_change_type"];

                                $('#drpsemester_old').trigger("liszt:updated");
                                $('#drpyear_old').trigger("liszt:updated");
                                bindpreviouscoursecode();
                                $('#pre_course_code').val(old_course_code);
                                $('#pre_course_code').trigger("liszt:updated");
                                get_studio_title_dtl('title');
                                old_course_code_bool = true;
                            }

                            //15022022
                            debugger;
                            for (var k = 0; k < inst_dtl.length; k++) {
                                //var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td>" + instructor + "</td>";
                                //str += "<td><select  onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                                //str += "<td><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";

                                if (inst_dtl[k]["to_be_later"] == "Y") {
                                    var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td>" + bindinst_tobelater_ + "</td>";
                                    str += "<td><select onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;' disabled><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                                    str += "<td><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";
                                    str += "<td><input type='checkbox' class='cls_check' checked> To be decided later </td></tr>";
                                }
                                else {
                                    var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td>" + instructor + "</td>";
                                    str += "<td><select  onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                                    str += "<td><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>";
                                    str += "<td></td></tr>";
                                }


                                $('#tblinstructor tbody').append(str);
                                add_instructor_cnt = add_instructor_cnt + 1;
                                var id_text = '#' + (k + 1) + ' ' + 'td';
                                
                                $(id_text).find(".drpinstructor").val(inst_dtl[k]["instructor_code"].trim());
                                if (inst_dtl[k]["tutor_type"].trim() == "T") {
                                    $(id_text).find(".cls_drp_tutor").val(inst_dtl[k]["tutor_type"].trim());
                                }
                                else if (inst_dtl[k]["tutor_type"] == "CT") {
                                    $(id_text).find(".cls_drp_tutor").val(inst_dtl[k]["tutor_type"].trim());
                                }

                                if ($('#hdnuserid').val().trim() == inst_dtl[k]["instructor_code"].trim()) {
                                    $(id_text).find(".drpinstructor").attr('disabled', true);
                                    $('i[data-row_no="' + (k + 1) + '"]').css
                                    ({
                                        'pointer-events': 'none','opacity': '0.5','cursor': 'default','color': 'grey'            
                                    });
                                }
                            }
                            $("#studio_level").val(studio_details[0]["studio_level"]);
                            $('#studio_level').trigger("liszt:updated");


                            //$("#program_level_code").attr('disabled', 'disabled');
                            $('#program_level_code').trigger("liszt:updated");
                            //$("#studio_level").attr("disabled", "disabled");
                            $("#drpsem").attr("disabled", "disabled");
                            $("#drpyear").attr("disabled", "disabled");
                            $('#drpyear').trigger("liszt:updated");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function bind_default_inst(studio_code) {
                if (studio_code == "") {
                    var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td class='disabled-td'>" + instructor + "</td>";
                    str += "<td><select  onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                    str += "<td class ='disabletd'></td><td></td></tr>";
                    $('#tblinstructor tbody').append(str);
                    add_instructor_cnt = add_instructor_cnt + 1;
                    var id_text = '#1' + ' ' + 'td';
                    $(id_text).find(".drpinstructor").val($('#hdn_user_id').val().trim());
                }

            }

            function getQueryStringValue(key) {
                return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
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
                            //$('#drpdepartment').chosen();
                        }
                    },
                    error: function (result) {
                        alert(result);
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

            //function bindProgramsByStudioLevels() {
            //    $.ajax({
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/GetProgramsByStudioLevels",
            //        async: false,
            //        data: "{}",
            //        dataType: "json",
            //        success: function (data) {
            //            if (data.d != "") {
            //                prog_data = "";
            //                var program_data = JSON.parse(data.d)
            //                prog_data = program_data;
            //                $('#program_level_code').empty().append($("<option></option>").val("").html("-- Please Select Programs --"));
            //                for (var i = 0; i < program_data.length; i++) {
            //                    if (i != 0 && (program_data[i-1]["prog_level_code"] != program_data[i]["prog_level_code"])) {
            //                       $('#program_level_code').append($("<option></option>").val(program_data[i]["dept_code"] + "_" + program_data[i]["prog_code"] + "_" + program_data[i]["prog_level_code"] + "_" + program_data[i]["studio_level"]).html(program_data[i]["prog_level_name"]));
            //                    } else if (i == 0) {
            //                        $('#program_level_code').append($("<option></option>").val(program_data[i]["dept_code"] + "_" + program_data[i]["prog_code"] + "_" + program_data[i]["prog_level_code"] + "_" + program_data[i]["studio_level"]).html(program_data[i]["prog_level_name"]));
            //                    }
            //                }
            //                $('#program_level_code').chosen();
            //            }
            //        },
            //        error: function (result) {
            //            alert(result);
            //        }
            //    });
            //}

            function bindProgramsByStudioLevels() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetProgramsByStudioLevels",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            prog_data = "";
                            var program_data = JSON.parse(data.d);
                            prog_data = program_data;
                            $('#program_level_code').empty().append($("<option></option>").val("").html("-- Please Select Studio Programs --"));
                            for (var i = 0; i < program_data.length; i++) {

                                if (i != 0 && (program_data[i - 1]["prog_level_code"] != program_data[i]["prog_level_code"])) {

                                    //if (i != 0 && (program_data[i-1]["prog_level_code"] != program_data[i]["prog_level_code"])) {

                                    //$('#program_level_code').append($("<option></option>").val(program_data[i]["dept_code"] + "_" + program_data[i]["prog_code"] + "_" + program_data[i]["prog_level_code"] + "_" + program_data[i]["studio_level"]).html(program_data[i]["prog_level_name"]));
                                    $('#program_level_code').append($("<option></option>").val(program_data[i]["prog_level_code"]).html(program_data[i]["prog_level_name"]));
                                } else if (i == 0) {
                                    //$('#program_level_code').append($("<option></option>").val(program_data[i]["dept_code"] + "_" + program_data[i]["prog_code"] + "_" + program_data[i]["prog_level_code"] + "_" + program_data[i]["studio_level"]).html(program_data[i]["prog_level_name"]));
                                    $('#program_level_code').append($("<option></option>").val(program_data[i]["prog_level_code"]).html(program_data[i]["prog_level_name"]));
                                }
                            }
                            $('#program_level_code').chosen();
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            if ($("#hdn_tutor_type").val() == "temp") {
                $("#bank_tutor").addClass("inactive");
                $("#bank_tutor").removeClass("active");
                $("#tutor_disabled").prop("disabled", true);
            }

            $('#btn_prev').on('click', function () {
                //$('#btn_save').click();
                var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";//?studio_code=" + studio_code
                window.open(url, "_self");
                //saveChanges(studio_code, true);
                //if (next_prev) {
                //    var url = "frm_personal_details.aspx";//?studio_code=" + studio_code
                //    window.open(url, "_self");
                //}
            });

            $('#btn_save').on('click', function () {
                saveChanges(studio_code, false);
            });

            $('#btn_next').on('click', function () {
                //$('#btn_save').click();

                disable_user();
                if (step_1_status == false) {
                    alert('Please Fill Step 1 Details');
                    return false;
                }
                else { saveChanges(studio_code, true); }
                if (next_prev) {
                    final_submit_data(studio_code);
                    //var url = "Studio_Details.aspx?studio_code=" + studio_code;
                    //window.open(url, "_self");
                }
            });

            function final_submit_data(txt_studio_code) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/submit_call_for_studio",
                    data: "{studio_code:'" + txt_studio_code + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            res = JSON.parse(data.d)
                            if (res['status'] == "1") {
                                send_mail();
                                alert(res['message']);
                                //var url = "Interested_Program.aspx?studio_code=" + studio_code;
                                var url = "Studio_Proposal_Dashboard.aspx";
                                window.open(url, "_self");
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function disable_user() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_disable_user_detail",
                    data: "{user_id:'" + $('#hdn_user_id').val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            step_1_status = true;
                        }
                        else { get_user_valid_user(); }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function get_user_valid_user() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_instructor_dtl",
                    data: "{user_id:'" + $('#hdn_user_id').val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var data_details = JSON.parse(data.d);
                            if (data_details[0]["title"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["first_name"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["last_name"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["gender"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["mail"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["indian_citizen"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["dob"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["highest_qualification"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["total_experiance"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["permanent_address"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["city"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["state"] == "") {
                                step_1_status = false;
                            }
                            else if (data_details[0]["country"] == "") {
                                step_1_status = false;
                            }
                        }
                        else {
                            next_prev = false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function get_program_list_for_interested_program() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_program_list_for_interested_program",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            program_data = JSON.parse(data.d)
                            //setTableData(program_data);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function getInterestedProgramDetails() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/getInterestedProgramDetails",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var saved_program_data = JSON.parse(data.d)
                            for (var i = 0; i < saved_program_data.length; i++) {
                                $("#" + saved_program_data[i]["dept_code"] + "_" + saved_program_data[i]["prog_code"] + "_" + saved_program_data[i]["prog_level_code"] + "_" + saved_program_data[i]["studio_level"]).prop("checked", true);
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function setTableData(program_data) {
                var str = '';
                for (var i = 0; i < program_data.length; i++) {
                    if (i != 0) {
                        if (program_data[i]["dept_code"] != program_data[i - 1]["dept_code"]) {
                            str += '<div style="margin-top:5px;"><b>Faculty of ' + program_data[i]["dept_name"] + '</b></div>';
                        }
                    } else {
                        str += '<div style="margin-top:5px;"><b>Faculty of ' + program_data[i]["dept_name"] + '</b></div>';
                    }
                    str += '<div style="margin-top:5px;"><input type="checkbox" name="selected_program" value="' + program_data[i]["dept_code"] + '_' + program_data[i]["prog_code"] + '_' + program_data[i]["prog_level_code"] + '" id="' + program_data[i]["dept_code"] + '_' + program_data[i]["prog_code"] + '_' + program_data[i]["prog_level_code"] + '" style="margin-top:0px;"/> <span>' + program_data[i]["prog_level_name"] + '</span></div>';
                }
                $("#program_data").append(str);
            }

            function getCurrentSemYearCallForStudio() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/getCurrentSemYearCallForStudio",
                    data: "{}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var sem_year_data = JSON.parse(data.d)
                            sem = sem_year_data[0]["sem_code"];
                            year = sem_year_data[0]["year_code"];
                            if (sem == "S") {
                                $("#semdesc").text("Spring " + year + " Semester");
                            } else if (sem == "M") {
                                $("#semdesc").text("Monsoon " + year + " Semester");
                            }

                            $("#drpsem").val(sem);
                            $("#drpyear").val(year);
                            $('#drpyear').trigger("liszt:updated");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function call_for_studio_status_track() {
                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/call_for_studio_status_track",
                        //async: false,
                        data: "{studio_code:'" + getQueryStringValue('studio_code') + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "" && data.d != "[]") {
                                var track_call_for_studio = JSON.parse(data.d);
                                if (track_call_for_studio[0]["value"] == "Y") {
                                    $("#pd").css('background-color', 'white');
                                } else {
                                    $("#pd").css('background-color', 'grey');
                                    block = true; //uncomment this line to work logic of stop going next button - Mahroofbhai - 14 10 2020
                                    $("#ip").addClass("active");
                                    // $("#ip").removeClass("active");
                                    $("#sd").addClass("active");
                                    //$("#sd").removeClass("active");
                                }
                                if (track_call_for_studio[1]["value"] == "Y") {
                                    $("#ip").css('background-color', 'white');
                                } else {
                                    $("#ip").css('background-color', 'white');
                                }
                                if (track_call_for_studio[2]["value"] == "Y") {
                                    $("#sd").css('background-color', 'white');

                                } else {
                                    $("#sd").css('background-color', 'grey');
                                }
                                if (track_call_for_studio[3]["value"] == "Y") {
                                    $("#bank_tutor").css('background-color', 'white');

                                } else {
                                    $("#bank_tutor").css('background-color', 'grey');
                                }
                                if (track_call_for_studio[4]["value"] == "Y") {
                                    block = false;
                                }
                                if (track_call_for_studio[6]["value"] == "Y") {
                                    $("#studio_title").attr("disabled", "disabled");
                                    $("#no_of_tutor").attr("disabled", "disabled");
                                    $("#teaching_mode").attr("disabled", "disabled");

                                }
                            }
                            else {
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                return false;
            }
            var entityMap = { "'": '&#39;', '"': '&#34;', "@": '&#64;', "&": '&#38;', "<": '&#60;', ">": '&#62;', "/": '&#47;' };

            var inst_code_arry = [];
            var tutor_type_arry = [];
            function saveChanges(studio_code, next) {

                var count_tbd = 0;
                var value = $('input[name=rdo_proposal_type]:checked').val();
                if (value == "N") {
                    $('input[name=new_old_modification]').prop('checked', false);
                }
                if ($('#hdnusertype').val() == 'PC') {

                    var r = confirm("You are currently in Program Coordinator role. Are you sure to submit studio proposal from Program coordinator account ?");
                    if (r == true) {

                    }
                    else {
                        return false;

                    }
                }
                var data = $("#program_level_code").val();
                if (data == "") {
                    bootbox.alert("Please Select the Program for which you have proposed the studio");
                    return false;
                }

                if ($("#studio_level").val() == "") {
                    bootbox.alert("Please Select the Level");
                    return false;
                }

                //10022022

                if ($("#no_of_tutor").val() == "") {
                    bootbox.alert("Please Select No of Tutor");
                    return false;
                }
                if ($("#no_of_tutor").val() == 'Dual') {
                    if ($("#tblinstructor tbody tr").length > 2) {
                        bootbox.alert('Maximum Two Instructor Add');
                        return false;
                    }
                    else if ($("#tblinstructor tbody tr").length < 2) {
                        bootbox.alert('Maximum Two Instructor Add');
                        return false;
                    }
                }
                if ($("#no_of_tutor").val() == 'Single') {
                    if ($("#tblinstructor tbody tr").length > 1) {
                        bootbox.alert('Maximum One Instructor Add');
                        return false;
                    }
                }

                if ($("#no_of_tutor").val() == 'Multiple') {
                    if ($("#tblinstructor tbody tr").length < 3) {
                        bootbox.alert('Minimum Three Instructor Add');
                        return false;
                    }
                }


                var inst_code = '';
                var tutor_type = '';
                var brief_edit_status = '';
                var to_be_later = '';
                var shortlist = '';
                var tutor_ex = false;
                var status_inst = true;
                var leadtutor_status = false;
                //21032025 Start
                var count_lead_tutor = 0;
                //21032025 End
                $("#tblinstructor tbody tr").each(function (j)
                {
                     //21032025 Start
                    if ($(this).find(".cls_drp_tutor").val() == "T")
                    {
                        count_lead_tutor = count_lead_tutor + 1;
                    }
                     //21032025 End
                    if (j == 0)
                    {
                        

                        if ($(this).find(".drpinstructor").val() == "") {
                            status_inst = false;
                            bootbox.alert("Please Select Instructor");
                            return false;
                        }
                        else if ($(this).find(".cls_drp_tutor").val() == "") {
                            status_inst = false;
                            bootbox.alert("Please Select Tutor Type");
                            return false;
                        }
                        else {
                            inst_code = $(this).find(".drpinstructor").val();
                            tutor_type = $(this).find(".cls_drp_tutor").val();
                            if ($(this).find(".cls_drp_tutor").val().trim() == "T")
                            {
                                brief_edit_status = "Y";
                                leadtutor_status = true;
                            }
                            else
                            {
                                brief_edit_status = "N";
                            }
                            to_be_later = "N";

                        }

                    }
                    else {
                        if ($(this).find('.cls_check').is(":checked") == false) {
                            if ($(this).find(".drpinstructor").val() == "") {
                                status_inst = false;
                                bootbox.alert("Please Select Instructor");
                                return false;
                            }
                            else if ($(this).find(".cls_drp_tutor").val() == "") {
                                status_inst = false;
                                bootbox.alert("Please Select Tutor Type");
                                return false;
                            }
                            else
                            {
                                inst_code += "," + $(this).find(".drpinstructor").val();
                                tutor_type += "," + $(this).find(".cls_drp_tutor").val();
                                if ($(this).find(".cls_drp_tutor").val().trim() == "T")
                                {
                                    brief_edit_status += "," + "Y";
                                    leadtutor_status = true;
                                }
                                else {
                                    brief_edit_status += "," + "N";
                                }
                                to_be_later += "," + "N";

                            }
                        }
                        else {

                            count_tbd = count_tbd + 1;
                            inst_code += "," + 'TBD_' + count_tbd;
                            tutor_type += "," + null;
                            brief_edit_status += "," + "N";
                            to_be_later += "," + "Y";

                        }

                    }

                    if ($('#hdn_user_id').val().trim() == $(this).find(".drpinstructor").val()) {
                        tutor_ex = true;
                    }
                });
                //21032025 Start
                if (count_lead_tutor > 1)
                {
                    bootbox.alert("Please Select only One Lead Tutor");
                    return false;
                }
                if (count_lead_tutor == 0) {
                    bootbox.alert("Please Select only One Lead Tutor");
                    return false;
                }
                //21032025 End 
                if (tutor_ex == false) {
                    bootbox.alert("Please Add your Instructor Details");
                    return false;
                }

                if (leadtutor_status == false)
                {
                    bootbox.alert("Please Select At least One Lead Tutor");
                    return false;
                }

                if (status_inst == false) {
                    return false;

                }

                //End

                if (next) {

                    if ($("#studio_title").val() == "") {
                        bootbox.alert("Please Enter Studio Title");
                        return false;
                    }

                    if ($("#sub_studio_title").val() == "") {
                        bootbox.alert("Please Enter Studio Sub Title");
                        return false;
                    }

                    if ($("#no_of_tutor").val() == "") {
                        bootbox.alert("Please Select No of Tutor");
                        return false;
                    }

                    if ($("#teaching_mode").val() == "") {
                        bootbox.alert("Please Select Mode of Teaching");
                        return false;
                    }
                }

                if ($("#txt_studio_dtl").val() == "" && $('#drpsemester_old').val() == "") {
                    bootbox.alert("Please Enter Studio Introducation");
                    return false;
                }

                if ($("#txt_studio_dtl").val() == "") {
                    if ($('#drpsemester_old').val() == "") {
                        bootbox.alert("Please Select Previous Semester");
                        return false;
                    }
                    if ($('#drpyear_old').val() == "") {
                        bootbox.alert("Please Select Previous Year");
                        return false;
                    }
                    if ($('#pre_course_code').val() == "") {
                        bootbox.alert("Please Select Previous Course Code");
                        return false;
                    }

                    if ($('#drpsemester1_old').val() == "") {
                        bootbox.alert("Please Select Previous Type");
                        return false;
                    }

                }
                else {
                    var text_length = $('#txt_studio_dtl').val().split(' ').length;
                    if (text_length >= '200') {
                        bootbox.alert('Studio Introducation Exceeds the Words Limit');
                        return false;
                    }
                }
                if ($("#drpsem").val() == "") {
                    bootbox.alert("Please Select Semester");
                    return false;
                }

                if ($("#drpyear").val() == "") {
                    bootbox.alert("Please Select Year");
                    return false;
                }

                var arr_data = data.split('_');

                var interested_program_selected_data = "";
                $("#studio_title").val().replace("&", "&#38;")
                $("#sub_studio_title").val().replace("&", "&#38;")
                if (studio_code == "")
                {
                    interested_program_selected_data = {
                        "dept_code": $('#drpdepartment').val(),
                        "prog_code": $('#prog_id').val(),
                        "prog_level_code": $('#program_level_code').val(),
                        "studio_level": $("#studio_level").val(),
                        "studio_title": $("#studio_title").val().replace(/[&<>"'\/]/g, function (s) {
                            return entityMap[s];
                        }),


                        "studio_subtitle": $("#sub_studio_title").val().replace(/[&<>"'\/]/g, function (s) {
                            return entityMap[s];
                        }),


                        "no_of_tutor": $("#no_of_tutor").val(),
                        "teaching_mode": $("#teaching_mode").val(),
                        "sem": $("#drpsem").val(),
                        "year": $("#drpyear").val(),
                        "studio_description": $("#txt_studio_dtl").val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                        "previous_sem_course_code": $('#pre_course_code').val(),
                        "previous_sem_code": $('#drpsemester_old').val(),
                        "previous_year_code": $('#drpyear_old').val(),
                        "inst_code": inst_code,
                        "tutor_type": tutor_type,
                        "brief_edit_status": brief_edit_status,
                        "to_be_later": to_be_later,
                        "mail_status": next,
                        "previous_type": $("#drpsemester1_old").val(),
                        "Portfolio_change_type": $('input[name=new_old_modification]:checked').length == 0 ? '' : $('input[name=new_old_modification]:checked').val()

                    };
                }
                else {
                    interested_program_selected_data = {
                        "dept_code": $('#drpdepartment').val(),
                        "prog_code": $('#prog_id').val(),
                        "prog_level_code": $('#program_level_code').val(),
                        "studio_level": $("#studio_level").val(),
                        "studio_title": $("#studio_title").val().replace(/[@&<>"'\/]/g, function (s) {
                            return entityMap[s];
                        }),
                        "studio_subtitle": $("#sub_studio_title").val().replace(/[&<>"'\/]/g, function (s) {
                            return entityMap[s];
                        }),
                        "no_of_tutor": $("#no_of_tutor").val(),
                        "teaching_mode": $("#teaching_mode").val(),
                        "sem": $("#drpsem").val(),
                        "year": $("#drpyear").val(),
                        "studio_description": $("#txt_studio_dtl").val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                        "studio_code": studio_code,
                        "previous_sem_course_code": $('#pre_course_code').val(),
                        "previous_sem_code": $('#drpsemester_old').val(),
                        "previous_year_code": $('#drpyear_old').val(),
                        "inst_code": inst_code,
                        "tutor_type": tutor_type,
                        "brief_edit_status": brief_edit_status,
                        "to_be_later": to_be_later,
                        "mail_status": next,
                        "previous_type": $("#drpsemester1_old").val(),
                        "Portfolio_change_type": $('input[name=new_old_modification]:checked').length == 0 ? '' : $('input[name=new_old_modification]:checked').val()


                    };
                }

                if (next) {
                    next_prev = true;
                }
                var interested_program_data = [];
                interested_program_data.push(interested_program_selected_data);
                var json_submit_data = JSON.stringify(interested_program_data);

                if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
                if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }


                if (studio_code == "") {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/submit_interested_program",
                        data: "{ interested_program_data: '" + json_submit_data + "' }",
                        //data: encodeURIComponent("{ interested_program_data: '" + json_submit_data + "' }"),
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != "") {
                                res = JSON.parse(data.d)
                                if (res['status'] == "1") {
                                    if (!next_prev) {
                                        alert("Studio proposal has been save successfully.");
                                        var url = "Interested_Program.aspx?studio_code=" + res['message'];
                                        window.open(url, "_self");
                                    }
                                    else {
                                        alert("Studio proposal has been save successfully.");
                                        var url = "Studio_Proposal_Dashboard.aspx";

                                        window.open(url, "_self");
                                    }
                                }
                                else if (res['status'] == "0") {
                                    alert(res['message']);

                                }
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }
                else {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/update_interested_program",
                        data: "{ interested_program_data: '" + json_submit_data + "' }",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != "") {
                                res = JSON.parse(data.d)
                                if (res['status'] == "1") {
                                    alert("Studio proposal has been submitted successfully.");
                                    if (next_prev) {
                                        var url = "Studio_Proposal_Dashboard.aspx";
                                        window.open(url, "_self");
                                    }
                                }
                                else if (res['status'] == "0") {
                                    alert(res['message']);
                                }
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }

            }
            $('#pdclick').click(function (e) {
                var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
                window.open(url, "_self");
            });
            $('#bdclick').click(function (e) {
                if ($("#hdn_tutor_type").val() == "temp") {
                    return false;
                } else {
                    var url = "vf_edit_personal_detail.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
                    window.open(url, "_self");
                }
            });
            $('#tutor_disabled').click(function (e) {
                if ($("#hdn_tutor_type").val() == "temp") {
                    return false;
                }
            });
            $('#sp_disabled').click(function (e) {
                //if (block) {
                //    return false;
                //}
                var url = "Studio_Details.aspx";
                window.open(url, "_self");
            });
            $('#lp_disabled').click(function (e) {
                if (block) {
                    return false;

                }
            });
            $(function () {
                $("#teaching_mode").change(function () {
                    var selectedText = $(this).find("option:selected").text();
                    var selectedValue = $(this).val();
                    if (selectedValue == "Blended") {
                        bootbox.alert("For more info refer Mode of Teaching pdf on Studio proposal details page");
                    }

                });
            });
            var text_max = 0;
            $('#txt_studio_dtl').keyup(function () {
                var text_length = $('#txt_studio_dtl').val().split(' ').length;
                var text_remaining = text_max + text_length;
                if (text_remaining > 200) {
                    $('#spn_desc').html('' + 'Total Words : ' + text_remaining);
                    $('#spn_desc').css('color', 'red');
                    //bootbox.alert('You Exceeds the Character Limit');
                } else {
                    $('#spn_desc').html('' + 'Total Words : ' + text_remaining);
                    $('#spn_desc').css('color', 'black');
                }

            });


            function bindpreviouscoursecode() {
                debugger
                var sem_code = $('#drpsemester_old').val();

                if (sem_code == '') {
                    bootbox.alert('Please select semester');
                    return false;
                }

                var year_code = $('#drpyear_old').val();

                if (year_code == '') {
                    bootbox.alert('Please select year');
                    return false;
                }
                var course_code = $('#pre_course_code').val();
                var pre_type = $('#drpsemester1_old').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_previous_sem_data_for_studio",
                    async: false,
                    data: "{sem_code:'" + sem_code + "',year_code:'" + year_code + "',course_code:'" + course_code + "',pre_type:'" + pre_type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            var coruse_data = JSON.parse(data.d);
                            if (course_code != '') {
                                $('#pre_studio_title').val(coruse_data[0]["course_name"]);
                            }
                            $('#pre_course_code').empty().append($("<option></option>").val("").html("-- Please Select Course Code --"));
                            for (var i = 0; i < coruse_data.length; i++) {
                                $('#pre_course_code').append($("<option></option>").val(coruse_data[i]["course_code"]).html(coruse_data[i]["course_code"]));

                            }
                            $('#pre_course_code').change();
                            $('#pre_course_code').trigger("liszt:updated");
                            $('#pre_course_code').chosen();
                            $('#pre_studio_title').val('');
                        }
                        else
                        {
                            $('#pre_course_code').empty().append($("<option></option>").val("").html("-- Please Select Course Code --"));
                            $('#pre_course_code').change();
                            $('#pre_course_code').trigger("liszt:updated");
                            $('#pre_course_code').chosen();
                            $('#pre_studio_title').val('');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function get_studio_title_dtl(title) {
                var sem_code = $('#drpsemester_old').val();

                if (sem_code == '') {
                    bootbox.alert('Please select semester');
                    return false;
                }

                var year_code = $('#drpyear_old').val();

                if (year_code == '') {
                    bootbox.alert('Please select year');
                    return false;
                }

                var course_code = $('#pre_course_code').val();
                if (course_code == '') {
                }
                var pre_type = $('#drpsemester1_old').val();
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_previous_sem_data_for_studio",
                    async: false,
                    data: "{sem_code:'" + sem_code + "',year_code:'" + year_code + "',course_code:'" + course_code + "',pre_type:'" + pre_type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var coruse_data = JSON.parse(data.d);

                            if (course_code != '') {

                                if (title != "title") {
                                    $('#pre_studio_title').val("");
                                    $('#program_level_code').val("");
                                    $('#program_level_code').change();
                                    $('#program_level_code').trigger("liszt:updated");
                                    $('#drpdepartment').val("");
                                    $('#drpdepartment').change();
                                    $('#drpdepartment').trigger("liszt:updated");
                                    $('#studio_level').val("");
                                    $('#studio_level').trigger("liszt:updated");
                                    $('#teaching_mode').val("");
                                    $('#teaching_mode').trigger("liszt:updated");
                                    $('#no_of_tutor').val("");
                                    $('#no_of_tutor').trigger("liszt:updated");

                                    $('#pre_studio_title').val(coruse_data[0]["course_name"]);
                                    $('#program_level_code').val(coruse_data[0]["prog_level_code"]);
                                    $('#program_level_code').change();
                                    $('#program_level_code').trigger("liszt:updated");
                                    $('#studio_level').val(coruse_data[0]["sub_category_id"]);
                                    $('#studio_level').trigger("liszt:updated");
                                    $('#teaching_mode').val(coruse_data[0]["studio_mode"]);
                                    $('#teaching_mode').trigger("liszt:updated");
                                    //
                                    var text_remaining = '';
                                    if (coruse_data[0]["studio_description"] != '') {
                                        $('#txt_studio_dtl').val(coruse_data[0]["studio_description"]);

                                        text_remaining = coruse_data[0]["studio_description"].split(' ').length;

                                    }
                                    else {
                                        $('#txt_studio_dtl').val(coruse_data[0]["course_desc"]);
                                        text_remaining = coruse_data[0]["course_desc"].split(' ').length;
                                    }

                                    if (text_remaining >= '200') {
                                        $('#spn_desc').html('' + 'Total Words : ' + text_remaining);
                                        $('#spn_desc').css('color', 'red');
                                    }
                                    else {
                                        $('#spn_desc').html('' + 'Total Words : ' + text_remaining);
                                        $('#spn_desc').css('color', 'black');
                                    }
                                    $('#studio_title').val(coruse_data[0]["studio_title"]);
                                    $('#no_of_tutor').val(coruse_data[0]["no_of_tutor"]);
                                    $('#no_of_tutor').trigger("liszt:updated");
                                    bindinst();
                                    prev_course_wise_inst();

                                } else {
                                    $('#pre_studio_title').val(coruse_data[0]["course_name"]);
                                }
                            }
                        }
                        else {
                            //$('#pre_course_code').empty().append($("<option></option>").val("").html("-- Please Select Course Code --"));
                            //$('#pre_course_code').change();
                            //$('#pre_course_code').trigger("liszt:updated");
                            //$('#pre_course_code').chosen();
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            function bindsemdata() {
                $('#drpsemester_old').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
                $('#drpsemester_old').append($("<option></option>").val("M").html("Monsoon"));
                $('#drpsemester_old').append($("<option></option>").val("S").html("Spring"));

                $('#drpsemester_old').chosen();
            }
            function bindyeardata() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_year_data",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var year_data = JSON.parse(data.d);

                            $('#drpyear_old').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                            for (var i = 0; i < year_data.length; i++) {
                                $('#drpyear_old').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                            }

                            $('#drpyear_old').chosen();
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            $('#tblinstructor tbody tr td i.icon-trash').live('click', function (e) {

                var r = confirm("Are you sure you want to remove this?");
                if (r == true) {
                    var thisdata = $(this).closest("tr");
                    var row_id = $(this).closest("tr")[0].id;
                    var inst_id = $("#" + row_id + ' ' + 'td').find('.drpinstructor').val();
                    $(this).closest("tr").remove();
                    $("[data-bind_row_no='" + e.currentTarget.dataset["row_no"] + "']").remove();
                    if (studio_code != '' && studio_code != undefined) {
                        var sem = $('#drpsem').val();
                        var year = $('#drpyear').val();
                        delete_inst(studio_code, inst_id, sem, year)
                    }


                }
            });

            $('#tblinstructor tbody tr td input').live('click', function (e) {

                // var r = confirm("Are you sure you want to remove this?");
                //if (r == true) {
                var thisdata = $(this).closest("tr");
                var row_id = $(this).closest("tr")[0].id;

                if ($(this).is(":checked")) {
                    $("#" + row_id + ' ' + 'td .drpinstructor').prop("disabled", true);
                    $("#" + row_id + ' ' + 'td .drpinstructor').val("");
                    $("#" + row_id + ' ' + 'td .drpinstructor').trigger("liszt:updated");

                    $("#" + row_id + ' ' + 'td .cls_drp_tutor').prop("disabled", true);
                    $("#" + row_id + ' ' + 'td .cls_drp_tutor').val("");
                    $("#" + row_id + ' ' + 'td .cls_drp_tutor').trigger("liszt:updated");
                    $("#" + row_id + ' ' + 'td .icon-trash').prop("disabled", true);
                } else {
                    $("#" + row_id + ' ' + 'td .drpinstructor').prop("disabled", false);
                    $("#" + row_id + ' ' + 'td .cls_drp_tutor').prop("disabled", false);
                    $("#" + row_id + ' ' + 'td .icon-trash').prop("disabled", false);
                }
                //}
            });


            if (studio_code != "" && old_course_code_bool) {
                $('input[type=radio][name=rdo_proposal_type][value=E]')[0].checked = true;
                $('input[name=rdo_proposal_type]').trigger('change');


                $('input[type=radio][name=new_old_modification][value=' + port_change_type + ']')[0].checked = true;
                $('input[name=new_old_modification]').trigger('change');


            } else if (studio_code != "" && old_course_code_bool == false) {

            } else {
                getCurrentSemYearCallForStudio();
                $("#drpsem").attr("disabled", "disabled");
                $("#drpyear").attr("disabled", "disabled");
                $('#drpyear').trigger("liszt:updated");
            }

            function prev_course_wise_inst() {

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_course_wise_inst",
                    data: "{sem_code:'" + $('#drpsemester_old').val() + "',year_code:'" + $('#drpyear_old').val() + "',course_code:'" + $('#pre_course_code').val() + "'}",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            var data_d = JSON.parse(data.d)
                            for (var k = 0; k < data_d.length; k++) {
                                if (k == 0) {
                                    $('#tblinstructor tbody').html('');
                                    add_instructor_cnt = 1;
                                }
                                var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td>" + instructor + "</td>";
                                str += "<td><select  onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                                str += "<td disabled><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td></td></tr>";
                                $('#tblinstructor tbody').append(str);
                                add_instructor_cnt = add_instructor_cnt + 1;
                                var id_text = '#' + (k + 1) + ' ' + 'td';
                                $(id_text).find(".drpinstructor").val(data_d[k]['instructor_code']);
                                $(id_text).find(".cls_drp_tutor").val(data_d[k]['tutor_type']);
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            document.getElementById('no_of_tutor').addEventListener('change', function () {
                var selectedValue = this.value;
                if (selectedValue == "Single")
                {
                    console.log(selectedValue);
                    $('select[data-row_no="1"]').val('T');
                    $('select[data-row_no="1"]').trigger("chosen:updated");
                }
                
            });

            
        });


        function rdo_tutorial_click(e) {
            if (e.value == "N") {
                $('#txt_studio_dtl').val('');
                $('#studio_title').val('');
                $('#no_of_tutor').val('');
                $('#teaching_mode').val('');
                $('#studio_level').val('');
                $('#drpsemester1_old').val('');
                var studio_code = getQueryStringValue_new('studio_code');
                if (studio_code == "") {
                    $('#tblinstructor tbody').html('');
                    add_instructor_cnt = 1;
                    var instructor = $('#hdn_inst_id').val(); 
                    var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td class='disabled-td'>" + instructor + "</td>";
                    str += "<td><select  onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                    str += "<td disabled></td><td></td></tr>";
                    //<center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center>
                    $('#tblinstructor tbody').append(str);
                    add_instructor_cnt = add_instructor_cnt + 1;
                    var id_text = '#1' + ' ' + 'td';
                    $(id_text).find(".drpinstructor").val($('#hdn_user_id').val().trim());

                }
            }

        }
        function studio_dtl() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_studio_proposal_dtl_dashboard",
                    async: true,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_details = JSON.parse(data.d)
                            if (user_details.length > 0) {
                                for (var i = 0; i < user_details.length; i++) {
                                    if (user_details[i]["approved"] == 'Y') {
                                        $("#sd").css('display', 'block');
                                        return false;
                                    }
                                }
                            }



                        }
                        else {
                        }

                    },
                    error: function (result) {
                        // alert(result);
                    }
                });
            return false;
        }


        function delete_inst(stu_code, inst, sem, year) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/StudiowiseDeleteinst",
                async: false,
                data: "{studio_code:'" + stu_code + "',inst_code:'" + inst + "',semester_type:'" + sem + "',year_semester:'" + year + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {

                    }

                },
                error: function (result) {
                    alert(result);
                }
            });
        }



        function prev_course_wise_inst() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_course_wise_inst",
                data: "{sem_code:'" + $('#drpsemester_old').val() + "',year_code:'" + $('#drpyear_old').val() + "',course_code:'" + $('#pre_course_code').val() + "'}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var data_d = JSON.parse(data.d)
                        for (var k = 0; k < data_d.length; k++) {
                            if (k == 0) {
                                add_instructor_cnt = 1;
                            }
                            var str = "<tr id ='" + add_instructor_cnt + "' data-row_no='" + add_instructor_cnt + "' ><td>" + instructor + "</td>";
                            str += "<td><select  onchange='append_tutor_value(this)' data-row_no='" + add_instructor_cnt + "' id ='" + add_instructor_cnt + "' class='cls_drp_tutor' style='width: 100%;'><option value=''>---Select Tutor---</option><option value='T'>Lead Tutor</option><option value='CT'>Co Tutor</option></select></td>";
                            str += "<td disabled><center><i data-row_no='" + add_instructor_cnt + "' class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td><td></td></tr>";
                            $('#tblinstructor tbody').append(str);
                            add_instructor_cnt = add_instructor_cnt + 1;
                            var id_text = '#1' + ' ' + 'td';
                            $(id_text).find(".drpinstructor").val(data_d[k]['instructor_code']);
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function getQueryStringValue_new(key) {
            return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }
        //changes 10022022
        //function remove(e) {
        //    $('#' + e.id).remove();
        //    if ($('#table_bind tr').length == 1) {
        //        $('#dynamic_table').css('display', 'none');
        //    }
        //}
    </script>
    <style type="text/css">
        .title {
            width: 15%;
            float: left;
        }

        .right {
            width: 30%;
            float: left;
        }

        .style_prevu_kit {
            /*display: inline-block;*/
            padding: 15px;
            border: 0;
            width: 170px;
            height: 26px;
            position: relative;
            border-radius: 5px 10px;
            -webkit-transition: all 200ms ease-in;
            -webkit-transform: scale(1);
            -ms-transition: all 200ms ease-in;
            -ms-transform: scale(1);
            -moz-transition: all 200ms ease-in;
            -moz-transform: scale(1);
            transition: all 200ms ease-in;
            transform: scale(1);
            color: #b5e6e3;
            font-weight: 300;
            font-size: 20px;
            font-family: 'Roboto';
            margin-top: 10px;
            margin-left: 10px;
            float: left;
        }

            .style_prevu_kit:hover {
                box-shadow: 0px 0px 150px #000000;
                z-index: 2;
                -webkit-transition: all 200ms ease-in;
                -webkit-transform: scale(1.5);
                -ms-transition: all 200ms ease-in;
                -ms-transform: scale(1.5);
                -moz-transition: all 200ms ease-in;
                -moz-transform: scale(1.5);
                transition: all 200ms ease-in;
                transform: scale(1);
            }

        .arrow {
            border: solid white;
            border-width: 0 3px 3px 0;
            display: inline-block;
            padding: 3px;
        }

        .down {
            transform: rotate(45deg);
            -webkit-transform: rotate(45deg);
        }

        .show-grid [class^=col-] {
            padding-top: 10px;
            padding-bottom: 10px;
            border: 1px solid #ddd;
            border: 1px solid rgba(86,61,124,.2);
            list-style: none;
        }

        .glyphicon {
            margin-top: 5px;
            margin-bottom: 10px;
            font-size: 35px;
        }

        .inactive {
            color: #ccc;
            background-color: #fafafa;
        }

        .active, .inactive {
            width: 19.6% !important;
        }

        #for_I2 {
            z-index: 1;
        }

        #pdclick:hover {
            text-decoration: underline;
        }
    </style>

     <style>
  
.step i.awesome {
  display: none;
}


.main {
    width: 100%;
   
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}

.animation {
    display: flex;
}

ul li {
    list-style: none;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin: 0 40px;
}
#lp_disabled{
    margin-right:-1500%;
}


ul li .label {
    font-family: sans-serif;
    letter-spacing: 1px;
    font-size: 14px;
    font-weight: bold;
    color: #1b761b;
}
.completed {
    color: green !important;
}


ul li .step {
    height: 30px;
    width: 30px;
    border-radius: 50%;
    background-color: #d7d7c3;
    margin: 16px 0 10px;
    display: grid;
    place-items: center;
    color: ghostwhite;
    position: relative;
    cursor: pointer;
}

.step::after {
    content: "";
    position: absolute;
    width: 865px;
    height: 3px;
    background-color: #d7d7c3;
    right: 30px;
}
.first::after {
    width: 0;
    height: 0;
}

ul li .step .awesome {
    display: none;
}

ul li .step p {
    font-size: 18px;
}

ul li .active {
    background-color: #1b761b;
}

li .active::after {
    background-color: #1b761b;

}

ul li .active p {
    display: none;
}

ul li .active .awesome {
    display: flex;
}

    </style>


    <script>
        document.addEventListener("DOMContentLoaded", function ()
        {

            // Your JavaScript code here
            function updateProgressBar() {
                const progressBar = document.querySelector('.progress-container');
                let progress = 0;
                const interval = setInterval(() => {
                    progress += 1;
                    progressBar.style.width = progress + '%';
                    if (progress >= 100) {
                        clearInterval(interval);
                        progressBar.classList.add('completed');
                    }
                }, 100);

                setTimeout(() => {
                    clearInterval(interval);
                    progressBar.classList.add('completed');
                }, 3000);
            }

            window.onload = updateProgressBar;
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row" style="margin-top: 11px; width: 100%; border: 0px solid rgba(113, 112, 112, 1); background-color: rgba(255, 255, 255, 1); border-radius: 0; box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6); margin-left: 1px; display: block;" id="for_I2">
        <h5 class="font_8" style="margin-left: 5px; font-size: 18px; margin-top: 3px;">Call for Studio Tutor
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue;"><a href="Studio_Proposal_dtl.aspx">View Submitted Proposal</a></span>
            <%--<span style="font-size: 10pt; float: right; margin-right: 0.8%; text-shadow: 0 0 slateblue;">|</span>
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a></span>--%>
        </h5>
        <div style="margin-left: 1%; border-top: 1px solid #c2c2c2ab; width: 97.8%;"></div>
        <%--<span style="font-size: 10pt;text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a>: If you are proposing a new studio, <a href="Interested_Program.aspx">click here</a> to submt your proposal.</span></br></br>
            <span style="font-size: 10pt;text-shadow: 0 0 slateblue;"><a href="Existing_Interested_Program.aspx">Existing Studio Brief</a>: If you are proposing an existing CAC approved studio unit from the previous semesters, <a href="Existing_Interested_Program.aspx">click here</a> to retrieve/add/edit and submit the brief with no change/ minor change (changing site location or order of exercises..</span></br></br>--%>
           <div class="progress-bar">
    <span class="progress-container"></span>
  </div>
      <div class="main">
    <ul class="animation" style="margin-left:-72%;">
        <li>
            <div class="step first">
                 <p><i class="fa fa-close" style="font-size:22px;color:#ffeeee"></i></p>
                
            </div>
             <p id="pdclick" style="color: black;">Personal Details</p>
        </li>
        <li>
            <div class="step second" style="margin-right: -1500%;background-color:#5B9BD5!important;">
                 <p><i class="fa fa-check" style="font-size:22px;color:#ffeeee"></i></p>
                
            </div>
            <a href="Interested_Program.aspx" id="lp_disabled" style="color: black;">Studio Proposal</a>
        </li>  
    </ul>        
</div>  
    


        <%--<ol class="show-grid col-md-8 col-md-offset-2" style="margin-left: -8px; width: 100%; margin-bottom: 10px; margin-top: 5px;">

            <li class="col-md-3 active" id="pd" style="width: 27.5% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-user"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 1:</strong></h5>
                        <p id="pdclick" style="color: black;">Personal Details</p>


                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="ip" style="width: 28% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-book"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 2:</strong></h5>
                        <a href="Interested_Program.aspx" id="lp_disabled" style="color: black;">Studio Proposal</a>

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="sd" style="width: 28% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 3:</strong></h5>
                        <a href="Studio_Details.aspx" id="sp_disabled" style="color: black;">Studio Brief</a>

                    </div>
                </div>
            </li>

        </ol>--%>
    </div>
    <%--<div class="row-fluid">
        <div style="width: 1200px; margin-top: 10px;">
            <a href="frm_personal_details.aspx" style="text-decoration: none;">
                <div class="style_prevu_kit" style="background-color: #b8b3b3; text-align: center;" id="pd">
                    <p style="color: white; font-size: 16px;font-family:Open Sans;">Personal Details</p>
                </div>
            </a>
            <a href="" style="text-decoration: none;">
                <div class="style_prevu_kit" style="background-color: #ff1e1eeb; text-align: center;box-shadow: 3px 3px black;" id="ip">
                    <p style="color: white; font-size: 16px;font-family:Open Sans;">Level/Program</p>
                    <i class="arrow down"></i><%--&#8681;
                </div>
            </a>
            <a href="Studio_Details.aspx" style="text-decoration: none;">
                <div class="style_prevu_kit" style="background-color: #b8b3b3; text-align: center;" id="sd">
                    <p style="color: white; font-size: 16px;font-family:Open Sans;">Studio Proposal Details</p>
                </div>
            </a>
            <a href="frm_personal_details.aspx" style="text-decoration: none;">
                <div class="style_prevu_kit" style="background-color: #b8b3b3; text-align: center;" id="bd">
                    <p style="color: white; font-size: 16px;font-family:Open Sans;">Bank Details</p>
                </div>
            </a>
        </div>
    </div>--%>

    <div class="panel panel-default" style="margin-top: 1%; padding: 0px 0px 20px 0px;">

        <div class="panel-heading">
            <b>Level/Program</b>
        </div>

        <%--<div class="row-fluid" style="margin-top: 2%;">
            <h4 style="width: 100%;">Select the program and level for which you intend to submit the studio proposal. <span style="color: red;">*</span></h4>
            <%--<h6>(<span id="semdesc"></span>)</h6>
            <br />
        </div>--%>

        <div class="row-fluid" style="" id="program_data">
            <%--  <div style="">
                <div style="width: 37%; float: left;">
                    <b>Select the Program for which you have proposed the studio <span style="color: red;">*</span></b>
                </div>
                <div style="width: 63%; float: left;">
                    <select id="program_level_code">
                    </select>
                </div>
            </div>--%>

            <div style="">
                <table style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tbody>
                        <tr>
                            <td class="pad-top">Semester <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                            </td>
                            <td>
                                <select id="drpsem">
                                    <option value="">-- Please Select Semester --</option>
                                    <option value="S">Spring</option>
                                    <option value="M">Monsoon</option>
                                </select>
                            </td>
                            <td class="pad-top">Year <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                            </td>
                            <td>
                                <select id="drpyear"></select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="radio" name="rdo_proposal_type" value="N" onclick="rdo_tutorial_click(this)" checked="checked" />&nbsp;&nbsp;New Proposal</td>
                            <td>
                                <input type="radio" name="rdo_proposal_type" value="E" onclick="rdo_tutorial_click(this)" />&nbsp;&nbsp;Existing Proposal </td>
                        </tr>
                        <tr class="hdn_new_proposal" style="display: none;">

                            <td>Previous Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester_old">
                                </select>
                            </td>
                            <td>Previous Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear_old">
                                </select>
                            </td>


                        </tr>
                        <tr class="hdn_new_proposal" style="display: none;">
                            <td>Previous Type :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester1_old">
                                    <option value="">--Please select PreviousType--</option>
                                    <option value="A">Approved Course</option>
                                    <option value="Y">Save Course but Not Publish</option>
                                </select>
                            </td>


                            <td>Previous Course Code </td>
                            <td>
                                <select id="pre_course_code">
                                    <option value="">-- Please Select Course Code --</option>
                                </select></td>
                        </tr>
                        <tr class="hdn_new_proposal" style="display: none;">
                            <td>Previous Course Name</td>
                            <td>
                                <input type="text" style="width: 250%;" id="pre_studio_title" disabled="disabled" /></td>
                        </tr>

                        <tr class="hdn_new_proposal" style="display: none;">
                            <td>Proposal Type: </td>
                            <td colspan="3">
                                <input type="radio" name="new_old_modification" value="NE" id="radio_buttons" checked="checked">
                                Being changed/modified to proposal a new studio
                                <input type="radio" name="new_old_modification" value="PE" id="radio_buttons">
                                Repeating with minor changes to offer the same studio again
                            </td>
                        </tr>

                        <tr>
                            <td>Select the Program for which you have
                                <br />
                                proposed the studio <span style="color: red;">*</span></td>
                            <td>
                                <select id="program_level_code">
                                </select></td>
                        </tr>
                        <tr>
                            <td class="pad-top">Select the Level <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                                <br />
                                <a href="../../StudioDetails/Studio_Levels.pdf" download="" style="color: blue; font-size: 12px;">(Refer docs)</a>
                            </td>
                            <td>
                                <select id="studio_level">
                                </select>
                            </td>
                            <td class="pad-top">Faculty <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                            </td>
                            <td>
                                <select id="drpdepartment" disabled="disabled">
                                </select>
                            </td>

                            <td>
                                <input id="prog_id" disabled="disabled" style="display: none;" />
                            </td>
                        </tr>
                        <tr>
                            <td class="pad-top">Title of Studio <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                            </td>
                            <td>
                                <input type="text" style="width: 245%;" id="studio_title" />
                            </td>
                        </tr>

                        <tr>
                            <td class="pad-top">SubTitle of Studio <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                            </td>
                            <td>
                                <input type="text" style="width: 245%;" id="sub_studio_title" />
                            </td>
                        </tr>
                        <tr>
                            <td class="pad-top">No of Tutor <span class="cls_mendatory" style="display: inline-block; color: red;">*</span><br />
                                <a href="../../StudioDetails/Add-Instructor.pdf" download="" style="color: blue; font-size: 12px;">(Refere docs)</a>
                            </td>
                            <td>
                                <select id="no_of_tutor">
                                    <option value="">-- Please Select Tutor --</option>
                                    <option value="Single">Single</option>
                                    <option value="Dual">Dual</option>
                                    <option value="Multiple">Multiple</option>
                                </select>
                            </td>
                            <td class="pad-top">Mode of Teaching <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                                <br />
                                <a href="../../StudioDetails/Mode-of-Teaching-v3.pdf" download="" style="color: blue; font-size: 12px;">(Refer docs)</a>
                            </td>
                            <td>
                                <select id="teaching_mode">
                                    <option value="">-- Please Select Mode --</option>
                                    <option value="Full On-Campus">Full On-Campus</option>
                                    <%--<option value="Hybrid">Hybrid</option>--%>
                                    <option value="Blended">Blended</option>
                                </select>
                            </td>
                        </tr>
                        <%--10022022--%>
                        <%--<tr id="inst_dtl">
                            <td class="pad-top">Instractor <span class="cls_mendatory" style="color: red;">*</span></td>
                            <td colspan="4">
                                <select class="chosen-select" id="instr_code" style="display: inline-block;"></select>
                                <select id="tutor" style="display: inline-block; margin-top: 10px;">
                                    <option value="">-- Please Select Tutor --</option>
                                    <option value="CT">Co-Tutor </option>
                                    <option value="T">Lead Tutor</option>
                                </select>
                                <input type="button" id="add_inst" value="Add" class="btn btn-primary" style="line-height: 143.5%; margin-bottom: -1px;" />

                            </td>

                        </tr>--%>
                        <tr>
                            <td></td>
                            <td colspan="3">
                                <div id="dynamic_table" style="display: block;">
                                    <%--<table id="table_bind" class="table table-bordered" style="width: 94%;"></table>--%>
                                    <div class="row-fluid" id="dataList_instructor" style="float: left; width: 50%; display: block;">
                                        <div class="box-content box-no-padding">
                                            <button class="btn  btn-primary" type="button" id="btn_instructor">
                                                <i class="icon-plus"></i>&nbsp;Add Instructor
                                            </button>
                                        </div>
                                        <table class="data-table table table-bordered table-striped" border="0" id="tblinstructor" style="width: 168% !important">
                                            <thead>
                                                <tr>
                                                    <th style="width: 45%;">Instructor</th>
                                                    <th style="width: 38%;">Tutor
                                    <select style="width: 100%; display: none;" id="cls_drp_tutor">
                                        <option value="">--</option>
                                        <option value="T">Lead Tutor</option>
                                        <option value="CT">Co Tutor</option>
                                    </select>
                                                    </th>
                                                    <th></th>
                                                    <th style="width: 45%;"></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                        <div id="co_tutor_note" style="width: 168%; display: none; color: red;">It is mandatory for the added instructor to complete the Step-1  i.e personal details through his/her connect login, for your submission to be considered further</div>
                                    </div>

                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6"><span><b>Note: Existing Tutor offering proposal with minor change must include course code and name of studio (title) & Semester & year of offering</b></span></td>
                        </tr>

                        <tr style="height: 120px;">
                            <td>Studio Introducation <span style="color: blue;">(MAX 200 Words)</span><span class="cls_mendatory" style="display: inline-block; color: red;">*</span></td>
                            <td colspan="3">
                                <textarea id="txt_studio_dtl" style="width: 92%; margin-bottom: 0px;" rows="4" cols="30" name="studio_dtl"></textarea>
                                <span id="spn_desc" style="float: right; margin-bottom: 10px;">Total Words : 0</span>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <%-- <div class="title">
                    <b>Select the Level <span style="color: red;">*</span></b>
                </div>
                <div class="right">
                    <select id="studio_level">
                    </select>
                </div>--%>
                <%--  <div class="title">
                    <b>Faculty <span style="color: red;">*</span></b>
                </div>
                <div class="right">
                    <select id="drpdepartment" disabled="disabled">
                    </select>
                </div>--%>
            </div>
            <%-- <div style="">
                <div class="title">
                    <b>Title of Studio <span style="color: red;">*</span></b>
                </div>
                <div style="width: 85%; float: left;">
                    <input type="text" style="width: 75.9%;" id="studio_title" />
                </div>
            </div>--%>
            <%--      <div style="">
                <div class="title">
                    <b>No of Tutor <span style="color: red;">*</span></b>
                </div>
                <div class="right">
                    <select id="no_of_tutor">
                        <option value="">-- Please Select Tutor --</option>
                        <option value="Single">Single</option>
                        <option value="Dual">Dual</option>
                    </select>
                </div>
                <div class="title">
                    <b>Mode of Teaching <span style="color: red;">*</span></b>
                </div>
                <div class="right">
                    <select id="teaching_mode">
                        <option value="">-- Please Select Mode --</option>
                        <option value="Online">Online</option>
                        <option value="Campus">Campus</option>
                    </select>
                </div>
            </div>--%>
            <%--  <div style="">
                <div class="title">
                    <b>Semester <span style="color: red;">*</span></b>
                </div>
                <div class="right">
                    <select id="drpsem">
                        <option value="">-- Please Select Semester --</option>
                        <option value="S">Spring</option>
                        <option value="M">Monsoon</option>
                    </select>
                </div>
                <div class="title">
                    <b>Year <span style="color: red;">*</span></b>
                </div>
                <div class="right">
                    <select id="drpyear">
                    </select>
                </div>
            </div>--%>
        </div>
    </div>
    <%-- <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="div_button" class="controls call_for_studio" style="text-align: center">
                    <table style="width: 100%">
                        <tbody>
                            <tr>
                                <td align="center" style="width: 40%;">
                                    <input type="button" id="btn_prev" value="<< Previous" class="btn btn-primary" style="" /></td>
                                <td align="" style="width: 20%;">
                                    <button id="btn_save" type="button" style="display: block; float: center;" class="btn btn-primary"><i class="icon-save bigger-160"></i>Save</button></td>
                                <td align="center" style="width: 40%;">
                                    <input type="button" id="btn_next" value="Step 3 >>" class="btn btn-primary" style="" /></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>--%>

    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                    <table style="width: 100%">
                        <tbody>
                            <tr>
                                <td align="center" style="width: 40%;">
                                    <button id="btn_prev" type="button" style="display: block; margin-right: -75%;" class="btn btn-primary"><< Previous</button>
                                    <%--<input type="button" id="btn_prev" value="<< Previous" class="btn btn-primary" style="margin-right: 10px;" />--%>
                                </td>
                                <td align="" style="width: 20%;">
                                    <button id="btn_save" type="button" style="display: block; float: center;" class="btn btn-primary"><i class="icon-save bigger-160"></i>Save</button>
                                    <%--<input type="button" id="btn_save" value="Save" class="btn btn-primary" />--%>
                                </td>
                                <td align="center" style="width: 40%;">
                                    <button id="btn_next" type="button" style="margin-left: -143%;" class="btn btn-primary"><i class="icon-save bigger-160"></i>Submit</button>
                                    <%--<input type="button" id="btn_next" value="Step 3 >>" class="btn btn-primary" style="margin-left: 10px; width: 88px;" />--%>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->
    </div>

    <%--    <div id="div_button" style="text-align: center; margin-top: 3%;" class="">
        <input type="button" id="btn_prev" value="<< Previous" class="btn btn-primary" style="margin-right: 10px;" />
        <input type="button" id="btn_save" value="Save" class="btn btn-primary" />
        <input type="button" id="btn_next" value="Step 3 >>" class="btn btn-primary" style="margin-left: 10px; width: 88px;" />
    </div>--%>

    <%--<div style="margin-top: 1%;" id="program_data">

        <div style="margin-top: 5px;"><b>Level 2</b></div>

        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="1_1_UA_L2" id="1_1_UA_L2" style="margin-top: 0px;" />
            <span>Bachelor of Architecture</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="2_1_UD_L2" id="2_1_UD_L2" style="margin-top: 0px;" />
            <span>Bachelor of Interior Design</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="2_1_UD2_L2" id="2_1_UD2_L2" style="margin-top: 0px;" />
            <span>Bachelor of Design (Building Products and Systems/Furniture)</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="4_1_UP2_L2" id="4_1_UP2_L2" style="margin-top: 0px;" />
            <span>Bachelor of Urban Design</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="5_1_UT_L2" id="5_1_UT_L2" style="margin-top: 0px;" />
            <span>Bachelor of Construction Technology</span>
        </div>

        <div style="margin-top: 5px;"><b>Level 3</b></div>

        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="1_1_UA_L3" id="1_1_UA_L3" style="margin-top: 0px;" />
            <span>Bachelor of Architecture</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="2_1_UD_L3" id="2_1_UD_L3" style="margin-top: 0px;" />
            <span>Bachelor of Interior Design</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="4_1_UP2_L3" id="4_1_UP2_L3" style="margin-top: 0px;" />
            <span>Bachelor of Urban Design</span>
        </div>
		<div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="5_1_UT_L3" id="5_1_UT_L3" style="margin-top: 0px;" />
            <span>Bachelor of Construction Technology</span>
        </div>

        <div style="margin-top: 5px;"><b>Level 4</b></div>

        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="1_2_PA4_L4" id="1_2_PA4_L4" style="margin-top: 0px;" />
            <span>M Arch in Architectural Design</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="1_2_PA2_L4" id="1_2_PA2_L4" style="margin-top: 0px;" />
            <span>Master of Landscape Architecture</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="2_2_PD4_L4" id="2_2_PD4_L4" style="margin-top: 0px;" />
            <span>Master of Design in Interior Design</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="2_2_PD2_L4" id="2_2_PD2_L4" style="margin-top: 0px;" />
            <span>Master of Design in Furniture Design</span>
        </div>
        <div style="margin-top: 5px;">
            <input type="checkbox" name="selected_program" value="2_2_PD5_L4" id="2_2_PD5_L4" style="margin-top: 0px;" />
            <span>Master of Design in Building Products and Systems</span>
        </div>
    </div>--%>

     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script type="text/javascript">

</script>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_tutor_type" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_user_id" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_inst_id" value="" />
</asp:Content>

