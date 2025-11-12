<%@ Page Title="" Language="C#" MasterPageFile="~/AdminCEPT.master" AutoEventWireup="true" CodeFile="NewHome.aspx.cs" Inherits="Admin_Master_NewHome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <link href="DesignCss/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>

 .info-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.progress {
  height: 8px;
  background: #e0e0e0;
  border-radius: 5px;
  overflow: hidden;
  margin-top: 10px;
}

.progress-bar {
  height: 100%;
  border-radius: 5px;
}

@media screen and (max-width: 768px) {
  .two-columns {
    grid-template-columns: 1fr; 
  }

  .right-content {
    height: auto; 
  }
}

.two-columns {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 20px;
  align-items: stretch; 
}

@media screen and (max-width: 768px) {
  .four-cards {
    grid-template-columns: 1fr; 
  }
}

.graph-container,
.quick-links,
.calendar-container {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.graph-container, .calendar-container {
  background: #fff;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
}

.calendar-container {
  flex: 1; 
  border: 1px solid #ddd;
}

.right-content {
  display: flex;
  flex-direction: column;
  gap: 20px; 
  height: 100%;
}
.quick-links {
  flex: 1; 
  border: 1px solid #ddd;
}

.quick-links {
 
  color: black;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  font-weight: bold;
  text-align: left;
}

.quick-links h2 {
  margin-bottom: 10px;
  font-size: 22px;
  border-bottom: 2px solid white;
  padding-bottom: 5px;
}

.quick-links ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

.quick-links li {
  margin: 10px 0;
}

.quick-links a {
  text-decoration: none;
  font-size: 15px;
  display: block;
  padding: 2px 5px;
  border-radius: 5px;
}

.quick-links a:hover {
  text-decoration: underline;
}

.four-cards {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
}

.comp-card {
  background: white;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
  text-align: left;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.small-chart {
  width: 80px;
  height: 50px;
}

.col-green {
  color: #28a745;
}

.l-bg-purple {
  background: #6f42c1;
}

.l-bg-red {
  background: #dc3545;
}

.l-bg-green {
  background: #28a745;
}

.l-bg-orange {
  background: #fd7e14;
}

@media (max-width: 992px) {
  .four-cards {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 576px) {
  .four-cards {
    grid-template-columns: 1fr;
  }
}

.small-chart {
  width: 57px;
  height: 50px;
}

.four-cards {
  display: grid;
  grid-template-columns: repeat(4, 1fr); 
  gap: 20px; 
}

.card {
  background: #fff;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
  text-align: center;
}
.table-container {
  background: #fff;
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
  overflow-x: auto;
}

.search_bar {
  height: 47px;
  max-width: 430px;
  width: 100%;
}
.search_bar input {
  height: 100%;
  width: 100%;
  border-radius: 25px;
  font-size: 18px;
  outline: none;
  background-color: var(--white-color);
  color: var(--grey-color);
  border: 1px solid var(--grey-color-light);
  padding: 0 20px;
}

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <div class="main-content">
      <section class="section">
        <div class="section-content four-cards">
          
          <div class="card comp-card">
            <div class="card-body">
              <div class="info-content">
                <div>
                  <h4 class="info-box-title">Total Fee</h4>
                  <h3 class="info-box-value col-green">4,50,000</h3>
                </div>
                <canvas id="chart1" class="small-chart"></canvas>
              </div>
              <div class="progress">
                <div class="progress-bar l-bg-purple" style="width: 45%"></div>
              </div>
            </div>
          </div>
          
          <div class="card comp-card">
            <div class="card-body">
              <div class="info-content">
                <div>
                  <h4 class="info-box-title">Total CGPA/SGPA</h4>
                  <h3 class="info-box-value col-green">7.38</h3>
                </div>
                <canvas id="chart2" class="small-chart"></canvas>
              </div>
              <div class="progress">
                <div class="progress-bar l-bg-red" style="width: 45%"></div>
              </div>
            </div>
          </div>
    
          <div class="card comp-card">
            <div class="card-body">
              <div class="info-content">
                <div>
                  <h4 class="info-box-title">Total Credits</h4>
                  <h3 class="info-box-value col-green">48</h3>
                </div>
                <canvas id="chart3" class="small-chart"></canvas>
              </div>
              <div class="progress">
                <div class="progress-bar l-bg-green" style="width: 45%"></div>
              </div>
            </div>
          </div>
    
          <div class="card comp-card">
            <div class="card-body">
              <div class="info-content">
                <div>
                  <h4 class="info-box-title">Remianing Credits</h4>
                  <h3 class="info-box-value col-green">24</h3>
                </div>
                <canvas id="chart4" class="small-chart"></canvas>
              </div>
              <div class="progress">
                <div class="progress-bar l-bg-orange" style="width: 45%"></div>
              </div>
            </div>
          </div>
    
        </div>
      </section>

      <section class="section">
        <div class="section-content two-columns">
          
          <div class="graph-container">
            <h2>Student Summary</h2>
            <div id="container" style="width: 100%; height: 400px;"></div>
          </div>
      
          <div class="right-content">
            <div class="quick-links">
              <h2>Quick Links</h2>
              <ul>
                <li><a href="#">Dashboard</a></li>
                <li><a href="#">Reports</a></li>
                <li><a href="#">Settings</a></li>
                <li><a href="#">Help Center</a></li>
              </ul>
            </div>
      
            <div class="calendar-container">
              <h2>Calendar</h2>
              <div id="calendar"></div>
            </div>
          </div>
        </div>
      </section>
      
      <section class="section">
        <div class="section-content">
          <div class="table-container">
            <h2>Student Data</h2>
            <table>
              <thead>
                <tr>
                  <th>Header 1</th>
                  <th>Header 2</th>
                  <th>Header 3</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Data A</td>
                  <td>Data B</td>
                  <td>Data C</td>
                </tr>
                <tr>
                  <td>Data D</td>
                  <td>Data E</td>
                  <td>Data F</td>
                </tr>
                <tr>
                  <td>Data G</td>
                  <td>Data H</td>
                  <td>Data I</td>
                </tr>
                <tr>
                  <td>Data J</td>
                  <td>Data K</td>
                  <td>Data L</td>
                </tr>
                <tr>
                  <td>Data M</td>
                  <td>Data N</td>
                  <td>Data O</td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="graph-container">
            <h2>Student Attendence</h2>
            <canvas id="barGraph"></canvas>
          </div>
        </div>
      </section>
    </div>
  
 <link href="https://cdn.jsdelivr.net/npm/fullcalendar/main.min.css" rel="stylesheet" />
 <script src="https://cdn.jsdelivr.net/npm/fullcalendar/main.min.js"></script>
 
 <script>
     document.addEventListener('DOMContentLoaded', function () {
         const calendarEl = document.getElementById('calendar');
         const calendar = new FullCalendar.Calendar(calendarEl, {
             initialView: 'dayGridMonth',
             height: '300px',
             events: [
                 { title: 'Event 1', start: '2025-01-25' },
                 { title: 'Event 2', start: '2025-01-28' },
             ],
         });
         calendar.render();
     });
 </script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link href="https://cdn.syncfusion.com/ej2/material.css" rel="stylesheet">
<script src="https://cdn.syncfusion.com/ej2/dist/ej2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

 <script>

     const barCtx = document.getElementById('barGraph').getContext('2d');

     new Chart(barCtx, {
         type: 'bar',
         data: {
             labels: ['A', 'B', 'C', 'D'],
             datasets: [{ label: 'Bar Dataset', data: [5, 10, 15, 20], backgroundColor: 'orange' }]
         }
     });


     var pieChart = new ej.charts.AccumulationChart({
         series: [
             {
                 dataSource: [
                     { x: 'Chrome', y: 59.28 },
                     { x: 'UC Browser', y: 4.37 },
                     { x: 'Opera', y: 3.12 },
                     { x: 'Sogou Explorer', y: 1.73 },
                     { x: 'QQ', y: 3.96 },
                     { x: 'Safari', y: 4.73 },
                     { x: 'Internet Explorer', y: 6.12 },
                     { x: 'Edge', y: 7.48 },
                     { x: 'Others', y: 9.57 }
                 ],
                 xName: 'x',
                 yName: 'y',
                 type: 'Pie',
                 dataLabel: {
                     visible: true,
                     position: 'Outside',
                     name: 'x'
                 }
             }
         ],
         legendSettings: {
             visible: true,
             position: 'Top'
         },
         tooltip: {
             enable: true
         }
     });
     pieChart.appendTo('#container');

     function createPieChart(chartId) {
         const ctx = document.getElementById(chartId).getContext("2d");
         new Chart(ctx, {
             type: "pie",
             data: {
                 labels: ["Boys", "Girls"],
                 datasets: [{
                     data: [60, 40],
                     backgroundColor: ["#6f42c1", "#dc3545"]
                 }]
             },
             options: {
                 responsive: false,
                 maintainAspectRatio: false,
                 plugins: { legend: { display: false } }
             }
         });
     }

     function createLineChart(chartId, color) {
         const ctx = document.getElementById(chartId).getContext("2d");
         new Chart(ctx, {
             type: "line",
             data: {
                 labels: ["Jan", "Feb", "Mar", "Apr", "May"],
                 datasets: [{
                     data: [10, 20, 15, 25, 30],
                     borderColor: color,
                     backgroundColor: "rgba(0, 0, 0, 0)",
                     borderWidth: 2,
                     pointRadius: 0,
                     tension: 0.4
                 }]
             },
             options: {
                 responsive: false,
                 maintainAspectRatio: false,
                 scales: { x: { display: false }, y: { display: false } },
                 plugins: {
                     legend: { display: false },
                     tooltip: {
                         enabled: true,
                         backgroundColor: "black",
                         titleColor: "white",
                         bodyColor: "white",
                         borderWidth: 0,
                         displayColors: false,
                         padding: 4,
                         caretSize: 0,
                         cornerRadius: 4,
                         titleFont: { size: 10, weight: "bold" },
                         bodyFont: { size: 10 },
                         callbacks: {
                             label: function (tooltipItem) {
                                 return `● ${tooltipItem.raw}`;
                             },
                             title: function () {
                                 return "";
                             }
                         }
                     }
                 }
             }
         });
     }

     function createLineChart_1(chartId, color) {
         const ctx = document.getElementById(chartId).getContext("2d");
         new Chart(ctx, {
             type: "line",
             data: {
                 labels: ["Jan", "Feb", "Mar", "Apr", "May"],
                 datasets: [{
                     data: [23, 28, 33, 45, 50],
                     borderColor: color,
                     backgroundColor: "rgba(0, 0, 0, 0)",
                     borderWidth: 2,
                     pointRadius: 0,
                     tension: 0.4
                 }]
             },
             options: {
                 responsive: false,
                 maintainAspectRatio: false,
                 scales: { x: { display: false }, y: { display: false } },
                 plugins: {
                     legend: { display: false },
                     tooltip: {
                         enabled: true,
                         backgroundColor: "black",
                         titleColor: "white",
                         bodyColor: "white",
                         borderWidth: 0,
                         displayColors: false,
                         padding: 4,
                         caretSize: 0,
                         cornerRadius: 4,
                         titleFont: { size: 10, weight: "bold" },
                         bodyFont: { size: 10 },
                         callbacks: {
                             label: function (tooltipItem) {
                                 return `● ${tooltipItem.raw}`;
                             },
                             title: function () {
                                 return "";
                             }
                         }
                     }
                 }
             }
         });
     }

     function createBarChart(chartId, color) {
         const ctx = document.getElementById(chartId).getContext("2d");
         new Chart(ctx, {
             type: "bar",
             data: {
                 labels: ["Course A", "Course B", "Course C"],
                 datasets: [{
                     data: [15, 25, 35],
                     backgroundColor: color
                 }]
             },
             options: {
                 responsive: false,
                 maintainAspectRatio: false,
                 scales: { x: { display: false }, y: { display: false } },
                 plugins: {
                     legend: { display: false },
                     tooltip: {
                         enabled: true,
                         backgroundColor: "black",
                         titleColor: "white",
                         bodyColor: "white",
                         borderWidth: 0,
                         displayColors: false,
                         padding: 4,
                         caretSize: 0,
                         cornerRadius: 4,
                         titleFont: { size: 10, weight: "bold" },
                         bodyFont: { size: 10 },
                         callbacks: {
                             label: function (tooltipItem) {
                                 return `● ${tooltipItem.raw}`;
                             },
                             title: function () {
                                 return "";
                             }
                         }
                     }
                 }
             }
         });
     }

     createPieChart("chart1");
     createLineChart("chart2", "#dc3545");
     createBarChart("chart3", "#28a745");
     createLineChart_1("chart4", "#fd7e14");
 </script>
</asp:Content>
