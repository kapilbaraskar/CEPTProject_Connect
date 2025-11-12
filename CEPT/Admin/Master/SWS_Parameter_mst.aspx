<%@ Page Title="SWS Parameter Master" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="SWS_Parameter_mst.aspx.cs" Inherits="Admin_Master_SWS_Parameter_mst" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            autodiv();
            $('#btnsave').click(function (e) {
                
                var a = $('#SWSparameter tbody').length;
                var interested_program_selected_data = [];

                for (var i = 0; i < a; i++) {
                    var num = i + 1;
                    var data = {
                        "Start_Date": $('#date1_' + num).val(),
                        "End_Date": $('#date2_' + num).val(),
                        "start_time": $('#text1_' + num).val(),
                        "end_time": $('#text2_' + num).val(),
                        "parameter_value": $('#status_' + num).val(),
                        "parameter_id": $('#SWSparameter tbody')[i].id
                    };
                    interested_program_selected_data.push(data);
                }
               
                var json_submit_data = JSON.stringify(interested_program_selected_data);
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/update_SWS_Parameter_mst",
                    data: "{ interested_program_data: '" + json_submit_data + "' }",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        debugger;
                        if (data.d == "true") {
                            alert("Data saved successfully");
                            autodiv();
                        }
                        else {
                            alert("Problem in saving the data");
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            });
        function autodiv() {
            debugger;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_SWS_Parameter_dtl",
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var jsson_parse = JSON.parse(data.d);
                        var html_string = '';
                        for (var i = 0; i < jsson_parse.length; i++) {
                            html_string += jsson_parse[i]['html_code'];
                        }
                        $('#SWSparameter').html(html_string);
                    }
                }
            });
            }
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;SWS Parameter Master
            </h1>
        </div>
    </div>

    <div class="" style="background-color: White;">
        <div class="panel panel-default">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>

            <div>
             <table border="0" cellpadding="8" cellspacing="5" id="myTable" style="margin-left:120px;">
                    <tbody id="SWSparameter">
                      
                    </tbody>
                </table>
                <button class="btn btn-primary" type="submit" id="btnsave" style="margin-left:44%;margin-bottom: 10px;">
                  Save
                </button>

                       
            </div>
        </div>
    </div>
</asp:Content>

