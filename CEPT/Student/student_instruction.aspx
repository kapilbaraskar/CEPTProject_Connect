<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPageDesign.master" AutoEventWireup="true" CodeFile="student_instruction.aspx.cs" Inherits="Student_student_instruction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="../../Js/csvfilejs/dataTables.min.js"></script>
    <script src="../../Js/csvfilejs/printcsv.js"></script>
    <script src="../../Js/csvfilejs/buttons.html5.min.js"></script>
    <script src="../../Js/csvfilejs/buttons.print.min.js"></script>

    <link href="../../Style/csvstyle.css" rel="stylesheet" />
    <style>

        
    </style>
    <script type="text/javascript">
        var oTable;
        var CheckStatusRequest = false;
        $(document).ready(function () {
            CheckCreditRequestBased();
            get_credits_dtl();

            $('.nextclick').on('click', function ()
            {
                if ($('#hdnswsStartDatestatus').val() == "True")
                {
                    var status_prog = true;
                    if ($('#hdnswssemcode').val().toUpperCase() == "W")
                    {
                        if (parseInt($('#totalcredits').html()) < parseInt("170") && $('#hdnuserprog').val() == "1") {
                            status_prog = false;
                        }
                        else if (parseInt($('#totalcredits').html()) < parseInt("50") && $('#hdnuserprog').val() == "2") {
                            status_prog = false;
                        }
                    }
                    else if ($('#hdnswssemcode').val().toUpperCase() == "S")
                    {
                        if (parseInt($('#totalcredits').html()) < parseInt("190") && $('#hdnuserprog').val() == "1") {
                            status_prog = false;
                        }
                        else if (parseInt($('#totalcredits').html()) < parseInt("70") && $('#hdnuserprog').val() == "2") {
                            status_prog = false;
                        }
                    }
                    if (CheckStatusRequest == true) {

                    }
                    else if (!status_prog) {
                        alert("You are not eligible. Please contact SWS office.");
                        return false;
                    }
                    //else { $('.button_div').css('display', ''); }
                }
                else
                {
                    //$('.button_div').css('display', 'block');
                }
                var origin = window.location.origin;
                window.location.replace(origin + "/Student/" + "sws_credit_choice.aspx");
                return false;

            });
            
        });

        function CheckCreditRequestBased() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/SWS_allow_registration_for_particular_student_FirstDay",
                    //url: "../../WebService.asmx/TestingPurpose",
                    data: "",
                    //data: "{}",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "")
                        {
                            CheckStatusRequest = true;
                        }
                        else
                        {
                            CheckStatusRequest = false;
                        }
                    },
                    error: function (result) {
                        alert(result);
                    }
                });

        }

        function get_credits_dtl() {
            $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "../../WebService.asmx/get_students_completed_credits_sgpa_cgpa_report_data",
                    data: "{enrollment_year : '',dept_code:'',prog_code:''}",
                    //data: "{}",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        if (data.d != "")
                        {
                           
                            display_get_vf_personal_detail(data.d);
                            var add = 0;
                            $("#example tbody tr").each(function (i) {
                                
                                var add_credits = $(this).children().eq(3).html();
                                if (add_credits == "") {
                                    add = parseInt(add) + parseInt("0");
                                }
                                else { add = parseInt(add) + parseInt(add_credits);}
                                
                                $('#totalcredits').html(add);

                            });
                            if ($('#hdnswsStartDatestatus').val() == "True") {
                                var status_prog = true;
                                if ($('#hdnswssemcode').val().toUpperCase() == "W") {
                                    if (parseInt($('#totalcredits').html()) < parseInt("170") && $('#hdnuserprog').val() == "1") {
                                        status_prog = false;
                                    }
                                    else if (parseInt($('#totalcredits').html()) < parseInt("50") && $('#hdnuserprog').val() == "2") {
                                        status_prog = false;
                                    }
                                }
                                else if ($('#hdnswssemcode').val().toUpperCase() == "S") {
                                    if (parseInt($('#totalcredits').html()) < parseInt("190") && $('#hdnuserprog').val() == "1") {
                                        status_prog = false;
                                    }
                                    else if (parseInt($('#totalcredits').html()) < parseInt("70") && $('#hdnuserprog').val() == "2") {
                                        status_prog = false;
                                    }
                                }
                                if (CheckStatusRequest == true)
                                {
                                    $('.button_div').css('display', 'block');
                                }
                                else if (!status_prog)
                                {
                                    alert("You are not eligible. Please contact SWS office.");
                                    return false;
                                }
                                else { $('.button_div').css('display', 'block');}
                            }
                            else { $('.button_div').css('display', 'block');}

                            //var t = $('#example').DataTable();
                            //var counter = 0;

                            //t.row.add([
                            //    counter + '.0',
                            //    counter + '.1',
                            //    counter + '.2',
                            //    counter + '.3',
                            //    counter + '.4'
                            //]).draw(false);

                            //var giCount = 1;
                            //$('#example').dataTable().fnAddData([
                            //    giCount + ""
                            //    ]);

                            //giCount++;


                        }
                        else
                        {
                            $('#btnnext').css('display', 'none');
                            
                        }
                    },
                    error: function (result)
                    {
                        $('#btnnext').css('display', 'none');
                        alert("You are not eligible for the first day.");
                    }
                });

        }

        function set_table_columns(row) {
            var columns = [];

            //columns.push({
            //    "sTitle": "Student Code", "mData": "user_id", "mRender": function (data) {
            //        return data;
            //    }
            //});
            //columns.push({ "sTitle": "Student Name", "mData": "user_name" });
            //columns.push({ "sTitle": "Faculty", "mData": "dept_name" });
            //columns.push({ "sTitle": "Program Name", "mData": "prog_name" });
            //columns.push({ "sTitle": "Program Level", "mData": "prog_level_name" });
            //columns.push({
            //    "sTitle": "Year of Enrollment", "mData": "year_code_actual", "mRender": function (data) {
            //        if (data == 'Y1') return 'Y2013';
            //        else return data;
            //    }
            //});

            columns.push({
                "sTitle": "Semester", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.semester_type != '') return data.semester_type ;
                    else return '';
                }
            });

            columns.push({
                "sTitle": "Semester Year", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.year_semester != '') return data.year_semester;
                    else return '';
                }
            });

            columns.push({
                "sTitle": "Total Credits Registered", "mData": null, "mRender": function (data) {// (Actual)
                    if (data.semester_wise_total_credit != '') {
                        return data.semester_wise_total_credit;
                    }
                    else {
                        return '';
                    }
                }
            });
            columns.push({ "sTitle": "Credits Completed", "mData": "credits_completed" });

            //columns.push({
            //    "sTitle": "Earn GPA Credits", "mData": null, "mRender": function (data) {// (Actual)
            //        if (data.earn_gpa_credit != '') {
            //            return data.earn_gpa_credit;
            //        }
            //        else {
            //            return '';
            //        }
            //    }
            //});
            //columns.push({
            //    "sTitle": "Earn NGPA Credits", "mData": null, "mRender": function (data) {// (Actual)
            //        if (data.earn_ngpa_credit != '') {
            //            return data.earn_ngpa_credit;
            //        }
            //        else {
            //            return '';
            //        }
            //    }
            //});


            //columns.push({
            //    "sTitle": "Semester", "mData": null, "mRender": function (data) {// (Actual)
            //        if (data.semester_type != '' && data.year_semester != '') return data.semester_type + " " + data.year_semester;
            //        else return '';
            //    }
            //});
            columns.push({
                "sTitle": "Semester GPA", "mData": "sem_grade_point_ratio_actual", "mRender": function (data) {// (Actual)
                    if (data != '')
                        return round_num(round_num(data, 2), 1);//parseFloat(data).toFixed(2);
                    else return '';
                }//Total_CGPA
            });
            //columns.push({
            //    "sTitle": "Total CGPA", "mData": null, "mRender": function (data) {// (Actual)
            //        if (data.Total_CGPA != '') {
            //            var calculate_CGPA = parseFloat(data.gpa_multiplication_sem / data.total_gpa_credit_sem).toFixed(1);
            //            return calculate_CGPA;
            //        }
            //        else {
            //            return '';
            //        }
            //        //nitinbhai changes 03112022
            //        //return round_num(round_num(data.Total_CGPA, 2), 1);//parseFloat(data).toFixed(2);
            //        //else return '';
            //    }//Total_CGPA
            //});
            //columns.push({
            //    "sTitle": "Semester Aggregate", "mData": "sem_aggregate_percentage_actual", "mRender": function (data) {// (Aggregate)
            //        if (data != '') return parseFloat(data).toFixed(2);
            //        else return '';
            //    }
            //});
            //columns.push({ "sTitle": "Semester GPA (Static)", "mData": "sem_grade_point_ratio", "mRender": function (data) {
            //    if (data != '') return parseFloat(data).toFixed(2);
            //    else return '';
            //}
            //});
            //            columns.push({ "sTitle": "Credits Completed", "mData": "credits_completed" });
            //            columns.push({ "sTitle": "Mandatory Credits Completed", "mData": "mandatory_credits_completed" });
            //            columns.push({ "sTitle": "Elective Credits Completed", "mData": "elective_credits_completed" });

            return columns;
        }
        function round_num(num, precision) {
            return (+(Math.round(+(num + 'e' + precision)) + 'e' + -precision)).toFixed(precision);
        }

        function display_get_vf_personal_detail(data) {

            var columns = set_table_columns(JSON.parse(data)[0]);

            if (oTable != null) {
                oTable.fnDestroy();
                $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example" width="100%"><thead></thead><tbody> </tbody></table>');
            }

            oTable = $("#example").dataTable({

                "bPaginate": true,
                "bSortable": false,
                "bSort": false,
                //"bStateSave": true,
                "iDisplayLength": 60,
                //"sDom": 't',
                //"sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                "sDom": "<'row-fluid'<'span6'B><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
                //"sScrollY": '400px',
                "oLanguage": {
                    "sSearch": "Search all columns with Space:"
                },

                //"sDom": 'T<"clear">lfrtip',
                //"oTableTools": {
                //    "aButtons": [
                //    //"copy",
                //        "print",
                //        {
                //            "sExtends": "collection",
                //            "sButtonText": 'Export',
                //            "aButtons": ["xls"]
                //        }
                //    ]
                //},

                "aaData": JSON.parse(data),
                "fnFooterCallback": function (nRow, aaData, iStart, iEnd,
                    aiDisplay) {
                    var TotalCreditsRegistered = 0;
                    var CreditsCompleted = 0;

                    if (aaData.length > 0) {
                        for (var i = 0; i < aaData.length; i++)
                        {
                            TotalCreditsRegistered += parseFloat(aaData[i].semester_wise_total_credit);
                            CreditsCompleted += parseFloat(aaData[i].credits_completed);

                        }
                    }
                    /*
                    * render the total row in table footer
                    */
                    var nCells = $('#example tfoot tr th');

                    //            var nCells = nRow.getElementsByTagName("th");
                    nCells[2].innerHTML = TotalCreditsRegistered;
                    nCells[3].innerHTML = CreditsCompleted;


                },


                "aoColumns": columns,
                
               
            });


            $('#DataList').css('display', 'block');
           // $('.dt-button.buttons-csv.buttons-html5')[0].innerText = 'Excel';
        }

        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <div class="well" style="background-color: White;">
          <div class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>General Instruction</strong>
            </div>
             <div style="padding-left: 10px;"><b style="color:blue"><br />SW Elective Course Registration Instructions :</b><b><a href='https://connect.cept.ac.in/ExcelFormatFiles/Guidelines_W_2023.pdf' target="_blank" style=" font-color:red "> Click for More Details</a> </b></br> </br> 
			<b>Registration</b>
			<p>1. The window for submitting preferences will be between <b> 10.00 AM to 5.00 PM each day during the registration period.</b></p> 
			<p>2. Preferences will be recorded in the system with timestamps when submitting the same.</p>
			<p>3. Set Course Preferences (you have to give total <b> Minimum 3 and max 8preferences </b>for each course-credit combination)</p>
			<p>4. After submission of preferences,<b> students must complete their registration by confirming their payment on the same day </b> that they give their preferences. And The payment window will be open <b>each day from 10.00 AM to 8.00 PM.</b></p>
            <b>ALLOCATION CYCLE</b>
			<p>5.<b>Every day after 8.00 PM</b>, the system will reconcile the registrations and allocate the courses registered for during the day on a first come first serve basis, as per the recorded time stamps.
			<p>6.Students will be able to see their provisionally allocated courses immediately thereafter, or at the latest by the next day morning.</p>
			<p>7.All cases where preferences were submitted but the commensurate <b>payment was not made on the same day during the payment window would be deemed void and cleared from the system.  Such students must start their registration afresh the next day.</b> </p>
			<!--<b>Drop</b>
				After Completing the course Preference process confirm your choices and click on the Submit button. The moment a student clicks on the SUBMIT button, their course preferences will be registered with the time stamp.</br></br>
