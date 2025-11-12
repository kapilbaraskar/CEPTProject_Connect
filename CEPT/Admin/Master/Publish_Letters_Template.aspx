<%@ Page Title="Publish Letters Template" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Publish_Letters_Template.aspx.cs" Inherits="Admin_Master_Publish_Letters_Template" %>

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
           
            bindsemdata();
            bindyeardata_for_cross_reg();
            $('#drpinstructor').empty().append($("<option></option>").val("").html("-- Please Select  --"));

            bind_email_type();

            $(document).on("click", "#btn_get", function () {

                if ($('#drpinstructor').val() == "") {

                    alert("Please select Email type");
                    return false;
                }
                var type_inst = $('#drpinstructor').val();
                if ("AA_Letter" == type_inst || "TA_Letter" == type_inst || "TEA_Letter" == type_inst || "VF_Letter" == type_inst || "VF_Letter_PHD" == type_inst) {

                    if ($('#drpsemester').val() == "" && $('#drpyear').val() == "") {
                        alert("Please Select Semester and Year");
                        return false;
                    }
                }
                //if ($('#drptype').val() == "") {

                //    alert("Type is empty");
                //    return false;
                //}

                var instructor_type = $('#drpinstructor').val();
                var semester_type = $('#drpsemester').val();
                var year_type = $('#drpyear').val();
                //var type = $('#drptype').val();
                var type = "email";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    //url: "../../WebService.asmx/Get_VF_TA_AA_Letter_Email_Body",
                    url: "../../WebService.asmx/Get_Publish_Letter_Email_Body",
                    async: false,
                    data: "{instructor_type : '" + instructor_type + "',type : '" + type + "',semester:'" + semester_type + "',year:'" + year_type + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
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
                        else {
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
                var data = { 'instructor_type': '', 'type_content': '', 'subject': '', 'semester': '', 'year': '' };

                if ($('#drpinstructor').val() == "") {

                    alert("course is empty");
                    return false;
                }
                if (CKEDITOR.instances['body_content'].getData() == "") {

                    alert("Mail Body is empty");
                    return false;
                }
                var type_inst = $('#drpinstructor').val();
                if ("AA_Letter" == type_inst || "TA_Letter" == type_inst || "TEA_Letter" == type_inst || "VF_Letter" == type_inst || "VF_Letter_PHD" == type_inst) {

                    if ($('#drpsemester').val() == "" && $('#drpyear').val() == "") {
                        alert("Please Select Semester and Year");
                        return false;
                    }
                }

                debugger;
                data.instructor_type = $('#drpinstructor').val();
                // data.type_content = $('#drptype').val();
                data.type_content = "email";
                data.subject = $('#subject').val();
                // data.body = CKEDITOR.instances['body_content'].getData();
                var sub_body = CKEDITOR.instances['body_content'].getData();
                //data.body = sub_body;
                data.att_path = $('#reservation_upload_document_name').html();
                data.semester = $('#drpsemester').val();
                data.year = $('#drpyear').val();
                instructor_letter_email_data.push(data);
                var all_data = JSON.stringify(instructor_letter_email_data);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Update_Publish_Letter_Body",
                    async: false,
                    data: "{str_req_data: '" + all_data + "', sub_body:'" + sub_body + "' }",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var dataa = JSON.parse(data["d"]);
                            if (dataa["status"] == 'True') {
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



            $(document).on("click", "#savedata", function () {
                debugger;
                var instructor_letter_email_data = [];
                var data = { 'instructor_type': '', 'type_content': '', 'subject': '', 'semester_type': '', 'year_semester': '' };

                if ($('#drpinstructor').val() == "") {

                    alert("course is empty");
                    return false;
                }
                var type_inst = $('#drpinstructor').val();
                if ("AA_Letter" == type_inst || "TA_Letter" == type_inst || "TEA_Letter" == type_inst || "VF_Letter" == type_inst || "VF_Letter_PHD" == type_inst || "Extrenal_Students_Outside_India" == type_inst) {


                }
                //else {
                //    return false;
                //}
                if ($('#drpsemester').val() == "" && $('#drpyear').val() == "") {
                    alert("Please Select Semester and Year");
                    return false;
                }
                if (CKEDITOR.instances['body_content'].getData() == "") {

                    alert("Mail Body is empty");
                    return false;
                }


                data.instructor_type = $('#drpinstructor').val();
                // data.type_content = $('#drptype').val();
                data.type_content = "email";
                data.subject = $('#subject').val();//.replace(/"/g, '\'')
                var str_body = CKEDITOR.instances['body_content'].getData();
                //data.body = CKEDITOR.instances['body_content'].getData();
                data.att_path = $('#reservation_upload_document_name').html();
                data.semester_type = $('#drpsemester').val();
                data.year_semester = $('#drpyear').val();

                instructor_letter_email_data.push(data);
                var all_data = JSON.stringify(instructor_letter_email_data);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/insert_Publish_Letter_Body",
                    async: false,
                    data: "{str_req_data: '" + all_data + "',str_body: '" + str_body + "' }",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var dataa = JSON.parse(data["d"]);
                            if (dataa["status"] == 'True') {
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

        function bind_email_type() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_publish_letter_content_details",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var email_data = JSON.parse(data.d)

                        for (var i = 0; i < email_data.length; i++)
                        {
                            if (email_data[i]["email_type"] == 'TEA_Letter') {
                                $('#drpinstructor').append($("<option></option>").val(email_data[i]["email_type"]).html('Teaching Assistant'));
                            }
                            else if (email_data[i]["email_type"] == 'TA_Letter')
                            {
                                $('#drpinstructor').append($("<option></option>").val(email_data[i]["email_type"]).html('Teaching Associate'));
                            }
                            else
                            {
                                $('#drpinstructor').append($("<option></option>").val(email_data[i]["email_type"]).html(email_data[i]["email_desc"]));
                            }
                            
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Publish Letters Template
            </h1>
        </div>
         <div class="panel panel-default ">
            <div class="panel-heading">
                <%--<strong><span class="panel-headingfont">Retrieve Previous Year Course Data</span></strong></div>--%>
                <%--< Comment By Ananth>--%>
                <strong><span class="panel-headingfont">Selection Of Publish Letters Template</span></strong></div>
            <div style="padding: 15px;" id="div3">
               
                <div class="row">
                    <div class="form-group col-md-3">
                        <div class="col-md-4" style="padding: 0 0 0 0;">
                             Type :
                        </div>
                        <div class="col-md-6" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpinstructor" style="width:146%">
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-3">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Semester :
                        </div>
                        <div class="col-md-6" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpsemester">
                                
                            </select>
                        </div>
                    </div>
                    <div class="form-group col-md-3">
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            Year of allocation:
                        </div>
                        <div class="col-md-3" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="drpyear">     

                            </select>
                        </div>
                    </div>
                    <div class="row">
                         <table border="0" cellpadding="10" cellspacing="5" style="margin-left:21px;">
                            <tr>
                                <td>
                                    <button class="btn  btn-primary" type="button" id="btn_get">
                                 Get Data
                            </button>
                                </td>
                                <td>
                                    <button class="btn  btn-primary" type="button" id="savedata">
                                 Insert Data
                            </button>
                                </td>
                                <td>
                                    <button class="btn  btn-primary" type="button" id="btn_savedata">
                                 Update Data
                            </button>
                                </td>
                                
                            </tr>
                            
                        </table>

                        <%-- <div class="form-group col-md-12">
                        <div  class="form-group col-md-4">
                            
                        </div>
                        <div  class="form-group col-md-4">
                            <button class="btn  btn-primary" type="button" id="btn_savedata">
                                 Update Data
                            </button>
                        </div>
                             <div class="form-group col-md-4">
                            <button class="btn  btn-primary" type="button" id="savedata">
                                 Saved Data
                            </button>
                        </div>
                        </div>--%>
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

