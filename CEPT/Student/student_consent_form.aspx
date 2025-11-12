<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="student_consent_form.aspx.cs" Inherits="Student_student_consent_form" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <style>
         body {
  overflow: hidden; /* Hide scrollbars */
}
    </style>
    <script type="text/javascript">

        $(document).ready(function () {
            get_student_dtl();
            bindyeardata_for_cross_reg();
            get_user_detail();
            bindtype();
            $('#student_code').val($("#hdn_stud_code").val());
            $('#click_pdf').click(clickevent);
            function clickevent() {
                var url = location.origin + "\\" + "ConsentForm\\Parental Consent Form.pdf";
                window.open(url, "_black");
              
            }
            $('#btnsubmit').on('click', function () {
                save_dtl('A');

            });
            function save_dtl() {
                debugger;
                var type = "";
                var consent_name = "";

                if ($('#drstudio_type').val() == "")
                {
                    alert("Please Select Studio Type");
                    return false;
                }
                else {
                    type = $('#drstudio_type').val();
                }
                if ($('#drstudio_type').val() == "Partial On-Campus") {
                    if ($('#lbl_consent_form_name').text() != "")
                    {
                        consent_name = $('#lbl_consent_form_name').text();
                    }
                    else {
                        alert("Please Upload Consent Form");
                        return false;
                    }
                }


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/consent_form_upload_dtl",
                    async: false,
                    data: "{consent_from_name:'" + consent_name + "',studio_type:'" + type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            alert("Consent Form Submit Successfully");
                        }
                        else {

                        }

                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }


        });

        function bindtype() {
            $('#drstudio_type').empty().append($("<option></option>").val("").html("-- Please Select Studio --"));
            $('#drstudio_type').append($("<option></option>").val("Online").html("Online"));
            $('#drstudio_type').append($("<option></option>").val("Partial On-Campus").html("Partial On-Campus"));

            $('#drstudio_type').chosen();
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
                    url: "../../WebService.asmx/Get_student_parental_consent_dtl",
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            var origin = window.location.origin;
                            var details = JSON.parse(data.d);
                            var statustext = '';

                            for (var i = 0; i < details.length; i++)
                            {
                                if (details[i]["consent_status"] == 'A')
                                {
                                    statustext = 'Submitted';
                                    $('#status').text('Submit');

                                    if ($('#hdn_current_sem').val() == details[i]["semester_type"] && $('#hdn_current_year').val() == details[i]["year_semester"])
                                    {
                                        $('#consentformCertUpload').attr("disabled", "disabled");
                                        $('#btnsubmit').attr("disabled", "disabled");
                                        // $('#btnsave').attr("disabled", "disabled");

                                        $("#drstudio_type").val(details[i]["studio_type"]);
                                        $('#drstudio_type').prop('disabled', true).trigger("liszt:updated");
                                        $('#lbl_consent_form_name').html('<b>' + details[i]["consent_form_path"] + '</b>');
                                    }
                                    


                                    //if (details[i]["studio_type"] == "Partial On-Campus")
                                    //{
                                    //    $('#birth_cert').css('display', 'block');
                                    //}
                                    //else {
                                    //    $('#birth_cert').css('display', 'none');
                                    //}
                                    if (i == 0)
                                    {
                                        var str = "<tr><th>Student Code</th><th>Student Name</th><th>Studio Type</th><th>Status</th><th>Consent Form</th><th>Semester</th><th>Year</th></tr>";
                                    }
                                    
                                    str += "<tr><td>" + $("#hdn_stud_code").val() + "</td><td>" + $('#hdn_stud_name').val() + "</td><td>" + details[i]["studio_type"] + "</td><td>" + statustext + "</td>";

                                    if (details[i]["consent_form_path"] != '')
                                    {
                                        //$('#lbl_consent_form_name').html('<b>' + details[i]["consent_form_path"] + '</b>');
                                        str += " <td><a href='" + origin + "\\ConsentForm\\" + details[i]["consent_form_path"] + "' target='_blank'>Download</a></td> ";

                                    }
                                    else {
                                        str += "<td></td>";
                                    }


                                    str += "<td>" + details[i]["semester_code"] + "</td><td>" + details[i]["year_semester"] + "</td></tr>";

                                    
                                }
                            }
                            $('#tbl_certi_dtl').html(str);
                            $('#div_certi_dtl').css('display', 'block');
                            $('#birth_cert').css('display', 'block');
                          



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

        function bindyeardata_for_cross_reg() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                data: "{type :'all'}",
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)
                        $('#hdn_current_sem').val(year_data[0]['sem_code']);
                        $('#hdn_current_year').val(year_data[0]['year_code']);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function Uploadconsentform() {
            try {
                //var d = new Date();
                var fileToUpload = GetFileNameFromPath($('#consentformCertUpload').val());
                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/birthschoolvaccine.ashx',
                                secureuri: false,
                                fileElementId: 'consentformCertUpload',
                                data: { 'ICODE': $("#hdn_stud_code").val(), 'FNAME': $("#hdn_current_sem").val() + '_' + $("#hdn_current_year").val(), 'LNAME': 'consent' },
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#consentformCertUpload').val("");
                                            $('#lbl_consent_form_name').html('<b>' + data.upfile + '</b>');//fileToUpload
                                            bootbox.alert("Consent Form Upload Successfully");

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

        function type_changes()
        {
            if ($('#drstudio_type').val() == 'Partial On-Campus') {
                $('#birth_cert').css('display', 'block');
            }
            else
            {
                $('#birth_cert').css('display', 'none');
            }
            
            // alert();

        }
     

    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <main class="my-form">
        <div class="cotainer">
            <div class="row-fluid">
                <div class="page-header position-relative">
                    <h1>Parental Consent Form</h1>
                </div>
            </div>
            <div class="row justify-content-center" style="padding-top: 25px;">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <div id="div_thesis" style="display: block;">
                                    <div class="form-group row">
                                        <label class="col-md-4 col-form-label text-md-right">Studio Type <span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6"> <%--onchange="type_changes()"--%>
                                            <select class="chosen-select" id="drstudio_type" onchange="type_changes()"></select>
                                        </div>
                                    </div>

                                    <div class="form-group row" id="birth_cert" style="display: none;">
                                         
                                        <p style="padding-left: 2.5%;padding-top: 10px;"> Download: <a href="#" id="click_pdf">Consent Form</a> </p>
                                          
                                        <label class="col-md-4 col-form-label text-md-right" style="padding-top: 9px;">Upload Consent Form</br> <span style="color: blue;">(Max 5 MB)</span><span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <div style="padding: 10px; padding-left: 0px; overflow: visible;" class="panel-collapse collapse in">
                                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                    <span><strong>Choose File</strong></span>
                                                    <input type="file" name="consentformCertUpload" id="consentformCertUpload" onchange="javascript:return Uploadconsentform();" style="display: none;">
                                                </label>
                                                <span id="lbl_consent_form_name" style="vertical-align: super;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row" style="display: block; padding-bottom: 14px;">

                                        <div class="col-md-6">
                                            <%--<button class="btn btn-primary" id="btnsave">Save</button>--%>
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
                    <strong>Parental Consent Form Details</strong>
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
    <input type="hidden" id="hdn_current_sem" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_current_year" runat="server" clientidmode="Static" />
</asp:Content>

