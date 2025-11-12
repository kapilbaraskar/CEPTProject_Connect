<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HDFCRequestHandler.aspx.cs" Inherits="Student_HDFCRequestHandler" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <script type="text/javascript" src="../DesignJS/jquery.min.js"></script>  
    <script type="text/javascript">
        $(document).ready(function () {
            $("#nonseamless").submit();
        });
    </script>
</head>
<body>
    <form id="nonseamless" method="post" name="redirect" action="<%=strHDFCReqUrl%>">
        <input type="hidden" id="encRequest" name="encRequest" value="<%=strEncRequest%>" />
        <input type="hidden" id="access_code" name="access_code" value="<%=strAccessCode%>" />
    </form>
</body>
</html>
