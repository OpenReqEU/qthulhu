<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: claramarielueders
  Date: 15.06.18
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html" charset=ISO-8859-1">
    <title>WP7 - Qt Trial</title>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"
            integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css">
    <link rel="stylesheet" href="./css/style.css">
</head>
<%--This is the navigation bar located at the top, it contains a link to the project website--%>
<body>
<div class="topnav">
    <a href="https://openreq.eu/"><img alt="or_logo"
                                       src="images/or_logo.png"
                                       width="116px" height="30px"/></a>
    <a href="https://bugreports.qt.io/browse/">Qt's Jira</a>
</div>
<%--This is the main body of the site, it contains some explanation about the service and a search box--%>
<div class="container" style="padding-top: 30px">
    <div class="row">
        <h1>WP7 - Qt Trial</h1>
    </div>
    <div class="row">
        <form action="./issue" method="post" id="search-id" style="display:inline-block;">
            <fieldset>
                <div class="row">
                    <%--Issue Key Input--%>
                    <div class="col-4">
                        <h4>Issue Key(s):</h4>
                        <input type="text" name="issue" id="issue" required="required" width="200px"><br>
                        <i>
                            <small>You can search for single issue keys.<br>
                                For example: QTWB-30
                            </small>
                        </i>
                    </div>
                    <%--Layer Input--%>
                    <div class="col-4">
                        <h4>Depth:</h4>
                        <input type="number" name="depth" id="layerDepth" min="1" max="5" width="100px"><br>
                        <i>
                            <small>This number should be between 1 and 5.<br>
                                For example: 2
                            </small>
                        </i>
                    </div>
                    <%--Search Button--%>
                    <div class="col-2">
                        <br>
                        <%--This is needed to implement the add and remove layer functionality--%>
                        <input type="submit"
                               class="button search button-effect-teal"
                               value="Search">
                    </div>
                    <%--Loading indication--%>
                    <div class="col-2">
                        <br>
                        <div class="loader" id="loader"></div>
                    </div>
                </div>
            </fieldset>
        </form>
        <div>
            <input type="button" class="button search button-effect-teal" onclick="getAndOpenAuthorizeAddress()" value="Authorize" />
            <input type="text" name="token" id="token-input" required="required" width="200px">
            <input type="button" class="button search button-effect-teal" onclick="verifyAuthorization()" value="Verify" />
        </div>

    </div>
    <br>
    <%--Information about this web application--%>
    <div class="row">
        <div class="card">
            <div class="card-body">
                <h3 class="card-title">Info</h3>
                <p class="card-text">This tool visualizes the link map of issues.<br>
                    Typing in an issue key from <a
                            href="https://bugreports.qt.io/secure/BrowseProjects.jspa?selectedCategory=all&selectedProjectType=software">Qt's
                        public JIRA</a> can show you its direct and indirect links to other issues.
                    If you select an issue in the visualisation, you will see key information on the right
                    side of the graph as well as a button which will redirect you to the JIRA page of that issue.
                </p>
                <h5 class="card-title">Issue Key(s)</h5>
                <p class="card-text">You can type in a single issue (f.e. <i>QTWB-30</i>).
                    The service will then look up the corresponding issue in University of Helsinki's service milla and
                    get the information about links and issues.</p>
                <h5 class="card-title">Depth</h5>
                <p class="card-text">This service can show you direct (depth 1) and indirect links (depth 2-5).
                    Depth 2 are the links of issues that are directly connected to the searched issue, depth 3 are the
                    links of issues of depth 2 and so on, up until depth 5.
                    If you do not specify a depth the default value is 1.
                    While viewing the issue link map you can switch between the different depths.
                <form action="./example" method="post" id="example" style="display:inline-block;">
                    <%--This is needed to implement the add and remove layer functionality--%>
                    <input type="hidden" name="layerDepth" value="1"/>
                    <input type="hidden" name="issues" value="EX-3"/>
                    <input type="submit"
                           class="button search button-effect-teal"
                           value="See Example">
                </form>
                </p>
                <h5 class="card-title">Dependency Detection & Consistency Checker</h5>
                <p class="card-text">The microservices for Dependency Detection and Consistency Checker are currently
                    being implemented.</p>
                </p>
            </div>
        </div>
    </div>
</div>
<script>
    <%--If the search button is pressed a loading circle appears--%>
    $('#search-id').submit(function () {
        $('#loader').show();
    });


    function getAndOpenAuthorizeAddress() {
        try {
            let xhr = new XMLHttpRequest();

            let url = "./authorize/getAddress"
            //let url = "https://bugreports-test.qt.io/rest/fisutankki/1/getJiraAuthorizationAddress"
            xhr.open("GET", url, true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    let win = window.open(xhr.responseText, '_blank');
                    win.focus();
                }
            };
            xhr.send(null);
        }
        catch
            (err) {
            alert(err);
        }
    }

    function verifyAuthorization() {
        try {
            let token = document.getElementById('token-input').value;
            let xhr = new XMLHttpRequest();
            xhr.withCredentials = true;

            let url = "./authorize/verifyAuth"
            //let url = "https://bugreports-test.qt.io/rest/fisutankki/1/verifyJiraAuthorization"
            xhr.open("POST", url);
            xhr.setRequestHeader("Content-Type", "application/json");
            xhr.setRequestHeader("cache-control", "no-cache");

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert(xhr.responseText);
                }
            };

            xhr.send(token);
        }
        catch
            (err) {
            alert(err);
        }
    }
</script>
</body>
</html>