<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="frm_add_preassigned_course.aspx.cs" Inherits="Admin_Master_frm_add_preassigned_course" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script src="../../Js/admin_report.js" type="text/javascript"></script>
    <script src="../../Js/add_pre_assigned_course.js" type="text/javascript"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            //  bindsemdata();
            binddepartment();
            bindprogrammedata();
           
            bindcourse();
            //   bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {


                get_data_for_preassigned();

                return false;
            });

         

            $('#btnsave').on('click', function () {


                save_data_for_allocation();

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
            background: rgba(129,193,229,0.8);
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i> Add Pre-assigned Course
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                    
                        <tr>
                        
                                <td>
                                 Course
                            </td>
                            <td>
                                <select class="chosen-select" id="drcourses">
                                </select>
                            </td>

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
          <div class="copyright" style="box-shadow: 5px 0 6px 1px black;">
        <div class="container">
            <div class="row-fluid">
                <div class="span11" style="margin-top: 10px">
                    <table align="center" border="0" cellpadding="3" cellspacing="5">
                        <tr>
                            <td>
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

