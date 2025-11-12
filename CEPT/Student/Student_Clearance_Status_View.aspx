<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Student_Clearance_Status_View.aspx.cs" Inherits="Student_Student_Clearance_Status_View" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../DesignCss/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>
 <script type="text/javascript">
        var oTable;
        var submitted_form_data;
        var sem = "";
        var year = "";
        var uid = "";
         $(document).ready(function () {

             setTableData();
             
         });

        function setTableData() {
           
            var submitted_form_data = JSON.parse($('#hdndata').val());
            for (var i = 0; i < submitted_form_data.length; i++)
            {
               
                   var uid = submitted_form_data[i]['user_id'];

                    var str_html = '';

                    str_html += '<tr id="tr' + submitted_form_data[i]['department_id'] + '">';

                str_html += '<td><b>' + submitted_form_data[i]['Department Name'] + '</b></td>';

                if (submitted_form_data[i]['Status'] == "On Hold") {
                        str_html += '<td><b style="color:blue;">' + submitted_form_data[i]['Status'] + '</b></td>';
                       
                    }
                else if (submitted_form_data[i]['Status'] == "Approved") {
                    str_html += '<td><b style="color:green;">' + submitted_form_data[i]['Status'] + '</b></td>';
                    }
                    else {
                    str_html += '<td>' + submitted_form_data[i]['Status'] + '</td>';
                       
                    }

                    str_html += '</tr>';

                    $('#tbl_param tbody').append(str_html);
             
            }

            
        }

 </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="status_of_clearance_form" style="display: block;">
        <h3 style="text-align: center;"><u>Status of the Clearances from Offices and Departments</u></h3>
        <div id="DataList" style="overflow: auto;">
            <table id="tbl_param" cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" style="width: 50%; margin-left: auto; margin-right: auto;">
                <thead>
                    <tr>
                        <th>Department</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <br />
        </div>
    </div>
    </form>

     <input type="hidden" id="hdn_user_id" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdnsem" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdnyear" runat="server" clientidmode="Static" />
    <input type="hidden" id="hdndata" runat="server" clientidmode="Static" />
</body>
</html>
