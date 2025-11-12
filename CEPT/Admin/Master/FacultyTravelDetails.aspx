<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="FacultyTravelDetails.aspx.cs" Inherits="Admin_Master_FacultyTravelDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/js/bootstrap-datepicker.min.js"></script>
    <link type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.2.0/css/datepicker.min.css" rel="stylesheet" />


   <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-timepicker/1.13.18/jquery.timepicker.min.css" /> --%>
   <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
   <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
    
    <script src="../../Js/FacultyTravel.js?t=18112024" type="text/javascript"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/alasql/0.4.8/alasql.min.js"></script>



    <style>
        .validation-msg {
            color: red;
            font-size: 12px;
            display: none; /* Hidden by default */
            margin-top: 5px; /* Add some space between the input and the message */
            display: block; /* Make sure the message spans the entire width below the input */
        }

        input.error, select.error {
            border-color: red;
        }

        .validate {
            display: block;
            width: 100%; /* Ensure the input takes full width */
            margin-bottom: 0px; /* Remove bottom margin */
        }

    </style>

    <style>
    
    .form-control {
        width: 100%;
        box-sizing: border-box;
        margin-bottom: 10px;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    
    
    select.form-control {
        width: 100%;
        max-width: 220px;
    }

    
    textarea.form-control {
        width: 100%;
        max-width: 420px;
    }

    /* Align validation messages */
    .validation-msg {
        color: red;
        font-size: 12px;
    }

    /* Adjust table layout */
    table {
        width: 100%;
    }

    /* Align td elements properly and apply padding */
    td {
        padding: 10px;
        vertical-align: top;
    }

    /* Add padding for the top labels */
    .pad-top {
        padding-top: 15px;
    }

    /* Responsive design to handle small screen layouts */
    @media (max-width: 768px) {
        td {
            display: block;
            width: 100%;
        }
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="padding-bottom:70px;">
    <div class="row-fluid" id="for_other" style="display: none;">
        <div class="page-header position-relative">
            <h1>
                <i class="icon-desktop"></i>&nbsp;Faculty Travel Details
            </h1>
        </div>
    </div>

    <div class="panel panel-default ">
        <div class="panel-heading">
            <b>Faculty Travel Details Note</b>
        </div>
        <div style="color: blue; padding: 10px;">
            
            <span style="color:red;" id="txtmessage"></span><br />
        </div>

    </div>


        <div class="panel panel-default ">
        <div class="panel-heading">
            <b>Fill by Details</b>
        </div>
        <div style="padding: 10px; overflow: visible;" id="div_fillby_detail" class="panel-collapse collapse in">
            <table style="width: 100%;" cellpadding="10" cellspacing="20">
                 <tr>
                    <td class="pad-top">Name : </td>
                    <td>
                        <input type="text" id="txt_name" class="validate marg-btm" style="width:237px;" placeholder="Enter Name" />
                        <span class="validation-msg" id="name-validation"></span>
                    </td>
                    <td class="pad-top">Mail Id : </td>
                    <td>
                        <input type="text" id="txt_mail" class="validate marg-btm" placeholder="Enter Email" />
                        <span class="validation-msg" id="mail-validation"></span>
                    </td>
                    <td class="pad-top">Mobile No : </td>
                    <td>
                        <input type="text" id="txt_contact" class="validate marg-btm" placeholder="Enter Mobile No" />
                        <span class="validation-msg" id="contact-validation"></span>
                    </td>
                </tr>
                </table>
            </div>
            </div>


    <div class="panel panel-default ">
        <div class="panel-heading">
            <b>Traveler Details</b>
        </div>
        <div style="padding: 10px; overflow: visible;" id="div_personal_detail" class="panel-collapse collapse in">


            <table style="width: 100%;" cellpadding="10" cellspacing="20">

               
                <tr>
                        <td class="pad-top">Faculty : <span style="color:red;">*</span></td>
                        <td>
                             <select style='width:100%;' name ="res_faculty" class='marg-btm' id="res_faculty">
                            <option value="">Please Select Faculty</option>
                            </select>
                            <span class="validation-msg" id="faculty-validation"></span>     
                        </td>
                      <td class="pad-top">Destination From</td>
                    <td>
                        <input type="text" id="txt_destFrom" class="validate marg-btm" placeholder="Enter Destination From (Place)" />
                        <span class="validation-msg" id="contact-destFrom"></span>
                    </td>
                        <td class="pad-top">Destination To</td>
                    <td>
                        <input type="text" id="txt_destTo" class="validate marg-btm" placeholder="Enter Destination To (Place)" />
                        <span class="validation-msg" id="contact-destTo"></span>
                    </td>
                        
                    </tr>
                <tr>
                     <td colspan="1" class="pad-top">Purpose of Traveling : <span style="color:red;">*</span></td>
                    <td colspan="6">
                        
                        <textarea id="txt_purposeoftraveling" class="validate marg-btm res_name" name="purposeoftraveling" rows="5" cols="60" style="width:420px;" placeholder="Enter Purpose of Traveling"></textarea>
                        <span class="validation-msg" id="contact-purposeoftraveling"></span>
                    </td>
                </tr>

                 <tr>
                        <td class="pad-top">Expense Type <span style="color:red;">*</span> : </td>
                        <td>
                             <select style='width:100%;' name ="res_Expense_Type" class='marg-btm' id="res_ExpenseType">
                            <option value="">Select Expense Type</option>
                            <option value="Chargeable">Chargeable</option>
                            <option value = "Reimbursable">Reimbursable</option>
                            </select>
                            <span class="validation-msg" id="ExpenseType-validation"></span>
                           
                        </td>
                      <td class="pad-top">Expense Head <span style="color:red;">*</span> : </td>
                        <td>
                             <select style='width:100%;' name ="res_Expense_Head" class='marg-btm' id="res_ExpenseHead">
                            <option value="">Select Expense Head</option>
                            </select>
                            <span class="validation-msg" id="ExpenseHead-validation"></span>
                           
                        </td>


                     <td class="pad-top">Please Arrange<br /> To Book <span style="color:red;">*</span> : </td>
                        <td>
                             <select style='width:100%;' name ="res_Arrange_book" class='marg-btm' id="res_Arrangebook">
                            <option value="">Select Arrange Book</option>
                            <option value="Ticket">Ticket(S)</option>
                            <option value = "HotelAcc">Hotel Accommodations</option>
                            <option value = "HT">Hotel and Ticket</option>
                            <option value = "HTA">Hotel and Taxi</option>
                            <option value = "Taxi">Taxi</option>
                            <option value = "All">All</option>
                            </select>
                            <span class="validation-msg" id="Arrangebook-validation"></span>
                           
                        </td>
                    

                      
                        
                    </tr>
                <tr>

                        <td class="pad-top">Payment Mode <span style="color:red;">*</span> : </td>
                        <td>
                             <select style='width:100%;' name ="res_Arrange_book" class='marg-btm' id="res_PaymentMode">
                            <option value="">Select Payment Mode</option>
                            <option value="DPFT">Direct Payment From The Traveler</option>
                            <option value = "BU">Bill to University</option>
                            </select>
                            <span class="validation-msg" id="PaymentMode-validation"></span>
                           
                        </td>

                    <td class="pad-top">Mode Of Travel <span style="color:red;">*</span> : </td>
                        <td>
                             <select style='width:100%;' name ="res_Mode_Of_Travel" class='marg-btm' id="res_ModeOfTravel">
                            <option value="">Select Mode Of Travel</option>
                            <option value="Air">Air</option>
                            <option value = "Rail">Rail</option>
                            <option value = "Taxi">Taxi</option>
                            </select>
                            <span class="validation-msg" id="ModeOfTravel-validation"></span>
                           
                        </td>
                </tr>
               <tr id="projectname" style="display:none;">
                   <td colspan="1" class="pad-top">Project Name : <span style="color:red;">*</span></td>
                    <td colspan="6">
                        
                        <textarea id="txt_projectname" class="validate marg-btm res_name" name="projectname" rows="5" cols="60" style="width:420px;" placeholder="Enter Project Name"></textarea>
                        <span class="validation-msg" id="contact-projectname"></span>
                    </td>

               </tr>

            </table>
        </div>
        
    </div>

      <div class="panel panel-default ">
            <div class="panel-heading">
                <b>Personal Details</b>
                 <%--<input type="button" id="btn_add_non_cept_faculty_row" class="btn btn-primary btn-small" value="Add Non Cept Faculty Row" style="float: right; margin-top: -6px;" onclick="return add_row('add_nonceptfaculty_dtl');">

               <input type="button" id="btn_add_details_other_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('add_personal_dtl');">--%>
                 <input type="button" id="btn_add_details_other_activity_row" class="btn btn-primary btn-small" value="Add Traveler" 
           style="float: right; margin-top: -6px;" 
           onclick="return add_row('add_personal_dtl');">

                <input type="button" id="btn_add_non_cept_faculty_row" class="btn btn-primary btn-small" value="Add Non Cept Faculty Traveler" 
           style="float: right; margin-top: -6px; margin-right: 20px;" onclick="return add_row('add_nonceptfaculty_dtl');">

   
            </div>
             <div style="padding: 10px; overflow: auto;" id="div_personal_dtl" class="panel-collapse collapse in">
                 <table id="tbl_personal_activity" style="width: 100%;" cellpadding="10" cellspacing="20">
                    <tr>
                        <th>Name <span style="color:red;">*</span></th>
                        <th>Dob <span style="color:red;">*</span></th>
                        <th>Gender <span style="color:red;">*</span></th>
                        <th>Address <span style="color:red;">*</span></th>
                        <th>Contact No <span style="color:red;">*</span></th>
                        <th>ID No(Aadhar/Pan) <span style="color:red;">*</span></th>
                        <th>Meal Request <span style="color:red;">*</span></th>
                        <th>Action</th>
                    </tr>
                    <tr>
                       
                        <td><select name ="InstName" class='validate marg-btm' id="personal_dtl_name_0"></select>
                             <span class="validation-msg" id="personal_dtl_name_0-validation"></span>
                        </td>
                        <td><input type="text" class="validate marg-btm" id="personal_dtl_dob_0" placeholder='dd/mm/yyyy' />
                            <span class="validation-msg" id="personal_dtl_dob_0-validation"></span>
                        </td>
                        <td><select name ="Gender" class='validate marg-btm' id="personal_dtl_gender_0"><option value="M">Male</option><option value="F">Female</option></select>
                            <span class="validation-msg" id="personal_dtl_gender_0-validation"></span>

                        </td> 
                        <td><textarea id='personal_dtl_address_0' class='validate marg-btm' rows='1' cols='60'></textarea>
                            <span class="validation-msg" id="personal_dtl_address_0-validation"></span>

                        </td>
                        
                        <td><input type="text" class="validate marg-btm" id="personal_dtl_contact_0"/>
                            <span class="validation-msg" id="personal_dtl_contact_0-validation"></span>

                        </td>
                        <td><input type="text" class="validate marg-btm" id="personal_dtl_id_0" />
                            <span class="validation-msg" id="personal_dtl_id_0-validation"></span>
                        </td>

                        <td><select name ="personal_dtl_mealrequest" class='validate marg-btm' id="personal_dtl_mealrequest_0"><option value="Y">Yes</option><option value="N">No</option></select>
                            <span class="validation-msg" id="personal_dtl_mealrequest_0-validation"></span>

                        </td> 
                        <td><center><i class='icon-trash icon-2x text-blue 'style='cursor:pointer;'></i></center></td>
                       
                    </tr>
                </table>
            </div>

        </div>




     <div class="panel panel-default ">
    <div class="panel-heading">
        <b>Travel Details</b>
        <input type="button" id="travel_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('add_Travel_dtl');">
    </div>
    <div style="padding: 10px; overflow: auto;" id="div_Travel_dtl" class="panel-collapse collapse in">
        <table id="tbl_Travel_activity" style="width: 100%;" cellpadding="10" cellspacing="20">
            <tr>
                <th>Date of Travel <span style="color:red;">*</span></th>
                <th>From Date <span style="color:red;">*</span></th>
                <th>To Date <span style="color:red;">*</span></th>
                <th>Travel <span style="color:red;">*</span></th>
                <th>Preferable Timing <span style="color:red;">*</span></th>
                <th>Action</th>
            </tr>
            <tr>
                <td>
                    <input type="text" class="validate marg-btm" id="travel_dtl_date_0" placeholder='dd/mm/yyyy' />
                    <span class="validation-msg" id="travel_dtl_date_0-validation"></span>
                </td>
                <td>
                    <input type="text" class="validate marg-btm" id="travel_dtl_fromdate_0" placeholder='dd/mm/yyyy' />
                    <span class="validation-msg" id="travel_dtl_fromdate_0-validation"></span>
                </td>
                <td>
                    <input type="text" class="validate marg-btm" id="travel_dtl_todate_0" placeholder='dd/mm/yyyy' />
                    <span class="validation-msg" id="travel_dtl_todate_0-validation"></span>
                </td>
                <td>
                    <select name="travel" class="validate marg-btm" id="travel_dtl_option_0">
                        <option value="F">Flight</option>
                        <option value="T">Train</option>
                        <option value="TX">Taxi</option>
                    </select>
                    <span class="validation-msg" id="travel_dtl_option_0-validation"></span>
                </td>
                <td>
                    <input type="text" class="validate marg-btm" id="travel_dtl_preferabletime_0" placeholder='HH:MM' />
                    <span class="validation-msg" id="travel_dtl_preferabletime_0-validation"></span>
                </td>
                <td>
                    <center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center>
                </td>
            </tr>
        </table>
    </div>
    </div>


    <div class="panel panel-default ">
    <div class="panel-heading">
        <b>Taxi Details</b>
        <input type="button" id="taxi_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('add_taxi_dtl');">
    </div>
   
        
        <div style="padding: 10px; overflow: auto;" id="div_taxi_dtl" class="panel-collapse collapse in">
        <table id="tbl_taxi_activity" style="width: 100%;" cellpadding="10" cellspacing="20">
            <tr>
                <th>Date <span style="color:red;">*</span></th>
                <th>Pick up Address <span style="color:red;">*</span></th>
                <th>Pick up Time <span style="color:red;">*</span></th>
                <th>Drop Time <span style="color:red;">*</span></th>
                <th>Action</th>
            </tr>
            <tr>
                <td>
                    <input type="text" class="validate marg-btm" id="taxi_dtl_date_0" placeholder='dd/mm/yyyy' />
                    <span class="validation-msg" id="taxi_dtl_date_0-validation"></span>
                </td>
                <td>
                    <textarea class='validate marg-btm' id='taxi_dtl_pickupaddress_0'  rows='1' cols='60'></textarea>
                    <span class="validation-msg" id="taxi_dtl_pickupaddress_0-validation"></span>
                </td>
                <td>
                    <input type="text" class="validate marg-btm" id="taxi_dtl_pickuptime_0" placeholder='HH:mm:ss' />
                    <span class="validation-msg" id="taxi_dtl_pickuptime_0-validation"></span>
                </td>
                <td>
                     <input type="text" class="validate marg-btm" id="taxi_dtl_droptime_0" placeholder='HH:mm:ss' />
                    <span class="validation-msg" id="taxi_dtl_droptime_0-validation"></span>
                </td>
                <td>
                    <center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center>
                </td>
            </tr>
        </table>
    </div>
    </div>



   <div class="panel panel-default ">
    <div class="panel-heading">
        <b>Accommodation Details</b>
        <input type="button" id="Accommodation_activity_row" class="btn btn-primary btn-small" value="Add Row" style="float: right; margin-top: -6px;" onclick="return add_row('add_Accommodation_dtl');">
    </div>
   
        
        <div style="padding: 10px; overflow: auto;" id="div_Accommodation_dtl" class="panel-collapse collapse in">
        <table id="tbl_Accommodation_activity" style="width: 100%;" cellpadding="10" cellspacing="20">
            <tr>
                <th>Place <span style="color:red;">*</span></th>
                <th>Name of the Hotel  <span style="color:red;">*</span></th>
                <th>Accommodation <span style="color:red;">*</span></th>
                <th>In date <span style="color:red;">*</span></th>
                <th>Out date <span style="color:red;">*</span></th>
                <th>IN Time <span style="color:red;">*</span></th>
                <th>Out Time <span style="color:red;">*</span></th>
                <th>Payment Mode <span style="color:red;">*</span></th>
                <th>Action</th>
            </tr>
            <tr>
                <td>
                    <input type="text" class="validate marg-btm" id="Accommodation_dtl_place_0" placeholder='Place' />
                    <span class="validation-msg" id="Accommodation_dtl_place_0-validation"></span>
                </td>
                <td>
                    <textarea class='validate marg-btm' id='Accommodation_dtl_hotelname_0'  rows='1' cols='20' placeholder="Name of the Hotel"></textarea>
                    <span class="validation-msg" id="Accommodation_dtl_hotelname_0-validation"></span>
                </td>
                <td>
                    <input type="text" class="validate marg-btm" id="Accommodation_dtl_Accommodation_0" placeholder='Accommodation' />
                    <span class="validation-msg" id="Accommodation_dtl_Accommodation_0-validation"></span>
                </td>
                <td>
                     <input type="text" class="validate marg-btm" id="Accommodation_dtl_indatetime_0" placeholder='In Date' />
                    <span class="validation-msg" id="Accommodation_dtl_indatetime_0-validation"></span>
                </td>
                <td>
                     <input type="text" class="validate marg-btm" id="Accommodation_dtl_outdatetime_0" placeholder='Out date' />
                    <span class="validation-msg" id="Accommodation_dtl_outdatetime_0-validation"></span>
                </td>
                <td>
                     <input type="text" class="validate marg-btm" id="Accommodation_dtl_intime_0" placeholder='In Time' />
                    <span class="validation-msg" id="Accommodation_dtl_intime_0-validation"></span>
                </td>
                <td>
                     <input type="text" class="validate marg-btm" id="Accommodation_dtl_outtime_0" placeholder='Out Time' />
                    <span class="validation-msg" id="Accommodation_dtl_outtime_0-validation"></span>
                </td>

                <td><select name ="paymentmode" class='validate marg-btm' id="Accommodation_dtl_paymentmode_0"><option value="O">Online</option><option value="C">Cash</option><option value="CA">Card</option></select>
                            <span class="validation-msg" id="Accommodation_dtl_paymentmode_0-validation"></span>

                        </td> 
                <td>
                    <center><i class='icon-trash icon-2x text-blue' style='cursor:pointer;'></i></center>
                </td>
            </tr>
        </table>
    </div>
    </div>

        </div>
     <div class="copyright" style="box-shadow: 5px 0 6px 1px black; width: 1060px;">
        <div class="container">
            <div class="row-fluid">
                <div id="submitBtnDiv" class="controls" style="text-align: center">
                </div>
            </div>
            <!--/row-fluid-->
        </div>
        <!--/container-->

    </div>
</asp:Content>

