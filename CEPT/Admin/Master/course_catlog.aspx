<%@ Page Language="C#" AutoEventWireup="true" CodeFile="course_catlog.aspx.cs" Inherits="Admin_Master_course_catlog" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Catlog</title>
    <style>
        * {
            box-sizing: border-box;
        }

        body {
            font-family: Helvetica Neue,Helvetica,Arial,sans-serif;
            margin: 5px 15px 0px 20px;
            font-size: 14px;
            color: #333;
            line-height: 24px;
            background-color: #fff;
            text-align: left;
        }

        .column {
            float: left;
            width: 73.33%;
            padding: 10px;
        }

        #left_col {
            float: left;
            width: 26.33%;
            padding: 10px;
            font-weight: bold;
        }

        #left_col_1 {
            float: left;
            width: 15.33%;
            padding: 10px;
            font-weight: bold;
        }

        .row:after {
            content: "";
            display: table;
            clear: both;
        }

        hr {
            color: black;
            height: 13px;
            background-color: forestgreen;
            border: 0px solid forestgreen;
            border-radius: 45px;
        }

        #header_center {
            border: none;
            outline: 0;
            padding: 5px;
            color: white;
            background-color: #000;
            text-align: center;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
        }

        #cours_info {
            width: 100%;
        }
    </style>
</head>
<body>
    <div>
        <span style="font-size: 30px; color: forestgreen;">COURSE CATLOG</span><hr>
    </div>
    <div class="row" id="main_con">
        <div class="column" id="cours_info">
            <p>
                <button id="header_center">@@semester@@year</button>
            </p>
        </div>
    </div>
    <div class="row">
        <div style="width: 60%; float: left;">
            <div class="row">
                <div class="column" id="left_col">Course :</div>
                <div class="column">@@coursecode@@coursename</div>
            </div>
            <div class="row">
                <div class="column" id="left_col">Course Tutor/s :</div>
                <div class="column">@@coursetutorname</div>
            </div>
            <div class="row">
                <div class="column" id="left_col">
                    Link to CEPT Portfolio :<p style="color: #b4b4b4; font-size: x-small; line-height: 1.2; margin-top: 0px;">(studio work from past semesters)</p>
                </div>
                <div class="column">@@link</div>
            </div>
            <div class="row">
                <div class="column" id="left_col">
                    Course Expense :<p style="color: #b4b4b4; font-size: x-small; line-height: 1.2; margin-top: 0px;">
                        (INR -extra expenditure a<br>
                        student would incur during<br>
                        the semester)
                    </p>
                </div>
                <div class="column">@@expense</div>
            </div>
        </div>
        <div style="width: 30%; float: left;">
            <img style="height: 300px;" id="img1" class="" style="" src="https://connect.cept.ac.in/CourseImageUpload/15759709028711.jpg">
        </div>
    </div>
    <div class="row">
        <div class="column" id="left_col_1">Long Description :</div>
        <div class="column">@@longdescription</div>
    </div>
    <div class="row">
        <div class="column" id="left_col_1">Course Prerequisite :</div>
        <div class="column">@@courseprerequisite</div>
    </div>
    <div class="row">
        <div class="column" id="left_col_1">Learning Outcomes :</div>
        <div class="column">@@learningoutcomes</div>
    </div>
</body>
</html>
