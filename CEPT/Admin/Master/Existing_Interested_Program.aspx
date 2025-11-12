<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Existing_Interested_Program.aspx.cs" Inherits="Admin_Master_Existing_Interested_Program" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            var program_data = '';
            var sem = '';
            var year = '';
            var next_prev = false;
            var block = false;
            var prog_data = "";

            get_program_list_for_interested_program();
            getCurrentSemYearCallForStudio();
            getInterestedProgramDetails();
            call_for_studio_status_track();
            binddepartment();
            bindyeardata_for_cross_reg();
            bindProgramsByStudioLevels();

            var studio_code = getQueryStringValue('studio_code');

            if (studio_code != "") {
                getStudioProposalsDetails(studio_code);
            } else {
                $('#studio_level').empty().append($("<option></option>").val("").html("-- No Level Found --"));
            }

            //$('#program_level_code').on('change', function () {
            //    var data = $('#program_level_code').val();
            //    var arr_data = data.split('_');
            //    var selected_programs = arr_data[2];

            //    $('#studio_level').empty().append($("<option></option>").val("").html("-- Please Select Level --"));
            //    for (var i = 0; i < prog_data.length; i++) {
            //        if (prog_data[i]["prog_level_code"] == selected_programs) {
            //            $('#drpdepartment').val(prog_data[i]["dept_code"]);
            //            $('#studio_level').append($("<option></option>").val(prog_data[i]["studio_level"]).html(prog_data[i]["studio_level"]));
            //        }
            //    }
            //});

            $('#program_level_code').on('change', function () {
                var data = $('#program_level_code').val();
                //var arr_data = data.split('_');
                //var selected_programs = arr_data[2];

                $('#studio_level').empty().append($("<option></option>").val("").html("-- Please Select Level --"));
                for (var i = 0; i < prog_data.length; i++) {
                    if (prog_data[i]["prog_level_code"] == data) {//selected_programs
                        $('#drpdepartment').val(prog_data[i]["dept_code"]);
                        $('#prog_id').val(prog_data[i]["prog_code"]);
                        $('#studio_level').append($("<option></option>").val(prog_data[i]["studio_level"]).html(prog_data[i]["studio_level"]));
                    }
                }
            });

            //function getStudioProposalsDetails(s_code) {
            //    $.ajax({
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/getStudioProposalsDetails",
            //        async: false,
            //        data: "{studio_code : '" + s_code + "'}",
            //        dataType: "json",
            //        success: function (data) {
            //            if (data.d != "") {
            //                var studio_details = JSON.parse(data.d);
            //                $("#program_level_code").val(studio_details[0]["dept_code"] + "_" + studio_details[0]["prog_code"] + "_" + studio_details[0]["prog_level_code"] + "_" + studio_details[0]["studio_level"]).html(studio_details[0]["prog_level_name"]);
            //                $('#program_level_code').trigger("liszt:updated");
            //                $("#studio_title").val(studio_details[0]["studio_title"]);
            //                $("#no_of_tutor").val(studio_details[0]["no_of_tutor"]);
            //                $("#teaching_mode").val(studio_details[0]["teaching_mode"]);
            //                $("#drpsem").val(studio_details[0]["semester_type"]);
            //                $("#drpyear").val(studio_details[0]["year_semester"]);
            //                $('#drpyear').trigger("liszt:updated");

            //                var data_new = $('#program_level_code').val();
            //                var arr_data_new = data_new.split('_');
            //                var selected_programs_new = arr_data_new[2];
            //                $('#studio_level').empty().append($("<option></option>").val("").html("-- Please Select Level --"));
            //                for (var i = 0; i < prog_data.length; i++) {
            //                    if (prog_data[i]["prog_level_code"] == selected_programs_new) {
            //                        $('#drpdepartment').val(prog_data[i]["dept_code"]);
            //                        $('#studio_level').append($("<option></option>").val(prog_data[i]["studio_level"]).html(prog_data[i]["studio_level"]));
            //                    }
            //                }
            //                $("#studio_level").val(studio_details[0]["studio_level"]);
            //                $('#studio_level').trigger("liszt:updated");

            //                $("#program_level_code").attr('disabled', 'disabled');
            //                $('#program_level_code').trigger("liszt:updated");
            //                $("#studio_level").attr("disabled", "disabled");
            //                $("#drpsem").attr("disabled", "disabled");
            //                $("#drpyear").attr("disabled", "disabled");
            //                $('#drpyear').trigger("liszt:updated");
            //            }
            //        },
            //        error: function (result) {
            //            alert(result);
            //        }
            //    });
            //}

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
                            $("#no_of_tutor").val(studio_details[0]["no_of_tutor"]);
                            $("#teaching_mode").val(studio_details[0]["teaching_mode"]);
                            $("#drpsem").val(studio_details[0]["semester_type"]);
                            var text_remaining = studio_details[0]["studio_description"].split(' ').length;
                            if (text_remaining >= '150') {
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

                            $("#studio_level").val(studio_details[0]["studio_level"]);
                            $('#studio_level').trigger("liszt:updated");

                            $("#program_level_code").attr('disabled', 'disabled');
                            $('#program_level_code').trigger("liszt:updated");
                            $("#studio_level").attr("disabled", "disabled");
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
            //                        $('#program_level_code').append($("<option></option>").val(program_data[i]["dept_code"] + "_" + program_data[i]["prog_code"] + "_" + program_data[i]["prog_level_code"] + "_" + program_data[i]["studio_level"]).html(program_data[i]["prog_level_name"]));
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
                    url: "../../WebService.asmx/Existing_GetProgramsByStudioLevels",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            prog_data = "";
                            var program_data = JSON.parse(data.d);
                            prog_data = program_data;
                            $('#program_level_code').empty().append($("<option></option>").val("").html("-- Please Select Programs --"));
                            for (var i = 0; i < program_data.length; i++) {
                                if (i != 0 && (program_data[i - 1]["prog_level_code"] != program_data[i]["prog_level_code"])) {
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
                
                saveChanges(studio_code, true);
                if (next_prev) {
                    var url = "frm_personal_details.aspx?ie=" + $("#hdnuserid").val()+"";
                    //var url = "frm_personal_details.aspx";
                    window.open(url, "_self");
                }
            });

            $('#btn_save').on('click', function () {
                saveChanges(studio_code, false);
            });

            $('#btn_next').on('click', function () {
                //$('#btn_save').click();
                saveChanges(studio_code, true);
                //Changes by nitinbhai 14092021
                //if (next_prev)
                //{
                //    var url = '';
                //    if ($('#hdn_studio_code_paremeter').val() != '') {
                //        url = "Studio_Brief_Details.aspx?studio_code=" + $('#hdn_studio_code_paremeter').val() + "&s=" + $("#drpsem").val() + "&y=" + $("#drpyear").val() + "";
                //    }
                //    else
                //    {  url = "Studio_Brief_Details.aspx?studio_code=" + $('#hdn_studio_code').val() + "&s=" + $("#drpsem").val() + "&y=" + $("#drpyear").val() + "";}
                //    
                //    window.open(url, "_self");
                //}
            });

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
                                    $("#ip").addClass("inactive");
                                    $("#ip").removeClass("active");
                                    $("#sd").addClass("inactive");
                                    $("#sd").removeClass("active");
                                }
                                if (track_call_for_studio[1]["value"] == "Y")
                                {
                                    $("#ip").css('background-color', 'white');
                                    $("#studio_title").attr("disabled", "disabled");
                                    $("#no_of_tutor").attr("disabled", "disabled");
                                    $("#teaching_mode").attr("disabled", "disabled");
                                    $('#btn_save').attr('disabled', 'disabled');
                                } else
                                {
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
                  //var entityMap = {"&": "&amp;","<": "&lt;",">": "&gt;",'"': '&quot;',"'": '&#39;',"/": '&#x2F;'};
            var entityMap = {"'": '&#39;'};
            //var entityMap = {"'": "''"};
            function saveChanges(studio_code, next) {

                var data = $("#program_level_code").val();

                if (data == "") {
                    bootbox.alert("Please Select the Program for which you have proposed the studio");
                    return false;
                }

                if ($("#studio_level").val() == "") {
                    bootbox.alert("Please Select the Level");
                    return false;
                }
                if (next) {

                    if ($("#studio_title").val() == "") {
                        bootbox.alert("Please Enter Studio Title");
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
                if ($("#txt_studio_dtl").val() == "") {
                    bootbox.alert("Please Enter Studio Introducation");
                    return false;
                }
                else {
                    var text_length = $('#txt_studio_dtl').val().split(' ').length;
                    if (text_length >= '150') {
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

                //if (studio_code == "") {
                //    interested_program_selected_data = {
                //        "dept_code": arr_data[0],
                //        "prog_code": arr_data[1],
                //        "prog_level_code": arr_data[2],
                //        "studio_level": $("#studio_level").val(),
                //        "studio_title": $("#studio_title").val(),
                //        "no_of_tutor": $("#no_of_tutor").val(),
                //        "teaching_mode": $("#teaching_mode").val(),
                //        "sem": $("#drpsem").val(),
                //        "year": $("#drpyear").val()
                //    };
                //} else {
                //    interested_program_selected_data = {
                //        "dept_code": arr_data[0],
                //        "prog_code": arr_data[1],
                //        "prog_level_code": arr_data[2],
                //        "studio_level": $("#studio_level").val(),
                //        "studio_title": $("#studio_title").val(),
                //        "no_of_tutor": $("#no_of_tutor").val(),
                //        "teaching_mode": $("#teaching_mode").val(),
                //        "sem": $("#drpsem").val(),
                //        "year": $("#drpyear").val(),
                //        "studio_code": studio_code
                //    };
                //}

                if (studio_code == "") {
                    interested_program_selected_data = {
                        "dept_code": $('#drpdepartment').val(),
                        "prog_code": $('#prog_id').val(),
                        "prog_level_code": $('#program_level_code').val(),
                        "studio_level": $("#studio_level").val(),
                        "studio_title": $("#studio_title").val().replace(/[&<>"'\/]/g, function (s) 
                        {return entityMap[s];}),
                        "no_of_tutor": $("#no_of_tutor").val(),
                        "teaching_mode": $("#teaching_mode").val(),
                        "sem": $("#drpsem").val(),
                        "year": $("#drpyear").val(),
                        "studio_description": $("#txt_studio_dtl").val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; })
                    };
                } else {
                    interested_program_selected_data = {
                        "dept_code": $('#drpdepartment').val(),
                        "prog_code": $('#prog_id').val(),
                        "prog_level_code": $('#program_level_code').val(),
                        "studio_level": $("#studio_level").val(),
                        "studio_title": $("#studio_title").val().replace(/[&<>"'\/]/g, function (s) 
                        {return entityMap[s];}),
                        "no_of_tutor": $("#no_of_tutor").val(),
                        "teaching_mode": $("#teaching_mode").val(),
                        "sem": $("#drpsem").val(),
                        "year": $("#drpyear").val(),
                        "studio_description": $("#txt_studio_dtl").val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
                        "studio_code": studio_code
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

                //console.log(json_submit_data);

                if (studio_code == "") {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Existing_interested_program_submit",
                        data: "{ interested_program_data: '" + json_submit_data + "' }",
                        dataType: "json",
                        async: false,
                        success: function (data) {
                            if (data.d != "") {
                                res = JSON.parse(data.d)
                                if (res['status'] == "1")
                                {
                                    $('#hdn_studio_code').val(res['message']);
                                    alert("Selection saved.");
                                    if (!next_prev) {
                                        var url = "Existing_Interested_Program.aspx?studio_code=" + res['message'];
                                        window.open(url, "_self");
                                    } else {
                                       // var url = "Studio_Details.aspx?studio_code=" + res['message'];
                                        var url = "Existing_Interested_Program.aspx?studio_code=" + res['message'];
                                        window.open(url, "_self");
                                    }
                                }
                                else if (res['status'] == "0") {
                                    alert(res['message']);
                                    //var url = "Clearance_Status.aspx";
                                    //window.open(url, '_self');
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
                                    alert(res['message']);
                                    if (next_prev) {
                                        //var url = "Studio_Details.aspx?studio_code=" + studio_code;
                                        var url = "Existing_Interested_Program.aspx?studio_code=" + studio_code;
                                        window.open(url, "_self");
                                    }
                                }
                                else if (res['status'] == "0") {
                                    alert(res['message']);
                                    //var url = "Clearance_Status.aspx";
                                    //window.open(url, '_self');
                                }
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }

            }

            //function saveChanges() {
            //    var interested_program_data = [];

            //    $("input[name='selected_program']:checked").each(function (index, obj) {
            //        var data = $("input[name='selected_program']:checked")[index].value;
            //        var arr_data = data.split('_');
            //        var interested_program_selected_data = {
            //            "dept_code": arr_data[0],
            //            "prog_code": arr_data[1],
            //            "prog_level_code": arr_data[2],
            //            "studio_level": arr_data[3]
            //        };

            //        interested_program_data.push(interested_program_selected_data);
            //    });

            //    if (interested_program_data.length == 0) {
            //        alert("Please Select Level/Program");
            //        return false;
            //    }

            //    next_prev = true;

            //    var json_submit_data = JSON.stringify(interested_program_data);

            //    if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            //    if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

            //    console.log(json_submit_data);

            //    $.ajax({
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/submit_interested_program",
            //        data: "{ interested_program_data: '" + json_submit_data + "' }",
            //        dataType: "json",
            //        async: false,
            //        success: function (data) {
            //            if (data.d != "") {
            //                res = JSON.parse(data.d)
            //                if (res['status'] == "1") {
            //                    alert(res['message']);
            //                }
            //                else if (res['status'] == "0") {
            //                    alert(res['message']);
            //                    var url = "Clearance_Status.aspx";
            //                    window.open(url, '_self');
            //                }
            //            }
            //        },
            //        error: function (result) {
            //            alert(result);
            //        }
            //    });
            //}


            $('#pdclick').click(function (e) {
                var url = "vf_edit_personal_detail.aspx?ie=" + $("#hdnuserid").val() + "&type=tutor";
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
                if (block) {
                    return false;
                }
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
                if (text_remaining > 150) {
                    $('#spn_desc').html('' + 'Total Words : ' + text_remaining);
                    $('#spn_desc').css('color', 'red');
                    //bootbox.alert('You Exceeds the Character Limit');
                } else {
                    $('#spn_desc').html('' + 'Total Words : ' + text_remaining);
                    $('#spn_desc').css('color', 'black');
                }

            });
        });
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row" style="margin-top: 11px; width: 64.3%; border: 0px solid rgba(113, 112, 112, 1); background-color: rgba(255, 255, 255, 1); border-radius: 0; box-shadow: 0 1px 4px rgba(0, 0, 0, 0.6); margin-left: 1px; display: block;" id="for_I2">
        <h5 class="font_8" style="margin-left: 5px; font-size: 18px; margin-top: 3px;">Call for Studio Tutor
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue;"><a href="Studio_Proposal_dtl.aspx">View Submitted Proposal</a></span>
            <%--<span style="font-size: 10pt; float: right; margin-right: 0.8%; text-shadow: 0 0 slateblue;">|</span>
            <span style="font-size: 10pt; float: right; margin-right: 1.2%; text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a></span>--%>
        </h5>
        <div style="margin-left: 1%; border-top: 1px solid #c2c2c2ab; width: 97.8%;"></div>
        <ol class="show-grid col-md-8 col-md-offset-2" style="margin-left: -8px; width: 100%; margin-bottom: 10px; margin-top: 5px;">
            <%--<span style="font-size: 10pt; text-shadow: 0 0 slateblue;"><a href="Interested_Program.aspx">New Proposal</a>: If you are proposing a new studio, <a href="Interested_Program.aspx">click here</a> to submt your proposal.</span></br></br>
            <span style="font-size: 10pt; text-shadow: 0 0 slateblue;"><a href="Existing_Interested_Program.aspx">Existing Studio Brief</a>:If you are proposing an existing CAC approved studio unit from the previous semesters, <a href="Existing_Interested_Program.aspx">click here</a> to retrieve/add/edit and submit the brief with no change/ minor change (changing site location or order of exercises. .</span></br></br>--%>
            <li class="col-md-3 active" id="pd" style="width: 27.5% !important;"><%-- If you are proposing to run and existig studio unit that you have already offered in a previous semester, <a href="Existing_Interested_Program.aspx">click here</a> to submit the detailed studio brief --%>
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
                        <a href="Existing_Interested_Program.aspx" id="lp_disabled" style="color: black;">Studio Details</a>

                    </div>
                </div>
            </li>
            <li class="col-md-3 active" id="sd" style="width: 28% !important; display: block;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 3:</strong></h5>
                        <a href="" id="sp_disabled" style="color: black;">Studio Brief</a>

                    </div>
                </div>
            </li>
            <%--<li class="col-md-3 active" id="bank_tutor" style="width: 18% !important;">
                <div class="media">
                    <div class="pull-left" href="#">
                        <span class="glyphicon glyphicon-dashboard"></span>
                    </div>
                    <div class="media-body">
                        <h5 class="media-heading"><strong>Step 4:</strong></h5>
                        <p id="bdclick" style="color: black;">Bank Details</p>
                    </div>
                </div>
            </li>--%>
        </ol>
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

    <div class="panel panel-default" style="margin-top: 1%; padding: 0px 0px 0px 0px;">

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
                            <td>Select the Program for which you have
                                <br />
                                proposed the studio <span style="color: red;">*</span></td>
                            <td>
                                <select id="program_level_code">
                                </select></td>
                        </tr>
                        <tr>
                            <td class="pad-top">Select the Level <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
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
                            <td class="pad-top">No of Tutor <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                            </td>
                            <td>
                                <select id="no_of_tutor">
                                    <option value="">-- Please Select Tutor --</option>
                                    <option value="Single">Single</option>
                                    <option value="Dual">Dual</option>
                                </select>
                            </td>
                            <td class="pad-top">Mode of Teaching <span class="cls_mendatory" style="display: inline-block; color: red;">*</span>
                            </td>
                            <td>
                                <select id="teaching_mode">
                                    <option value="">-- Please Select Mode --</option>
                                    <%--     <option value="Online">Online</option>
                                    <option value="Partial On-Campus">Partial On-Campus</option> --%>
                                    <option value="Full On-Campus">Full On-Campus</option>
                                    <option value="Blended">Blended</option>
                                </select>
                            </td>
                        </tr>
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
                                <select id="drpyear">
                                </select>
                            </td>
                        </tr>
                        <tr>
                           <td>Studio Introducation <span style="color:blue;">(MAX 150 Words)</span><span class="cls_mendatory" style="display: inline-block; color: red;">*</span></td>
                           <td colspan="3">
                           <textarea id="txt_studio_dtl" style="width: 92%; margin-bottom: 0px;" rows="4" cols="30" name="studio_dtl"></textarea>
                               <span id="spn_desc" style="float: right; margin-bottom: 10px;">Total Words: 0</span>
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
                                <td align="" style="width: 20%;" id="sub_but">
                                    <button id="btn_save" type="button" style="display: block; float: center;" class="btn btn-primary"><i class="icon-save bigger-160"></i>Submit</button>

                                </td>
                                <td align="center" style="width: 79%; display: block; visibility:collapse;">
                                    <button id="btn_next" type="button" style="margin-left: -143%;" class="btn btn-primary">Submit</button>
                                    <%--<input type="button" id="btn_next" value="Step 3 >>" class="btn btn-primary" style="margin-left: 10px; width: 88px;" />--%>
                                </td>
                                <%--<td align="" style="width: 20%;" id="dis_but">
                                    <button id="btn_submitted" type="button" style="margin-left: -183%;background-color: #f81616 !important;border-color: black !important;height: 43px;border: 1px solid;display:none;" class="btn btn-primary" disabled="disabled">Submitted</button>
                                 
                                </td>--%>
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


    <script type="text/javascript">

    </script>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_tutor_type" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_studio_code" value="" />
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_studio_code_paremeter" value="" />
</asp:Content>

