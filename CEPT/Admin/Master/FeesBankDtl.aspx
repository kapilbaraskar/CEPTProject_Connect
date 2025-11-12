<%@ Page Title="Fees Bank Detail" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="FeesBankDtl.aspx.cs" Inherits="Admin_Master_FeesBankDtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
   
    <script src="../../Scripts/AjaxFileupload.js?t=28062019"></script>
   <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var FileName = '';
        var oTable;
        var oTable2;
        var oTable3;

        jQuery.extend({
            handleError: function (s, xhr, status, e)
            {
                // If a local callback was specified, fire it
                if (s.error)
                    s.error(xhr, status, e);
                // If we have some XML response text (e.g. from an AJAX call) then log it in the console
                else if (xhr.responseText)
                    console.log(xhr.responseText);
            }
        });

        $(document).ready(function ()
        {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindProgram();

            $('#btn_retrieve').on('click', function () {
                retrieve_fees_Data();
                return false;
            });

            $('#btn_download_prev').on('click', function () {
                
                download_prev_sem_fees();
            });
            
        });

        function bindProgram()
        {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Program --"));
            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function retrieve_fees_Data() {
            
            $('#DataList').css('display', 'none');
            $('#div_fee_bank_dtl_upload').css('display', 'none');

            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            //dept_code = $('#drpdepartment').val();
            //if (dept_code == "") {
            //    bootbox.alert('Please select Department');
            //    $('#drpdepartment').focus();
            //    return false;
            //}

            //prog_code = $('#drpprog').val();
            //if (prog_code == "") {
            //    bootbox.alert('Please select Programme');
            //    $('#drpprog').focus();
            //    return false;
            //}

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_all_fees_bank_detail",
                data: "{semester:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_Fees_Data(data.d);

                        $('#div_fees_list').css('display', 'block');
                        $('#div_fee_bank_dtl_upload').css('display', 'block');
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester or Year');
                        $('#div_fees_list').css('display', 'none');
                        $('#div_fee_bank_dtl_upload').css('display', 'block');
                    }

                    fee_bank_dtl_upload();
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        }

        function display_Fees_Data(data) {

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
                //"sDom": 't',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Department", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Program", "mData": "prog_name", "bSortable": false },
                    { "sTitle": "Account", "mData": "account_name", "bSortable": false },
                    { "sTitle": "Bank Code", "mData": "bank_code", "bSortable": false },
                    { "sTitle": "Allocation Year", "mData": "year", "bSortable": false },
                    { "sTitle": "Semester Code", "mData": "semester_code", "bSortable": false },
                    { "sTitle": "Male Fees", "mData": "M", "bSortable": false },
                    { "sTitle": "Female Fees", "mData": "F", "bSortable": false },
                    { "sTitle": "Installment 1", "mData": "installment1", "bSortable": false },
                    { "sTitle": "Installment 2", "mData": "installment2", "bSortable": false },
                    { "sTitle": "Installment 3", "mData": "installment3", "bSortable": false },
                    { "sTitle": "Installment 4", "mData": "installment4", "bSortable": false },
                    { "sTitle": "Nationality", "mData": "nationality", "bSortable": false },
                    { "sTitle": "", "mData": null, "bSortable": false, "mRender": function (course_code) {
                        return '<center><button type="button" onclick="rowClick_edit(this)">Edit</button></center>';
                    } 
                    }
                    //{ "sTitle": "", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    //    return '<center><button type="button" onclick="rowClick_delete(this)">Delete</button></center>';
                    //}
                    //}
                ]
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function rowClick_edit(row)
        {
            var tr = row.parentElement.parentElement.parentElement;
            var tr_data = oTable.fnGetData(tr);

            var semester = tr_data['semester_type'];
            var year = tr_data['year_semester'];
            var dept_code = tr_data['dept_code'];
            var prog_code = tr_data['prog_code'];
            var allo_year = tr_data['year_code'];
            var nationality = tr_data['nationality'];

            location.href = 'FeesBankDtl_Add.aspx?s=' + semester + '&y=' + year + '&d=' + dept_code + '&p=' + prog_code + '&a=' + allo_year + '&n=' + nationality;
        }

        //function rowClick_delete(row) {
        //    var tr = row.parentElement.parentElement.parentElement;
        //    var tr_data = oTable.fnGetData(tr);

        //    var semester = tr_data['semester_type'];
        //    var year = tr_data['year_semester'];
        //    var dept_code = tr_data['dept_code'];
        //    var prog_code = tr_data['prog_code'];
        //    var allo_year = tr_data['year_code'];
        //}

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

        function CheckMarksDocumentExtension(file)
        {
            try {
              
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'xls':
                    case 'xlxs':
                    case 'csv':
                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e)
            {
                //alert("Exception : " + e.message);
            }
        }


        function fee_bank_dtl_upload()
        {

            var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
            if (fileToUpload != null && fileToUpload != undefined) {
                if (CheckMarksDocumentExtension(fileToUpload))
                {
                 
                    $("#UploadingProgress").fadeIn(200);
                    $.ajaxFileUpload({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: '../../Handler/fee_bank_dtl_upload.ashx',
                        data: { 'semester_type': semester, 'year_code': year_code },
                        fileElementId: 'reservation_upload_document',
                        dataType: 'text',
                        success: function (data) {
                            if (data == "Problem in save data" || data == "Problem in save data, Please try again") {
                                bootbox.alert(data);
                            }
                            else if (data == "Fees Saved Successfully") {
                                bootbox.alert(data, function () {
                                    window.location.reload();
                                });
                            }
                            else if (data == "null") {
                                bootbox.alert("No data found in excel");
                            }
                            else if (data == "") {
                                bootbox.alert("Problem in save data.");
                            }
                            else {
                                var str_modal2 = "<div id='DataList2' style='display: none;'>" +
                                    " <table cellpadding='0' cellspacing='0' border='0' id='example2' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                    " <thead></thead><tbody></tbody></table></div>";
                                $('#div_errorList')[0].innerHTML = str_modal2;
                                display_fee_bank_dtl_upload_error_data(JSON.parse(data));
                            }
                        }
                    });

                }
                else
                {
                    alert('Invalid File Type. Please upload .xls file');
                }
            }
            return false;

        }






        <%--function fee_bank_dtl_upload() {
            try {//.uploadify
                //ctl00_ContentPlaceHolder1_fee_bank_dtl_upload
                //$("#" + '<%=fee_bank_dtl_upload.ClientID%>').fileUpload
                var fileToUpload = GetFileNameFromPath($('#reservation_upload_document').val());
                $('#reservation_upload_document').fileUpload({
                        'swf': '../../Scripts/uploadify.swf',
                        'uploader': '../../Handler/fee_bank_dtl_upload.ashx',
                        'buttonText': 'Choose File',
                        'fileDesc': 'Image Files',
                        'fileExt': '*.jpg;*.jpeg;*.gif;*.png',
                        'multi': false,
                        'auto': true,
                        'successTimeout': 15,
                        'width': 90,
                        'formData': { 'semester_type': semester, 'year_code': year_code },
                        'onUploadSuccess': function (file, data, response) {

                            FileName = file.name;

                            if (data == "Problem in save data" || data == "Problem in save data, Please try again") {
                                bootbox.alert(data);
                            }
                            else if (data == "Fees Saved Successfully") {
                                bootbox.alert(data, function () {
                                    window.location.reload();
                                });
                            }
                            else if (data == "null") {
                                bootbox.alert("No data found in excel");
                            }
                            else if (data == "") {
                                bootbox.alert("Problem in save data.");
                            }
                            else {
                                var str_modal2 = "<div id='DataList2' style='display: none;'>" +
                                    " <table cellpadding='0' cellspacing='0' border='0' id='example2' class='display table table-striped table-bordered table-hover' width='100%'>" +
                                    " <thead></thead><tbody></tbody></table></div>";
                                $('#div_errorList')[0].innerHTML = str_modal2;
                                display_fee_bank_dtl_upload_error_data(JSON.parse(data));
                            }
                        }
                    });

            }
            catch (e) {
                alert("Exception : " + e.message);
            }
            return false;
        }--%>

        function display_fee_bank_dtl_upload_error_data(data)
        {
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
                "aaData": data,
                "aoColumns": [{ "sTitle": "Excel Row No", "mData": "Excel_RowNo", "bSortable": false },
                        { "sTitle": "Column", "mData": "User_Id", "bSortable": false },
                        { "sTitle": "Remark", "mData": "Remark", "bSortable": false}]
            });

            $('#DataList2').css('display', 'block');
            $('#btn_show_modal2').click();
        }

        function download_prev_sem_fees() {

            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }

            var prev_sem;
            if (semester == "S") prev_sem = "M";
            else if (semester == "M") prev_sem = "S";

            var prev_year = '';
            if (semester == "S") prev_year = parseInt(year_code) - 1;
            else if (semester == "M") prev_year = year_code;

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_all_fees_bank_detail",
                data: "{semester:'" + prev_sem + "' , year_code : '" + prev_year + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                     
                        display_Prev_Sem_Fees_Data(data.d);
                    }
                    else {
                        bootbox.alert('No data Found For Selected Semester or Year');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        }

        function display_Prev_Sem_Fees_Data(data) {
            
            $('#DataList3').css('display', 'none');
        
            if (oTable3 != null) {
                oTable3.fnDestroy();
                $("#DataList3").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example_prev_sem_fees" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable3 = $("#example_prev_sem_fees").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                 "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                ////"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},
                "aaData": JSON.parse(data),
                //var startdate = start_date.;
                "aoColumns": [
                    { "sTitle": "department", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "program", "mData": "prog_name", "bSortable": false },
                    { "sTitle": "account_name", "mData": "account_name", "bSortable": false },
                    { "sTitle": "bank_code", "mData": "bank_code", "bSortable": false },
                    { "sTitle": "allocation_year", "mData": "year", "bSortable": false, "mRender": function (alloc_year) { return alloc_year.substr(0, 4); } },
                    { "sTitle": "semester_code", "mData": "semester_code", "bSortable": false },
                    { "sTitle": "male_fees", "mData": "M", "bSortable": false },
                    { "sTitle": "female_fees", "mData": "F", "bSortable": false },
                    { "sTitle": "semester", "mData": "semester_type", "bSortable": false, "mRender": function (sem) { return semester; } },
                    { "sTitle": "year_semester", "mData": "year_semester", "bSortable": false, "mRender": function (year) { return year_code; } },
                    { "sTitle": "upto_7_days_fine", "mData": "fine", "bSortable": false },
                    { "sTitle": "upto_84_days_fine", "mData": "fine2", "bSortable": false },
                    { "sTitle": "installment1", "mData": "installment1", "bSortable": false },
                    { "sTitle": "installment2", "mData": "installment2", "bSortable": false },
                    { "sTitle": "installment3", "mData": "installment3", "bSortable": false },
                    { "sTitle": "installment4", "mData": "installment4", "bSortable": false },
                     
                    {
                        "sTitle": "start_date", "mData": "start_date", "bSortable": false, "mRender": function (start_date)
                        {
                           // startdate = startdate.
                            return start_date;
                        }
                    },
                    { "sTitle": "end_date", "mData": "end_date", "bSortable": false },
                    { "sTitle": "end_date2", "mData": "end_date2", "bSortable": false },
                    { "sTitle": "end_date3", "mData": "end_date3", "bSortable": false },
                    { "sTitle": "nationality", "mData": "nationality", "bSortable": false },
                ]
            });

            $('#DataList3').css('display', 'block');
            $('#btn_show_modal3').click();
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Fees Bank Detail
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>Semester</td>
                        <td><select class="chosen-select" id="drpsemester"></select></td>
                        
                        <td>Year</td>
                        <td><select class="chosen-select" id="drpyear"></select></td>

                        <td><input type="button" id="btn_retrieve" value="Retrieve" class="btn btn-primary" /></td>
                    </tr>

                    <tr style="display:none;">
                        <td class="cls_dept_prog">Department</td>
                        <td class="cls_dept_prog"><select class="chosen-select" id="drpdepartment"></select></td>

                        <td>Program</td>
                        <td><select class="chosen-select" id="drpprog"></select></td>

                        <td></td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="div_fee_bank_dtl_upload" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Upload Fees Bank Detail</strong>
            </div>
            <div class="panel-body">
               <%-- <asp:FileUpload ID="reservation_upload_document" type="file" onchange ="javascript:return fee_bank_dtl_upload();" runat="server"  />--%>
                <input id="reservation_upload_document" type="file" name="reservation_upload_document"
                                                onchange ="javascript:return fee_bank_dtl_upload();" />

                <div style="position: absolute;left: 69%;margin-top: -4%;">
                    <%--<input type="button" id="btn_download_prev" class="btn btn-primary" value="Download" />--%>
                    Download Previous Sem Fees : <input type="button" id="btn_download_prev" class="uploadify-button" value="Download" style="width: 96px;height: 36px;"/>
                  
                </div>
            </div>
        </div>

        <div id="div_fees_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Fees List</strong> 
                <%--<span style="float: right;">
                    <input type="button" id="btn_download_all" class="btn btn-primary" runat="server" value="Upload Excel" style="height: 40px;margin-top: -10px;" />
                </span>--%>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow:auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="mynewModal2" style="display:none;top:5%;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="H2">Excel Upload Error List</h4>
                    </div>

                    <div id="div_errorList" class="modal-body">
                        
                    </div>

                    <div class="modal-footer">
                        <button id="btn_modal_close2" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="mynewModal3" style="display:none;top:5%;left: 34%;width: 73%;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="H3">Excel Upload Error List</h4>
                    </div>

                    <div id="div_prevSemFees" class="modal-body">
                        <div id='DataList3' style='display: none;'>
                            <table cellpadding='0' cellspacing='0' border='0' id='example_prev_sem_fees' class='display table table-striped table-bordered table-hover' width='100%'>
                                <thead>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button id="btn_modal_close3" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>

        <div>
            <input id="btn_show_modal2" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal2" value="Display" style="height: 40px;margin-top: -10px;display:none;"/>
            <input id="btn_show_modal3" type="button" class="btn btn-primary" data-toggle="modal" data-target="#mynewModal3" value="Display" style="height: 40px;margin-top: -10px;display:none;"/>
        </div>

    </div>
</asp:Content>

