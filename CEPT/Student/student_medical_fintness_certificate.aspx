<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="student_medical_fintness_certificate.aspx.cs" Inherits="Student_student_medical_fintness_certificate" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script>
    {
        $(document).ready(function () 
        {
            get_student_dtl();
            get_user_detail();                                                        
            $('#student_code').val($("#hdn_stud_code").val());
            $('#click_pdf').click(clickevent);
            function clickevent() 
            {
             $("#btnDownloadCertificate").click();
            }

            $('#btnsubmit').on('click', function () 
            {
            
                            if($('#lbl_medical_Cert_file_name').text() == "")
                            {
                            bootbox.alert("Please Upload Medical Fitness Certificate");
                            return false;
                            }
                            $.ajax({
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            url: "../../WebService.asmx/MedicalCertificate_upload_dtl",
                            async: false,
                            data: "{FileName:'"+$('#lbl_medical_Cert_file_name').text()+"',user_id : '" + $("#hdn_stud_code").val() + "',type:'M'}",
                            dataType: "json",
                            success: function (data) {
                                if (data.d != "" && data.d != "[]") 
                                {
                                alert("Medical Fitness Certificate Submit Successfully");
                                
                                }
                                else {
            
                                }
            
                            },
                            error: function (result) {
                                alert(result);
                            }
                          });
                     });
                 });
    
                function get_student_dtl() 
                {
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
                    url: "../../WebService.asmx/get_medical_antiragging_dtl",
                    data: "{student_code:'" + $("#hdn_stud_code").val() +"',type:'',prog_code:'',dept_code:'',year_code:''}",
                    dataType: "json",
                    success: function (data) { 
                        if (data.d != "" && data.d != "[]") 
                        {
                        
                        //var details = JSON.parse(data.d);
                        //  //details[0]["is_submit"]//details[0]["remark"]
                        //   if(details[0]["is_submit"] == 'A')
                        //    { $('#status').text('Approved');$('#medicalCertUpload').attr("disabled","disabled");}
                        //    else if(details[0]["is_submit"] == 'R')
                        //    {$('#status').text('Rejected')} //
                        //    if(details[0]["remark"] != "")
                        //    {  $('#remark_div').css('display','block');   
                        //       $('#remark').val(details[0]["remark"]);
                        //    }
                        //
                        //    if(details[0]["file_path"] !=''){
                        //     $('#lbl_medical_Cert_file_name').html('<b>' + details[0]["file_path"] + '</b>');
                        //      $('#download_div').css('display','block');}//
                           var origin   = window.location.origin;              
                            //window.open(origin + '\\' + 'Antiragging' + '\\' + $('#lbl_medical_Cert_file_name').text(),"_blank");
                            var details = JSON.parse(data.d);
                            
                            
                            var str = "<tr><th>Student Code</th><th>Student Name</th><th>Year</th><th>Remark</th><th>Status</th><th>Action</th></tr>";
                            for (var i = 0; i < details.length; i++) {

                                var statustext = '';
                                if (details[i]["is_submit"] == 'A')
                                {
                                    statustext = 'Approved';
                                    $('#status').text('Approved');
                                    //$('#medicalCertUpload').attr("disabled", "disabled");
                                    //$('#btnsubmit').attr("disabled", "disabled");
                                }
                                else if (details[0]["is_submit"] == 'R')
                                {
                                    statustext = 'Rejected'; $('#status').text('Rejected')
                                }
                                else {
                                    statustext = 'In-Progress';
                                }


                                str += "<tr><td>" + $("#hdn_stud_code").val() + "</td><td>" + $('#hdn_stud_name').val() + "</td><td>" + details[i]["year_code"] + "</td><td>" + details[i]["remark"] + "</td><td>" + statustext + "</td><td><a href='" + origin + "\\MedicalCertificate\\" + details[i]["file_path"] + "' target='_blank'>Download</a></td></tr>";
                            }

                            
                            $('#tbl_certi_dtl').html(str);
                            $('#div_certi_dtl').css('display','block'); 
                            
                                                  

                            //
                            //if(details[0]["remark"] != "")
                            //{  $('#remark_div').css('display','block');   
                            //   $('#remark').val(details[0]["remark"]);
                            //}
                            //
                            if (details[0]["file_path"] != '')
                            {
                             //$('#lbl_medical_Cert_file_name').html('<b>' + details[0]["file_path"] + '</b>');
                             // $('#download_div').css('display','block');
                            }//
                            
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

            function Uploadfeesslip() {
            try {
                //var d = new Date();
                var fileToUpload = GetFileNameFromPath($('#medicalCertUpload').val());
                var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));

                if (CheckUserPhotoExtension(fileToUpload)) {

                    var flag = true;

                    if (filename != "" && filename != null) {

                        if (flag == true) {
                            $("#UploadingProgress").fadeIn(200);
                            $.ajaxFileUpload({
                                url: '../../Handler/student_medical_certificate.ashx',
                                secureuri: false,
                                fileElementId: 'medicalCertUpload',
                                data: { 'ICODE': $("#hdn_stud_code").val(), 'FNAME': 'MEDICAL', 'LNAME': 'medical' },
                                dataType: 'json',
                                success: function (data, status) {
                                    if (typeof (data.error) != 'undefined') {
                                        if (data.error != '') {
                                            alert(data.error);
                                        }
                                        else {
                                            $('#medicalCertUpload').val("");
                                            $('#lbl_medical_Cert_file_name').html('<b>' + data.upfile + '</b>');//fileToUpload
                                            bootbox.alert("Medical Fitness Certificate Upload Successfully");
                                            //$('#hdn_fees_file_name').val(data.upfile);
                                            //FileName = data.upfile;
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
                    <h1>Student Medical Fitness CertiFicate </h1>
                </div>
            </div>
            <div style="display: block; font-family: Helvetica Neue,Helvetica,Arial,sans-serif;">
                <%--<h5>Note :</h5>
                <ul>
                    <li>Download <a href="#" id="click_pdf">Certificate</a></li>
                </ul>--%>
                <h4>Note :</h4>
        
        <p>Step 1: The examination should be done and a certificate to be signed by a registered family physician or allopathy doctor (having a minimum qualification of an MBBS degree or above) from whom certification needs to be done.</p>
        <%--<p>Step 1: You Can Download Medical Fitness Certificate. Click on <a href="#" id="click_pdf">Download Certificate</a>.</p>--%>
        <p>Step 2: Click on the link to download the format to be followed for <a href="#" id="click_pdf">Medical Fitness Certificate</a>.</p>
       <%-- <p>Step 2: Fill the All Information then Upload Medical Fitness Certificate.</p>--%>   
        <p>Step 3: You are requested to upload your medical form on the following link.</p>
                <p style="color:red;">If you have any questions, please contact Student Services Office (SSO) Email: studentservices@cept.ac.in</p>
        <%--<p style="color:red;">Note: Approved Your Medical Fitness Certificate Then you can not upload Medical Fitness Certificate.</p>--%>
            </div>

            <div class="row justify-content-center" style="padding-top: 25px;">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                 <%--<div class="form-group row">
                                    <label for="stu_code" class="col-md-4 col-form-label text-md-right">Student Code</label>
                                    <div class="col-md-6">
                                        <input type="text" id="student_code" class="form-control" name="Student Code" disabled="disabled">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="full_name" class="col-md-4 col-form-label text-md-right">Student Name</label>
                                    <div class="col-md-6">
                                        <input type="text" id="student_name" class="form-control" name="Student Name" disabled="disabled">
                                    </div>
                                </div>
                               <div class="form-group row" style="padding-bottom: 10px;">
                                    <label for="stu_code" class="col-md-4 col-form-label text-md-right">Status</label>
                                    <div class="col-md-6">
                                     <label id="status" style="color:red;">Pending</label>   
                                    </div>
                                </div>
                                 
                                <div class="form-group row" style="display:none;" id="remark_div">
                                    <label for="stu_code" class="col-md-4 col-form-label text-md-right">Remark</label>
                                    <div class="col-md-6">
                                         <input type="text" id="remark" class="form-control" name="Remark" style="width: 600px; height: 50px;" disabled="disabled">
                                     
                                    </div>
                                </div>--%>
                               

                                <div id="div_thesis" style="display: block;">
                                    <div class="form-group row">
                                        <label for="fees_slip" class="col-md-4 col-form-label text-md-right">Upload Medical Fitness CertiFicate <span style="color:blue;">(Max 5 MB)</span><span class="cls_mendatory" style="color: Red;">*</span></label>
                                        <div class="col-md-6">
                                            <div style="padding: 10px;padding-left: 0px; overflow: visible;" id="div_upload_fees_slip" class="panel-collapse collapse in">
                                                <label class="btn btn-primary file-upload " style="vertical-align: bottom;">
                                                    <span><strong>Choose File</strong></span>
                                                    <input type="file" name="medicalCertUpload" id="medicalCertUpload" onchange="javascript:return Uploadfeesslip();" style="display: none;" >
                                                </label>
                                                <span id="lbl_medical_Cert_file_name" style="vertical-align: super;"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row" style="display:block;padding-bottom: 14px;">
                                    
                                    <div class="col-md-6">
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
                    <strong>Medical Fitness Certificate Details</strong>
                </div>
                <div>
                    <table id="tbl_certi_dtl" class="table table-bordered">
                    </table>
                </div>
            </div>
        </div>
        </main>
    <asp:Button ID="btnDownloadCertificate" runat="server" Text="Download" Style="display: none;" OnClick="btnDownloadCertificate_Click" ClientIDMode="Static" />
    <input type="hidden" id="hdn_stud_code" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_file_path" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_stud_name" runat="server" clientidmode="Static" />
</asp:Content>

