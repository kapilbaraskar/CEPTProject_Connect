<%@ Page Title="Add Course - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Add_course_before_allocation.aspx.cs" Inherits="Admin_Master_Add_course_before_allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js_WS/admin_report.js" type="text/javascript"></script>
    <script src="../../Js_WS/add_manually_allocation.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            bind_ws_semdata();
            //binddepartment();
            //bindprogrammedata();
            bindyeardata_for_cross_reg();
            //bind_ws_course();

            $('#btnreterive').on('click', function () {
                get_ws_data_before_allocation();
                return false;
            });

            $('#drpsemester').on('change', function () {
                $('#example tbody').html('');
                $('#btnsave').css('display', 'none').closest('.copyright').css('display', 'none');
                $('#DataList').css('display', 'none');
                $('#div_student_list').css('display', 'none');

                if ($('#drpsemester').val() != '') {
                    if ($('#drpyear').val() != '') {
                        bind_sem_course();
                    }
                }
            });

            $('#drpyear').on('change', function () {
                $('#example tbody').html('');
                $('#btnsave').css('display', 'none').closest('.copyright').css('display', 'none');
                $('#DataList').css('display', 'none');
                $('#div_student_list').css('display', 'none');

                if ($('#drpyear').val() != '') {
                    if ($('#drpsemester').val() != '') {
                        bind_sem_course();
                    }
                }
            });

            //$('#drpsemester').on('change', function () {
            //    if ($('#drpsemester').val() != '') {
            //        bind_sem_course();
            //    }
            //});

            $('#drcourses').on('change', function () {
                $('#example tbody').html('');
                $('#btnsave').css('display', 'none').closest('.copyright').css('display', 'none');
                $('#DataList').css('display', 'none');
                $('#div_student_list').css('display', 'none');
            });

            $('#btnsave').on('click', function () {
                save_ws_data_for_allocation();
                return false;
            });
        });
    </script>

    <style type="text/css">
        tfoot
        {
            display: table-header-group;
        }
        .copyright
        {
            font-size: 12px;
            background: white;
            position: fixed;
            bottom: 0px;
            z-index: 11;
            margin-top: 10px;
        }
        .copyright p
        {
            color: #dadada;
        }
        .copyright a
        {
            margin: 0 5px;
            color: #72c02c;
        }
        .copyright a:hover
        {
            color: #a8f85f;
            -webkit-transition: all 0.4s ease-in-out;
            -moz-transition: all 0.4s ease-in-out;
            -o-transition: all 0.4s ease-in-out;
            transition: all 0.4s ease-in-out;
        }
        .copyright .span8
        {
            padding-top: 15px;
        }
        .copyright .span4
        {
            padding-top: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Asign Courses Manually Before Allocation
            </h1>
        </div>
    </div>
    
    <div style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
                <table border="0" cellpadding="10" cellspacing="5">
                    <tr>
                        <td>
                            Semester of Allocation :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpsemester">
                            </select>
                        </td>
                        <td>
                            Year of Assign :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpyear">
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Course of Allocation :
                        </td>
                        <td>
                            <select class="chosen-select" id="drcourses">
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

        <div id="div_student_list" class="panel panel-default" style="display:none;margin-bottom:80px;">
            <div class="panel-heading">
                <strong>Student Detail</strong>
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

    <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;display:none;">
        <div class="container">
            <div class="row-fluid">
                <div class="span11" style="margin-top: 10px">
                    <table style="width: 100%" align="center" border="0" cellpadding="3" cellspacing="5">
                        <tr>
                            <td align="center">
                                <button id="btnsave" style="display: none; line-height: inherit;" class="btn btn-lg btn-primary">
                                    <i class="icon-save bigger-160"></i>Save
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
