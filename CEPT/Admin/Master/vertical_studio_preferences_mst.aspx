<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="vertical_studio_preferences_mst.aspx.cs" Inherits="Admin_Master_vertical_studio_preferences_mst" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    
    <script type="text/javascript">
        var semester = '';
        var year_code = '';
        var oTable;
        var tempData = [];
        var data_set = { 'doc_no': '', 'preference': '', 'status': '', 'semester_type': null, 'year_semester': null, 'value_FA': '', 'value_FD': '', 'value_FT': '', 'value_FP': '', 'value_FM': '' };
        $(document).ready(function () {
            bindsemdata();
            bindyeardata_for_cross_reg();

            $('#btnreterive').on('click', function () {
                get_details_data();
                return false;
            });
            
        });
        function change_value_1(values, current_value) {
            
            $('.' + values).attr('disabled', (current_value.value == "D") ? true : false);
            $('#' + values).attr('disabled', (current_value.value == "D") ? true : false);
            
            //alert(current_value.value);
        };
        function bindsemdata() {

            $('#drpsemester').empty().append($("<option></option>").val("").html("-- Please Select Semester --"));
            $('#drpsemester').append($("<option></option>").val("M").html("Monsoon"));
            $('#drpsemester').append($("<option></option>").val("S").html("Spring"));

            $('#drpsemester').chosen();

        }
        function bindyeardata_for_cross_reg() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/Get_year_data",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    if (data.d != "") {
                        var year_data = JSON.parse(data.d)
                        $('#drpyear').empty().append($("<option></option>").val("").html("-- Please Select Year --"));
                        for (var i = 0; i < year_data.length; i++) {
                            $('#drpyear').append($("<option></option>").val(year_data[i]["year_desc"]).html(year_data[i]["year_desc"]));
                        }
                        $('#drpyear').chosen();


                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }


        function get_details_data() {
            semester = $('#drpsemester').val();
            if (semester == "") {
                bootbox.alert('Please select semester');
                $('#drpsemester').focus();
                return false;
            }

            year_code = $('#drpyear').val();
            if (year_code == "") {
                bootbox.alert('Please select Year');
                $('#drpyear').focus();
                return false;
            }
           

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_semester_wise_preference",
                    data: "{sem_code:'" + semester + "',year_code:'" + year_code + "'}",
                    dataType: "json",
                    success: function (data) {
                        if (data.d != "" && data.d != "[]") {
                            debugger;
                            semester_wise_list(data.d);
                            $('#div_preference_list').css('display', 'block');
                        }
                        else {
                            bootbox.alert('No data Found For Selected Semester and Year');
                            $('#div_preference_list').css('display', 'none');
                            

                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

            return false;
        }


        function semester_wise_list(data) {

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
                "sDom": 'b',
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",

                "aaData": JSON.parse(data),

                "aoColumns": [
                    { "sTitle": "Doc No", "mData": "doc_no", "bSortable": false, "sClass": "cls_hide" },
                    { "sTitle": "Preference Name", "mData": "preference_name", "bSortable": false },
                    {
                        "sTitle": "Preference Status", "width": "5px", "mData": null, "sClass": "cls_hide", "bSortable": false, fnRender: function (data)
                        {
                            return '<select id ="' + data.aData.doc_no + '" onchange="change_value_1(' + data.aData.preference_number +',this)" class="cls_drp_type" style="width:112px;"><option value="">--Select Status--</option><option value="E">Enable</option><option value="D">Disable</option></select>' +

                                '<input type="hidden" class="cls_hdn_drp_type" value="' + data.aData.status + '" />';
                        }
                    },
                    {
                        
                        "sTitle": "<span><label style='width :120px;'>Faculty Architecture </label> <br><label style='width :30px;'>L2 </label> <label style='Width : 30px;'>L3 </label> <label style='width:30px;'>L4</label></span>", "mData": null, "bSortable": false, fnRender: function (data)
                        {
                             

                            return '<label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class ="' + data.aData.preference_number + '" id="FA_L2_' + data.aData.preference_number + '"  value=""></label>  <label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FA_L3_' + data.aData.preference_number + '" value=""></label>  <label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FA_L4_' + data.aData.preference_number + '" value=""></label>';
                        }
                    },
                    {

                        "sTitle": "<span><label style='width :100px;'>Faculty Planning </label> <br><label style='width :30px;'>L2 </label> <label style='Width : 30px;'>L3 </label> <label style='width:30px;'>L4</label></span>", "mData": null, "bSortable": false, fnRender: function (data) {

                            return '<label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FP_L2_' + data.aData.preference_number + '" value=""></label>  <label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FP_L3_' + data.aData.preference_number + '" value=""></label>  <label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FP_L4_' + data.aData.preference_number +'" value=""></label>';
                        }
                    },
                    {

                        "sTitle": "<span><label style='width :95px;'>Faculty Design </label> <br><label style='width :30px;'>L2 </label> <label style='Width : 30px;'>L3 </label> <label style='width:30px;'>L4</label></span>", "mData": null, "bSortable": false, fnRender: function (data) {

                            return '<label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FD_L2_' + data.aData.preference_number + '" value=""></label>  <label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FD_L3_' + data.aData.preference_number + '" value=""></label>  <label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FD_L4_' + data.aData.preference_number +'" value=""></label>';
                        }
                    },
                    {

                        "sTitle": "<span><label style='width :118px;'>Faculty Technology </label> <br><label style='width :30px;'>L2 </label> <label style='Width : 30px;'>L3 </label> <label style='width:30px;'>L4</label></span>", "mData": null, "bSortable": false, fnRender: function (data) {

                            return '<label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FT_L2_' + data.aData.preference_number + '" value=""></label>  <label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FT_L3_' + data.aData.preference_number + '" value=""></label>  <label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class="' + data.aData.preference_number + '" id="FT_L4_' + data.aData.preference_number +'" value=""></label>';
                        }
                    },
                    {

                        "sTitle": "<span><label style='width :127px;'>Faculty Management </label> <br><label style='width :30px;'>L4 </label> </span>", "mData": null, "bSortable": false, fnRender: function (data) {

                            return '<label class="checkbox-inline" style="width: 30px;"><input type="checkbox" class ="' + data.aData.preference_number + '" id="FM_L4_' + data.aData.preference_number +'" value=""></label> ';
                        }
                    },
                    {

                        "sTitle": "All Checkbox Check/Uncheck ", "mData": null, "bSortable": false, fnRender: function (data) {

                            return '<input type="checkbox" class="rowwisecheck" id ="' + data.aData.preference_number + '" value=""></label> ';
                        }
                    }
                ]
            });  
            for (var i = 0; i < $('#example tbody tr').length; i++)
            {
                var temp_tr = $('#example tbody tr:nth-child(' + (i + 1) + ')');
                temp_tr.find('.cls_drp_type').val(temp_tr.find('.cls_hdn_drp_type').val());
            }
            //changes 
            var data_value = JSON.parse(data);
            for (var k = 0; k < data_value.length; k++)
            {
                $('.' + data_value[k]['preference_number']).attr('disabled', (data_value[k]['status'] == "D") ? true : false);
                $('#' + data_value[k]['preference_number']).attr('disabled', (data_value[k]['status'] == "D") ? true : false);
                var get_value = '';
                for (var q = 1; q <= 5; q++)
                {
                    if (q == 1)
                    {
                        get_value = JSON.parse(data_value[k]["FA"]);
                    }
                    else if (q == 2) {
                        get_value = JSON.parse(data_value[k]["FP"]);
                    }
                    else if (q == 3) {
                        get_value = JSON.parse(data_value[k]["FD"]);
                    }
                    else if (q == 4) {
                        get_value = JSON.parse(data_value[k]["FT"]);
                    }
                    else if (q == 5) {
                        get_value = JSON.parse(data_value[k]["FM"]);
                    }
                    for (var p = 0; p < get_value.length; p++)
                    {
                        var key_value = get_value[p]['key'];
                        var key_value_status = get_value[p]['value'].toString().toLowerCase();
                        var status = key_value_status;
                        if (status == 'false') {
                            $('#' + key_value + '_' + (k + 1)).attr('checked', false);
                        }
                        else if (status == 'true') {
                            $('#' + key_value + '_' + (k + 1)).attr('checked', true);
                        }
                        
                    }
                }
                
                //var get_L2_value = $.grep(data_value[k]['FA'], function (e) { return e.key == 'FA_L2'; });
            }

            $('#DataList').css('display', 'block');
            $("#example tbody tr").each(function (i)
            {
                $('.cls_hide').css('display', 'none');
                $('#example tbody tr')[i].children[0].style.display = 'none';
            });
        }

        var json_submit_data = '';
        function submit_preference() {
            $("#example tbody tr").each(function (i) {

                var value_FA = [];
                var value_FD = [];
                var value_FT = [];
                var value_FP = [];
                var value_FM = [];
                debugger;
                data_set.semester_type = $('#drpsemester').val();
                data_set.year_semester = $('#drpyear').val();
                data_set.status = $(this).children().eq(2)[0].children[0].value;
                data_set.doc_no = $(this).children().eq(0).html();
                data_set.preference = $(this).children().eq(1).html();
                value_FA.push({ "key": "FA_L2", "value": $('#FA_L2_'+(i+1)).prop('checked') },);
                value_FA.push({ "key": "FA_L3", "value": $('#FA_L3_' + (i + 1)).prop('checked') },);
                value_FA.push({ "key": "FA_L4", "value": $('#FA_L4_' + (i + 1)).prop('checked') });
                data_set.value_FA = JSON.stringify(value_FA);
                

                value_FD.push({ "key": "FD_L2", "value": $('#FD_L2_' + (i + 1)).prop('checked') },);
                value_FD.push({ "key": "FD_L3", "value": $('#FD_L3_' + (i + 1)).prop('checked') },);
                value_FD.push({ "key": "FD_L4", "value": $('#FD_L4_' + (i + 1)).prop('checked') });

                data_set.value_FD = JSON.stringify(value_FD);;

                value_FT.push({ "key": "FT_L2", "value": $('#FT_L2_' + (i + 1)).prop('checked') },);
                value_FT.push({ "key": "FT_L3", "value": $('#FT_L3_' + (i + 1)).prop('checked') },);
                value_FT.push({ "key": "FT_L4", "value": $('#FT_L4_' + (i + 1)).prop('checked') });
                data_set.value_FT = JSON.stringify(value_FT);
                


                value_FP.push({ "key": "FP_L2", "value": $('#FP_L2_' + (i + 1)).prop('checked') },);
                value_FP.push({ "key": "FP_L3", "value": $('#FP_L3_' + (i + 1)).prop('checked') },);
                value_FP.push({ "key": "FP_L4", "value": $('#FP_L4_' + (i + 1)).prop('checked') });
                data_set.value_FP = JSON.stringify(value_FP);
                

                value_FM.push({ "key": "FM_L4", "value": $('#FM_L4_' + (i + 1)).prop('checked') },);

                data_set.value_FM = JSON.stringify(value_FM);
                
                
                tempData.push(data_set);
                json_submit_data = JSON.stringify(tempData);

                if (json_submit_data.search(/\\/) != -1) { json_submit_data = json_submit_data.replace(/\\/g, '\\\\'); }
                if (json_submit_data.search("\"") != -1) { json_submit_data = json_submit_data.replace(/"/g, '\\\"'); }

                data_set = { 'doc_no': '', 'preference': '', 'status': '', 'semester_type': null, 'year_semester': null, 'value_FA': value_FA, 'value_FD': value_FD, 'value_FT': value_FT, 'value_FP': value_FP, 'value_FM': value_FM };

            });

            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/save_all_preference_value",
            
                    //data: "{preference_Data:'" + JSON.stringify(tempData) + "'}",
                    data: "{preference_Data:'" + json_submit_data + "'}",
                    dataType: "json",
                    success: function (data) {
                        tempData = [];
                        if (data.d != "" && data.d != "[]") {
                            if (data.d == 'Data Saved Successfully') {
                                get_details_data();
                                bootbox.alert("Data Saved Successfully");
            
                            }
                            else {
                                bootbox.alert(data.d);
                            }
                        }
                        //course_wise_exam();
                    },
                    error: function (result) {
                        tempData = [];
                        bootbox.alert(result);
                    }
                });

        }

        function change_value(e) {
            
            for (var i = 0; i < $('#example tbody tr').length; i++)
            {
                var seat_type = $('#example tbody tr:nth-child(' + (i + 1) + ')').find('.cls_drp_type').val();
                
            }
        }

        $(".rowwisecheck").live('click', function () {
            if ($('#' + this.id).is(':checked')) {
                $('.' + this.id).attr('checked', true);
            } else { $('.' + this.id).attr('checked', false); }
            
        });

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <div class="row-fluid">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>Semester Wise Vertical Studio Preferences
            </h1>
        </div>
    </div>
    <div class="well" style="background-color: White;">
        <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Filter Criteria</strong>
            </div>
            <div>
                <div>
                    <div>
                        <table border="0" cellpadding="10" cellspacing="5">
                            <tr>
                                <td>Semester :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpsemester">
                                    </select>
                                </td>
                                <td>Year :
                                </td>
                                <td>
                                    <select class="chosen-select" id="drpyear">
                                    </select>
                                </td>
                                     <td>
                                    <button class="btn btn-primary" id="btnreterive">
                                        Retrieve
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div id="div_preference_list" class="panel panel-default" style="display: none;">
            <div class="panel-heading">
                <strong>Vertical Studio Preferences</strong>
            </div>
            <div>
                <div id="DataList" style="display: none;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                        width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div>
                <table style="width: 62%; margin-left: 15%;">
                    <tr>
                        <td align="center">
                            <button id="btn_submit" type="button" class="btn btn-lg btn-primary" onclick="submit_preference()">Submit</button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>


    </div>
</asp:Content>

