<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="vertical_studio_preferences.aspx.cs" Inherits="Student_vertical_studio_preferences" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        table
        {
            min-width: 100% !important;
        }
    </style>
     
    <script type="text/javascript">
        var parameter_status = '';
        $(document).ready(function ()
        {
            //status();
            bind_current_year_sem();
            
            bind_sem_course_data();
            bind_sem_course_data_reg();
            
            // Save button
            $("#btnsave").on("click", function () {
                save_data();
                return false;
            });

            // Register button
            $("#btn_reg").on("click", function () {
                Register_data();
                return false;
            });
        });

        
        function bind_current_year_sem() {
            $.ajax({
                async: false,
                type: "POST",
                url: "../WebService.asmx/get_parameter_value_current_sem",
                data: {},
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data)
                {
                    if (data.d[0] != null && data.d[1] != null) {
                        var current_sem_data = JSON.parse(data.d[0]);
                        $('#hdn_sem_code').val(current_sem_data[0]["sem_code"]);
                        $('#hdn_year_code').val(current_sem_data[0]["year_code"]);
                    }
                    else {
                        
                        return false;
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }



        function bind_sem_course_data() {
            $.ajax({
                async: false,
                type: "POST",
                url: "../WebService.asmx/get_student_vertical_studio_course_dtl",
                data: {},
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data)
                {
                    if ($('#parameter_status').val() == "E") {
                    if (data.d[0] != null && data.d[1] != null)
                    {
                        var course_data = JSON.parse(data.d[0]);
                        var student_course_data = JSON.parse(data.d[1]);
                        var select_course_data;
                        var str = "";

                        for (var i = 0; i < course_data.length; i++) {
                            select_course_data = $.grep(student_course_data, function (n, j)
                            {
                                return n["parent_course"] == course_data[i]["course_code"];
                            });

                            if (select_course_data.length > 0) {
                                var prio_option = "<option value=''>Select Priority</option>";

                                for (var opt = 1; opt <= select_course_data.length; opt++) {
                                    prio_option += "<option value='" + opt + "'>" + opt + "</option>";
                                }

                                str += '<div class="panel panel-default" style="display: block;"> ';
                                str += '<div class="panel-heading">';
                                str += '<strong>' + select_course_data[0]["parent_course"] + '</strong> ';
                                str += '<strong style="color: red;"><span style=float:right;>P : Prefernces S : Student</span> </strong>';
                                str += '</div>';
                                str += "<div><table id='" + select_course_data[0]["parent_course"] + "' class='table table-bordered tbl'>";
                                str += "<thead><tr><th style=width:8%;>Priority</th><th>Course Code</th><th>Name</th><th>Instructors</th><th>Selected Priority Status</th><th>Course Outline</th><th>Studio Mode</th><th>Course Outline Download</th></tr></thead>";
                                str += "<tbody>";

                                for (var k = 0; k < select_course_data.length; k++) {
                                    var prio_status = "";
                                    if (select_course_data[k]["status"] == "R" && select_course_data[k]["shortlist_student_status"] == "Y") {
                                        prio_status = "Shortlisted";
                                        $('#div_button').html("");
                                    }
                                    else if (select_course_data[k]["status"] == "R") {
                                        prio_status = "Registered";
                                        $('#div_button').html("");
                                    }
                                    else if (select_course_data[k]["status"] == "A") {
                                        prio_status = "Allocated";
                                        $('#div_button').html("");
                                    }
                                    else {
                                        prio_status = "Not Registered";
                                    }

                                    str += "<tr>";

                                    if (select_course_data[k]["status"] == 'R' || select_course_data[k]["status"] == 'A')
                                        str += "<td>" + select_course_data[k]["priority"] + "<strong style='color: blue;'><span>" + select_course_data[k]["priority_count"] +"</span></strong></td>";
                                    else
                                        str += "<td><select class=cls_prio>" + prio_option + "</select> <strong style='color: blue;'><span>" + select_course_data[k]["priority_count"] +"</span></strong></td>";

                                    str += "<td class='course_code'>" + select_course_data[k]["course_code"] + "</td>";
                                    str += "<td>" + select_course_data[k]["course_name"] + "</td>";
                                    str += "<td>" + select_course_data[k]["instructors"] + "</td>";
                                    if (prio_status == 'Allocated')
                                    {
                                        str += "<td style='color:blue;'>" + prio_status + "</td>";
                                    }
                                    else
                                    {
                                        str += "<td>" + prio_status + "</td>";
                                    }
                                    
                                    str += "<td>" + select_course_data[k]["course_outline"] + "</td>";
                                    str += "<td>" + select_course_data[k]["studio_mode"] + "</td>";
                                    str += "<td><input type='button' class='cls_btn' id='" + select_course_data[k]["course_code"] + "' onclick=print_PDF(\'" + select_course_data[k]["course_code"] + "\') value='Download'/> </td>";
                                    str += "</tr>";
                                }
                                str += "</tbody></table></div></div>";
                            }
                        }

                        $("#DataList").html(str);
                        select_dropdown(student_course_data);
                    }
                    else
                    {
                        debugger;
                       // bind_sem_course_data_reg();
                        $('#div_button').html("");
                        window.location.href = "Dashboard.aspx";
                        return false;
                        }
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }


        function bind_sem_course_data_reg() {
            $.ajax({
                async: false,
                type: "POST",
                url: "../WebService.asmx/get_student_vertical_studio_course_dtl_reg",
                data: {},
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                    if ($('#parameter_status').val() == "D")
                    {
                        if (data.d[0] != null) {

                            var select_course_data = JSON.parse(data.d[0]);

                            var str = "";
                            if (select_course_data.length > 0) {
                                str += '<div class="panel panel-default" style="display: block;"> ';
                                str += '<div class="panel-heading">';
                                str += '<strong>' + select_course_data[0]["parent_course"] + '</strong> ';
                                str += '<strong style="color: red;"><span style=float:right;>P : Prefernces S : Student</span> </strong>';
                                str += '</div>';
                                str += "<div><table id='" + select_course_data[0]["parent_course"] + "' class='table table-bordered tbl'>";
                                str += "<thead><tr><th style=width:8%;>Priority</th><th>Course Code</th><th>Name</th><th>Instructors</th><th>Selected Priority Status</th><th>Course Outline</th><th>Studio Mode</th><th>Course Outline Download</th></tr></thead>";
                                str += "<tbody>";

                                for (var k = 0; k < select_course_data.length; k++) {
                                    var prio_status = "";

                                    if (select_course_data[k]["status"] == "R" && select_course_data[k]["shortlist_student_status"] == "Y")
                                    {
                                        prio_status = "<span style='color:blue;'>Shortlisted</span>";
                                        $('#div_button').html(""); 
                                    }
                                    else if (select_course_data[k]["status"] == "R")
                                    {
                                        prio_status = "<span style='color:blue;'>Registered</span>";
                                        $('#div_button').html("");
                                    }
                                    else if (select_course_data[k]["status"] == "A") {
                                        prio_status = "<span style='color:green;'>Allocated</span>";
                                        $('#div_button').html("");
                                    }
                                    else
                                    {
                                        prio_status = "Not Registered";
                                    }

                                    str += "<tr>";

                                    if (select_course_data[k]["status"] == 'R' || select_course_data[k]["status"] == 'A' || select_course_data[k]["status"] == 'S') {
                                        str += "<td>" + select_course_data[k]["priority"] + "<strong style='color: blue;'><span>" + select_course_data[k]["priority_count"]+"</span></strong></td>";
                                    }
                                    str += "<td class='course_code'>" + select_course_data[k]["course_code"] + "</td>";
                                    str += "<td>" + select_course_data[k]["course_name"] + "</td>";
                                    str += "<td>" + select_course_data[k]["instructors"] + "</td>";
                                    str += "<td>" + prio_status + "</td>";
                                    str += "<td>" + select_course_data[k]["course_outline"] + "</td>";
                                    str += "<td>" + select_course_data[k]["studio_mode"] + "</td>";
                                    str += "<td><input type='button' class='cls_btn' id='" + select_course_data[k]["course_code"] + "' onclick=print_PDF(\'" + select_course_data[k]["course_code"] + "\') value='Download'/> </td>";
                                    str += "</tr>";
                                }
                                str += "</tbody></table></div></div>";
                            }
                            //}

                            $("#DataList").html(str);
                            $('#div_button').css('display', 'none');
                        }
                        else {
                            $('#div_button').html("");
                            return false;
                        }
                    }
                    
                },
                error: function (msg) { alert(msg.d); }
            });
           
        }


        function select_dropdown(std_obj) {
            var table_count = document.getElementsByClassName("tbl");

            for (var i = 0; i < table_count.length; i++) {
                var rows_count = table_count[i].getElementsByTagName("tbody")[0].getElementsByTagName("tr").length;

                for (var j = 1; j <= rows_count; j++) {
                    var course_code = table_count[i].rows[j].getElementsByClassName("course_code")[0].innerText;

                    var course_check = $.grep(std_obj, function (n, j) {
                        return n["course_code"] == course_code;
                    });

                    if (course_check.length > 0 && course_check[0]["status"] != 'R' && course_check[0]["status"] != 'A') {
                        if (course_check[0]["priority"] == "") {
                            table_count[i].rows[j].getElementsByClassName("cls_prio")[0].value = "";
                        } else {
                            table_count[i].rows[j].getElementsByClassName("cls_prio")[0].value = course_check[0]["priority"];
                        }
                    }
                }
            }
        }

        function save_data() {
            var datalist = [];
            var table_count = document.getElementsByClassName("tbl");

            for (var i = 0; i < table_count.length; i++) {
                var temp_datalist = [];
                var rows_count = table_count[i].getElementsByTagName("tbody")[0].getElementsByTagName("tr").length;

                for (var j = 1; j <= rows_count; j++) {
                    var obj = {};
                    var obj_temp = {};
                    var temp_priority = table_count[i].rows[j].getElementsByClassName("cls_prio")[0].value;

                    if (temp_priority == "") {
                        bootbox.alert("Please Select Priority");
                        return false;
                    } 
                    else {
                        var temp_check = $.grep(temp_datalist, function (n, j) {
                            return n["priority"] == temp_priority;
                        });

                        if (temp_check.length > 0) {
                            alert("You can not assign one priority to multiple courses.");
                            return false;
                        } else {
                            obj_temp["priority"] = table_count[i].rows[j].getElementsByClassName("cls_prio")[0].value;
                            temp_datalist.push(obj);
                        }
                    }

                    obj["priority"] = table_count[i].rows[j].getElementsByClassName("cls_prio")[0].value;
                    obj["course_code"] = table_count[i].rows[j].getElementsByClassName("course_code")[0].innerText;
                    obj["parent_course"] = table_count[i].id;
                    obj["status"] = "S";
                    datalist.push(obj);
                }
            }

            $.ajax({
                async: false,
                type: "POST",
                url: "../WebService.asmx/save_student_vertical_studio_course_priority",
                data: "{jsonString:'" + JSON.stringify(datalist) + "' }",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                    var save_data = JSON.parse(data.d);
                    bootbox.alert(save_data["message"]);
                    return false;
                },
                error: function (msg) { alert(msg.d); }
            });
        }

        function Register_data() {
            var datalist = [];
            var table_count = document.getElementsByClassName("tbl");

            for (var i = 0; i < table_count.length; i++) {
                var temp_datalist = [];
                var rows_count = table_count[i].getElementsByTagName("tbody")[0].getElementsByTagName("tr").length;

                for (var j = 1; j <= rows_count; j++) {
                    var obj = {};
                    var obj_temp = {};
                    var temp_priority = table_count[i].rows[j].getElementsByClassName("cls_prio")[0].value;
                    
                    if (temp_priority == "") {
                        bootbox.alert("Please Select Priority");
                        return false;
                    } 
                    else {
                        var temp_check = $.grep(temp_datalist, function (n, j) {
                            return n["priority"] == temp_priority;
                        });

                        if (temp_check.length > 0) {
                            alert("You can not assign one priority to multiple courses.");
                            return false;
                        } else {
                            obj_temp["priority"] = table_count[i].rows[j].getElementsByClassName("cls_prio")[0].value;
                            temp_datalist.push(obj);
                        }
                    }

                    obj["priority"] = table_count[i].rows[j].getElementsByClassName("cls_prio")[0].value;
                    obj["course_code"] = table_count[i].rows[j].getElementsByClassName("course_code")[0].innerText;
                    obj["parent_course"] = table_count[i].id;
                    obj["status"] = "R";
                    datalist.push(obj);
                }
            }
            $.ajax({
                async: false,
                type: "POST",
                url: "../WebService.asmx/save_student_vertical_studio_course_priority",
                data: "{jsonString:'" + JSON.stringify(datalist) + "' }",
                contentType: "application/json; charset=utf-8",
                datatype: "json",
                success: function (data) {
                    var save_data = JSON.parse(data.d);

                    if (save_data["status"] == "0") {
                        bootbox.alert(save_data["message"]);
                        bind_sem_course_data();
                    } 
                    else {
                        bootbox.alert(save_data["message"]);
                    }
                },
                error: function (msg) { alert(msg.d); }
            });
        }

        function print_PDF(data)
        {
            $('#hdn_course_code').val(data);
            $('#btn_download').click();
        }


        function status()
        {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_parameter_value",
                data: "{param_name:'vertical_studio_preferences'}",
                contentType: "application/json",
                //async: false,
               // cache: false,
                datatype: "json",
                success: function (data) {
                    if (data.d != "" && data.d != "[]")
                    {
                        var data_set = JSON.parse(data.d);
                        parameter_status = data_set[0]["parameter_value"];
                    }
                    else {
                    }
                },
                Error: function (data) {
                    alert(data.d);
                }
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp; Level 2 - Level 3 - Level 4 Studio Preferences 
            </h1>
        </div>
    </div>

    <div class="well" style="background-color: White;">
        <div>
            <div id="DataList">
            </div>
            <div align="center" id="div_button">
                <button id="btnsave" style="line-height: inherit;" class="btn btn-lg btn-primary">
                    <i class="icon-save bigger-160"></i>Save
                </button>
                <button id="btn_reg" style="line-height: inherit; margin-left: 30px;" class="btn btn-lg btn-primary">
                    <i class="icon-save bigger-160"></i>Register
                </button>
            </div>
        </div>

        <div style="display: none;">
            <asp:Button ID="btn_download" runat="server" ClientIDMode="Static" Text="test" OnClick="Download_OutLine" />
        </div>

        <input type="hidden" id="hdn_course_code" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_sem_code" runat="server" clientidmode="Static" />
        <input type="hidden" id="hdn_year_code" runat="server" clientidmode="Static" />
        <input type="hidden" id="parameter_status" runat="server" clientidmode="Static" />
    </div>
</asp:Content>

