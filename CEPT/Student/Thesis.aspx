<%@ Page Title="Thesis Request Form" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="Thesis.aspx.cs" Inherits="Student_Thesis" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        body {
            overflow-x: hidden;
        }
    </style>
    <script>
        $(document).ready(function () {
            var action;
            var sem_code = "";
            var year_code = "";
            setCurrentSemester();
            GetGuideName();
            bind_sem_course();
            GetFilledData();

            $('#student_code').val($("#hdn_stud_code").val());
            $('#btnsave').on('click', function () {
                action = 'S';
                $('#savesubmit').click();
            });
            $('#btnsubmit').on('click', function () {
                action = 'A';
                $('#savesubmit').click();
            });
            $('#savesubmit').on('click', function () {
                var flag = true;
                if (action == "A") {
                    if ($("#drcourses").val() == "") {
                        flag = false;
                        alert("Please Select Course");
                        return false;
                    }
                    if ($("#instructor_code").val() == "") {
                        flag = false;
                        alert("Please Select Guide");
                        return false;
                    }
                    if ($("#topic").val() == "") {
                        flag = false;
                        alert("Please Enter Thesis Title");
                        return false;
                    }
                    if ($("#abstract").val() == "") {
                        flag = false;
                        alert("Please Enter Abstract");
                        return false;
                    }
                    
                }

                if ($("#topic").val().length > 150) {
                    flag = false;
                    alert("Maximum 150 chars allow for Thesis Title.");
                    return false;
                }

                if ($("#noofwords").val() > 300) {
                    flag = false;
                    alert("Maximum 300 words allow for Abstract.");
                    return false;
                }

                if (flag) {
                    var thesis_data = { 'instructor_code': '', 'type': '', 'topic': '', 'abstract': '', 'references': '', 'is_submit': '', 'sem_code': '', 'year_code': '', 'course_code': '' };

                    thesis_data.instructor_code = $("#instructor_code").val();
                    thesis_data.course_code = $('#drcourses').val();
                    thesis_data.type = $("input[name='type']:checked").val();
                    thesis_data.topic = $("#topic").val();
                    thesis_data.abstract = $("#abstract").val();
                    thesis_data.references = $("#reference").val();
                    if (action == "A") {
                        thesis_data.is_submit = "Y";
                    } else {
                        thesis_data.is_submit = "N";
                    }

                    if (thesis_data.abstract.search(/\\/) != -1) { thesis_data.abstract = thesis_data.abstract.replace(/\\/g, '\\\\'); }
                    if (thesis_data.abstract.search("\"") != -1) { thesis_data.abstract = thesis_data.abstract.replace(/"/g, '\\\"'); }

                    if (thesis_data.references.search(/\\/) != -1) { thesis_data.references = thesis_data.references.replace(/\\/g, '\\\\'); }
                    if (thesis_data.references.search("\"") != -1) { thesis_data.references = thesis_data.references.replace(/"/g, '\\\"'); }

                    thesis_data = JSON.stringify(thesis_data);

                    if (thesis_data.search("'") != -1) {
                        thesis_data = thesis_data.replace(/\'/g, '\\\'');
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../WebService.asmx/save_thesis_drp_data",
                        data: "{thesis_drp_dataa:'" + thesis_data + "'}",
                        dataType: "json",
                        success: function (data) {
                            var dataa = JSON.parse(data.d);
                            if (dataa.status == "0") {
                                alert(dataa.message);
                                window.location.reload();
                            } else {
                                alert(dataa.message);
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }
            });
            $("input[name='type'][value='25']").prop('checked', true);
        });
        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_current_thesis_drp_semester",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_thesis_sem = JSON.parse(data.d);
                        if (cur_thesis_sem.length > 0) {
                            if (cur_thesis_sem[0]['sem_code'].toString() == "S") {
                                $('#semester_type').val("Spring");
                            } else {
                                $('#semester_type').val("Monsoon");
                            }
                            $('#year_semester').val(cur_thesis_sem[0]['year_code'].toString());
                             
                            sem_code = cur_thesis_sem[0]['sem_code'].toString();
                            year_code = cur_thesis_sem[0]['year_code'].toString();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function GetGuideName() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_instructor_for_thisis_drp",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var instructor_data = JSON.parse(data.d);
                        $("#instructor_code").html("");
                        var instructor = "";
                        instructor += '<option value="">-- Please Select Guide --</option>'
                        for (var i = 0; i < instructor_data.length; i++) {
                            instructor = instructor + "<option value =" + instructor_data[i]["instructor_code"] + ">" + instructor_data[i]["instructor_name"] + " </option>";
                        }
                        $("#instructor_code").append(instructor);
                        $("#instructor_code").chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function GetFilledData() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_student_data_of_thisis_drp",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var thesis_drp_saved_data = JSON.parse(data.d);
                        switch (thesis_drp_saved_data[0]["status"]) {
                            case "A":
                                thesis_drp_saved_data[0]["status"] = "Accepted";
                                break;
                            case "R":
                                thesis_drp_saved_data[0]["status"] = "Rejected";
                                break;
                            default:
                                thesis_drp_saved_data[0]["status"] = "Pending";
                                break;
                        }
                        $("#status").text(thesis_drp_saved_data[0]["status"]);
                        $("#instructor_code").val(thesis_drp_saved_data[0]["instructor_code"]);
                        $('#instructor_code').trigger("liszt:updated");
                        $("#drcourses").val(thesis_drp_saved_data[0]["course_code"]);
                        $('#drcourses').trigger("liszt:updated");
                        $("input[name='type'][value='" + thesis_drp_saved_data[0]["form_type"] + "']").prop('checked', true);
                        $("#topic").val(thesis_drp_saved_data[0]["topic"]);
                        $("#abstract").val(thesis_drp_saved_data[0]["thesis_abstract"]);
                        $("#reference").val(thesis_drp_saved_data[0]["thesis_references"]);
                        $("#noofwords").val($("#abstract").val().split(' ').length);
                        if (thesis_drp_saved_data[0]["is_submit"] == "Y") {
                            $("#div_save_submit").remove();
                            $("input[type=radio]").attr('disabled', true);
                            $("#instructor_code").prop('disabled', true).trigger("liszt:updated");
                            $('#drcourses').prop('disabled', true).trigger("liszt:updated");
                            $("#topic").attr('disabled', true);
                            $("#abstract").attr('disabled', true);
                            $("#reference").attr('disabled', true);
                        } else {
                            $("input[type=radio]").attr('disabled', false);
                            $("#instructor_code").prop('disabled', false).trigger("liszt:updated");
                            $('#drcourses').prop('disabled', false).trigger("liszt:updated");
                            $("#topic").attr('disabled', false);
                            $("#abstract").attr('disabled', false);
                            $("#reference").attr('disabled', false);
                        }
                    } else {
                        $("#status").text("Form Not Filled");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function bind_sem_course() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_all_course_data_For_Thesis_DRP",
                async: false,
                data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_type : 'Thesis'}",
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
                        $('#drcourses').find('option').remove().end().append('<option value="">No Data found</option>').val('');
                        $('#drcourses').chosen();
                        $('#drcourses').val('').trigger("liszt:updated");
                    }
                    //bind_other_sem_course();
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function countNoOfWords() {
        $("#noofwords").val($("#abstract").val().split(' ').length);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <main class="my-form">
        <div class="cotainer">
            <div class="row-fluid">
                <div class="page-header position-relative">
                    <h1>Student Thesis Request Form
                    </h1>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div class="form-group row">
                                    <label for="full_name" class="col-md-4 col-form-label text-md-right">Status</label>
                                    <div class="col-md-6">
                                        <p id="status"></p>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="full_name" class="col-md-4 col-form-label text-md-right">Student Code</label>
                                    <div class="col-md-6">
                                        <input type="text" id="student_code" class="form-control" name="Student Code" disabled="disabled">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="email_address" class="col-md-4 col-form-label text-md-right">Semester</label>
                                    <div class="col-md-6">
                                        <input type="text" id="semester_type" class="form-control" name="Semester" disabled="disabled">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="user_name" class="col-md-4 col-form-label text-md-right">Year</label>
                                    <div class="col-md-6">
                                        <input type="text" id="year_semester" class="form-control" name="Year" disabled="disabled">
                                    </div>
                                </div>
                                <div class="form-group row" style="">
                                    <label for="user_name" class="col-md-4 col-form-label text-md-right">Course <span class="cls_mendatory" style="color: Red;">*</span></label>
                                    <div class="col-md-6">
                                        <select class="chosen-select" id="drcourses">
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row" style="display: none;">
                                    <label for="phone_number" class="col-md-4 col-form-label text-md-right">Type</label>
                                    <div class="col-md-6">
                                        <input type="radio" value="25" name="type" />
                                        Thesis
                                        <input type="radio" value="29" name="type" />
                                        DRP
                                    </div>
                                </div>
                                <div class="form-group row" style="margin-top: 5px;">
                                    <label for="phone_number" class="col-md-4 col-form-label text-md-right"></label>
                                </div>
                                <div id="div_thesis" style="display: block;">
                                    <div class="form-group row">
                                        <label for="phone_number" class="col-md-4 col-form-label text-md-right">Guide <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <select id="instructor_code" class="form-control" name="Guide">
                                                <option value="">-- Please Select Guide --</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group row" style="margin-top: 10px;">
                                        <label for="phone_number" class="col-md-4 col-form-label text-md-right">Thesis Title (max 150 chars)<span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <input type="text" id="topic" class="form-control" name="Thesis Topic" style="width: 600px;height: 40px;">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="permanent_address" class="col-md-4 col-form-label text-md-right">Abstract (max 300 words) <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <textarea rows="3" cols="100" id="abstract" onkeyup="countNoOfWords()" style="width: 600px;height: 500px;"></textarea>
                                            <input id="noofwords" type="text" value="" size="6" style="display:none;"/>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="permanent_address" class="col-md-4 col-form-label text-md-right">References (If Any)</label>
                                        <div class="col-md-6">
                                            <textarea rows="2" cols="100" id="reference" style="width: 600px;height: 200px;"></textarea>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4"></div>
                                    <div class="col-md-4" id="div_save_submit">
                                        <button class="btn  btn-primary" type="button" id="btnsave">
                                            Save
                                        </button>
                                        <button class="btn  btn-primary" type="button" id="btnsubmit">
                                            Submit   
                                        </button>
                                        <button class="btn  btn-primary" type="button" id="savesubmit" style="display: none;">
                                            Save Submit   
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <input type="hidden" id="hdn_stud_code" runat="server" clientidmode="Static" />
</asp:Content>

