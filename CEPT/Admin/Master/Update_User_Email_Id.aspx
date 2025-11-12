<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Update_User_Email_Id.aspx.cs" Inherits="Admin_Master_Update_User_Email_Id" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Scripts/AjaxFileupload.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            bindyeardata_for_cross_reg();
            bindsemdata();

            $(".for_cc").css("display", "none");
            $(".for_ue").css("display", "none");

            $("#change_type").change(function () {
                if ($("#change_type").val() == "UE") {
                    $(".for_cc").css("display", "none");
                    $(".for_ue").css("display", "");
                } else if ($("#change_type").val() == "CC") {
                    $(".for_cc").css("display", "");
                    $(".for_ue").css("display", "none");
                } else {
                    $(".for_cc").css("display", "none");
                    $(".for_ue").css("display", "none");
                }
            });

            $("#btn_update").click(function () {

                if ($("#change_type").val() == "UE") {
                    if ($("#drpyear2").val() == "") {
                        bootbox.alert("Please Select Year");
                        return false;
                    }

                } else if ($("#change_type").val() == "CC") {
                    if ($("#drpsemester").val() == "") {
                        bootbox.alert("Please Select Semester");
                        return false;
                    }
                    if ($("#drpyear").val() == "") {
                        bootbox.alert("Please Select Year");
                        return false;
                    }
                    if ($("#old_cc").val() == "") {
                        bootbox.alert("Please Enter Old Course Code");
                        return false;
                    }
                    if ($("#new_cc").val() == "") {
                        bootbox.alert("Please Enter New Course Code");
                        return false;
                    }
                } else {
                    bootbox.alert("Please Select Change Type");
                    return false;
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Update_UserID_EmailID_Course_Code",
                    data: "{change_type : '" + $("#change_type").val() + "', old_cc : '" + $("#old_cc").val() + "', new_cc : '" + $("#new_cc").val() + "', sem_type : '" + $("#drpsemester").val() + "', year_sem : '" + $("#drpyear").val() + "', enrol_year : '" + $("#drpyear2").val() + "'}",
                    dataType: "json",
                    success: function (data) {
                        debugger;
                        if (data.d != "") {
                            bootbox.alert(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            });

            $("#btn_delete").click(function () {
                if (confirm('Are you sure you want to delete data?')) {
                    
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "../../WebService.asmx/Delete_UserId_EmailId",
                        dataType: "json",
                        success: function (data) {
                            bootbox.alert(data.d);
                        },
                        error: function (result) {
                            alert(result);
                        }
                    });
                } else {
                    // Do nothing!
                }
            });

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

                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }
                        $('#drpyear').chosen();

                        $('#drpyear2').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear2').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }
                        $('#drpyear2').chosen();

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

        jQuery.extend({
            handleError: function (s, xhr, status, e) {
                // If a local callback was specified, fire it
                if (s.error)
                    s.error(xhr, status, e);
                // If we have some XML response text (e.g. from an AJAX call) then log it in the console
                else if (xhr.responseText)
                    console.log(xhr.responseText);
            }
        });

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

        function CheckMarksDocumentExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'xls':
                    case 'xlxs':
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

        function UploadData() {
            try {
                var fileToUpload = GetFileNameFromPath($('#userid_emailid_update_document').val());

                if (CheckMarksDocumentExtension(fileToUpload)) {
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        url: '../../Handler/Upload_Student_UserId.ashx',
                        secureuri: false,
                        fileElementId: 'userid_emailid_update_document',
                        dataType: 'json',
                        success: function (data, status) {
                            if (typeof (data.error) != 'undefined') {
                                if (data.error != '') {
                                    alert(data.error);
                                }
                                else {

                                }
                            }
                            $("#UploadingProgress").fadeOut(200);
                            alert(data[0]["Remark"] + ' of ' + data[0]["User_Id"] + ' at Excel Row No ' + data[0]["Excel_RowNo"]);
                            $('#userid_emailid_update_document').val('');
                        },
                        error: function (data, status, e) {
                            $("#UploadingProgress").fadeOut(200);
                            alert(data.responseText);
                            //window.location.reload();
                            $('#userid_emailid_update_document').val('');
                        }
                    });
                    //}
                }
                else {
                    alert('Invalid File Type. Please upload .xls file');
                }
                return false;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Update User ID/Email ID and Course Code
            </h1>
        </div>
        <div class="panel panel-default ">
            <div class="panel-heading">

                <strong><span class="panel-headingfont">Select Type</span></strong>
            </div>
            <div style="padding: 15px;" id="div3">

                <div class="row">
                    <div class="form-group col-md-3">
                        <div class="col-md-4" style="padding: 0 0 0 0;">
                            Type :
                        </div>
                        <div class="col-md-6" style="padding: 0 0 0 0;">
                            <select class="chosen-select" id="change_type" style="width: 146%">
                                <option value="">--- Please Select  ---</option>
                                <option value="UE">User ID - Email ID</option>
                                <option value="CC">Course Code</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <p style="color: black; margin-left: 1.5%;" class="for_ue">Step 1 : Click Delete All > Delete old data</p>
                    <p style="color: black; margin-left: 1.5%;" class="for_ue">Step 2 : Donwload Excel > Insert Data into Excel Format File</p>
                    <p style="color: black; margin-left: 1.5%;" class="for_ue">Step 3 : Upload Excel > Save new data</p>
                    <p style="color: black; margin-left: 1.5%;" class="for_ue">Step 4 : Click Update button > Update UserId and Email Id</p>
                    <p style="color: black; margin-left: 1.5%;" class="for_cc">Step 1 : Select Semester </p>
                    <p style="color: black; margin-left: 1.5%;" class="for_cc">Step 2 : Select Year</p>
                    <p style="color: black; margin-left: 1.5%;" class="for_cc">Step 3 : Enter Old Course Code</p>
                    <p style="color: black; margin-left: 1.5%;" class="for_cc">Step 4 : Enter New Course Code</p>
                    <p style="color: black; margin-left: 1.5%;" class="for_cc">Step 5 : Click Update button > Update Course Code</p>
                </div>
            </div>
        </div>
        <div class="panel-body for_ue" style="margin-top: 10px; border: 1px solid #ddd; height: 40px;">
            <div style="float: left; width: 20%;">
                <label for="text1" class="control-label">
                    <button class="btn  btn-primary" type="button" id="btn_delete">
                        Delete All
                    </button>
                </label>
            </div>
            <div style="float: left; width: 38%;">
                <div class="col-md-8" style="padding: 0 0 0 0;">
                    <a href="../../ExcelFormatFiles/UseridEmailid.xls" download>Download Excel Format</a>
                    <input id="userid_emailid_update_document" type="file" name="userid_emailid_update_document"
                        onchange="javascript:return UploadData();"/>
                </div>
            </div>
            <div style="float: left; width: 15%;">
                <label for="text1" class="control-label">
                    Enrollment Year :
                </label>
            </div>
            <div style="float: left;width: 25%;">
                <div class="col-md-8" style="padding: 0 0 0 0;">
                    <select class="chosen-select col-md-12" id="drpyear2">
                    </select>
                </div>
            </div>
        </div>
        <div class="panel-body for_cc" style="margin-top: 10px; border: 1px solid #ddd;">
            <div class="row">
                <div class="form-group col-md-2">
                    <label for="text1" class="control-label">
                        Semester :
                    </label>
                </div>
                <div class="form-group col-md-3">
                    <div class="col-md-9" style="padding: 0 0 0 0;">
                        <select class="chosen-select" id="drpsemester">
                        </select>
                    </div>
                </div>
                <div class="form-group col-md-2">
                    <label for="text1" class="control-label">
                        Year :
                    </label>
                </div>
                <div class="form-group col-md-3">
                    <div class="col-md-8" style="padding: 0 0 0 0;">
                        <select class="chosen-select col-md-12" id="drpyear">
                        </select>
                    </div>
                </div>
            </div>

            <div class="row" style="margin-top: 20px;">
                <div class="form-group col-md-2">
                    <label for="text1" class="control-label">
                        Enter Old Course Code :
                    </label>
                </div>
                <div class="form-group col-md-3">
                    <input type="text" id="old_cc" />
                </div>
                <div class="form-group col-md-2">
                    <label for="text1" class="control-label">
                        Enter New Course Code :
                    </label>
                </div>
                <div class="form-group col-md-2">

                    <input type="text" id="new_cc" />
                </div>
            </div>

        </div>
        <div class="row">
            <div class="form-group col-md-12" style="text-align: center; margin-top: 10px;">
                <div class="form-group col-md-12">
                    <button class="btn  btn-primary" type="button" id="btn_update">
                        Update
                    </button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

