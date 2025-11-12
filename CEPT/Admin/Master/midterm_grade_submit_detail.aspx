<%@ Page Title="MidTerm Grade Status" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="midterm_grade_submit_detail.aspx.cs" Inherits="Admin_Master_midterm_grade_submit_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <script src="../../Js/course_wise_entered_marks.js?t=22092022" type="text/javascript"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            $('#btnreterive_grade').on('click', function () {
                course_wise_entered_marks();
                return false;
            });
        });

        function course_wise_Grade_submit_dtl(data) {

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
                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Title", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Faculty Approval", "mData": "faculty_approved", "bSortable": false },
                    { "sTitle": "Coordinator Approval", "mData": "progcoordinate_approved", "bSortable": false }

                    //{
                    //    "sTitle": "", "mData": null, "bSortable": false, mRender: function (data) {
                    //        return '<center><button type="button" onclick="rowClick_view(this)">View</button></center>';
                    //    }
                    //}
                ]
            });

            var thead = $('<tr class="dt"></tr>');
            $('#example thead th').each(function (i, r) {
                var nm = $('#example thead th').eq($(this).index()).text();
                thead.append('<th></th>');
            });
            $('#example thead').append(thead);
            //adding input box in thead second row  
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
            //$('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
            if ($('#hdnusertype').val() == 'A1') {
                $('#div_btn').html('<button id="btn_publish_all" type="button" class="btn btn-lg btn-primary" onclick="publish_all()">Publish All</button>');
            }
        }

        function course_wise_entered_marks() {
            $('#DataList').css('display', 'none');
            $('#div_btn').html('');

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

            //prog_code = $('#drpprog').val();
            //prog_level_code = $('#drpproglevel').val();

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Get_MidTerm_Grade_Submission_dtl",
                    //async: false,
                    data: "{semester_type:'" + semester + "',year_semester:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            course_wise_Grade_submit_dtl(data.d);    
                            $('#div_course_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            $('#div_course_list').css('display', 'none');
                           
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            return false;
        }


        function getParameterByName(name) {
            name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
            var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
            results = regex.exec(location.search);
            return results == null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>MidTerm Grade Submit Detail
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
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
                                    Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnreterive_grade">
                                        Retrieve
                                    </button>
                                </td>
                                <%--<td>
                                    Programme
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpprog">
                                    </select>
                                </td>--%>
                            </tr>
                            <tr>
                                <%--<td>
                                    Programme Level
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpproglevel">
                                    </select>
                                </td>--%>
                                
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_course_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>MmidTerm Grade Submit Detail</strong>
            </div>
            <div>
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
     
         <input type="hidden" id="hdn_degination" runat="server" clientidmode="Static" />
    </div>

</asp:Content>

