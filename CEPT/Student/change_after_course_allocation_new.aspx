<%@ Page Title="Drop Course - CEPT" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="change_after_course_allocation_new.aspx.cs" Inherits="Student_change_after_course_allocation_new" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%--<script src="../../Js/admin_report.js" type="text/javascript"></script>--%>

    <script src="../Js/change_after_allocation_new.js?t=11062021" type="text/javascript"></script>
    
    <script type="text/javascript">
       $(document).ready(function () {
           get_allocate_data();

           $('#btnsave').on('click', function () {
               save_changes();
               return false;
           });

           return false;
       });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Drop Course
            </h1>
        </div>
        <div class="space">
        </div>
        <div style="margin-top: 5px; display: none; width: 100%" class="row-fluid" id="datalist_saved">
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0" border="0" id="datatable_saved" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
        <div style="width: 100%; float: left; margin-top: 15px;">
            <table width="100%">
                <tr>
                    <td align="center">
                        <button id="btnsave" style="display: none" class="btn btn-lg btn-primary">
                            <i class="icon-save bigger-160"></i>Drop Course
                        </button>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