Courses will be allocated Provisionally after the registration process is completed, based on the student’s selected course preferences and the registered timestamp.</br></br>
Students will be able to view the courses provisionally allocated to them in the SW Elective Registration page on the connect portal.</br></br>
Students must pay the fees within the specified timeline to confirm the course allocation. The auto calculation of fees and the waiver credit (if any) will be done on the payment page. If the fee remains unpaid after the deadline, the provisional allocation will be cancelled and the course offered to the next student in line.</br></br> 
Once the student successfully completes the Payment, the final allocation of the course will be done, and the student will be able to view the allocated course on the connect portal.</br></br>
Step by step instructions for course selection are given in the following pages.</p> -->

            </div>
            

            </div>


             <div id="div_course_list" class="panel panel-default" style="display: block;">
            <div class="panel-heading">
                <strong>Student Credit Details</strong>
            </div>
            <div>     
                <div id="DataList" style="display: none;overflow:auto;">
                    <table cellpadding="0" cellspacing="0" border="0" id="example" class="display table table-striped table-bordered table-hover" width="100%">
                        <thead>
                        </thead>
                        <tbody>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th>Total : </th>
                                <th>
                                </th>
                                <th style="text-align: left"></th>
                                <th style="text-align: left"></th>
                                <th style="text-align: left"></th>
                                
                            </tr>
                        </tfoot>
                    </table>
                </div>
                <br />

                <p style="padding-left:10px; font-weight:900;font-size:x-large;">Total Credits Completed : <span style="color:blue;" id="totalcredits"></span></p>
                <br />
                <div class="button_div" style="padding-left:40%; padding-bottom:10px; display:block;">
                    <button style="align-items:center;" class="btn btn-primary nextclick" id="btnnext">Next</button>
                </div>
            </div>
        </div>
        </div>
</asp:Content>

