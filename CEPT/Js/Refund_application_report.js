var oTable;

$(document).ready(function () {
    getdtdata();
   
});

function getdtdata() {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_Refund_report",

        data: "",
        dataType: "json",
        success: function (data) {

            debugger;
            if (data.d != "") {
                var jsondata = JSON.parse(data.d);
                if (jsondata["status"] == "True") {
                    display_student_data(jsondata["message"]);
                }
                else {
                    alert(jsondata["message"]);
                }
            }


        },
        error: function (result) {
            alert(result);
        }
    });


}

function display_student_data(data) {
    // alert(data);

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        
        "bPaginate": true,
        "bStateSave": false,
        "iDisplayLength": 30,
        "sDom": 't',
        "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
        //         "sScrollY": '400px',
        "oLanguage": {
            "sSearch": "Search all columns with Space:"
        },
        //        "sDom": 'T<"clear">lfrtip',
        "oTableTools": {
            "aButtons": [
							"copy",
							"print",
							{
							    "sExtends": "collection",
							    "sButtonText": 'Export',
							    "aButtons": ["xls", "pdf"]
							}
            ]
        },

        "aaData": data,
        "aoColumns": [

          { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },

          { "sTitle": "Application Id ", "mData": "application_id", "bSortable": false },

           { "sTitle": "Email id", "mData": "mail", "bSortable": false },

             { "sTitle": "Refund Amount ", "mData": "refund_amount", "bSortable": false },
             { "sTitle": "Reson For Drop ", "mData": "reason_for_dropwithdrawal", "bSortable": false },
            { "sTitle": "Name Of Account Holder ", "mData": "name_of_account_holder", "bSortable": false },

             { "sTitle": "name_of_bank_address", "mData": "name_of_bank_address", "bSortable": false },
             { "sTitle": "account_type ", "mData": "account_type", "bSortable": false },
            { "sTitle": "IFSC_code ", "mData": "IFSC_code", "bSortable": false },


            { "sTitle": "account_number", "mData": "account_number", "bSortable": false },
            { "sTitle": "created_date ", "mData": "created_date", "bSortable": false },

            {
                "sTitle": "Select", "bSortable": false, "mData": null, fnRender: function (oObj) {
                    return '<center><button type="button" onclick="redirectviewpage(\'' + oObj.aData.application_id + '\')">View</button></center>';
                }
            }


        ]


    });

    $('#DataList').css('display', 'block');


}

function redirectviewpage(data) {

    $('#hdn_userid').val(data);
    $('#hdn_download').click();
}
