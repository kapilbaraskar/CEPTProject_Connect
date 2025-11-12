<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="alumni_report.aspx.cs" Inherits="Admin_Report_alumni_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White; padding: 13px;">


        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <%--class="panel-body"--%>

                <table border="0" cellpadding="10" cellspacing="5">

                    <tr>
                        <td class="cls_dept_prog">Department
                        </td>
                        <td class="cls_dept_prog">
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>Enrollment Year
                        </td>
                        <td>
                            <select class="chosen-select" id="drpenrollmentyear">
                            </select>
                        </td>
                        <td>Programme
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog">
                            </select>
                        </td>


                    </tr>
                    <tr style="text-align: center;">
                        <td>RegisterBy
                        </td>
                        <td>
                            <select class="chosen-select" id="reg_by">
                                <option value="">--Select Register By--</option>
                                <option value="AD">Admin</option>
                                <option value="AL">Alumni</option>
                            </select>
                        </td>
                        <td>ID Card requested
                        </td>
                        <td>
                            <select class="chosen-select" id="id_card_request">
                                <option value="">--Select requested--</option>
                                <option value="Y">Yes</option>
                                <option value="N">No</option>
                            </select>
                        </td>

                        <td>verified/unverified status
                        </td>
                        <td>
                            <select class="chosen-select" id="ver_status">
                                <option value="">--Select status--</option>
                                <option value="Y">Yes</option>
                                <option value="N">No</option>
                            </select>
                        </td>
                    </tr>

                    <tr style="text-align: center;">
                    </tr>
                    <tr style="text-align: center;">
                        <td></td>
                        <td colspan="2" style="display:none;">
                            <asp:Button ID="btn_download_all" class="btn btn-primary" runat="server" Text="Download All"
                                OnClick="Button1_Click" />
                        </td>
                        <td>
                            <button class="btn btn-primary" type="button" id="btnreterive">
                                Retrieve
                            </button>


                        </td>
                    </tr>
                </table>

            </div>
        </div>
        <div id="DataList" class="panel panel-default" style="overflow: auto;">
            <div id="studiocourse" class="tab-pane">
                <div>
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
        <table style="width: 100%; margin-top: 10px;">
            <tr>
                <td align="center" style="padding-left: 75px;">
                    <button id="btnsave" type="button" style="display: none" class="btn btn-lg btn-primary">
                        <i class="icon-save bigger-160"></i>Save
                    </button>
                </td>
            </tr>
        </table>
        <div style="display: none;">
            <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="Download_Form" />

        </div>
        <input type="hidden" id="hdn_userid" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_drpdepartment" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_drpenrollmentyear" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_drpprog" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_reg_by" runat="server" clientidmode="Static" />

        <input type="hidden" id="hdn_id_card_request" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_ver_status" runat="server" clientidmode="Static" />

    </div>
    <script>
        var oTable1;
        var student_data = '';
        var course_instructor_data = '';
        var student_saved_data = '';
        var course_saved_data = '';
        var instructor_group_saved_data = '';

        $(document).ready(function () {
            binddepartment();
            bindEnrollmentyeardata();
            bindprogramme();

            $("#btnreterive").click(function () {

                $("#hdn_drpdepartment").val($('#drpdepartment').val());
                $("#hdn_drpenrollmentyear").val($('#drpenrollmentyear').val());
                $("#hdn_drpprog").val($('#drpprog').val());
                $("#hdn_reg_by").val($('#reg_by').val());
                $("#hdn_id_card_request").val($('#id_card_request').val());
                $("#hdn_ver_status").val($('#ver_status').val());
                databind();
            });

        });
        function databind() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_alumni_data_for_report",
                async: false,
                data: "{year_code:'" + $('#drpenrollmentyear').val() + "' ,dept_code:'" + $('#drpdepartment').val() + "',prog_code:'" + $('#drpprog').val() + "',regby:'" + $('#reg_by').val() + "',id_card_req:'" + $('#id_card_request').val() + "',ver_status:'" + $('#ver_status').val() + "'}",
                dataType: "json",
                success: function (data) {
                    //   display_data(data.d);
                    debugger;

                    if (data.d != "") {

                        display_data(data.d);
                    }
                    else {
                        bootbox.alert("No data found for verification");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

        }
        function display_data(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList").html('<div class="panel-heading"><strong><span class="panel-headingfont">Select Student Group</span></strong></div> <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                                //"copy",
                                    "print",
                                    {
                                        "sExtends": "collection",
                                        "sButtonText": 'Export',
                                        "aButtons": ["xls"]
                                    }
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                                { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                                { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
                                { "sTitle": "First Name", "mData": "first_name", "bSortable": false },
                                { "sTitle": "Middle Name", "mData": "middle_name", "bSortable": false },
                                { "sTitle": "Last Name", "mData": "last_name", "bSortable": false },
                                { "sTitle": "Year of Enrollment", "mData": "year_desc", "bSortable": false },
                                { "sTitle": "Program Title", "mData": "prog_level_name", "bSortable": false },
                                { "sTitle": "Date of birth", "mData": "date_of_birth", "bSortable": false },
                                  { "sTitle": "Email", "mData": "mail", "bSortable": false },
                              { "sTitle": "Alternate Email", "mData": "alternate_mail", "bSortable": false },
                                { "sTitle": "Mobile No", "mData": "mobile_no", "bSortable": false },
                                { "sTitle": "Occupation", "mData": "occupation", "bSortable": false },
                                { "sTitle": "Designation", "mData": "title", "bSortable": false },
                                { "sTitle": "Organisation", "mData": "organisation", "bSortable": false },
                                { "sTitle": "Work Address Line 1", "mData": "work_address", "bSortable": false },
                                { "sTitle": "Work Address Line 2", "mData": "work_address_line_2", "bSortable": false },
                                { "sTitle": "Work Address Line 3", "mData": "work_address_line_3", "bSortable": false },
                                { "sTitle": "Work City", "mData": "work_city", "bSortable": false },
                                { "sTitle": "Work State", "mData": "workstate", "bSortable": false },
                                { "sTitle": "Work Country", "mData": "work_country", "bSortable": false },
                                { "sTitle": "work pincode", "mData": "work_pincode", "bSortable": false },
                                { "sTitle": "Work Phone", "mData": "work_phone", "bSortable": false },
                                { "sTitle": "Work Email", "mData": "work_email", "bSortable": false },
                                { "sTitle": "Home Address", "mData": "home_address", "bSortable": false },
                                { "sTitle": "home address line 1", "mData": "home_address_line_1", "bSortable": false },
                                { "sTitle": "home address line 2", "mData": "home_address_line_2", "bSortable": false },
                                { "sTitle": "home address line 3", "mData": "home_address_line_3", "bSortable": false },
                                { "sTitle": "Home City", "mData": "home_city", "bSortable": false },
                                { "sTitle": "Home State", "mData": "homestate", "bSortable": false },
                                { "sTitle": "Home Country", "mData": "homecountry", "bSortable": false },
                                { "sTitle": "home pincode", "mData": "home_pincode", "bSortable": false },
                                { "sTitle": "Phone No", "mData": "phone_no", "bSortable": false },
                                { "sTitle": "Created date", "mData": "created_date", "bSortable": false },
                                { "sTitle": "Last updated", "mData": "last_modified_date", "bSortable": false },
                                { "sTitle": "Preferred Address", "mData": "is_preferred_address", "bSortable": false },
                                { "sTitle": "verified/unverified status", "mData": "is_verified", "bSortable": false },
                                { "sTitle": "Subscribe Newsletter", "mData": "subscribe_newsletter", "bSortable": false },
                                { "sTitle": "ID Card requested", "mData": "is_id_card", "bSortable": false },
                                { "sTitle": "Blood Group", "mData": "blood_group", "bSortable": false },
                                { "sTitle": "Emergency Contact Number", "mData": "Emergency_contact_no", "bSortable": false },
                                { "sTitle": "Photograph", "mData": "id_card_path", "bSortable": false },

                                //{
                                //    "sTitle": "Action", "mData": "user_id", "bSortable": false, "mRender": function (user_id) {
                                //        //alert(user_id);
                                //        return '<center><button type="button" onclick="rowClick(\'' + user_id + '\')">EDIT</button></center>';
                                //    }
                                //},
                                // {
                                //     "sTitle": "Action", "mData": "user_id", "bSortable": false, "mRender": function (user_id) {
                                //         //alert(user_id);
                                //         return '<center><button type="button" onclick="dwonload(\'' + user_id + '\')">Download</button></center>';
                                //     }
                                // },

                ]
            });
            $('#btnsave').css('display', 'none');
        }


        function bindEnrollmentyeardata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_alumini_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {

                        var year_data = JSON.parse(data.d);

                        $('#drpenrollmentyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpenrollmentyear').append($("<option></option>").val(year_data[i]["year_code"]).html(year_data[i]["year_desc"]));
                        }

                        $('#drpenrollmentyear').chosen();
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
        function bindprogramme() {

            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_Admin_wise_Program_user_dtl",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);

                            $('#drpprog').empty();

                            for (var i = 0; i < user_data.length; i++) {

                                if (user_data[i]['prog_code'] == "1") {
                                    $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                                }
                                else if (user_data[i]['prog_code'] == "2") {
                                    $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                                }
                                else if (user_data[i]['prog_code'] == "3") {
                                    $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));
                                }
                            }

                        }
                        else {
                            $('#drpprog').val('1');
                            $("#drpprog").attr('disabled', 'disabled');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }
            else {
                $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));
                $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
                $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
                $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

                if ($("#hdnusertype").val() != 'PC' && $("#hdnusertype").val() != 'FA') {
                    $('#drpprog').chosen();
                }
            }
        }

        function rowClick(id) {

            window.location.href = "PersonalDetailEditAdmin_Alumni.aspx?userid=" + id;

        }

        function dwonload(id) {
            $('#hdn_userid').val(id);
            $('#hdn_download').click();
            // window.location.href = "PersonalDetailEditAdmin_Alumni.aspx?userid=" + id;

        }
    </script>
</asp:Content>
