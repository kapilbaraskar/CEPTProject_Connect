<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="studio_tutor_report.aspx.cs" Inherits="Admin_Report_studio_tutor_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
       
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            
           $('#btnreterive').on('click', function () {
              get_studio_dtl();
               return false;
           });

        });
        function rowClick(row)
        {
            var rowId = row.parentElement.parentElement.parentElement.childNodes[5].childNodes[0].nodeValue;
            var pageURL = $(location).attr("href");
            pageURL = pageURL.replace("Report", "Master");
            pageURL = pageURL.replace("Studio_Tutor_dtl.aspx", "vf_edit_personal_detail.aspx?ic=" + rowId);
            window.location = pageURL;//"vf_edit_personal_detail.aspx?ic=" + rowId;
        }

        function app_rowClick(row) {

            var instructor_code = row.parentElement.parentElement.parentElement.childNodes[1].childNodes[0].nodeValue;
            var instructor_name = row.parentElement.parentElement.parentElement.childNodes[3].childNodes[0].nodeValue;
           
            var semester = $('#drpsemester').val();
            var year_code = $('#drpyear').val();
            var temp = {};
            temp["id"] = instructor_code;
            temp["name"] = instructor_name;
            temp["s"] = semester;
            temp["y"] = year_code;
            $("#exDocuments").val(JSON.stringify(temp));
            $("#btnDownloadExcelDocuments").click();
            return false;
            
        }
        

        function bindsemdata() {
            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));
            $('#drpsemester').chosen();
        }
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


        var semester = '';
        var year_code = '';
        var oTable;


        $(document).on("click", ".pdf_download", function (event) {
            var row = $(this).closest("tr").get(0);
            var aData = oTable.fnGetData(row);
            
            var instructor_code = aData["instructor_code"];
            var instructor_name = aData["instructor_name"];
            var cv_file_name = aData["cv_file_name"];
            var portfolio_file_name = aData["portfolio_file_name"];
            var ppt_video = aData["ppt_video"];
            var studio_brief = aData["studio_brief"];
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
                url: "../../WebService.asmx/Download_Document",
                data: "{'instructor_code':'" + instructor_code + "','cv_file_name':'" + cv_file_name + "','portfolio_file_name':'" + portfolio_file_name + "','ppt_video':'" + ppt_video + "','studio_brief':'" + studio_brief + "','weekly_excercises_path':''}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        if (data.d == "1")
                        {
                           //window.open('http://localhost:1121/' + 'InstructorCVUpload' + '/' + instructor_code +'_' + 'Document.zip', '_blank');
                           // window.open('http://localhost:1121/' + 'InstructorCVUpload' + '/' + 'Document.zip', '_blank');
                           // window.open('https://connect.cept.ac.in/' + 'InstructorCVUpload' + '/' +'Document.zip', '_blank');
                            
                            $("#btnDownloadPDFDocuments").click();
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


        function get_studio_dtl() {
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
            
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_studio_tutor_dtl",
                    //async: false,
                    data: "{semester:'" + semester + "',year:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            display_studio_detail(data.d);
                            $('#div_studio_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }

        function set_table_columns(row) {
            var columns = [];

            columns.push({ "sTitle": "VF Code", "mData": "VF_code", "sClass": "cls_hide" });
            //columns.push({ "sTitle": "CV File Name", "mData": "cv_file_name", "sClass": "cls_hide" });
            //columns.push({ "sTitle": "Portfolio File Name", "mData": "portfolio_file_name", "sClass": "cls_hide" });
            //columns.push({ "sTitle": "PPT File Name", "mData": "ppt_video", "sClass": "cls_hide" });
            //columns.push({ "sTitle": "Studio File Name", "mData": "studio_brief", "sClass": "cls_hide"  });
            columns.push({ "sTitle": "Instructor Code", "mData": "instructor_code" });
            columns.push({
                "sTitle": "Download", "mData": null, "sClass": "cls_action", mRender: function (data) {
                    
                        return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'
                    
                }
            });

            columns.push({ "sTitle": "Instructor Name", "mData": "instructor_name" });
            columns.push({ "sTitle": "Email Id", "mData": "mail" });
            columns.push({ "sTitle": "Contact", "mData": "mobile_no" });

            var view_column = {
                "sTitle": "View", "mData": null, "bSortable": false, mRender: function (data) {
                   
                    return '<center><button type="button" onclick="rowClick(this)">View</button></center>'
                }
            };
            //columns.push(view_column);
            var excel_column = {
                "sTitle": "Persional Details", "mData": null, "bSortable": false, mRender: function (data) {

                    return '<center><button type="button" onclick="app_rowClick(this)">Excel</button></center>'
                }
            };

           columns.push(excel_column);
            
            return columns;
        }

        function display_studio_detail(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"oTableTools": {
                //    "aButtons": [
                //        //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},

                "aaData": JSON.parse(data),

                "aoColumns": columns

            });

            $('#DataList').css('display', 'block');

            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            $('#example thead tr')[0].children[0].style.display = 'none';
            

            $("#example tbody tr").each(function (i) {
               
                $(this).children().eq(0)[0].style.display = 'none';
               
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Studio Tutor Report
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>
                                    Year of allocation :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                                </tr>
                           
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="div_studio_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Studio Tutor Report</strong>
            </div>
            <div>    
                <div id="DataList" style="display: none;overflow:auto">
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
    <asp:HiddenField ID="exDocuments" runat="server" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadExcelDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadExcelDocuments_Click" ClientIDMode="Static" />
    <asp:Button ID="btnDownloadPDFDocuments" runat="server" Text="Documents" Style="display: none;" OnClick="btnDownloadPDFDocuments_Click" ClientIDMode="Static" />
</asp:Content>

