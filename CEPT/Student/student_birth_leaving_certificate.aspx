<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="student_birth_leaving_certificate.aspx.cs" Inherits="Student_student_birth_leaving_certificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script type="text/javascript">
        {
            $(document).ready(function () {
                get_student_dtl();
                get_user_detail();
                $('#student_code').val($("#hdn_stud_code").val());
                $('#click_pdf').click(clickevent);
                function clickevent() {
                    //$("#btnDownloadCertificate").click();
                }

                $('#btnsubmit').on('click', function ()
                {
                    save_dtl('A');

                });

                $('#btnsave').on('click', function () {
                    save_dtl('S');
                });

                //$('#btnsubmit').on('click', function () {
                function save_dtl(status) {

                    var birth_cert_name = "";
                    var school_cert_name = "";
                    if ($('#myDatePicker').val() == "") {
                       alert("Please Insert Date Of Birth");
                        return false;
                    }
                    if ($('#drcertificate_type').val() == 'B') {
                        if ($('#lbl_birth_Cert_file_name').text() == "") {
                            alert("Please Upload Birth Certificate");
                            return false;
                        }
                        else
                        {
                            birth_cert_name = $('#lbl_birth_Cert_file_name').text();
                        }
                    }
                    else {
                        if ($('#lbl_school_Cert_file_name').text() == "") {
                            alert("Please Upload School Leaving Certificate");
                            return false;
                        }
                        else
                        {
                            school_cert_name = $('#lbl_school_Cert_file_name').text();
                        }
                    }


                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Certificate_upload_dtl",
                        async: false,
                        data: "{birth_filename:'" + birth_cert_name + "',school_leaving_filename:'" + school_cert_name + "',user_id : '" + $("#hdn_stud_code").val() + "',status:'" + status + "',dob:'" + $('#myDatePicker').val() + "'}",
                        dataType: "json",
                        success: function (data) {
                            if (data.d != "" && data.d != "[]") {
                                if (status == 'S') {
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
                bindtype();
                $("#myDatePicker").datepicker({
                    altField: "#dateHidden",
                    altFormat: "yy-mm-dd",
                    dateFormat: "dd-mm-yy",
                    onSelect: function (date) {
                        // Your CSS changes, just in case you still need them        
                    }
                });
            });

            function bindtype() {
                $('#drcertificate_type').empty().append($("<option></option>").val("").html("-- Please Select Type --"));
                $('#drcertificate_type').append($("<option></option>").val("B").html("Birth Certificate"));
                $('#drcertificate_type').append($("<option></option>").val("S").html("School Leaving Certificate"));

                $('#drcertificate_type').chosen();
            }

            function type_changes()
            {
                if ($('#drcertificate_type').val() == 'B')
                {
                    $('#birth_cert').css('display', 'block');
                    $('#school_cert').css('display', 'none');
                    $('#div_certi_dtl').css('display', 'none');
                }
                if ($('#drcertificate_type').val() == 'S') {
                    $('#birth_cert').css('display', 'none');
                    $('#school_cert').css('display', 'block');
                    $('#div_certi_dtl').css('display', 'block');
                }
               // alert();

            }

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
                            if (student_data[0]["dateofbirth"] != "")
                            {
                                $('#myDatePicker').val(student_data[0]["dateofbirth"]);
                            }
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
                            if (data.d != "" && data.d != "[]")
                            {
                                var origin = window.location.origin;
                                var details = JSON.parse(data.d);
                                var statustext = '';

                                if (details[0]["birth_certificate"] != "")
                                {
                                    $("#drcertificate_type").val('B');
                                    $('#drcertificate_type').trigger("liszt:updated");
                                    $('#birth_cert').css('display', 'block');
                                    $('#school_cert').css('display', 'none');
                                }
                                else if (details[0]["school_leaving_certificate"] != "")
                                {
                                    $("#drcertificate_type").val('S');
                                    $('#drcertificate_type').trigger("liszt:updated");
                                    $('#birth_cert').css('display', 'none');
                                    $('#school_cert').css('display', 'block');
                                }
                                
                                if (details[0]["is_submit"] == 'A')
                                {
                                    statustext = 'Submitted';
                                    $('#status').text('Submit');
                                    $('#birthCertUpload').attr("disabled", "disabled");
                                    $('#schoolCertUpload').attr("disabled", "disabled");
                                    $('#btnsubmit').attr("disabled", "disabled");
                                    $('#btnsave').attr("disabled", "disabled");
                                    $('#drcertificate_type').prop('disabled', true).trigger("liszt:updated");
                                }
                                else if (details[0]["is_submit"] == 'S')
                                {
                                    statustext = 'Saved';
                                    $('#status').text('Saved')
                                }

                                if (details[0]["birth_certificate"] != "" || details[0]["school_leaving_certificate"] != "") {


                                    var str = "<tr><th>Student Code</th><th>Student Name</th><th>Status</th><th>Certificate</th></tr>";
                                    str += "<tr><td>" + $("#hdn_stud_code").val() + "</td><td>" + $('#hdn_stud_name').val() + "</td><td>" + statustext + "</td>";

                                    if (details[0]["birth_certificate"] != '') {
                                        $('#lbl_birth_Cert_file_name').html('<b>' + details[0]["birth_certificate"] + '</b>');
                                        str += " <td><a href='" + origin + "\\BirthCertificate\\" + details[0]["birth_certificate"] + "' target='_blank'>Download</a></td> ";

                                    }
                                    else {
                                        $('#lbl_school_Cert_file_name').html('<b>' + details[0]["school_leaving_certificate"] + '</b>');
                                        str += " <td><a href='" + origin + "\\SchoolLeavingCertificate\\" + details[0]["school_leaving_certificate"] + "' target='_blank'>Download</a></td> ";
                                    }

                                    str += "</tr>";

                                    $('#tbl_certi_dtl').html(str);
                                    $('#div_certi_dtl').css('display', 'block');
                                }

                                

                            }
                            else {
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
                    var fileToUpload = GetFileNameFromPath($('#birthCertUpload').val());
                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                    if (CheckUserPhotoExtension(fileToUpload)) {

                        var flag = true;

                        if (filename != "" && filename != null) {

                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../../Handler/birthschoolvaccine.ashx',
                                    secureuri: false,
                                    fileElementId: 'birthCertUpload',
                                    data: { 'ICODE': $("#hdn_stud_code").val(), 'FNAME': 'Birth', 'LNAME': 'birth' },
                                    dataType: 'json',
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                            }
                                            else {
                                                $('#birthCertUpload').val("");
                                                $('#lbl_birth_Cert_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload
                                                bootbox.alert("Birth Certificate Upload Successfully");

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
                    var fileToUpload = GetFileNameFromPath($('#schoolCertUpload').val());
                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                    if (CheckUserPhotoExtension(fileToUpload)) {

                        var flag = true;

                        if (filename != "" && filename != null) {

                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../../Handler/birthschoolvaccine.ashx',
                                    secureuri: false,
                                    fileElementId: 'schoolCertUpload',
                                    data: { 'ICODE': $("#hdn_stud_code").val(), 'FNAME': 'School_Leaving', 'LNAME': 'school' },
                                    dataType: 'json',
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                            }
                                            else {
                                                $('#schoolCertUpload').val("");
                                                $('#lbl_school_Cert_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload
                                                bootbox.alert("School Leaving Certificate Upload Successfully");

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
                    <h1>Student Birth and School Leaving CertiFicate </h1>
                </div>
            </div>
            <%--<div style="display: block; font-weight: bold; color: black;font-family: Helvetica Neue,Helvetica,Arial,sans-serif;">
               
                <h4>Note :</h4>
        
        <p>Step 1: The examination should be done and a certificate to be signed by a registered family physician or allopathy doctor (having a minimum qualification of an MBBS degree or above) from whom certification needs to be done.</p>
       
        <p>Step 2: Click on the link to download the format to be followed for <a href="#" id="click_pdf">Medical Fitness Certificate</a>.</p>
       
        <p>Step 3: You are requested to upload your medical form on the following link.</p>
                <p style="color:red;">If you have any questions, please contact Student Services Office (SSO) Email: studentservices@cept.ac.in</p>
       
            </div>--%>

            <div class="row justify-content-center" style="padding-top: 25px;">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div id="div_thesis" style="display: block;">
                                    <div class="form-group row">
                                        <label class="col-md-4 col-form-label text-md-right">Date of Birth <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <input type="text" id="myDatePicker" class="marg-btm" placeholder="DD-MM-YYYY" />
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-md-4 col-form-label text-md-right">Certificate Type <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                             <select class="chosen-select" id="drcertificate_type" onchange="type_changes()"></select>
                                        </div>
                                    </div>

                                    <div class="form-group row" id="birth_cert" style="display:none;">
                                        <label class="col-md-4 col-form-label text-md-right" style="padding-top: 9px;">Upload Birth CertiFicate</br> <span style="color: blue;">(Max 5 MB)</span><span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <div style="padding: 10px; padding-left: 0px; overflow: visible;" class="panel-collapse collapse in">
                                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                    <span><strong>Choose File</strong></span>
                                                    <input type="file" name="birthCertUpload" id="birthCertUpload" onchange="javascript:return Uploadbirthcertificate();" style="display: none;">
                                                </label>
                                                <span id="lbl_birth_Cert_file_name" style="vertical-align: super;"></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group row" id="school_cert" style="display:none;">
                                        <label class="col-md-4 col-form-label text-md-right" style="padding-top: 9px;">School Leaving Certificate</br> <span style="color: blue;">(Max 5 MB)</span> <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <div style="padding: 10px; padding-left: 0px; overflow: visible;" class="panel-collapse collapse in">
                                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                    <span><strong>Choose File</strong></span>
                                                    <input type="file" name="schoolCertUpload" id="schoolCertUpload" onchange="javascript:return Uploadschoolcertificate();" style="display: none;">
                                                </label>
                                                <span id="lbl_school_Cert_file_name" style="vertical-align: super;"></span>
                                            </div>
                                        </div>


                                    </div>
                                    <div class="form-group row" style="display: block; padding-bottom: 14px;">

                                        <div class="col-md-6">
                                            <button class="btn btn-primary" id="btnsave">Save</button>
                                            <button class="btn btn-primary" id="btnsubmit">Submit</button>
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
                    <strong>Certificate Details</strong>
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

