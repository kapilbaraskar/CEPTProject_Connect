<%@ Page Title="DRP Request Form" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="DRP_Request_form.aspx.cs" Inherits="Admin_Master_DRP_Request_form" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Scripts/AjaxFileupload.js?t=28062019"></script>    


    <script type="text/javascript">
        var cur_sem_code;
        var cur_year_code;
        var oTable2;
        var FileNameBrief;

        $(document).ready(function () {
            var action;
            bindsemdata();
            bindyeardata_for_cross_reg();
            GetGuideName();

            $('#student_code').val($("#hdn_inst_code").val());
            if ($('#hdn_drp').val() != '' && $('#hdn_course').val() != '' && $('#hdn_year').val() != '' && $('#hdn_sem').val() != '') {
                $('#upload_drp_file').attr('disabled', true);
                $('#btn_download_prev1').attr('disabled', true);
                $('#drp_details_div').css('display', 'none');
                $('#btnsubmit').css('display', 'none');
                $('#btnupdate').css('display', 'block');
                $('#guid_2').css('display', 'block');
                
                retrive_data();
            }
            else
            {
                $('#guid_2').css('display', 'none');
            }
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
                    if ($("#drpsemester").val() == "") {
                        flag = false;
                        alert("Please Select Semester");
                        return false;
                    }
                    if ($("#drpyear").val() == "") {
                        flag = false;
                        alert("Please Select Year");
                        return false;
                    }
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
                    //if ($("#drstudent").val() == "") {
                    //    flag = false;
                    //    alert("Please Select Student");
                    //    return false;
                    //}

                    if ($("#topic").val() == "") {
                        flag = false;
                        alert("Please Enter DRP Title");
                        return false;
                    }

                    if ($("#lbl_brief_file_name").text() == "") {
                        flag = false;
                        alert("Please Upload DRP Brief Details");
                        return false;
                    }
                    //Seats
                    if ($("#vacant_seats").val() == "") {
                        flag = false;
                        alert("Please Enter DRP Intake/Seats/Students");
                        return false;
                    }
                    if ($("#funded_seats").val() == "") {
                        flag = false;
                        alert("Please Enter DRP Funded Seats");
                        return false;
                    }
                    if ($("#unfunded_seats").val() == "") {
                        flag = false;
                        alert("Please Enter DRP DRP Un-Funded Seats");
                        return false;
                    }
                    //Seats
                    if ($("#abstract").val() == "") {
                        flag = false;
                        alert("Please Enter Abstract");
                        return false;
                    }

                }

                if ($("#topic").val().length > 150) {
                    flag = false;
                    alert("Maximum 150 chars allow for DRP Title.");
                    return false;
                }

                if ($("#noofwords").val() > 300) {
                    flag = false;
                    alert("Maximum 300 words allow for Abstract.");
                    return false;
                }

                if (parseInt($("#vacant_seats").val()) != parseInt($("#funded_seats").val()) + parseInt($("#unfunded_seats").val())) {
                    flag = false;
                    alert("Funded + Un-Funded Seats does not match with the Vacant Seats.");
                    return false;
                }

                if (flag) {

                    var thesis_data = {
                        'instructor_code': '', 'vacant_seats': '', 'funded_seats': '', 'unfunded_seats': '', 'type': '', 'topic': '', 'abstract': '', 'references': '', 'is_submit': '', 'sem_code': '', 'year_code': '', 'course_code': '', 'doc_path': ''
                    };

                    thesis_data.course_code = $('#drcourses').val();
                    thesis_data.instructor_code = $("#instructor_code").val();
                    //thesis_data.student_code = $("#drstudent").val();
                    thesis_data.type = $("input[name='type']:checked").val();
                    thesis_data.topic = $("#topic").val();
                    thesis_data.vacant_seats = $("#vacant_seats").val();
                    thesis_data.funded_seats = $("#funded_seats").val();
                    thesis_data.unfunded_seats = $("#unfunded_seats").val();
                    thesis_data.abstract = $("#abstract").val();
                    thesis_data.reference = $("#reference").val();
                    thesis_data.sem_code = $("#drpsemester").val();
                    thesis_data.year_code = $("#drpyear").val();
                    thesis_data.doc_path = $("#lbl_brief_file_name").text();

                    //if (action == "A") {
                    //    thesis_data.is_submit = "Y";
                    //} else {
                    //    thesis_data.is_submit = "N";
                    //}

                    if (thesis_data.abstract.search(/\\/) != -1) {
                        thesis_data.abstract = thesis_data.abstract.replace(/\\/g, '\\\\');
                    }
                    if (thesis_data.abstract.search("\"") != -1) {
                        thesis_data.abstract = thesis_data.abstract.replace(/"/g, '\\\"');
                    }

                    if (thesis_data.references.search(/\\/) != -1) {
                        thesis_data.references = thesis_data.references.replace(/\\/g, '\\\\');
                    }
                    if (thesis_data.references.search("\"") != -1) {
                        thesis_data.references = thesis_data.references.replace(/"/g, '\\\"');
                    }

                    thesis_data = JSON.stringify(thesis_data);

                    if (thesis_data.search("'") != -1) {
                        thesis_data = thesis_data.replace(/\'/g, '\\\'');
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/save_course_wise_drp_data",//save_thesis_drp_data
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

            $('#drpsemester').on('change', function () {
                if ($('#drpsemester').val() != '') {

                    if ($('#drpyear').val() != '') {
                        bind_sem_course();
                        //GetStudent();
                    }

                }
            });

            $('#drpyear').on('change', function () {
                if ($('#drpyear').val() != '') {

                    if ($('#drpsemester').val() != '') {
                        bind_sem_course();
                        //GetStudent();
                    }

                }
            });

            $("#btn_download_prev1").click(function () {
                var href = $('.downloadLink').attr('href');
                window.location.href = href;
            });

            setCurrentSemester();

            $("input[name='type'][value='29']").prop('checked', true);
            $('#drcourses').empty().append($("<option></option>").val("").html("-- No Data Found --"));
            $('#drstudent').empty().append($("<option></option>").val("").html("-- No Data Found --"));

            $('#btnupdate').on('click', function () {
                var flag = true;
               
                   if ($('#hdn_sem').val() == "") {
                        flag = false;
                        alert("Please Enter Semester");
                        return false;
                    }
                    if ($('#hdn_year').val() == "") {
                        flag = false;
                        alert("Please Enter Year");
                        return false;
                    }
                    if ($('#hdn_course').val() == "") {
                        flag = false;
                        alert("Please Enter Course");
                        return false;
                    }
                    if ($("#instructor_code").val() == "") {
                        flag = false;
                        alert("Please Select Guide");
                        return false;
                    }
                if ($('#hdn_drp').val() == "") {
                       flag = false;
                       alert("Please Enter DRP CODE");
                       return false;
                   }

                    if ($("#topic").val() == "") {
                        flag = false;
                        alert("Please Enter DRP Title");
                        return false;
                    }

                    if ($("#lbl_brief_file_name").text() == "") {
                        flag = false;
                        alert("Please Upload DRP Brief Details");
                        return false;
                    }
                    //Seats
                    if ($("#vacant_seats").val() == "") {
                        flag = false;
                        alert("Please Enter DRP Intake/Seats/Students");
                        return false;
                    }
                    if ($("#funded_seats").val() == "") {
                        flag = false;
                        alert("Please Enter DRP Funded Seats");
                        return false;
                    }
                    if ($("#unfunded_seats").val() == "") {
                        flag = false;
                        alert("Please Enter DRP DRP Un-Funded Seats");
                        return false;
                    }
                    //Seats
                    if ($("#abstract").val() == "") {
                        flag = false;
                        alert("Please Enter Abstract");
                        return false;
                    }

               

                if ($("#topic").val().length > 150) {
                    flag = false;
                    alert("Maximum 150 chars allow for DRP Title.");
                    return false;
                }

                if ($("#noofwords").val() > 300) {
                    flag = false;
                    alert("Maximum 300 words allow for Abstract.");
                    return false;
                }

                if (parseInt($("#vacant_seats").val()) != parseInt($("#funded_seats").val()) + parseInt($("#unfunded_seats").val())) {
                    flag = false;
                    alert("Funded + Un-Funded Seats does not match with the Vacant Seats.");
                    return false;
                }

                if (flag) {

                    var thesis_data = {
                        'instructor_code': '', 'vacant_seats': '', 'funded_seats': '', 'unfunded_seats': '', 'type': '', 'topic': '', 'abstract': '', 'references': '', 'is_submit': '', 'sem_code': '', 'year_code': '', 'course_code': '', 'doc_path': '', 'drp_code': ''
                    };
                    
                    thesis_data.course_code = $('#hdn_course').val();
                    thesis_data.instructor_code = $("#instructor_code_1").val();
                    thesis_data.drp_code = $('#hdn_drp').val();
                    thesis_data.type = $("input[name='type']:checked").val();
                    thesis_data.topic = $("#topic").val();
                    thesis_data.vacant_seats = $("#vacant_seats").val();
                    thesis_data.funded_seats = $("#funded_seats").val();
                    thesis_data.unfunded_seats = $("#unfunded_seats").val();
                    thesis_data.abstract = $("#abstract").val();
                    thesis_data.reference = $("#reference").val();
                    thesis_data.sem_code = $('#hdn_sem').val();
                    thesis_data.year_code = $('#hdn_year').val();
                    thesis_data.doc_path = $("#lbl_brief_file_name").text();

                    //if (action == "A") {
                    //    thesis_data.is_submit = "Y";
                    //} else {
                    //    thesis_data.is_submit = "N";
                    //}

                    if (thesis_data.abstract.search(/\\/) != -1) {
                        thesis_data.abstract = thesis_data.abstract.replace(/\\/g, '\\\\');
                    }
                    if (thesis_data.abstract.search("\"") != -1) {
                        thesis_data.abstract = thesis_data.abstract.replace(/"/g, '\\\"');
                    }

                    if (thesis_data.references.search(/\\/) != -1) {
                        thesis_data.references = thesis_data.references.replace(/\\/g, '\\\\');
                    }
                    if (thesis_data.references.search("\"") != -1) {
                        thesis_data.references = thesis_data.references.replace(/"/g, '\\\"');
                    }

                    thesis_data = JSON.stringify(thesis_data);

                    if (thesis_data.search("'") != -1) {
                        thesis_data = thesis_data.replace(/\'/g, '\\\'');
                    }

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Update_course_wise_drp_data",//save_thesis_drp_data
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


        });

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
                        instructor += '<option value="">Please Select Guide</option>';
                        for (var i = 0; i < instructor_data.length; i++) {
                            instructor = instructor + "<option value ='" + instructor_data[i]["instructor_code"] + "'>" + instructor_data[i]["instructor_name"] + " </option>";
                        }
                        if ($('#hdn_drp').val() != '' && $('#hdn_course').val() != '' && $('#hdn_year').val() != '' && $('#hdn_sem').val() != '') {
                            $("#instructor_code_1").append(instructor);
                            $("#instructor_code_1").chosen();
                        }
                        else
                        {
                            $("#instructor_code").append(instructor);
                            $("#instructor_code").chosen();
                        }
                        
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function GetStudent() {
            var sem_code = $('#drpsemester').val();
            if (sem_code == '') {
                alert('Please Select Semester');
            }

            var year_code = $('#drpyear').val();
            if (year_code == '') {
                alert('Please Select Year');
            }

            //var course_code = $('#drcourses').val();
            //if (course_code == '') {
            //    alert('Please Select Course');
            //}

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_student_for_drp",
                async: false,
                data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var student_data = JSON.parse(data.d);
                        $('#drstudent').empty().append($("<option></option>").val("").html("-- Please Select Select --"));
                        for (var i = 0; i < student_data.length; i++) {
                            $('#drstudent').append($("<option></option>").val(student_data[i]["user_id"]).html(student_data[i]["user_id"]));
                        }
                        $("#drstudent").chosen();
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
                        $("#instructor_code").val(thesis_drp_saved_data[0]["instructor_code"]);
                        $("#drpsemester").val(thesis_drp_saved_data[0]["semester_type"]);
                        $("#drpyear").val(thesis_drp_saved_data[0]["year_semester"]);
                        $('#drpyear').trigger("liszt:updated");
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
                            $("#instructor_code").attr('disabled', true);
                            $("#topic").attr('disabled', true);
                            $("#abstract").attr('disabled', true);
                            $("#reference").attr('disabled', true);
                        } else {
                            $("input[type=radio]").attr('disabled', false);
                            $("#instructor_code").attr('disabled', false);
                            $("#topic").attr('disabled', false);
                            $("#abstract").attr('disabled', false);
                            $("#reference").attr('disabled', false);
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            $('#drpsemester').chosen();
        }

        function bindyeardata_for_cross_reg() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                data: "{}",
                async: false,
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

        function bind_sem_course() {
            var sem_code = $('#drpsemester').val();
            if (sem_code == '') {
                alert('Please select semester');
            }

            var year_code = $('#drpyear').val();
            if (year_code == '') {
                alert('Please select year');
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_all_course_data_For_Thesis_DRP",
                async: false,
                data: "{sem_code : '" + sem_code + "',year_code : '" + year_code + "',course_type : 'DRP'}",
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
                        $('#drcourses').find('option').remove().end().append('<option value="">-- No Data found --</option>').val('');
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

        function GetFileNameFromPath(strFilepath) {

            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return strName[0];
            }
        }

        function CheckMarksDocumentExtension(file) {
            try {

                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'xls':
                    case 'xlsx':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                //alert("Exception : " + e.message);
            }
        }

        function countNoOfWords() {
            $("#noofwords").val($("#abstract").val().split(' ').length);
        }

        function drp_dtl_upload() {

            var fileToUpload = GetFileNameFromPath($('#upload_drp_file').val());
            if (fileToUpload != null && fileToUpload != undefined) {
                if (CheckMarksDocumentExtension(fileToUpload)) {
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '../../Handler/Drp_Dtl_Upload.ashx',
                        data: { 'semester_type': $('#hdn_sem_code').val(), 'year_code': $('#hdn_year_code').val() },
                        fileElementId: 'upload_drp_file',
                        dataType: 'text',
                        success: function (data) {
                            if (data == "Problem in save data" || data == "Problem in save data, Please try again") {
                                bootbox.alert(data);
                            }
                            else if (data == "DRP Details Saved Successfully") {
                                bootbox.alert(data, function () {
                                    window.location.reload();
                                });
                            }
                            else if (data == "null") {
                                bootbox.alert("No data found in excel");
                            }
                            else if (data == "") {
                                bootbox.alert("Problem in save data.");
                            }
                            else {
                                var str_modal2 = "<div id='DataList2' style='display: none;'>" +
                                    " <table cellpadding='0' cellspacing='0' border='0' id='example2' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                    " <thead></thead><tbody></tbody></table></div>";
                                $('#div_errorList')[0].innerHTML = str_modal2;
                                display_drp_upload_error_data(JSON.parse(data));
                            }
                        }
                    });

                }
                else {
                    alert('Invalid File Type. Please upload .xls file');
                }
            }
            return false;
        }

        function display_drp_upload_error_data(data) {
            if (oTable2 != null) {
                oTable2.fnDestroy();
                $("#DataList2").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example2" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable2 = $("#example2").dataTable({
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
                "aaData": data,
                "aoColumns": [{ "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
                { "sTitle": "Column", "mData": "User_Id", "bSortable": false },
                { "sTitle": "Remark", "mData": "Remark", "bSortable": false }]
            });

            $('#DataList2').css('display', 'block');
            $('#btn_show_modal2').click();
        }

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type:'thesis'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#hdn_sem_code').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#hdn_year_code').val(cur_grade_sem[0]['year_code'].toString());

                            $('#Excel_Heading').html('Upload DRP Request ' + '(' + cur_grade_sem[0]['sem_desc'].toString().toUpperCase() + ' ' + cur_grade_sem[0]['year_code'].toString() + ')');
                            if ($('#hdn_course').val() != "") {
                                $('#Excel_Heading').html('UPDATE DRP DETAILS');
                            }
                            
                            $('#Excel_Heading').css('color', 'red');

                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function retrive_data() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_course_wise_drp_dtl",
                async: false,
                data: "{Course_Code :'" + $('#hdn_course').val() + "',semester : '" + $('#hdn_sem').val() + "',year : '" + $('#hdn_year').val() + "',drp_code :'" + $('#hdn_drp').val() + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var drp_data = JSON.parse(data.d);
                        //$('#drpyear').val(drp_data[0]['year_semester']);
                        //$('#drpyear').trigger("liszt:updated");
                        //$('#drpsemester').val(drp_data[0]['semester_type']);
                        //$('#drpsemester').trigger("liszt:updated");
                        debugger;
                        //bind_sem_course();
                        //$('#drcourses').val(drp_data[0]['course_code']);
                        //$('#drcourses').trigger("liszt:updated");

                        $('#instructor_code_1').val(drp_data[0]['instructor_code']);
                        $('#instructor_code_1').trigger("liszt:updated");
                        $('#topic').val(drp_data[0]['topic']);
                        $('#vacant_seats').val(drp_data[0]['vacant_seats']);
                        $('#funded_seats').val(drp_data[0]['funded_seats']);
                        $('#unfunded_seats').val(drp_data[0]['unfunded_seats']);
                        $('#abstract').text(drp_data[0]["abstracts"]);
                        $('#reference').val(drp_data[0]['reference']);
                        
                   //   var path_value = "../../DRPTopicBriefDocs/" + drp_data["doc_path"];
                     
                        //$('#lbl_brief_file_name').text("<a href='" + path_value + " download>" + drp_data["doc_path"] +" </a>");
                        $('#lbl_brief_file_name').text(drp_data[0]["doc_path"]);
                        
                
                    }

                },
                error: function (result) {
                    alert(result);
                }
              
            });
            
        }

    </script>
    <script  type="text/javascript">
        function GetFileNameFromPathDRPBrief(strFilepath) {

            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return strName[0];
            }
        }

        function CheckDrpBriefExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'pdf':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }

        function UploadDrpBrief() {

            var course_code = '';
            var sem_code = '';
            var year_code = '';
            if ($('#hdn_drp').val() != '' && $('#hdn_course').val() != '' && $('#hdn_year').val() != '' && $('#hdn_sem').val() != '')
            {
                if ($('#hdn_sem').val() == "") {
                    $('#drp_brief').val('');
                    alert("Please Select Semester");
                    return false;
                }
                if ($('#hdn_year').val() == "") {
                    $('#drp_brief').val('');
                    alert("Please Select Year");
                    return false;
                }
                if ($('#hdn_course').val() == "") {
                    $('#drp_brief').val('');
                    alert("Please Select Course");
                    return false;
                }
                course_code = $('#hdn_course').val();
                sem_code = $('#hdn_sem').val();
                year_code = $('#hdn_year').val();
            }
            else
            {
                if ($("#drpsemester").val() == "") {
                    $('#drp_brief').val('');
                    alert("Please Select Semester");
                    return false;
                }
                if ($("#drpyear").val() == "") {
                    $('#drp_brief').val('');
                    alert("Please Select Year");
                    return false;
                }
                if ($("#drcourses").val() == "") {
                    $('#drp_brief').val('');
                    alert("Please Select Course");
                    return false;
                }
                course_code = $("#drcourses").val();
                sem_code = $("#drpsemester").val();
                year_code = $("#drpyear").val();
            }

            

            try {
                var fileToUpload = GetFileNameFromPathDRPBrief($('#drp_brief').val());

                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckDrpBriefExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {
                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/Drp_Topic_Brief_Doc.ashx',
                                secureuri: false,
                                //data: { 'UploadType': 'drp_brief', 'Course_Code': $("#drpsemester").val() + '_' + $("#drpyear").val() + '_' + $("#drcourses").val() },
                                data: { 'UploadType': 'drp_brief', 'Course_Code': sem_code + '_' + year_code + '_' + course_code },
                                fileElementId: 'drp_brief',
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#drp_brief').val("");
                                            $('#lbl_brief_file_name').html('<b>' + data.upfile + '</b>');
                                            FileNameBrief = data.upfile;
                                            alert('DRP Brief Details Uploaded Successfully.');
                                        }
                                    }
                                    $("#UploadingProgress").fadeOut(200);
                                },
                                error: function (data, status, e) {
                                    $("#UploadingProgress").fadeOut(200);
                                    alert(e);
                                }
                            });
                        }
                    }
                }
                else {
                    $('#drp_brief').val('');
                    alert('Invalid File Type. Please upload .pdf format file.');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }

        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div id="div_fee_bank_dtl_upload1" class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong id="Excel_Heading"></strong>
            </div>
            <div class="panel-body">
                <%--<asp:FileUpload ID="fee_bank_dtl_upload1" runat="server" />onclick ="javascript: return drp_sem_dtl();"--%>
                <input id="upload_drp_file" type="file" name="upload_drp_file"
                                                onchange ="javascript:return drp_dtl_upload();" />
                <div style="position: absolute;left: 75%;margin-top: -4%;">
                    Download Excel Formate : <a href="../../ExcelFormatFiles/DRP_Request_Details.xlsx" class="downloadLink" style="display: none;"></a><input type="button" id="btn_download_prev1" class="uploadify-button" value="Download" style="width: 96px;height: 36px;" />
                </div>
            </div>
        </div>



    <div class="panel panel-default ">
        <div class="panel-heading">
            <strong><span class="panel-headingfont">DRP Request Form</span></strong>
        </div>
        <div style="padding: 10px; overflow: visible;" id="div_progcoord_panel" class="panel-collapse collapse in">
            <div id="drp_details_div">
                <table style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                    </tr>
                    <tr id="first_row">
                        <td class="pad-top" style="vertical-align: middle;">Name
                        </td>
                        <td>
                            <input type="text" id="student_code" class="form-control" name="Student Code" disabled="disabled">
                        </td>
                        <td class="pad-top" style="vertical-align: middle;">Semester <span class="cls_mendatory" style="color: Red;">*</span>
                        </td>
                        <td class ="sem">
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>

                        <td class="pad-top" style="vertical-align: middle;">Year <span class="cls_mendatory" style="color: Red;">*</span>
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                    </tr>
                    <tr id="second_row">
                        <td>Course <span class="cls_mendatory" style="color: Red;">*</span>
                        </td>
                        <td>
                            <select class="chosen-select" id="drcourses">
                            </select>
                        </td>
                        <td style="vertical-align: top;display:none;">Student <span class="cls_mendatory" style="color: Red;">*</span>
                        </td>
                        <td style="display:none;">
                            <select class="chosen-select" id="drstudent">
                            </select>
                        </td>
                        <td style="vertical-align: top; display: none;">Type<span class="cls_mendatory" style="display: none; color: Red;">*</span>
                        </td>
                        <td style="vertical-align: top; display: none;">
                            <input type="radio" value="25" name="type" />
                            Thesis
                                        <input type="radio" value="29" name="type" />
                            DRP
                        </td>
                        <td style="vertical-align: top;">Guide <span class="cls_mendatory" style="color: Red;">*</span>
                        </td>
                        <td>
                            <select id="instructor_code" class="form-control" name="Guide">
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="guid_2">
                    <table style="width: 100%;" cellpadding="10" cellspacing="20">
                   
                    <tr>
                        <td style="vertical-align: top;">Guide <span class="cls_mendatory" style="color: Red;">*</span>
                        </td>
                        <td>
                            <select id="instructor_code_1" class="form-control" name="Guide">
                            </select>
                        </td>
                    </tr>
                </table>
            </div>
            <div style="margin-left:1%;">
                DRP Title (Max 150 chars) <span class="cls_mendatory" style="color: Red;">*</span><br />
            </div>
            <div style="margin-left:1%;">
                <input type="text" id="topic" class="form-control" name="Thesis Topic" style="width:1000px !important;"/>
            </div>
             <div style="margin-left:1%;margin-top:10px;">
                <span>Upload DRP Brief Details (PDF Only)</span> <span class="cls_mendatory" style="color: Red;">*</span>
                <input type="file" name="drp_brief" id="drp_brief" onchange="javascript:return UploadDrpBrief();" " />
                 <span id="lbl_brief_file_name" style="vertical-align: super;"></span>
            </div>
            <div style="margin-left:1%;margin-top:10px;">
                <span>DRP Intake/Seats/Students</span> <span class="cls_mendatory" style="color: Red;">*</span>
                <input type="text" id="vacant_seats" class="form-control" name="Vacant Seats" style="width:50px !important;margin-top: 5px;"/>
                <span style="margin-left:10%;">DRP Funded Seats</span> <span class="cls_mendatory" style="color: Red;">*</span>
                <input type="text" id="funded_seats" class="form-control" name="Vacant Seats" style="width:50px !important;margin-top: 5px;"/>
                <span style="margin-left:15%;">DRP Un-Funded Seats</span> <span class="cls_mendatory" style="color: Red;">*</span>
                <input type="text" id="unfunded_seats" class="form-control" name="Vacant Seats" style="width:50px !important;margin-top: 5px;"/>
            </div>
            <div style="margin-left:1%;margin-top:10px;">
                Abstract (Max 300 words) <span class="cls_mendatory" style="color: Red;">*</span><br />
            </div>
            <div style="margin-left:1%;">
                <textarea rows="4" cols="1200" id="abstract" style="width: 1000px !important;" onkeyup="countNoOfWords()"></textarea>
                <input id="noofwords" type="text" value="" size="6" style="display:none;"/>
            </div>
            <div style="margin-left:1%;">
                References (If Any) 
            </div>
            <div style="margin-left:1%;">
                <textarea rows="4" cols="600" id="reference" style="width: 1000px !important;"></textarea>
            </div>
            <div class="row">
                <div class="col-md-5"></div>
                <div class="col-md-4" id="div_save_submit">
                    <button class="btn  btn-primary" type="button" id="btnsubmit">
                        Submit   
                    </button>
                    <button class="btn  btn-primary" type="button" id="savesubmit" style="display: none;">
                        Save Submit   
                    </button>
                     <button class="btn  btn-primary" type="button" id="btnupdate" style="display: none;">
                        Update DRP   
                    </button>
                </div>
            </div>
        </div>
    </div>


    </div>


    <div class="modal fade" id="mynewModal2" style="display:none;top:5%;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="H2">Excel Upload Error List</h4>
                    </div>

                    <div id="div_errorList" class="modal-body">
                        
                    </div>

                    <div class="modal-footer">
                        <button id="btn_modal_close2" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

    <input type="hidden" id="hdn_inst_code" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_sem_code" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_drp" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_sem" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_course" runat="server" clientidmode="Static" />

    <div>
            <input id="btn_show_modal2" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal2" value="Display" style="height: 40px;margin-top: -10px;display:none;"/>
        </div>
</asp:Content>

