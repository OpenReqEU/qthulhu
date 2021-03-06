<%--
  Created by IntelliJ IDEA.
  User: claramarielueders
  Date: 15.06.18
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

    <title>WP7 - Qt Trial</title>
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>
    <script type="text/javascript"
            src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        #issueLinkMap {
            width: 100%;
            height: 100%;
        }

        input[type=number] {
            width: 100px;
        }

        input[type=text] {
            width: 150px;
        }
    </style>
</head>
<body>


<%--This is the navigation bar located at the top, it contains a link to the project website and a search box--%>
<div class="topnav">
    <a target="_blank" href="https://openreq.eu/"><img alt="or_logo"
                                                       src="../images/or_logo.png"
                                                       width="116px" height="30px"/></a>
    <a target="_blank" href="https://bugreports.qt.io/browse/">Qt's Jira</a>
    <%--<a target="_blank" href="https://forum.qt.io/">Qt Forum</a>--%>
    <%--<a target="_blank" href="https://forms.gle/GQQhym7obLEss3bCA">Feedback</a>--%>
    <a target="_blank" href="https://github.com/OpenReqEU/qthulhu/issues">Report a Bug</a>
    <a class="button-effect-orange" href="../">Return to Homepage</a>
    <div class="search-container">
        <form onsubmit="buildURL()" method="get" id="search-id" name="search">
            <button type="submit"><em class="fa fa-search" style="color: #ffffff;"></em></button>
            <input type="text" name="issue" id="issueInput" required="required" placeholder="Issue Key..."
                   style="margin-right: 20px">
            <input type="number" name="depth" id="depthInput" min="1" max="5" placeholder="Depth..."
                   style="margin-right: 20px">
        </form>
    </div>
</div>

<div class="container-fluid" style="padding-left: 50px; padding-top: 30px">
    <div class="row">
        <p>
            This is a prototype of the <a href="https://openreq.eu/"> OpenReq project</a>, please give feedback through
            the <a target="_blank" href="https://forum.qt.io/category/60/openreq-issue-link-map-tool"> Qt Forum </a> or
            this <a target="_blank" href="https://forms.gle/EG6fd6QyCMXt7DEW9"> anonynoums feedback form</a>.
        </p>
    </div>
    <%--Header and Loader--%>
    <div class="row">

        <div class="col-10">
            <h2>Issue Links of ${issue}</h2>
        </div>

        <div class="col-2">
            <div class="loader" id="loader"></div>
        </div>

    </div>
</div>

<div class="container-fluid" style="padding-left: 50px; padding-top: 30px">
    <%--Network--%>
    <div class="row">
        <div class="col-8">
            <div class="row">
                <div class="col-8">
                    <%--Depth buttons--%>
                    <button class="button layer button-effect-teal" onclick="depth1()" id="depth-1-btn"
                            style="margin-left: 2px;">Depth 1
                    </button>
                    <button class="button layer button-effect-teal" onclick="depth2()" id="depth-2-btn"
                            style="margin-left: 2px;">Depth 2
                    </button>
                    <button class="button layer button-effect-teal" onclick="depth3()" id="depth-3-btn"
                            style="margin-left: 2px;">Depth 3
                    </button>
                    <button class="button layer button-effect-teal" onclick="depth4()" id="depth-4-btn"
                            style="margin-left: 2px;">Depth 4
                    </button>
                    <button class="button layer button-effect-teal" onclick="depth5()" id="depth-5-btn"
                            style="margin-left: 2px;">Depth 5
                    </button>
                </div>
                <%--Legend--%>
                <div class="col-4">
                    <p>
                    <div class="box blue" style="display: inline-block;">
                    </div>
                    To-Do
                    <div class="box red" style="display: inline-block;">
                    </div>
                    Stuck
                    <div class="box yellow" style="display: inline-block;">
                    </div>
                    In Progress
                    <div class="box green" style="display: inline-block;">
                    </div>
                    Done
                    </p>
                </div>
            </div>
            <div class="row">
                <%--Issue Link Map--%>
                <div class="card" id="issueLinkMap"></div>
                <br>
            </div>
        </div>
        <%--Information--%>
        <div class="col-4">

            <%--Information buttons--%>
            <ul class="nav nav-tabs nav-fill mb-3" id="info-nav" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="info-tab" data-toggle="tab" href="#info-box" role="tab"
                       aria-controls="info-tab" aria-selected="true" onclick="infoTab();">Info
                    </a>
                </li>
                <%--<li class="nav-item">--%>
                <%--<a class="nav-link" id="list-tab" data-toggle="tab" href="#list-box" role="tab"--%>
                <%--aria-controls="list-tab" aria-selected="true" onclick="listTab();">List--%>
                <%--</a>--%>
                <%--</li>--%>
                <li class="nav-item">
                    <a class="nav-link" id="sd-tab" data-toggle="tab" href="#sd-box" role="tab"
                       aria-controls="sd-tab" aria-selected="false" onclick="proposedLinks();">Link Detection
                    </a>
                    <span class="tooltiptext">The Link Detection service finds similar or related items based on the textual fields. The accepted and rejected links are NOT written to Jira.</span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="cc-tab" data-toggle="tab" href="#cc-box" role="tab"
                       aria-controls="cc-tab" aria-selected="false" onclick="checkConsistency();">Consistency Checker
                    </a>
                    <span class="tooltiptext">The Consistency Checker verifies the viability of the release plan regarding the issue link map. <br>For example if a feature is required by another one, it is not assigned to later release.</span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="filter-tab" data-toggle="tab" href="#filter-box" role="tab"
                       aria-controls="filter-tab" aria-selected="false" onclick="filterNodesTab();">Node Filter
                    </a>
                </li>
            </ul>
            <%--Information box--%>
            <div class="tab-content" id="tabs-tabContent">
                <div class="tab-pane fade show active" id="info-box" role="tabpanel"
                     aria-labelledby="info-tab">
                    <h5 id="infoBoxHeading"></h5>
                    <p id="infoBoxIssueSummary"></p>
                    <p id="infoBoxIssueStatus"></p>
                    <p id="infoBoxIssuePrio"></p>
                    <p id="infoBoxIssueResolution"></p>
                    <p id="infoBoxIssueComponent"></p>
                    <p id="infoBoxIssueLabel"></p>
                    <p id="infoBoxIssueVersion"></p>
                    <p id="infoBoxIssueFix"></p>
                    <p id="infoBoxIssuePlatform"></p>
                    <p id="infoBoxIssueEnv"></p>
                    <div id="infoBoxIssueLink"></div>
                    <br>
                    <%--<div id="infoBoxIssueLinkTestJIRA"></div>--%>
                </div>
                <%--<div class="tab-pane fade show" id="list-box" role="tabpanel"--%>
                <%--aria-labelledby="list-tab">--%>
                <%--<h5>Issue List</h5>--%>
                <%--<p id="IssuesList"></p>--%>
                <%--</div>--%>
                <div class="tab-pane fade" id="sd-box" role="tabpanel" aria-labelledby="sd-tab">
                    <p id="ddResult"></p>
                    <p id="ddPending"></p>
                </div>
                <div class="tab-pane fade" id="cc-box" role="tabpanel" aria-labelledby="cc-tab">
                    <p id="ccResult"></p>
                    <button class="accordion" id="ccRelIncButton">Inconsistent releases</button>
                    <div class="panel"><p id="ccRelInc"></p></div>
                    <button class="accordion" id="ccReleasesButton">Releases</button>
                    <div class="panel"><p id="ccReleases"></p></div>
                </div>
                <div class="tab-pane fade" id="filter-box" role="tabpanel" aria-labelledby="filter-tab">
                    <p>Only issues with one of the selected statuses and types will be displayed.</p>
                    <div class="filterOptions">
                        <h5>Statuses:</h5>
                        <span style="color: #6D8DB5">
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" onClick="toggle(this)">
                                <strong>To-Do:</strong>
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" value="Open"/>
                                Open
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" value="Reported"/>
                                Reported
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" value="Accepted"/>
                                Accepted
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" value="Reopened"/>
                                Reopened
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" value="To Do"/>
                                To Do
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" value="Blocked"/>
                                Blocked
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" value="Need More Info"/>
                                Need More Info
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="ToDoStatus" type="checkbox" checked="checked" value="Waiting 3rd party"/>
                                Waiting 3rd party
                            </label>
                        </span>
                        <br>

                        <span style="color: #fecc3f">
                            <label>
                                <input name="ProgStatus" type="checkbox" checked="checked" value="In Progress">
                                <strong>In Progress</strong>
                            </label>
                        </span>
                        <br>

                        <span style="color: #24C533">
                            <label>
                                <input name="DoneStatus" type="checkbox" onClick="toggle(this)">
                                <strong>Done:</strong>
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="DoneStatus" type="checkbox" value="Closed"/>
                                Closed
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="DoneStatus" type="checkbox" value="Done"/>
                                Done
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="DoneStatus" type="checkbox" value="Rejected"/>
                                Rejected
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="DoneStatus" type="checkbox" value="Resolved"/>
                                Resolved
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="DoneStatus" type="checkbox" value="Withdrawn"/>
                                Withdrawn
                            </label>
                        </span>
                        <br>
                        <span>
                            <label>
                                <input name="Status" type="checkbox" checked="checked" value="confidential"/>
                                Confidential
                            </label>
                        </span>
                        <br>
                        <span>
                            <label>
                                <input onClick="toggleAll(this);" type="checkbox" checked="checked"/>
                                <strong> Toggle All Statuses </strong>
                            </label>
                        </span>
                        <h5>Types:</h5>
                        <span>
                            <label>
                                <input name="Type" type="checkbox" checked="checked" value="task"/>
                                Task
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Type" type="checkbox" checked="checked" value="bug"/>
                                Bug
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Type" type="checkbox" checked="checked" value="issue"/>
                                Issue
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Type" type="checkbox" checked="checked" value="epic"/>
                                Epic
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Type" type="checkbox" checked="checked" value="user_story"/>
                                User Story
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Type" type="checkbox" checked="checked" value="suggestion"/>
                                Suggestion
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Type" type="checkbox" checked="checked" value="not specified"/>
                                not specified
                            </label>
                        </span>
                        <br>
                        <span>
                            <label>
                                <input name="Type" onClick="toggle(this);" type="checkbox" checked="checked"/>
                                <strong> Toggle All Types </strong>
                            </label>
                        </span>
                        <br>
                        <h5>Priority:</h5>
                        <span>
                            <label>
                                <input name="Priority" type="checkbox" checked="checked" value="0"/>
                                <img src="../images/prio/0.png" width="20" height="20" alt="P0: Blocker"/>P0: Blocker
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Priority" type="checkbox" checked="checked" value="1"/>
                                <img src="../images/prio/1.png" width="20" height="20" alt="P1: Critical"/>P1: Critical
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Priority" type="checkbox" checked="checked" value="2"/>
                                <img src="../images/prio/2.png" width="20" height="20" alt="P2: Important"/>P2: Important
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Priority" type="checkbox" checked="checked" value="3"/>
                                <img src="../images/prio/3.png" width="20" height="20" alt="P3: Somewhat important"/>P3: Somewhat important
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Priority" type="checkbox" checked="checked" value="4"/>
                                <img src="../images/prio/4.png" width="20" height="20" alt="P4: Low"/>P4: Low
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Priority" type="checkbox" checked="checked" value="5"/>
                                <img src="../images/prio/5.png" width="20" height="20" alt="P5: Not important"/>P5: Not important
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="Priority" type="checkbox" checked="checked" value="7"/>
                                <img src="../images/prio/7.png" width="20" height="20" alt="Not evaluated"/>Not evaluated
                            </label>
                        </span>
                        <br>
                        <span>
                            <label>
                                <input name="Priority" onClick="toggle(this);" type="checkbox" checked="checked"/>
                                <strong> Toggle All Priorities </strong>
                            </label>
                        </span>
                        <br>
                        <input type="button" class="button search button-effect-teal" onclick="filterNodes()"
                               value="Apply filter"/>
                    </div>
                    <p id="filterOptions"></p>
                </div>
            </div>
        </div>
    </div>
