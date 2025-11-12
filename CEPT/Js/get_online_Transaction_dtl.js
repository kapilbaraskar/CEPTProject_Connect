
var oTable;

$(document).ready(function () {

    $('#btnreterive').on('click', function () {


        $('#DataList').css('display', 'none');
        $('#div_transaction').css('display', 'none');

        var trans_id = $('#txt_trasaction_id').val();

        if (trans_id == '') {

            bootbox.alert("Please Enter Transaction Id");

            return false;

        }

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Get_selected_transaction_data",

            data: "{transaction_id: '" + trans_id + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != "") {
                    debugger;
                    if (data.d == "already") {
                        bootbox.alert("This Transaction Id's Details Already Found in Master");
                        return false;
                    }

                    display_data(data.d);
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
    });


    $('#btnsave').on('click', function () {

        var trans_id = $('#txt_trasaction_id').val();

        if (trans_id == '') {
            bootbox.alert("Please Enter Transaction Id");
            return false;
        }

        var payment_trans_no = $('#txt_PG_transaction_id').val();

        if (payment_trans_no == '') {
            bootbox.alert("Please Enter PG Transaction Id");
            return false;
        }
        var citrus_ref_no = $('#txt_citrus_txn_id').val();

        if (citrus_ref_no == '') {

            bootbox.alert("Please Enter Citrus Txn Id");
            return false;
        }
        var aut_code = $('#txt_payment_autho_code').val();
        if (aut_code == '') {
            bootbox.alert("Please Enter Auth Id Code");
            return false;
        }


        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../../WebService.asmx/Save_transaction_details",

            data: "{transactionId: '" + trans_id + "',payment_ref_no:'" + payment_trans_no + "',citrus_ref_no:'" + citrus_ref_no + "',auth_code:'" + aut_code + "'}",
            dataType: "json",
            success: function (data) {

                if (data.d != "") {
                    bootbox.alert(data.d);
                    $('#txt_trasaction_id').val('');
                    $('#txt_PG_transaction_id').val('');
                    $('#txt_citrus_txn_id').val('');
                    $('#txt_payment_autho_code').val('');

                    $('#DataList').css('display', 'none');
                    $('#div_transaction').css('display', 'none');

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

        "aaData": JSON.parse(data),
        "aoColumns": [
          { "sTitle": "Transaction Id", "mData": "transaction_id", "bSortable": false },
          { "sTitle": "Student Code", "mData": "user_id", "bSortable": false },
           { "sTitle": "Student Name", "mData": "user_name", "bSortable": false },
          { "sTitle": "Amount", "mData": "amount", "bSortable": false },
            { "sTitle": "Created Date", "mData": "created_date", "bSortable": false }

            ]


    });


    $('#DataList').css('display', 'block');
    $('#div_transaction').css('display', 'block');


}