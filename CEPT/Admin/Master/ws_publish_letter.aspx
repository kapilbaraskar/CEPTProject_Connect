<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ws_publish_letter.aspx.cs" Inherits="Admin_Master_ws_publish_letter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript" src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/printcsv.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script type="text/javascript" src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        var ints_code = "";

        $(document).ready(function () {

            bindsemdata();
            bindyeardata_for_cross_reg();
            //get_fauser_detail();
            // bindprogramme();
            // bindproglevel();

            $('#btnreterive').on('click', function () {
                get_vf_rate_band_detail();
                return false;
            });
            $('#btngenerateletter').on('click', function () {
                letter_auto_download();
                return false;
            });

            setCurrentSemester();
        });

        function get_vf_rate_band_detail() {

            $('#DataList').css('display', 'none');
            $('#div_btn').html('');
         

         var   semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

           var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/ws_publish_letter_genrate",
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {

                            $('#hdn_All_instructor').val(data.d);

                           // workload_detail = JSON.parse(data.d);

                            display_get_vf_personal_detail(data.d);

                            $('#div_course_list').css('display', 'block');
                            //letter_auto_download();     04082021
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function display_get_vf_personal_detail(data)
        {
            var columns = [
                { "sTitle": "Instructor Code", "mData": "instructor_code" },

            {
                "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, mRender: function (data) {
                    //return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" checked />';
                    var pdfstatus = data.pdf_status;
                    if (parseInt($('#drpyear').val()) >= 2023) {

                        if (pdfstatus == 'N') {
                            if (data.uso_hr_approved == "Y") {
                                return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
                            }
                            else {
                                return '';
                            }

                        }
                        else if (pdfstatus == 'Y') {
                            if (data.uso_hr_approved == "Y") {
                                return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
                            }
                            else {
                                return '';
                            }

                        }
                    }
                    else
                    {
                        if (pdfstatus == 'N') {
                            return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
                        }
                        else if (pdfstatus == 'Y') {
                            return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
                        }
                        else {
                            return '';
                        }
                    }
                    //else if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.des_type == 'VF' && data.uso_hr_approved == 'Approved') {
                    //    return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" checked />';
                    //}
                    //else if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.uso_hr_approved == 'Approved') {
                    //    return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)" checked />';
                    //}
                    
                }
            },

            {
                "sTitle": "Download", "mData": null, "sClass": "cls_action", mRender: function (data) {
                    var pdfstatus = data.pdf_status;
                    if (pdfstatus == 'Y') {
                        return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download PDF"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'
                    }
                    else {
                        return "";

                    }
                }
            },


            { "sTitle": "VF Code", "mData": "VF_code" },
                { "sTitle": "Instructor Name", "mData": "instructor_name" },
                { "sTitle": "Email", "mData": "mail" },
                { "sTitle": "Course Code", "mData": "course_code" },
            //{ "sTitle": "Designation", "mData": "designation" },

            //{
            //    //"sTitle": "Grade", "mData": null, "bSortable": false, "sClass": "cls_hide", "fnRender": function (data) {
            //    "sTitle": "Grade", "mData": null, "bSortable": false, "mRender": function (data) {
            //        if (data.rate_wise_designation != '' && data.rate_wise_designation != null && data.rate_wise_designation != undefined) { return data.rate_wise_designation; }

            //        else if (data.designation != '' && data.designation != null && data.designation != undefined) {
            //            return data.designation;
            //        }
            //        else { return ''; }

            //    }
            //},
            
            //{ "sTitle": "Department", "mData": "dept_name" },

            //{ "sTitle": "Highest Qualification", "mData": "highest_qualification" },
            //{ "sTitle": "Rate Band", "mData": null, "bSortable": false, fnRender: function (data) {
            //    if (data.aData.alternate_band != '') {
            //        return data.aData.alternate_band;
            //    }
            //    else {
            //        return data.aData.rate_band;
            //    }
            //}
            //},
            //{ "sTitle": "Justification", "mData": "justification" },

          /*  { "sTitle": "Admin Approval", "mData": "admin_approved" },*/

            //{ "sTitle": "Print Letters", "mData": "admin_approved", "bSortable": false, "mRender": function (data, type, full) {
            //    if (data == 'Approved')
            //        return '<center><button type="button" onclick="rowClick_print(this)">Print</button></center>';
            //    else
            //        return '';
            //}
            //},

            //{
            //    "sTitle": "Print Letters", "mData": null, "bSortable": false, "mRender": function (data) {
            //        if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.des_type == 'VF' && data.uso_hr_approved == 'Approved')
            //            return '<center><button type="button" onclick="rowClick_print(this)">Print</button></center>';
            //        else if (data.admin_approved == 'Approved' && data.rateband_approved == 'Approved' && data.workload_approved == 'Approved' && data.hr_approved == 'Approved' && data.uso_hr_approved == 'Approved')
            //            return '<center><button type="button" onclick="rowClick_print(this)">Print</button></center>';
            //        else
            //            return '';
            //    }
            //},
            


                {
                    "sTitle": "Designation Type", "mData": null, "bSortable": false, "mRender": function (data) {
                        if (data.des_type != '' && data.des_type != null && data.des_type != undefined) { return data.des_type; }


                        else { return ''; }

                    }
                },
                {
                    "sTitle": "Designation Letter", "mData": null, "bSortable": false, "mRender": function (data) {
                        if (data.designation_letter != '' && data.rate_wise_designation != null && data.designation_letter != undefined)
                        { return data.designation_letter; }

                        
                        else { return ''; }

                    }
                },
                {
                    "sTitle": "Title", "mData": null, "bSortable": false, "sClass": "cls_hide", "mRender": function (data) {
                        if (data.title != '' && data.tilte != null && data.tilte != undefined)
                        { return data.tilte; }


                        else { return ''; }

                    }
                },
                {
                    "sTitle": "Send Mail", "mData": null, "bSortable": false, "mRender": function (data) {
                        var pdfstatus = data.pdf_status;
                        if (pdfstatus == 'Y') {
                            return '<center><button type="button" class="sendmail">Send</button></center>';
                        }
                        else {
                            return '';
                        }

                    }
                },
            /*{ "sTitle": "Program Code", "mData": "prog_code", "sClass": "cls_hide" },*/
               
               
                
            ];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //        //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            //if ($('#hdnusertype').val() == 'HR') {
            //    $('#submitBtnDiv').css('display', 'block');
            //}

            $('#DataList').css('display', 'block');
            $('#example thead tr')[0].children[0].style.display = 'none';
            //$('#example thead tr')[0].children[5].style.display = 'none';
            //$('#example thead tr')[0].children[7].style.display = 'none';
            //$('#example thead tr')[0].children[8].style.display = 'none';
            //$('#example thead tr')[0].children[9].style.display = 'none';

            $("#example tbody tr").each(function (i) {
                $('.cls_hide').css('display', 'none');
                $('#example tbody tr')[i].children[0].style.display = 'none';
            });

            $("#example tbody tr").each(function (i) {
             $(this).children().eq(0)[0].style.display = 'none';
                //$(this).children().eq(5)[0].style.display = 'none';
                //$(this).children().eq(7)[0].style.display = 'none';
                //$(this).children().eq(8)[0].style.display = 'none';
                //$(this).children().eq(9)[0].style.display = 'none';
            });
            
        }

        
        function select_all_change() {
            if ($('#chk_select_all')[0].checked) {
                $('.cls_chk_course_select').attr('checked', 'checked');
            }
            else {
                $('.cls_chk_course_select').removeAttr('checked');
            }
        }
        function course_select_change(cur_ele) {

            if (cur_ele.checked) {
                if ($('.cls_chk_course_select').length == $('.cls_chk_course_select:checked').length)
                    $('#chk_select_all')[0].checked = true;
            }
            else {
                $('#chk_select_all')[0].checked = false;
            }
        }

        

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("S").html("Summer"));
            $('#drpsemester').append($("<option></option>").val("W").html("Winter"));
            $('#drpsemester').chosen();
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

      

       

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type:'ws_course'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            //$('#btnreterive').click();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function letter_auto_download() {

            var sem_code = $('#drpsemester').val();
            if (sem_code == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

          var  year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            var obj_selected_inst = $('.cls_chk_course_select:checked');
            if (obj_selected_inst.length > 0) {
                for (var i = 0; i < obj_selected_inst.length; i++)
                {
                    var row_data = oTable.fnGetData(obj_selected_inst[i].closest('tr'));

                    if (ints_code == "") {
                        ints_code = row_data['instructor_code'];
                        user_type = row_data['des_type'];
                        tea_letter = row_data['designation_letter'];
                        //program_code = row_data['prog_code'];

                    }
                    else {
                        //ints_code = '126';
                        ints_code = ints_code + ',' + row_data['instructor_code'];
                        user_type = user_type + ',' + row_data['des_type'];
                        tea_letter = tea_letter + ',' + row_data['designation_letter'];
                        //program_code = program_code + ',' + row_data['prog_code'];


                    }
                }
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/WS_publish_letter_print",
                    data: "{sem_code:'" + sem_code + "',year_code:'" + year_code + "',ints_code:'" + ints_code + "',user_type:'" + user_type + "',tea_letter:'" + tea_letter + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            if (data.d == "Data Not Found") {
                                bootbox.alert("No data found for selected course or course type");
                                return false;
                            }
                            else if (data.d == "true") {
                                location.reload();
                                //$('#btnreterive').click();
                                // get_vf_rate_band_detail(); session out issue 
                                //origin = window.location.origin + '/' + 'login.aspx?logout=2';
                                //window.open(origin, "_self");
                            }

                            return true;

                        }
                        else {
                            bootbox.alert('No data found for selected criteria');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });



            }
            else {
                alert("Please Select CheckBox");
                return false;
            }
        }


        $(document).on("click", ".pdf_download", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            //var course_code = aData["course_code"];
            var instructor_code = aData["instructor_code"];
            //var course_name = aData["course_name"];
            //var total_course = aData["total_course"];
            //var total_feedback = aData["total_feedback"];
            //var dept_name = aData["dept_name"];
            var instructor_name = aData["instructor_name"];
            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            if (semester == 'S') {
                semester = 'Summer';
            }
            else {
                semester = 'Winter';
            }
            var link = instructor_code + '_' + instructor_name.replace(' ', '_') + '_' + semester + '_' + year_code + '.pdf';
            link = link.replace(' ', '_');
           // origin = window.location.origin + '/';
           // window.open(origin + 'WSLetterPDF' + '/' + link, '_blank');

            document.getElementById('Link').download = instructor_code + ' ' + 'Publish Letter';
            document.getElementById('Link').href = '';
            document.getElementById('Link').href = window.location.origin + '\\WSLetterPDF\\' + link;
            document.getElementById('Link').click();
            return false;
        });


        function rowClick_mail(row) {
            
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            //var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
            //var dept = row.parentElement.parentElement.parentElement.childNodes[7].innerHTML;
            //var usrType = row.parentElement.parentElement.parentElement.childNodes[11].innerHTML;
            //var tea_letter = row.parentElement.parentElement.parentElement.childNodes[12].innerHTML;
            //var prog_code = row.parentElement.parentElement.parentElement.childNodes[13].innerHTML;
            //
            //$('#hdn_usrType').val(usrType);
            //var instructor_list = [{ 'instructor_code': rowId, 'dept_name': dept, 'sem_code': semester, 'year_code': year_code, 'prog_code': prog_code, 'hdn_user_type': usrType, 'hdn_tea_letter': tea_letter }];

            //send_mail(JSON.stringify(instructor_list));
        }

        $(document).on("click", ".sendmail", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            //var portfolio_file_name = aData["portfolio_file_name"];
            //var ppt_video = aData["ppt_video"];
            //$('#hdn_file_name').val(ppt_video);
            //$("#btnDownloadproposal").click();
            var instructor_list = [{ 'instructor_code': aData.instructor_code, 'instructor_name': aData.instructor_name, 'sem_code': aData.semester_type, 'year_code': aData.year_semester, 'hdn_user_type': aData.des_type, 'course_code': aData.course_code, 'mail': aData.mail, 'title': aData.tilte }];

            //$('#hdn_instructor').val(JSON.stringify(instructor_list));
            //$('#hdn_send_mail').click();

            send_mail(JSON.stringify(instructor_list));
            return false;
        });



        function send_mail(instructor_list) {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/sws_send_Appointment_mail_to_visiting_faculty",
                    //async: false,
                    data: "{instructor_list:'" + instructor_list + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == null || data.d == '') {
                            bootbox.alert('Problem in Sending Mails.');
                        }
                        else if (data.d != "" && data.d != "[]") {
                            bootbox.alert(data.d);
                        }
                        else {
                            bootbox.alert(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Publish Letters
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>
                                    Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <%--<td>
                                    Programme :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>--%>
                            </tr>
                          <%--  <tr>
                                   <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                                <td>
                                    Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>
                                </tr>--%>
                            <tr>
                                <td colspan="8">
                                    <button class="btn btn-primary" id="btnreterive"> Retrieve</button>
                                    <button class="btn btn-primary" id="btngenerateletter">Generate Letter</button>
                                    <%--<button class="btn btn-primary" id="btn_print_letter_all" onclick="update_letter()"> Update Letter</button>
                                    <button class="btn btn-primary" id="btndownload"> Download</button>--%>
                                   
                                </td>
                                <%--<td>
                                    <input id="cb" type="checkbox" >
                                </td>--%>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">Publish Letters</strong>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div id="DataList" style="display: none;">
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
    </div>
    <div style="display: none;">
        <a href="#" id="Link" download="outline.pdf">Download</a>
    </div>
</asp:Content>

