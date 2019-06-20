<%--
  Created by IntelliJ IDEA.
  User: claramarielueders
  Date: 31.07.18
  Time: 09:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>WP7 - Qt trial</title>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
            integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<style>
    input[type=number] {
        width: 100px;
    }

    input[type=text] {
        width: 150px;
    }
</style>

<body>
<%--This is the navigation bar located at the top, it contains a link to the project website and a search box--%>
<div class="topnav">
    <a href="https://openreq.eu/"><img alt="or_logo"
                                       src="images/or_logo.png"
                                       width="116px" height="30px"/></a>
    <a href="https://bugreports.qt.io/browse/">Qt's Jira</a>
    <a href="./">Go Back</a>
    <%-- <div class="search-container">
        <form action="./issue" method="post" id="search-id" name="search">
            <button type="submit"><i class="fa fa-search" style="color: #ffffff;"></i></button>
            <div class="loader" id="loader-search"></div>
            <input type="text" name="issues" id="issueInput" required="required" placeholder="Issue Key..."
                   style="margin-right: 20px">
            <input type="number" name="depth" id="depthInput" min="1" max="5" placeholder="Depth..."
                   style="margin-right: 20px">
        </form>
    </div> --%>
</div>

<%--This is the main body of the error page, it is fairly simple--%>
<div class="container" style="padding-left: 50px; padding-top: 50px">
    <div class="row">
        <div class="col-8">
            <h1>Sorry, I could not find the page you were looking for.</h1>
            <h3>Searched issue key (${issue}) does not exist or access to it is limited, please check that you wrote the issue key correctly.</h3>
            <h3>Thank you.</h3>
            <a href="./" class="button back button-effect-orange">&#171 Go to Main Page</a>
        </div>
        <div class="col-4">
<pre>
 ,---.
( @ @ )
 ).-.(
'/|||\`
  '|`
</pre>

        </div>
    </div>
</div>
</body>
</html>