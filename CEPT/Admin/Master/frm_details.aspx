<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="frm_details.aspx.cs" Inherits="Admin_Master_frm_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript">

        var oTable;

        $(document).ready(function () {
            $('#btn_retrieve').on('click', function () {
                retrieve_Data();
            });
        });

        function retrieve_Data() {
            $('#div_result').css('display', 'none');
            $('#DataList').css('display', 'none');

            txt1 = $('#txt1').val();
            if (txt1 == "") {
                bootbox.alert('Enter Textbox 1 value');
                return false;
            }

            txt2 = $('#txt2').val();
            if (txt2 == "") {
                bootbox.alert('Enter Textbox 2 value');
                return false;
            }

            txt3 = $('#txt3').val();
            if (txt3 == "") {
                bootbox.alert('Enter Textbox 3 value');
                return false;
            }

            txt4 = $('#txt4').val();
            if (txt4 == "") {
                bootbox.alert('Enter Textbox 4 value');
                return false;
            }

            var filter_criteria = { txt1: txt1, txt2: txt2, txt3: txt3, txt4: txt4 };
            var req_data = JSON.stringify(filter_criteria);

            req_data = req_data.replace(/'/g, '\\\'');

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_request_data",
                data: "{request:'" + req_data + "'}",
                dataType: "json",
                success: function (data) {

                    if (data.d != "") {
                        display_Data(JSON.parse(data.d));
                        $('#DataList').css('display', 'block');
                        setDataTableHeaderFooter('example');
                    }
                    else {
                        bootbox.alert('No data Found');
                        $('#DataList').css('display', 'none');
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });

            return false;
        }
        
        function display_Data(data) {

            var columns = [];

            for (var key in data[0]) {
                columns.push({ "sTitle": key, "mData": key, "bSortable": false});
            }
                            
            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({
                "bPaginate": false,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                "sDom": 't',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                //"sDom": 'T<"clear">lfrtip',
                "oTableTools": {
                    "aButtons": [
                        "copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": 'Export',
                            "aButtons": ["xls"]
                        }
                    ]
                },

                "aaData": data,
                "aoColumns": columns
            });

            $('#DataList').css('display', 'block');
            $('#div_result').css('display', 'block');
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="panel panel-default" style="margin-top:20px;">
        <div class="panel-heading">
            <strong>Request</strong>
            <span style="display:block;float:right;">
                <input type="button" id="btn_retrieve" class="btn btn-primary" value="Retrieve" style="height: 40px;margin-top: -10px;" />
            </span>
        </div>

        <div style="padding:15px;">
            <table>
                <tr>
                    <td>Textbox 1</td>
                    <td><input type="text" id="txt1" /></td>
                </tr>

                <tr>
                    <td>Textbox 2</td>
                    <td><input type="text" id="txt2" /></td>
                </tr>

                <tr>
                    <td>Textbox 3</td>
                    <td><input type="text" id="txt3" /></td>
                </tr>
                
                <tr>
                    <td>Textbox 4</td>
                    <td>
                    <%--<input type="text" id="txt4" />--%>
                    <textarea id="txt4" rows="2"></textarea>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <div id="div_result" class="panel panel-default" style="display:none;">
        <div class="panel-heading">
            <strong>Result</strong>
            <span style="display:block;position:absolute;">
            </span>
        </div>

        <div id="DataList" style="overflow:auto;display:none;">
            <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                <thead>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</asp:Content>

