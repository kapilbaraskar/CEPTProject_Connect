<%@ Page Title="Manually Assign - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="Add_manually_allocation.aspx.cs" Inherits="Admin_Master_Add_manually_allocation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Js/add_manually_allocation.js?t=06062022" type="text/javascript"></script>
    <style>
        .mrgnleft
        {
            margin-left: 5px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            bindsemdata();
            binddepartment();
            bindprogrammedata();
            bindyeardata_for_cross_reg();
            bindyeardata_for_batch();
            bindproglevel();

            $('#btnreterive').on('click', function () {
                var course = $('#drcourses').val();

                if (course == "") {
                    bootbox.alert('Please select course')
                    $('#drcourses').focus();
                    return false;
                }

                get_data_for_allocation();
                return false;
            });

            $('#drpsemester').on('change', function () {
                if ($('#drpyear').val() != '') {
                    bind_sem_course();
                }
            });

            $('#drpyear').on('change', function () {
                if ($('#drpsemester').val() != '') {
                    bind_sem_course();
                }
            });

            $('#btnsave').on('click', function () {
                save_data_for_allocation();
                return false;
            });

            $('#btnselectall').on('click', function () {
                $('.chk_course').prop('checked', true);
                return false;
            });

            $('#btnselectmandall').on('click', function () {
                $('.course_type').val('M');
                return false;
            });

            $('#btnselecteleall').on('click', function () {
                $('.course_type').val('E');
                return false;
            });

            $('#btnselectgpaall').on('click', function () {
                $('.gpa').val('G');
                return false;
            });

            $('#btnselectngpaall').on('click', function () {
                $('.gpa').val('N');
                return false;
            });

            $('#drpsemester,#drpyear,#drcourses,#drpdepartment,#drpprog').on('change', function () {
                $('#DataList').css('display', 'none');
                $('#btnsave').css('display', 'none');
            });
        });
    
    </script>
    <style type="text/css">
        tfoot
        {
            display: table-header-group;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Assign Courses Manually
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Semester of Assign :
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
                            <td>
                                Course of Assign :
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Student Department
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment">
                                </select>
                            </td>
                            <td>
                                Student Programme
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                            <td>Program Level :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpproglevel" />
                            </td>
                        </tr>
                        <tr>
                            <td>Year of Batch :
                            </td>
                            <td>
                                <select class="chosen-select" id="BthYear">
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
            <div class="row-fluid" style="margin-top: 2px;margin-bottom:10px;float: right;">
                            <button class="btn btn-primary mrgnleft" type="submit" id="btnselectall">
                                Select All
                            </button>
                            <button class="btn btn-primary mrgnleft" type="submit" id="btnselectmandall">
                                All Mandatory
                            </button>
                            <button class="btn btn-primary mrgnleft" type="submit" id="btnselecteleall">
                                All Elective
                            </button>
                            <button class="btn btn-primary mrgnleft" type="submit" id="btnselectgpaall">
                                All GPA
                            </button>
                            <button class="btn btn-primary mrgnleft" type="submit" id="btnselectngpaall">
                                All NGPA
                            </button>
            </div>
            <div id="DataList" style="display: none;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                        
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
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
                    <!--/row-fluid-->
                </div>
                <!--/container-->
            </div>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</asp:Content>
