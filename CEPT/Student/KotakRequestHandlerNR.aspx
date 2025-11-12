<%@ Page Language="C#" AutoEventWireup="true" CodeFile="KotakRequestHandlerNR.aspx.cs" Inherits="Student_KotakRequestHandlerNR" %>

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
    <form id="nonseamless" method="post" name="redirect" action="<%=strKotakReqUrl%>">
        <input type="hidden" id="enc_request" name="enc_request" value="<%=strEncRequest%>" />
        <input type="hidden" id="access_code" name="access_code" value="<%=strAccessCode%>" />
        <input type="hidden" id="request_type" name="request_type" value="<%=request_type%>" />
        <input type="hidden" id="response_type" name="response_type" value="<%=response_type%>" />
        <input type="hidden" id="command" name="command" value="<%=command%>" />
        <input type="hidden" id="version" name="version" value="<%=version%>" />
    </form>
</body>
</html>
