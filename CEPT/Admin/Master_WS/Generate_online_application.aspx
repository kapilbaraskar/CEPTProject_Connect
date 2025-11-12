<%@ Page Title="CEPT - Generate Transaction" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true"
    CodeFile="Generate_online_application.aspx.cs" Inherits="Admin_Master_Generate_online_application" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../../Js_WS/get_online_Transaction_dtl.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Generate Online Payment
            </h1>
        </div>
        <div>
            <div>
                <div>
                    <table border="0" cellpadding="10" cellspacing="5">
                        <tr>
                            <td>
                                Transaction Id :
                            </td>
                            <td>
                                <input type="text" class="chosen-select" id="txt_trasaction_id" />
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
            <div id="div_transaction" style="display:none; margin-top:15px" class="tab-content">
         
                    
                        <table align="center" style="width:55%" border="0" cellpadding="2" cellspacing="2">
                            <tr>
                                <td>
                                   <b> PG Transaction Id :</b>
                                </td>
                                <td>
                                    <input type="text" id="txt_PG_transaction_id" />
                                </td>
                                  </tr>
                                <tr>
                                    <td>
                                       <b> Citrus Txn Id :</b>
                                    </td>
                                    <td>
                                        <input type="text" id="txt_citrus_txn_id" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                       <b> Auth Id Code :</b>
                                    </td>
                                    <td>
                                        <input type="text" id="txt_payment_autho_code" />
                                    </td>
                                </tr>
                          
                        </table>
                  
          
                <!--/row-fluid-->
                <!--/container-->

          
                    <div class="span11" style="margin-top: 10px">
                        <table align="center" border="0" cellpadding="3" cellspacing="5">
                            <tr>
                                <td>
                                <center>
                                    <button id="btnsave"  line-height: inherit;" class="btn btn-lg btn-primary">
                                        <i class="icon-save bigger-160"></i>Save
                                    </button>
                                    </center>
                                </td>
                            </tr>
                        </table>
                    </div>
                
               

         
</div>
        </div>
        <%--  <div class="tab-content">--%>
        <%--</div>--%>
    </div>
</asp:Content>
