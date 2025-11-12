<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="GradeTranscriptDetail.aspx.cs" Inherits="Admin_Master_GradeTranscriptDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .table td {
            border-top: none;
            padding-left: 15px;
            padding-bottom: 0;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Manage Transcript Detail
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>Student Code
                        </td>
                        <td>
                            <select class="chosen-select" id="drpStudents">
                            </select>
                        </td>
                        <td>
                            <button class="btn btn-primary" type="button" id="btnretrieve">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>



                <div id="div_stud_personal_dtl" style="display: block;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Student Personal Detail</strong>
                </div>

                <div>
                    <table cellpadding="0" cellspacing="0" border="0" id="examplepersonal" class="display table" width="100%">
                        <tr>
                            <td>Student Code</td>
                            <td id="td_studentcode"></td>

                            <td>Student Name</td>
                            <td id="td_studentname"></td>

                        </tr>

                        <tr>
                            <td>Mail ID</td>
                            <td id="td_mailid"></td>

                            <td>Program Name</td>
                            <td id="td_program"></td>
                        </tr>

                        <tr>
                            <td>DepartMent Name</td>
                            <td id="td_departmentname"></td>
                            <td>Degree Name</td>
                            <td id="td_degreename"></td>
                        </tr>

                        <tr>
                            <td>Date Of Birth</td>
                            <td id="td_dob"></td>

                            <td>Grade Year</td>
                            <td id="td_gradeyear"></td>
                        </tr>

                        <tr>
                            <td>Admission Year</td>
                            <td id="td_admissionyear"></td>
                            
                            
                        </tr>

                        <tr>
                            <td>University Register Id</td>
                            <td id="td_universityregisterid"></td>
                            
                            <td>Student Apaar Id</td>
                            <td id="td_studentapaarid"></td>
                            
                        </tr>

                    </table>
                </div>
            </div>
        </div>





        <div id="div_stud_dtl" style="display: none;">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <strong>Student Transcript Detail</strong>
                </div>

                <div>
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table" width="100%">
                        <tr>
                            <td>Student Code</td>
                            <td id="td_student_code"></td>

                            <td>Graduation Month & Year</td>
                            <td>
                                <%--<input type="text" id="txt_graduation_year" /></td>--%>
                                <select class="chosen-select" id="txt_graduation_year"></select></td>

                        </tr>

                        <tr>
                            <td>Convocation Year</td>
                            <td>
                                <select class="chosen-select" id="convocation_year"></select></td>

                            <td>Date of Completion</td>
                            <td>
                                <select class="chosen-select" id="completion_date_code">
                                    <option value="">-- No Data Found -- </option>
                                </select></td>
                        </tr>

                        <tr>
                            <td>Name Of the Degree</td>
                            <%--<td><input type="text" id="txt_name_of_the_degree" /></td>--%>

                            <td>
                                <select class="chosen-select" id="txt_name_of_the_degree"></select></td>

                            <td>Previous Degree</td>
                            <td>
                                <input type="text" id="txt_previous_degree" /></td>
                        </tr>

                        <tr>
                            <td>Topic Type</td>
                            <td>
                                <%--<input type="text" id="txt_topic_type" />--%>
                                 <select class="chosen-select" id="txt_topic_type"></select>
                            </td>

                            <td>Dissertation Topic</td>
                            <td>
                               <%-- <input type="text" id="txt_dissertation_topic" />--%>
                                <textarea id="txt_dissertation_topic" style="width: 70%; margin-bottom: 0px;" rows="3" cols="2" name="topic" spellcheck="false" disabled></textarea>

                            </td>
                            
                        </tr>

                        <tr>
                            <td>Dissertation Supervisor</td>
                            <td>
                                <input type="text" id="txt_dissertation_supervisor" /></td>

                            <td>Specialization</td>
                            <td>
                                <input type="text" id="txt_specialization" /></td>
                        </tr>

                        <tr style="display:none;">
                            <td>Major</td>
                            <td>
                                <input type="text" id="txt_major" /></td>

                            <td>Minor</td>
                            <td>
                                <input type="text" id="txt_minor" /></td>
                        </tr>

                        <tr>
                            <td>Transcript No</td>
                            <td>
                                <input type="text" id="txt_transcript_no" /></td>

                            <td></td>
                            <td></td>
                        </tr>

                        <tr>
                            <td>Drp Topic Title</td>
                            <td colspan="3">
                                <p id="drptopic"></p>

                            </td>
                        </tr>

                    </table>
                </div>
            </div>

            <div style="text-align: center;">
                <button class="btn btn-primary" type="button" id="btn_save">Save</button>
            </div>
        </div>




        <asp:HiddenField ID="hdn_utype" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_sem" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_year" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_uid" runat="server" ClientIDMode="Static" />
        <asp:HiddenField ID="hdn_drptopic" runat="server" ClientIDMode="Static" />

    </div>

    <script type="text/javascript">
        var deg_code = '';
        var bind_topic_code = '';
        $(document).ready(function () {
            // bindStudentCode();
           
            bindConvocationYear();
            bindDegreeName();
           // bindtopicdata();
            // $('#btnretrieve').on('click', function () {
            deg_code = '';
            bindConvocationYear();
            getStudentPersonalDetail();
            getStudentTranscriptDetail();
            bindDegreeName();
            bindtopicdata();
            

            if (bind_topic_code != '') {
                $('#txt_topic_type').val(bind_topic_code);
                $('#txt_topic_type').trigger("liszt:updated");
            }

            if (deg_code != '') {
                $('#txt_name_of_the_degree').val(deg_code);
                $('#txt_name_of_the_degree').trigger("liszt:updated");
            }
            //});

            $('#btn_save').on('click', function () {
                saveStudentTranscriptDetail();
            });
           
            function bindDegreeName() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_Student_degree_dtl",
                    async: false,
                    data: "{user_id:'" + user_id + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var res = JSON.parse(data.d);

                            if (res['status'] == 'True') {
                                var lst_degree_name = res['message'];
                                $('#txt_name_of_the_degree').empty().append($("<option></option>").val("").html("-- Please Degree Name --"));
                                for (var i = 0; i < lst_degree_name.length; i++) {
                                    $('#txt_name_of_the_degree').append($("<option></option>").val(lst_degree_name[i]['degree_code']).html(lst_degree_name[i]['degree_name']));
                                }
                                $('#txt_name_of_the_degree').chosen();
                                $('#txt_name_of_the_degree').trigger("liszt:updated");
                            }
                            else if (res['status'] == 'False') {
                            }


                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }


            //$('#txt_graduation_year').on('change', function ()
            //{
            //    if ($('#txt_graduation_year').val() != '')
            //    {
            //        bindGraduationDate();
            //    }
            //});

        });

        function bindtopicdata() {
      
            //$('#txt_topic_type').empty().append($("<option></option>").val("").html("-- Please Select Topic --"));
            
            if ($('#td_program').text() != "UG" && $('#td_program').text() != "PG")
            {
                $('#txt_topic_type').append($("<option></option>").val("Thesis").html("Thesis"));
            }
            else
            {
                $('#txt_topic_type').append($("<option></option>").val("Directed Research Project").html("Directed Research Project"));
            }
            

            $('#txt_topic_type').chosen();

        }

        function bindConvocationYear() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetConvocationYear",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        var res = JSON.parse(data.d);
                        if (res['status'] == 'True') {
                            var lst_con_year = res['message'];
                            var str_html = "<option value=''> -- Select Convocation Year -- </option>";
                            for (var i = 0; i < lst_con_year.length; i++) {
                                str_html += "<option value='" + lst_con_year[i]['convocation_year'] + "'>" + lst_con_year[i]['convocation_year'] + "</option>";
                            }
                            $('#convocation_year').html(str_html);
                            //$('#convocation_year').chosen();
                            //$('#convocation_year').trigger("liszt:updated");
                        }
                        else if (res['status'] == 'False') {
                            //bootbox.alert(res['message']);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }

        function bindGraduationDate() {
            //$.ajax(
            //    {
            //        type: "POST",
            //        contentType: "application/json; charset=utf-8",
            //        url: "../../WebService.asmx/GetGraduationDate",
            //        async: false,
            //        data: "{convocation_year :'" + $('#convocation_year').val()+"'}",
            //        dataType: "json",
            //        success: function (data) {
            //            var res = JSON.parse(data.d);
            //            if (res['status'] == 'True')
            //            {
            //                var lst_con_year = res['message'];
            //                var str_html = "<option value=''> -- Select Graduation Date -- </option>";
            //                for (var i = 0; i < lst_con_year.length; i++) {
            //                    str_html += "<option value='" + lst_con_year[i]['graduate_date_code'] + "'>" + lst_con_year[i]['graduation_date'] + "</option>";
            //                }
            //                $('#txt_graduation_year').html(str_html);
            //            }
            //            else if (res['status'] == 'False') {
            //                //bootbox.alert(res['message']);
            //            }
            //        },
            //        error: function (result) {
            //            alert(result);
            //        }
            //    });
        }


        $('#convocation_year').on('change', function () {
            var con_year = $("#convocation_year").val();
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetCompletionDateByConvocationYear",
                    async: false,
                    data: "{ convocation_year : '" + con_year + "',user_id : '" + $('#hdn_uid').val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        var res = JSON.parse(data.d);
                        if (res['status'] == 'True') {
                            var lst_com_date = res['message'];
                            var str_html = "<option value=''> -- Select Completion Date -- </option>";
                            for (var i = 0; i < lst_com_date.length; i++) {
                                str_html += "<option value='" + lst_com_date[i]['completion_date_code'] + "'>" + lst_com_date[i]['completion_date'] + "</option>";
                            }
                            $('#completion_date_code').html(str_html);
                        }
                        else if (res['status'] == 'False') {
                            var str_html = "<option value=''> -- No Data Found -- </option>";
                            $('#completion_date_code').html(str_html);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            if ($('#convocation_year').val() != '') {


                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/GetGraduationDate",
                        async: false,
                        data: "{convocation_year :'" + $('#convocation_year').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            var res = JSON.parse(data.d); 
                            if (res['status'] == 'True') {
                                var lst_con_year = res['message'];
                                var str_html = "<option value=''> -- Select Graduation Date -- </option>";
                                for (var i = 0; i < lst_con_year.length; i++) {
                                    str_html += "<option value='" + lst_con_year[i]['graduate_date_code'] + "'>" + lst_con_year[i]['graduation_date'] + "</option>";
                                }
                                $('#txt_graduation_year').html(str_html);
                            }
                            else if (res['status'] == 'False') {
                                var str_html = "<option value=''> -- No Data Found -- </option>";
                                $('#txt_graduation_year').html(str_html);
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
            }
            else {
                var str_html = "<option value=''> -- No Data Found -- </option>";
                $('#txt_graduation_year').html(str_html);}
            //bindGraduationDate();
        });

        function bindStudentCode() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_students_for_manage_transcript",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        var res = JSON.parse(data.d);
                        if (res['status'] == 'True') {
                            var lst_students = res['message'];
                            var str_html = "<option value=''> -- Select Student Code -- </option>";

                            for (var i = 0; i < lst_students.length; i++) {
                                str_html += "<option value='" + lst_students[i]['user_id'] + "'>" + lst_students[i]['user_id'] + " - " + lst_students[i]['user_name'] + "</option>";
                            }

                            $('#drpStudents').html(str_html);
                            $('#drpStudents').chosen();
                            //$('#drpStudents').trigger("liszt:updated");
                        }
                        else if (res['status'] == 'False') {
                            bootbox.alert(res['message']);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }

        var user_id = '';
        function getStudentTranscriptDetail() {
            $('#div_stud_dtl').css('display', 'none');

            //user_id = $('#drpStudents').val();
            user_id = $('#hdn_uid').val();
            if (user_id == '') {
                bootbox.alert("Please Select Student");
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_Student_transcript_dtl",
                    async: false,
                    data: "{user_id:'" + user_id + "'}",
                    dataType: "json",
                    success: function (data) {
                        var res = JSON.parse(data.d);
                        if (res['status'] == 'True') {
                            if (res['message'].length > 0) {
                                var transcript_dtl = res['message'][0];
                                $('#div_stud_dtl').css('display', 'block');

                                $('#td_student_code').html(user_id);
                               // $('#txt_graduation_year').val(transcript_dtl['graduation_year']);
                                // $('#txt_name_of_the_degree').val(transcript_dtl['name_of_the_degree']);


                                $('#txt_previous_degree').val(transcript_dtl['previous_degree']);

                             
                                if (transcript_dtl['dissertation_topic'] == '') {
                                    $('#txt_dissertation_topic').val(transcript_dtl['dissertation_topic']);
                                }
                                else {
                                    $('#txt_dissertation_topic').val($('#hdn_drptopic').val());
                                }
                                //
                                
                                if (transcript_dtl['dissertation_supervisor'] == "") {
                                    $('#txt_dissertation_supervisor').val(transcript_dtl['name']);
                                }
                                else { $('#txt_dissertation_supervisor').val(transcript_dtl['dissertation_supervisor']);}


                                $('#txt_specialization').val(transcript_dtl['specialization']);
                                $('#txt_major').val(transcript_dtl['major']);
                                $('#txt_minor').val(transcript_dtl['minor']);
                                $('#txt_transcript_no').val(transcript_dtl['transcript_no']);
                                $('#convocation_year').val(transcript_dtl['convocation_year']);
                                $('#convocation_year').change();
                                deg_code = transcript_dtl['degree_code'];
                                $('#txt_name_of_the_degree').val(transcript_dtl['degree_code']);
                                //$('#txt_name_of_the_degree').change();
                                $('#txt_name_of_the_degree').trigger("liszt:updated");
                                //29122021
                                $('#txt_graduation_year').val(transcript_dtl['graduation_date_code']);
                                $('#txt_graduation_year').trigger("liszt:updated");

                                bind_topic_code = transcript_dtl['topic_type_code'];
                                $('#txt_topic_type').val(transcript_dtl['topic_type_code']);
                               
                                $('#txt_topic_type').trigger("liszt:updated");
                                

                                $('#completion_date_code').val(transcript_dtl['completion_date_code']);
                            }
                        }
                        else if (res['status'] == 'False') {
                            //bootbox.alert(res['message']);
                            $('#div_stud_dtl').css('display', 'block');

                            $('#td_student_code').html(user_id);
                            $('#txt_graduation_year').val('');
                            $('#txt_name_of_the_degree').val('');
                            $('#txt_previous_degree').val('');
                            $('#txt_topic_type').val('');
                           // $('#txt_dissertation_topic').val('');
                            //$('#txt_dissertation_supervisor').val('');
                            $('#txt_specialization').val('');
                            $('#txt_major').val('');
                            $('#txt_minor').val('');
                            $('#txt_transcript_no').val('');
                            $('#convocation_year').val('');
                            $('#convocation_year').change();
                            $('#txt_name_of_the_degree').val('');
                            $('#txt_name_of_the_degree').change();
                            $('#txt_name_of_the_degree').trigger("liszt:updated");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }

        function saveStudentTranscriptDetail() {

            if (user_id == '') {
                bootbox.alert("Please Select Student");
                return false;
            }

            if ($("#convocation_year").val() != '' && $("#completion_date_code").val() == '') {
                bootbox.alert("Please Select Date of Completion");
                return false;
            }

            var obj_transcript_dtl = { 'user_id': user_id, 'graduation_year': '', 'name_of_the_degree': '', 'previous_degree': '', 'topic_type': '', 'dissertation_topic': '', 'dissertation_supervisor': '', 'specialization': '', 'degree_code': '' };

            obj_transcript_dtl.graduation_year = $('#txt_graduation_year').val();
            //obj_transcript_dtl.name_of_the_degree = $('#txt_name_of_the_degree').val();

            if ($("#txt_name_of_the_degree").val() != '' && $("#txt_name_of_the_degree").val() != '') {
                obj_transcript_dtl.degree_code = $('#txt_name_of_the_degree').val();
            } else {
                obj_transcript_dtl.degree_code = null;
            }

            if ($("#txt_name_of_the_degree").val() != '' && $("#txt_name_of_the_degree").val() != '') {
                obj_transcript_dtl.name_of_the_degree = $("#txt_name_of_the_degree option:selected").text();
            } else {
                obj_transcript_dtl.name_of_the_degree = null;
            }
            //degree_code
            obj_transcript_dtl.previous_degree = $('#txt_previous_degree').val();
            obj_transcript_dtl.topic_type = $('#txt_topic_type').val();
            obj_transcript_dtl.dissertation_topic = $('#txt_dissertation_topic').val();
            obj_transcript_dtl.dissertation_supervisor = $('#txt_dissertation_supervisor').val();
            obj_transcript_dtl.specialization = $('#txt_specialization').val();
            obj_transcript_dtl.major = $('#txt_major').val();
            obj_transcript_dtl.minor = $('#txt_minor').val();
            obj_transcript_dtl.transcript_no = $('#txt_transcript_no').val();

            if ($("#convocation_year").val() != '' && $("#completion_date_code").val() != '') {
                obj_transcript_dtl.completion_date_code = $('#completion_date_code').val();
            } else {
                obj_transcript_dtl.completion_date_code = null;
            }

            var jsonString = JSON.stringify({ transcript_dtl: JSON.stringify(obj_transcript_dtl)});

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_Student_transcript_dtl",
                    async: false,
                   // data: "{transcript_dtl:'" + JSON.stringify(obj_transcript_dtl) + "'}",
                    data: jsonString,
                    dataType: "json",
                    success: function (data) {
                        var res = JSON.parse(data.d);
                        if (res['status'] == 'True') {
                            bootbox.alert(res['message']);
                        }
                        else if (res['status'] == 'False') {
                            bootbox.alert(res['message']);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }


        function getStudentPersonalDetail()
        {
            user_id = $('#hdn_uid').val();
            if (user_id == '') {
                bootbox.alert("Please Select Student");
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetStudentDetailsPersonal",
                    async: false,
                    data: "{user_id:'" + user_id + "'}",
                    dataType: "json",
                    success: function (data) {
                        var res = JSON.parse(data.d);
                        if (res['status'] == 'True') {
                            if (res['message'].length > 0) {
                                var transcript_dtl = res['message'][0];
                                $('#td_studentcode').html('<b>' + user_id + '</b>');
                                $('#td_studentname').html('<b>' + transcript_dtl['user_name'] + '</b>');
                                $('#td_mailid').html('<b>' + transcript_dtl['mail'] + '</b>');
                                $('#td_program').html('<b>' + transcript_dtl['prog_name'] + '</b>');
                                $('#td_departmentname').html('<b>' + transcript_dtl['dept_name'] + '</b>');
                                $('#td_degreename').html('<b>' + transcript_dtl['prog_level_name'] + '</b>');
                                $('#td_dob').html('<b>' + transcript_dtl['DOB'] + '</b>');
                                $('#td_gradeyear').html('<b>' + transcript_dtl['year_code'] + '</b>');
                                $('#td_admissionyear').html('<b>' + transcript_dtl['admission_year'] + '</b>');
                                $('#drptopic').html('<b>' + transcript_dtl['topic'] + '</b>');
                                $('#txt_dissertation_topic').val(transcript_dtl['topic']);
                                $('#txt_dissertation_supervisor').val(transcript_dtl['instname']);
                                $('#hdn_drptopic').val(transcript_dtl['topic']);
                                $('#td_studentapaarid').html('<b>' + transcript_dtl['apaar_id'] + '</b>');
                                $('#td_universityregisterid').html('<b>' + transcript_dtl['university_register_id'] + '</b>');
                                
                            }
                        }
                        
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }
    </script>

</asp:Content>

