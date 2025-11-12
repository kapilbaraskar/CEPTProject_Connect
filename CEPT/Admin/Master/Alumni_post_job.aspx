<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Alumni_post_job.aspx.cs" Inherits="Admin_Master_Alumni_post_job" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        tr.highlight td div {
            margin-top: 10px;
        }

        #cke_txtarea_desc, #cke_txt_profile_desc, #cke_txt_requirements {
            width: 100% !important;
        }
    </style>
    <script src="../../DesignJS/ckeditor2/ckeditor.js" type="text/javascript"></script>

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Post Job
            </h1>
        </div>
        <div>
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong>Post Job</strong>
                </div>
                <div style="padding: 15px;">
                    <table id="tbl_personal_detail1" style="width: 100%;">
                        <tr>
                            <td style="width: 20%;">Job Title
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_job_title" />
                            </td>
                            <td style="width: 20%;">Due Date
                            </td>
                            <td style="width: 30%;">
                                <input type="date" id="txt_Due_Date" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">City
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_city" />
                            </td>
                            <td style="width: 20%;">State
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_state" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Professional Area
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_pro_area" />
                            </td>
                            <td style="width: 20%;">Experience
                            </td>
                            <td style="width: 30%;">
                                <input type="number" id="txt_experience" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Salary
                            </td>
                            <td style="width: 30%;">
                                <input type="number" id="txt_salary" />
                            </td>
                            <td style="width: 20%;">Organization
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_org" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Contact Person
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_contact_person" />
                            </td>


                            <td style="width: 20%;">Organization Website
                            </td>
                            <td colspan="3" style="padding-top: 12px;">
                                <input type="text" id="txt_website" />
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 20%;">Contact Number 
                            </td>
                            <td style="width: 30%;">
                                <input type="number" id="txt_contact_no" />
                            </td>
                            <td style="width: 20%;">Email Id
                            </td>
                            <td style="width: 30%;">
                                <input type="text" id="txt_email_id" />
                            </td>
                        </tr>

                        <tr>
                            <td colspan="4">&nbsp;</td>
                        </tr>
                        <tr class="highlight">
                            <td>Firm Description
                            </td>
                            <td colspan="3"></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <textarea rows="4" cols="50" id="txtarea_desc" class="ckeditor">
                                    </textarea>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="4">&nbsp;</td>
                        </tr>
                        <tr class="highlight">
                            <td colspan="3">Profile Description/Responsibilities
                            </td>
                            <%--<td colspan="2" ></td>--%>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <textarea rows="4" cols="50" id="txt_profile_desc" style="width: 86%!important" class="ckeditor">
                                    </textarea>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="4">&nbsp;</td>
                        </tr>
                        <tr class="highlight">
                            <td>Qualification & Qualities
                            </td>
                            <td colspan="3"></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <textarea rows="4" cols="50" id="txt_requirements" style="width: 86%" class="ckeditor">
                                    </textarea>
                            </td>
                        </tr>
                        <tr class="highlight">
                        </tr>

                    </table>
                </div>
            </div>

            <div style="margin-top: 30px;" align="center">
                <button id="btn_save" type="button" class="btn btn-lg btn-primary" style="margin-left: -60px;">
                    Submit</button>

                <button id="btn_publish" type="button" class="btn btn-lg btn-primary" style="margin-left:0px;">
                    Publish</button>
            </div>
        </div>
    </div>
    <input type="hidden" runat="server" clientidmode="Static" id="hdn_login_email" />
    <input type="hidden" id="hdn_doc_no" />
    <script>

        $(document).ready(function () {
            debugger;
            var doc_no = getParameterByName('doc_no');
            if (doc_no != null) {
                get_alumni_data(doc_no);
            }

            $('#btn_save').on('click', function () {
                save_alumni_personal_data();
            });
            $('#btn_publish').on('click', function () {
                save_alumni_personal_data_publish();    
            })
        });

        function getParameterByName(name, url) {
            if (!url) url = window.location.href;
            name = name.replace(/[\[\]]/g, "\\$&");
            var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return '';
            return decodeURIComponent(results[2].replace(/\+/g, " "));
        }

        function get_alumni_data(no) {
            debugger;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_alumni_job_data",
                async: false,
                data: '{doc_no:"' + no + '"}',
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var response = JSON.parse(data.d);

                        display_data(response);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function display_data(data) {

            $('#txt_job_title').val(data[0].job_title);
            $('#txt_Due_Date').val(data[0].test);
            $('#txt_city').val(data[0].city);

            $('#txt_state').val(data[0].state);
            $('#txt_pro_area').val(data[0].professional_area);
            $('#txt_experience').val(data[0].experience);
            $('#txt_salary').val(data[0].salary);
            $('#txt_org').val(data[0].organization);
            $('#txtarea_desc').val(data[0].description);
            $('#txt_website').val(data[0].organization_website)
            $('#hdn_doc_no').val(data[0].Doc_no);
            $('#txt_profile_desc').val(data[0].profile_description);
            $('#txt_requirements').val(data[0].requirements);
            $('#txt_contact_person').val(data[0].contact_person);
            $('#txt_email_id').val(data[0].Email_id);
            $('#txt_contact_no').val(data[0].contact_Number);
        }
        function save_alumni_personal_data() {
            debugger;
            if ($('#txt_job_title').val() == "") {
                alert("Please Enter Job Title");
                return false;
            }
            var obj_data = {};
            obj_data.Doc_no = $('#hdn_doc_no').val();
            obj_data.job_title = $('#txt_job_title').val();
            obj_data.due_date = $('#txt_Due_Date').val();
            obj_data.city = $('#txt_city').val();
            obj_data.state = $('#txt_state').val();
            obj_data.professional_area = $('#txt_pro_area').val();
            obj_data.experience = $('#txt_experience').val();
            obj_data.salary = $('#txt_salary').val();
            obj_data.organization = $('#txt_org').val();
            obj_data.contact_person = $('#txt_contact_person').val();
            obj_data.Email_id = $('#txt_email_id').val();
            obj_data.contact_Number = $('#txt_contact_no').val();
            obj_data.is_publish = "N";
            obj_data.organization_website = $('#txt_website').val();

            if (CKEDITOR.instances.txtarea_desc.getData() == "") {
                obj_data.description = "";
            }
            else {
                obj_data.description = CKEDITOR.instances.txtarea_desc.getData();
            }
            if (CKEDITOR.instances.txt_profile_desc.getData() == "") {
                obj_data.profile_description = "";
            }
            else {
                obj_data.profile_description = CKEDITOR.instances.txt_profile_desc.getData();
            }
            if (CKEDITOR.instances.txt_requirements.getData() == "") {
                obj_data.requirements = "";
            }
            else {
                obj_data.requirements = CKEDITOR.instances.txt_requirements.getData();
            }


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_alumni_post_job",
                async: false,
                data: "{str_req_data:'" + JSON.stringify(obj_data) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var response = JSON.parse(data.d);

                        if (response['status'] == 'True') {
                            bootbox.alert(response['message'], function () {
                                location.reload();
                            });
                        }
                        else if (response['status'] == 'False') {
                            bootbox.alert(response['message']);
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function save_alumni_personal_data_publish() {
            debugger;
            if ($('#txt_job_title').val() == "") {
                alert("Please Enter Job Title");
                return false;
            }
            var obj_data = {};
            obj_data.Doc_no = $('#hdn_doc_no').val();
            obj_data.job_title = $('#txt_job_title').val();
            obj_data.due_date = $('#txt_Due_Date').val();
            obj_data.city = $('#txt_city').val();
            obj_data.state = $('#txt_state').val();
            obj_data.professional_area = $('#txt_pro_area').val();
            obj_data.experience = $('#txt_experience').val();
            obj_data.salary = $('#txt_salary').val();
            obj_data.organization = $('#txt_org').val();
            obj_data.contact_person = $('#txt_contact_person').val();
            obj_data.Email_id = $('#txt_email_id').val();
            obj_data.contact_Number = $('#txt_contact_no').val();
            obj_data.is_publish = "Y";
            obj_data.organization_website = $('#txt_website').val();

            if (CKEDITOR.instances.txtarea_desc.getData() == "") {
                obj_data.description = "";
            }
            else {
                obj_data.description = CKEDITOR.instances.txtarea_desc.getData();
            }
            if (CKEDITOR.instances.txt_profile_desc.getData() == "") {
                obj_data.profile_description = "";
            }
            else {
                obj_data.profile_description = CKEDITOR.instances.txt_profile_desc.getData();
            }
            if (CKEDITOR.instances.txt_requirements.getData() == "") {
                obj_data.requirements = "";
            }
            else {
                obj_data.requirements = CKEDITOR.instances.txt_requirements.getData();
            }


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_alumni_post_job",
                async: false,
                data: "{str_req_data:'" + JSON.stringify(obj_data) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var response = JSON.parse(data.d);

                        if (response['status'] == 'True') {
                            bootbox.alert(response['message'], function () {
                                location.reload();
                            });
                        }
                        else if (response['status'] == 'False') {
                            bootbox.alert(response['message']);
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

