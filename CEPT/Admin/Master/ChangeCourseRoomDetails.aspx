<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="ChangeCourseRoomDetails.aspx.cs" Inherits="Admin_Master_ChangeCourseRoomDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        var sem_code = '';
        var year_code = '';
        var course_code = '';

        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            setCurrentSemester();

            $('#drpsemester').on('change', function () {
                if ($('#drpsemester').val() != '' && $('#drpyear').val() != '') {
                    bind_sem_course();
                }
            });

            $('#drpyear').on('change', function () {
                if ($('#drpsemester').val() != '' && $('#drpyear').val() != '') {
                    bind_sem_course();
                }
            });

            $('#btnRetrieve').click(function () {
                sem_code = $('#drpsemester').val();
                if (sem_code == '') {
                    bootbox.alert('Please select semester');
                    return false;
                }

                year_code = $('#drpyear').val();
                if (year_code == '') {
                    bootbox.alert('Please select year');
                    return false;
                }

                course_code = $('#drcourses').val();
                if (course_code == '') {
                    bootbox.alert('Please select course');
                    return false;
                }

                var str_room;

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_all_room_details",
                    async: false,
                    data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var room_data = JSON.parse(data.d)
                            str_room = '<option value="">-- Please Select Room --</option>';
                            for (var i = 0; i < room_data.length; i++) {
                                str_room += '<option value="' + room_data[i]["room_id"] + '">' + room_data[i]["room_id"] + ' - ' + room_data[i]["name"] + '</option>';
                            }
                            str_room += '<option value="studio">Studio</option><option value="auditorium">Auditorium</option>';
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_room_details",
                    async: false,
                    data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_code:'" + course_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != null && data.d != "") {
                            $("#hidn").css("display", "");
                            $("#btnsave").css("display", "");

                            var course_data = JSON.parse(data.d);
                            $("#tbltimeday tbody").html('');
                            var str = "";
                            for (var i = 0; i < course_data.length; i++) {
                                str += "<tr>";
                                str += "<td class='doc_no'>" + course_data[i]["doc_no"] + "</td>";
                                str += "<td class='from_time'>" + course_data[i]["from_time"] + "</td>";
                                str += "<td class='to_time'>" + course_data[i]["To_time"] + "</td>";
                                str += "<td class='day'>" + course_data[i]["day_name"] + "</td>";
                                str += "<td><select class='marg-btm cls_roomid' style='width: 100%;'>" + str_room + "</select></td>";
                                str += "</tr>";
                            }
                            $('#tbltimeday tbody').append(str);

                            $("#tbltimeday tbody tr").each(function (j) {
                                for (var k = 0; k < course_data.length; k++) {
                                    if (j == k) {
                                        $(this).find(".cls_roomid").val(course_data[k]["room_id"]);
                                    }
                                }
                            });

                        } else {
                            $("#hidn").css("display", "none");
                            $("#btnsave").css("display", "none");
                            alert("No Data Found.")
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

            $('#btnsave').on('click', function () {

                if ($('#drcourses').val() == '') {
                    action = 'S';
                    bootbox.alert('Please Select Course');
                    return false;
                }

                var day_time_data_list = [];

                $("#tbltimeday tbody tr").each(function (j) {

                    var day_time_data = { 'doc_no': '', 'course_code': course_code, 'room_id': '', 'sem_code': sem_code, 'year_code': year_code, 'time_seq_no': '' };

                    day_time_data.doc_no = $(this).find(".doc_no").text();
                    day_time_data.time_seq_no = (j+1);
                    day_time_data.room_id = $(this).find(".cls_roomid").val();

                    day_time_data_list.push(day_time_data);

                });

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_course_room_data",
                    async: false,
                    data: "{ All_table_course_data: '" + JSON.stringify(day_time_data_list) + "' }",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == 'Data Saved Successfully') {
                            alert(data.d);
                            window.location.reload();
                        }
                        else{
                            alert(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });
        });

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
        }

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type : 'course'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            $('#drpsemester').trigger("change");
                        }
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
                        var year_data = JSON.parse(data.d);

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

        function bind_sem_course() {
            var sem_code = $('#drpsemester').val();
            if (sem_code == '') {
                bootbox.alert('Please select semester');
            }

            var year_code = $('#drpyear').val();
            if (year_code == '') {
                bootbox.alert('Please select year');
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_all_course_data_For_Modification",
                async: false,
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
                        $('#drcourses').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                        $('#drcourses').chosen();
                        $('#drcourses').val('').trigger("liszt:updated");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Change Course Room Details
            </h1>
        </div>
    </div>
    <div class="" style="background-color: White;">
        <div id="course_select" class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Course Selection</span></strong></div>
            <div style="padding: 15px;" id="div3">
                <div class="row">
                    <div id="div_drpsem" class="form-group col-md-4">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Semester :</div>
                        <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </div>
                    </div>
                    <div id="div_drpyear" class="form-group col-md-3">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Year :</div>
                        <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-8" style="padding: 0 0 0 0;">
                            <select class="chosen-select col-md-12" id="drpyear">
                            </select>
                        </div>
                    </div>
                    <div id="div_drpcourse" class="form-group col-md-3">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Course :</div>
                        <%--</div>
                    <div class="form-group col-md-2">--%>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drcourses">
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div style="margin-left: 41%;" class="form-group col-md-12">
                        <button class="btn  btn-primary" type="button" id="btnRetrieve">
                            <i class="icon-plus"></i>&nbsp; Retrieve
                        </button>
                    </div>
                </div>
            </div>
        </div>
       </div>
    <div class="panel panel-default" style="display:none;" id="hidn">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Course Room Details</span></strong>
            </div>
         <table class="data-table table table-bordered table-striped" border="0" id="tbltimeday" style="width:100%;">
                            <thead>
                                <tr>
                                    <th>Doc No</th>
                                    <th>From Time</th>
                                    <th>To Time</th>
                                    <th>Day</th>
                                    <th style="width: 50%;">Room Id</th>
                                </tr>
                                <tr>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
    </div>
    <div style="margin-left: 44%;margin-bottom:2%;" class="form-group col-md-12">
        <button id="btnsave" type="button" style="display: none" class="btn btn-lg btn-primary">Save</button>
    </div>
</asp:Content>

