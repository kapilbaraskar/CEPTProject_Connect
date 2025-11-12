<%@ Page Title="Student Wise Upload Certificate Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Student_wise_certificate_dtl.aspx.cs" Inherits="Admin_Report_Student_wise_certificate_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
   <%-- <script src="https://cdn.datatables.net/fixedcolumns/4.0.0/js/dataTables.fixedColumns.min.js"></script>--%>


    <style>
        label {
            float: left;
            clear: none;
            display: block;
            padding: 0px 1em 0px 8px;
        }

        input[type=radio],
        input.radio {
            float: left;
            clear: none;
            margin: 2.3px 0 0 2.3px;
        }

        .cls_desc_width {
            width: 103px;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var asInitVals = new Array();
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            binddepartment()
            bindprogrammedata();
            bindyeardata();



            $('#btnreterive').on('click', function () {
                get_detail();
                return false;
            });
            
            $('#btndownload_pdf').on('click', function () {
                var type = false;
                if ($("#p").is(":checked")) {
                    type = 'p';
                }
                else if ($("#m").is(":checked")) {
                    type = 'm';
                }
                else if ($("#a").is(":checked")) {
                    type = 'a';
                }
                else if ($("#d").is(":checked")) {
                    type = 'd';
                }
                else if ($("#co").is(":checked")) {
                    type = 'co';
                }
                else if ($("#c").is(":checked")) {
                    type = 'c';
                }
                else if ($("#image").is(":checked")) {
                    type = 'image';
                }
                else {
                    bootbox.alert("Please Select At Least One Radio Button");
                    return false;
                }

                var year_code = $('#drpyear').val();
                var sem_year_code = $('#sem_drpyear').val();
                var dept_code = $('#drpdepartment').val();
                var prog_code = $('#drpprog').val();
                //var sr_no = "";
                //if ($('#sr_no').val() != "") {
                //    sr_no = $('#sr_no').val();
                //}
                //else
                //{
                //    bootbox.alert("Please Insert Sr No");
                //    return false;
                //}
                //if (type != false)
                //{
                //    $.ajax({
                //        type: "POST",
                //        contentType: "application/json; charset=utf-8",
                //        url: "../../WebService.asmx/CombinePDF_Student_Certificate",

                //        data: "{'type':'" + type + "','sr_no':'"+sr_no+"'}",
                //        dataType: "json",
                //        success: function (data) {
                //            if (data.d != "") {
                //                if (data.d == "2")
                //                {
                //                    bootbox.alert("No Data Found");
                //                    return false;
                //                }
                //                else
                //                {
                //                    var origin = window.location.origin;
                //                    if (type == 'm')
                //                    {
                //                        window.open(origin + '/' + 'MedicalCertificate' + '/' + 'MedicalCertificate.zip'); return false;
                //                    }
                //                    else if (type == 'a')
                //                    {
                //                        window.open(origin + '/' + 'Antiragging' + '/' + 'Antiragging.zip'); return false;
                //                    }
                //                    else if (type == 'd')
                //                    {
                //                        window.open(origin + '/' + 'BirthCertificate' + '/' + 'BirthCertificate.zip'); return false;

                //                    }
                //                    else if (type == 'sc')
                //                    {
                //                        window.open(origin + '/' + 'SchoolLeavingCertificate' + '/' + 'SchoolLeavingCertificate.zip'); return false;

                //                    }
                //                    else if (type == 'co')
                //                    {
                //                        window.open(origin + '/' + 'CovidVaccineCertificate' + '/' + 'CovidVaccineCertificate.zip'); return false;
                //                    }
                //                    else if (type == 'c')
                //                    {
                //                        window.open(origin + '/' + 'ConsentForm' + '/' + 'ConsentForm.zip'); return false;
                //                    }
                //                    else if (type == 'image')
                //                    {
                //                        window.open(origin + '/' + 'UserProfilePhoto' + '/' + 'UserProfilePhoto.zip'); return false;
                //                    }


                //                }

                //                return false;

                //            }
                //            else {
                //                bootbox.alert('No data found for selected criteria');
                //                return false;
                //            }
                //        },
                //        error: function (result) {
                //            alert(result);
                //        }
                //    });
                //    return false;
                //} 


                if (type != false) {
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/CombinePDF_Student_Certificate",

                        data: "{'type':'" + type + "',year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',sem_code:'" + sem_year_code + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "") {
                                if (data.d == "2") {
                                    bootbox.alert("No Data Found");
                                    return false;
                                }
                                else {
                                    var origin = window.location.origin;
                                    if (type == 'm') {
                                        //window.open(origin + '/' + 'MedicalCertificate' + '/' + 'MedicalCertificate.zip');
                                        window.open(origin + '/' + 'MedicalCertificate' + '/' + data.d + '.zip');
                                        return false;
                                    }
                                    else if (type == 'a') {
                                        //window.open(origin + '/' + 'Antiragging' + '/' + 'Antiragging.zip');
                                        window.open(origin + '/' + 'Antiragging' + '/' + data.d + '.zip');
                                        return false;
                                    }
                                    else if (type == 'd') {
                                        //window.open(origin + '/' + 'BirthCertificate' + '/' + 'BirthCertificate.zip');
                                        window.open(origin + '/' + 'BirthCertificate' + '/' + data.d + '.zip');
                                        return false;

                                    }
                                    else if (type == 'sc') {
                                        //window.open(origin + '/' + 'SchoolLeavingCertificate' + '/' + 'SchoolLeavingCertificate.zip');
                                        window.open(origin + '/' + 'SchoolLeavingCertificate' + '/' + data.d + '.zip');
                                        return false;

                                    }
                                    else if (type == 'co') {
                                        //window.open(origin + '/' + 'CovidVaccineCertificate' + '/' + 'CovidVaccineCertificate.zip');
                                        window.open(origin + '/' + 'CovidVaccineCertificate' + '/' + data.d + '.zip');
                                        return false;
                                    }
                                    else if (type == 'c') {
                                        window.open(origin + '/' + 'ConsentForm' + '/' + data.d + '.zip');
                                        //window.open(origin + '/' + 'ConsentForm' + '/' + 'ConsentForm.zip');
                                        return false;
                                    }
                                    else if (type == 'image') {
                                        //window.open(origin + '/' + 'UserProfilePhoto' + '/' + 'UserProfilePhoto.zip');
                                        window.open(origin + '/' + 'UserProfilePhoto' + '/' + data.d + '.zip');
                                        return false;
                                    }


                                }

                                return false;

                            }
                            else {
                                bootbox.alert('No data found for selected criteria');
                                return false;
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                    return false;
                }


            });
            return false;

        });

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

                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Enrollment Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }
                        $('#drpyear').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
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
                        var year_data = JSON.parse(data.d)

                        $('#sem_drpyear').empty().append($("<option></option>").val("").html("-- Please Enrollment Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#sem_drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }
                        $('#sem_drpyear').chosen();
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
        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function get_detail() {

            var year_code = $('#drpyear').val();
            var sem_year_code = $('#sem_drpyear').val();
            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();

            $('#DataList').css('display', 'none');

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_Certificate_dtl",
                    data: "{year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "',sem_code:'" + sem_year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            display_certificate_detail(data.d);
                            $('#div_student_certificate_dtl').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }
        function display_certificate_detail(data) {
            var columns = [

                //{ "sTitle": "Sr No", "mData": "sr_no" },
                { "sTitle": "Student Code", "mData": "user_id" },
                { "sTitle": "Old Code", "mData": "enrollment_no" },
                { "sTitle": "Student Name", "mData": "full_name" },
                { "sTitle": "Date Of Birth", "mData": "user_dob", "sClass": "cls_desc_width" },
                { "sTitle": "Blood Group", "mData": "blood_group" },

                {
                    "sTitle": "Studio Type", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.studio_type != "") {

                            return data.studio_type;
                        }
                        return '';
                    }
                },

                {
                    "sTitle": "Parental Consent Form", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.consent_form_path != "") {

                            return " <a href='" + location.origin + "\\ConsentForm\\" + data.consent_form_path + "' target='_blank'>View</a>";
                        }
                        return '';
                    }
                },
                {
                    "sTitle": "Medical Certificate", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.medical_file_path != "") {


                            return " <a href='" + location.origin + "\\MedicalCertificate\\" + data.medical_file_path + "' target='_blank'>View</a>";
                        }
                        return '';
                    }
                },
                {
                    "sTitle": "Antiragging Certificate", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.antirigging_file_path != "") {


                            return " <a href='" + location.origin + "\\Antiragging\\" + data.antirigging_file_path + "' target='_blank'>View</a>";
                        }
                        return '';
                    }
                },

                {
                    "sTitle": "Proof Of DOB", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.school_leaving_certificate != "") {


                            return " <a href='" + location.origin + "\\SchoolLeavingCertificate\\" + data.school_leaving_certificate + "' target='_blank'>View</a>";
                        }
                        else if (data.birth_certificate != "") {
                            return " <a href='" + location.origin + "\\BirthCertificate\\" + data.birth_certificate + "' target='_blank'>View</a>";
                        }
                        return '';
                    }
                },
                {
                    "sTitle": "Covid Vaccine First Dose Certificate", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.covid_vaccine_1_certificate != "") {


                            return " <a href='" + location.origin + "\\CovidVaccineCertificate\\" + data.covid_vaccine_1_certificate + "' target='_blank'>View</a>";
                        }
                        return '';
                    }
                },
                {
                    "sTitle": "Covid Vaccine Second Dose Certificate", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.covid_vaccine_2_certificate != "") {


                            return " <a href='" + location.origin + "\\CovidVaccineCertificate\\" + data.covid_vaccine_2_certificate + "' target='_blank'>View</a>";
                        }
                        return '';
                    }
                },
                {
                    "sTitle": "Profile Image", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.profile_photo != "") {

                            const pic = data.profile_photo.split("/");

                            if (pic.length > 1) {
                                return '';
                            }
                            var extension = data.profile_photo.substr((data.profile_photo.lastIndexOf('.') + 1));
                            return " <a href='" + location.origin + "\\UserProfilePhoto\\" + data.profile_photo + "' download=''" + data.user_id + "'.'" + extension + "''>View</a>";
                        }
                        return '';
                    }
                },
                // return '<center><button type="button" id=' + data.sr_no + ' onclick="rowClick_approve(this,\'' + rej + '\')">Approve</button></center>';
                {
                    "sTitle": "Parental Consent Form Status", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.consent_status != "" && data.consent_status != undefined) {
                            return '<center><button type="button" id=' + data.user_id + ' onclick="rowClick_reject(this,\'' + 'consent_status' + '\')">Reject</button></center>';
                        }
                        return '';
                    }
                },

                {
                    "sTitle": "Proof Of DOB Status", "mData": null, "bSortable": false, mRender: function (data) {

                        if (data.dob != "" && data.dob != undefined) {
                            return '<center><button type="button" id=' + data.user_id + ' onclick="rowClick_reject(this,\'' + 'is_submit' + '\')">Reject</button></center>';
                        }
                        return '';
                    }
                },
                {
                    "sTitle": "Covid Vaccination Status", "mData": null, "bSortable": false, mRender: function (data) {
                        if (data.vaccination_status != "" && data.vaccination_status != undefined) {
                            return '<center><button type="button" id=' + data.user_id + ' onclick="rowClick_reject(this,\'' + 'vaccination_status' + '\')">Reject</button></center>';
                        }
                        return '';
                    }
                },
                { "sTitle": "Create Date", "mData": "created_date", "sClass": "cls_desc_width" },

                {
                    "sTitle": "Last Modified Date", "mData": null, "sClass": "cls_desc_width", "bSortable": false, mRender: function (data) {
                        if (data.last_modified_date != "" && data.last_modified_date != undefined) {
                            return data.last_modified_date;
                        }
                        return '';
                    }
                },

            ];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }
            oTable = $("#example").dataTable({
                //"scrollY": false,
                //"scrollX": true,
                //"scrollCollapse": true,
                //"fixedColumns": {
                //    left: 1,
                //    right: 1
                //},
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');


            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

            //adding input box in thead second row 
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
                var title = $('#example thead th').eq(i).text();
                $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            };

            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("thead input").index(this));
            });

            $("thead input").each(function (i) {
                asInitVals[i] = this.value;
            });

            $("thead input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });

            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("thead input").index(this)];
                }
            });

        }

        function rowClick_reject(row, status) {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/reject_certificate_dtl",
                    data: "{student_id:'" + row.id + "',column_name:'" + status + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert("Approved successfully");
                                get_detail();
                            }
                            else if (data.d == "Reject") {
                                bootbox.alert("Reject successfully");
                                get_detail();
                            }
                            else {
                                bootbox.alert('Problem in Data');
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

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i><span id="title_name">Student Certificate Details </span>
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
                            <%--<tr>
                                <td>Sr No (From) : <input type="text" id="sr_no" /></td>
                                
                            </tr>--%>
                            <tr>
                                <td>Enrollment Year:
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>Department :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>


                            </tr>
                            <tr>
                                <td>Program :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog" />
                                </td>
                                <td>
                            Semester Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="sem_drpyear">
                            </select>
                        </td>
                                <td>
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="6">
                                    <label class="radio-inline">
                                        <input type="radio" name="optradio" id="c">&nbsp;Parental Consent Form</label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optradio" id="m">&nbsp;Medical Certificate</label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optradio" id="a">&nbsp;Antiragging Certificate</label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optradio" id="d">&nbsp;Date Of Birth Certificate</label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optradio" id="sc">&nbsp;School Leaving Certificate</label>

                                </td>
                            </tr>
                            <tr>

                                <td colspan="6">
                                    <label class="radio-inline">
                                        <input type="radio" name="optradio" id="co">&nbsp;Covid Vaccine Certificate</label>
                                    <label class="radio-inline">
                                        <input type="radio" name="optradio" id="image">&nbsp;Profile Image</label>

                                    <button class="btn btn-primary" id="btndownload_pdf">
                                        Download PDF
                                    </button>
                                </td>

                            </tr>

                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="div_student_certificate_dtl" class="panel panel-default" style="display: none; overflow: auto;">

            <div class="panel-heading">
                <strong id="panel_head">Student Certificate Detail</strong>
            </div>
            <div id="DataList" style="display: none;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="150%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>


        </div>

    </div>

</asp:Content>

