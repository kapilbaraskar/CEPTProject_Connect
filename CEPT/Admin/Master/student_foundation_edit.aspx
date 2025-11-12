<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="student_foundation_edit.aspx.cs" Inherits="Admin_Master_student_foundation_edit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            bindyeardata();

            $('#btn_retrieve').on('click', function () {
                get_student_foundation_dtl();
                return false;
            });
        });

        function bindyeardata() {
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

        var year_code='';
        function get_student_foundation_dtl() {
            $('#div_stud_list').css('display', 'none');
            $('#DataList').css('display', 'none');

            year_code = $('#drpyear').val();
            if (year_code == '') {
                bootbox.alert('Please Select Enrollment Year');
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_student_foundation_dtl",
                async: false,
                data: "{year_code:'" + year_code + "'}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var student_data = JSON.parse(data.d)

                        display_student_foundation_dtl(student_data);
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }

        var oTable;
        function display_student_foundation_dtl(student_data) {
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html('<table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "oTableTools": {
                    "aButtons": [
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },
                "aaData": student_data,
                "aoColumns": [
                    { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
                    { "sTitle": "Student Name", "mData": "full_name", "bSortable": false },
                    { "sTitle": "Cur Foundation Sem", "mData": "cur_foundation_sem", "bSortable": false, "mRender": function (course_code) {
                        return '<center><select class="drp_cur_sem"><option value="1">1</option><option value="2">2</option></select></center>';
                    } 
                    },
                    { "sTitle": "Foundation Program Status", "mData": "status", "bSortable": false, "mRender": function (course_code) {
                        return '<center><select class="drp_status"><option value="A">Active</option><option value="D">Deactive</option><option value="C">Completed</option></select></center>';
                    }
                    }
                ]
            });

            $('#example tbody tr').each(function () {
                var row_data = oTable.fnGetData(this);

                $(this).find('.drp_cur_sem').val(row_data['cur_foundation_sem']);
                $(this).find('.drp_status').val(row_data['status']);
            });

            $('#div_stud_list').css('display', 'block');
            $('#DataList').css('display', 'block');
        }

        function fnSaveFoundationDtl() {
            var arr_student_dtl = [];

            if (year_code == '') {
                bootbox.alert('Please Select Enrollment Year');
                return false;
            }

            $('#example tbody tr').each(function () {
                var obj_student_dtl = { 'user_id': '', 'cur_sem': '', 'status': '' };
                var row_data = oTable.fnGetData(this);

                obj_student_dtl.user_id = row_data['user_id'];
                obj_student_dtl.cur_sem = $(this).find('.drp_cur_sem').val();
                obj_student_dtl.status = $(this).find('.drp_status').val();

                arr_student_dtl.push(obj_student_dtl);
            });

            if (arr_student_dtl.length > 0) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_student_foundation_dtl",
                    async: false,
                    data: "{student_dtl:'" + JSON.stringify(arr_student_dtl) + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "") {
                            var obj_res = JSON.parse(data.d);

                            bootbox.alert(obj_res["message"], function () {
                                if (obj_res["status"].toString() == 'true')
                                    location.reload();
                            });
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            }

            return false;
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Student Foundation Detail Edit
            </h1>
        </div>
    </div>

    <div class="panel panel-default">
        <div class="panel-heading">
            <strong>Filter Criteria</strong>
        </div>
        <div>
            <table border="0" cellpadding="10" cellspacing="5">
                <tr>
                    <td>
                        Year of allocation
                    </td>
                    <td>
                        <select class="chosen-select" id="drpyear">
                        </select>
                    </td>
                    <td colspan="6">
                        <button class="btn btn-primary" type="submit" id="btn_retrieve">
                            Retrieve
                        </button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    
    <div id="div_stud_list" class="panel panel-default" style="display: none;">
        <div class="panel-heading">
            <strong>Student List</strong>
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

        <div style="padding:20px;" align="center">
            <input type="button" id="btn_save" class="btn btn-primary" value="Save" onclick="fnSaveFoundationDtl()" />
        </div>
    </div>
</asp:Content>

