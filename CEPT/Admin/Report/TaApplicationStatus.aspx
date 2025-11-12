<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="TaApplicationStatus.aspx.cs" Inherits="Admin_Report_TaApplicationStatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?t=22082022" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {

            /*bootbox.alert("Please ensure that you have submitted the latest Grade Range from \"Course Wise Grade Range\".");*/
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            // bindprogrammedata();
            // bindproglevel();
            // bindprogramme();
            // bindEnrollmentyeardata();
            // get_fauser_detail();
            // $("#hdn_check").val("false");
            // $('input[type="checkbox"]').click(function(){
            // if($(this).prop("checked") == true){
            //     //alert("Checkbox is checked.");
            //     $("#hdn_check").val("true");
            // }
            // else if($(this).prop("checked") == false){
            //     //alert("Checkbox is unchecked.");
            //     $("#hdn_check").val("false");
            // }
            // });

            $('#btnreterive').on('click', function () {
                retrieve_Student_Data();
                return false;
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;TA Application Status
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
                <%--<div style="float: right;">
                    <input type="checkbox" name="vehicle" style="margin-bottom: 5px;"><b> Old Version</b>
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
                                <td class="cls_dept_prog">Department :
                                </td>
                                <td class="cls_dept_prog">
                                    <select class="chosen-select" id="drpdepartment" />
                                </td>
                            </tr>
                            <%--<tr>
                                <td>Programme :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>
                                <td>Program Level :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>
                                <td>Enrollment Year
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpenrollmentyear">
                                    </select>
                                </td>
                            </tr>--%>
                            <tr style="text-align: center;">
                                <td colspan="6">
                                    <button class="btn btn-primary" type="submit" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                                <%-- <td style="float: right;">
                                   <input type="checkbox" name="vehicle">Old Version 
                                </td>--%>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_stud_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>TA Application Status</strong> <span style="float: right;">
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
    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var dept_code = '';
        var prog_code = '';
        var prog_level_code = '';
        var asInitVals = new Array();

        function get_fauser_detail() {
            if ($('#hdnusertype').val() == 'FA') {

                $('.cls_dept_prog').css('display', 'none');

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

            dept_code = $('#drpdepartment').val();
            // if (dept_code == "") {
            //     bootbox.alert('Please select Department');
            //     $('#drpdepartment').focus();
            //     return false;
            // }

            // prog_code = $('#drpprog').val();
            // if (prog_code == "") {
            //     bootbox.alert('Please select Programme');
            //     $('#drpprog').focus();
            //     return false;
            // }
            // 
            // prog_level_code = $('#drpproglevel').val();
            // year_of_enrollment = $('#drpenrollmentyear').val();

            // var filter_criteria = { sem_code: semester, year: year_code, dept: dept_code, prog: prog_code };
            // $('#hdn_filter').val(JSON.stringify(filter_criteria));

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/GetTaApplicationData",
                    /*data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',prog_level_code:'" + prog_level_code + "',year_of_enrollment:'" + year_of_enrollment + "'}",*/
                    data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "'}",
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

        function bindEnrollmentyeardata() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
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
                scrollX: true,
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Name", "mData": "user_name", "bSortable": false },
                    { "sTitle": "Mail", "mData": "mail", "bSortable": false },
                    { "sTitle": "Mobile No", "mData": "mobile_no", "bSortable": false },
                    { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Programe Name", "mData": "prog_name", "bSortable": false },
                    { "sTitle": "Programe Level Name", "mData": "prog_level_name", "bSortable": false },
                    { "sTitle": "Submitted/Saved", "mData": "is_submit", "bSortable": false },

                    {
                        "sTitle": "Faculty Selected By", "mData": null, "bSortable": false, "mRender": function (Data) {
                            if (Data.faculty_selected == "N") {
                                return 'Pending';
                            }
                            else if (Data.faculty_selected == "Y") {
                                return Data.faculty_selected_by;
                            }
                            else {
                                return '';
                            }

                        }
                    },

                    {
                        "sTitle": "HR Approved", "mData": null, "bSortable": false, "mRender": function (Data) {
                            if (Data.faculty_selected == "Y") {
                                return Data.hr_approved;
                            }
                            else { return ''; }

                        }
                    },
                    {
                        "sTitle": "Download Reference Letter", "mData": null, "bSortable": false, "mRender": function (Data) {
                            if (Data.refrence_letter_path != "")
                                return '<center><a href="' + window.location.origin + '/TAReferenceLetter/' + Data.refrence_letter_path + '" download style="text-decoration:none;" class="cv_refrence" title="Download Document"><i class="icon-download-alt" style ="font-size:17px;"></i></a></center>';
                            else
                                return '';
                        }
                    },

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


                    { "sTitle": "Past studio TA Texts", "mData": "past_studio_ta_txt", "bSortable": false },
                    { "sTitle": "Total Experience In Moths", "mData": "total_experiance", "bSortable": false },
                    { "sTitle": "Rate Band", "mData": "rate_band", "bSortable": false },
                    { "sTitle": "Remarks", "mData": "remark", "bSortable": false },
                    { "sTitle": "Studio Code", "mData": "studio_code", "bSortable": false },
                    { "sTitle": "Studio Title", "mData": "studio_title", "bSortable": false },
                    { "sTitle": "Apply Type", "mData": "apply_type", "bSortable": false },
                ]
            });
            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);

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
    </script>
</asp:Content>