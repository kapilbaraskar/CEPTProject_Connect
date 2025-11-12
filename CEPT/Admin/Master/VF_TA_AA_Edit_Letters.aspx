<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" 
    CodeFile="VF_TA_AA_Edit_Letters.aspx.cs" Inherits="Admin_Master_VF_TA_AA_Edit_Letters" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
  <link href="../../DesignCss/jquery.timepicker.css" rel="stylesheet" type="text/css" />
    <script src="../../DesignJS/ckeditor2/ckeditor.js" type="text/javascript"></script>
   
    <script src="../../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../../Js/jquery.timepicker.js" type="text/javascript"></script>

    <style>
        #cke_body_content {
        width:835px !important; 
        }
    </style>

    <script type="text/javascript">

        $(document).ready(function () {
            //CKEDITOR.replace('txtcourse_structure', {
            //    width: '1058px',
            //    height: '500px'


            //});
            //CKEDITOR.replace('txt_reference', {
            //    width: '1058px'

            //});
            $(document).on("click", "#btn_get", function () {

                if ($('#drpinstructor').val() == "") {

                    alert("Instructor is empty");
                    return false;
                }

                //if ($('#drptype').val() == "") {

                //    alert("Type is empty");
                //    return false;
                //}

                var instructor_type = $('#drpinstructor').val();
                //var type = $('#drptype').val();
                var type = "email";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_VF_TA_AA_Letter_Email_Body",
                    async: false,
                    data: "{instructor_type : '" + instructor_type + "',type : '" + type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            debugger;
                            var TypeDatedata = JSON.parse(data.d)
                            if (TypeDatedata != null && TypeDatedata != undefined) {

                                $('#subject').val(TypeDatedata[0].subject)
                                CKEDITOR.instances['body_content'].setData(TypeDatedata[0].body);
                                CKEDITOR.instances['body_content'].resize(1000, 600);
                                $('#Instruction').html(TypeDatedata[0].placeholder);
                                $('#reservation_upload_document_name').html(TypeDatedata[0].att_path);
                            }
                            else {

                            }


                        }
                        else
                        {
                            $('#subject').val('');
                            CKEDITOR.instances['body_content'].setData('');
                            CKEDITOR.instances['body_content'].resize(900, 302);
                            $('#Instruction').html('');
                            $('#reservation_upload_document_name').html('');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

            $(document).on("click", "#btn_savedata", function () {

                var instructor_letter_email_data = [];
                var data = { 'instructor_type': '', 'type_content': '', 'subject': '', 'body': '' };

                if ($('#drpinstructor').val() == "") {

                    alert("course is empty");
                    return false;
                }
                if (CKEDITOR.instances['body_content'].getData() == "") {

                    alert("Mail Body is empty");
                    return false;
                }
                data.instructor_type = $('#drpinstructor').val();
                // data.type_content = $('#drptype').val();
                data.type_content = "email";
                data.subject = $('#subject').val();
                data.body = CKEDITOR.instances['body_content'].getData();
                data.att_path = $('#reservation_upload_document_name').html();


                
                instructor_letter_email_data.push(data);
                var all_data = JSON.stringify(instructor_letter_email_data);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Update_VF_TA_AA_Letter_Email_Body",
                    async: false,
                    data: "{str_req_data: '" + all_data + "' }",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            debugger;
                            var dataa = JSON.parse(data["d"]);
                            if (dataa["status"]=='True') {
                                //alert(ResultObject.responseObjectInfo.Message);
                                bootbox.alert(dataa.message);
                            }
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });
        });

        

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Email Template
            </h1>
        </div>
         <div class="panel panel-default ">
            <div class="panel-heading">
                <%--<strong><span class="panel-headingfont">Retrieve Previous Year Course Data</span></strong></div>--%>
                <%--< Comment By Ananth>--%>
                <strong><span class="panel-headingfont">Selection of Email</span></strong></div>
            <div style="padding: 15px;" id="div3">
               
                <div class="row">
                    <div class="form-group col-md-3">
                        <div class="col-md-4" style="padding: 0 0 0 0;">
                             Type :
                        </div>
                        <div class="col-md-6" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpinstructor" style="width:146%">
                                <option value="">--- Please Select  ---</option>
                                    <option value="VF">VF</option>
                                    <option value="TA">TA</option>
                                    <option value="AA">AA</option>
                                    <option value="TEA">TEA</option>
                                    <option value="Feedback">Feedback</option> 
                            </select>
                        </div>
                    </div>
                    <%--<div class="form-group col-md-3">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Type :
                        </div>
                        <div class="col-md-9" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drptype">
                                <option value="">--- Please Select  ---</option>
                                    <option value="email">Email</option>
                            </select>
                        </div>
                    </div>--%>
                    <div class="row">
                         <div class="form-group col-md-4">
                        <div  class="form-group col-md-3">
                            <button class="btn  btn-primary" type="button" id="btn_get">
                                 Get Data
                            </button>
                        </div>
                        <div  class="form-group col-md-4">
                            <button class="btn  btn-primary" type="button" id="btn_savedata">
                                 Save Data
                            </button>
                        </div>
                        </div>
                    </div>  
                </div>
            </div>
        </div>
        <div class="panel-body" style="margin-top:10px;border: 1px solid #ddd;">
            <div class="row">
                <div class="form-group col-md-12">
                    <%-- <a href="" class="btn btn-success" id="btn_get">GetData
                </a>--%>
                    <%--<input type="button" class="btn btn-success" id="btn_get" value="GetData"/>--%>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12">
                    <label for="text1" class="control-label">
                        Subject</label>

                    <input type="text" id="subject" style="width: 822px;" />
                </div>
            </div>
            <div class="row">
                <div class="form-group col-md-12">
                    <label for="text1" class="control-label">
                        Email body</label>
                    <textarea rows="200" cols="200" id="body_content" class="ckeditor">
                   </textarea>
                    <div id="Instruction" style="float: right;margin-right: 3%;margin-top: -46%;color: red;">
                </div>
                </div>
                
            </div>
            <div class="row" id="attach_file" style="display:none">
                <div class="form-group col-md-3">
                    <label>Attach file </label>
                    <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                        onchange="javascript:return UploadReservationCertificate();" />
                </div>
                <div class="form-group col-md-3">
                    <label id="reservation_upload_document_name">
                    </label>
                </div>
            </div>
                </div>
    </div>
</asp:Content>

