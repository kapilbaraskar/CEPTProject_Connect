<%@ Page Title="Change Semester - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master"
    AutoEventWireup="true" CodeFile="change_sem_of_student.aspx.cs" Inherits="Admin_Master_change_sem_of_student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {


           

            change_WS_sem_year();

//            $('#btnreterive').on('click', function () {

//                change_student_current_sem();

//                return false;

//            });

            $('#btnsave').on('click', function () {

                save_ws_current_sem();

                return false;

            });



            return false;

        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Change Semester for Student
            </h1>
        </div>
        <div>
            <div>
                <%--<div>
                    <table border="0" cellpadding="5" cellspacing="5">
                        <tr>
                            <td>
                                Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>
                            <td>
                                Year of enrollment :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>--%>
            </div>
            <div id="DataList" style="display: none">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <div style="width: 100%; float: left; margin-top: 20px;">
                <table width="100%">
                    <tr>
                        <td align="center">
                            <button id="btnsave" style="display: none" class="btn btn-lg btn-primary">
                                <i class="icon-save bigger-160"></i>Save
                            </button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</asp:Content>
