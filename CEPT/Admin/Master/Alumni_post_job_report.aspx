<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Alumni_post_job_report.aspx.cs" Inherits="Admin_Master_Alumni_post_job_report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div id="DataList" class="panel panel-default">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Alumni job post data</span></strong>
            </div>

            <div id="studiocourse" class="tab-pane" style="overflow: auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover"
                    width="100%">
                    <thead>
                    </thead>

                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>

        <table style="width: 100%; margin-top: 10px;">
            <tr>
                <td align="center" style="padding-left: 75px;">
                    <button id="btnsave" type="button" style="display: none" class="btn btn-lg btn-primary">
                        <i class="icon-save bigger-160"></i>Save
                    </button>
                </td>
            </tr>
        </table>
    </div>

    <script type="text/javascript">
        var oTable1;
        var student_data = '';
        var course_instructor_data = '';
        var student_saved_data = '';
        var course_saved_data = '';
        var instructor_group_saved_data = '';

        $(document).ready(function () {

            Gettbaledata();
        });
        function Gettbaledata(){
        
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/get_alumni_job_reportdata",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    //   display_data(data.d);
                    debugger;

                    if (data.d != "") {

                        display_data(data.d);
                    }
                    else {
                        bootbox.alert("No data found for verification");
                    }
                },
                error: function (result) {
                    alert(result);
                }
            });
        }
        $('#btnsave').on('click', function () {

            var datalist = [];

            $("#example tbody tr").each(function (i) {


                if ($(this).find(".chk_verify").is(':checked')) {
                    debugger;
                    var aPos = oTable1.fnGetPosition(this);
                    var a = oTable1.fnGetData(aPos);
                    var ob = {};

                    ob["user_id"] = $(this).find(".cls_user_id").val();
                    ob["user_name"] = $(this).children().eq(2).html();
                    ob["email"] = $(this).children().eq(3).html();
                    ob["dob"] = $(this).children().eq(6).html();
                    ob["year_of_enrollement"] = a["year_code"];
                    ob["prog_level_code"] = a["prog_level_code"];

                    datalist.push(ob);
                }

            });


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_alumni_verify_user",
                async: false,
                data: "{}",
                dataType: "json",
                success: function (data) {
                    //   display_data(data.d);
                    debugger;

                    if (data.d != null) {

                        display_data(data.d)
                    }


                },
                error: function (result) {
                    alert(result);
                }
            });

        });

      


        function display_data(data) {
            if (oTable1 != null) {
                oTable1.fnDestroy();
                $("#DataList").html('<div class="panel-heading"><strong><span class="panel-headingfont">Select Student Group</span></strong></div> <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable1 = $("#example").dataTable({

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
                    //"copy",
				"print",
            	{
            	    "sExtends": "collection",
            	    "sButtonText": 'Export',
            	    "aButtons": ["xls"]
            	}
                    ]
                },
                "aaData": JSON.parse(data),
                "aoColumns": [
                    {
                        "sTitle": "Select", "bSortable": false, "mData": null, fnRender: function (oObj) {
                            return '<center><button type="button" onclick="rowClick(' + oObj.aData.Doc_no + ')">Edit</button></center>';
                        }
                    },
                    { "sTitle": "Job Title", "mData": "job_title", "bSortable": false },
                    { "sTitle": "State", "mData": "state", "bSortable": false },
                    { "sTitle": "City ", "mData": "city", "bSortable": false },
                    { "sTitle": "Professional Area", "mData": "professional_area", "bSortable": false },
                    { "sTitle": "Due Date", "mData": "due_date", "bSortable": false },
                    { "sTitle": "Experience ", "mData": "experience", "bSortable": false },
                    { "sTitle": "Salary", "mData": "salary", "bSortable": false },
                    { "sTitle": "Organization ", "mData": "experience", "bSortable": false },
                    { "sTitle": "Description", "mData": "salary", "bSortable": false },
                    { "sTitle": "Organization Website", "mData": "organization_website", "bSortable": false },
                    {
                        "sTitle": "Select", "bSortable": false, "mData": null, fnRender: function (oObj) {
                            return '<center><button type="button" onclick="viewjob(' + oObj.aData.Doc_no + ')">View</button></center>';
                        }
                    },
                     {
                         "sTitle": "Action", "bSortable": false, "mData": null, fnRender: function (oObj) {
                             if (oObj.aData.cancel_flag == "Y") {

                                 return '<center><button type="button" onclick="ActiveDeactive(' + oObj.aData.Doc_no + ',\'' + oObj.aData.cancel_flag + '\')">Active</button></center>';
                             } else {

                                 return '<center><button type="button" onclick="ActiveDeactive(' + oObj.aData.Doc_no + ',\'' + oObj.aData.cancel_flag + '\')">DeActive</button></center>';
                             }
                             }
                     }


                ]
            });
            $('#btnsave').css('display', 'none');
        }

        function rowClick(raw) {
            window.location.href = "Alumni_post_job.aspx?doc_no=" + raw;
        }
        function viewjob(data) {
            window.location.href = "Alumni_view_job.aspx?doc_no=" + data;
        }
        function ActiveDeactive(doc, flag) {
            var obj =  {};
            obj.Doc_no = doc;
            obj.flag = flag;

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "../../WebService.asmx/save_alumni_post_job_deactive",
                async: false,
                data: "{str_req_data:'" + JSON.stringify(obj) + "'}",
                dataType: "json",
                success: function (data) {
                    //   display_data(data.d);
                    debugger;

                    if (data.d != null) {
                        if(data.d["status"]=="False")
                        {
                            alert(data.d["message"]);
                        }else{

                            location.reload();
                        
                        }
                    }


                },
                error: function (result) {
                    alert(result);
                }
            });

        }
    </script>
</asp:Content>

