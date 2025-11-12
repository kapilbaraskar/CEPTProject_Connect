<%@ Page Title="Reset Password - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="reset_password.aspx.cs" Inherits="Admin_Master_reset_password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../DesignJS/jquery.dataTables.rowGrouping.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            bindyeardata();
//            bindsemdata();
            binddepartment()

            $('#btnreterive').on('click', function () {

                change_student_password();

                return false;

            });

            $('#btnsave').on('click', function () {

                save_reset_password();

                return false;

            });

            $(document).on("click", ".chk_half_parent", function (event) {
                var $this = $(this), $table = $this.closest("table"), $madaniya = null;
                if ($table.hasClass("dataTable")) {
                    $table = $table.closest(".dataTables_wrapper");
                }
                $table.find(".chk_half_child").prop("checked", this.checked).change();
            }).on("click", ".chk_half_child", function () {
                var $this = $(this), $table = $this.closest("table"), $madaniya = null; $madaniya = null, checkedLength = 0;
                if ($table.hasClass("dataTable")) {
                    $table = $table.closest(".dataTables_wrapper");
                }
                $madaniya = $table.find(".chk_half_child");
                checkedLength = $madaniya.filter(":checked").length;
                $table.find(".chk_half_parent").prop({ "indeterminate": checkedLength && checkedLength !== $madaniya.length, "checked": checkedLength === $madaniya.length });
            }).on("change", ".chk_half_child", function () {
                if (this.checked) {
                    //  addSelection(this.value);
                } else {
                    // removeSelection(this.value);
                }
            });



            return false;

        });


    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
 <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Reset Password
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <%--<td>
                                Semester :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpsemester">
                                </select>
                            </td>--%>
                            <td>
                                Year :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <td>
                                Department :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpdepartment" />
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
                            <i class="icon-save bigger-160"></i>Reset
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

