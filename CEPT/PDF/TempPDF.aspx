<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TempPDF.aspx.cs" Inherits="PDF_TempPDF" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Invoice</title>
    <%--<style type="text/css">
        #div1,#div2,#div3,#div4,#div5,#div6
        {
            float:left;
            width:32%;
            padding:5px;
        }
        #div2,#div5
        {
            border-left:1px solid black;
            border-right:1px solid black;
        }
        #tbl_data
        {
            border-right:1px solid black;
            border-bottom:1px solid black;
        }
        #tbl_data th
        {
            font-weight:bold;
            border-left:1px solid black;
            border-top:1px solid black;
        }
        #tbl_data td
        {
            border-left:1px solid black;
            border-top:1px solid black;
        }
        
        .footer { position: fixed; bottom: 0; }
        .header { position: fixed; top: 0; }
    </style>--%>

    <style type="text/css">
        #tbl tbody tr:first-child
        {
            color:Red;
        }
        
        @media print
        {
            #tbl tbody tr:nth-child(2)
            {
                color:Red;
            }
            #header {
                display: block; 
                position: fixed; 
                top: 0;
            } 
            #footer {
                display: block; 
                position: fixed; 
                bottom: 0;
            } 
        }
    </style>
</head>
<%--<body>
    <div class='header'>This is Header</div>

    <div>
        <div id="div1">
            <div><b>PHARMA DISTRIBUTORS</b></div>
            <div>60/61, DEVMOOL TOWERS, 3RD AND 4TH FLOORS,</div>
            <div>NEW TIMBER YARD LAYOUT, MYSORE ROAD,</div>
            <div>BANGALORE - 560026,</div>
            <div>KARNATAKA, INDIA</div>
            <div>PHONE NO. : 26257921/22, 26257921/22, A/C:26257928/29</div>
            <div>EMAIL ID : mpdbir1@gmail.com</div>
        </div>

        <div id="div2">
            <div><b>SRINIVASA MEDISALES PVT LTD</b></div>
            <div>"MAAS COMPLEX"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;PAN NO:AALCS5968H</div>
            <div>NO. 44, 44/1 & 44/2, 6TH CROSS,</div>
            <div>WILSON GARDEN, HOSUR MAIN ROAD,</div>
            <div>BANGALORE - 560027</div>
            <div>KARNATAKAM, INDIA</div>
            <div>PHONE NO. : 40007999, 40007916, 9844727222</div>
            <div>EMAIL ID : contact@srinivsamedisales.com</div>
        </div>

        <div id="div3">
            <div>Invoice No. : I17005447&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date : 09-Nov-2017</div>
            <div>Memo No. : I17005447&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Page No. : 09-Nov-2017</div>
            <div>Due Date : </div>
        </div>
        
        <div style="clear:both;"></div>

        <div id="div4">
            <table>
                <tr>
                    <td><b>Drug Lic. No. / Mfg No.</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>20B-KA-B21-148682</td>
                </tr>
                <tr>
                    <td><b></b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>20B-KA-B21-148683</td>
                </tr>
                <tr>
                    <td><b>GSTIN No.</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>29AAOFM6704B1Z9</td>
                </tr>
                <tr>
                    <td><b>PAN No.</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>AAOFM6704B</td>
                </tr>
            </table>
        </div>
        
        <div id="div5">
            <table>
                <tr>
                    <td><b>Drug Lic. No. / Mfg No.</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>KA-B31-20B-135017</td>
                </tr>
                <tr>
                    <td><b></b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>KA-B31-20B-135018</td>
                </tr>
                <tr>
                    <td><b>GSTIN No.</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>29AALCS5968H1ZK</td>
                </tr>
                <tr>
                    <td><b>PAN No.</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>AALCS5968H</td>
                </tr>
                <tr>
                    <td><b>Place of Supply</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>BANGALORE, KARNATAKA</td>
                </tr>
                <tr>
                    <td><b>FSSAI No.</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td></td>
                </tr>
            </table>
        </div>

        <div id="div6">
            <table>
                <tr>
                    <td><b>PO No. / Date</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>Cheque No.</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>LR No. / Date</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>No. of Classes</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>Mode of Transport</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td></td>
                </tr>
                <tr>
                    <td><b>Transport Name</b></td>
                    <td>&nbsp;:&nbsp;</td>
                    <td>Local</td>
                </tr>
            </table>
        </div>
    </div>

    <div style="clear:both;"></div>

    <table id="tbl_data" cellspacing="0">
        <thead>
            <tr>
                <th>Div Code</th>
                <th>HSN Code</th>
                <th>Material Name</th>
                <th>Pack</th>
                <th>Batch No.</th>
                <th>Exp. Dt</th>
                <th>Mfg. Code</th>
                <th>MRP</th>
                <th>Rate</th>
                <th>PTR</th>
                <th>Total Qty</th>
                <th>Box</th>
                <th>Billed</th>
                <th>Disc.</th>
                <th>Total Amt Base Price</th>
                <th>Disc. Amt</th>
                <th>Taxable Amount</th>
                <th>GST Rate</th>
                <th>Tax Type</th>
            </tr>
        </thead>
        <tbody>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
            <tr><td>TF02</td><td>30049031</td><td>ALLERCET COLD TABS</td><td>10'S</td><td>ALCY0206</td><td>Feb-2019</td><td></td><td>55.50</td><td>35.68</td><td>39.64</td><td>360.00</td><td>36.00</td><td>300</td><td>60</td><td>12844.80</td><td>2140.80</td><td>10704.00</td><td>12.00</td><td>CGST+SGST</td></tr>
        </tbody>
    </table>

    <div class='footer'>This is Footer</div>
</body>--%>
<body>
    <table id="header" width="100%"> 
        <tr> <td width="100%"> heder text </td></tr>
    </table>

    <table id="tbl" border="0" width="100%"> 
        <thead> 
            <tr> <th style="width:100%">page header</th> </tr> 
            <tr> <th><hr style="color:#000080"/></th> </tr> 
        </thead> 

        <tfoot>
            <tr> 
                <td width="100%"> 
                    <table width="100%" border="0"> 
                        <tr> <td colspan="4"><br>&nbsp;</td> </tr> 
                    </table> 
                </td>
            </tr>
        </tfoot>

        <tbody> 
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
            <tr> <td width="100%"> put your text (for example article main body, title etc...)</td> </tr>
        </tbody> 
    </table>

    <table id="footer" width="100%"> 
        <tr> <td width="100%"> footer text </td></tr>
    </table>
</body>
</html>
