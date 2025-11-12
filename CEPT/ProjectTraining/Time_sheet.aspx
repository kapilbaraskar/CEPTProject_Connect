<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="Time_sheet.aspx.cs" Inherits="Time_sheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
              <div> <center><u><b>TIME SHEET</b></u></center> </div>
            <div style="padding: 15px;" id="div3">
                <div class="row"><br />
                    <div style="" class="form-group col-md-12">
                        <div  class="form-group col-sm-6 ">
                        <p>Name of Student :    ____________________________________</p>
                        </div>
                         <div  class="form-group col-sm-5">
                        <p>code no :    ____________________________________________</p>
                        </div>
                    </div>

                    <div style="" class="form-group col-md-12">
                        <div  class="form-group col-sm-6 ">
                        <p>Project Name :    _______________________________________</p>
                        </div>
                         <div  class="form-group col-sm-5">
                        <p>Location :    ___________________________________________</p>
                        </div>
                    </div>

                     <div style="" class="form-group col-md-12">
                        <div  class="form-group col-sm-6 ">
                        <p>Continuous Time sheet No :   __________________________</p>
                        </div>
                         <div  class="form-group col-sm-5">
                        <p>CAR NO :    ___________________________________________</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <style>
        .span-set
        {
            font-size: smaller;
            margin-left: 4px;
        }
        .setPadding
        {
            width: 25px;
        }
        .setWidth
        {
            width: 65px;
        }
        .td1
        {
            width: 3%;
        }
        .btn_rad
        {
            border-radius: 6px;
        }
    </style>
   
</asp:Content>
