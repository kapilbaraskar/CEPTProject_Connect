function confirmdialog(message)
{
    Swal.fire({
        title: message,
        text: "",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, remove it!"
    }).then((result) => {
        if (result.isConfirmed) {
            var thisdata = $(this).closest("tr");
            $(this).closest("tr").remove();
            Swal.fire({
                title: "Deleted!",
                text: "Your Data has been deleted.",
                icon: "success"
            });
        }
    });
}