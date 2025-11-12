<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="student_vaccination_dtl.aspx.cs" Inherits="Student_student_vaccination_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
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
        }
        body {
  overflow: hidden; /* Hide scrollbars */
}
    </style>
    <script>
        {
            $(document).ready(function () {
                get_student_dtl();
                get_user_detail();
                $('#student_code').val($("#hdn_stud_code").val());
                $('#click_pdf').click(clickevent);
                function clickevent() {
                    //$("#btnDownloadCertificate").click();
                }

                $('#btnsubmit').on('click', function () {
                    save_dtl('A');

                });

                $('#btnsave').on('click', function () {
                    

                    save_dtl('S');
                });

                //$('#btnsubmit').on('click', function () {
                function save_dtl(status) {

                    if ($('#lbl_v1_Cert_file_name').text() == "")
                    {
                        alert("Please Upload Covid Vaccine First Dose Certificate");
                        return false;
                    }

                    //if ($('#lbl_v2_Cert_file_name').text() == "") {
                    //    bootbox.alert("Please Upload Covid Vaccine Second Dose Certificate");
                    //    return false;
                    //}

                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Covide_Vaccine_Certificate_upload_dtl",
                        async: false,
                        data: "{covid_vaccine_1_certificate:'" + $('#lbl_v1_Cert_file_name').text() + "',covid_vaccine_2_certificate:'" + $('#lbl_v2_Cert_file_name').text() + "',user_id : '" + $("#hdn_stud_code").val() + "',status:'" + status + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "" && data.d != "[]") {
                                if (status == 'S')
                                {
                                    alert("Certificate Save Successfully");
                                }
                                else { alert("Certificate Submit Successfully"); }


                            }
                            else {

                            }

                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                }
                //});


                $("input[name$='optradio']").click(function ()
                {
                    if ($('#vac_yes').is(":checked"))
                    {
                        $('#vaccine_Status').css('display', 'block');
                        $('#vac_yes').attr("checked", 'false');
                    }
                    if ($('#vac_no').is(":checked")) {
                        $('#vaccine_Status').css('display', 'none');
                        
                        $('#div_certi_dtl').css('display', 'none');
                        

                    }
                });

            });



            function get_student_dtl() {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_student_dtl",
                    async: false,
                    data: "{student_code : '" + $("#hdn_stud_code").val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {

                            var student_data = JSON.parse(data.d)

                            $('#student_name').val(student_data[0]["user_name"]);
                            $('#hdn_stud_name').val(student_data[0]["user_name"]);

                        }
                        else {
                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }


            function get_user_detail() {

                $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Get_Birth_School_leaving_Certificate_dtl",
                        data: "{}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "" && data.d != "[]") {
                                var origin = window.location.origin;
                                var details = JSON.parse(data.d);
                                if (details[0]["covid_vaccine_1_certificate"] == "" && details[0]["covid_vaccine_2_certificate"] == "")
                                {
                                    $('#vac_no').attr('checked', true);
                                  
                                    return false;

                                }
                                else
                                {
                                    $('#vac_no').attr('disabled', 'disabled');
                                    $('#vac_yes').attr('checked', true);
                                    $('#vaccine_Status').css('display', 'block');
                                    $('#div_certi_dtl').css('display', 'block');
                                }
                               
                                var statustext = '';
                                if (details[0]["vaccination_status"] == 'A')
                                {
                                    //statustext = 'Approved';
                                    //$('#status').text('Submit');
                                    $('#v1CertUpload').attr("disabled", "disabled");
                                    $('#v2CertUpload').attr("disabled", "disabled");
                                    $('#btnsubmit').attr("disabled", "disabled");
                                    $('#btnsave').attr("disabled", "disabled");
                                    $('#vac_no').attr('disabled', 'disabled');
                                }
                               // else if (details[0]["is_submit"] == 'S')
                               // {
                               //     statustext = 'Saved';
                               //     $('#status').text('Saved')
                               // }


                                var str = "<tr><th>Student Code</th><th>Student Name</th><th>Covid Vaccine First Dose Certificate</th><th>Covid Vaccine Second Dose Certificate</th></tr>";
                                str += "<tr><td>" + $("#hdn_stud_code").val() + "</td><td>" + $('#hdn_stud_name').val() + "</td>";

                                if (details[0]["covid_vaccine_1_certificate"] != "")
                                {
                                    str += "<td><a href='" + origin + "\\CovidVaccineCertificate\\" + details[0]["covid_vaccine_1_certificate"] + "' target='_blank'>Download</a></td>";

                                }
                                else
                                {
                                    str += "<td></td>";
                                }
                                if (details[0]["covid_vaccine_2_certificate"] != "") {
                                    str += "<td><a href='" + origin + "\\CovidVaccineCertificate\\" + details[0]["covid_vaccine_2_certificate"] + "' target='_blank'>Download</a></td>";
                                }
                                else
                                {
                                    str += "<td></td>";
                                }
                                str += "</tr>";
                                $('#tbl_certi_dtl').html(str);
                                $('#div_certi_dtl').css('display', 'block');

                                if (details[0]["file_path"] != '') {
                                    $('#lbl_v1_Cert_file_name').html('<b>' + details[0]["covid_vaccine_1_certificate"] + '</b>');
                                    $('#lbl_v2_Cert_file_name').html('<b>' + details[0]["covid_vaccine_2_certificate"] + '</b>');
                                }

                            }
                            else
                            {
                                $('#vac_no').attr('checked', true)
                                //bootbox.alert('No data Found');
                                return false;
                            }
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });

                return false;
            }

            function Uploadbirthcertificate() {
                try {
                    //var d = new Date();
                    var fileToUpload = GetFileNameFromPath($('#v1CertUpload').val());
                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                    if (CheckUserPhotoExtension(fileToUpload)) {

                        var flag = true;

                        if (filename != "" && filename != null) {

                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../../Handler/birthschoolvaccine.ashx',
                                    secureuri: false,
                                    fileElementId: 'v1CertUpload',
                                    data: { 'ICODE': $("#hdn_stud_code").val(), 'FNAME': 'Vaccine_First_Dose', 'LNAME': 'Vaccine' },
                                    dataType: 'json',
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                            }
                                            else {
                                                $('#v1CertUpload').val("");
                                                $('#lbl_v1_Cert_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload
                                                bootbox.alert("Covid Vaccine First Dose Certificate Upload Successfully");

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
                        alert('Invalid File Type. Please Upload PDF File');
                    }
                    return false;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                }

            }

            function Uploadschoolcertificate() {
                try {
                    //var d = new Date();
                    var fileToUpload = GetFileNameFromPath($('#v2CertUpload').val());
                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                    if (CheckUserPhotoExtension(fileToUpload)) {

                        var flag = true;

                        if (filename != "" && filename != null) {

                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../../Handler/birthschoolvaccine.ashx',
                                    secureuri: false,
                                    fileElementId: 'v2CertUpload',
                                    data: { 'ICODE': $("#hdn_stud_code").val(), 'FNAME': 'Vaccine_Second_Dose', 'LNAME': 'Vaccine' },
                                    dataType: 'json',
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                            }
                                            else {
                                                $('#v2CertUpload').val("");
                                                $('#lbl_v2_Cert_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload
                                                bootbox.alert("Covid Vaccine Second Dose Certificate Upload Successfully");

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
                        alert('Invalid File Type. Please Upload PDF File');
                    }
                    return false;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                }

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
            function CheckUserPhotoExtension(file) {
                try {
                    var flag = true;
                    var extension = file.substr((file.lastIndexOf('.') + 1));

                    switch (extension) {

                        case 'pdf':
                        case 'PDF':

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
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <main class="my-form">
        <div class="cotainer">
            <div class="row-fluid">
                <div class="page-header position-relative">
                    <h1>Vaccination Details</h1>
                </div>
            </div>
            <div class="row justify-content-center" style="padding-top: 25px;">
                <div class="col-md-12">
                    <div class="row">
                        <div class="col-md-11">
                        <span style="text-align:justify;"><b><span style="color:red;"> Note:</span>  Students will need to carry their ID cards for entering the campus each day. COVID-19 related protocols as updated from time to time will be mandatory for all students, faculty,
                         and staff of the University.</br>  All students (above 18) are strongly advised to complete their vaccination. People who are not fully vaccinated may be disallowed access to campus.</span></b></br></br>
                    </div>
                    </div>
                </div>

                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div id="div_vaccine" style="display: block;">
                                    <div class="form-group row">
                                        <label class="col-md-4 col-form-label text-md-right">Are you vaccinated</label>
                                        <div class="col-md-6">
                                            <label class="radio-inline">
                                                <input type="radio" name="optradio" id="vac_yes">
                                                YES</label>
                                            <label class="radio-inline">
                                                <input type="radio" name="optradio" id="vac_no">
                                                NO</label>
                                        </div>
                                    </div>
                                    <div id="vaccine_Status" style="display:none;">
                                        <div class="form-group row">
                                            <label class="col-md-4 col-form-label text-md-right" style="padding-top: 9px;">Covid Vaccine First Dose Certificate</br> <span style="color: blue;">(Max 5 MB)</span><span class="cls_mendatory" style="color: Red;">*</span></label>
                                            <div class="col-md-6">
                                                <div style="padding: 10px; padding-left: 0px; overflow: visible;" class="panel-collapse collapse in">
                                                    <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                        <span><strong>Choose File</strong></span>
                                                        <input type="file" name="v1CertUpload" id="v1CertUpload" onchange="javascript:return Uploadbirthcertificate();" style="display: none;">
                                                    </label>
                                                    <span id="lbl_v1_Cert_file_name" style="vertical-align: super;"></span>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group row">
                                            <label class="col-md-4 col-form-label text-md-right" style="padding-top: 9px;">Covid Vaccine Second Dose Certificate</br> <span style="color: blue;">(Max 5 MB)</span> <span class="cls_mendatory" style="color: Red;">*</span></label>
                                            <div class="col-md-6">
                                                <div style="padding: 10px; padding-left: 0px; overflow: visible;" class="panel-collapse collapse in">
                                                    <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                        <span><strong>Choose File</strong></span>
                                                        <input type="file" name="v2CertUpload" id="v2CertUpload" onchange="javascript:return Uploadschoolcertificate();" style="display: none;">
                                                    </label>
                                                    <span id="lbl_v2_Cert_file_name" style="vertical-align: super;"></span>
                                                </div>
                                            </div>


                                        </div>
                                        <div class="form-group row" style="display: block; padding-bottom: 14px;">

                                            <div class="col-md-6">
                                                <button class="btn btn-primary" id="btnsave">Save</button>
                                                <button class="btn btn-primary" id="btnsubmit" style="display:none;">Submit</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default" id="div_certi_dtl" style="display: none;">
                <div class="panel-heading">
                    <strong>Vaccination Details</strong>
                </div>
                <div>
                    <table id="tbl_certi_dtl" class="table table-bordered">
                    </table>
                </div>
            </div>
        </div>
    </main>
    <input type="hidden" id="hdn_stud_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_file_path" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_stud_name" runat="server" clientidmode="Static" />

</asp:Content>

