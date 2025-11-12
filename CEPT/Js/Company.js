var oTable;
var user_data;

var cad_user_data = "";

$(document).ready(function () {

    GetCompanydata();

    $('#btnsave').on('click', function () {

        var datalist = [];
        
        
        //        bootbox.alert('kamlesh');

        $('#example tbody tr').each(function (i) {

            var aPos = oTable.fnGetPosition(this);
            var aData = oTable.fnGetData(aPos[i]);
            var a = aData[i];
         
            var obj = {};

            obj["company_code"] = $(this).children().eq(0).html();
            obj["user_id"] = $(this).find(".cad_user").val();
            obj["doc_no"] = a["doc_no"];

            datalist.push(obj);


        });



        var data = JSON.stringify({ cad_data: JSON.stringify(datalist) });

        $.ajax({
            type: "POST",
            url: "WebService.asmx/SAVE_CAS_Workflow",
            data: data,
            contentType: "application/json; charset=utf-8",
            datatype: "json",
            success: function (data) {

                bootbox.alert(data.d);


                GetCompanydata();

            },
            error: function (msg) { alert(msg.d); }
        });

        return false;
    });
});


function GetCompanydata() {


    BindCAD_Data();

    GetCad_user_data();


    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "WebService.asmx/GetCompanyMaster",

        data: "{}",
        dataType: "json",
        success: function (data) {


            DisplayData(data.d);
            $('#btnsave').css("display", "block");

        },
        error: function (result) {
            alert(result);
        }
    });
}

function DisplayData(data) {
    //   alert(data);

    if (oTable != null) {
        oTable.fnDestroy();

        $("#DataList").html(' <table cellpadding="0" cellspacing="0" border="0" class="table table-striped table-bordered table-hover" id="example"><thead></thead><tbody> </tbody></table>');
    }

    oTable = $("#example").dataTable({

        "bPaginate": false,
        "bStateSave": true,
        "sDom": 't',
        "sScrollY": '400px',

        "aaData": JSON.parse(data),
        "aoColumns": [
                { "sTitle": "Company Code", "mData": "company_code","sWidth": "100px", "bSortable": false },
                { "sTitle": "Company Name", "mData": "company_name", "sWidth": "500px", "bSortable": false },
                 { "sTitle": "CAD User",
                     "bSortable": false,
                     "mData": null,

                     fnRender: function (oObj) {

                         // var user = JSON.parse(user_data)


                         //                         if (so_exp_value != "") {
                         //                             so_exp = JSON.parse(so_exp_value);
                         //                         }


                         var listItems = '<select class="cad_user" id="' + oObj.aData['company_code'] + '" >';
                         listItems += "<option value='0'>-- - Select-- -</option>";
                         for (var i = 0; i < user_data.length; i++) {


                             listItems += "<option  value='" + user_data[i]["user_id"] + "'>" + user_data[i]["user_name"] + "</option>";
                         }


                         listItems += '</select>';



                         return listItems;


                         // return '<select id="' + oObj.aData['Activity'] + '">' + '<option value="L*B*H">L*B*H</option>' + '<option value="PI*r*r">PI * r * r *h</option>' + '<option value="2(L + B)">2(L + B)</option>' + '</select> ';
                     }
                 }
            ]


    });

    $("#example tbody tr").each(function (i) {


        if (cad_user_data != "") {


            for (var j = 0; j < cad_user_data.length; j++) {

                if (cad_user_data[j]["company_code"] == $(this).children().eq(0).html()) {

                    if (cad_user_data[j]["user_id"] != "0") {

                        $(this).find(".cad_user").val(cad_user_data[j]["user_id"]);
                    }
                }
            }
        }
        else {

        }

    });


}


function BindCAD_Data() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "WebService.asmx/Get_Cad_user",

        data: "{}",
        dataType: "json",
        success: function (data) {

            // alert(data.d);

            user_data = JSON.parse(data.d);

            // alert(user_data);

        },
        error: function (result) {
            alert(result);
        }
    });
}

function GetCad_user_data() {

    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "WebService.asmx/Get_Cad_workflow_user",

        data: "{}",
        dataType: "json",
        success: function (data) {

            if (data.d != "") {
                cad_user_data = JSON.parse(data.d);
            }
           



        },
        error: function (result) {
            alert(result);
        }
    });
}



    

