<%@ Page Title="Change Parameter Current Sem" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="parameter_mst_current_sem.aspx.cs" Inherits="Admin_Master_parametermst_current_sem" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>
        select
        {
            width:100px;
        }
    </style>
    <script type="text/javascript">
        var oTable;
        var param_data = [];
        var year_data = [];
        $(document).ready(function () {
            getParamDetail();
            $('#btn_save').on('click', function () {
                saveChanges();
            });
        });

        function getParamDetail()
        {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_parameter_value_current_sem",
                data: "{}",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "") {
                        param_data = JSON.parse(data.d[0])
                        year_data = JSON.parse(data.d[1])
                        setTableData();
                    }
                },
                error: function (result)
                {
                    alert(result);
                }
            });
        }

        function changeformate(values)
        {
            var parts = values.split('/');
            var year = parts[2].split(' ');
            var dmyDate = parts[1] + '/' + parts[0] + '/' + year[0];
            return dmyDate;ssss
        }


        function setTableData()
        {
            var count = 1;
            

            for (var i = 0; i < param_data.length; i++)
            {
                var str_html = '';
                var dro_list = '';
                var semester_des = '';
                var summer_semester = '';
                semester_des = '<option value="M">Monsoon</option><option value="S">Spring</option>';
                summer_semester ='<option value="S">Summer</option><option value="W">Winter</option>'
                for (var j = 0; j < year_data.length; j++)
                {
                    dro_list += '<option value="' + year_data[j]["year_code"] + '">' + year_data[j]["year_desc"] + '</option>'
                }
              
                if (param_data[i]["Group_no"] == count )
                {
                    count++;
                    str_html += '<tr><td colspan="6" style="color:blue;background-color:#7e6c6c;">' + param_data[i]['Group_name'] + '</td></tr>';
                }

                str_html += '<tr id="tr' + param_data[i]['doc_no'] + '">';
                str_html += '<td class ="parameter_desc">' + param_data[i]['type_desc'] +
               '<input type="hidden" class="cls_hdn_grp" value="' + param_data[i]['doc_no'] + '" /></td>';
                if (param_data[i]['doc_no'] == "15" || param_data[i]['doc_no'] == "7" || param_data[i]['doc_no'] == "8")// || param_data[i]['doc_no'] == "21"
                {
                        str_html += '<td><select class="cls_drp_semester_value">' + summer_semester + '</select></td>'
                }
                else
                {
                    str_html += '<td><select class="cls_drp_semester_value">' + semester_des + '</select></td>'
                }
                str_html += '<td><select class="cls_drp_year_val">' + dro_list + '</select></td>';
                var formDate = param_data[i]['start_date'];
                if (formDate != "")
                {
                var dmyDate = changeformate(formDate);
                str_html += '<td>' + dmyDate + '</td>';
                }
                else
                {
                    str_html += '<td></td>';
                }
                var todate = param_data[i]['end_date'];
                if (todate != "")
                {
                var dmyDate = changeformate(todate);
                str_html += '<td>' + dmyDate + '</td>';
                }
                else
                {
                    str_html += '<td></td>';
                }
                var status = param_data[i]['active_flag'];
                if (status == "Y") {
                    str_html += '<td style="color:Green;">Active</td>';
                }
                else
                {
                    str_html += '<td style="color:Green;">InActive</td>';
                }
               
                str_html += '</tr>';
                $('#tbl_param tbody').append(str_html);
            }

            for (var j = 0; j < param_data.length; j++)
            {
                $('#tr' + param_data[j]['doc_no'] + ' .cls_drp_semester_value').val(param_data[j]['sem_code']);

                for (var yar_value = 0; yar_value < year_data.length; yar_value++)
                {
                    if (param_data[j]['year_code'] == year_data[yar_value]['year_desc'])
                    {
                        var ss =  $('#tr' + param_data[j]['doc_no'] + ' .cls_drp_year_val').val(year_data[yar_value]['year_code']);
                        $('#tr' + year_data[j]['doc_no'] + ' .cls_drp_year_val').val(year_data[yar_value]['year_code']);
                    }
                }
            }

        }

        function saveChanges()
        {
            if (param_data.length > 0)
            {
                for (var i = 0; i < param_data.length; i++)
                {
                    param_data[i]['sem_code'] = $('#tr' + param_data[i]['doc_no'] + ' .cls_drp_semester_value').children("option:selected").val();
                    param_data[i]['sem_desc'] = $('#tr' + param_data[i]['doc_no'] + ' .cls_drp_semester_value').children("option:selected").html();
                    param_data[i]['year_code'] = $('#tr' + param_data[i]['doc_no'] + ' .cls_drp_year_val').children("option:selected").html();

                }

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_parameters_current_sem",
                    data: JSON.stringify({ 'param_data': param_data }),
                    data: "{ param_data: '" + JSON.stringify(param_data) + "' }",
                    dataType: "json",
                    async: false,
                    success: function (data) {
                        if (data.d != "") {
                            res = JSON.parse(data.d)
                            //bootbox.alert(res['message']);
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
                        <th style="width:20%;">Parameter Name</th>
                        <th style="width:10%;">Semester</th>
                        <th style="width:10%;">Year</th>
                        <th style="width:15%;">Start Date</th>
                        <th style="width:15%;">End Date</th>
                        <th style="width:10%;">Status</th>
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

