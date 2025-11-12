<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ApproveRateBandReport.aspx.cs" Inherits="Admin_Report_ApproveRateBandReport" %>

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

           
            bindyeardata_for_cross_reg();
            bindsemdata();
          

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

   

        });

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
                                        <option value="VF">Studio Tutor</option>
                                        <option value="TA">TA</option>
                                        <option value="AA">AA</option>
                                        <option value="Course">Course Tutor</option>
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
                    data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',selecttype: '" + selecttype + "',type: 'Report'}",
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


                    //{
                    //    "sTitle": "Personal Details", "mData": null, "bSortable": false, mRender: function (data) {

                    //        var row_value = data.instructor_code;
                    //        return '<center><button type="button" id=' + row_value + ' onclick="rowClick_edit(this)" class="per_edit">Edit</button></center>';

                    //    }
                    //},
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

                    //{
                    //    "sTitle": "Download CV", "mData": null, "bSortable": false, "mRender": function (Data) {
                    //        if (Data.cv_file_name != "")
                    //            return '<center><a href="' + window.location.origin + '/InstructorCVUpload/' + Data.cv_file_name + '" download style="text-decoration:none;" class="cv_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    //        else
                    //            return '';
                    //    }
                    //},


                    //{
                    //    "sTitle": "Download Portfolio", "mData": null, "bSortable": false, "mRender": function (Data) {
                    //        if (Data.portfolio_file_name != "")
                    //            return '<center><a href="' + window.location.origin + '/InstructorPortfolioUpload/' + Data.portfolio_file_name + '" download style="text-decoration:none;" class="cv_portfolio" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                    //        else
                    //            return '';
                    //    }
                    //},
                    //{
                    //    "sTitle": "Work Experience/Personal Document", "mData": null, "sClass": "cls_action", mRender: function (data) {

                    //        return '<center><a href="#" style="text-decoration:none;" class="pdf_download" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>'

                    //    }
                    //},

                    /*{ "sTitle": "Past studio TA Texts", "mData": "past_studio_ta_txt", "bSortable": false },*/


                    /*{ "sTitle": "PC Remarks", "mData": "pc_remark", "bSortable": false },*/

                    //{
                    //    "sTitle": "HR Remarks", "mData": null, "bSortable": false, "mRender": function (data) {

                    //        return '<textarea class="HRRemark1" id=hr_' + data.instructor_code + ' name="remark" rows="4" cols="50">' + data.hr_remark + '';


                    //    }
                    //},


                    //{
                    //    "sTitle": "Add Year", "mData": null, "bSortable": false, "mRender": function (data) {
                    //        if (data.hasOwnProperty('DegreeYear') && data.DegreeYear !== '') {
                    //            return data.DegreeYear;
                    //        }
                    //        else if (data.designation == 'TA' && data.highest_qualification.toUpperCase() == 'UG') {
                    //            return '<select class="chosen-select" style="width:70px;" onchange="changeRateBand(\'' + data.instructor_code + '\')" id="year_' + data.instructor_code + '"><option value="">--Select Year--</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>';
                    //        }
                    //        else if (data.designation.toUpperCase() == 'TEMP' && data.highest_qualification.toUpperCase() == 'UG') { return '<select class="chosen-select" style="width:70px;" onchange="changeRateBand(\'' + data.instructor_code + '\')" id="year_' + data.instructor_code + '"><option value="">--Select Year--</option><option value="3">3</option><option value="4">4</option><option value="5">5</option></select>'; }
                    //        else { return ''; }



                    //    }
                    //},

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

                                    return '';
                                    //return '<center><button type="button" id="' + data.instructor_code + '" class="authorize">Authorize</button><span class="approval-message" style = "display:none;color:green;" > Approved successfully!</span ></center>';
                                }
                                else if (data.hasOwnProperty('faculty_selected') == true && data.faculty_selected == 'N') {
                                    return '<span style="color:red">FA Not Selected</span>';
                                }
                                else if (data.hasOwnProperty('iw_admin_approved') == true && data.iw_admin_approved == 'Y') {

                                   // return '<center><button type="button" id="' + data.instructor_code + '" class="authorize">Authorize</button><span class="approval-message" style = "display:none;color:green;" > Approved successfully!</span ></center>';
                                    return '';
                                }
                                else if (data.hasOwnProperty('iw_admin_approved') == true && data.iw_admin_approved == '') {

                                    if ($('#drptype').val() == 'Course') {
                                        //return '<center><button type="button" id="' + data.instructor_code + '" class="authorize">Authorize</button><span class="approval-message" style = "display:none;color:green;" > Approved successfully!</span ></center>';
                                        return '';
                                    }
                                    else { return 'Dean Not Approve'; }

                                }




                                else if (data.hasOwnProperty('faculty_selected') == false) {
                                    //return '<center><button type="button" id="' + data.instructor_code + '" class="authorize">Authorize</button><span class="approval-message" style = "display:none;color:green;" > Approved successfully!</span ></center>';
                                    return '';
                                }

                                else {
                                    return '';
                                }
                            }



                        }
                    },

                    //{
                    //    "sTitle": "Action", "mData": null, "bSortable": false, mRender: function (data) {
                    //        if (data.ApproveRateBand != "A") {
                    //            return '<center><button type="button" id=hrremark_' + data.instructor_code + ' class="HRRemark">Remark</button></center >';
                    //        }
                    //        else { return ''; }

                    //    }
                    //},

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

        function rowClick_edit(row) {
            var url = "vf_edit_personal_detail.aspx?ic=" + row.id + "&type=tutor";
            window.open(url, "_blank");
        }

     



    </script>
     <input type="hidden" id="base64output" />
</asp:Content>

