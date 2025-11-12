<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true" CodeFile="Deadline.aspx.cs" Inherits="ProjectTraining_Deadline" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
        <div class="panel panel-default " style="width: 49%;margin-left:22%;margin-top: 8%;">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Deadline Dates</span></strong>
            </div>
            <div style="padding: 15px; margin-right: 14px;" id="div3">
                <div class="row">
                    <div style="" class="form-group col-md-12">
                        <table id="tbl_deadline" class="table" align="center" style="width: 500px !important;">
                            <tbody>
                                <tr>
                                    <td style="width: 50px !important;"><b>Sr. No.</b></td>
                                    <td style="width: 250px !important;"><b>Name</b></td>
                                    <td><b>Date</b></td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    
    <script type="text/javascript">
        var user;
        $(document).ready(function () {
            var plan_entry_deadline;
            var date_of_join;
            user = ('<%= Session["UserId"] %>');
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_sjr_report_date",
                data: '{}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    debugger;
                    obj_date = JSON.parse(result.d);
                    if (obj_date[0]['is_submit'] == 'Y') {

                        date_of_join = obj_date[0]['date_of_join'];
                        plan_entry_deadline = obj_date[0]['plan_entry_deadline'];

                    }
                    else {
                        bootbox.alert('Please Submit Site Join Report', function () {
                            window.location.href = "site_joining_report(SJR).aspx";
                        });


                    }
                },
                error: function (error) {

                }
            });
            debugger;
            var a = new Date(plan_entry_deadline);
            var b = a.getFullYear();
            var dead_date = a.getDate() + '/' + (a.getMonth() + 1) + '/' + a.getFullYear();
            var sr_no = 2;
            var car_no = 0;

            var str1 = "";
            str1 += "<tr><td>1</td><td>SES Planned</td><td style='color:red;'><b>" + dead_date + "</b></td></tr>";
            str1 += "<tr><td>2</td><td>Preliminary Site Report</td><td style='color:red;'><b>" + dead_date + "</b></td></tr>";


            var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var now = new Date(date_of_join);
            var totaldays = 112;
            switch (now.getDay()) {
                case 0:
                    totaldays = parseInt(totaldays + 7);
                    break;
                case 1:
                    totaldays = parseInt(totaldays + 7);
                    break;
                case 2:
                    totaldays = parseInt(totaldays + 6);
                    break;
                case 3:
                    totaldays = parseInt(totaldays + 5);
                    break;
                case 4:
                    totaldays = parseInt(totaldays + 4);
                    break;
                case 5:
                    totaldays = parseInt(totaldays + 3);
                    break;
                case 6:
                    totaldays = parseInt(totaldays + 2);
            }

            if (now.getDay() == 0) {
                counter = 0;
            }
            else {
            }
            var temp_ctn = 1;
            for (var i = 0; i < 119; i++) {
                var now = new Date(date_of_join);
                now.setDate(now.getDate() + i)

                switch (now.getDay()) {
                    case 0:
                        day = "Sun";
                        break;
                    case 1:
                        day = "Mon";
                        break;
                    case 2:
                        day = "Tue";
                        break;
                    case 3:
                        day = "Wed";
                        break;
                    case 4:
                        day = "Thu";
                        break;
                    case 5:
                        day = "Fri";
                        break;
                    case 6:
                        day = "Sat";
                }

                if (i == 28 || i == 49 || i == 70 || i == 91 || i == 112) {

                    var t = sr_no = sr_no + 1;
                    var t1 = car_no = car_no + 1;
                    str1 += "<tr><td>" + t + "</td><td>CAR " + t1 + "</td><td style='color:red;'><b>" + monthNames[now.getMonth()] + " " + now.getDate() + "</b></td></tr>"

                }

            }


            $('#tbl_deadline tbody').append(str1);
        });
    </script>
</asp:Content>

