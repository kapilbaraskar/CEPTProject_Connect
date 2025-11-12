<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="TARateBandDtl.aspx.cs" Inherits="Admin_Master_TARateBandDtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <script src="../../Js/admin_report.js?t=22082022" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script> 
     
      <link href="../../Style/csvstyle.css" rel="stylesheet" />
       <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/fixedcolumns/4.2.2/css/fixedColumns.dataTables.min.css"/>
<script type="text/javascript" src="https://cdn.datatables.net/fixedcolumns/4.2.2/js/dataTables.fixedColumns.min.js"></script>
       
    <script type="text/javascript">
        $(document).ready(function () {

            /*bootbox.alert("Please ensure that you have submitted the latest Grade Range from \"Course Wise Grade Range\".");*/
            bindyeardata_for_cross_reg();
            bindsemdata();
            //binddepartment();

            $('#btnreterive').on('click', function () {
                retrieve_Student_Data();
                return false;
            });

            document.getElementById('fileInput').addEventListener('change', function (event) {
                var file = event.target.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        var base64String = e.target.result;
                        document.getElementById('base64output').value = base64String;
                    };
                    reader.readAsDataURL(file);
                }
            });

            $("#uploadBtn").click(function () {

                if ($('#drpyear').val() == '')
                {
                    bootbox.alert("Please select Year");
                    return false;
                }
                if ($('#drpsemester').val() == '') {
                    bootbox.alert("Please select Semester");
                    return false;
                }
                var fileInput = document.getElementById('fileInput');
                var file = fileInput.files[0];

                if (!file) {
                    bootbox.alert("Please select a Excel file.");
                    return false;
                }
                var fileInput = $('#fileInput')[0].files[0];
                var fileBytes = $('#base64output').val();
                var base64String = fileBytes.split(',')[1];
                var sendurl = base64String;
                $.ajax({
                    url: '../../WebService.asmx/UploadExceldata',
                    type: 'POST',
                    data: "{fileBytes:'" + sendurl + "',year:'" + $('#drpyear').val() + "',semester:'" + $('#drpsemester').val() + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response)
                    {
                        $('#status').html(response.d);
                    },
                    error: function (xhr, status, error) {
                        $('#status').html('File upload failed: ' + error);
                    }
                });

            });

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Rate Band Approve Details
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
                <%--<div style="float: right;">
                     <a href="../../ExcelFormatFiles/UseridEmailid.xls" download>Download Excel Format</a>
                </div>--%>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>Select Type :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drptype">
                                        <%--<option value="VF">Studio Tutor</option>--%>
                                        <option value="TA">TA</option>
                                        <%--<option value="AA">AA</option>
                                        <option value="Course">Course Tutor</option>--%>
                                    </select>
                                </td>
                                </tr>
                            <tr>
                                <td>Filter Type :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpFilter">
                                         <option value="">----Please Select----</option>
                                        <option value="A">Authorize</option>
                                        <option value="P">Pending</option>
                                    </select>
                                </td>

                                <td>
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                              
                            </tr>

                            <tr>
                                
                                
                            <td colspan="4" style="display:none;">
                                <div style="float: left; width: 38%;">
                <div class="col-md-8" style="padding: 0 0 0 0;">
                   <a href="../../ExcelFormatFiles/RatebandData.xlsx" download>Download Excel Format</a>
                    <input type="file" id="fileInput" name="file" accept=".xlsx" />
                   
                </div>
            </div>
           
        <button class="btn  btn-primary" type="button" id="uploadBtn">Upload</button>
               
       <%-- <input type="button" value="Upload" onclick="uploadExcel()" />--%>
      
       

                                    </td>
                            </tr>
                            <tr>
                                <td colspan="4"><div id="status" style="color:blue;"></div></td>
                            </tr>
                           
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_stud_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Rate Band Approve Details</strong> <span style="float: right;">
                   
                </span>
            </div>
            <div>
                <%--class="panel-body"--%>
                <div id="DataList" style="display: none;">
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
    </div>
    <div id="ifrm_outline" style="display: none;"></div>
    <input type="hidden" id="hdn_filter" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdn_check" runat="server" clientidmode="Static" />
    <div style="display: none;">
        <a href="#" id="Link" download="outline.pdf">Download</a>
    </div>
    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var prog_level_code = '';
        var asInitVals = new Array();

        function get_fauser_detail() {

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_department_wise_user_dtl",
                    async: false,
                    data: "{}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var user_data = JSON.parse(data.d);
                            $('#drpdepartment').val(user_data[0]['dept_code']);
                            //$('#drpprog').val(user_data[0]['prog_code']);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }

        function retrieve_Student_Data() {
            $('#DataList').css('display', 'none');

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

            dept_code = '';
            var selecttype = $('#drptype').val();
            if (selecttype == "") {
                bootbox.alert('Please select Type');
                $('#drptype').focus();
                return false;
            }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetRateBandDetails",
                    /*data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',prog_level_code:'" + prog_level_code + "',year_of_enrollment:'" + year_of_enrollment + "'}",*/
                    data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',selecttype: '" + selecttype + "',type: ''}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "") {
                            display_Student_Data(data.d);
                            $('#div_stud_list').css('display', 'block');
                            $(window).trigger('resize');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester or Year');
                            $('#div_stud_list').css('display', 'none');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            return false;
        }







        function display_Student_Data(data) {

            var result = JSON.parse(data);
            if ($('#drpFilter').val() == 'A') {
                result = alasql('SELECT * FROM ? WHERE ApproveRateBand = ?', [result, 'A']);
                //result = alasql('SELECT * FROM ? WHERE hr_status = ?', [result, 'A']);
                //result = alasql('SELECT * FROM ? WHERE ApproveRateBand = ? AND hr_status = ?', [result, 'A', 'A']);
            }
            else if ($('#drpFilter').val() == 'P') {
                result = alasql('SELECT * FROM ? WHERE ApproveRateBand <> ?', [result, 'A']);
                //result = alasql('SELECT * FROM ? WHERE hr_status <> ?', [result, 'A']);
            }


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
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
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
                "scrollX": true,
                "aaData": result,
                "fixedColumns": {
                    "rightColumns": 4 // Fix the last 3 columns
                },
                "aoColumns": [
                    { "sTitle": "Code", "mData": "instructor_code", "bSortable": false },
                    { "sTitle": "Name", "mData": "instructor_name", "bSortable": false },
                    { "sTitle": "Mail", "mData": "mail", "bSortable": false },
                    //{ "sTitle": "Mobile No", "mData": "mobile_no", "bSortable": false },
                    //{ "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    //{ "sTitle": "Programe Name", "mData": "prog_name", "bSortable": false },
                    //{ "sTitle": "Programe Level Name", "mData": "prog_level_name", "bSortable": false },
                    //{ "sTitle": "Submitted/Saved", "mData": "is_submit", "bSortable": false },
                    /*{ "sTitle": "Faculty Selected By", "mData": "faculty_selected_by", "bSortable": false },*/

                    //{
                    //    "sTitle": "Faculty Selected By", "mData": null, "bSortable": false, "mRender": function (Data)
                    //    {
                    //        if (Data.faculty_selected == "N")
                    //        {
                    //            return 'Pending';
                    //        }
                    //        else if (Data.faculty_selected == "Y")
                    //        {
                    //            return Data.faculty_selected_by;
                    //        }
                    //        else
                    //        {
                    //            return '';
                    //        }

                    //    }
                    //},
                    { "sTitle": "Total Experience In Month", "mData": "TotalExperiance", "bSortable": false },
                    { "sTitle": "Highest Qualification", "mData": "highest_qualification", "bSortable": false },
                    { "sTitle": "Designation", "mData": "designation", "bSortable": false },
                    /* { "sTitle": "Rate Band", "mData": "rate_band", "bSortable": false },*/
                    {
                        "sTitle": "Rate Band", "mData": null, "bSortable": false, mRender: function (data) {

                            var row_value = data.rate_band;
                            return '<span id=rateband_' + data.instructor_code + '>' + row_value + '</span>';

                        }
                    },


                    {
                        "sTitle": "Personal Details", "mData": null, "bSortable": false, mRender: function (data) {

                            var row_value = data.instructor_code;
                            return '<center><button type="button" id=' + row_value + ' onclick="rowClick_edit(this)" class="per_edit">Edit</button></center>';

                        }
                    },
                    //{
                    //    "sTitle": "HR Status", "mData": null, "bSortable": false, "mRender": function (Data)
                    //    {
                    //        if (Data.hr_status == 'A')
                    //        {
                    //            return 'Approved';
                    //        }
                    //        else
                    //        {
                    //            return 'Pending';
                    //        }
                    //    }
                    //},

                    //{
                    //    "sTitle": "PC Status", "mData": null, "bSortable": false, "mRender": function (Data) {
                    //        if (Data.pc_status == 'A') {
                    //            return 'Approved';
                    //        }
                    //        else { return 'Pending'; }



                    //    }
                    //},

                    /* { "sTitle": "HR Approved", "mData": "hr_approved", "bSortable": false },*/
                    //{
                    //    "sTitle": "Download Reference Letter", "mData": null, "bSortable": false, "mRender": function (Data) {
                    //        if (Data.refrence_letter_path != "")
                    //            return '<center><a href="' + window.location.origin + '/TAReferenceLetter/' + Data.refrence_letter_path + '" download style="text-decoration:none;" class="cv_refrence" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    //        else
                    //            return '';
                    //    }
                    //},

                    {
                        "sTitle": "Download CV", "mData": null, "bSortable": false, "mRender": function (Data) {
                            if (Data.cv_file_name != "")
                                return '<center><a href="' + window.location.origin + '/InstructorCVUpload/' + Data.cv_file_name + '" download style="text-decoration:none;" class="cv_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                            else
                                return '';
                        }
                    },


                    {
                        "sTitle": "Download Portfolio", "mData": null, "bSortable": false, "mRender": function (Data) {
                            if (Data.portfolio_file_name != "")
                                return '<center><a href="' + window.location.origin + '/InstructorPortfolioUpload/' + Data.portfolio_file_name + '" download style="text-decoration:none;" class="cv_portfolio" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                            else
                                return '';
                        }
                    },
                    {
                        "sTitle": "Work Experience/Personal Document", "mData": null, "sClass": "cls_action", mRender: function (data) {

                            return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'

                        }
                    },

                    /*{ "sTitle": "Past studio TA Texts", "mData": "past_studio_ta_txt", "bSortable": false },*/


                    /*{ "sTitle": "PC Remarks", "mData": "pc_remark", "bSortable": false },*/

                    {
                        "sTitle": "HR Remarks", "mData": null, "bSortable": false, "mRender": function (data) {

                            return '<textarea class="HRRemark1" id=hr_' + data.instructor_code + ' name="remark" rows="4" cols="50">' + data.hr_remark + '';


                        }
                    },


                    {
                        "sTitle": "Add Year", "mData": null, "bSortable": false, "mRender": function (data) {
                            if (data.hasOwnProperty('DegreeYear') && data.DegreeYear !== '') {
                                return data.DegreeYear;
                            }
                            else if (data.designation == 'TA' && data.highest_qualification.toUpperCase() == 'UG') {
                                return '<select class="chosen-select" style="width:70px;" onchange="changeRateBand(\'' + data.instructor_code + '\')" id="year_' + data.instructor_code + '"><option value="">--Select Year--</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>';
                            }
                            else if (data.designation.toUpperCase() == 'TEMP' && data.highest_qualification.toUpperCase() == 'UG') { return '<select class="chosen-select" style="width:70px;" onchange="changeRateBand(\'' + data.instructor_code + '\')" id="year_' + data.instructor_code + '"><option value="">--Select Year--</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>'; }
                            else { return ''; }



                        }
                    },

                    {
                        "sTitle": "Approve", "mData": null, "bSortable": false, "mRender": function (data) {

                            if (data.ApproveRateBand == "A") {
                                return '<span style="color:blue">HR Approved RateBand</span>';
                            }
                            else if (data.hr_status == "A") {
                                return '<span style="color:blue">USO HR Approved RateBand</span>';
                            }
                            else {
                                if (data.designation.trim().toUpperCase() === 'INSTRUCTOR') {
                                    return 'This is INSTRUCTOR';
                                }
                                else if (data.superviser_code != '') {
                                    return 'This is CPOP USer';;
                                }
                                else if (data.hasOwnProperty('faculty_selected') == true && data.faculty_selected == 'Y') {

                                    return '<center><button type="button" id="' + data.instructor_code + '" class="authorize">Authorize</button><span class="approval-message" style = "display:none;color:green;" > Approved successfully!</span ></center>';
                                }
                                else if (data.hasOwnProperty('faculty_selected') == true && data.faculty_selected == 'N') {
                                    return '<span style="color:red">FA Not Selected</span>';
                                }
                                else if (data.hasOwnProperty('iw_admin_approved') == true && data.iw_admin_approved == 'Y') {

                                    return '<center><button type="button" id="' + data.instructor_code + '" class="authorize">Authorize</button><span class="approval-message" style = "display:none;color:green;" > Approved successfully!</span ></center>';
                                }
                                else if (data.hasOwnProperty('iw_admin_approved') == true && data.iw_admin_approved == '') {

                                    if ($('#drptype').val() == 'Course') {
                                        return '<center><button type="button" id="' + data.instructor_code + '" class="authorize">Authorize</button><span class="approval-message" style = "display:none;color:green;" > Approved successfully!</span ></center>';
                                    }
                                    else { return 'Dean Not Approve'; }

                                }




                                else if (data.hasOwnProperty('faculty_selected') == false) {
                                    return '<center><button type="button" id="' + data.instructor_code + '" class="authorize">Authorize</button><span class="approval-message" style = "display:none;color:green;" > Approved successfully!</span ></center>';
                                }

                                else {
                                    return '';
                                }
                            }



                        }
                    },

                    {
                        "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.ApproveRateBand != "A") {
                                return '<center><button type="button" id=hrremark_' + data.instructor_code + ' class="HRRemark">Remark</button></center >';
                            }
                            else { return ''; }

                        }
                    },

                    {
                        "sTitle": "Personal Details Save/Submit Date", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.createddate != "") {
                                return data.createddate;
                            }
                            else { return ''; }

                        }
                    },
                ]
            });
            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);
            //adding input box in thead second row 
            //$("#example tr:nth-child(2) th").length (Remove because of Download)
            for (var i = 0; i < 4; i++) {
                var title = $('#example thead th').eq(i).text();
                $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            };
            $("thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("thead input").index(this));
            });
            $("thead input").each(function (i) {
                asInitVals[i] = this.value;
            });
            $("thead input").focus(function () {
                if (this.className == "search_init") {
                    this.className = "";
                    this.value = "";
                }
            });
            $("thead input").blur(function (i) {
                if (this.value == "") {
                    this.className = "search_init";
                    this.value = asInitVals[$("thead input").index(this)];
                }
            });
            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }


        $(document).on("click", ".authorize", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["instructor_code"];
            var instructor_name = aData["instructor_name"];
            var inst_designation = aData["designation"];
            var mail = aData["mail"];

            var remark_details = "";
            remark_details =
            {
                "instructor_code": aData["instructor_code"],
                "inst_designation": aData["designation"],
            };

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

            var selecttype = $('#drptype').val();
            if (selecttype == "") {
                bootbox.alert('Please select Type');
                $('#drptype').focus();
                return false;
            }
            var DegreeYear = $('#year_' + aData["instructor_code"]).val();
            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }
            $.ajax({

                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/UpdateRateBandData",
                data: "{sem_code:'" + semester + "',year_code:'" + year_code + "',inst_code:'" + instructor_code + "',selecttype:'" + selecttype + "',DegreeYear:'" + DegreeYear + "'}",
                async: false,
                dataType: "json",
                success: function (data) {
                    if (data.d == "True") {

                        $('tr td #' + instructor_code).hide();
                        $('tr td #' + instructor_code).siblings('.approval-message').show();
                        if (inst_designation.trim().toUpperCase() == 'TEMP') {
                            convert_VF_Type(instructor_code, instructor_name, mail, selecttype);
                        }
                        bootbox.alert("HR Approved RateBand Successfully");
                        return false;
                    }
                    else {
                        bootbox.alert("RateBand is Not Approved ");
                        return false;
                    }
                }

            });

            return false;
        });


        $(document).on("click", ".HRRemark", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            var instructor_code = aData["instructor_code"];
            var instructor_name = aData["instructor_name"];
            var inst_designation = aData["designation"];
            remark_details =
            {
                "instructor_code": aData["instructor_code"],
                "inst_designation": aData["designation"],
                "remark": $('#hr_' + aData["instructor_code"]).val().replace(/[&<>"'\/]/g, function (s) { return entityMap[s]; }),
            };



            if ($('#hr_' + aData["instructor_code"]).val() == "") {
                bootbox.alert('Please Enter Remark');
                return false;
            }


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
            var selecttype = $('#drptype').val();
            if (selecttype == "") {
                bootbox.alert('Please select Type');
                $('#drptype').focus();
                return false;
            }

            var interested_remark_data = [];
            interested_remark_data.push(remark_details);
            var json_submit_data = JSON.stringify(interested_remark_data);
            if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
            if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/UpdateRateBandRemark",
                    data: "{semester:'" + semester + "',year:'" + year_code + "',inst_code:'" + instructor_code + "',interested_remark_data: '" + json_submit_data + "',selecttype:'" + selecttype + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == "true") {
                                bootbox.alert('Remark Successfully');
                                //get_studio_detail();
                            }
                        }
                        else {
                            bootbox.alert('Problem in Data');
                            return false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });


            return false;
        });

        var entityMap = { "'": '&#39;' };

        function convert_VF_Type(instructor_code, instructor_name, email, user_type_data) {
            var user_type = "";
            if (user_type_data == 'TA') {
                user_type = "TA";
            }
            else if (user_type_data == 'AA') {
                user_type = "AA";
            }
            else { user_type = "VF"; }


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/change_instructor_mst_new_only_ta_vf",
                async: false,
                data: "{instructor_code : '" + instructor_code + "',instructor_name:'" + instructor_name + "',email:'" + email + "',flag:'S',user_type:'" + user_type + "',des_letter:'',instructor_first_name:'',instructor_last_name:''}",
                dataType: "json",
                success: function (data) {
                    var result = JSON.parse(data.d);
                    if (result["status"] != "") {
                        message_type = 'Studio Proposal,Rate Band and VF Authorized and Submit Successfully';
                    }
                    else {
                        bootbox.alert(result["message"]);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        function rowClick_edit(row) {
            var url = "vf_edit_personal_detail.aspx?ic=" + row.id + "&type=tutor";
            window.open(url, "_blank");
        }
        $(document).on("click", ".pdf_download", function (event) {

            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);


            //var instructor_code = aData["user_id"];
            var instructor_code = aData['instructor_code']
            var instructor_name = aData["instructor_name"];
            var cv_file_name = aData["cv_file_name"];
            var portfolio_file_name = aData["portfolio_file_name"];
            if (instructor_code == '') {
                if (cv_file_name != '') {
                    var myArr = cv_file_name.split("_");
                    instructor_code = myArr[0];
                }
                if (portfolio_file_name != '') {
                    var myArr = cv_file_name.split("_");
                    instructor_code = myArr[0];

                }
            }



            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            var dep_name = "";

            if (semester == 'S') {
                semester = 'Spring';
            }
            else {
                semester = 'Monsoon';
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Download_Document_new",
                data: "{'instructor_code':'" + instructor_code + "','cv_file_name':'" + cv_file_name + "','portfolio_file_name':'" + portfolio_file_name + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "1") {
                            $("#btnDownloadExcelDocuments").click();
                            return false;
                        }
                        else {
                            bootbox.alert('Document Not Found');
                        }
                        return true;
                    }
                    else {
                        bootbox.alert('Document Not Found');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
            return false;
        });

        function changeRateBand(rowid) {
            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
            var DegreeYear = $('#year_' + rowid).val();


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/GetRateBandTAYearWise",
                async: false,
                data: "{sem_code : '" + semester + "',year_code:'" + year_code + "',inst_code:'" + rowid + "',DegreeYear:'" + DegreeYear + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != '') {
                        var result = JSON.parse(data.d);
                        $('#rateband_' + rowid).text(result[0]["rate_band"])

                    }


                    //}
                    // else {
                    // bootbox.alert(result["message"]);
                    // }
                },
                error: function (result) {
                    alert(result);
                }
            });

        }



    </script>
     <input type="hidden" id="base64output" />
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" ClientIDMode="Static"/>
</asp:Content>

