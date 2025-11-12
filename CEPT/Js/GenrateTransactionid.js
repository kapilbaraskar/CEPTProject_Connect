var oTable;
var feesamount = 0;
$(document).ready(function () {

    $('#txt_credit_txn_id').keypress(function (event) {
        var keyCode = event.which;
        if (keyCode < 48 || keyCode > 57) {
            event.preventDefault(); 
        }
    });
    $('#txt_credit_txn_id').on('input', function ()
    {
        var txnId = $(this).val();
        var fees = 0;
        if (txnId)
        {
            if ($('#hdn_fees_type').val() != '') {
                fees = txnId * feesamount;
            }
            else { fees = txnId * 0;}
            
        }
        $('#txt_Amount_txn_id').val(fees);
    });
    $('#btnreterive').on('click', function ()
    {
        $('#DataList').css('display', 'none');
        $('#div_transaction').css('display', 'none');
        calculateFees();

        var user_id = $('#txt_student_id').val();

        if (user_id == '') {
            bootbox.alert("Please Enter Student Id");
            return false;
        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_selected_Student_trasaction_data",
            data: "{user_id: '" + user_id + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "")
                {                
                    display_data(data.d);
                    return false;
                }
                else {
                    $('#div_transaction').css('display', '');//10042025
                    bootbox.alert('There is no Data found for Transaction ID');
                }
            },
            error: function (result) {
                alert(result);
            }
        });
        return false;
    });
    $('#btnsave').on('click', function () {

        var StudentID = $('#txt_student_id').val();
        if (StudentID == '') {
            bootbox.alert("Please Enter Student Code");
            return false;
        }


        var trans_id = $('#txt_PG_transaction_id').val();
        if (trans_id == '') {
            bootbox.alert("Please Enter Transaction Id");
            return false;
        }

        var credit = $('#txt_credit_txn_id').val();
        if (credit == '') {
            bootbox.alert("Please Enter Credit");
            return false;
        }
        var PaymentMode = $('#txt_PaymentMode_txn_id').val();
        if (PaymentMode == '') {
            bootbox.alert("Please Enter Payment Mode");
            return false;
        }
        var Amount = $('#txt_Amount_txn_id').val();
        if (Amount == '') {
            bootbox.alert("Please Enter Amount");
            return false;
        }


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Save_offline_transactionid_details",
            data: "{StudentID: '" + StudentID + "',transactionId: '" + trans_id + "',credit:'" + credit + "',PaymentMode:'" + PaymentMode + "',Amount:'" + Amount + "'}",
            dataType: "json",
            success: function (data) {
                if (data.d != "") {
                    bootbox.alert("Add Manually Transaction Successfull ");
                    $('#txt_PG_transaction_id').val('');
                    $('#txt_PaymentMode_txn_id').val('');
                    $('#txt_credit_txn_id').val('');
                    $('#txt_Amount_txn_id').val('');
                    $('#btnreterive').click();

                    return false;
                }
                else {
                }
            },
            error: function (result) {
                alert(result);
            }
        });
        return false;
    });
    return false;
});




function calculateFees()
{
    var user_id = $('#txt_student_id').val();
    if (user_id == '') {
        bootbox.alert("Please Enter Student Id");
        return false;
    }
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../../WebService.asmx/Get_fees_amount_pre_credit_WS_user",
        data: "{user_id: '" + user_id + "'}",
        dataType: "json",
        success: function (data) {
            if (data.d != "")
            {
                var data = JSON.parse(data.d);
                $('#hdn_fees_type').val(data[0]['fees_amount']);
                $('#amountpercredit').text(data[0]['fees_amount']);
                feesamount = data[0]['fees_amount'];
                return false;
            }
            else {
                bootbox.alert('There is no Data found for Transaction ID');
            }
        },
        error: function (result) {
            alert(result);
        }
    });
    return false;
}



function display_data(data) {
    if (oTable != null) {
        oTable.fnDestroy();
        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({
        "bPaginate": true,
        "bStateSave": false,
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
                "copy",
                "print",
                {
                    "sExtends": "collection",
                    "sButtonText": 'Export',
                    "aButtons": ["xls", "pdf"]
                }
            ]
        },
        "aaData": JSON.parse(data),
        "aoColumns": [
            { "sTitle": "Transaction Id", "mData": "transaction_id", "bSortable": false },
            { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
            { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
            { "sTitle": "Amount", "mData": "amount", "bSortable": false },
            { "sTitle": "Created Date", "mData": "created_date", "bSortable": false },
            { "sTitle": "Fees Type", "mData": "fees_type", "bSortable": false }
        ]
    });

    $('#DataList').css('display', 'block');
    $('#div_transaction').css('display', 'block');
}