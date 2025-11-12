<%@ Page Title="Alumni Verification" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Alumni_verification.aspx.cs" Inherits="Admin_Master_Alumni_verification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>

     <%--<script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>--%>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="well" style="background-color: White;">
        <div id="DataList9" class="panel panel-default">
            <div class="panel panel-default ">
                <div class="panel-heading">
                    <strong><span class="panel-headingfont">Alumni Verification Data</span></strong>

                    <div>
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

                            </tr>
                            <tr style="text-align: center;">

                                <td colspan="3">
                                    <button class="btn btn-primary" type="button" id="btnreterive">
                                        Retrieve
                                    </button>


                                </td>
                                <td colspan="2" style="display:none;">
                                    <div align="right">

                                        <div id="div_student_marks_upload">
                                            <asp:FileUpload ID="student_marks_upload" runat="server" />
                                        </div>
                                    </div>
                                </td>
                            </tr>

                        </table>


                    </div>

                </div>
            </div>
            <div id="studiocourse" class="tab-pane" style="overflow:auto;">
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


                <td align="center" style="padding-left: 75px;display:none;" >
                    <button id="btnsave" type="button" style="display: none" class="btn btn-lg btn-primary">
                        <i class="icon-save bigger-160"></i>Save
                    </button>
                </td>
            </tr>

        </table>
        <input id="btn_show_modal2" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal2" value="Display" style="height: 40px; margin-top: -10px; display: none;" />
        <div class="modal fade" id="mynewModal2" style="display: none; top: 5%;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="H2">Hello</h4>
                    </div>

                    <div class="modal-body">
                    </div>

                    <div class="modal-footer">
                        <button id="btn_modal_close2" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <%--<button id="btn_modal_save2" type="button" class="btn btn-primary" onclick="updateColumn()">Save changes</button>--%>
                    </div>

                </div>
            </div>
        </div>
    </div>



    <script type="text/javascript">
        var oTable1;
        var oTable2;
        var student_data = '';
        var course_instructor_data = '';
        var student_saved_data = '';
        var course_saved_data = '';
        var instructor_group_saved_data = '';

        $(document).ready(function () {
            student_marks_upload();
            binddepartment();
            bindEnrollmentyeardata();
            bindprogramme();

            $("#btnreterive").click(function () {

                $("#hdn_drpdepartment").val($('#drpdepartment').val());
                $("#hdn_drpenrollmentyear").val($('#drpenrollmentyear').val());
                $("#hdn_drpprog").val($('#drpprog').val());
                $("#hdn_reg_by").val($('#reg_by').val());

                databind();
            });


            $('#btnsave').on('click', function () {

                var datalist = [];

                $("#example tbody tr").each(function (i) {


                    if ($(this).find(".chk_verify").is(':checked')) {
                        
                        var aPos = oTable1.fnGetPosition(this);
                        var a = oTable1.fnGetData(aPos);
                        var ob = {};

                        ob["user_id"] = $(this).find(".cls_user_id").val();
                        ob["user_name"] = $(this).children().eq(3).html();
                        ob["email"] = $(this).children().eq(4).html();
                        ob["dob"] = $(this).children().eq(7).html();
                        ob["year_of_enrollement"] = a["year_code"];
                        ob["prog_level_code"] = a["prog_level_code"];
                        ob["year_code"] = a["year_code"];

                        ob["dept_code"] = a["dept_code"];
                        ob["prog_code"] = a["prog_code"];
                        datalist.push(ob);
                    }

                });


                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_alumni_verify_user_admin",
                    async: false,
                    data: "{verify_data : '" + JSON.stringify(datalist) + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == "Data verified Successfully") {
                            bootbox.alert(data.d, function () {

                                window.location.reload();

                            });
                        }
                        else {
                            bootbox.alert(data.d);
                        }
                        return false;
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

        });
        function databind() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_alumni_data_for_verification",
                async: false,
                data: "{year_code:'" + $('#drpenrollmentyear').val() + "' ,dept_code:'" + $('#drpdepartment').val() + "',prog_code:'" + $('#drpprog').val() + "',regby:'" + $('#reg_by').val() + "'}",
                dataType: "json",
                success: function (data) {
                    //   display_data(data.d);
                   

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
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [
                     //{
                     //    "sTitle": "Select",
                     //    "bSortable": false,
                     //    "mData": null,
                     //    fnRender: function (oObj) {
                     //        debugger;
                     //        listItems = '<center><input type="checkbox" class="cls_chk" value ="' + oObj.aData.user_id + '"/></center>';
                     //        return listItems;
                     //    }
                     //},
                //{
                //    "sTitle": "",
                //    "bSortable": false,
                //    "mData": null,
                //    fnRender: function (oObj) {
                //        listItems = '<center><button type="button" onclick="rowClick(this)">Verify</button></center>';
                //        return listItems;
                //    }
                //},
                {
                    "sTitle": "Student Code",
                    "bSortable": false,
                    "mData": null,
                    mRender: function (oObj) {
                        
                        //listItems = '<center><input type="text"   name="substudio_user" value ="' + oObj.user_id + '" class="cls_user_id" ></center>';
                        listItems = oObj.user_id;
                        return listItems;
                    }
                },
                 //{
                 //    "sTitle": "Select",
                 //    "bSortable": false,
                 //    "mData": null,
                 //    fnRender: function (oObj) {
                 //        debugger;
                 //        listItems = '<center><input type="checkbox" class="chk_verify" value ="' + oObj.aData.user_id + '"/></center>';
                 //        return listItems;
                 //    }
                 //},

            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Email", "mData": "mail", "bSortable": false },
            { "sTitle": "Year of Enrollment", "mData": "year_desc", "bSortable": false },
            { "sTitle": "Program Name", "mData": "prog_level_name", "bSortable": false },
            { "sTitle": "Date of birth", "mData": "date_of_birth", "bSortable": false },
            //{ "sTitle": "RegisterBy", "mData": "is_registr", "bSortable": false },
            //{ "sTitle": "Created date", "mData": "created_date", "bSortable": false },
            //{ "sTitle": "Last updated", "mData": "last_modified_date", "bSortable": false }
                ]
            });
            $('#btnsave').css('display', 'block');
        }

        function rowClick(raw) {
           
            var current_row = $(raw).closest("tr").get(0)

            var aPos = oTable1.fnGetPosition(current_row);
            var a = oTable1.fnGetData(aPos);
            var ob = {};

            ob["user_id"] = $(current_row).find(".cls_user_id").val();
            ob["user_name"] = $(current_row).children().eq(3).html();
            ob["email"] = $(current_row).children().eq(4).html();
            ob["dob"] = $(current_row).children().eq(7).html();
            ob["year_code"] = a["year_code"];
            ob["prog_level_code"] = a["prog_level_code"];
            ob["dept_code"] = a["dept_code"];
            ob["prog_code"] = a["prog_code"];

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_alumni_verify_user",
                async: false,
                data: "{verify_data : '" + JSON.stringify(ob) + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d == "Data verified Successfully") {
                        bootbox.alert(data.d, function () {

                            window.location.reload();

                        });
                    }
                    else {
                        bootbox.alert(data.d);
                    }
                    return false;
                },
                error: function (result) {
                    alert(result);
                }
            });
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


        function display_student_marks_upload_error_data(data) {

            if (oTable2 != null) {
                oTable2.fnDestroy();
                $("#DataList2").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example2" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable2 = $("#example2").dataTable({

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

                //"aaData": JSON.parse(data),
                "aaData": data,

                "aoColumns": [{ "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
                                { "sTitle": "User Id", "mData": "User_Id", "bSortable": false },
                                { "sTitle": "Remark", "mData": "Remark", "bSortable": false },

                                { "sTitle": "Error", "mData": "Error", "bSortable": false }]

            });

            $('#DataList2').css('display', 'block');
            $('#btn_show_modal2').click();
        }

        function student_marks_upload() {

            $("#" + '<%=student_marks_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/AlumniData_Upload.ashx',
                'buttonText': 'Excel Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 120,
                'height': 34,
                // 'formData': { 'course_code': $('#hdn_c').val(), 'semester_type': sem, 'year_code': year, 'session_data': $('#hdn_session').val() },
                'onUploadSuccess': function (file, data, response) {

                    FileName = file.name;

                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                    }
                    else if (data == "Data Saved Successfully") {
                        bootbox.alert(data, function () {
                            //window.location.reload();
                            databind();
                        });
                    }
                    else if (data == "null") {

                        bootbox.alert("No data found in excel");
                    }
                    else if (data == "") {

                        bootbox.alert("Problme Excel data");
                    }
                    else {
                        //  $('#H2').html('' + course_detail[0]['course_code'] + ' - ' + course_detail[0]['course_name']);
                        var str_modal2 = "<div id='DataList2' style='display: none;'>" +
                                " <table cellpadding='0' cellspacing='0' border='0' id='example2' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                " <thead></thead><tbody></tbody></table></div>";
                        $('.modal-body')[0].innerHTML = str_modal2;
                        display_student_marks_upload_error_data(JSON.parse(data));
                    }
                }
            });

            $('#ctl00_ContentPlaceHolder1_student_marks_upload').addClass("btn btn-lg btn-primary");
            $('#ctl00_ContentPlaceHolder1_student_marks_upload').css('padding', '0');
            $('#ctl00_ContentPlaceHolder1_student_marks_upload').css('margin-bottom', '0');
            $('#SWFUpload_0').css('margin-left', '-50%');
            $('#ctl00_ContentPlaceHolder1_student_marks_upload-button').removeClass("uploadify-button");
            $('#ctl00_ContentPlaceHolder1_student_marks_upload-queue').remove();

            return false;

        }



    </script>
</asp:Content>
