<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="ParameterMst.aspx.cs" Inherits="Admin_Master_ParameterMst" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css">
        table
        {
            margin-top: 20px;
        }
        
        #tbl_param select
        {
            width: 100%;
        }
        
        #tbl_param input[type=text]
        {
            width: 94%;
        }
        
        #tbl_param tr th:first-child, #tbl_param tr td:first-child
        {
            width: 15%;
        }
        
        #tbl_param tr th:nth-child(2), #tbl_param tr td:nth-child(2)
        {
            width: 13%;
        }
        
        #tbl_param tr th:nth-child(3), #tbl_param tr td:nth-child(3)
        {
            width: 12%;
        }
        
        #tbl_param tr th:nth-child(4), #tbl_param tr td:nth-child(4)
        {
            width: 30%;
        }
        
        #tbl_param tr th:last-child, #tbl_param tr td:last-child
        {
            width: 30%;
        }
    </style>

    <script type="text/javascript">
        var oTable;
        var param_data = [];

        $(document).ready(function () {
            getParamDetail();

            $('#btn_save').on('click', function () {
                saveChanges();
            });
        });

        function getParamDetail() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_parameter_value_all",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        param_data = JSON.parse(data.d)

                        setTableData();
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }

        function setTableData() {
            var count = 1;
            for (var i = 0; i < param_data.length; i++) {
                var str_html = '';
                var drp_option = '<option value="E">Enable</option><option value="D">Disable</option>';

                if (param_data[i]['value_option'] != '') {
                    var obj_val_option = param_data[i]['value_option'].split(',');

                    if (obj_val_option.length > 1) {
                        drp_option = '';
                        for (var j = 0; j < obj_val_option.length; j++) {
                            drp_option += '<option value="' + obj_val_option[j].split(':')[0] + '">' + obj_val_option[j].split(':')[1] + '</option>';
                        } 
                    }
                }
                debugger;
                if (param_data[i]["Group_no"] == count) {
                    count++;
                    str_html += '<tr><td colspan="6" style="color:blue;background-color:#7e6c6c;">' + param_data[i]['Group_name'] + '</td></tr>';
                }
                str_html += '<tr id="tr' + param_data[i]['parameter_id'] + '">';

                str_html += '<td>' + param_data[i]['parameter_name'] +
                            '<input type="hidden" class="cls_hdn_id" value="' + param_data[i]['parameter_id'] + '" />' +
                            '<input type="hidden" class="cls_hdn_grp" value="' + param_data[i]['group_id'] + '" /></td>';

                str_html += '<td>' + param_data[i]['user_type'] + '</td>';

                if (param_data[i]['group_id'] == "4")
                    str_html += '<td><input type="text" class="cls_drp_param_value" value="' + param_data[i]['parameter_value'] + '"/></td>';
                else
                    str_html += '<td><select class="cls_drp_param_value" onchange="param_value_change()">' + drp_option + '</select></td>';

                if (param_data[i]['group_id'] == '2' || param_data[i]['group_id'] == '3')
                    str_html += '<td><input type="text" class="cls_text_message" /></td>';
                else
                    str_html += '<td></td>';

                if (param_data[i]['group_id'] == '3')
                    str_html += '<td><input type="text" class="cls_text_page_path" disabled /></td>';
                else
                    str_html += '<td></td>';

                str_html += '</tr>';

                $('#tbl_param tbody').append(str_html);
            }

            for (var j = 0; j < param_data.length; j++) {
                $('#tr' + param_data[j]['parameter_id'] + ' .cls_drp_param_value').val(param_data[j]['parameter_value']);

                if (param_data[j]['group_id'] == '2' || param_data[j]['group_id'] == '3')
                    $('#tr' + param_data[j]['parameter_id'] + ' .cls_text_message').val(param_data[j]['disable_message']);

                if (param_data[j]['group_id'] == '3')
                    $('#tr' + param_data[j]['parameter_id'] + ' .cls_text_page_path').val(param_data[j]['page_path']);
            }

            param_value_change();
        }

        function param_value_change() {
            $('.cls_drp_param_value').each(function (e) {
                if (this.value == "D")
                    $(this).css('color', 'red');
                else
                    $(this).css('color', 'black');
            });
        }

        function saveChanges() {
            if (param_data.length > 0) {
                for (var i = 0; i < param_data.length; i++) {
                    param_data[i]['parameter_value'] = $('#tr' + param_data[i]['parameter_id'] + ' .cls_drp_param_value').val();

                    if (param_data[i]['group_id'] == '2' || param_data[i]['group_id'] == '3')
                        param_data[i]['disable_message'] = $('#tr' + param_data[i]['parameter_id'] + ' .cls_text_message').val();
                    else
                        param_data[i]['disable_message'] = '';

                    if (param_data[i]['group_id'] == '3')
                        param_data[i]['page_path'] = $('#tr' + param_data[i]['parameter_id'] + ' .cls_text_page_path').val();
                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_parameters_value",
                    data: JSON.stringify({ 'param_data': param_data }),
                    data: "{ param_data: '" + JSON.stringify(param_data) + "' }",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            res = JSON.parse(data.d)

                            alert(res['message']);

                            location.reload();
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });
            } 
        }

    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div>
        <div id="DataList" style="overflow: auto;">
            <table id="tbl_param" cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" width="100%">
                <thead>
                    <tr style="color:#9c27b0;">
                        <th>Parameter Name</th>
                        <th>User Type</th>
                        <th>Parameter Value</th>
                        <th>Disable Message</th>
                        <th>Page Path</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
    
    <div id="div_button" style="text-align: center; margin: 10px 10px 50px 10px;">
        <input type="button" id="btn_save" value="Save Changes" class="btn btn-primary" />
    </div>
</asp:Content>

