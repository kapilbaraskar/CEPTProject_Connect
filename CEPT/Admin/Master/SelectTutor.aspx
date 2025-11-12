<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SelectTutor.aspx.cs" Inherits="Admin_Master_SelectTutor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $('#btnapplyta').on('click', function ()
            {
                applyTa();
                return false;

            });

            $('#btnapplytutor').on('click', function () {
                applytutor();
                return false;
            });

            return false;

        });

        function applyTa()
        {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/TA_Rights",
                    async: false,
                    data: "",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]")
                        {
                            if (data.d != "TA Application is closed") {
                                //var url = "Temp_Dashboard.aspx";
                                var url = "TA_Application.aspx?ic=" + $("#hdnuserid").val() + "&type=tutor";
                                window.open(url, "_self");
                            }
                            else {
                                bootbox.alert('TA Application is closed');
                                return false;

                            }
                            
                            //var track_call_for_studio = JSON.parse(data.d);
                            
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }
        function applytutor() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/Tutor_Rights",
                    async: false,
                    data: "",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {

                            if (data.d != "Tutor Application is closed") {
                                var url = "Studio_Proposal_Dashboard.aspx";
                                window.open(url, "_self");
                            }
                            else {
                                bootbox.alert('Tutor Application is closed');
                                return false;

                            }


                            
                           // var track_call_for_studio = JSON.parse(data.d);

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
        }
    </script>
	  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Select Tutor 
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Select</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>
                                    <button class="btn btn-primary" id="btnapplyta">
                                        Apply As TA 
                                    </button>
                                </td>
                                <td>
                                    <button class="btn btn-primary" id="btnapplytutor">
                                        Apply As Tutor
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
       
    </div>
</asp:Content>

