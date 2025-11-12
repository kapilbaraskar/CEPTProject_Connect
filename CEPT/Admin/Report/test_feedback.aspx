<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test_feedback.aspx.cs" Inherits="Admin_Report_test_feedback" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
     <script type="text/javascript">
         Function.prototype.bind = Function.prototype.bind || function (thisp) {
             var fn = this;
             return function () {
                 return fn.apply(thisp, arguments);
             };
         }
    </script>
    <script src="../../Scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/knockout-3.0.0.js" type="text/javascript"></script>
    <script src="../../ChartJs/globalize.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/dx.chartjs.js" type="text/javascript"></script>
     <script src="../../Scripts/jspdf.min.js" type="text/javascript"></script>
   
</head>
<body>
    <form id="form1" runat="server">
    <div id="print_data" style="display: block">
        <div style="page-break-after: always;">
            <table width="100%">
                <tbody>
                    <tr>
                        <td>
                            <img style="float: left; height: 50px;" src="../../image/Capture.PNG">
                        </td>
                        <td align="center" style="font-size: 25px; font-weight: bold; padding-top: 0px; vertical-align: super;">
                            STUDENT FEEDBACK
                        </td>
                        <td style="font-size: 20px; font-weight: bold; text-align: right; vertical-align: super;">
                            <b style="width: 160px;">Spring - 2015 </b>
                        </td>
                    </tr>
                    <tr>
                    </tr>
                </tbody>
            </table>
            <table style="margin-top: 5px;" width="100%">
                <tbody>
                    <tr>
                        <td style="font-size: 16px; font-weight: bold;">
                            COURSE TITLE : Architectural Design Studio 8
                        </td>
                        <td>
                        </td>
                        <td align="right" style="font-size: 16px; font-weight: bold">
                            COURSE CODE : 1015
                        </td>
                    </tr>
                </tbody>
            </table>
            <div style="border: 1px solid">
                <table style="width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px;
                    font: 10px arial, san serif; border-collapse: collapse; border: 0px solid #000000"
                    cellpadding="0" cellspacing="0" id="tbl_lecture" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="padding-left: 5px; font-size: 15px; font-style: italic; padding-right: 5px;
                                border: 5px solid white; border-bottom: 0; background-color: white; color: black;
                                height: 18px;" colspan="14">
                                COURSE TYPE : Studio
                            </td>
                            <td align="right" style="padding-left: 5px; font-size: 15px; font-style: italic;
                                padding-right: 5px; border: 5px solid white; border-bottom: 1; background-color: white;
                                color: black; height: 18px;" colspan="14">
                                NO OF STUDENTS : 27
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 5px; font-size: 15px; font-style: italic; padding-right: 5px;
                                border: 5px solid white; border-bottom: 0; background-color: white; color: black;
                                height: 18px;" colspan="12">
                                FACULTY : Faculty of Architecture
                            </td>
                            <td>
                            </td>
                            <td align="right" style="padding-left: 5px; font-size: 15px; font-style: italic;
                                padding-right: 5px; border: 5px solid white; border-bottom: 0; background-color: white;
                                color: black; height: 18px;" colspan="8">
                                NO OF RESPONDENTS : 23
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="course" style="border: 1px solid; margin-bottom: 5px; margin-top: 5px;">
                <div style="margin-left: 20px; -webkit-user-select: none;" id="1015-113">
                    <svg width="1038" height="550" xmlns="https://www.w3.org/2000/svg" xmlns:xlink="https://www.w3.org/1999/xlink"
                        version="1.1" stroke="none" stroke-width="0" fill="none" class="dxc dxc-chart"
                        style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); display: block; overflow: hidden;"><defs><clipPath id="DevExpress_2"><rect x="0" y="0" width="1038" height="550" rx="0" ry="0" fill="none" stroke="none" stroke-width="0"></rect></clipPath><clipPath id="DevExpress_3"><rect x="626" y="62" width="408" height="488" rx="0" ry="0" fill="none" stroke="none" stroke-width="0"></rect></clipPath><pattern id="DevExpressPattern_1" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#5f8b95" opacity="0.75"></rect><path stroke-width="2" stroke="#5f8b95" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpressPattern_2" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#5f8b95" opacity="0.5"></rect><path stroke-width="2" stroke="#5f8b95" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpressPattern_3" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#ba4d51" opacity="0.75"></rect><path stroke-width="2" stroke="#ba4d51" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpressPattern_4" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#ba4d51" opacity="0.5"></rect><path stroke-width="2" stroke="#ba4d51" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern></defs><g class="dxc-background"></g><g class="dxc-title"><g transform="translate(519,21)"><text x="0" y="0" text-anchor="middle" style="font-family: &quot;Segoe UI Light&quot;, &quot;Helvetica Neue Light&quot;, &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 200; fill: rgb(35, 35, 35); font-size: 28px; cursor: default; fill-opacity: 2;"><tspan x="0" dy="0" style="font-size: 19px; font-weight: bold;">Course Feedback</tspan></text></g></g><g class="dxc-strips-group"><g class="dxc-h-strips" clip-path="url(#DevExpress_3)"></g><g class="dxc-v-strips" clip-path="url(#DevExpress_3)"></g></g><g class="dxc-axes-group"><g class="dxc-h-axis" clip-path="url(#DevExpress_2)"><g class="dxc-grid"><path stroke-width="1" stroke="#d3d3d3" d="M 626.5 550 L 626.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 694.5 550 L 694.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 762.5 550 L 762.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 830.5 550 L 830.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 898.5 550 L 898.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 966.5 550 L 966.5 62" style="display: none;"></path><path stroke-width="1" stroke="#d3d3d3" d="M 1034.5 550 L 1034.5 62" style="display: none;"></path></g><g class="dxc-elements"><text x="626" y="49" text-anchor="middle" transform="rotate(0,626,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="626" dy="0">1</tspan></text><text x="694" y="49" text-anchor="middle" transform="rotate(0,694,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="694" dy="0">2</tspan></text><text x="762" y="49" text-anchor="middle" transform="rotate(0,762,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="762" dy="0">3</tspan></text><text x="830" y="49" text-anchor="middle" transform="rotate(0,830,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="830" dy="0">4</tspan></text><text x="898" y="49" text-anchor="middle" transform="rotate(0,898,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="898" dy="0">5</tspan></text><text x="945" y="49" text-anchor="middle" transform="rotate(0,966,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="945" y="30">COR</tspan><tspan x="945" y="49">AVG</tspan></text><text x="1000" y="49" text-anchor="middle" transform="rotate(0,1034,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="1000" y="30">FAC</tspan><tspan x="1000" y="49">AVG</tspan></text></g><g class="dxc-line"></g><g class="dxc-title"></g></g><g class="dxc-v-axis" clip-path="url(#DevExpress_2)"><g class="dxc-grid"></g><g class="dxc-elements"><text x="616" y="516" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">Overall Rating of Course </tspan><tspan dy="0" dx="0">  </tspan><tspan dy="0" dx="0" x="935" fill="#85A9B1" style="font-size: 17px; font-weight: bold;">3.6</tspan></text><text x="616" y="435" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">The course improved my ability to work in groups </tspan><tspan dy="0" dx="0"> </tspan><tspan dy="0" dx="0" x="935" fill="#85A9B1" style="font-size: 17px; font-weight: bold;">2.9</tspan></text><text x="616" y="354" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">The course helped to come up with practical solutions </tspan><tspan dy="0" dx="0"> </tspan><tspan dy="0" dx="0" x="935" fill="#85A9B1" style="font-size: 17px; font-weight: bold;">3.7</tspan></text><text x="616" y="272" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">The course helped me develop my skills to understand and analyze problems </tspan><tspan dy="0" dx="0"> </tspan><tspan dy="0" dx="0" x="935" fill="#85A9B1" style="font-size: 17px; font-weight: bold;">4.0</tspan></text><text x="616" y="191" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">The course achieved its objectives </tspan><tspan dy="0" dx="0"> </tspan><tspan dy="0" dx="0" x="935" fill="#85A9B1" style="font-size: 17px; font-weight: bold;">3.7</tspan></text><text x="616" y="110" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">The objectives for this course were clearly outlined and communicated by the instructor's</tspan><tspan dy="0" dx="0"> </tspan><tspan dy="0" dx="0" x="935" fill="#85A9B1" style="font-size: 17px; font-weight: bold;">3.8</tspan></text></g><g class="dxc-line"></g><g class="dxc-title"></g></g></g><g class="dxc-constant-lines-group"><g class="dxc-h-constant-lines"></g><g class="dxc-v-constant-lines"></g></g><g class="dxc-strips-labels-group"><g class="dxc-axis-labels"></g><g class="dxc-axis-labels"></g></g><g class="dxc-border"></g><g class="dxc-series-group"><g class="dxc-series" transform="translate(0,0) scale(1,1)"><g class="dxc-elements" clip-path="url(#DevExpress_3)"></g><g class="dxc-markers" stroke-width="0" stroke="none" fill="#5f8b95" r="0" inh="true" line-width="2"><rect x="626" y="480" width="177" height="57" rx="0" ry="0" fill="#85A9B1"></rect><rect x="626" y="399" width="129" height="57" rx="0" ry="0" fill="#85A9B1"></rect><rect x="626" y="318" width="184" height="57" rx="0" ry="0" fill="#85A9B1"></rect><rect x="626" y="236" width="204" height="57" rx="0" ry="0" fill="#85A9B1"></rect><rect x="626" y="155" width="184" height="57" rx="0" ry="0" fill="#85A9B1"></rect><rect x="626" y="74" width="190" height="57" rx="0" ry="0" fill="#85A9B1"></rect></g></g><g class="dxc-series"><g class="dxc-elements" clip-path="url(#DevExpress_3)"></g><g class="dxc-markers" stroke-width="0" stroke="none" fill="#ba4d51" r="6" inh="true"><circle cx="810" cy="509" r="6" transform="translate(0,0)"></circle><circle cx="789" cy="428" r="6" transform="translate(0,0)"></circle><circle cx="810" cy="347" r="6" transform="translate(0,0)"></circle><circle cx="823" cy="265" r="6" transform="translate(0,0)"></circle><circle cx="810" cy="184" r="6" transform="translate(0,0)"></circle><circle cx="816" cy="103" r="6" transform="translate(0,0)"></circle></g></g></g><g class="dxc-labels-group"><g class="dxc-series-labels" clip-path="url(#DevExpress_3)" opacity="1"></g><g class="dxc-series-labels" clip-path="url(#DevExpress_3)" opacity="1"><g><g x="810" y="504" transform="translate(32,5) rotate(0,810,504)"><rect x="955" y="492" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="810" y="509" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.7</tspan></text></g></g><g><g x="789" y="423" transform="translate(32,5) rotate(0,789,423)"><rect x="955" y="411" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="789" y="428" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.4</tspan></text></g></g><g><g x="810" y="342" transform="translate(32,5) rotate(0,810,342)"><rect x="955" y="330" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="810" y="347" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.7</tspan></text></g></g><g><g x="823" y="260" transform="translate(32,5) rotate(0,823,260)"><rect x="955" y="248" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="823" y="265" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.9</tspan></text></g></g><g><g x="810" y="179" transform="translate(32,5) rotate(0,810,179)"><rect x="955" y="167" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="810" y="184" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.7</tspan></text></g></g><g><g x="816" y="98" transform="translate(32,5) rotate(0,816,98)"><rect x="955" y="86" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="816" y="103" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.8</tspan></text></g></g></g></g><g class="dxc-crosshair-cursor"></g><g class="dxc-legend"><g class="dxc-legend-trackers" stroke="none" fill="grey" opacity="0.0001"></g></g><g class="dxc-tooltip"><path fill="#000000" stroke="none" opacity="0.1" d="M 0 0" visibility="hidden"></path><path d="M 0 0 Z" visibility="hidden"></path><text x="0" y="0" text-anchor="middle" visibility="hidden" style="font-family: &quot;Segoe UI Light&quot;, &quot;Helvetica Neue Light&quot;, &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 200; font-size: 26px; fill: rgb(255, 255, 255); cursor: default;"><tspan x="0" dy="0">0</tspan></text></g><g class="dxc-trackers" opacity="0.0001"><g class="dxc-crosshair-trackers" stroke="none" fill="grey"></g><g class="dxc-series-trackers"><g class="dxc-pane-tracker" clip-path="url(#DevExpress_3)"></g></g><g class="dxc-markers-trackers" stroke="none" fill="grey" display="none"><g class="dxc-pane-tracker" clip-path="url(#DevExpress_3)"><rect x="626" y="480" width="177" height="57" rx="0" ry="0"></rect><rect x="626" y="399" width="129" height="57" rx="0" ry="0"></rect><rect x="626" y="318" width="184" height="57" rx="0" ry="0"></rect><rect x="626" y="236" width="204" height="57" rx="0" ry="0"></rect><rect x="626" y="155" width="184" height="57" rx="0" ry="0"></rect><rect x="626" y="74" width="190" height="57" rx="0" ry="0"></rect><circle cx="810" cy="509" r="6"></circle><circle cx="789" cy="428" r="6"></circle><circle cx="810" cy="347" r="6"></circle><circle cx="823" cy="265" r="6"></circle><circle cx="810" cy="184" r="6"></circle><circle cx="816" cy="103" r="6"></circle></g></g></g></svg>
                </div>
                <script type="text/javascript">                    var dataSource = [{ name: '<div style="font-size: 15px;">Overall Rating of Course </div>  <div style="font-weight: bold; font-size: 17px;">3.6</div>', average: parseFloat(3.6), median: parseFloat(3.7) }, { name: '<div style="font-size: 15px;">The course improved my ability to work in groups </div> <div style="font-weight: bold; font-size: 17px;"><b>2.9</div>', average: parseFloat(2.9), median: parseFloat(3.4) }, { name: '<div style="font-size: 15px;">The course helped to come up with practical solutions </div> <div style="font-weight: bold; font-size: 17px;"><b>3.7</div>', average: parseFloat(3.7), median: parseFloat(3.7) }, { name: '<div style="font-size: 15px;">The course helped me develop my skills to understand and analyze problems </div> <div style="font-weight: bold; font-size: 17px;"><b>4.0</div>', average: parseFloat(4.0), median: parseFloat(3.9) }, { name: '<div style="font-size: 15px;">The course achieved its objectives </div> <div style="font-weight: bold; font-size: 17px;"><b>3.7</div>', average: parseFloat(3.7), median: parseFloat(3.7) }, { name: '<div style="font-size: 15px;">The objectives for this course were clearly outlined and communicated by the instructor\'s</div> <div style="font-weight: bold; font-size: 17px;"><b>3.8</div>', average: parseFloat(3.8), median: parseFloat(3.8)}]; var series = [{ argumentField: 'name', valueField: 'average', type: 'bar', name: 'Average1', label: { visible: false, precision: 1, horizontalOffset: 40} }, { argumentField: 'name', name: 'Average2', valueField: 'median', type: 'scatter', label: { visible: true, precision: 1, position: 'inside'}}]; $('#1015-113').dxChart({ size: { height: 550 }, dataSource: dataSource, series: series, rotated: true, palette: 'Default', valueAxis: { position: 'top', min: 1, max: 7, tickInterval: 1, valueMarginsEnabled: false }, title: { text: '<div style="font-weight: bold; font-size: 19px;">Course Feedback</div>', font: { horizontalAlignment: 'center', opacity: 2 }, position: 'centerTop' }, commonSeriesSettings: { argumentField: 'state', type: 'bar', hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints', label: { visible: false, format: 'fixedPoint', precision: 1} }, legend: { visible: false, verticalAlignment: 'bottom', horizontalAlignment: 'center'} });</script>
            </div>
            <div style="border: 1px solid">
                <table style="width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px;
                    font: 10px arial, san serif; border-collapse: collapse; border: 0px solid #000000"
                    cellpadding="0" cellspacing="0" id="tbl_lecture" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="padding-left: 5px; font-size: 15px; font-style: italic; padding-right: 5px;
                                border: 5px solid white; border-bottom: 0; background-color: white; color: black;
                                height: 18px;" colspan="14">
                                <b>INSTRUCTOR NAME: Nitin Raje</b>
                            </td>
                            <td align="right" style="padding-left: 5px; font-size: 15px; font-style: italic;
                                padding-right: 5px; border: 5px solid white; border-bottom: 0; background-color: white;
                                color: black; height: 18px;" colspan="14">
                                <b>NO OF RESPONDENTS : 12 </b>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="instructor" style="border: 1px solid; border-top: 0;">
                <div style="margin-left: 20px; -webkit-user-select: none;" id="1015-113-1">
                    <svg width="1038" height="550" xmlns="https://www.w3.org/2000/svg" xmlns:xlink="https://www.w3.org/1999/xlink"
                        version="1.1" stroke="none" stroke-width="0" fill="none" class="dxc dxc-chart"
                        style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0); display: block; overflow: hidden;"><defs><clipPath id="DevExpress_4"><rect x="0" y="0" width="1038" height="550" rx="0" ry="0" fill="none" stroke="none" stroke-width="0"></rect></clipPath><clipPath id="DevExpress_5"><rect x="440" y="62" width="594" height="488" rx="0" ry="0" fill="none" stroke="none" stroke-width="0"></rect></clipPath><pattern id="DevExpressPattern_5" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#5f8b95" opacity="0.75"></rect><path stroke-width="2" stroke="#5f8b95" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpressPattern_6" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#5f8b95" opacity="0.5"></rect><path stroke-width="2" stroke="#5f8b95" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpressPattern_7" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#ba4d51" opacity="0.75"></rect><path stroke-width="2" stroke="#ba4d51" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern><pattern id="DevExpressPattern_8" width="6" height="6" patternUnits="userSpaceOnUse"><rect x="0" y="0" width="6" height="6" rx="0" ry="0" fill="#ba4d51" opacity="0.5"></rect><path stroke-width="2" stroke="#ba4d51" d="M 3 -3 L -3 3M 0 6 L 6 0 M 9 3 L 3 9"></path></pattern></defs><g class="dxc-background"></g><g class="dxc-title"><g transform="translate(519,21)"><text x="0" y="0" text-anchor="middle" style="font-family: &quot;Segoe UI Light&quot;, &quot;Helvetica Neue Light&quot;, &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 200; fill: rgb(35, 35, 35); font-size: 28px; cursor: default;"><tspan x="0" dy="0" style="font-size: 19px; font-weight: bold;">Instructor Feedback</tspan></text></g></g><g class="dxc-strips-group"><g class="dxc-h-strips" clip-path="url(#DevExpress_5)"></g><g class="dxc-v-strips" clip-path="url(#DevExpress_5)"></g></g><g class="dxc-axes-group"><g class="dxc-h-axis" clip-path="url(#DevExpress_4)"><g class="dxc-grid"><path stroke-width="1" stroke="#d3d3d3" d="M 440.5 550 L 440.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 539.5 550 L 539.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 638.5 550 L 638.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 737.5 550 L 737.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 836.5 550 L 836.5 62"></path><path stroke-width="1" stroke="#d3d3d3" d="M 935.5 550 L 935.5 62" style="display: none;"></path><path stroke-width="1" stroke="#d3d3d3" d="M 1034.5 550 L 1034.5 62" style="display: none;"></path></g><g class="dxc-elements"><text x="440" y="49" text-anchor="middle" transform="rotate(0,440,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="440" dy="0">1</tspan></text><text x="539" y="49" text-anchor="middle" transform="rotate(0,539,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="539" dy="0">2</tspan></text><text x="638" y="49" text-anchor="middle" transform="rotate(0,638,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="638" dy="0">3</tspan></text><text x="737" y="49" text-anchor="middle" transform="rotate(0,737,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="737" dy="0">4</tspan></text><text x="836" y="49" text-anchor="middle" transform="rotate(0,836,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="836" dy="0">5</tspan></text><text x="945" y="49" text-anchor="middle" transform="rotate(0,935,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="945" y="30">IND</tspan><tspan x="945" y="49">AVG</tspan></text><text x="1000" y="49" text-anchor="middle" transform="rotate(0,1034,49)" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="1000" y="30">FAC</tspan><tspan x="1000" y="49">AVG</tspan></text></g><g class="dxc-line"></g><g class="dxc-title"></g></g><g class="dxc-v-axis" clip-path="url(#DevExpress_4)"><g class="dxc-grid"></g><g class="dxc-elements"><text x="430" y="522" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">Overall Rating of Instructor</tspan><tspan dy="0" dx="0"> </tspan><tspan dy="0" dx="0" x="935" fill="#266473" style="font-size: 17px; font-weight: bold;">4.1</tspan></text><text x="430" y="452" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">The course encouraged creative thinking </tspan><tspan dy="0" dx="0" x="935" fill="#266473" style="font-size: 17px; font-weight: bold;">4.3</tspan></text><text x="430" y="383" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">My queries were effectively addressed </tspan><tspan dy="0" dx="0" x="935" fill="#266473" style="font-size: 17px; font-weight: bold;">4.0</tspan></text><text x="430" y="313" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">Theory and practice were well integrated </tspan><tspan dy="0" dx="0" x="935" fill="#266473" style="font-size: 17px; font-weight: bold;">4.3</tspan></text><text x="430" y="243" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">Work progress was assessed regularly </tspan><tspan dy="0" dx="0" x="935" fill="#266473" style="font-size: 17px; font-weight: bold;">4.1</tspan></text><text x="430" y="174" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">I received relevant and timely inputs from the instructors </tspan><tspan dy="0" dx="0" x="935" fill="#266473" style="font-size: 17px; font-weight: bold;">4.2</tspan></text><text x="430" y="104" text-anchor="inherit" style="fill: black; font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px; cursor: default;"><tspan x="0" dy="0" style="font-size: 15px;">The instructor was available during the scheduled studio time</tspan><tspan dy="0" dx="0" x="935" fill="#266473" style="font-size: 17px; font-weight: bold;">3.9</tspan></text></g><g class="dxc-line"></g><g class="dxc-title"></g></g></g><g class="dxc-constant-lines-group"><g class="dxc-h-constant-lines"></g><g class="dxc-v-constant-lines"></g></g><g class="dxc-strips-labels-group"><g class="dxc-axis-labels"></g><g class="dxc-axis-labels"></g></g><g class="dxc-border"></g><g class="dxc-series-group"><g class="dxc-series" transform="translate(0,0) scale(1,1)"><g class="dxc-elements" clip-path="url(#DevExpress_5)"></g><g class="dxc-markers" stroke-width="0" stroke="none" fill="#5f8b95" r="0" inh="true" line-width="2"><rect x="440" y="490" width="307" height="49" rx="0" ry="0"></rect><rect x="440" y="420" width="327" height="49" rx="0" ry="0"></rect><rect x="440" y="351" width="297" height="49" rx="0" ry="0"></rect><rect x="440" y="281" width="327" height="49" rx="0" ry="0"></rect><rect x="440" y="211" width="307" height="49" rx="0" ry="0"></rect><rect x="440" y="142" width="317" height="49" rx="0" ry="0"></rect><rect x="440" y="72" width="287" height="49" rx="0" ry="0"></rect></g></g><g class="dxc-series"><g class="dxc-elements" clip-path="url(#DevExpress_5)"></g><g class="dxc-markers" stroke-width="0" stroke="none" fill="#ba4d51" r="6" inh="true"><circle cx="717" cy="515" r="6" transform="translate(0,0)"></circle><circle cx="707" cy="445" r="6" transform="translate(0,0)"></circle><circle cx="707" cy="376" r="6" transform="translate(0,0)"></circle><circle cx="697" cy="306" r="6" transform="translate(0,0)"></circle><circle cx="717" cy="236" r="6" transform="translate(0,0)"></circle><circle cx="717" cy="167" r="6" transform="translate(0,0)"></circle><circle cx="737" cy="97" r="6" transform="translate(0,0)"></circle></g></g></g><g class="dxc-labels-group"><g class="dxc-series-labels" clip-path="url(#DevExpress_5)" opacity="1" style="display: none;"><g><g x="440" y="485" transform="translate(281,29) rotate(0,440,485)"><rect x="955" y="473" width="32" height="24" rx="0" ry="0" fill="#5f8b95" stroke-width="0" stroke="none" class=""></rect><text x="440" y="490" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">4.1</tspan></text></g></g><g><g x="440" y="415" transform="translate(301,29) rotate(0,440,415)"><rect x="955" y="403" width="32" height="24" rx="0" ry="0" fill="#5f8b95" stroke-width="0" stroke="none" class=""></rect><text x="440" y="420" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">4.3</tspan></text></g></g><g><g x="440" y="346" transform="translate(271,29) rotate(0,440,346)"><rect x="955" y="334" width="32" height="24" rx="0" ry="0" fill="#5f8b95" stroke-width="0" stroke="none" class=""></rect><text x="440" y="351" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">4.0</tspan></text></g></g><g><g x="440" y="276" transform="translate(301,29) rotate(0,440,276)"><rect x="955" y="264" width="32" height="24" rx="0" ry="0" fill="#5f8b95" stroke-width="0" stroke="none" class=""></rect><text x="440" y="281" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">4.3</tspan></text></g></g><g><g x="440" y="206" transform="translate(281,29) rotate(0,440,206)"><rect x="955" y="194" width="32" height="24" rx="0" ry="0" fill="#5f8b95" stroke-width="0" stroke="none" class=""></rect><text x="440" y="211" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">4.1</tspan></text></g></g><g><g x="440" y="137" transform="translate(291,29) rotate(0,440,137)"><rect x="955" y="125" width="32" height="24" rx="0" ry="0" fill="#5f8b95" stroke-width="0" stroke="none" class=""></rect><text x="440" y="142" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">4.2</tspan></text></g></g><g><g x="440" y="67" transform="translate(261,29) rotate(0,440,67)"><rect x="955" y="55" width="32" height="24" rx="0" ry="0" fill="#5f8b95" stroke-width="0" stroke="none" class=""></rect><text x="440" y="72" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.9</tspan></text></g></g></g><g class="dxc-series-labels" clip-path="url(#DevExpress_5)" opacity="1"><g><g x="717" y="510" transform="translate(32,5) rotate(0,717,510)"><rect x="955" y="498" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="717" y="515" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.8</tspan></text></g></g><g><g x="707" y="440" transform="translate(32,5) rotate(0,707,440)"><rect x="955" y="428" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="707" y="445" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.7</tspan></text></g></g><g><g x="707" y="371" transform="translate(32,5) rotate(0,707,371)"><rect x="955" y="359" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="707" y="376" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.7</tspan></text></g></g><g><g x="697" y="301" transform="translate(32,5) rotate(0,697,301)"><rect x="955" y="289" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="697" y="306" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.6</tspan></text></g></g><g><g x="717" y="231" transform="translate(32,5) rotate(0,717,231)"><rect x="955" y="219" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="717" y="236" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.8</tspan></text></g></g><g><g x="717" y="162" transform="translate(32,5) rotate(0,717,162)"><rect x="955" y="150" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="717" y="167" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">3.8</tspan></text></g></g><g><g x="737" y="92" transform="translate(32,5) rotate(0,737,92)"><rect x="955" y="80" width="32" height="24" rx="0" ry="0" fill="#ba4d51" stroke-width="0" stroke="none" class=""></rect><text x="737" y="97" text-anchor="middle" style="fill: rgb(255, 255, 255); font-family: &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 400; font-size: 12px;"><tspan x="970" dy="0" style="font-weight: bold; font-size: 15px;">4.0</tspan></text></g></g></g></g><g class="dxc-crosshair-cursor"></g><g class="dxc-legend"><g class="dxc-legend-trackers" stroke="none" fill="grey" opacity="0.0001"></g></g><g class="dxc-tooltip"><path fill="#000000" stroke="none" opacity="0.1" d="M 0 0" visibility="hidden"></path><path d="M 0 0 Z" visibility="hidden"></path><text x="0" y="0" text-anchor="middle" visibility="hidden" style="font-family: &quot;Segoe UI Light&quot;, &quot;Helvetica Neue Light&quot;, &quot;Segoe UI&quot;, &quot;Helvetica Neue&quot;, &quot;Trebuchet MS&quot;, Verdana; font-weight: 200; font-size: 26px; fill: rgb(255, 255, 255); cursor: default;"><tspan x="0" dy="0">0</tspan></text></g><g class="dxc-trackers" opacity="0.0001"><g class="dxc-crosshair-trackers" stroke="none" fill="grey"></g><g class="dxc-series-trackers"><g class="dxc-pane-tracker" clip-path="url(#DevExpress_5)"></g></g><g class="dxc-markers-trackers" stroke="none" fill="grey"><g class="dxc-pane-tracker" clip-path="url(#DevExpress_5)"><rect x="440" y="490" width="307" height="49" rx="0" ry="0"></rect><rect x="440" y="420" width="327" height="49" rx="0" ry="0"></rect><rect x="440" y="351" width="297" height="49" rx="0" ry="0"></rect><rect x="440" y="281" width="327" height="49" rx="0" ry="0"></rect><rect x="440" y="211" width="307" height="49" rx="0" ry="0"></rect><rect x="440" y="142" width="317" height="49" rx="0" ry="0"></rect><rect x="440" y="72" width="287" height="49" rx="0" ry="0"></rect><circle cx="717" cy="515" r="6"></circle><circle cx="707" cy="445" r="6"></circle><circle cx="707" cy="376" r="6"></circle><circle cx="697" cy="306" r="6"></circle><circle cx="717" cy="236" r="6"></circle><circle cx="717" cy="167" r="6"></circle><circle cx="737" cy="97" r="6"></circle></g></g></g></svg>
                </div>
                <script type="text/javascript">                    var dataSource = [{ name: '<div style="font-size: 15px;">Overall Rating of Instructor</div> <div style="font-weight: bold; font-size: 17px;">4.1</div>', average: parseFloat(4.1), median: parseFloat(3.8) }, { name: '<div style="font-size: 15px;">The course encouraged creative thinking </div><div style="font-weight: bold; font-size: 17px;"><b>4.3</div>', average: parseFloat(4.3), median: parseFloat(3.7) }, { name: '<div style="font-size: 15px;">My queries were effectively addressed </div><div style="font-weight: bold; font-size: 17px;"><b>4.0</div>', average: parseFloat(4.0), median: parseFloat(3.7) }, { name: '<div style="font-size: 15px;">Theory and practice were well integrated </div><div style="font-weight: bold; font-size: 17px;"><b>4.3</div>', average: parseFloat(4.3), median: parseFloat(3.6) }, { name: '<div style="font-size: 15px;">Work progress was assessed regularly </div><div style="font-weight: bold; font-size: 17px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.8) }, { name: '<div style="font-size: 15px;">I received relevant and timely inputs from the instructors </div><div style="font-weight: bold; font-size: 17px;"><b>4.2</div>', average: parseFloat(4.2), median: parseFloat(3.8) }, { name: '<div style="font-size: 15px;">The instructor was available during the scheduled studio time</div><div style="font-weight: bold; font-size: 17px;"><b>3.9</div>', average: parseFloat(3.9), median: parseFloat(4.0)}]; var series = [{ argumentField: 'name', valueField: 'average', type: 'bar', name: 'Average1', label: { visible: true, precision: 1, position: 'inside'} }, { argumentField: 'name', name: 'Average2', valueField: 'median', type: 'scatter', label: { visible: true, precision: 1, position: 'inside'}}]; $('#1015-113-1').dxChart({ size: { height: 550 }, dataSource: dataSource, series: series, valueAxis: { position: 'top', min: 1, max: 7, tickInterval: 1, valueMarginsEnabled: false }, commonSeriesSettings: { argumentField: 'state', type: 'bar', hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints', label: { visible: true, format: 'fixedPoint', precision: 1} }, title: { text: '<div style="font-weight: bold; font-size: 19px;">Instructor Feedback</div>', font: { horizontalAlignment: 'center'} }, legend: { visible: false, verticalAlignment: 'bottom', horizontalAlignment: 'center' }, rotated: true }); </script>
            </div>
            <table style="border: 1px solid; width: 100%; border-collapse: collapse; margin-top: 5px;
                font-size: 14px">
                <tbody>
                    <tr style="font-size: 12px;">
                        <td align="left" colspan="7" style="font-size: 15px; font-weight: bold; font-style: italic">
                            STUDENTS REGISTERED BY FACULTY
                        </td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid; padding-left: 5px; font-style: italic">
                            Name Of Faculty
                        </td>
                        <td style="border: 1px solid; padding-left: 5px; font-style: italic">
                            FA
                        </td>
                        <td style="border: 1px solid; padding-left: 5px; font-style: italic">
                            FD
                        </td>
                        <td style="border: 1px solid; padding-left: 5px; font-style: italic">
                            FM
                        </td>
                        <td style="border: 1px solid; padding-left: 5px; font-style: italic">
                            FP
                        </td>
                        <td style="border: 1px solid; padding-left: 5px; font-style: italic">
                            FT
                        </td>
                        <td style="border: 1px solid; font-style: italic">
                            Total
                        </td>
                    </tr>
                    <tr style="border: 1px solid;">
                        <td style="border: 1px solid; padding-left: 5px; font-style: italic">
                            No. of Students
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            27
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            0
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            0
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            0
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            0
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            27
                        </td>
                    </tr>
                    <tr style="border: 1px solid;">
                        <td style="border: 1px solid; padding-left: 5px; font-style: italic">
                            Percentage(%)
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            100
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            0
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            0
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            0
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            0
                        </td>
                        <td style="border: 1px solid; padding-left: 5px;">
                            100%
                        </td>
                    </tr>
                </tbody>
            </table>
            <div style="font-size: 14px; font-style: italic">
                <div style="margin-top: 2px;">
                    <img style="float: left; margin-top: 3px; width: 9px; margin-right: 4px;" src="../../image/cor_avg.png"><b>Course
                        Average(COR AVG):</b>This is the average of the total responses for this course.
                    For example, for Studio IV,out of total 32 students 28 have responded, the Average
                    represents the mean of all 28 responses.</div>
                <div style="margin-top: 2px;">
                    <img style="float: left; margin-top: 3px; width: 9px; margin-right: 4px;" src="../../image/avg1.png"><b>Individual
                        Average(IND AVG):</b>This is the average score of the total responses for this
                    instructor. For example, for Studio IV,out of total 32 students 28 have responded,
                    the Average represents the mean of all 28 responses.</div>
                <div style="margin-top: 2px;">
                    <img style="float: left; margin-top: 3px; width: 9px; margin-right: 4px;" src="../../image/avg2.png"><b>Faculty
                        Average(FAC AVG):</b> This is the average of all responses for similar course
                    type within the Faculty.For example,Faculty average of Studio IV offered by FA,represents
                    the mean of all responses for Studio courses offered in FA during the given semester.</div>
            </div>
            <div style="font-weight: bold; font-size: 14px; margin-top: 2px;">
                Scale: 1 = least agreement with the statement, 5 = most agreement with the statement</div>
        </div>
        <div style="page-break-after: always;">
            <table style="margin-top: 5px;" width="100%">
                <tbody>
                    <tr>
                        <td style="font-size: 16px; font-weight: bold;">
                            COURSE TITLE : Architectural Design Studio 8
                        </td>
                        <td>
                        </td>
                        <td align="right" style="font-size: 16px; font-weight: bold">
                            COURSE CODE : 1015
                        </td>
                    </tr>
                </tbody>
            </table>
            <div style="border: 1px solid">
                <table style="width: 99%; margin-top: 5px; margin-bottom: 5px; margin-left: 2px;
                    font: 10px arial, san serif; border-collapse: collapse; border: 0px solid #000000"
                    cellpadding="0" cellspacing="0" id="tbl_lecture" width="100%">
                    <thead>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="padding-left: 5px; font-size: 15px; font-style: italic; padding-right: 5px;
                                border: 5px solid white; border-bottom: 0; background-color: white; color: black;
                                height: 18px;" colspan="14">
                                COURSE TYPE : Studio
                            </td>
                            <td align="right" style="padding-left: 5px; font-size: 15px; font-style: italic;
                                padding-right: 5px; border: 5px solid white; border-bottom: 1; background-color: white;
                                color: black; height: 18px;" colspan="14">
                                NO OF STUDENTS : 27
                            </td>
                        </tr>
                        <tr>
                            <td style="padding-left: 5px; font-size: 15px; font-style: italic; padding-right: 5px;
                                border: 5px solid white; border-bottom: 0; background-color: white; color: black;
                                height: 18px;" colspan="12">
                                FACULTY : Faculty of Architecture
                            </td>
                            <td>
                            </td>
                            <td align="right" style="padding-left: 5px; font-size: 15px; font-style: italic;
                                padding-right: 5px; border: 5px solid white; border-bottom: 0; background-color: white;
                                color: black; height: 18px;" colspan="8">
                                NO OF RESPONDENTS : 23
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div>
                <p class="small" style="line-height: 12px; font-size: 20px; font-family: Segoe UI Light, Helvetica Neue Light, Segoe UI, Helvetica Neue, Trebuchet MS, Verdana;">
                    <b>Course Comments </b>
                </p>
            </div>
            <table style="font: 15px arial, san serif; border-collapse: collapse; border: 1px solid;"
                cellpadding="0" cellspacing="0" id="tbl_lecture" width="100%">
                <tbody>
                    <tr style="border: 1px solid;">
                        <td style="border: 1px solid; width: 42px; padding: 4px 7px;">
                            <center>
                                Sr No.</center>
                        </td>
                        <td style="border: 1px solid;">
                            <center>
                                Comments
                            </center>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div>
                <p class="small" style="line-height: 12px; font-size: 20px; font-family: Segoe UI Light, Helvetica Neue Light, Segoe UI, Helvetica Neue, Trebuchet MS, Verdana;">
                    <b>Instructor Comments </b>
                </p>
            </div>
            <div style="font: 10px arial, san serif; font-size: 15px; font-style: italic; color: black;
                height: 18px;" colspan="14">
                <b>Instructor Name: Nitin Raje</b>
            </div>
            <table style="font: 15px arial, san serif; border-collapse: collapse; border: 1px solid"
                cellpadding="0" cellspacing="0" id="tbl_lecture" width="100%">
                <tbody>
                    <tr style="border: 1px solid;">
                        <td style="border: 1px solid; border-bottom: 0; width: 42px; padding: 4px 7px;">
                            <center>
                                Sr No.</center>
                        </td>
                        <td style="border: 1px solid;">
                            <center>
                                Comments
                            </center>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div style="font-size: 15px;">
                Comments are reproduced verbatim from the feedback received</div>
        </div>
    </div>
    </form>
</body>
</html>
