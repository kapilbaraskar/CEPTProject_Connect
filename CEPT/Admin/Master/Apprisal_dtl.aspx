<%@ Page Title="Faculty Wise Apprisal Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Apprisal_dtl.aspx.cs" Inherits="Admin_Master_Apprisal_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script type="text/javascript">
        var oTable;
        var semester = "";
        var year_code = "";
        $(document).ready(function () {
            bindyear();
            $('#btnreterive').on('click', function () {
                faculty_apprisal_dtl();
                return false;
            });
           
            return false;
        });

        
        function bindyear() {
            $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
            $('#drpyear').append($("<option></option>").val("2022-2023").html("2022-2023"));
            $('#drpyear').append($("<option></option>").val("2023-2024").html("2023-2024"));
            $('#drpyear').append($("<option></option>").val("2024-2025").html("2024-2025"));
            $('#drpyear').append($("<option></option>").val("2025-2026").html("2025-2026"));

            $('#drpyear').chosen();
        }

        function faculty_apprisal_dtl() {

            $('#DataList').css('display', 'none');

             

             var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }
            $('#hdn_year').val(year_code);


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_faculty_apprisal_dtl",
                data: "{ year : '" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_faculty_approsal_dtl(data.d);
                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester or Year');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function display_faculty_approsal_dtl(data) {
            var titlestatus = true;
            if ($('#hdnusertype').val() != "HR" && $('#hdnusertype').val() != "D") {
                titlestatus = false;
            }
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Instructor Code", "mData": "instructor_code", "bSortable": false, "bVisible": true },
                    { "sTitle": "Instructor Name", "mData": "instructor_name", "bSortable": false },
                    { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    {
                        "sTitle": "Faculty Status", "mData": null, "bSortable": false, mRender: function (data) {

                           if (data.faculty_approve == 'Y') {
                               return "Submitted";
                            }
                           else { return "Pending"; }


                        }
                    },


                    //{
                    //    "sTitle": "Dean Status", "mData": null, "bSortable": false, mRender: function (data) {

                    //        if (data.dean_approve == 'Y') {
                    //            return "Approved"
                    //        }
                    //        else if (data.faculty_approve == 'N') {
                    //            return "Pending"
                    //        }
                    //        else if (data.dean_approve == 'N' && data.faculty_approve == 'Y' && $('#hdnusertype').val() == 'D') {
                    //            //return '<center><button type="button" onclick="rowClick_update(this)">Approve </button></center>';
                    //            return "";
                                
                    //        }
                    //        else { return "Pending"; }
                            

                    //    }
                    //},

                    //{
                    //    "sTitle": "HR Status", "mData": null, "bSortable": false, mRender: function (data)
                    //    {
                    //        if (data.uso_approve == 'Y') {
                    //            return "Approved"
                    //        }
                    //        else if (data.dean_approve == 'Y' && data.faculty_approve == 'Y' && data.uso_approve == 'N' && $('#hdnusertype').val() == 'HR' ) {
                    //            return '<center><button type="button" onclick="rowClick_update(this)">Approve </button></center>';
                    //        }
                    //        else { return "Pending"; }
                    //    }
                    //},

                    //{
                    //    "sTitle": "Managment Approve", "mData": null, "bSortable": false, mRender: function (data) {
                    //        if (data.managment_approve == 'Y') {
                    //            return "Approved"
                    //        }
                    //        //else if (data.dean_approve == 'Y' && data.faculty_approve == 'Y' && data.uso_approve == 'Y' && data.managment_approve == "") {
                    //        //    return '<center><button type="button" onclick="rowClick_excel(this)">Approve </button></center>';
                    //        //}
                    //        else { return "Pending"; }




                    //    }
                    //},
                    {
                        "sTitle": "Approve ", "mData": null, "bSortable": false, mRender: function (data) {
                            if ($('#hdnusertype').val() == 'D' && data.faculty_approve == 'Y' && data.dean_approve == 'N')
                            {
                                return '<center><button type="button" onclick="rowClick(this)">Approve</button></center>';
                            }
                            //else if (data.dean_approve == 'Y' && data.faculty_approve == 'Y' && data.uso_approve == 'N' && data.managment_approve == "N" && $('#hdnusertype').val() == 'HR') {
                            else if ($('#hdnusertype').val() == 'HR') {
                                return '<center><button type="button" onclick="rowClick(this)">Finalize</button></center>';
                            }
                            else if ($('#hdnusertype').val() == 'I2' && data.faculty_approve == 'N')
                            {
                                return '<center><button type="button" onclick="rowClick(this)">Approve</button></center>';
                            }
                            else { return ""; }




                        }
                    },
                    //{
                    //    "sTitle": "Send For Review", "mData": null, "bSortable": false, mRender: function (data) {
                    //        if ($('#hdnusertype').val() == 'D' && data.faculty_approve == 'Y' && data.dean_approve == 'N') {
                    //            return '<center><button type="button" onclick="rowClick_sendforreview(this)">Send For Review</button></center>';
                    //        }
                    //        else if (data.dean_approve == 'Y' && data.faculty_approve == 'Y' && data.uso_approve == 'N' && data.managment_approve == "N" && $('#hdnusertype').val() == 'HR') {
                    //            return '<center><button type="button" onclick="rowClick_sendforreview(this)">Send For Review</button></center>';
                    //        }
                    //        else { return ""; }




                    //    }
                    //},
                    {
                        "sTitle": "Download PDF", "mData": null, "bSortable": false, "mRender": function (data) {
                            var row_value = data.instructor_code;
                            if (data.dean_approve == 'Y' && ($('#hdnusertype').val() == "HR" || $('#hdnusertype').val() == "D"))
                            {
                                return '<center><button type="button" id=' + row_value + ' onclick="rowclickPDF(this)">Download</button></center>';
                            }
                            else if (data.faculty_approve == 'Y' && $('#hdnusertype').val() != "HR" && $('#hdnusertype').val() != "D")
                            {
                                return '<center><button type="button" id=' + row_value + ' onclick="rowclickPDF(this)">Download</button></center>';
                            }
                            else {
                                return "Dean Not Approve";
                            } 
                            
                        }
                    },

                    {
                        "sTitle": "Download Files", "mData": null, "bSortable": false, "mRender": function (data) {
                            var row_value = data.instructor_code;
                            var str = '';
                            if (data.uplodaFile1 != '') {
                                const fileUrl = '/ApprisalFileUploads/' + data.uplodaFile1;
                                str += `<a href="${fileUrl}" target="_blank" download class="download-link">${data.uplodaFile1}</a><br>`;
                            }
                            if (data.uplodaFile2 != '') {
                                const fileUrl = '/ApprisalFileUploads/' + data.uplodaFile2;
                                str += `<a href="${fileUrl}" target="_blank" download class="download-link">${data.uplodaFile2}</a><br>`;
                            }
                            if (data.uplodaFile3 != '') {
                                const fileUrl = '/ApprisalFileUploads/' + data.uplodaFile3;
                                str += `<a href="${fileUrl}" target="_blank" download class="download-link">${data.uplodaFile3}</a>`;
                            }
                            return str;
                        }
                    },

                    {
                        "sTitle": "Download PDF Without Comment", "mData": null, "bSortable": false, "bVisible": titlestatus, "mRender": function (data) {
                            var row_value = data.instructor_code;
                            if (data.faculty_approve == 'Y') {
                                return '<center><button type="button" id=' + row_value + ' onclick="rowclickPDF_without(this)">Download</button></center>';
                            }
                            else {
                                return "Faculty Not Submited";
                            }

                        }
                    }
                    //,{
                    //    "sTitle": "Download PDF New", "mData": null, "bSortable": false, "mRender": function (data) {
                    //        var row_value = data.instructor_code;
                    //        if (data.faculty_approve == 'Y')
                    //        {
                    //            return '<center><button type="button" id=' + row_value + ' onclick="rowclickPDF(this)">Download</button></center>';
                    //        }
                    //        else
                    //        {
                    //            return "";
                    //        }

                    //    }
                    //}


                ],
                fnRowCallback: function (nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    if (aData.faculty_approve == "Y")
                    {
                        //$('td', nRow).css('background-color', 'orange');
                        $('td', nRow).css('background-color', 'rgb(209, 213, 210)');
                    }
                    else if (aData.faculty_approve == "P")
                    {
                        //$('td', nRow).css('background-color', 'rgb(209, 213, 210)');
                    }
                },
            });

            $('#DataList').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function rowClick(row)
        {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
            var year = $('#drpyear').val();
            window.open("Faculty_apprisal_dtl.aspx?c=" + rowId + "&y=" + year, "_blank");
        }

        function rowClick_download(row) {

            $('#hdn_user_id').val(row.id);
           // showLoader();
            $('#btndownloadpdf').click();
        }
        function rowClick_download_without(row) {

            $('#hdn_user_id').val(row.id);
           // showLoader();
            $('#btndownloadpdf_without').click();
        }


        function showLoader() {
            Swal.fire({
                title: 'Generating PDF...',
                text: 'Please wait while the PDF is being generated.',
                allowOutsideClick: false,
                timer: 3000,
                didOpen: () => {
                    Swal.showLoading();
                }
            });
        }

        function hideLoader() {
            Swal.close();
        }
        function rowClick_sendforreview(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
            var year = $('#drpyear').val();
            faculty_sendforreview(rowId);

        }

        function faculty_apprisal_update_dtl(inst_code) {

            $('#DataList').css('display', 'none');
            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/update_apprisal_dtl",
                async: false,
                data: "{ inst_code: '" + inst_code + "',year: '" + year_code + "' }",
                dataType: "json",
                success: function (data) {
                    if (data.d == true)
                    {
                        
                            bootbox.alert('Self Evaluation Details Approved Successfully', function () {
                                //location.reload();
                            });
                        
                        
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function faculty_sendforreview(inst_code) {

            $('#DataList').css('display', 'none');



            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/faculty_send_for_review",
                async: false,
                data: "{ inst_code: '" + inst_code + "',year: '" + year_code + "' }",
                dataType: "json",
                success: function (data) {
                    if (data.d == true) {

                        bootbox.alert('Self Evaluation Details Approved Successfully', function () {
                            //location.reload();
                        });


                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        function rowClick_pdf(row)
        {
            var file_path = location.origin + "/AttendancePdfUpload/" + row.id;
            window.open(file_path, "_blank");
            
        }

        function rowClick_update(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
            faculty_apprisal_update_dtl(rowId);

        }

        function rowclickPDF(row) {
            var yearcode = $('#drpyear').val();
            var inst = row.id;
            var status = 'S';
            showLoader();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/CreatPDF",
                async: false,
                data: "{ yearcode: '" + yearcode + "',inst: '" + inst + "',status: '" + status + "',user_id:'" + $('#hdnuserid').val()+"' }",
                dataType: "json",
                success: function (data) {
                    if (data.d != null && data.d != "") {
                        hideLoader();
                        var path = JSON.parse(data.d)
                        const pdfUrl = window.location.origin + '/SelfEvaluationPdfs/'+ path.htmlContent;
                        const link = document.createElement('a');
                        link.href = pdfUrl;
                        //link.download = inst + '_' + yearcode + '.pdf'; // Set the file name to download
                        link.download = 'SelfEvaluation.pdf'; // Set the file name to download
                        link.style.display = 'none';
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link); // Clean up

                    }
                },
                error: function (result) {
                    hideLoader();
                    alert(result);
                }
            });


            //$('#btndownloadpdf_without').click();
        }
       
        function rowclickPDF_without(row) {
            var yearcode = $('#drpyear').val();
            var inst = row.id;
            var status = 'W';
            showLoader();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/CreatPDF",
                async: false,
                data: "{ yearcode: '" + yearcode + "',inst: '" + inst + "',status: '" + status + "',user_id:'" + $('#hdnuserid').val() +"' }",
                dataType: "json",
                success: function (data) {
                    if (data.d != null && data.d != "") {
                        hideLoader();
                        var path = JSON.parse(data.d)
                        const pdfUrl = window.location.origin + '/SelfEvaluationPdfs/' + path.htmlContent;
                        const link = document.createElement('a');
                        link.href = pdfUrl;
                        //link.download = inst + '_' + yearcode + '.pdf'; // Set the file name to download
                        link.download = 'SelfEvaluation.pdf'; // Set the file name to download
                        link.style.display = 'none';
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link); // Clean up

                    }
                },
                error: function (result) {
                    hideLoader();
                    alert(result);
                }
            });


            //$('#btndownloadpdf_without').click();
        }
    </script> 
    <style>
       .download-link {
        display: inline-block;
        color: #fff;
        background-color: #17a2b8; /* soft blue */
        padding: 3px 8px;
        margin: 2px 0;
        font-size: 12px;
        border-radius: 3px;
        text-decoration: none;
        font-family: sans-serif;
        transition: background-color 0.2s ease;
    }

    .download-link:hover {
        background-color: #117a8b;
        text-decoration: none;
    }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     
    <div class="row-fluid">
         
        <div class="page-header position-relative">

            <h1>
                <i class="icon-desktop"></i> Faculty Wise Appraisal Details
            </h1>
        </div>
    </div>
    <div>
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                       
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div>


            <div id="DataList" style="display: none; overflow: auto;" class="panel panel-default">
                <div class="panel-heading">
                    <strong id="panel_head">Faculty Wise Appraisal Details</strong>
                </div>
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
     
    <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
     <input type="hidden" id="hdn_year" runat="server" clientidmode="Static" />
    <asp:Button ID="btndownloadpdf" runat="server" Style="display: none;" ClientIDMode="Static" OnClick="btndownloadpdf_Click" />
    <asp:Button ID="btndownloadpdf_without" runat="server" Style="display: none;" ClientIDMode="Static" OnClick="btndownloadpdf_without_Click" />
    
</asp:Content>

