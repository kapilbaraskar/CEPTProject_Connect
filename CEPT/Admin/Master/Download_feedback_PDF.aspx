<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Download_feedback_PDF.aspx.cs"
    Inherits="Admin_Master_Download_feedback_PDF" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="https://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="../../Scripts/jquery-2.0.3.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/knockout-3.0.0.js" type="text/javascript"></script>
    <script src="../../ChartJs/globalize.min.js" type="text/javascript"></script>
    <script src="../../ChartJs/dx.chartjs.js" type="text/javascript"></script>
</head>
<body>
    <div id="feedback_data" runat="server">
    </div>

    <%--<rect x="541" y="70" width="294" height="38" rx="0" ry="0"></rect>--%>
</body>

<%--<script type="text/javascript">
    $(document).ready(function () { 
    var dataSource = [{ name: 'Overall Rating of Course- <div style="font-weight: bold; font-size: 16px;">4.0</div>', average: parseFloat(4.0), median: parseFloat(3.5) },
       { name: 'The course met my expectations. - <div style="font-weight: bold; font-size: 16px;"><b>3.8</div>', average: parseFloat(3.8), median: parseFloat(3.2) },
        { name: 'The assignments were promptly evaluated and comments were given. - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.5) },
      { name: 'The evaluation weightage of different components /  assignments of &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <br/> course was consistent with their workload. - <div style="font-weight: bold; font-size: 16px;"><b>4.3</div>', average: parseFloat(4.3), median: parseFloat(3.5) },
        { name: 'The course was well structured. - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.4) },
      { name: 'The assignments / field visits / practicals organized as a part of the course helped to improve my understanding of the subject. - <div style="font-weight: bold; font-size: 16px;"><b>3.8</div>', average: parseFloat(3.8), median: parseFloat(3.6) },
      { name: 'The course materials (e.g. text, lecture notes, reading, etc.) were helpful in learning and understanding the content taught. - <div style="font-weight: bold; font-size: 16px;"><b>3.9</div>', average: parseFloat(3.9), median: parseFloat(3.5) },
    //         { name: 'Course outline (including schedule of classes, reading and other resources, assignments and, evaluation scheme and criteria) was provided at the beginning and explained clearly. - <div style="font-weight: bold; font-size: 16px;"><b>3.9</div>', average: parseFloat(3.9), median: parseFloat(3.7) },
         {name: 'The course achieved its stated objectives. - <div style="font-weight: bold; font-size: 16px;"><b>4.1</div>', average: parseFloat(4.1), median: parseFloat(3.5)}];
    var series = [{ argumentField: 'name', valueField: 'average', type: 'bar', name: 'Average1', label: { visible: false, precision: 1, horizontalOffset: 40} },
           { argumentField: 'name', name: 'Average2', valueField: 'median', type: 'scatter', label: { visible: true, precision: 1, position: 'inside'}}];

    $('#feedback_data').dxChart({ size: { height: 300, width: 650 }, dataSource: dataSource, series: series,
        rotated: true, palette: 'Default', valueAxis: { position: 'top', min: 0, max: 6, tickInterval: 1,
            valueMarginsEnabled: false
        }, title: { text: '<div style="font-weight: bold; font-size: 19px;">Course Feedback</div>',
            font: { horizontalAlignment: 'center', opacity: 2 }, position: 'centerTop'
        },
        commonSeriesSettings: { argumentField: 'state', type: 'bar', hoverMode: 'allArgumentPoints', selectionMode: 'allArgumentPoints',
            label: { visible: false, format: 'fixedPoint', precision: 1 }
        }, legend: { visible: false, verticalAlignment: 'bottom', horizontalAlignment: 'center' }
    });
});
</script>--%>
</html>
