<%@ Page Title="Fees Status - CEPT" Language="C#" MasterPageFile="~/AdminCEPT.master"
    AutoEventWireup="true" CodeFile="student_fees_status.aspx.cs" Inherits="Student_student_fees_status" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <%--<script src="../../Js/general.js" type="text/javascript"></script>--%>
    <script src="../../Js/StudentFees.js" type="text/javascript"></script>
    <script src="../../DesignJS/FixedHeader.js" type="text/javascript"></script>
    <script type="text/javascript">
      
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="clearfix">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-rupee"></i>Student Fees Status
            </h1>
        </div>
        <div class="space">
        </div>
        <div>
        <table border="0" cellpadding="5" cellspacing="5">
                    <tr>
                        <td>
                          Current semester for fees : 
                          
                        </td>
                         <td>
                           <label style="color: Red;" id="lbl_current_sem" runat="server">
                            </label>
                         </td>
                    </tr>
                    </table>
            <div>
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
                            Year :
                        </td>
                        <td>
                            <select class="chosen-select" id="drp_year">
                            </select>
                        </td>
                        <td>
                            Department :
                        </td>
                        <td>
                            <select class="chosen-select" id="drpdepartment" />
                        </td>
                        <td>
                            </tr>
                    <tr>
                            <td>
                                Year of enrollment :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpyear">
                                </select>
                            </td>
                            <td>
                                Programme :
                            </td>
                            <td>
                                <select class="chosen-select" id="drpprog">
                                </select>
                            </td>
                        </td>
                        <td>
                            <button class="btn btn-primary" type="submit" id="btnreterive">
                                Retrieve
                            </button>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </table>
            </div>
        </div>
        <div style="margin-top: 25px; display: none; width: 100%" class="row-fluid" id="DataList">
            <table class="table table-striped table-bordered" cellpadding="0" cellspacing="0"
                border="0" id="example" width="100%">
                <tbody>
                </tbody>
            </table>
        </div>
        <div style="width: 100%; float: left; margin-top: 15px;">
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
</asp:Content>
