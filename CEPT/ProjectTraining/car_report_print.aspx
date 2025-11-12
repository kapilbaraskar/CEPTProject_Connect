<%@ Page Language="C#" AutoEventWireup="true" CodeFile="car_report_print.aspx.cs" Inherits="ProjectTraining_car_report_print" %>

<!DOCTYPE html>

<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
        <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>
    <script src="../DesignJS/jquery.min.js" type="text/javascript"></script>

</head>
<body>
      <br />
    <div style="border: solid 2px">
        <div style="top: 20px; height: 96px; left: 1px;" title="" id="i22byht1">
            <a style="width: 297px; height: 96px; cursor: pointer;" href="../Master/Home.aspx" id="i22byht1link">
                <div id="i22byht1img" style="width: 297px; height: 96px; position: relative;">
                    <img alt="" style="margin-top: 10px; margin-left: 10px; width: 297px; height: 96px; object-fit: cover;" src="../image/ceptlogo_pdf.jpg" id="i22byht1imgimage" class="s4imgimage">
                </div>
            </a>
        </div>
        <div class="well" style="background-color: White; margin-top: 150px; margin-left: 68px">
            <span style="font-size: x-large">
                <br />
                <br />
                <br />
                <br />
                <center class="title_color"><span class="title_color font-size">Project Title:</span><span id="Project_title"></span> <span id="sem_type"></span> <span id="year" ></span> </center>
                <div class="panel panel-default" style="min-height: 100%">


                    <div id="div3">
                        <div class="row">
                            <div style="" class="form-group col-md-12">
                                <br />
                                <div>
                                    <center><span class="title_color font-size"  id="">CAR No.</span><span class="title_color" id="car_no"></span></center>
                                </div>
                                <br />
                                <div>
                                    <center> <span class="title_color font-size">CAR Title:</span><span class="title_color font-size" id="car_title"></span></center>
                                </div>
                                <br />
                                <div>
                                    <center><span class="prepared-by">PREPARED BY: <span id="user_name"></span></center>
                                </div>
                                <br />
                                <div>
                                    <center><span class="" style="font-size: large;">(DATE OF SUBMISSION)</span></center>
                                      <center><span class="" style="font-size: large;" id="date_text" runat="server"></span></center>
                                </div>

                                <div>
                                    <center><span class=""></span></center>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>

                <div style="padding-bottom: 350px;"></div>
        </div>
    </div>
    <div>
        <div class="page-2" style="background-color: White; margin-top: 50px; margin-left: 20px; margin-right: 20px; page-break-before: always">
            <center>
                    <table id="tb_Time_sheet" style="width:100%; border: solid 1px" class="display table table-striped table-bordered table-hover">
                    </table>
                    <div style="margin-top:100px;"></div>
            </center>
        </div>
    </div>

    <div>
        <div class="page-3" style="background-color: White; margin-top: 50px; margin-left: 20px; margin-right: 20px; page-break-before: always">
            <center>
            <table id="tb_Time_sheet1" style="width:100%; border: solid 1px" class="display table table-striped table-bordered table-hover">
            </table>
                <div style="margin-top:100px;"></div>
                </center>
        </div>
    </div>
     <div>
        <div class="page-3" style="background-color: White; margin-top: 50px; margin-left: 20px; margin-right: 20px; page-break-before: always" class="last_report">
            <center>
            <table id="tb_Time_sheet2" style="width:100%; border: solid 1px" class="display table table-striped table-bordered table-hover">
            </table>
                <div style="margin-top:100px;"></div>
                </center>
        </div>
    </div>

    <div  >
        <div class="page-4" style="background-color: White; margin-top: 50px; margin-left: 20px; margin-right: 20px; page-break-before: always">
            <center>
            <table  id="tbl_planned" style="width:100%; border: solid 1px" class="display table table-striped table-bordered table-hover">
            </table>
                <div style="margin-top:100px;"></div>
                </center>
        </div>
    </div>

    <div  >
        <div class="page-4" style="background-color: White; margin-top: 50px; margin-left: 20px; margin-right: 20px; page-break-before: always">
            <center>
            <table  id="tbl_actual" style="width:100%; border: solid 1px" class="display table table-striped table-bordered table-hover">
            </table>
                <div style="margin-top:100px;"></div>
                </center>
        </div>
    </div>

     <input type="hidden" runat="server" clientidmode="Static" id="hdn_timesheet_data" />
     <input type="hidden" runat="server" clientidmode="Static" id="hdn_actual_data" />

 <script type="text/javascript">
     var str1 = '';
     var str2 = '';
     var str7 = '';
     var PageNumber = '';
     var obj_planned_actual_data = new Object();
     var user_id = '';
     var temp_title = JSON.parse(getQueryStringValue("car_title"));
     var tmp_car_title = temp_title['car_title'];//.replace(/111/g, "&");


     console.log("temp_title" + temp_title);
     $("#Project_title").text(getQueryStringValue("project_name"));
     $("#car_title").text(tmp_car_title);
     $("#user_name").text(getQueryStringValue("user_name"));
     $("#car_no").text(getQueryStringValue("page_number"));
   //  $("#date").text(getQueryStringValue("date"));
     
     
     function getQueryStringValue(key) {
         return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
     }

     $(document).ready(function () {
         debugger;
         obj_timesheet = JSON.parse(document.getElementById("hdn_timesheet_data").value);
         obj_planned_actual_data = JSON.parse(document.getElementById("hdn_actual_data").value);
         timesheet1();
         timesheet2();
         timesheet3();
         

         bind_planned();
         bind_actual();

         function timesheet1() {
             if (Object.keys(obj_timesheet[0]).length > 0) {

                 str1 += ' <thead><tr><td colspan="14" ><center><b>Weekly Timesheet Data   [ ' + Object.keys(obj_timesheet[1])[3] + ' To ' + Object.keys(obj_timesheet[1])[8] + ' ]</b></center></td> </tr></thead>';
                 str1 += ' <thead><tr>';

                 for (var i = 0; i < Object.keys(obj_timesheet[0]).length; i++) {

                     if (i == 9) {
                         break;
                     }
                     
                     if (Object.keys(obj_timesheet[0])[i] != 'user_id') {

                         if (Object.keys(obj_timesheet[0])[i].length > 9) {

                             str1 += '<td  class="center">' + Object.keys(obj_timesheet[0])[i].substr(0, 2) + '</td>';
                         }
                         else {
                             str1 += '<td  class="center">' +titleCase( Object.keys(obj_timesheet[0])[i] )+ '</td>';
                         }

                     }

                 }
                 str1 += '<td class="center">Total</td></thead></tr>';
             }

             for (var j = 0; j < obj_timesheet.length; j++) {
                 var total = 0;
                 str1 += "<tr><td class='td_width center'>" + obj_timesheet[j]['code'] + " </td> <td>" + obj_timesheet[j]['name'] + "</td>"

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

             $('#tb_Time_sheet').append(str1);
         }

         function timesheet2() {

             

             if (Object.keys(obj_timesheet[0]).length > 0) {

                 str2 += ' <thead><tr><td colspan="14" ><center><b>Weekly Timesheet Data  [ ' + Object.keys(obj_timesheet[1])[9] + ' To ' + Object.keys(obj_timesheet[1])[14] + ' ]</b></center></td> </tr></thead>';
                 str2 += ' <thead><tr>';

                 for (var i = 0; i < Object.keys(obj_timesheet[0]).length; i++) {

                     if (i > 2 && i < 9) {
                         continue;
                     }
                     if (i > 14) {
                         continue;
                     }
                     if (Object.keys(obj_timesheet[0])[i] != 'user_id') {
                         if (Object.keys(obj_timesheet[0])[i].length > 9 ) {
                             str2 += ' <td  class="center">' + Object.keys(obj_timesheet[0])[i].substr(0, 2) + '</td>';
                         } else {
                             str2 += ' <td  class="center">' + titleCase(Object.keys(obj_timesheet[0])[i] )+ '</td>';
                         }
                     }

                 }
                 str2 += '<td class="center">Total</td></thead></tr>';
             }

             for (var j = 0; j < obj_timesheet.length; j++) {
                 var total = 0;
                 str2 += "<tr>   <td class='td_width center'>" + obj_timesheet[j]['code'] + " </td> <td>" + obj_timesheet[j]['name'] + "</td>"

                 for (var i = 9; i < Object.keys(obj_timesheet[0]).length; i++) {
                     if (i == 15) {
                         break;
                     }
                     str2 += ' <td  class="center">' + obj_timesheet[j][Object.keys(obj_timesheet[0])[i]] + '</td>';
                     if (obj_timesheet[j][Object.keys(obj_timesheet[0])[i]] != "") {
                         total += parseInt(obj_timesheet[j][Object.keys(obj_timesheet[0])[i]]);
                     }
                 }
                 str2 += "<td class='center'>" + total + "</td></tr> ";
             }

             $('#tb_Time_sheet1').append(str2);
         }
         function timesheet3() {

             debugger;
             if (Object.keys(obj_timesheet[1])[15] != undefined) {
                 if (Object.keys(obj_timesheet[0]).length > 0) {

                     str7 += ' <thead><tr><td colspan="14" ><center><b>Weekly Timesheet Data  [ ' + Object.keys(obj_timesheet[1])[15] + ' To ' + Object.keys(obj_timesheet[1])[20] + ' ]</b></center></td> </tr></thead>';
                     str7 += ' <thead><tr>';

                     for (var i = 0; i < Object.keys(obj_timesheet[0]).length; i++) {

                         if (i > 2 && i < 15) {
                             continue;
                         }
                         if (i > 21) {
                             continue;
                         }
                         if (Object.keys(obj_timesheet[0])[i] != 'user_id') {
                             if (Object.keys(obj_timesheet[0])[i].length > 9) {
                                 str7 += ' <td  class="center">' + Object.keys(obj_timesheet[0])[i].substr(0, 2) + '</td>';
                             } else {
                                 str7 += ' <td  class="center">' + titleCase(Object.keys(obj_timesheet[0])[i]) + '</td>';
                             }
                         }

                     }
                     str7 += '<td class="center">Total</td></thead></tr>';
                 }

                 for (var j = 0; j < obj_timesheet.length; j++) {
                     var total = 0;
                     str7 += "<tr>   <td class='td_width center'>" + obj_timesheet[j]['code'] + " </td> <td>" + obj_timesheet[j]['name'] + "</td>"

                     for (var i = 15; i < Object.keys(obj_timesheet[0]).length; i++) {

                         str7 += '<td  class="center">' + obj_timesheet[j][Object.keys(obj_timesheet[0])[i]] + '</td>';
                         if (obj_timesheet[j][Object.keys(obj_timesheet[0])[i]] != "") {
                             total += parseInt(obj_timesheet[j][Object.keys(obj_timesheet[0])[i]]);
                         }
                     }
                     str7 += "<td class='center'>" + total + "</td></tr> ";
                 }

                 $('#tb_Time_sheet2').append(str7);
             } else {
                 $('.last_report').remove();
                 $('#tb_Time_sheet2').remove();
             }
         }

         function bind_planned() {
             debugger;
             var str3 = '';
             if (obj_planned_actual_data.length > 0) {

                 str3 += ' <thead><tr><td colspan="14" ><center><b>SES Planning</b></center></td> </tr></thead>';
                 str3 += ' <thead style="font-weight: 600;"><tr><td style="text-align:center;">Date</td> <td style="text-align:center;width: 30%;">Structure</td> <td style="text-align:center;width: 30%;"">Location</td>  <td  style="text-align:center;width: 30%;">Activity</td>   </tr></thead>';
             }
             str3 += "<tbody>";
             for (var i = 0; i < obj_planned_actual_data.length; i++) {
                 str3 += "<tr><td>" + obj_planned_actual_data[i]['date'] + "</td> ";
                 str3 += "<td>" + obj_planned_actual_data[i]['structure'] + "</td> ";
                 str3 += "<td>" + obj_planned_actual_data[i]['location'] + "</td> ";
                 str3 += "<td>" + obj_planned_actual_data[i]['activity'] + "</td> ";
                 str3 += "</tr>";
             }

             str3 += "</tbody>";
             $('#tbl_planned').append(str3);

         }

         function bind_actual() {
             debugger;
             var str3 = '';
             if (obj_planned_actual_data.length > 0) {

                 str3 += ' <thead><tr><td colspan="14" ><center><b>SES Actual</b></center></td> </tr></thead>';
                 str3 += ' <thead style="font-weight: 600;"><tr><td style="text-align:center;width: 10%;">Date</td> <td style="text-align:center;width: 25%;" >Structure</td> <td style="text-align:center;width: 25%;">Location</td>  <td  style="text-align:center;width: 25%;">Activity</td>   <td style="text-align:center;width: 25%;">Remark</td> </tr></thead>';
             }
             str3 += "<tbody>";
             for (var i = 0; i < obj_planned_actual_data.length; i++) {
                 str3 += "<tr><td>" + obj_planned_actual_data[i]['date'] + "</td> ";
                 str3 += "<td>" + obj_planned_actual_data[i]['structure_actual'] + "</td> ";
                 str3 += "<td>" + obj_planned_actual_data[i]['location_actual'] + "</td> ";
                 str3 += "<td>" + obj_planned_actual_data[i]['activity_actual'] + "</td> ";
                 str3 += "<td>" + obj_planned_actual_data[i]['Remark_actual'] + "</td> ";
                 str3 += "</tr>";
             }

             str3 += "</tbody>";
             $('#tbl_actual').append(str3);

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

     }) </script>


</body>

    <style>
    .center {
    
    text-align:center;
    }

    #tbl_actual {
        border-spacing: 0;
        border-color: black;
        border-left: 1px;
        border-top: 1px;
    }

    #tbl_actual tr td {
            border: solid 1px;
            border-right: 1px;
            border-bottom: 1px;
            border-color: black;
        }

    #tbl_planned {
        border-spacing: 0;
        border-color: black;
        border-left: 1px;
        border-top: 1px;
    }

    #tbl_planned tr td {
            border: solid 1px;
            border-right: 1px;
            border-bottom: 1px;
            border-color: black;
        }

    #tb_Time_sheet {
        border: solid 1px;
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
    #tb_Time_sheet2 {
        border-spacing: 0;
        border-color: black;
        border-left: 1px;
        border-top: 1px;
    }
    
    #tb_Time_sheet2 tr td {
            border: solid 1px;
            border-right: 1px;
            border-bottom: 1px;
            border-color: black;
        }

    .prepared-by {
        font-size: medium;
    }

    .font {
        font-size: x-large;
    }

    .title_color {
        color: #418ab3;
    }

    #tbl_print tr td {
        border-right: 1px;
        border-bottom: 1px;
        border-color: black;
    }

    #tbl_print {
        border-spacing: 0;
        border-color: black;
        border-left: 1px;
        border-top: 1px;
    }

    .span-set {
        font-size: smaller;
        margin-left: 4px;
    }

    .setPadding {
        width: 25px;
    }

    .setWidth {
        width: 65px;
    }

    .td1 {
        width: 3%;
    }

    .btn_rad {
        border-radius: 6px;
    }
</style>
</html>
    