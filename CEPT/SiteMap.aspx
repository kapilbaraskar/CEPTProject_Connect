<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SiteMap.aspx.cs" Inherits="SiteMap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Site Map</title>
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
    <script src="Js/SiteMapscript.js"></script>
    <link href="Style/SiteMapStyle.css" rel="stylesheet" />
    
</head>
<body style="margin-top:20px;">
    <!-- partial:index.partial.html -->
    <div class="container">
        <div style="float:right;">
        <div id="i22byht1img" style="width: 196px; height: 35px; position: relative;">
                                        <img alt="" style="width: 196px; height: 63px; object-fit: cover;" src="<%= Page.ResolveClientUrl("~/image/Capture.png") %>"
                                            id="i22byht1imgimage" class="s4imgimage"></div>
            </div>
        <h1>Chronological Site Map </h1>

   <%-- <ul class="nav nav-pills">
    <li role="presentation"><a href="#sec1">Section 1</a></li>
    <li role="presentation"><a href="#sec2">Section 2</a></li>
    <li role="presentation"><a href="#sec3">Section 3</a></li>
    <li role="presentation"><a href="#Menu5">Section 4</a></li>
    </ul>--%>
    <div id="divSiteMap" clientidmode="Static" runat="server"></div></div>

    
</body>
</html>
