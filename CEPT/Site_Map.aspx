<%@ Page Title="Site Map" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="Site_Map.aspx.cs" Inherits="Site_Map" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css'>
    <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
    <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
    <script src="Js/SiteMapscript.js"></script>
    <%--   <link href="Style/SiteMapStyle.css" rel="stylesheet" />--%>
    <style>
        section {
            border-bottom: 1px solid #ccc;
            margin-top: 1em;
        }

            section .col-md-3 {
                border-left: 1px solid #ccc;
                padding-left: 33px;
            }

                section .col-md-3:first-child {
                    border: none;
                }


        ol.sub_des
        {
            list-style-type: none;
            padding-left: 17px;
            padding-top: 3px;
            padding-bottom: 3px;
            color: #010202f2;
        }

        ul {
            list-style-type: none;
            /*counter-reset: css-counter 0;*/ /* initializes counter to 0; use -1 for zero-based numbering */
        }

        #divSiteMap ul li {
            /* counter-increment: css-counter 1;*/ /* Increase the counter by 1. */
        }

            #divSiteMap ul li:before {
                /*content: counter(css-counter) ". ";*/ /* Apply counter before children's content. */
            }


        /*#divSiteMap ul li {
     list-style-type: none;
  counter-increment: my-awesome-counter;
}
#divSiteMap ul li::before {
  content: counter(my-awesome-counter) ". ";
  color: red;
  font-weight: bold;
}*/
        #count_value {
            color: black !important;
        }

        p#test_1 {
            /*padding: 2px 4px;*/
            font-size: 90%;
            color: #c7254e;
           /* background-color: #f9f2f4;*/
           /* border-radius: 4px;*/
        }

        #test_1 span 
        {
           /* background-color: #ede5e7;
            border-radius: 4px;
            padding: 2px 4px;*/
            text-align: justify;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <%-- <ul class="nav nav-pills">
    <li role="presentation"><a href="#sec1">Section 1</a></li>
    <li role="presentation"><a href="#sec2">Section 2</a></li>
    <li role="presentation"><a href="#sec3">Section 3</a></li>
    <li role="presentation"><a href="#Menu5">Section 4</a></li>
    </ul>--%>
        <div id="divSiteMap" clientidmode="Static" runat="server"></div>
    </div>
</asp:Content>


