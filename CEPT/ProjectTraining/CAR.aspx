<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageProject.master" AutoEventWireup="true"
    CodeFile="CAR.aspx.cs" Inherits="ProjectTraining_ProjectTraining" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../DesignJS/jquery.validate.min.js" type="text/javascript"></script>
    <link href="../DesignCss/Validation.css" rel="stylesheet" type="text/css" />
    <script src="../DesignJS/AjaxFileupload.js" type="text/javascript"></script>

     <script src="../Js/js2/xlsx.core.min.js" type="text/javascript"></script>
    <script src="../Js/js2/Blob.js" type="text/javascript"></script>
    <script src="../Js/js2/FileSaver.js" type="text/javascript"></script>
    <script src="../Js/js2/tableexport.min.js" type="text/javascript"></script>

      <style>
        tfoot
        {
            display: table-header-group;
        }
         .btn_rad {
            border-radius: 6px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="well" style="background-color: White;">
        <div class="panel panel-default ">
            <div class="panel-heading">
                <strong><span class="panel-headingfont">Current Activitie Report</span></strong>
            </div>
            <div style="padding: 15px; margin-right: 14px;" id="div3">
                <div class="row">
                    <div style="" class="form-group col-md-12">
                        <table id="tbl_car" class="table">
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <center><input type="button" style="margin-right: 10px; display:none" class="btn-small center" id="save" value="save" /></center>
        <%--<input type="button" id="get_car_report"  value="Feedback Status Report" data-toggle="modal" data-target="#car_report"/>--%>

    </div>
     <%-- <div class="modal fade planned1" id="car_report" role="dialog" style="margin-left: -47%!important; width: 95%!important; display: none">
        <div class="modal-dialog">--%>

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <%--<button type="button" class="close" data-dismiss="modal">&times;</button>--%>
                    <h4 class="modal-title">Feedback Status Report</h4>
                </div>
                <div class="modal-body">
                 <div id="DataList" style="overflow-x: auto;">
                <table cellpadding="0" cellspacing="0" border="0" id="CAR_Report" class="display table table-striped table-bordered table-hover">
                    <thead>
                         
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
                </div>

                <div class="copyright" style="box-shadow: 5px 0 6px 1px black;"></div>

              
            </div>

       <%-- </div>

    </div>--%>
        <style>

        .borderclass:focus{
    border: 1px solid red;
    box-shadow: 0px 0px 2px 0px red;
    outline: 0;
    }
    </style>
    <div style="display: none;">
        <asp:Button ID="hdn_download" runat="server" ClientIDMode="Static" OnClick="print_proposal" />
        <input type="hidden" runat="server" clientidmode="Static" id="hdn_data" />
        <input type="hidden" runat="server" clientidmode="Static" id="hdn_sem_year_data" />
        
    </div>
    <script type="text/javascript">
        var doj;
        var ped;
        var str = "";
        var selected_date = '';
        var upload_file_name = '';
        var myObject = new Object();
        var car_title;
        var project_name = '';
        var User_type = '';
        var comments='';
        var update_obj = new Object();
        var user = '';
        var obj_sem = new Object();
        var current_sem = '';
        var current_year = '';
        $(document).ready(function () {
           
            obj_sem = JSON.parse(document.getElementById("hdn_sem_year_data").value);
            current_sem = obj_sem[0]['sem_code'];
            current_year = obj_sem[0]['year_code']

           
            user = '';

              User_type = ('<%= Session["User_type"] %>');

            if (User_type == "FA")
            {
                $(".well").hide();
            }
          
            user = getQueryStringValue('user_id');
            user_name = getQueryStringValue('user_name');
            var obj = new Object();
            
           
            if (user =='') {

                var user = ('<%= Session["UserId"] %>');
                var user_name = ('<%= Session["UserName"] %>');
            }
        
            function getQueryStringValue(key) {
                return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
            }

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/get_sjr_report_date_for_admin",
                data: '{user_id: "'+user+'"}',
                dataType: 'json',
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d != "") {
                      
                        obj = JSON.parse(result.d);
                        doj = obj[0]['date_of_join'];
                        ped = obj[0]['plan_entry_deadline'];
                        project_name = obj[0]['project_name']
                        design();


                        $.ajax({
                            type: "POST",
                            url: "../WebService.asmx/get_project_car",
                            data: '{user_id: "'+user+'" }',
                            dataType: 'json',
                            contentType: "application/json",
                            async: false,
                            success: function (result) {
                                if (result.d != "") {
                                   
                                    Obj_project_final_upload = JSON.parse(result.d);

                                    for (var i = 0; i < Obj_project_final_upload.length; i++) {

                                        $("#tbl_car tbody tr").each(function () {
                                            var obj = new Object();
                                            if ($(this).find('.id1').prop('id') == undefined) {
                                            }
                                            else {
                                                var d = new Date(Obj_project_final_upload[i]['date'])

                                                if (d.toLocaleDateString() == this['id']) {

                                                    if (Obj_project_final_upload[i]['file_path'] == "") {
                                                      
                                                        $(this).closest('tr').find('.link').html('');
                                                    }
                                                    else {
                                                        $(this).closest('tr').find('.link').find('.download_link').css('display', 'none');
                                                        //   $(this).closest('tr').find('.link').find('.download_link').prop('href', ("../ProjectTraining/car/" + Obj_project_final_upload[i]['file_path']));
                                                        $(this).closest('tr').find('.link').find('.download_link').prop('text', (Obj_project_final_upload[i]['file_path']));
                                                        $(this).closest('tr').find('.car_title').css('display', 'block');
                                                        $(this).closest('tr').find('.car').css('display', 'block');
                                                        $(this).closest('tr').find('.txt_area_comments').css('display', 'block');
                                                        $(this).closest('tr').find('.save_comment').css('display', 'block');
                                                        
                                                        $(this).closest('tr').find('.car_title').val(Obj_project_final_upload[i]['car_title']);

                                                        $(this).closest('tr').find('.txt_area_comments').val(Obj_project_final_upload[i]['comments']);

                                                        $(this).closest('tr').find('.lbl_car_comments').text(Obj_project_final_upload[i]['comments']);
                                                        
                                                    }

                                                    DisplayData(result.d);
                                                }
                                                else {

                                                }


                                            }
                                        });
                                    }

                                    //if (Obj_project_final_upload[0]['file_path'] != "") {
                                    //    $('#download_link').prop('href', ("../ProjectTraining/car/" + Obj_project_final_upload[0]['file_path']));
                                    //}
                                    //else {
                                    //    $('#download_link').css('display', 'none');
                                    //}
                                }
                                else {
                                    $('#download_link').css('display', 'none');
                                }

                            },
                            error: function (error) {
                                console.log(error);
                            }
                        });

                        if (User_type == "S") {
                    
                            $("#get_car_report").remove();
                            $("#car_report").remove();
                            $(".modal-content").remove();
                            //$(".modal-content").css("display","none");
                        } else {
                           
                        }

                    }
                    else {
                        $('#loading').hide();
                      //  bootbox.alert('Please Fill Site Join Report', function () {
                      //      window.location.href = "site_joining_report(SJR).aspx";
                      //  });
                    }
                },
                error: function (error) {
                    console.log(error);
                }
            });

            t_user_id = getQueryStringValue('user_id');

            if (t_user_id !="") {
                $('.file-upload').css('display', 'none');
                $('.upload_head').css('display', 'none');
                $('.car_title').prop('readOnly', true);
            }
          
            if (User_type == "S") {
                $('#save_comment').css('display', 'none');
            }

        });
        var oTable;
        var asInitVals = new Array();
       

        function DisplayData(data) {
           
            var dataa = JSON.parse(data);
            var myArray = new Array();
            for (var i = 0; i < dataa.length; i++) {
                myObject_save = new Object();
                myObject_save.row = dataa[i]['row'];
                myObject_save.user_id = dataa[i]['user_id'];
                myObject_save.user_name = dataa[i]['user_name'];
                myObject_save.project_name = dataa[i]['project_name'];
                myObject_save.date = convert_date(dataa[i]['date']);

                myObject_save.car_title = dataa[i]['car_title'];
                myObject_save.comments = dataa[i]['comments'];
                myArray.push(myObject_save);
            }
            var catdata = JSON.stringify(myArray);
            if (oTable != null) {
                oTable.fnDestroy();

                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="CAR_Report"><thead></thead><tbody> <tfoot ></tfoot> </tbody> </table>');
            }


            oTable = $("#CAR_Report").dataTable({

                "bPaginate": false,
                "bStateSave": false,
                "sDom": 't',
                //  "sScrollY": '400px',
                "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },
                "oTableTools": {
                    "aButtons": [
                        //"xls"
                    ]
                },

                //"aaData": JSON.parse(myArray),
                "aaData": JSON.parse(catdata),
                "aoColumns": [
            { "sTitle": "Sr. No.", "mData": "row", "bSortable": false, },
            { "sTitle": "Code No.", "mData": "user_id", "bSortable": false, },
            //{ "sTitle": "email", "mData": "mail", "bSortable": false, "bVisible": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false, "sClass": 'cls_user_name' },
            { "sTitle": "Project Name", "mData": "project_name", "bSortable": false, "sClass": 'cls_user_name' },
            { "sTitle": "Submission Date", "mData": "date", "bSortable": false },
            { "sTitle": "CAR Title", "mData": "car_title", "bSortable": false },
            { "sTitle": "Comment", "mData": "comments", "bSortable": false }
            ]
            });

           $('.cls_user_name').css('text-transform', 'capitalize');
           $("tfoot input").keyup(function () {
               /* Filter on the column (the index) of this element */
               oTable.fnFilter(this.value, $("tfoot input").index(this));
           });



             /*
             * Support functions to provide a little bit of 'user friendlyness' to the textboxes in
             * the footer
             */
           $("tfoot input").each(function (i) {
               asInitVals[i] = this.value;
           });

           $("tfoot input").focus(function () {
               if (this.className == "search_init") {
                   this.className = "";
                   this.value = "";
               }
           });

           $("tfoot input").blur(function (i) {
               if (this.value == "") {
                   this.className = "search_init";
                   this.value = asInitVals[$("tfoot input").index(this)];
               }
           });
           //$.ajax({
           //    type: "POST",
           //    url: "../WebService.asmx/Get_faculty_name_project",
           //    data: '{}',
           //    dataType: 'json',
           //    contentType: "application/json",
           //    async: false,
           //    success: function (result) {

           //        if (result.d != "") {
           //            debugger;
           //            window.faculty_name = JSON.parse(result.d);
           //        }
           //    },
           //    error: function (error) {
           //        console.log(error);
           //    }
            //});
           $.ajax({
               type: "POST",
               url: "../WebService.asmx/get_instructor_detail",//5 instructor 5055 S 2018
               data: '{}',
               dataType: 'json',
               contentType: "application/json",
               async: false,
               success: function (result) {
                   if (result.d != "") {
                       window.faculty_name = JSON.parse(result.d);
                   }
                   else {

                   }
               },
               error: function (error) {
                   console.log(error);
               }
           });
           var end_year;
           var start_year;
           var batch_year;
           $.ajax({
               type: "POST",
               contentType: "application/json; charset=utf-8",
               url: "../WebService.asmx/Get_cept_current_sem_data",
               data: "{type:'Project Training'}",
               async: false,
               dataType: "json",
               success: function (data) {
             
                   obj = JSON.parse(data.d)

                   end_year = obj[0]['year_code'];
                   start_year = end_year - 1;
                   batch_year = end_year - 4;


               },
               error: function (result) {
                
                   alert(result);
               }
           });
           var str_html = '<tr style="display:none;"><th colspan="4"><b>Site Details of Project Training</b></th></tr>' +
                         '<tr style="display:none;"><th>Batch</th><th>' + batch_year + '</th><th></th><th colspan="2" align="right"><b>Year: ' + start_year + ' - ' + end_year + '</b></th></tr>' +
                         '<tr style="display:none;"><th colspan="15">' +
                         '<b>Faculty: ';

           for (var i = 0; i < window.faculty_name.length; i++) {
              
               if (i == 0) {
                   str_html += ' Prof. ' + window.faculty_name[i].instructor_name;
               } else {
                   str_html += ', Prof. ' + window.faculty_name[i].instructor_name;
               }
           }

           var final_str_html = str_html + '</b></th></tr>' +
          '<tr style="display:none;"><th>&nbsp;</th></tr>' + $('#CAR_Report thead').html();

           $('#CAR_Report thead').html(final_str_html);

           var DefaultTable = document.getElementById('CAR_Report');

           new TableExport(DefaultTable, {
               headers: true,
               footers: true,
               formats: ['xlsx'],
               filename: 'id',
               bootstrap: false,
               position: 'bottom',
               ignoreRows: null,
               ignoreCols: null,
               ignoreCSS: '.tableexport-ignore',
               emptyCSS: '.tableexport-empty',
               trimWhitespace: true
           });
           $('#CAR_Report caption').css('text-align', 'left');
           $('#CAR_Report caption button').css('position', 'absolute');
           $('#CAR_Report caption button').css('margin-top', '-34px');
           $('#CAR_Report caption button').css('margin-left', '469px');
       }
        function convert_date(tmp) {
            var dates = new Date(tmp);
            var day = dates.getDate();
            var month = dates.getMonth() + 1;
            var year = dates.getFullYear();
            return day + "/" + month + "/" + year;
        }
        $(document).on('click', ".car", function () {
          
            var raw = $(this).closest('tr').get(0);
            //  var upload_pdf_path=$(this).closest('tr').find('.link a')[0]['href']
            var upload_pdf_path = $(this).closest('tr').find('.link a')[0].text;
              car_title = $(this).closest('tr').find('.car_title')[0].value;

            var mystring = car_title;
            mystring.replace(/&/g, "'111'");



            if (car_title == "") {
               
                $(this).closest('tr').find('.car_title').css('border','1px solid red');
                $(this).closest('tr').find('.car_title').css('box-shadow','0px 0px 2px 0px red');
                $(this).closest('tr').find('.car_title').css('outline', '0');

                alert("Please Enter Current Activity Report Title");
            
                return false;
            }

            $(this).closest('tr').find('.car_title').css('border', '');
            $(this).closest('tr').find('.car_title').css('box-shadow', '');
            $(this).closest('tr').find('.car_title').css('outline', '');



            car_title = JSON.stringify({ car_title: "" + car_title + "" });


            user = getQueryStringValue('user_id');

            if (user == '') {
                user = ('<%= Session["UserId"] %>');
            
            }
            if (getQueryStringValue('user_name') != "") {
                user_name = getQueryStringValue('user_name');
            }
            else {
                user_name = "";
            }
         
        

            var ob = { 'user_id': user, 'user_name': user_name, 'project_name': project_name, 'car_title': car_title, 'page_number': raw.firstChild.innerText, 'upload_pdf_path': upload_pdf_path };

         
            $('#hdn_data').val(JSON.stringify(ob));

            $('#hdn_download').click();
            
            // print_proposal();
        });

        function design() {
           
            var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var counter = 1;
           
            var join_date = doj;//doj-ped
            var sr_no = 0;
            if (join_date != "") {
                var now = new Date(join_date);
                var str = "";
                str += "<tr>       <td class='text-align'><strong>Sr.No</strong></td>  <td class='text-align'><strong>Submission Date</strong></td>  <td class='text-align'><strong class='upload_head'>Upload</strong></td> <td><strong></strong></td> <td><strong>CAR Title</strong></td>  <td><strong>CAR</strong></td> <td><strong>Comments</strong></td> <td id='save_comment'><strong>Save Comments</strong></td></tr>";
                var totaldays = 112;//126
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
                for (var i = 0; i < 119; i++) {//143
                    var now = new Date(join_date);
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
                    //temp_ctn++;
                    //if (day == "Sat") {
                        //counter = counter + 1;

                        //if (counter <= 18 && i < 118) {//21 142
                    if (i == 28 || i == 49 || i == 70 || i == 91 || i == 112) {
                            //if (counter % 3 == 0) {//3
                            
                               // if (counter == 3) {//3

                                    //if (temp_ctn > 14) {//21

                                        //str += "<tr id=" + (now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear() + " class='wk'><td>" + t + "</td> <td class='id1' >" + monthNames[now.getMonth()] + ' ' + now.getDate() + "</td>"
                                        //    + "<td><label class='btn btn-primary file-upload ' style='vertical-align: bottom;'><span><strong>Upload Files</strong></span><input type='file' name='file_upload' id='file_upload" + t + "' onchange='javascript:return UploadProfilePhoto(this);'style='display: none;'></label>"
                                        //     + "<div  > <input type='file'  class='upload_result_disp' name='file_upload'  onchange='javascript:return UploadProfilePhoto(this);' style='display: none;'></div></label>"
                                        //    + "<span class='up'  id='file_upload" + (now.getMonth() + 1) + "_" + now.getDate() + "_" + now.getFullYear() + "' ><strong class='upload_result'></strong><span></span>"
                                        //    + "</td><td class='link'>   <span id='upload_span'><strong id='upload_result'></strong></span><a style='display:none' class='download_link' class='fancybox radio_hide' download='' rel='group'href=''>Download</a></td>   <td></td>     <td><button class='car' type='button OnClick='print_Proposal''>Car</button></td></tr>"
                                    //}

                              //  } else {
                                    t = sr_no = sr_no + 1;
                                    str +=  " <tr id=" + (now.getMonth() + 1) + "/" + now.getDate() + "/" + now.getFullYear() + " class='wk'><td>" + t + "</td> <td class='id1' >" + monthNames[now.getMonth()] + ' ' + now.getDate() + "</td>"
                                            + "<td><label class='btn btn-primary file-upload ' style='vertical-align: bottom;'><span><strong>Upload Files</strong></span><input type='file' name='file_upload' id='file_upload" + t + "' onchange='javascript:return UploadProfilePhoto(this);'style='display: none;'></label>"
                                            + "<div > <input type='file' class='upload_result_disp' name='file_upload' onchange='javascript:return UploadProfilePhoto(this);' style='display: none;'></div></label>"
                                            + "<span class='up'  id='file_upload" + (now.getMonth() + 1) + "_" + now.getDate() + "_" + now.getFullYear() + "' ><strong class='upload_result'></strong><span></span>"
                                          + " </td><td class='link'>   <span id='upload_span'><strong id='upload_result'></strong></span><a style='display:none'  class='download_link' class='fancybox radio_hide' download='' rel='group'href=''>Download</a></td>  <td><input type='text' class='car_title'  ></td>      <td><button  style='display:none' class='car' type='button' >Car Download</button></td>"
                                  
                                    if (User_type == "S") {
                                        str += " <td> <lable class='lbl_car_comments'></lable> </td> </tr> "
                                    }
                                    else {
                                        str += " <td>  <textarea class='txt_area_comments'    style='width:96%; display:none' ></textarea></td>   "
                                        str += " <td><input type='button' class='save_comment' style='display:none' value='Save Comment'></td>   </tr>"
                                    }
                               // }
                            //}
                        }
                    //}
                    //else {
                    //}
                }

            } else {
                bootbox.alert('Please Fill Site Join Report', function () {
                    window.location.href = "site_joining_report(SJR).aspx";
                });
            }
            $('#tbl_car').append(str);
        }

        function UploadProfilePhoto(event) {

         
            car_title = $(event).closest('tr').find('td').find('.car_title').val();

            if (car_title == "") {
                alert("please enter CAR Title");
                //   alert("Exception : " + e.message);
                $('#' + $(event)[0]['id']).val('');
                return false;
            }
            else {
                var id = $(event)[0]['id'];
              
                selected_date = '';
                upload_file_name = '';


                try {

                    var fileToUpload = GetFileNameFromPath($('#' + $(event)[0]['id']).val());
                    var filename = fileToUpload.substr(0, (fileToUpload.lastIndexOf('.')));
                    selected_date = $(event).closest('tr')[0]['id'];
                    var upload_result = $(event).closest('tr').find('.up')[0]['id'];


                    if (CheckUserPhotoExtension(fileToUpload)) {
                        var flag = true;
                        if (filename != "" && filename != null) {
                            if (flag == true) {
                                $("#UploadingProgress").fadeIn(200);
                                $.ajaxFileUpload({
                                    url: '../Handler/project_car.ashx?selected_date=' + selected_date,
                                    secureuri: false,
                                    fileElementId: id,
                                    dataType: 'json',
                                    success: function (data, status) {
                                        if (typeof (data.error) != 'undefined') {
                                            if (data.error != '') {
                                                alert(data.error);
                                            }
                                            else {
                                                $('#file_upload').val("");

                                                FileName = data.upfile;
                                                upload_file_name = FileName;

                                            }
                                        }
                                        $("#UploadingProgress").fadeOut(200);


                                        $('#' + upload_result).text('file upload successfully.');
                                        $('#save').click();
                                    },
                                    error: function (data, status, e) {
                                        $("#UploadingProgress").fadeOut(200);
                                        alert(e);
                                    }
                                });
                            }
                        }
                    }
                    else {
                        alert('Invalid File Type. Please upload PDF file');
                    }
                    return false;
                }
                catch (e) {
                    alert("Exception : " + e.message);
                }
            }
        }

        function GetFileNameFromPath(strFilepath) {

            var objRE = new RegExp(/([^\/\\]+)$/);
            var strName = objRE.exec(strFilepath);

            if (strName == null) {
                return null;
            }
            else {
                return strName[0];
            }
        }

        function CheckUserPhotoExtension(file) {
            try {
                var flag = true;
                var extension = file.substr((file.lastIndexOf('.') + 1));

                switch (extension) {
                    case 'pdf':
                    case 'PDF':

                        flag = true;
                        break;
                    default:
                        flag = false;
                }

                return flag;
            }
            catch (e) {
                alert("Exception : " + e.message);
            }
        }
  

        $('#save').on('click', function () {
            var result = $('#aspnetForm').valid();
            if (result == true) {

                if (upload_file_name != undefined) {
                    myObject.file_path = upload_file_name;
                    myObject.date = selected_date;
                    myObject.car_title = car_title;

                }
                else {
                    myObject.file_path = "";
                }

                data = JSON.stringify({ "data": myObject });
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/project_car_upload",
                    data: data,
                    dataType: 'json',
                    contentType: "application/json",
                    success: function (result) {
                        bootbox.alert(result.d, function () {
                            window.location.reload();
                        });
                    },
                    error: function (error) {
                        console.log(error);
                    }

                });
            }
        });

        function getQueryStringValue(key) {
            return unescape(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + escape(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
        }


        $(Document).on('click', '.save_comment', function () {
           
            var temp = this.closest('tr');
            var date = this.closest('tr').id;
            comments = temp.children[6].childNodes[1].value;
            update_obj.date = date;
            update_obj.comments = comments;
            
            update_obj.sem_code = current_sem;
            update_obj.year_code = current_year;

            user = getQueryStringValue('user_id');
        

             
            if (user == '') {
                  user = ('<%= Session["UserId"] %>');
            }
            update_obj.user_id = user;

            data = JSON.stringify({ "data": update_obj });
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/project_update_car_upload_comment",
                data: data,
                dataType: 'json',
                contentType: "application/json",
                success: function (result) {
                    bootbox.alert(result.d, function () {
                        window.location.reload();
                    });
                },
                error: function (error) {
                    console.log(error);
                }

            });


        });
        
    </script>
    <style>
        /*.sorting_disabled {
        width:15% !important
        }
        .search_init {
        width:211px !important
        }*/
    </style>
</asp:Content>
