<%@ Page Title="Room Allocation Detail" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Room_allocation_dtl.aspx.cs" Inherits="Admin_Report_Room_allocation_dtl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Scripts/jquery-1.8.0.js" type="text/javascript"></script>
    <link href="../../Style/uploadify.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.uploadify.js" type="text/javascript"></script>
    <script src="../../Js/admin_report.js?t=28082019" type="text/javascript"></script>

    <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
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
        var prog_level_code = '';
        var obj_days = { '1': 'Monday', '2': 'Tuesday', '3': 'Wednesday', '4': 'Thursday', '5': 'Friday', '6': 'Saturday' };
        var asInitVals = new Array();
        
        $(document).ready(function () {
            bindyeardata_for_cross_reg();
            bindsemdata();
            binddepartment();
            bindProgram();

            bindproglevel(); /// Returned By Ananth

            $('#btn_retrieve').on('click', function () {
                retrieve_fees_Data();
                return false;
            });
        });

        function bindProgram() {
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

            dept_code = $('#drpdepartment').val();
            //if (dept_code == "") {
            //    bootbox.alert('Please select Department');
            //    $('#drpdepartment').focus();
            //    return false;
            //}

            prog_code = $('#drpprog').val();
            //if (prog_code == "") {
            //    bootbox.alert('Please select Programme');
            //    $('#drpprog').focus();
            //    return false;
            //}

            prog_level_code = $("#drpproglevel").val();  ///Returned By Ananth

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_room_allocation_dtl",
                data: "{sem_code:'" + semester + "' , year_code : '" + year_code + "',dept_code: '" + dept_code + "',prog_code: '" + prog_code + "',prog_level_code: '" + prog_level_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        display_Fees_Data(data.d);
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
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
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
                "aaData": JSON.parse(data),
                "aoColumns": [
                    { "sTitle": "From Time", "mData": "from_time", "bSortable": false },
                    { "sTitle": "To Time", "mData": "To_time", "bSortable": false },
                    { "sTitle": "Day", "mData": "day_code", "bSortable": false, "mRender": function (data) { return obj_days[data]; } },
                    { "sTitle": "Room Id", "mData": "room_id", "bSortable": false },
                    { "sTitle": "Course Code", "mData": "course_code", "bSortable": false },
                    { "sTitle": "Course Name", "mData": "course_name", "bSortable": false },
                    { "sTitle": "Department Name", "mData": "dept_name", "bSortable": false },
                    { "sTitle": "Program Name", "mData": "prog_name", "bSortable": false },
                    //{ "sTitle": "", "mData": null, "bSortable": false, "mRender": function (course_code) {
                    //    return '<center><button type="button" onclick="rowClick_edit(this)">Edit</button></center>';
                    //}
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
            for (var i = 0; i < $("#example tr:nth-child(2) th").length; i++) {
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
            $('#div_room_list').css('display', 'block');
            $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        //function rowClick_edit(row) {
        //    var tr = row.parentElement.parentElement.parentElement;
        //    var tr_data = oTable.fnGetData(tr);

        //    var semester = tr_data['semester_type'];
        //    var year = tr_data['year_semester'];
        //    var dept_code = tr_data['dept_code'];
        //    var prog_code = tr_data['prog_code'];
        //    var allo_year = tr_data['year_code'];

        //    location.href = 'FeesBankDtl_Add.aspx?s=' + semester + '&y=' + year + '&d=' + dept_code + '&p=' + prog_code + '&a=' + allo_year;
        //}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Room Allocation Detail
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

                        <td class="cls_dept_prog">Department</td>
                        <td class="cls_dept_prog"><select class="chosen-select" id="drpdepartment"></select></td>
                        
                    </tr>

                    <tr>
                        <td>Program</td>
                        <td><select class="chosen-select" id="drpprog"></select></td>

                        <td>Program Level</td>
                        <td><select class="chosen-select" id="drpproglevel"></select></td>

                        <td><input type="button" id="btn_retrieve" value="Retrieve" class="btn btn-primary" /></td>
                    </tr>
                </table>
            </div>
        </div>

        <div id="div_room_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Room Details</strong>
            </div>
            <div>
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
    </div>
</asp:Content>