</div>

    <script>
        $('#search-id').submit(function () {
            $('#loader').show();
        });

        //getting the data for the network and depth btn disabling
        let issue = '${issue}';
        let depth = '${depth}';
        let max_depth = '${maxDepth}';
        let nodeEdgeSet = '${nodeEdgeSet}';
        let nodeEdgeObject = JSON.parse(nodeEdgeSet);
        let currentIssue = nodeEdgeObject['0']['nodes']['0']['id'];

        let helpNodeSet = [];
        let filteredNodes = [];
        let filterArray = [];
        let distances = [];
        let deprDistance = 240;
        let maxNodesPerLayer;
        let priorityArray = ["P0: Blocker", "P1: Critical", "P2: Important", "P3: Somewhat important", "P4: Low", "P5: Not important", "", "Not Evaluated"];


        //proposed View active boolean
        let proposedViewActive = false;
        //has the Consistency Checker been called
        let consistencyChecked = false;
        //infoTab View active boolean
        let infoTabActive = true;
        //saves the Issue that links get proposed for
        let propLinksIssue;

        let nodeElements = [];
        let edgeElements = [];

        let acc = document.getElementsByClassName("accordion");

        for (let i = 0; i < acc.length; i++) {
            acc[i].addEventListener("click", function() {
                /* Toggle between adding and removing the "active" class,
                to highlight the button that controls the panel */
                this.classList.toggle("active");

                /* Toggle between hiding and showing the active panel */
                let panel = this.nextElementSibling;
                if (panel.style.display === "block") {
                    panel.style.display = "none";
                } else {
                    panel.style.display = "block";
                }
            });
        }

        $(document).ready(function () {
            infoTab();
            calculatePositions();
            nodes.add(allNodesArray[0]);
            nodes.add(allNodesArray[1]);
            edges.add(depth0Edges);
            edges.add(depth1Edges);
            updateDepthButtons();
            if (depth >= 2) {
                add2layer()
            }
            if (depth >= 3) {
                add3layer();
            }
            if (depth >= 4) {
                add4layer();
            }
            if (depth === 5) {
                add5layer();
            }
            filterNodes();
        });

        //Help Functions
        //builds URL for search form
        function buildURL() {
            let url = "../issue/" + document.getElementById("issueInput").value;
            let search_form = document.getElementById("search-id");
            search_form.action = url;
        }

        //function to help find a specific item depending on its identifier
        function findElement(arr, propName, propValue) {
            for (let i = 0; i < arr.length; i++) {
                if (arr[i][propName] === propValue)
                    return arr[i];
            }
        }

        function findInAllNodes(id) {
            let elem;
            for (let i = 0; i < allNodesArray.length; i++) {
                elem = findElement(allNodesArray[i], "id", id);
                if (typeof elem !== "undefined") {
                    return elem;
                }
            }
        }

        function getIndexInAll(id) {
            for (let i = 0; i <= 5; i++) {
                for (let j = 0; j < allNodesArray[i].length; j++) {
                    if (allNodesArray[i][j].id === id) {
                        return [i, j];
                    }
                }
            }
        }

        function checkElement(arr, propName, propValue) {
            for (let i = 0; i < arr.length; i++) {
                if (arr[i][propName] === propValue)
                    return true;
            }
            return false;
        }

        function checkNodesContains(id) {
            return (nodes.get(id) !== null);
        }

        //the type of a proposed link is proposed where as the type of an accepted link is smth like duplicates, similar, etc.
        function findProposed(status, type) {
            if (status === "proposed")
                return "proposed";
            else {
                return type;
            }
        }

        function getCheckedCheckboxes() {
            //let checkboxes = document.querySelectorAll('input[name="' + checkboxName + 'Status"]:checked'), values = [];
            let checkboxes = document.querySelectorAll(':checked'), values = [];
            Array.prototype.forEach.call(checkboxes, function (el) {
                values.push(el.value);
            });
            return values;
        }

        function toggle(source) {
            let checkboxes = document.getElementsByName(source.name);
            for (let i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = source.checked;
            }
        }

        function toggleAll(source) {
            let types = ["ToDoStatus", "ProgStatus", "StuckStatus", "DoneStatus", "Status"];
            for (let i = 0; i < types.length; i++) {
                toggle({name: types[i], checked: source.checked});
            }
        }

        function isFiltered(status, type, priority) {
            return !(filterArray.includes(status) && filterArray.includes(type) && filterArray.includes(priority));
        }

        /**
         * arrange nodes in circles, with the currentIssue in the center
         */
        function calculatePositions() {
            if (typeof allNodesArray[0][0] !== "undefined") {
                distances[0] = 0;
                deprDistance = 240;
                if (allNodesArray[1].length > 12) {
                    deprDistance *= Math.sqrt(allNodesArray[1].length / 12);
                }
                maxNodesPerLayer = 1;
                // the one element with depth 0 is in the center
                allNodesArray[0][0].x = 0;
                allNodesArray[0][0].y = 0;
                allNodesArray[0][0].angle = 0;
                allNodesArray[0][0].fixed = true;
                allNodesArray[0][0].heightConstraint = 60;
                allNodesArray[0][0].widthConstraint = 135;
                allNodesArray[0][0].font = {multi: true, size: 24};
                // allNodesArray[1] is layer one and surrounds the center
                for (let i = 0; i < allNodesArray[1].length; i++) {
                    positionsDepthOne(allNodesArray[1].length, i);
                }
                for (let i = 2; i <= max_depth; i++) {
                    positionsOuterRings(i);
                }
            }
        }

        function positionsDepthOne(maxElements, currentElement) {
            let angle = 360 / maxElements;
            let direction;
            let resultingAngle;
            maxNodesPerLayer = Math.max(maxNodesPerLayer, allNodesArray[1].length);
            // increasing the radius by 16 roughly increases circumference by 100
            distances[1] = Math.max(allNodesArray[1].length * 16, 240);

            // if depth 1 has only one element it will be displayed below the center
            if (maxElements === 1) {
                direction = getDirectionByAngle(0);
                resultingAngle = 0;
            }
            // if there are two elements they will be displayed next to each other below the center
            else if (maxElements === 2) {
                direction = getDirectionByAngle(-45 + 90 * currentElement);
                resultingAngle = -45 + 90 * currentElement;
            }
            // if the amount of nodes is odd the first element is displayed above the center and the rest in a circle around the center
            else if (maxElements % 2) {
                direction = getDirectionByAngle(180 + (angle * currentElement));
                resultingAngle = 180 + angle * currentElement;
            }
            // even amount: first element on the top right, rest circle around center
            else {
                direction = getDirectionByAngle(45 + (angle * currentElement));
                resultingAngle = 45 + angle * currentElement;
            }
            // allNodesArray[1][currentElement].x = distances[1] * direction.x;
            // allNodesArray[1][currentElement].y = distances[1] * direction.y;

            allNodesArray[1][currentElement].x = deprDistance * direction.x;
            allNodesArray[1][currentElement].y = deprDistance * direction.y;
            allNodesArray[1][currentElement].angle = resultingAngle;
        }

        function positionsOuterRings(depth) {
            let connectionsOut = [];
            let index;
            let direction;
            let angleDiff;

            // increasing the radius by 16 roughly increases circumference by 100
            distances[depth] = Math.max(allNodesArray[depth].length * 16, distances[depth - 1] + 240);

            maxNodesPerLayer = Math.max(maxNodesPerLayer, allNodesArray[depth].length);

            for (let i = 0; i < allNodesArray[depth - 1].length; i++) {
                connectionsOut = findConnectedNodesOuter(allNodesArray[depth - 1][i]);
                allNodesArray[depth - 1][i].connections = connectionsOut;
                for (let j = 0; j < connectionsOut.length; j++) {
                    index = getIndexInAll(connectionsOut[j]);
                    angleDiff = Math.min(15, 360 / allNodesArray[depth].length);
                    angleDiff *= Math.ceil(j / 2);

                    if (j % 2) { // j == odd
                        angleDiff *= -1;
                    }
                    direction = getDirectionByAngle(allNodesArray[depth - 1][i].angle + angleDiff);

                    // allNodesArray[index[0]][index[1]].x = distances[depth]  * direction.x;
                    // allNodesArray[index[0]][index[1]].y = distances[depth] * direction.y;

                    allNodesArray[index[0]][index[1]].x = deprDistance * depth * direction.x;
                    allNodesArray[index[0]][index[1]].y = deprDistance * depth * direction.y;
                    allNodesArray[index[0]][index[1]].angle = allNodesArray[depth - 1][i].angle + angleDiff;
                }
            }
        }

        //calculates positions for proposed issues if the selected issue is in layer 0
        function calculateProposedDepthOnePositions(j, maxElements) {
            let angle = 360 / maxElements;
            let direction;

            // if depth 1 has only one element it will be displayed below the center
            if (maxElements === 1) {
                direction = getDirectionByAngle(0);
            }
            // if there are two elements they will be displayed next to each other below the center
            else if (maxElements === 2) {
                direction = getDirectionByAngle(-45 + 90 * j);
            }
            // if the amount of nodes is odd the first element is displayed above the center and the rest in a circle around the center
            else if (maxElements % 2) {
                direction = getDirectionByAngle(180 + (angle * j));
            }
            // even amount: first element on the top right, rest circle around center
            else {
                direction = getDirectionByAngle(45 + (angle * j));
            }
            let coord_x = 0.6 * distances[1] * direction.x;
            let coord_y = 0.6 * distances[1] * direction.y;
            return {x: coord_x, y: coord_y};
        }

        //calculates positions for proposed issues if the selected issue is not layer 0
        function calculateProposedOuterPositions(issueInfo, j) {
            let index = getIndexInAll(issueInfo.nodeid);
            let angleDiff = Math.min(15, 360 / proposedNodesEdges['nodes'].length);
            angleDiff *= Math.ceil(j / 2);
            if (j % 2) { // j == odd
                angleDiff *= -1;
            }
            j++;
            let direction = getDirectionByAngle(allNodesArray[index[0]][index[1]].angle + angleDiff);

            let coord_x = (distances[issueInfo.depth] + 120) * direction.x;
            let coord_y = (distances[issueInfo.depth] + 120) * direction.y;
            return {x: coord_x, y: coord_y};
        }

        function getDirectionByAngle(angle) {
            let direction = {};
            direction.x = Math.sin(angle * (Math.PI / 180));
            direction.y = Math.cos(angle * (Math.PI / 180));
            return direction;
        }

        function getAngleByRelativePosition(fromPoint, point) {
            let dx = point.x - fromPoint.x;
            let dy = point.y - fromPoint.y;
            return Math.atan2(dx, dy) * 180 / Math.PI;
        }

        function findConnectedNodesOuter(paraElem) {
            let connections = findConnectedNodes(paraElem.id);
            let result = [];
            let elem;
            for (let i = 0; i < connections.length; i++) {
                elem = findInAllNodes(connections[i]);
                if ((typeof elem !== "undefined") && (paraElem.level === elem.level - 1)) {
                    result.push(elem.id)
                }
            }
            return result;
        }

        function findConnectedNodes(id) {
            let result = [];
            for (let i = 0; i < allEdges[0].length; i++) {
                if ((id === allEdges[0][i].from) && !result.includes(allEdges[0][i].to)) {
                    result.push(allEdges[0][i].to);
                }
                if ((id === allEdges[0][i].to) && !result.includes(allEdges[0][i].from)) {
                    result.push(allEdges[0][i].from);
                }
            }
            return result;
        }

        //Palettes

        //color map for status according to bucketing in Kanban board
        //Open blue, Blocked red, In Progress yellow, Done green
        let colorPaletteStatus = {
            'Open': 'blue',
            'Reopened': 'blue',
            'Accepted': 'blue',
            'Reported': 'blue',
            'To-Do': 'blue',
            'Blocked': 'red',
            'On hold': 'red',
            'Need more info': 'red',
            'Waiting 3rd party': 'red',
            'In Progress': 'yellow',
            'Implemented': 'yellow',
            'undefined': 'yellow',
            'Resolved': 'green',
            'Closed': 'green',
            'Withdrawn': 'green',
            'Rejected': 'green',
            'Done': 'green',
            'Verified': 'green'
        };
        //map to create the correct type of error, links like duplicates do not have a direction
        let arrowPaletteType = {
            'contributes': 'to',
            'damages': 'to',
            'refines': 'to', //work breakdown, test
            'requires': 'to', //dependency
            'incompatible': '',
            'decomposition': 'to', //sub-task, epic
            'similar': '', //relates
            'duplicates': '', //duplicate
            'replaces': 'to' //replaces
        };
        //map to visually differentiate between accepted and proposed links
        let edgeStatusPalette = {
            'accepted': false,
            'proposed': true
        };

        //disables the layer buttons if the depth would be smaller than 1 or bigger than 5
        function updateDepthButtons() {
            if (1 > max_depth) {
                $("#depth-1-btn").prop("disabled", true);
            } else {
                $("#depth-1-btn").removeAttr('disabled');
            }
            if (2 > max_depth) {
                $("#depth-2-btn").prop("disabled", true);
            } else {
                $("#depth-2-btn").removeAttr('disabled');
            }
            if (3 > max_depth) {
                $("#depth-3-btn").prop("disabled", true);
            } else {
                $("#depth-3-btn").removeAttr('disabled');
            }
            if (4 > max_depth) {
                $("#depth-4-btn").prop("disabled", true);
            } else {
                $("#depth-4-btn").removeAttr('disabled');
            }
            if (5 > max_depth) {
                $("#depth-5-btn").prop("disabled", true);
            } else {
                $("#depth-5-btn").removeAttr('disabled');
            }
            if (1 == depth) {
                $("#depth-1-btn").attr("class", "button layer button-effect-teal active");
            } else {
                $("#depth-1-btn").attr('class', "button layer button-effect-teal");
            }
            if (2 == depth) {
                $("#depth-2-btn").attr("class", "button layer button-effect-teal active");
            } else {
                $("#depth-2-btn").attr('class', "button layer button-effect-teal");
            }
            if (3 == depth) {
                $("#depth-3-btn").attr("class", "button layer button-effect-teal active");
            } else {
                $("#depth-3-btn").attr('class', "button layer button-effect-teal");
            }
            if (4 == depth) {
                $("#depth-4-btn").attr("class", "button layer button-effect-teal active");
            } else {
                $("#depth-4-btn").attr('class', "button layer button-effect-teal");
            }
            if (5 == depth) {
                $("#depth-5-btn").attr("class", "button layer button-effect-teal active");
            } else {
                $("#depth-5-btn").attr('class', "button layer button-effect-teal");
            }
        }

        function depth1() {
            let oldDepth = depth;
            depth = 1;
            if (oldDepth > depth) {
                nodes.remove(allNodesArray[2]);
                nodes.remove(allNodesArray[3]);
                nodes.remove(allNodesArray[4]);
                nodes.remove(allNodesArray[5]);
                edges.remove(depth3Edges);
                edges.remove(depth4Edges);
                edges.remove(depth5Edges);
                edges.remove(depth2Edges);
            }
            // network.fit();
            updateDepthButtons();
        }

        function depth2() {
            let oldDepth = depth;
            depth = 2;
            if (oldDepth > depth) {
                nodes.remove(allNodesArray[3]);
                nodes.remove(allNodesArray[4]);
                nodes.remove(allNodesArray[5]);
                edges.remove(depth3Edges);
                edges.remove(depth4Edges);
                edges.remove(depth5Edges);
            }
            if (oldDepth < depth) {
                add2layer();
            }
            // network.fit();
            updateDepthButtons();
        }

        function depth3() {
            let oldDepth = depth;
            depth = 3;
            if (oldDepth > depth) {
                nodes.remove(allNodesArray[4]);
                nodes.remove(allNodesArray[5]);
                edges.remove(depth4Edges);
                edges.remove(depth5Edges);
            }
            if (oldDepth == 1) {
                add2layer();
                add3layer();
            }
            if (oldDepth == 2) {
                add3layer();
            }
            // network.fit();
            updateDepthButtons();
        }

        function depth4() {
            let oldDepth = depth;
            depth = 4;
            if (oldDepth > depth) {
                nodes.remove(allNodesArray[5]);
                edges.remove(depth5Edges);
            }
            if (oldDepth == 1) {
                add2layer();
                add3layer();
                add4layer();
            }
            if (oldDepth == 2) {
                add3layer();
                add4layer();
            }
            if (oldDepth == 3) {
                add4layer();
            }
            // network.fit();
            updateDepthButtons();
        }

        function depth5() {
            let oldDepth = depth;
            depth = 5;
            if (oldDepth == 1) {
                add2layer();
                add3layer();
                add4layer();
                add5layer();
            }
            if (oldDepth == 2) {
                add3layer();
                add4layer();
                add5layer();
            }
            if (oldDepth == 3) {
                add4layer();
                add5layer();
            }
            if (oldDepth == 4) {
                add5layer();
            }
            // network.fit();
            updateDepthButtons();
        }

        function add5layer() {
            nodes.add(allNodesArray[5]);
            edges.add(depth5Edges)
        }

        function add4layer() {
            nodes.add(allNodesArray[4]);
            edges.add(depth4Edges);
        }

        function add3layer() {
            nodes.add(allNodesArray[3]);
            edges.add(depth3Edges);
        }

        function add2layer() {
            nodes.add(allNodesArray[2]);
            edges.add(depth2Edges);
        }


        function createDepthLevelNodes(nodeEdgeObject) {
            let depthLevelNodes = [];
            $.each(nodeEdgeObject, function (i, v) {
                helpNodeSet.push(v);
                let nodedepth = v['depth'];
                let ID = v['nodeid'];
                let nodekey = v['id'];
                let nodetype = v['requirement_type'];
                let nodename = v['name'];
                let nodestatus = v['status'];
                let noderesolution = v['resolution'];
                let nodegroup = colorPaletteStatus[nodestatus];
                let nodesize = 25;
                if (nodedepth == 0) {
                    nodesize = 40;
                }
                let nodehidden = v['layer'] > depth;
                let nodelabel = "";
                let nodeprio = v['priority'].toString();
                if (v['priority'] === 6) {
                    nodeprio = "5";
                }
                if (typeof nodetype === "undefined") {
                    nodetype = "not specified"
                }
                if (!(nodetype == null)) {
                    nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n").concat(nodetype.toString());
                    nodelabel = nodelabel.concat("\n").concat(nodestatus).concat(", ").concat(noderesolution);
                }
                else
                    nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n not specified");
                let nodetitle = "";
                if (nodename.toString().length > 20) {
                    nodetitle = nodetitle.concat(nodename.toString().substring(0, 20)).concat("...\n");
                }
                else {
                    nodetitle = nodetitle.concat(nodename.toString().substring(0, 20)).concat("\n")
                }
                //blub

                depthLevelNodes.push({
                    id: ID,
                    font: {multi: true},
                    label: nodelabel,
                    group: nodegroup,
                    shape: 'box',
                    title: nodetitle,
                    level: nodedepth,
                    status: nodestatus,
                    resolution: noderesolution,
                    hidden: nodehidden,
                    type: nodetype,
                    priority: nodeprio,
                    size: nodesize
                });
            });
            return depthLevelNodes;
        }

        function createDepthLevelEdges(nodeEdgeObject) {
            let depthLevelEdges = [];
            $.each(nodeEdgeObject, function (i, v) {
                let edgestatus = v['status'];
                let fromID = v['node_fromid'];
                let toID = v['node_toid'];
                let edgelabel = "";
                if (typeof v['description'] === "undefined") {
                    edgelabel = findProposed(v['status'], v['dependency_type']);
                } else {
                    edgelabel = findProposed(v['status'], v['description']['0']);
                }
                let edgearrow = arrowPaletteType[edgelabel];
                let edgedashes = edgeStatusPalette[edgestatus];
                depth0Edges.push({
                    from: fromID,
                    to: toID,
                    arrows: edgearrow,
                    label: edgelabel,
                    color: {color: '#172B4D', inherit: false},
                    width: 2,
                    dashes: edgedashes
                });
            });
            return depthLevelEdges;
        }

        let allNodesArray = [];
        allNodesArray[0] = createDepthLevelNodes(nodeEdgeObject['0']['nodes']);
        let depth0Edges = createDepthLevelEdges(nodeEdgeObject['0']['edges']);
        allNodesArray[1] = createDepthLevelNodes(nodeEdgeObject['1']['nodes']);
        let depth1Edges = createDepthLevelEdges(nodeEdgeObject['1']['edges']);
        allNodesArray[2] = createDepthLevelNodes(nodeEdgeObject['2']['nodes']);
        let depth2Edges = createDepthLevelEdges(nodeEdgeObject['2']['edges']);
        allNodesArray[3] = createDepthLevelNodes(nodeEdgeObject['3']['nodes']);
        let depth3Edges = createDepthLevelEdges(nodeEdgeObject['3']['edges']);
        allNodesArray[4] = createDepthLevelNodes(nodeEdgeObject['4']['nodes']);
        let depth4Edges = createDepthLevelEdges(nodeEdgeObject['4']['edges']);
        allNodesArray[5] = createDepthLevelNodes(nodeEdgeObject['5']['nodes']);
        let depth5Edges = createDepthLevelEdges(nodeEdgeObject['5']['edges']);
        //let allNodes = allNodesArray[0].concat(allNodesArray[1]).concat(allNodesArray[2]).concat(allNodesArray[3]).concat(allNodesArray[4]).concat(allNodesArray[5]);

        let allEdges = [depth0Edges, depth1Edges, depth2Edges, depth3Edges, depth4Edges, depth5Edges];


        //create an array with nodes
        nodes = new vis.DataSet(nodeElements);
        // create an array with edges
        edges = new vis.DataSet(edgeElements);

        let linkDetectionResponse;

        let testFilter;

        function selectFilterTest(filter) {
            testFilter = filter;
        }

        let proposedIssueOrderLDR = [];

        function registerClick(elem) {
            if (elem.id.charAt(1) === 'r') {
                let btnid = "#" + elem.id;
                if ($(btnid).hasClass('reject')) {
                    let otherbtnid = "#" + elem.id.charAt(0) + "a" + elem.id.substring(2);
                    if ($(otherbtnid).hasClass('accepted')) {
                        $(otherbtnid).removeClass('accepted');
                        $(otherbtnid).addClass('accept');
                    }
                    $(btnid).removeClass('reject');
                    $(btnid).addClass('rejected');
                    linkDetectionResponse[elem.id.charAt(0)] = "reject";
                    proposedIssueOrderLDR[elem.id.charAt(0)] = elem.id.substring(2);
                }
                else {
                    $(btnid).removeClass('rejected');
                    $(btnid).addClass('reject');
                    delete linkDetectionResponse[elem.id.charAt(0)];
                    delete proposedIssueOrderLDR[elem.id.charAt(0)];
                }
            }
            else {
                let selectid = elem.id.charAt(0) + "s";
                let selectedItem = document.getElementById(selectid).value;
                let btnid = "#" + elem.id;
                if ($(btnid).hasClass('accept')) {
                    let otherbtnid = "#" + elem.id.charAt(0) + "r" + elem.id.substring(2);
                    if ($(otherbtnid).hasClass('rejected')) {
                        $(otherbtnid).removeClass('rejected');
                        $(otherbtnid).addClass('reject');
                    }
                    $(btnid).removeClass('accept');
                    $(btnid).addClass('accepted');
                    linkDetectionResponse[elem.id.charAt(0)] = selectedItem;
                    proposedIssueOrderLDR[elem.id.charAt(0)] = elem.id.substring(2);
                }
                else {
                    $(btnid).removeClass('accepted');
                    $(btnid).addClass('accept');
                    delete linkDetectionResponse[elem.id.charAt(0)];
                    delete proposedIssueOrderLDR[elem.id.charAt(0)];
                }
            }
        }

        function sendLinkData() {
            let updatedProposedLinksJSON =
                {
                    dependencies: []
                };
            let currentProjectId = currentIssue.substring(0, currentIssue.indexOf("-"));
            let projectsToUpdate = [];

            $.each(proposedNodesEdges['edges'], function (i, v) {
                let dep_type = v['dependency_type'].toUpperCase(); //when the type is not overwritten the standard is "similar". The API doesn't accept lowercase input
                let fromid = v['fromid'];
                let toid = v['toid'];
                let id = v['id'];
                let created_at = v['created_at'];
                let dep_score = v['dependency_score'];
                let description = v['description'];


                updatedProposedLinksJSON.dependencies.push({
                    created_at: created_at,
                    dependency_score: dep_score,
                    dependency_type: dep_type,
                    description: description,
                    fromid: fromid,
                    id: id,
                    status: "PROPOSED",
                    toid: toid,
                });

                // $('#issueInput').val(issueKey);
                // $('#depthInput').val(depth);
                // //
                // document.forms["search-id"].submit();
            });

            for (let i = linkDetectionResponse.length - 1; i >= 0; i--) {
                //saves the projectIDs to update those later
                let fromID = updatedProposedLinksJSON.dependencies[i].fromid;
                let toID = updatedProposedLinksJSON.dependencies[i].toid;
                let fromProject = fromID.substring(0, fromID.indexOf("-"));
                let toProject = toID.substring(0, toID.indexOf("-"));


                let index = Math.max(proposedIssueOrderLDR.indexOf(fromID), proposedIssueOrderLDR.indexOf(toID));
                if (index !== -1) {
                    if (linkDetectionResponse[index] !== undefined) {
                        if (linkDetectionResponse[index] !== "reject") {
                            updatedProposedLinksJSON.dependencies[i].dependency_type = linkDetectionResponse[index].toUpperCase();
                            updatedProposedLinksJSON.dependencies[i].status = "ACCEPTED";
                            updatedProposedLinksJSON.dependencies[i].description[0] = linkDetectionResponse[index];

                            //this will safe all projects that need to be updated
                            if (fromProject === currentProjectId)
                            {
                                if (projectsToUpdate.indexOf(toProject) === -1)
                                {
                                    projectsToUpdate.push(toProject);
                                }
                            }
                            else if (toProject === currentProjectId)
                            {
                                if (projectsToUpdate.indexOf(fromProject) === -1)
                                {
                                    projectsToUpdate.push(fromProject);
                                }
                            }
                        }
                        else {
                            updatedProposedLinksJSON.dependencies[i].status = "REJECTED";

                            //this will safe all projects that need to be updated
                            if (fromProject === currentProjectId)
                            {
                                if (projectsToUpdate.indexOf(toProject) === -1)
                                {
                                    projectsToUpdate.push(toProject);
                                }
                            }
                            else if (toProject === currentProjectId)
                            {
                                if (projectsToUpdate.indexOf(fromProject) === -1)
                                {
                                    projectsToUpdate.push(fromProject);
                                }
                            }
                        }
                    }
                    else {
                        updatedProposedLinksJSON.dependencies.splice(i, 1);
                    }
                }
            }
            let updatedProposedLinksResponse = JSON.stringify(updatedProposedLinksJSON);

            try {

                let xhr = new XMLHttpRequest();
                // let url = "../milla/updateProposedDependencies";
                let url = "https://api.openreq.eu/milla/updateProposedDependencies";
                xhr.open("POST", url, true);
                xhr.setRequestHeader("Content-Type", "application/json");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        let response = xhr.responseText;
                        console.log(response);
                        if (projectsToUpdate.includes("QTBUG"))
                        {
                            document.getElementById("ddPending").innerHTML += "<br><br>QTBUG is the largest project and will take a while to update. This can take up to 2 minutes. Thank you for your patience.";
                        }
                        for (let count = 0; count < projectsToUpdate.length; count++)
                        {
                            sendProjectToMulperi(projectsToUpdate[count]);
                        }
                    }
                };
                // takes only the array out of the JSON
                //{ dependencies : [...] }  => [...]
                updatedProposedLinksResponse = updatedProposedLinksResponse.substring(updatedProposedLinksResponse.indexOf(":") + 1, updatedProposedLinksResponse.length - 1);
                xhr.send(updatedProposedLinksResponse);
                document.getElementById("ddPending").innerHTML = "Your request is being processed.<br>The updated page will reload afterwards."
            }
            catch
                (err) {
                alert(err);
            }
        }

        let proposedNodeElements = [];
        let proposedEdgeElements = [];
        let proposedNodesEdges = [];
        let proposedIssuesList = [];
        let numberOfProposedLinks = 0;

        function sendProjectToMulperi(projectID) {
            try {
                let xhr = new XMLHttpRequest();
                let url = "https://api.openreq.eu/milla/sendProjectToMulperi?projectId=" + projectID;
                //let url = "http://localhost:9203/sendProjectToMulperi?projectId=" + projectID;
                xhr.open("POST", url, true);
                xhr.setRequestHeader("Content-Type", "application/json");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200)
                    {
                        console.log(projectID + " done");
                        document.getElementById("ddPending").innerHTML = "The page will now reload.<br>If you have time to read this please reload the page manually.";
                        location.reload();
                    }
                };
                xhr.send("");
            }
            catch
                (err) {
                alert(err);
            }
        }

        //Similarity detection functionality
        //Showing and removing proposed issues
        function proposedLinks() {
            infoTabActive = false;
            if (propLinksIssue !== currentIssue || !proposedViewActive) {
                propLinksIssue = currentIssue;

                try {
                    nodes.remove(proposedNodeElements);
                    edges.remove(proposedEdgeElements);

                    proposedNodeElements = [];
                    proposedEdgeElements = [];
                    proposedNodesEdges = [];
                    proposedIssuesList = [];


                    let xhr = new XMLHttpRequest();

                    let url = "../milla/getTopProposedDependenciesOfRequirement?requirementId=" + currentIssue + "&maxResults=" + "5";

                    xhr.open("GET", url, true);

                    document.getElementById('ddResult').innerHTML = "pending...";
                    let issueInfo = findElement(nodeEdgeObject.nodes, "id", currentIssue);
                    let level = issueInfo.depth + 1;

                    xhr.onreadystatechange = function () {

                        if (xhr.readyState === 4 && xhr.status === 200) {

                            proposedNodesEdges = JSON.parse(xhr.responseText);
                            //add nodes
                            let j = 0;
                            $.each(proposedNodesEdges['nodes'], function (i, v) {
                                let ID = v['nodeid'];
                                let nodekey = v['id'];
                                let nodetype = v['requirement_type'];
                                let nodename = v['name'];
                                let nodestatus = v['status'];
                                let noderesolution = v['resolution'];
                                let nodehidden = v['layer'] > depth;
                                let nodegroup = colorPaletteStatus[nodestatus] || "unknown";
                                let nodelabel = "";
                                if (nodetype !== null) {
                                    nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n");

                                    if (nodename.toString().length > 20) {
                                        nodelabel = nodelabel.concat(nodename.toString().substring(0, 20)).concat("...\n").concat(nodetype.toString());
                                    }
                                    else {
                                        nodelabel = nodelabel.concat(nodename.toString().substring(0, 20)).concat("\n").concat(nodetype.toString());
                                    }
                                }
                                else {
                                    nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n not specified");
                                }
                                let nodetitle = "";
                                nodetitle = nodetitle.concat(nodestatus).concat("\n, ").concat(noderesolution);

                                //calculate positions for the proposed issue
                                let positions;
                                if (issue === propLinksIssue) {
                                    positions = calculateProposedDepthOnePositions(j, proposedNodesEdges['nodes'].length);
                                } else {
                                    positions = calculateProposedOuterPositions(issueInfo, j);
                                }
                                j++;
                                if (!checkNodesContains(ID)) {
                                    proposedNodeElements.push({
                                        id: ID,
                                        label: nodelabel,
                                        group: nodegroup,
                                        shape: 'ellipse',
                                        title: nodetitle,
                                        level: level,
                                        hidden: nodehidden,
                                        x: positions.x,
                                        y: positions.y
                                    });
                                    proposedIssuesList.push({
                                        id: nodekey
                                    })
                                }
                            });

                            //add edges
                            $.each(proposedNodesEdges['edges'], function (i, v) {
                                let edgestatus = v['status'];
                                let fromID = v['node_fromid'];
                                let toID = v['node_toid'];
                                let edgelabel = findProposed(v['status'], v['dependency_type']);
                                let edgearrow = arrowPaletteType[edgelabel];

                                if (!(checkNodesContains(fromID) && checkNodesContains(toID))) {
                                    proposedEdgeElements.push({
                                        from: fromID,
                                        to: toID,
                                        arrows: edgearrow,
                                        label: "proposed",
                                        color: {color: '#172B4D', inherit: false},
                                        width: 2,
                                        dashes: true
                                    });
                                }

                                // console.log(proposedNodesEdges)
                            });

                            numberOfProposedLinks = proposedEdgeElements.length;
                            linkDetectionResponse = Array(numberOfProposedLinks);

                            nodes.add(proposedNodeElements);
                            edges.add(proposedEdgeElements);

                            proposedViewActive = true;
                            if (proposedIssuesList.length === 0) {
                                document.getElementById('ddResult').innerHTML = "No proposed links for issue " + currentIssue + ".";
                            }
                            else {
                                let stringList = " <h5>Proposed Links of " + currentIssue + "</h5>" +
                                    "<table style='width: 100%'><tr>\n" +
                                    "<th>Issue Key</th>" +
                                    "<th>Link type</th>" +
                                    "<th>Accept</th>" +
                                    "<th>Reject</th>" +
                                    "</tr>";
                                let selectionList = '<div class="custom-select">';
                                let acceptBtn = "<button class='button accept button-effect-teal-light' role='radio' onclick=\"registerClick(this)\" id=";
                                let rejectBtn = "<button class='button reject button-effect-orange-light' role='radio' onclick=\"registerClick(this)\" id=";
                                for (let i = 0; i < proposedIssuesList.length; i++) {
                                    stringList = stringList + "<tr><td><a href='https://bugreports-test.qt.io/browse/" + proposedIssuesList[i].id + "' target='_blank'>" + proposedIssuesList[i].id + "</a></td><td>" + selectionList + "<select id=" + i + "s>" +
                                        "<option value='REQUIRES'>dependency</option>" +
                                        "<option value='DUPLICATES'>duplicate</option>" +
                                        "<option value='DECOMPOSITION'>epic</option>" +
                                        "<option value='CONTRIBUTES'>relates</option>" +
                                        "<option value='REPLACES'>replacement</option>" +
                                        "<option value='DECOMPOSITION'>subtask</option>" +
                                        "<option value='REFINES'>work breakdown</option>" +
                                        "</select></div></td><td>"
                                        + acceptBtn + i + "a" + proposedIssuesList[i].id + ">&#x2713</button></td><td>"
                                        + rejectBtn + i + "r" + proposedIssuesList[i].id + ">&#x2717</button></td></tr>";
                                }
                                stringList = stringList + "<td><button class='button button-effect-teal' onclick ='sendLinkData()'>Save</button></td><td></td><td></td><td></td></table>";
                                document.getElementById('ddResult').innerHTML = stringList;

                                // console.log(proposedNodesEdges)
                            }
                        }

                    };
                    xhr.send(null);

                } catch (err) {
                    document.getElementById('ddResult').innerHTML = "We are sorry, there was an error getting the proposed dependencies...";
                    alert(err);
                }
            }
        }

        function checkConsistency() {
            if (proposedViewActive) {
                nodes.remove(proposedNodeElements);
                edges.remove(proposedEdgeElements);
                proposedViewActive = false;
            }
            infoTabActive = false;

            if (!consistencyChecked)
            {
                try
                {
                    let xhr = new XMLHttpRequest();

                    let url = "../milla/getConsistencyCheckForRequirement?requirementId=" + issue;
                    xhr.open("GET", url, true);

                    document.getElementById('ccResult').innerHTML = "Pending...";
                    document.getElementById('ccRelIncButton').innerHTML = "Inconsistent links are being calculated...";
                    document.getElementById('ccReleasesButton').innerHTML = "Searching for releases in link map...";
                    xhr.onreadystatechange = function ()
                    {
                        if (xhr.readyState === 4 && xhr.status === 200)
                        {
                            let json = JSON.parse(xhr.responseText);

                            console.log(json);

                            let releases = json.response[0].Releases;
                            let regsInReleases = "";
                            for (let i = 0; i < releases.length; i++)
                            {
                                regsInReleases = regsInReleases + "<strong>Release " + releases[i].Release + "</strong><br>" + releases[i].RequirementsAssigned_msg + "<br>"
                            }
                            let ccMessage = "";
                            let relList = "";

                            if (json.response[0].Consistent_msg == "Release plan contains errors")
                            {
                                ccMessage = ccMessage.concat("<h5><font color=\"#d83d04\">Release plan is inconsistent.</font></h5>");
                                let relInc = json.response[0].RelationshipsInconsistent;
                                relList = relList +
                                    "<table style='width: 100%'><tr>\n" +
                                    "<th>Issue Keys</th>" +
                                    "<th>Link type</th>" +
                                    "</tr>";
                                for (let i = 0; i < relInc.length; i++)
                                {
                                    relList = relList + "<tr><td>" + relInc[i].To + ", " + relInc[i].From + "</a></td><td>" + relInc[i].Type + "</td></tr>";
                                }
                                relList = relList + "</table>";
                                document.getElementById('ccRelInc').innerHTML = relList;
                                document.getElementById('ccRelIncButton').innerHTML = "Inconsistent items";
                            }
                            else
                            {
                                ccMessage = ccMessage.concat("<h5><font color=\"#138f8b\">Release plan is consistent.</font></h5>");
                                document.getElementById("ccRelInc").style.display = "none";
                                document.getElementById("ccRelIncButton").style.display = "none"
                            }

                            document.getElementById('ccResult').innerHTML = "<br>".concat(ccMessage).concat("<br>");
                            document.getElementById('ccReleases').innerHTML = "<br>".concat(regsInReleases).concat("<br>");
                            document.getElementById('ccReleasesButton').innerHTML = "Releases found";

                            consistencyChecked = true;
                        }
                    };

                    xhr.send(null);
                }
                catch (err)
                {
                    alert(err);
                    document.getElementById('ccResult').innerHTML = "there was an error...";
                }
            }
        }


        function infoTab() {

            infoTabActive = true;

            if (proposedViewActive) {
                nodes.remove(proposedNodeElements);
                edges.remove(proposedEdgeElements);
                proposedViewActive = false;
            }
            //display the initial infobox only if the user put exactly one issue in the input
            //get coressponding JSON
            let issueInfo = findElement(helpNodeSet, "id", currentIssue);
            //get information that should be displayed
            let infoLink = "https://bugreports.qt.io/browse/" + currentIssue;
            let infoLinkTestJIRA = "https://bugreports-test.qt.io/browse/" + currentIssue;
            let infoTitle = issueInfo.name;
            //let infoType = issueInfo.requirement_type;
            let infoStatus = issueInfo.status;
            //let infoDescription = issueInfo.issueDescription;
            let infoResolution = issueInfo.resolution;
            let infoEnvironment = issueInfo.environment;
            let infoComponent = issueInfo.components;
            let infoLabel = issueInfo.labels;
            let infoVersion = issueInfo.versions;
            let infoPlatform = issueInfo.platforms;
            let infoFixVersion = issueInfo.fixversion;
            let infoPriority = priorityArray[issueInfo.priority];

            //put the issues in the corressponding part of the website
            document.getElementById('infoBoxHeading').innerHTML = "".concat(currentIssue);
            document.getElementById('infoBoxIssueLink').innerHTML = '<a href=\"' + infoLink + '\" class=\"button jira button-effect-orange center\" target="_blank">View Issue in Qt JIRA</a>';
            //document.getElementById('infoBoxIssueLinkTestJIRA').innerHTML = '<a href=\"' + infoLinkTestJIRA + '\" class=\"button jira button-effect-orange center\" target="_blank">View Issue in Qt Test JIRA</a>';
            document.getElementById('infoBoxIssueStatus').innerHTML = "<strong>Status: </strong>".concat(infoStatus);
            document.getElementById('infoBoxIssueSummary').innerHTML = "<strong>Summary: </strong>".concat(infoTitle);
            document.getElementById('infoBoxIssueResolution').innerHTML = "<strong>Resolution: </strong>".concat(infoResolution);
            document.getElementById('infoBoxIssueEnv').innerHTML = "<strong>Environment: </strong>".concat(infoEnvironment);
            document.getElementById('infoBoxIssueComponent').innerHTML = "<strong>Component: </strong>".concat(infoComponent);
            document.getElementById('infoBoxIssueLabel').innerHTML = "<strong>Label: </strong>".concat(infoLabel);
            document.getElementById('infoBoxIssueVersion').innerHTML = "<strong>Version: </strong>".concat(infoVersion);
            document.getElementById('infoBoxIssueFix').innerHTML = "<strong>Fix Version: </strong>".concat(infoFixVersion);
            document.getElementById('infoBoxIssuePlatform').innerHTML = "<strong>Platform(s): </strong>".concat(infoPlatform);
            document.getElementById('infoBoxIssuePrio').innerHTML = '<strong>Priority:  </strong><img src="../images/prio/' + issueInfo.priority + '.png" width="20" height="20" align="middle"/>'.concat(" ").concat(infoPriority);
        }

        function filterNodesTab() {
            if (proposedViewActive) {
                nodes.remove(proposedNodeElements);
                edges.remove(proposedEdgeElements);
                proposedViewActive = false;
            }
            infoTabActive = false;

            filterNodes();
        }

        function filterNodes() {
            filterArray = getCheckedCheckboxes();

            $.each(filteredNodes, function (i, v) {
                allNodesArray[v.level].push(v);
            });
            filteredNodes = [];
            for (let j = 0; j < 6; j++) {
                for (let i = 0; i < allNodesArray[j].length; i++) {
                    // if the current node has a status that should not be shown it will be
                    // spliced out of allNodesArray and pushed into filteredNodes
                    if (isFiltered(allNodesArray[j][i].status, allNodesArray[j][i].type, allNodesArray[j][i].priority) && allNodesArray[j][i].level !== 0) {
                        filteredNodes.push(allNodesArray[j].splice(i, 1)[0]);
                        i--;
                    }
                }
            }
            // after splicing all filtered nodes out of allNodesArray calculate position will create a circle out of the remaining nodes
            calculatePositions();
            // nodes is cleared
            nodes.clear();
            // and refilled with the correct nodes
            for (let i = 0; i <= depth; i++) {
                nodes.add(allNodesArray[i]);
            }
        }

        // Create the network after the page is loaded and the network containing div is rendered
        $(document).ready(function () {
            // create a network
            let networkContainer = document.getElementById('issueLinkMap');
            // provide the data in the vis format
            let data = {
                nodes: nodes,
                edges: edges
            };

            //specify options such as physics
            let options = {
                //size of the network
                // autoResize: true,
                // height: '1000px',
                // width: '80%',
                //specify the different groups
                //TODO: There must be an easier way to create these groups
                "groups": {
                    "yellow": {
                        color: {background: '#FECC3F', border: '#172B4D'},
                        borderWidth: 2,
                        font: {color: 'black', multi: 'html'}
                    },
                    "green": {
                        color: {background: '#36DA46', border: '#172B4D'},
                        borderWidth: 2,
                        font: {color: 'black', multi: 'html'}
                    },
                    "blue": {
                        color: {background: '#87A1C2', border: '#172B4D'},
                        borderWidth: 2,
                        font: {color: 'black', multi: 'html'}
                    },
                    "red": {
                        color: {background: '#FF5E36', border: '#172B4D'},
                        borderWidth: 2,
                        font: {color: 'black', multi: 'html'}
                    },
                    "unknown": {
                        color: {background: '#aaa', border: '#172B4D'},
                        borderWidth: 2,
                        font: {color: 'black', multi: 'html'}
                    }
                },
                //node design
                "nodes": {
                    "font": {
                        "face": 'Arial'
                    },
                    "margin": {
                        "top": 10,
                        "right": 10,
                        "bottom": 10,
                        "left": 10
                    },
                    "title": "HTML"
                },
                //edge design
                "edges": {
                    "font": {
                        "face": 'Lato',
                        "align": 'bottom'
                    },
                    "smooth": {
                        "type": "curvedCW",
                        "forceDirection": "none",
                        "roundness": 0   // This is max roundness
                    }
                },
                "interaction": {
                    "multiselect": false,
                    "navigationButtons": true
                },
                "physics": {
                    "enabled": false,
                    'forceAtlas2Based': {
                        'gravitationalConstant': 26,
                        'centralGravity': 0.005,
                        'springLength': 230,
                        'springConstant': 0.18,
                        'avoidOverlap': 10
                    },
                    'maxVelocity': 146,
                    'solver': 'forceAtlas2Based',
                    'timestep': 0.35,
                    'stabilization': {
                        'enabled': true,
                        "iterations": 1000,
                        "updateInterval": 25
                        // "minVelocity": 50,
                        // // "repulsion": {
                        // //     "nodeDistance": 150
                        // // },
                        // "barnesHut":
                        //     {
                        //         "avoidOverlap": 1
                        //     },
                        // "stabilization": {
                        //     "enabled": true,
                        //     "iterations": 50, // maximum number of iteration to stabilize
                        //     "updateInterval": 1,
                        //     "onlyDynamicEdges": false,
                        //     "fit": true
                    }
                }
            };
            //initialize network
            let network = new vis.Network(networkContainer, data, options);

            network.on("stabilizationIterationsDone", function () {
                network.setOptions({physics: false});
            });

            // network.on("afterDrawing", function () {
            //     network.fit();
            // });

            //interact with network
            //if a node is selected display information in infobox
            network.on("selectNode", function (params) {
                params.event = "[original event]";

                let node = nodes.get(params.nodes);
                let issueID = node[0].id;
                let issueNode = findElement(nodeEdgeObject.nodes, "nodeid", issueID);
                if (typeof issueNode !== 'undefined') {

                    currentIssue = issueNode.id;
                    if (infoTabActive) {
                        infoTab();
                    }
                    if (proposedViewActive) {
                        proposedLinks()
                    }
                }
            });

            //doubleclicking searches for the clicked issue
            network.on("doubleClick", function (params) {
                params.event = "[original event]";
                let node = nodes.get(params.nodes);
                if (typeof node[0] !== "undefined") {
                    let issueID = node[0].id;
                    let issueNode = findElement(nodeEdgeObject.nodes, "nodeid", issueID);
                    if (typeof issueNode !== 'undefined' && issueNode.id !== issue) {
                        let issueKey = issueNode.id;
                        $('#issueInput').val(issueKey);
                        $('#depthInput').val(depth);
                        //
                        buildURL();
                        document.forms["search-id"].submit();
                    }
                }
            });
        });

        $(document).on("load");

        function resizeCanvas() {
            $('#issueLinkMap').height($(document).height() * 0.70)
        }

        $(document).ready(function () {
            $(window).resize(function () {
                resizeCanvas();
            });
        });

        resizeCanvas();


        //    ######GRAVEYARD & INFORMATION######
        //    LINKS in Qt and OpenReq JSON
        //         'CONTRIBUTES'
        //         'DAMAGES'
        //         'REFINES'        work breakdown, test
        //         'REQUIRES'       dependency
        //         'INCOMPATIBLE'
        //         'DECOMPOSITION'  sub-task, epic
        //         'SIMILAR'        relates
        //         'DUPLICATES'     duplicate
        //         'REPLACES'       replaces
    </script>
</body>
</html>