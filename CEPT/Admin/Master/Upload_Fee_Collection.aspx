<%@ Page Title="Fee Collection" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Upload_Fee_Collection.aspx.cs" Inherits="Admin_Master_Upload_Fee_Collection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Js/admin_report.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        var oTable;
        var semester = '';
        var year_code = '';
        var upload_type = '';

        function semchange() {
            semester = $('#drpsemester').val();

            if (semester == '') {
                $('#div_fee_collection_upload').css("display", "none");
            }
            else if (year_code != '' && upload_type != '') {
                fee_collection_upload();
            }
        }

        function yearchange() {
            year_code = $('#drpyear').val();

            if (year_code == '') {
                $('#div_fee_collection_upload').css("display", "none");
            }
            else if (semester != '' && upload_type != '') {
                fee_collection_upload();
            }
        }

        function uploadtypechange() {
            upload_type = $('#drpuploadtype').val();

            if (upload_type == '') {
                $('#div_fee_collection_upload').css("display", "none");
            }
            else if (semester != '' && year_code != '') {
                fee_collection_upload();
            }
        }

        function fee_collection_upload() {
            $('#div_fee_collection_upload').css("display", "block");

            $("#" + '<%=fee_collection_upload.ClientID%>').uploadify({
                'swf': '../../Scripts/uploadify.swf',
                'uploader': '../../Handler/Fee_Collection_Upload.ashx',
                'buttonText': 'Choose File',
                'fileDesc': 'Image Files',
                'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                'multi': false,
                'auto': true,
                'successTimeout': 15,
                'width': 90,
                'formData': { 'semester_type': semester, 'year_code': year_code, 'upload_type': upload_type, 'session_data': $('#hdn_session').val() },
                'onUploadSuccess': function (file, data, response) {
                    FileName = file.name;

                    if (data == "Problem in save data") {
                        bootbox.alert(data);
                    }
                    else if (data == "Data Saved Successfully") {
                        bootbox.alert(data, function () {
                            window.location.reload();
                        });
                    }
                    else if (data == "null") {
                        bootbox.alert("No data found in excel");
                    }
                    else {
                        display_fee_collection_upload_error_data(data);
                    }
                }
            });

            return false;
        }

        $(document).ready(function () {
            $('#drpselect').on('change', function () {
                var str = $('#drpselect').val();

                if (str == "opt_fee_collection_upload") {
                    $('#d_fee_collection_upload').css("display", "block");
                    $('#DataList_user').css("display", "none");

                    bindsemdata();
                    bindyeardata_for_cross_reg();
                }

                if (str == "area_upload") {
                    $('#DataList_user').css("display", "none");
                }
                if (str == "") {
                    $('#DataList_user').css("display", "none");
                }
            });
        });

        //function display_fee_collection_upload_error_data(data) {
        //    bootbox.alert("There are some problem in excel data please check and correct data");
        //    if (oTable != null) {
        //        oTable.fnDestroy();
        //        $("#DataList_user").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="dt_user_upload"><thead></thead><tbody> </tbody></table>');
        //    }

        //    oTable = $("#dt_user_upload").dataTable({
        //        "bPaginate": true,
        //        "bStateSave": true,
        //        "iDisplayLength": 60,
        //        "sDom": 't',
        //        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //        //"sScrollY": '400px',
        //        "oLanguage": {
        //            "sSearch": "Search all columns with Space:"
        //        },
        //        //"sDom": 'T<"clear">lfrtip',
        //        "oTableTools": {
        //            "aButtons": [
        //              ]
        //        },
        //        "aaData": JSON.parse(data),
        //        "aoColumns": [
        //            { "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
        //            { "sTitle": "User Id", "mData": "User_Id", "bSortable": false },
        //            { "sTitle": "Remark", "mData": "Remark", "bSortable": false }
        //        ]
        //    });
        //    $('#DataList_user').css('display', 'block');
        //}

        function display_fee_collection_upload_error_data(data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        //"copy",
                        //"print",
                        //{
                            //"sExtends": "collection",
                            //"sButtonText": 'Export',
                            //"aButtons": ["xls"]
                        //}
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
                    { "sTitle": "User Id", "mData": "User_Id", "bSortable": false },
                    { "sTitle": "Remark", "mData": "Remark", "bSortable": false }
                    //{ "sTitle": "Edit", "mData": null, "bSortable": false, "mRender": function (course_code) {
                        ////alert(course_code);
                        //return '<center><button type="button" onclick="rowClick(this)">Edit</button></center>';
                        //}
                    //},
                    //{ "sTitle": "Delete", "mData": null, "bSortable": false, "mRender": function (course_code) {
                        ////alert(course_code);
                        //return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
                        //}
                    //}
                ]
            });

            $('#DataList').css('display', 'block');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Upload Fee Collection
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
                            <option value="opt_fee_collection_upload">Fee Collection Upload</option>
                        </select>
                    </div>
                    <div class="widget-box" id="d_fee_collection_upload" style="display: none;">
                        <p style="color:Red;padding-left:5px;"> * select both Drop Down List to proceed</p>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester" onchange="semchange()">
                                    </select>
                                </td>
                                <td>
                                    Year Of Allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear" onchange="yearchange()">
                                    </select>
                                </td>
                                <td>
                                    Upload Type :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpuploadtype" onchange="uploadtypechange()">
                                        <option value="">-- Please Select Upload Type --</option>
                                        <option value="branch">Direct ICICI Branch</option>
                                        <option value="card">Debit / Credit Card</option>
                                        <option value="nb">Net Banking</option>
                                    </select>
                                </td>
                            </tr>
                        </table>
                        
                        <%--<button id="btn_student_wise_course" onclick="return student_course_upload()">Student Wise Course Upload</button>--%>

                        <div class="widget-box" id="div_fee_collection_upload" style="display: none;">
                            <asp:FileUpload ID="fee_collection_upload" runat="server"/>
                        </div>
                    </div>
                    
                </div>
            </div>

            <div id="DataList" style="display: none;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <input type="hidden" id="hdn_session" runat="server" clientidmode="Static" />
</asp:Content>

