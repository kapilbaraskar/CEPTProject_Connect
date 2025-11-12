<%@ Page Title="Upload Master - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="user_upload.aspx.cs" Inherits="Admin_Master_user_upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">
        var oTable;

        $(document).ready(function () {
            $("#" + '<%=area_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/Area_mst_upload.ashx',
                'buttonText': 'Area Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'onUploadSuccess': function (file, data, response) {
                    debugger;
                    FileName = file.name;
                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                    }
                    else if (data == "Data Saved Successfully") {
                        bootbox.alert(data);
                    }
                    else if (data == "null") {

                        bootbox.alert("No data found in excel");
                    }
                    else {

                        display_area_upload_error_data(data);

                    }

                    //   alert(FileName);
                }
            });

            $("#" + '<%=user_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/UploadFile.ashx',
                'buttonText': 'User Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                //  'successTimeout': 15,
                //  'width': 90,
                'onUploadSuccess': function (file, data, response) {

                    FileName = file.name;
                    debugger;
                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                    }
                    else if (data == "Data Saved Successfully") {
                        bootbox.alert(data);
                    }
                    else if (data == "null") {

                        bootbox.alert("No data found in excel");
                    }
                    else {

                        display_user_upload_error_data(data);

                    }


                    //   alert(FileName);
                }
            });
            $("#" + '<%=course_master.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/course_master.ashx',
                'buttonText': 'Course Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'onUploadSuccess': function (file, data, response) {
                    debugger;
                    FileName = file.name;
                    alert(data);
                    //   alert(FileName);
                }
            });
            $("#" + '<%=department_master.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/department.ashx',
                'buttonText': 'Department Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'onUploadSuccess': function (file, data, response) {
                    debugger;
                    FileName = file.name;
                    alert(data);
                    //   alert(FileName);
                }
            });
            $("#" + '<%=instructer_master.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/instructer.ashx',
                'buttonText': 'Instructer Upload',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'onUploadSuccess': function (file, data, response) {
                    debugger;
                    FileName = file.name;
                    alert(data);
                    //   alert(FileName);
                }
            });
            $('#drpselect').on('change', function () {
                var str = $('#drpselect').val();
                if (str == "area_upload") {
                    $('#area').css("display", "block");
                    $('#user').css("display", "none");
                    $('#course').css("display", "none");
                    $('#dept').css("display", "none");
                    $('#ins').css("display", "none");
                    $('#DataList_user').css("display", "none");
                }
                if (str == "user_upload") {
                    $('#area').css("display", "none");
                    $('#user').css("display", "block");
                    $('#course').css("display", "none");
                    $('#dept').css("display", "none");
                    $('#ins').css("display", "none");
                    $('#DataList_user').css("display", "none");
                }
                if (str == "course_master") {
                    $('#course').css("display", "block");
                    $('#area').css("display", "none");
                    $('#user').css("display", "none");
                    $('#dept').css("display", "none");
                    $('#ins').css("display", "none");
                    $('#DataList_user').css("display", "none");
                }
                if (str == "department_master") {
                    $('#course').css("display", "none");
                    $('#area').css("display", "none");
                    $('#user').css("display", "none");
                    $('#dept').css("display", "block");
                    $('#ins').css("display", "none");
                    $('#DataList_user').css("display", "none");
                }
                if (str == "instructer_master") {
                    $('#dept').css("display", "none");
                    $('#area').css("display", "none");
                    $('#user').css("display", "none");
                    $('#course').css("display", "none");
                    $('#ins').css("display", "block");
                    $('#DataList_user').css("display", "none");
                }
                if (str == "") {
                    $('#ins').css("display", "none");
                    $('#area').css("display", "none");
                    $('#user').css("display", "none");
                    $('#course').css("display", "none");
                    $('#ins').css("display", "none");
                    $('#DataList_user').css("display", "none");
                }
            });
        });

        function display_user_upload_error_data(data) {


            bootbox.alert("There are some problem in excel data please check and correct data");

            debugger;

            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList_user").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="dt_user_upload"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#dt_user_upload").dataTable({

                "bPaginate": true,
                "bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //  "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //        "sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [

						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
          { "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
          { "sTitle": "User Id", "mData": "User_Id", "bSortable": false },
           { "sTitle": "Remark", "mData": "Remark", "bSortable": false }



            ]


            });

            $('#DataList_user').css('display', 'block');


        }



        function display_area_upload_error_data(data) {


            bootbox.alert("There are some problem in excel data please check and correct data");

            debugger;

            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList_user").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="dt_user_upload"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#dt_user_upload").dataTable({

                "bPaginate": true,
                "bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //  "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //         "sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //        "sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [

						]
                },

                "aaData": JSON.parse(data),
                "aoColumns": [
          { "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
          { "sTitle": "Area Code", "mData": "area_code", "bSortable": false },
           { "sTitle": "Remark", "mData": "Remark", "bSortable": false }



            ]


            });

            $('#DataList_user').css('display', 'block');


        }
       
                
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Upload Master
            </h1>
        </div>
        <div class="row-fluid">
            <div class="span4">
                <div class="control-group">
                    <label class="control-label" for="drpupload">
                    </label>
                    <div class="controls">
                        <select id="drpselect">
                            <option value="">Select Upload</option>
                            <option value="area_upload">Area upload</option>
                            <option value="user_upload">User upload</option>
                            <%-- <option value="course_master">course master</option>--%>
                            <%--  <option value="department_master">Department master</option>--%>
                            <%-- <option value="instructer_master">instructer master</option>--%>
                        </select>
                    </div>
                    <div class="widget-box" id="area" style="display: none">
                        <asp:FileUpload ID="area_upload" runat="server" />
                    </div>
                    <div class="widget-box" id="user" style="display: none">
                        <asp:FileUpload ID="user_upload" runat="server" />
                    </div>
                    <div class="widget-box" id="course" style="display: none">
                        <asp:FileUpload ID="course_master" runat="server" />
                    </div>
                    <div class="widget-box" id="dept" style="display: none">
                        <asp:FileUpload ID="department_master" runat="server" />
                    </div>
                    <div class="widget-box" id="ins" style="display: none">
                        <asp:FileUpload ID="instructer_master" runat="server" />
                    </div>
                </div>
            </div>
            <div id="DataList_user" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="dt_user_upload" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>
