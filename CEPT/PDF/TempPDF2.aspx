<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TempPDF2.aspx.cs" Inherits="PDF_TempPDF2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice</title>
    <style type="text/css">
        table th
        {
            font-weight:100;
            text-align:left;
        }
        table td
        {
            font-weight:100;
            text-align:left;
            padding:2px;
        }
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
        .tr_bold td
        {
            font-weight:bold;
        }
        .brdr_btm td
        {
            border-bottom:1px solid black;
        }
        .tr_top0 td
        {
            border-top:0 !important;
        }
        .total_row td
        {
            border-left:0 !important;
        }
        .total_row td:first-child
        {
            border-left:1px solid black !important;
        }
        #lst_div td
        {
            border:1px solid black;
        }
        #lst_div div:first-child
        {
            float:left;
            width:48%;
            padding:5px;
        }
        #lst_div div:last-child
        {
            float:left;
            width:48%;
            border-left:1px solid black;
            padding:5px;
        }
        
        @media print
        {
        }
        
        @page
        {
            margin:20px;
            <%--size: A4 landscape;--%>
        }
    </style>
</head>
<body>
    <%--<div>
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
    </div>--%>

    <div style="clear:both;"></div>

    <table>
        <thead>
            <tr>
                <th>
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
                    </div>
                </th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                    <div>
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
                </td>
            </tr>
            <tr>
                <td>
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
                            
                            <tr class="tr_bold total_row"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td>Total</td><td></td><td>17999</td><td>2208.00</td><td>16440</td><td>1559</td><td>776778.83</td><td>44153.47</td><td>732625.36</td><td></td><td></td></tr>
                            
                            <tr class="tr_bold total_row tr_top0"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td colspan="5">Total Taxable Value</td><td>732625.36</td><td></td><td></td></tr>
                            <tr class="total_row tr_top0"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td colspan="5">CGST @ 6.00% on 732625.36</td><td>43957.52</td><td></td><td></td></tr>
                            <tr class="total_row tr_top0"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td colspan="5">SGST @ 6.00% on 732625.36</td><td>43957.52</td><td></td><td></td></tr>
                            <tr class="total_row tr_top0"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td colspan="5">Rounding Off</td><td>-0.40</td><td></td><td></td></tr>
                            
                            <tr class="tr_bold total_row tr_top0"><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td colspan="5">Total Invoice Value</td><td>820540.00</td><td></td><td></td></tr>
                        </tbody>
                    </table>
                </td>
            </tr>

            <tr><td>Amount : 0.00</td></tr>
            <tr><td>Order Remark : </td></tr>
            <tr><td>Mfg. Code : </td></tr>

            <tr class="tr_bold brdr_btm"><td align="center">TERMS AND CONDITIONS</td></tr>
            <tr><td>This is <b>"Subject to Bangalore Jurisdiction"</b></td></tr>
            <tr><td>TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS</td></tr>
            <tr><td>TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS</td></tr>
            <tr><td>TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS TERMS AND CONDITIONS</td></tr>
            <tr><td>TERMS AND CONDITIONS</td></tr>

            <tr id="lst_div">
                <td>
                    <div>
                        <b>Amount in Words : </b>Rs.Eight Lacs Twenty Thousand Five Hundred Fourty Only
                    </div>
                    <div>
                        <b>For, </b> MAC PHARMA DISTRIBUTORS<br />
                        Authorized Signatory : <br />
                        Name : <br />
                        Designation : 
                    </div>
                </td>
            </tr>
        </tbody>
    </table>
</body>
</html>
