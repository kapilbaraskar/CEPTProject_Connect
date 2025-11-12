<%@ Page Title="Vertical Studio Preferences Seats Details" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="vertical_studio_course_wise_seats_dtl.aspx.cs" Inherits="Admin_Report_vertical_studio_course_wise_seats_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />

    <script type="text/javascript">
        var oTable;
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindprogrammedata();
            $('#btnreterive').on('click', function () {
                seats_report_data();
                return false;
            });

            return false;
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

        function binddepartment() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_department_data",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        var sem_data = JSON.parse(data.d)

                        $('#drpdepartment').empty().append($("<option></option>").val("").html("-- Please Select Department --"));

                        for (var i = 0; i < sem_data.length; i++) {
                            $('#drpdepartment').append($("<option></option>").val(sem_data[i]["dept_code"]).html(sem_data[i]["dept_name"]));
                        }

                        $('#drpdepartment').chosen();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function bindprogrammedata() {
            $('#drpprog').empty().append($("<option></option>").val("").html("-- Please Select Programme --"));

            $('#drpprog').append($("<option></option>").val("1").html("Undergraduate"));
            $('#drpprog').append($("<option></option>").val("2").html("Postgraduate"));
            $('#drpprog').append($("<option></option>").val("3").html("Doctoral"));

            $('#drpprog').chosen();
        }

        function seats_report_data() {
            $('#DataList').css('display', 'none');

            var semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester')
                $('#drpsemester').focus();
                return false;
            }

            var year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year')
                $('#drpyear').focus();
                return false;
            }

            var dept_code = $('#drpdepartment').val();
            var prog_code = $('#drpprog').val();


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_Calculate_Vertical_Studio_Seats",
                data: "{sem_code: '" + semester + "',year_code:'" + year_code + "',dept_code: '" + dept_code + "',prog_code:'" + prog_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        Display_report(data.d);

                    }
                    else {
                        bootbox.alert('There is No data Found For Selected Semester');
                        return false;
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }


        function Display_report(data) {
            $('#DataList').css('display', 'block');

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bStateSave": false,
                "bSort": false,
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Total Seats", "mData": "available_seat", "bSortable": false },
                    { "sTitle": "Total Allocated Seats", "mData": "total_allocated_seats", "bSortable": false },
                    { "sTitle": "Total Register Seats", "mData": "total_register_seats", "bSortable": false },
                    {
                        "sTitle": "Total Remaining Seats", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.remaining_seats != '') {
                                return data.remaining_seats;
                            }
                            else { return ''; }
                        }
                    },
                    {
                        "sTitle": "Priority 1(Total Allocated Seats)", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.priority_1_allocate_seats != '') {
                                return data.priority_1_allocate_seats;
                            }
                            else { return ''; }
                        }
                    },

                    {
                        "sTitle": "Priority 2(Total Allocated Seats)", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.priority_2_allocate_seats != '') {
                                return data.priority_2_allocate_seats;
                            }
                            else { return ''; }
                        }
                    },

                    {
                        "sTitle": "Priority 3(Total Allocated Seats)", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.priority_3_allocate_seats != '') {
                                return data.priority_3_allocate_seats;
                            }
                            else { return ''; }
                        }
                    },

                    {
                        "sTitle": "Priority 4(Total Allocated Seats)", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.priority_4_allocate_seats != '') {
                                return data.priority_4_allocate_seats;
                            }
                            else { return ''; }
                        }
                    },
                    {
                        "sTitle": "Priority 1 Percentage", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Percentage_priority1 != '') {
                                return data.Percentage_priority1;
                            }
                            else { return ''; }
                        }
                    },
                    {
                        "sTitle": "Priority 2 Percentage", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Percentage_priority2 != '') {
                                return data.Percentage_priority2;
                            }
                            else { return ''; }
                        }
                    },
                    {
                        "sTitle": "Priority 3 Percentage", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Percentage_priority3 != '') {
                                return data.Percentage_priority3;
                            }
                            else { return ''; }
                        }
                    },
                    {
                        "sTitle": "Priority 4 Percentage", "mData": null, "bSortable": false, mRender: function (data) {
                            if (data.Percentage_priority4 != '') {
                                return data.Percentage_priority4;
                            }
                            else { return ''; }
                        }
                    }                    

                    
                ]
            });

            //var thead = $('<tr class="dt"></tr>');
            //$('#example thead th').each(function (i, r) {
            //    var nm = $('#example thead th').eq($(this).index()).text();
            //    thead.append('<th></th>');
            //});
            //$('#example thead').append(thead);

            ////adding input box in thead second row 

            //for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
            //    var title = $('#example thead th').eq(i).text();
            //    $('#example thead tr:nth-child(n+2) th').eq(i).html("<input type='text' id='" + i + "'class='search_init' style='width: 56px;'>");
            //};

            //$("thead input").keyup(function () {
            //    /* Filter on the column (the index) of this element */
            //    oTable.fnFilter(this.value, $("thead input").index(this));
            //});

            //$("thead input").each(function (i) {
            //    asInitVals[i] = this.value;
            //});

            //$("thead input").focus(function () {
            //    if (this.className == "search_init") {
            //        this.className = "";
            //        this.value = "";
            //    }
            //});

            //$("thead input").blur(function (i) {
            //    if (this.value == "") {
            //        this.className = "search_init";
            //        this.value = asInitVals[$("thead input").index(this)];
            //    }
            //});

            $('#DataList').css('display', 'block');
            //$('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }
    </script>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Vertical Studio Preferences Seats Details
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

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

                    </tr>
                    <tr style="display: none;">
                        <td>Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>Program :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpprog" />
                        </td>

                    </tr>

                </table>
            </div>
        </div>

        <div id="DataList" class="panel panel-default" style="display: none; overflow:auto;">
            <div class="panel-heading">
                <strong id="panel_head">Vertical Studio Preferences Seats Details </strong>
            </div>

            <div>
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%" style="overflow:auto;">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>


</asp:Content>

