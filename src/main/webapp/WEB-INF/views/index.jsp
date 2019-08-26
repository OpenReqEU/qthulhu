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
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-146396443-1"></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag('js', new Date());

        gtag('config', 'UA-146396443-1');
    </script>

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
    <%--<a target="_blank" href="https://forum.qt.io/">Qt Forum</a>--%>
    <%--<a target="_blank" href="https://forms.gle/GQQhym7obLEss3bCA">Feedback</a>--%>
    <a target="_blank" href="https://github.com/OpenReqEU/qthulhu/issues">Report a Bug</a>
</div>

<%--This is the main body of the site, it contains some explanation about the service and a search box--%>
<div class="container" style="padding-top: 30px">
    <div class="row">
        <h1>WP7 - Qt Trial</h1>
    </div>

    <%--    <form id = "your_form" onsubmit="yourFunction()">--%>
    <%--        <input type="text" name="keywords">--%>
    <%--        <input type="submit" value="Search">--%>
    <%--    </form>--%>

    <%--    function yourFunction(){--%>
    <%--    var action_src = "http://localhost/test/" + document.getElementsByName("keywords")[0].value;--%>
    <%--    var your_form = document.getElementById('your_form');--%>
    <%--    your_form.action = action_src ;--%>
    <%--    }--%>

    <div class="row">
        <form <%--action="./issue"--%> onsubmit="buildURL()" method="get" id="search-id" style="display:inline-block;">
            <fieldset>
                <div class="row">
                    <%--Issue Key Input--%>
                    <div class="col-4">
                        <h4>Issue Key(s):</h4>
                        <input type="text" name="issue" id="issue" required="required" width="200px"><br>
                        <i>
                            <small>Search for an issue key.<br>
                                For example: QTWB-30
                            </small>
                        </i>
                    </div>
                    <%--Layer Input--%>
                    <div class="col-4">
                        <h4>Depth:</h4>
                        <input type="number" name="depth" id="layerDepth" min="1" max="5" width="100px"><br>
                        <i>
                            <small>Enter a number between 1 and 5.<br>
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

            <%--
            <input type="button" class="button search button-effect-teal" onclick="testForCORS()" value="TEST" />
            <input type="button" class="button search button-effect-teal" onclick="getAndOpenAuthorizeAddress()" value="Authorize" />
            <input type="text" name="token" id="token-input" required="required" width="200px">
            <input type="button" class="button search button-effect-teal" onclick="verifyAuthorization()" value="Verify" />
            --%>

        </div>

    </div>
    <br>
    <%--Information about this web application--%>
    <div class="row">
        <div class="card">
            <div class="card-body">
                <h3 class="card-title">Info</h3>
                <p class="card-text">This prototype visualizes the link between issues in Qt's public Jira, it also
                    offers
                    one feature to find missing links in the Jira issues and one feature to check the consistency of a
                    fix version.<br>
                    Typing in an issue key from <a
                            href="https://bugreports.qt.io/secure/BrowseProjects.jspa?selectedCategory=all&selectedProjectType=software">Qt's
                        public JIRA</a> can show you its direct and indirect links to other issues.
                    If you select an issue in the visualisation, you will see some issue information on the right
                    side of the graph as well as a button which will redirect you to the JIRA page of that issue.
                </p>
                <h5 class="card-title">Filtering</h5>
                <p class="card-text">The visualized issues can be filtered depending on their status, type and priority.
                    Currently, the default filter does not show issues which are already closed.
                    Thus, some nodes might be orphaned with not appareant connection to the searched issue key. </p>
                <h5 class="card-title">Issue Key</h5>
                <p class="card-text">You can type in a single issue (f.e. <i>QTWB-30</i>).
                    The service will then look up the corresponding issue in University of Helsinki's service milla and
                    get the information about links and issues.</p>
                <h5 class="card-title">Depth</h5>
                <p class="card-text">This service can show you direct (depth 1) and indirect links (depth 2-5).
                    Depth 2 are the links of issues that are directly connected to the searched issue, depth 3 are the
                    links of issues of depth 2 and so on, up until depth 5.
                    If you do not specify a depth the default value is 1.
                    While viewing the issue link map you can switch between the different depths.
                </p>
                <h5 class="card-title">Link Detection</h5>
                <p class="card-text">Use the link detection to find issues which might be related to the currently
                    selected issue.</p>
                <h5 class="card-title">Consistency Checker</h5>
                <p class="card-text">The Consistency Checker verifies the viability of the release plan regarding the
                    issue
                    link map. For example if a feature is required by another one, it is not assigned to later
                    release.</p>
                <h4 class="card-title">We appreciate your feedback!</h4>
                <p class="card-text">
                    <%--Click <a target="_blank" href="https://docs.google.com/forms/d/e/1FAIpQLSf_hyBtBF8vdXA9S0Zaee9IMY2qwo86n23-fHURojWnA44AVQ/viewform">here</a>--%>
                    <%--if you would like give feedback to the services or visualizatiion:--%>
                    You can either leave a comment in the <a target="_blank" href="https://forum.qt.io/category/60/openreq-issue-link-map-tool">Qt Forum</a> or give feedback anonynoumsly in this
                    <a target="_blank" href="https://forms.gle/EG6fd6QyCMXt7DEW9">form</a>.<br>
                    Click <a target="_blank" href="https://github.com/OpenReqEU/qthulhu/issues">here</a> if you would
                    like to report a bug.
                    <br>
                    Click <a target="_blank" href="https://github.com/OpenReqEU/qthulhu">here</a> if you would like to
                    contribute.


                </p>
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

    function buildURL() {
        if (document.getElementById("issue").value !== "") {
            let url = "./issue/" + document.getElementById("issue").value;
            let search_form = document.getElementById("search-id");
            search_form.action = url;
        }
    }

    function getAndOpenAuthorizeAddress() {
        try {
            let xhr = new XMLHttpRequest();

            let url = "./authorize/getAddress";
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

            let url = "./authorize/verifyAuth";
            //let url = "https://bugreports-test.qt.io/rest/fisutankki/1/verifyJiraAuthorization";
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

    function testForCORS() {
        try {
            let xhr = new XMLHttpRequest();

            let url = "./milla/getConsistencyCheckForRequirement?requirementId=QTWB-30";

            xhr.open("GET", url, true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    alert("call successful");
                    console.log(xhr.responseText);
                    console.log(xhr);
                }
            };
            xhr.send(null);
        }
        catch
            (err) {
            alert(err);
        }
    }
</script>
</body>
</html>