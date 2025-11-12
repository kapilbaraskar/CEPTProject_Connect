<%@ Page Title="Course Selected By Student - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="total_selected_course_type_wise.aspx.cs" Inherits="Admin_Report_total_selected_course_type_wise" ViewStateEncryptionMode="Always" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js?14082025" type="text/javascript"></script>
       <script src="../../Js/csvfilejs/jquery-3.3.1.js"></script>
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>
    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <script type="text/javascript">
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();
            //bindyeardata();

            $('#btnreterive').on('click', function () {
                total_selected_course();
                return false;
            });

            $('#btn_assign').on('click', function () {
                save_data();
                return false;
            });

            $('#btn_assign2').on('click', function () {
                save_data_logic2();
                return false;
            });

            $('#btn_assign3').on('click', function () {
                save_data_logic3();
                return false;
            });
            $('#btn_cfp_publish').on('click', function () {
                save_data_CFP_logic();
                return false;
            });

            $('#drpsemester').on('change', function () {
                //save_data_logic2();
                $('#DataList').css('display', 'none');
                $('#btn_assign').css('display', 'none');
                $('#btn_assign2').css('display', 'none');
                //$('#btn_remove').css('display', 'none');
                $('#btn_assign3').css('display', 'none');
                $('#btn_delete').css('display', 'none');
                $('#btn_cfp_publish').css('display', 'none');
                return false;
            });

            $('#drpyear').on('change', function () {
                $('#DataList').css('display', 'none');
                $('#btn_assign').css('display', 'none');
                $('#btn_assign2').css('display', 'none');
                //$('#btn_remove').css('display', 'none');
                $('#btn_assign3').css('display', 'none');
                $('#btn_delete').css('display', 'none');
                $('#btn_cfp_publish').css('display', 'none');
                //save_data_logic2();
                return false;
            });

            $('#btn_delete').on('click', function () {
                remove_data();
                return false;
            });

            $('#btn_publish').on('click', function () {
                publish_allocation_data();
                return false;
            });

            return false;
        });

        function btnreterive_onclick() {

        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Course Allocation
            </h1>
        </div>

        <div>
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
                            <td>Year Of Allocation :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                             <td>
                                Course Type :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpcoursetype">
                                    <option value =''>--Please Select Type--</option>
                                    <option value ='9'>CFP</option>
                                </select>
                            </td>
                            <td>
                                <button class="btn btn-primary" type="submit" id="btnreterive" onclick="return btnreterive_onclick()">
                                    Retrieve
                                </button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="DataList" class="panel panel-default" style="display:none;">
                <div class="panel-heading">
                    <strong id="panel_head">Registration Detail</strong>
                </div>

                <div>
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <table style="margin-top:10px;margin-bottom:20px;" width="100%" border="0" cellpadding="5" cellspacing="5">
                <tr>
                    <td style="width:10%;" align="right">
                        <button class="btn btn-primary" style="display:none;" type="submit" id="btn_assign">
                            <i class="icon-save bigger-160"></i>Assign 20
                        </button>
                    </td>
                    <%--<td style=" display:block;">
                        <button class="btn btn-primary" style="display:none;left: 40px;" type="submit" id="btn_assign2">
                            <i class="icon-save bigger-160"></i> Original
                        </button>
                    </td>--%>
                    <td style="display:none;">
                        <button class="btn btn-primary" style="display:none;" type="submit" id="btn_assign3">
                            <i class="icon-save bigger-160"></i>Assign 3
                        </button>
                    </td>
                    <td style="width:20%;" align="center">
                        <button class="btn btn-primary" style="display:none;" type="submit" id="btn_delete">
                            <i class="icon-save bigger-160"></i>Delete Allocation
                        </button>
                    </td>
                    <td style="width:14%;" align="left">
                        <button class="btn btn-primary" style="display:none;" type="submit" id="btn_publish">
                            <i class="icon-save bigger-160"></i>Publish Allocation
                        </button>
                    </td>
                    <td style="width:21%;" align="left">
                        <button class="btn btn-primary" style="display:none;" type="submit" id="btn_cfp_publish">
                            <i class="icon-save bigger-160"></i>CFP Publish Allocation
                        </button>
                    </td>

                </tr>
            </table>
        </div>
    </div>
</asp:Content>
