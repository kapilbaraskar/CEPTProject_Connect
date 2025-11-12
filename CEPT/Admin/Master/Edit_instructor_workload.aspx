<%@ Page Title="Edit Instructor Workload" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Edit_instructor_workload.aspx.cs" Inherits="Admin_Master_Edit_instructor_workload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type ="text/javascript">
        $(document).ready(function () {

            bindsemdata();
            bindyeardata_for_cross_reg();
            

            $('#btnreterive').on('click', function () {
                get_int_workload_detail();
                return false;
            });
            $('#btnsave').on('click', function () {
                inst_list_to_all();
                return false;
            });

            setCurrentSemester();
        });
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

        function setCurrentSemester() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_cept_current_sem_data",
                //async: false,
                data: "{type:'course'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var cur_grade_sem = JSON.parse(data.d);

                        if (cur_grade_sem.length > 0) {
                            $('#drpsemester').val(cur_grade_sem[0]['sem_code'].toString());
                            $('#drpyear').val(cur_grade_sem[0]['year_code'].toString());

                            $('#drpsemester').trigger("liszt:updated");
                            $('#drpyear').trigger("liszt:updated");

                            

                            //$('#btnreterive').click();
                        }
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        var oTable;
        var semester = '';
        var year_code = '';
        function get_int_workload_detail() {
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
                    url: "../../WebService.asmx/Get_instructor_workload",
                    
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {

                            display_get_ints_workload_detail(data.d);

                            $('#div_inst_list').css('display', 'block');
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

        function display_get_ints_workload_detail(data) {

            var columns = [

                {
                    "sTitle": "Select<br /><input type='checkbox' id='chk_select_all' onchange='select_all_change()' />", "mData": null, "bSortable": false, mRender: function (data) {
                        
                            return '<input type="checkbox" class="cls_chk_course_select" onchange="course_select_change(this)"/>';
                    }
                },

                { "sTitle": "course Code", "mData": "course_code" },
                { "sTitle": "Instructor Code", "mData": "instructor_code" },
            { "sTitle": "VF Code", "mData": "VF_code" },
            { "sTitle": "Instructor Name", "mData": "instructor_name" },
            { "sTitle": "Designation", "mData": "designation" }
            ];

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                //"iDisplayLength": 60,
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                //"oLanguage": {
                //    "sSearch": "Search all columns with Space:"
                //},
                ////"sDom": 'T<"clear">lfrtip',
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

        }

        function select_all_change() {
            if ($('#chk_select_all')[0].checked) {
                $('.cls_chk_course_select').attr('checked', 'checked');
            }
            else {
                $('.cls_chk_course_select').removeAttr('checked');
            }
        }

        function course_select_change(cur_ele) {

            if (cur_ele.checked) {
                if ($('.cls_chk_course_select').length == $('.cls_chk_course_select:checked').length)
                    $('#chk_select_all')[0].checked = true;
            }
            else {
                $('#chk_select_all')[0].checked = false;
            }
        }


        function update_ints_workload_detail(instructor_list)
        {
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
                    url: "../../WebService.asmx/update_workload_dtl",
                    //async: false,
                    data: "{instructor_list:'" + instructor_list + "',semester:'" + semester + "',year_code:'" + year_code+"'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d == null || data.d == '') {
                            bootbox.alert('Problem in Data.');
                        }
                        else if (data.d != "" && data.d != "[]")
                        {
                            bootbox.alert("Successfully Updata data");
                            $('#btnreterive').click();
                        }
                        else {
                            bootbox.alert(data.d);
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }
        var instructor_list = [];
        function inst_list_to_all() {
            
            var obj_selected_inst = $('.cls_chk_course_select:checked');
            if (obj_selected_inst.length > 0) {
                for (var i = 0; i < obj_selected_inst.length; i++) {
                    var row_data = oTable.fnGetData(obj_selected_inst[i].closest('tr'));
                    var instructor_code = row_data['instructor_code'];
                    var course_code = row_data['course_code'];
                    var instructor = { 'instructor_code': instructor_code, 'course_code': course_code };
                    instructor_list.push(instructor);
                }
            } else {
              
                bootbox.alert('Please Checked checkbox');
                return false;
            }
            update_ints_workload_detail(JSON.stringify(instructor_list));
            instructor_list = [];
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Edit Instructor Workload
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
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year of allocation 
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
                                <td>
                                    <button class="btn btn-primary" id="btnsave">
                                        Update
                                    </button>
                                </td>
                            </tr>
                            
                        </table>
                    </div>
                </div>
            </div>
        </div>

         <div id="div_inst_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong id="panel_head">Instructor Work Load</strong>
            </div>
            <div>
                <div id="DataList" style="display: none; overflow: auto;">
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
</asp:Content>

