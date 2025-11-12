<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="TravelDetails.aspx.cs" Inherits="Admin_Report_TravelDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        $(document).ready(function ()
        {
            bindyeardata_for_cross_reg();
            bindsemdata();
            

            $('#btnreterive').on('click', function () {
                retrieve_Data();
                return false;
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


        function retrieve_Data() {
            $('#DataList').css('display', 'none');
            $('#div_stud_list').css('display', 'none');

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


            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetTRFDetails",
                    data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',userid: ''}",
                    dataType: "json",
                    success: function (data) {

                        if (data.d != "") {
                            display_Student_Data(data.d);
                        }
                        else
                        {
                            bootbox.alert('No data Found For Selected Semester or Year');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            return false;
        }


        function display_Student_Data(data) {

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
               
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Doc No", "mData": "TRF_doc", "bSortable": false },
                    { "sTitle": "Name", "mData": "instructor_name", "bSortable": false },
                    { "sTitle": "Mail", "mData": "mail", "bSortable": false },
                    { "sTitle": "Mobile No", "mData": "mobile_no", "bSortable": false },

                    {
                        "sTitle": "Status", "mData": null, "bSortable": false, "mRender": function (Data) {
                            if (Data.FacultyStatus == "N") {
                                return 'Pending';
                            }
                            else if (Data.FacultyStatus == "Y") {
                                return 'Submitted';
                            }
                            else
                            {
                                return '';
                            }

                        }
                    },

                    {
                        "sTitle": "Edit-View", "mData": null, "bSortable": false, "mRender": function (Data) {
                            //if (Data.FacultyStatus == "N")
                            //{
                                return '<center><button class="btn btn-primary" type="button" onclick="rowClick(this)">Edit/View</button></center>';
                            //}
                            //else if (Data.FacultyStatus == "Y")
                            //{
                            //    return '';
                            //}
                            //else {
                            //    return '';
                            //}

                        }
                    },

                    {
                        "sTitle": "Download", "mData": null, "bSortable": false, "mRender": function (Data) {
                            if (Data.FacultyStatus == "Y") {
                                return '<center><button class="btn btn-primary" type="button" id=' + Data.TRF_doc + ' onclick="rowclickPDF(this)">Download</button></center>';
                            }
                            else {
                                return '';
                            }

                        }
                    },
                   
                    //{
                    //    "sTitle": "Download PDF", "mData": null, "bSortable": false, "mRender": function (Data) {
                    //        if (Data.refrence_letter_path != "")
                    //            return '<center><a href="' + window.location.origin + '/TAReferenceLetter/' + Data.refrence_letter_path + '" download style="text-decoration:none;" class="cv_refrence" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    //        else
                    //            return '';
                    //    }
                    //},

                   


                    
                ]
            });
            
            $('#DataList').css('display', 'block');
            $('#div_stud_list').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        function rowClick(row) {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[0].childNodes[0].nodeValue;
            //var url = "frmcoursemaster.aspx?c=" + rowId + "&s=" + cur_sem + "&y=" + cur_year;
            var url = "../Master/FacultyTravelDetails.aspx?doc=" + rowId;
            window.open(url, '_blank');
        }

        function rowClick_new() {
            
            var url = "../Master/FacultyTravelDetails.aspx?doc=new";
            window.open(url, '_blank');
        }


        function rowclickPDF(row) {
          
            var doc_no = row.id;
            var status = 'S';
            //showLoader();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/CreatePDFForTRF",
                async: false,
                data: "{ doc_no: '" + doc_no + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != null && data.d != "") {
                        //hideLoader();
                        var path = JSON.parse(data.d)
                        const pdfUrl = window.location.origin + '/TravelFormPdfs/' + path.htmlContent;
                        const link = document.createElement('a');
                        link.href = pdfUrl;
                        //link.download = inst + '_' + yearcode + '.pdf'; // Set the file name to download
                        link.download = 'TravelForm.pdf'; // Set the file name to download
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Travel Details
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
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
                                <td>
                                     <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                                <td><button class="btn btn-primary" type="button" onclick="rowClick_new()">Apply New TRF</button></td>
                            </tr>
                            
                           
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_stud_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Travel Details</strong> <span style="float: right;">
                    <%--<asp:Button ID="btn_download_all" class="btn btn-primary" runat="server" Text="Download All" OnClick="Button1_Click" style="height: 40px;margin-top: -10px;"/>--%>
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
        <%--<asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="Download_Student_Grade_Report" />--%>

        <a href="#" id="Link" download="outline.pdf">Download</a>
    </div>
</asp:Content>

