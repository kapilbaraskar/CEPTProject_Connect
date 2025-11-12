<%@ Page Language="C#" AutoEventWireup="true" CodeFile="week_reoprt_pdf.aspx.cs" Inherits="ProjectTraining_week_reoprt_pdf" %>

<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../DesignJS/jquery.min.js" type="text/javascript"></script>

</head>
<body>
    <div id="i22byht1img" style="float: right; height: 96px; position: relative;">
        <img alt="" style="width: 297px; height: 96px; object-fit: cover;" src="../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage">
    </div>
    <div class="well" style="background-color: White;">

        <input type="hidden" runat="server" clientidmode="Static" id="hdn_data" />
        <input type="hidden" runat="server" clientidmode="Static" id="year_sem" />
        <div class="panel panel-default ">
            <div class="panel-heading">
            </div>
            <div class="col-sm-12">
                <div>
                    <div class="page-2" style="background-color: White; margin-left: 20px; margin-right: 20px;">
                        <center>
                            <br /><br /><br /><br /><br /><br />
                        <center style="text-decoration: underline;    font-size: x-large;"> Time Sheet </center>

                                <br />
                                
                                <span style="font-size:x-large"><center>Project Training | Faculty Of Technology |<span id="sem_type"></span> <span id="year" ></span> </center>
                            <br />
                                 <span style="float:left;font-size:large;">Id: </span>  <span style="font-size:large;float:left" id="user_id"></span><br />
                                 <span style="  float:left;font-size:large;">Name: </span>  <span style="font-size:large;float:left" id="name"></span><br />
                                <span style="  float:left;font-size:large;">Project name: </span>  <span style="font-size:large;float:left" id="Email"></span><br />
                                      <span style="  float:left;font-size:large;">Address: </span>  <span style="font-size:large;float:left" id="address"></span>
                                
                    <table id="tb_Time_sheet" style="width:100%; border: solid 1px" class="display table table-striped table-bordered table-hover">
                    </table>
                    <div style="margin-top:10px; font-size:large">
                        <span style="float:left">Signature Of Student :</span>
                          <span>Signature Of Engineer In-charge :</span><br />
                          <br/><span style="float:left">Date :</span>
                        <span>Name :</span>
                    </div>
                       </center>
                    </div>
                </div>
            </div>
            <br />
        </div>
    </div>


    <script type="text/javascript">
        var obj_timesheet = new Object();
        var obj_user_details = obj_timesheet = JSON.parse(document.getElementById("year_sem").value);
        debugger;
        obj_timesheet = JSON.parse(document.getElementById("hdn_data").value);
        $("#sem_type").text(obj_user_details['sem_code']);
        $("#year").text(obj_user_details['year_code']);
        $("#name").text(obj_user_details['user_name']);
        $("#Email").text(obj_user_details['mail']);
        $("#user_id").text(obj_user_details['user_id']);
        $("#address").text(obj_user_details['address']);
        $(document).ready(function () {
            timesheet1();
        });


        function timesheet1() {
            var str1;
            if (Object.keys(obj_timesheet[0]).length > 0) {

                str1 += ' <thead><tr><td colspan="14" ><center><b>Weekly Timesheet Data   [ ' + Object.keys(obj_timesheet[1])[3] + ' To ' + Object.keys(obj_timesheet[1])[8] + ' ]</b></center></td> </tr></thead>';
                str1 += ' <thead><tr>';

                for (var i = 0; i < Object.keys(obj_timesheet[0]).length; i++) {

                    if (i == 9) {
                        break;
                    }
                    debugger;
                    if (Object.keys(obj_timesheet[0])[i] != 'user_id') {

                        if (Object.keys(obj_timesheet[0])[i].length > 9) {

                            str1 += '<td  class="center">' + Object.keys(obj_timesheet[0])[i].substr(0, 2) + '</td>';
                        }
                        else {
                            str1 += '<td  class="center">' +titleCase( Object.keys(obj_timesheet[0])[i]) + '</td>';
                        }

                    }

                }
                str1 += '<td class="center">Total</td></thead></tr>';
            }
            var total1 = 0;
            var total2 = 0;
            var total3 = 0;
            var total4 = 0;
            var total5 = 0;
            var total6 = 0;
            for (var j = 0; j < obj_timesheet.length; j++) {
                var total = 0;
               
                str1 += "<tr><td class='td_width center'>" + obj_timesheet[j]['code'] + " </td> <td>" + obj_timesheet[j]['name'] + "</td>"
                debugger;
                if (obj_timesheet[j][Object.keys(obj_timesheet[1])[3]] != "") {
                    total1 +=  parseInt(obj_timesheet[j][Object.keys(obj_timesheet[1])[3]]);
                }
                if (obj_timesheet[j][Object.keys(obj_timesheet[1])[4]] != "") {
                    total2 +=  parseInt(obj_timesheet[j][Object.keys(obj_timesheet[1])[4]]);
                }
                if (obj_timesheet[j][Object.keys(obj_timesheet[1])[5]] != "") {
                    total3 +=  parseInt(obj_timesheet[j][Object.keys(obj_timesheet[1])[5]]);
                }
                if (obj_timesheet[j][Object.keys(obj_timesheet[1])[6]] != "") {
                    total4 +=  parseInt(obj_timesheet[j][Object.keys(obj_timesheet[1])[6]]);
                }
                if (obj_timesheet[j][Object.keys(obj_timesheet[1])[7]] != "") {
                    total5 +=  parseInt(obj_timesheet[j][Object.keys(obj_timesheet[1])[7]]);
                }
                if (obj_timesheet[j][Object.keys(obj_timesheet[1])[8]] != "") {
                    total6 +=  parseInt(obj_timesheet[j][Object.keys(obj_timesheet[1])[8]]);
                }
                for (var i = 3; i < Object.keys(obj_timesheet[0]).length; i++) {
                    if (i == 9) {
                        break;
                    }

                    str1 += ' <td  class="center">' + obj_timesheet[j][Object.keys(obj_timesheet[1])[i]] + '</td>';

                    if (obj_timesheet[j][Object.keys(obj_timesheet[0])[i]] != "") {
                        total += parseInt(obj_timesheet[j][Object.keys(obj_timesheet[0])[i]]);
                    }

                }

                str1 += "<td class='center'>" + total + "</td></tr> ";
            }
            str1 += "<tr>"
            str1 += "<td class='td_width center'></td>"
            str1 += "<td>Total</td>"
            str1 += "<td>" + total1 +" </td>"
            str1 += "<td>" + total2 + " </td>"
            str1 += "<td>" + total3 + " </td>"
            str1 += "<td>" + total4 + " </td>"
            str1 += "<td>" + total5 + " </td>"
            str1 += "<td>" + total6 + " </td>"
            str1 += "<td></td>"
            $('#tb_Time_sheet').append(str1);
        }


        function titleCase(str) {
            var newstr = str.split(" ");
            for (i = 0; i < newstr.length; i++) {
                if (newstr[i] == "") continue;
                var copy = newstr[i].substring(1).toLowerCase();
                newstr[i] = newstr[i][0].toUpperCase() + copy;
            }
            newstr = newstr.join(" ");
            return newstr;
        }
    </script>
</body>

<style>
    #tb_Time_sheet {
        font-size: smaller;
        border-spacing: 0;
        border-color: black;
        border-left: 1px;
        border-top: 1px;
    }

        #tb_Time_sheet tr td {
            border: solid 1px;
            border-right: 1px;
            border-bottom: 1px;
            border-color: black;
        }

    #tb_Time_sheet1 {
        border-spacing: 0;
        border-color: black;
        border-left: 1px;
        border-top: 1px;
    }

        #tb_Time_sheet1 tr td {
            border: solid 1px;
            border-right: 1px;
            border-bottom: 1px;
            border-color: black;
        }
</style>
</html>
