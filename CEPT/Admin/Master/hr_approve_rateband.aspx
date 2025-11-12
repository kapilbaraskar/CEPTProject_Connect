<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="hr_approve_rateband.aspx.cs" Inherits="Admin_Master_hr_approve_rateband" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            $('#btnreterive').on('click', function () {
                get_data();
                $(".cls_btn_pdf").addClass("btn btn-primary");
                return false;
            });
            //$("#drpsemester,#drpyear").on('change', function () {
            //    $('#DataList').css('display', 'none');
            //    return true;
            //});
            
        });
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

        $(document).on("click", ".pdf_download_doc", function (event) {
           
            var instructor_code = event.currentTarget.id;
            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            var dep_name = "";

            if (semester == 'S') {
                semester = 'Spring';
            }
            else {
                semester = 'Monsoon';
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Download_Document_new_course",
                data: "{'instructor_code':'" + instructor_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "1") {
                            $("#btnDownloadExcelDocuments").click();
                            return false;
                        }
                        else {
                            bootbox.alert('Document Not Found');
                            return false;
                        }
                        return true;
                    }
                    else {
                        bootbox.alert('Document Not Found');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        });

        $(document).on("click", ".pdf_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var file_name = event.currentTarget.id;
            var root = window.location.origin;
            //alert(root);
            window.open(root + '/' + 'InstructorCVUpload' + '/' + file_name, '_blank');
        });
        $(document).on("click", ".port_download", function (event) {
            var row = $(this).closest("tr").get(0); //
            var file_name = event.currentTarget.id;
            var root = window.location.origin;
            //alert(root);
            window.open(root + '/' + 'InstructorPortfolioUpload' + '/' + file_name, '_blank');
        });
        $(document).on("click", ".imag_download", function (event) {
            var row = $(this).closest("tr").get(0); //
            var file_name = event.currentTarget.id;
            var root = window.location.origin;
            //alert(root);
            document.getElementById('Link').download = file_name;
            document.getElementById('Link').href = window.location.origin + "\\UserPersonalPhoto" + "\\" + file_name;
            document.getElementById('Link').click();
        });

        function rowClick_Hr_Authorized(element) {
            
           
            var semester_type = $('#drpsemester').val();
            var year_semester = $('#drpyear').val();
            var a_instructor_code = element.id;
           

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Uso_Hr_Authorized_Course",
                    //async: false,
                    data: "{instructor_code:'" + a_instructor_code + "', sem_code:'" + semester_type + "',year_code:'" + year_semester + "'}",
                    dataType: "json",
                    success: function (data) {
                        //if (TA_user == 'temp')
                        //{
                        //    TA_user = 'TA';
                        //    convert_VF_Type(a_instructor_code, instructor_name, email, TA_user);
                        //    //bootbox.alert(data.d);
                        //    get_authorize_detail();
                        //}
                        //else {
                            bootbox.alert(data.d);
                        get_data();
                        //}



                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }


        var entityMap = { "'": '&#39;', '"': '&#34;', "@": '&#64;', "&": '&#38;', "<": '&#60;', ">": '&#62;', "/": '&#47;' };
        function sendremark(element)
        {
            //var row = element.closest('tr');
            //var aData = oTable.fnGetData(row);

            var remark_details = "";
            //var remark_id = aData["instructor_code"] + '_' + aData["course_code"];
            var remark_id = element.id;
            if ($('#remark_data' + remark_id).val() == '') {
                alert("Please Enter Remark")
                return false;
            }
            remark_details =
            {
                "instructor_code": element.id,
                "course_code": '',
                "remark": $('#remark_data' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
            };

            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/insert_course_remark_coure_wise",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',interested_remark_data: '" + json_submit_data + "'}",
            
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Mail Send Successfully")
                            }
                            else if (data.d == true) {
                                bootbox.alert("Mail Send Successfully")
                            }
                        }
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            //$('#hdn_instructor').val(row_data['instructor_code'].toString());
            //$('#hdn_instructor_name').val(row_data['instructor_name'].toString());
            //$('#hdn_dept').val(row_data['dept_name'].toString());
            //$('#hdn_sem').val(semester);
            //$('#hdn_year').val(year_code);

        }

        function rowClick_edit(row) {
            var url = "vf_edit_personal_detail.aspx?ic=" + row.id + "&type=tutor";
            window.open(url, "_blank");
        }


        function get_data() {
           
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            var status = $('#drpstatus').val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_tab_data",
                async: false,
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',status:'" + status + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_rateband_data(data.d);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function display_rateband_data(data) {
      
            var hr_status = $('#hdnusertype').val();
            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');

            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bStateSave": false,
                "iDisplayLength": 60,
                "bSort": false,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
               
                "aoColumns": [
                    { "sTitle": "TExt", "mData": "htmltext", "bSortable": false },
                    //{ "sTitle": "USER ID", "mData": "USER_ID", "bSortable": false },
                    //{ "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                    //{ "sTitle": "Designation", "mData": "designation", "bSortable": false },
                    //{ "sTitle": "Rate Band", "mData": "rate_band", "bSortable": false },
                    { "sTitle": "Course Codes", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Rate Band", "mData": "rate_band", "bSortable": false },
                   // { "sTitle": "Update Rate Band", "mData": "new_rate_band", "bSortable": false },
                    { "sTitle": "Total Contact Hrs", "mData": "total_contact_hrs", "bSortable": false },
                    { "sTitle": "Total Weeks", "mData": "total_weeks", "bSortable": false },
                    { "sTitle": "Additional Hours", "mData": "additional_hours", "bSortable": false },
                    { "sTitle": "TotalHrs In Semester", "mData": "total_hrs_in_semester", "bSortable": false },

                    
                    { "sTitle": "Total Pay", "mData": "TotalPay", "bSortable": false },
                     
                 
                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, mRender: function (data) {
                           
                           
                                var remark_id = data.instructor_code ;
                            if (data.hr_approved == 'Y' && data.uso_hr_approved == 'Y' && data.admin_approved == 'Y') {
                                return 'Approved';
                            }
                            else { return 'Pending';}
                                  
                               
                            
                        }
                    }
                    //,{
                    //    "sTitle": "Remark", "mData": null, "bSortable": false, mRender: function (data) {
                    //        if (hr_status = 'HR') {
                    //            var remark_button_id = data.instructor_code;
                    //            if (remark_button_id != '') {
                    //                return '<center><button type="button" id=' + remark_button_id + ' class="reject">Remark</button></center>';
                    //            }
                    //            else { return ''; }

                    //        }
                    //    }
                    //},
                    //{
                    //    "sTitle": "Approve", "mData": null, "bSortable": false, mRender: function (data) {
                    //        if (hr_status = 'HR') {
                    //            var approve_button_id = data.instructor_code;
                    //            if (data.hr_approved == 'Y' && data.uso_hr_approved == 'Y' && data.admin_approved == 'Y') {
                    //                return "Approved";
                    //            }
                    //            else { return '<center><button type="button" id=' + approve_button_id + ' class="approve_reject">Approve</button></center>'; }

                    //        }
                    //    }
                    //}
                ],
            }).rowGrouping();

            $('#DataList').css('display', 'block');
        }
        $(document).on("click", ".reject", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var remark_id = aData["instructor_code"];
            var reject_remark = $('#' + remark_id).val();
            var remark_details = "";
            remark_details =
                {
                "remark_id": aData["instructor_code"],
                "reject_remark": $('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
            };


            if (reject_remark == "") {
                bootbox.alert('Please Enter Remark');
                $('#' + aData["studio_code"]).focus();
                return false;
            }
        });
        //$(document).on("click", ".approve_reject", function (event) {
        //    var row = $(this).closest("tr").get(0);
        //    var aData = oTable.fnGetData(row);
        //    var remark_id = aData["instructor_code"];
        //    var reject_remark = $('#' + remark_id).val();
        //    var remark_details = "";
        //    remark_details =
        //    {
        //        "remark_id": aData["instructor_code"],
        //        "reject_remark": $('#' + remark_id).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
        //    };


        //    if (reject_remark == "") {
        //        bootbox.alert('Please Enter Remark');
        //        $('#' + aData["studio_code"]).focus();
        //        return false;
        //    }
        //});
       
    </script>

    <style>
       table#rateband_txt tr td
       {
        border:none;
       }
       #rate_band_id{
           color:blue;
       }
       
       
    </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
      <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>RateBand Report
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year 
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>

                                <td>Status
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpstatus">
                                        <option value="">--Please Select Status--</option>
                                        <option value="A">Approved</option>
                                        <option value="P">Pending</option>
                                    </select>
                                </td>

                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Rate Band Report</strong>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow: overlay;">
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
     <a href="#" id="Link" download="outline.pdf" Style="display: none;">Download</a>
   <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static" OnClick="btnDownloadExcelDocuments_Click" />
    
</asp:Content>
