var success_data={
title:"",
first_name : "",
program_course_desc :"",
transaction_id :"",
pg_transaction_id:"",
application_id:"",
email_id:"",
program_type_id:"",
message : ""
};



var ViewModel = {
     status:ko.observable(""),
     data:ko.mapping.fromJS(success_data)
     
      
};
ViewModel.data.contact_email_id = ko.computed(function () {
    debugger;
    var program_type_id = ViewModel.data.program_type_id();
    if (program_type_id == "PTM0001") // UG
    {
        return "ug@cept.ac.in";
    }
    else if (program_type_id == "PTM0002")//PG
    {
        return "pg@cept.ac.in";
    }
    else if (program_type_id == "PTM0003")//PHD
    {
        return "phd@cept.ac.in";
    }
    else if (program_type_id == "PTM0004")//DIPLOMA
    {
        return "diploma@cept.ac.in";
    }
    else {
        return "";
    }
}, ViewModel);


function onReady() {
    debugger;
    var data=  JSON.parse(  $("#data").val());

    ViewModel.status(data["status"]);
    ko.mapping.fromJS(data["data"],ViewModel.data);



}
