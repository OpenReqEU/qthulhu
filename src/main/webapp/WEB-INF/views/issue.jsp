<%--
  Created by IntelliJ IDEA.
  User: claramarielueders
  Date: 15.06.18
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
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
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        #issueLinkMap {
            width: 100%;
            height: 70%;
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
    <a href="https://openreq.eu/"><img alt="or_logo"
                                       src="images/or_logo.png"
                                       width="116px" height="30px"/></a>
    <a class="button-effect-orange" href="https://bugreports.qt.io/browse/">Qt's Jira</a>
    <a class="button-effect-orange" href="./">Go Back</a>
    <div class="search-container">
        <form action="./issue" method="post" id="search-id" name="search">
            <button type="submit"><i class="fa fa-search" style="color: #ffffff;"></i></button>
            <input type="text" name="issue" id="issueInput" required="required" placeholder="Issue Key..."
                   style="margin-right: 20px">
            <input type="number" name="depth" id="depthInput" min="1" max="5" placeholder="Depth..."
                   style="margin-right: 20px">
        </form>
    </div>
</div>

<div class="container-fluid" style="padding-left: 50px; padding-top: 30px">
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
            <div class="row">
                <%--Issue Link Map--%>
                <div class="card" id="issueLinkMap"></div>
                <br>
            </div>
            <br>
            <div class="row">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Legend</h5>
                        <p class="card-text">
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
                        <div class="box teal" style="display: inline-block;">
                        </div>
                        Proposed
                    </div>
                </div>
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
                       aria-controls="sd-tab" aria-selected="false" onclick="proposedLinks();">Link
                        Detection
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="cc-tab" data-toggle="tab" href="#cc-box" role="tab"
                       aria-controls="cc-tab" aria-selected="false" onclick="checkConsistency();">Consistency
                        Checker
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="filter-tab" data-toggle="tab" href="#filter-box" role="tab"
                       aria-controls="filter-tab" aria-selected="false" onclick="filterNodes();">Node
                        Filter
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
                    <p id="infoBoxIssueResolution"></p>
                    <p id="infoBoxIssueComponent"></p>
                    <p id="infoBoxIssueLabel"></p>
                    <p id="infoBoxIssueVersion"></p>
                    <p id="infoBoxIssueFix"></p>
                    <p id="infoBoxIssuePlatform"></p>
                    <p id="infoBoxIssueEnv"></p>
                    <div id="infoBoxIssueLink"></div>
                    <br>
                    <div id="infoBoxIssueLinkTestJIRA"></div>
                </div>
                <%--<div class="tab-pane fade show" id="list-box" role="tabpanel"--%>
                <%--aria-labelledby="list-tab">--%>
                <%--<h5>Issue List</h5>--%>
                <%--<p id="IssuesList"></p>--%>
                <%--</div>--%>
                <div class="tab-pane fade" id="sd-box" role="tabpanel" aria-labelledby="sd-tab">
                    <p id="proposedIssuesList"></p>
                </div>
                <div class="tab-pane fade" id="cc-box" role="tabpanel" aria-labelledby="cc-tab">
                    <p>Checks if the release plan of this issue link map is consistent.</p>
                    <p id="ccResult"></p>
                </div>
                <div class="tab-pane fade" id="filter-box" role="tabpanel" aria-labelledby="filter-tab">
                    <p>Only Nodes with one of the selected statuses will be displayed.</p>
                    <p><b>Work in progress... <br>proceed at your own risk</b></p>
                    <div class="filterOptions">
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Closed"/>
                                Closed
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="In Progress"/>
                                In Progress
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Open"/>
                                Open
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Reported"/>
                                Reported
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="To Do"/>
                                To Do
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Done"/>
                                Done
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Accepted"/>
                                Accepted
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Rejected"/>
                                Rejected
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Resolved"/>
                                Resolved
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Reopened"/>
                                Reopened
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Blocked"/>
                                Blocked
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Withdrawn"/>
                                Withdrawn
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Need More Info"/>
                                Need More Info
                            </label>
                        </span>
                        <span>
                            <label>
                                <input name="status" type="checkbox" checked="true" value="Waiting 3rd party"/>
                                Waiting 3rd party
                            </label>
                        </span>
                        <br>
                        <span>
                            <label>
                                <input type="checkbox" checked="true" onClick="toggle(this)" />
                                Toggle All
                            </label>
                        </span>
                        <input type="button" class="button search button-effect-teal" onclick="filterNodes()" value="Apply filter" />
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
    let currentIssue = '${issue}';
    let depth = '${depth}';
    let max_depth = '${maxDepth}';
    let nodeEdgeSet = '${nodeEdgeSet}';
    let nodeEdgeObject = JSON.parse(nodeEdgeSet);
    let helpNodeSet =[];
    let filteredNodes;
    let filterStatuses = [];

    //proposed View active boolean
    let proposedViewActive = false;
    //infoTab View active boolean
    let infoTabActive = true;
    //saves the Issue that links get proposed for
    let propLinksIssue;

    let nodeElements = [];
    let edgeElements = [];

    $(document).ready(function () {
        infoTab();
        //calculatePositions();
        nodes.add(depth0Nodes);
        nodes.add(depth1Nodes);
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
        //TODO test if correct calculation
        //console.log(getAngleByRelativePosition({x:0, y:0}, {x:240, y:120}));
    });

    //Help Functions

    //function to help find a specific item depending on its identifier
    function findElement(arr, propName, propValue) {
        for (let i = 0; i < arr.length; i++) {
            if (arr[i][propName] == propValue)
                return arr[i];
        }
    }

    function checkElement(arr, propName, propValue) {
        for (let i = 0; i < arr.length; i++) {
            if (arr[i][propName] == propValue)
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

    function getCheckedCheckboxesFor(checkboxName) {
        let checkboxes = document.querySelectorAll('input[name="' + checkboxName + '"]:checked'), values = [];
        Array.prototype.forEach.call(checkboxes, function(el) {
            values.push(el.value);
        });
        return values;
    }
    function toggle(source) {
        let checkboxes = document.getElementsByName('status');
        for(let i=0, n=checkboxes.length;i<n;i++) {
            checkboxes[i].checked = source.checked;
        }
    }

    function applyFilter(status) {
        return !filterStatuses.includes(status);
    }

    /**
     * arrange nodes in circles, with the currentIssue in the center
     */
    function calculatePositions() {
        // the one element with depth 0 is in the center
        depth0Nodes[0].x = 0;
        depth0Nodes[0].y = 0;
        depth0Nodes[0].fixed = true;
        // depth1Nodes is layer one and surrounds the center
        for(let i = 0; i < depth1Nodes.length; i++){
            let position = positionsDepthOne(depth1Nodes.length, i);
            depth1Nodes[i].x = position.x;
            depth1Nodes[i].y = position.y;
        }
    }

    function positionsDepthOne(maxElements, currentElement) {
        let point = {};
        let angle = 360/maxElements;
        let direction;
        // Ein Element wird unter dem currentIssue angezeigt
        if (maxElements === 1) {
            direction = getDirectionByAngle(180);
        }
        // Zwei Elemente werden nebeneinander unter dem currentIssue angezeigt
        else if(maxElements === 2){
                 direction = getDirectionByAngle(135 + 90 * currentElement);
        }
        // bei einer ungeraden Anzahl ist das erste Element direkt über dem currentIssue
        else if(maxElements % 2) {
            direction = getDirectionByAngle(angle * currentElement);
        }
        // gerade Anzahl:
        else {
            direction = getDirectionByAngle(45 + (angle * currentElement));
        }
        // 240 = radius : Erfahrungswert

        point.x = 240 * direction.x;
        point.y = 240 * direction.y;
        return point;
    }

    function positionsDepthTwo(maxElements, currentElement) {

    }

    function getDirectionByAngle(angle) {
        let direction = {};
        direction.x = -Math.sin(angle * (Math.PI/180));
        direction.y = -Math.cos(angle * (Math.PI/180));
        return direction;
    }

    function getAngleByRelativePosition (fromPoint, point) {
        let dx = point.x - fromPoint.x;
        let dy = point.y - fromPoint.y;
        return Math.atan2(dy, dx) * 180/Math.PI;
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
        'Resolved': 'green',
        'Closed': 'green',
        'Withdrawn': 'green',
        'Rejected': 'green',
        'Done': 'green',
        'Verified': 'green',
        'undefined': 'yellow'
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
            nodes.remove(depth2Nodes);
            nodes.remove(depth3Nodes);
            nodes.remove(depth4Nodes);
            nodes.remove(depth5Nodes);
            edges.remove(depth3Edges);
            edges.remove(depth4Edges);
            edges.remove(depth5Edges);
            edges.remove(depth2Edges);
        }
        updateDepthButtons();
    }

    function depth2() {
        let oldDepth = depth;
        depth = 2;
        if (oldDepth > depth) {
            nodes.remove(depth3Nodes);
            nodes.remove(depth4Nodes);
            nodes.remove(depth5Nodes);
            edges.remove(depth3Edges);
            edges.remove(depth4Edges);
            edges.remove(depth5Edges);
        }
        if (oldDepth < depth) {
            add2layer();
        }
        updateDepthButtons();
    }

    function depth3() {
        let oldDepth = depth;
        depth = 3;
        if (oldDepth > depth) {
            nodes.remove(depth4Nodes);
            nodes.remove(depth5Nodes);
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
        updateDepthButtons();
    }

    function depth4() {
        let oldDepth = depth;
        depth = 4;
        if (oldDepth > depth) {
            nodes.remove(depth5Nodes);
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
        updateDepthButtons();
    }

    function add5layer() {
        nodes.add(depth5Nodes);
        edges.add(depth5Edges)
    }

    function add4layer() {
        nodes.add(depth4Nodes);
        edges.add(depth4Edges);
    }

    function add3layer() {
        nodes.add(depth3Nodes);
        edges.add(depth3Edges);
    }

    function add2layer() {
        nodes.add(depth2Nodes);
        edges.add(depth2Edges);
    }

    let issueList = [];

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
            let nodehidden = v['layer'] > depth;
            let nodelabel = "";
            if (!(nodetype == null)) {
                nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n");
                if (nodename.toString().length > 20) {
                    nodelabel = nodelabel.concat(nodename.toString().substring(0, 20)).concat("...\n").concat(nodetype.toString());
                }
                else {
                    nodelabel = nodelabel.concat(nodename.toString().substring(0, 20)).concat("\n").concat(nodetype.toString());
                }
            }
            else
                nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n not specified");
            let nodetitle = "";
            nodetitle = nodetitle.concat(nodestatus).concat("\n, ").concat(noderesolution);
            depthLevelNodes.push({
                id: ID,
                font: {multi: true},
                label: nodelabel,
                group: nodegroup,
                shape: 'box',
                title: nodetitle,
                level: nodedepth,
                hidden: nodehidden
            });
            issueList.push({
                id: nodekey
            })
        });
        return depthLevelNodes;
    }

    function createDepthLevelEdges(nodeEdgeObject) {
        let depthLevelEdges = [];
        $.each(nodeEdgeObject, function (i, v) {
            let edgestatus = v['status'];
            let fromID = v['node_fromid'];
            let toID = v['node_toid'];
            let edgelabel = findProposed(v['status'], v['dependency_type']);
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

    let depth0Nodes = createDepthLevelNodes(nodeEdgeObject['0']['nodes']);
    let depth0Edges = createDepthLevelEdges(nodeEdgeObject['0']['edges']);
    let depth1Nodes = createDepthLevelNodes(nodeEdgeObject['1']['nodes']);
    let depth1Edges = createDepthLevelEdges(nodeEdgeObject['1']['edges']);
    let depth2Nodes = createDepthLevelNodes(nodeEdgeObject['2']['nodes']);
    let depth2Edges = createDepthLevelEdges(nodeEdgeObject['2']['edges']);
    let depth3Nodes = createDepthLevelNodes(nodeEdgeObject['3']['nodes']);
    let depth3Edges = createDepthLevelEdges(nodeEdgeObject['3']['edges']);
    let depth4Nodes = createDepthLevelNodes(nodeEdgeObject['4']['nodes']);
    let depth4Edges = createDepthLevelEdges(nodeEdgeObject['4']['edges']);
    let depth5Nodes = createDepthLevelNodes(nodeEdgeObject['5']['nodes']);
    let depth5Edges = createDepthLevelEdges(nodeEdgeObject['5']['edges']);
    let allNodes = depth0Nodes.concat(depth1Nodes).concat(depth2Nodes).concat(depth3Nodes).concat(depth4Nodes).concat(depth5Nodes);


    //create an array with nodes
    nodes = new vis.DataSet(nodeElements);
    // create an array with edges
    edges = new vis.DataSet(edgeElements);

    let linkDetectionResponse;

    let testFilter;
    function selectFilterTest(filter) {
        testFilter = filter;
    }
    function registerClick(elem) {
        if (elem.id.charAt(1) == 'r') {
            let btnid = "#" + elem.id;
            if ($(btnid).hasClass('reject')) {
                let otherbtnid = "#" + elem.id.charAt(0) + "a";
                if ($(otherbtnid).hasClass('accepted')) {
                    $(otherbtnid).removeClass('accepted');
                    $(otherbtnid).addClass('accept');
                }
                $(btnid).removeClass('reject');
                $(btnid).addClass('rejected');
                linkDetectionResponse[elem.id.charAt(0)] = "reject";
            }
            else {
                $(btnid).removeClass('rejected');
                $(btnid).addClass('reject');
                delete linkDetectionResponse[elem.id.charAt(0)];
            }
        }
        else {
            let selectid = elem.id.charAt(0) + "s";
            let selectedItem = document.getElementById(selectid).value;
            let btnid = "#" + elem.id;
            if ($(btnid).hasClass('accept')) {
                let otherbtnid = "#" + elem.id.charAt(0) + "r";
                if ($(otherbtnid).hasClass('rejected')) {
                    $(otherbtnid).removeClass('rejected');
                    $(otherbtnid).addClass('reject');
                }
                $(btnid).removeClass('accept');
                $(btnid).addClass('accepted');
                linkDetectionResponse[elem.id.charAt(0)] = selectedItem;
            }
            else {
                $(btnid).removeClass('accepted');
                $(btnid).addClass('accept');
                delete linkDetectionResponse[elem.id.charAt(0)];
            }
        }
    }

    function sendLinkData() {
        let updatedProposedLinksJSON =
            {
                dependencies: []
            };
        $.each(proposedNodesEdges['edges'], function (i, v) {
            let dep_type = v['dependency_type'];
            let fromid = v['fromid'];
            let toid = v['toid'];

            updatedProposedLinksJSON.dependencies.push({
                dependency_type: dep_type,
                fromid: fromid,
                toid: toid
            })
        });


        for (i = linkDetectionResponse.length - 1; i >= 0; i--) {
            if (linkDetectionResponse[i] != undefined) {
                if (linkDetectionResponse[i] != "reject") {
                    updatedProposedLinksJSON.dependencies[i].dependency_type = linkDetectionResponse[i];
                    updatedProposedLinksJSON.dependencies[i].status = "accepted"
                }
                else {
                    updatedProposedLinksJSON.dependencies[i].status = "rejected"
                }
                console.log(updatedProposedLinksJSON)
            }
            else {
                updatedProposedLinksJSON.dependencies.splice(i, 1);
                console.log(updatedProposedLinksJSON)

            }
            console.log(updatedProposedLinksJSON)
        }
        let updatedPropsedLinksResponse = JSON.stringify(updatedProposedLinksJSON);

        try {

            let xhr = new XMLHttpRequest();

            let url = "./sendUpdatedProposedLinks";
            xhr.open("POST", url, true);
            xhr.setRequestHeader("Content-Type", "plain/text");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    let string = xhr.responseText;
                    console.log(string);
                }
            };
            xhr.send(updatedPropsedLinksResponse);
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

                let url = "./milla/getTopProposedDependenciesOfRequirement?requirementId=" + currentIssue + "&maxResults=" + "5";

                xhr.open("GET", url, true);

                let issueInfo = findElement(nodeEdgeObject.nodes, "id", currentIssue);
                let level = issueInfo.depth + 1;

                xhr.onreadystatechange = function () {

                    if (xhr.readyState === 4 && xhr.status === 200) {

                        proposedNodesEdges = JSON.parse(xhr.responseText);
                        console.log(proposedNodesEdges);
                        //add nodes
                        $.each(proposedNodesEdges['nodes'], function (i, v) {
                            let ID = v['nodeid'];
                            let nodekey = v['id'];
                            let nodetype = v['requirement_type'];
                            let nodename = v['name'];
                            let nodestatus = v['status'];
                            let noderesolution = v['resolution'];
                            let nodehidden = v['layer'] > depth;
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
                            if (!checkNodesContains(ID)) {
                                proposedNodeElements.push({
                                        id: ID,
                                        label: nodelabel,
                                        group: "proposed",
                                        shape: 'box',
                                        title: nodetitle,
                                        level: level,
                                        hidden: nodehidden
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

                            if(!(checkNodesContains(fromID) && checkNodesContains(toID))){
                                proposedEdgeElements.push({
                                    from: fromID,
                                    to: toID,
                                    arrows: edgearrow,
                                    label: edgelabel,
                                    color: {color: '#172B4D', inherit: false},
                                    width: 2,
                                    dashes: true
                                });
                            }
                        });

                        numberOfProposedLinks = proposedEdgeElements.length;
                        linkDetectionResponse = Array(numberOfProposedLinks);

                        nodes.add(proposedNodeElements);
                        edges.add(proposedEdgeElements);

                        proposedViewActive = true;
                        if (proposedIssuesList.length === 0) {
                            document.getElementById('proposedIssuesList').innerHTML = "No proposed links for issue " + currentIssue + ".";
                        }
                        else {
                            stringList = " <h5>Proposed Links of " + currentIssue + "</h5>" +
                                "<table style='width: 100%'><tr>\n" +
                                "<th>Issue Key</th>" +
                                "<th>Link type</th>" +
                                "<th>Accept</th>" +
                                "<th>Reject</th>" +
                                "</tr>";
                            selectionList = '<div class="custom-select">';
                            acceptBtn = "<button class='button accept button-effect-teal-light' onclick=\"registerClick(this)\" id=";
                            rejectBtn = "<button class='button reject button-effect-orange-light' onclick=\"registerClick(this)\" id=";
                            for (i = 0; i < proposedIssuesList.length; i++) {
                                stringList = stringList + "<tr><td><a href='https://bugreports-test.qt.io/browse/" + proposedIssuesList[i].id + "' target='_blank'>" + proposedIssuesList[i].id + "</a></td><td>" + selectionList + "<select id=" + i + "s>" +
                                    "<option value='duplicate'>Duplicate</option>" +
                                    "<option value='similar'>Similar</option>" +
                                    "<option value='depends'>Dependency</option></select></div></td><td>" + acceptBtn + i + "a>&#x2713</button></td><td>" + rejectBtn + +i + "r>&#x2717</button></td></tr>";
                            }
                            stringList = stringList + "<td><button class='button button-effect-teal' onclick ='sendLinkData()'>Save</button></td><td></td><td></td><td></td></table>";
                            document.getElementById('proposedIssuesList').innerHTML = stringList;
                        }
                    }

                };
                xhr.send(null);

            } catch (err) {
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

        try {
            let xhr = new XMLHttpRequest();

            let url = "./milla/getConsistencyCheckForRequirement?requirementId=" + currentIssue;
            xhr.open("GET", url, true);

            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    //let jsonPart = xhr.responseText.substring(xhr.responseText.indexOf("{"));
                    //let notJSONResponse = xhr.responseText.substring(0,xhr.responseText.indexOf("Caas response:")-2);
                    let json = JSON.parse(xhr.responseText);
                    let releases = json.response[0].Releases;
                    let regsInReleases = "";
                    for (let i = 0; i < releases.length; i++) {
                        regsInReleases = regsInReleases + "<b>Release " + releases[i].Release + "</b><br>" + releases[i].RequirementsAssigned_msg + "<br>"
                    }
                    document.getElementById('ccResult').innerHTML = "<h5>Result:</h5>".concat(json.response[0].Consistent_msg).concat("<br>") + regsInReleases;
                }
            };

            xhr.send(null);
        }
        catch
            (err) {
            alert(err);
        }
    }

    function listTab() {
        stringList = "";
        for (i = 0; i < issueList.length; i++) {
            stringList = stringList + issueList[i].id + '<br>';
        }
        document.getElementById('IssuesList').innerHTML = stringList;
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

        //put the issues in the corressponding part of the website
        document.getElementById('infoBoxHeading').innerHTML = "".concat(currentIssue);
        document.getElementById('infoBoxIssueLink').innerHTML = '<a href=\"' + infoLink + '\" class=\"button jira button-effect-orange center\" target="_blank">View Issue in Qt JIRA</a>';
        document.getElementById('infoBoxIssueLinkTestJIRA').innerHTML = '<a href=\"' + infoLinkTestJIRA + '\" class=\"button jira button-effect-orange center\" target="_blank">View Issue in Qt Test JIRA</a>';
        document.getElementById('infoBoxIssueStatus').innerHTML = "<b>Status: </b>".concat(infoStatus);
        document.getElementById('infoBoxIssueSummary').innerHTML = "<b>Summary: </b>".concat(infoTitle);
        document.getElementById('infoBoxIssueResolution').innerHTML = "<b>Resolution: </b>".concat(infoResolution);
        document.getElementById('infoBoxIssueEnv').innerHTML = "<b>Environment: </b>".concat(infoEnvironment);
        document.getElementById('infoBoxIssueComponent').innerHTML = "<b>Component: </b>".concat(infoComponent);
        document.getElementById('infoBoxIssueLabel').innerHTML = "<b>Label: </b>".concat(infoLabel);
        document.getElementById('infoBoxIssueVersion').innerHTML = "<b>Version: </b>".concat(infoVersion);
        document.getElementById('infoBoxIssueFix').innerHTML = "<b>Fix Version: </b>".concat(infoFixVersion);
        document.getElementById('infoBoxIssuePlatform').innerHTML = "<b>Platform(s): </b>".concat(infoPlatform);
    }

    function filterNodes() {
        if (proposedViewActive) {
            nodes.remove(proposedNodeElements);
            edges.remove(proposedEdgeElements);
            proposedViewActive = false;
        }
        infoTabActive = false;

        filterStatuses = getCheckedCheckboxesFor('status');

        $.each(filteredNodes, function (i,v) {
            nodes.update({id: v.nodeid, hidden:false})
        });
        filteredNodes = [];
        $.each(nodeEdgeObject.nodes, function (i, v) {
            if (applyFilter(v.status)) {
                if(checkNodesContains(v.nodeid)){
                    nodes.update({id: v.nodeid, hidden:true});
                    filteredNodes.push(v);
                }
            }
        });
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
                    // },
                    // "yellow_layer_1": {
                    //     color: {background: '#FED153', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "green_layer_1": {
                    //     color: {background: '#27D638', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "blue_layer_1": {
                    //     color: {background: '#7A97BB', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "red_layer_1": {
                    //     color: {background: '#FF5E36', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "yellow_layer_2": {
                    //     color: {background: '#FED666', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "green_layer_2": {
                    //     color: {background: '#36DA46', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "blue_layer_2": {
                    //     color: {background: '#87A1C2', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "red_layer_2": {
                    //     color: {background: '#FF6D49', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "yellow_layer_3": {
                    //     color: {background: '#FEDC7A', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "green_layer_3": {
                    //     color: {background: '#47DD55', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "blue_layer_3": {
                    //     color: {background: '#94ABC9', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "red_layer_3": {
                    //     color: {background: '#FF7D5D', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "yellow_layer_4": {
                    //     color: {background: '#FEE18D', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "green_layer_4": {
                    //     color: {background: '#58E064', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "blue_layer_4": {
                    //     color: {background: '#A1B6CF', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "red_layer_4": {
                    //     color: {background: '#FF8D71', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "yellow_layer_5": {
                    //     color: {background: '#FFE6A1', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "green_layer_5": {
                    //     color: {background: '#68E374', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "blue_layer_5": {
                    //     color: {background: '#AEC0D6', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                    // },
                    // "red_layer_5": {
                    //     color: {background: '#FF9D84', border: '#172B4D'},
                    //     borderWidth: 2,
                    //     font: {color: 'black', multi: 'html'}
                },
                "proposed": {
                    color: {background: '#17b2ad', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                }
            },
            configure: {
                enabled: false,
                filter: "edges",
                showButton: true
            },
            //node design
            "nodes": {
                "font": {
                    "face": 'Lato'
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
            //physics, interaction
            "layout": {
                "hierarchical":
                    {
                        "enabled": true,
                        "nodeSpacing": 150,
                        "blockShifting": false,
                        "edgeMinimization": false,
                        "sortMethod": "directed"
                    },
                "randomSeed": 9
            },
            "interaction": {
                "multiselect": false,
                "navigationButtons": false
            },
            "physics": {
                "enabled": true,
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

        network.on("afterDrawing", function () {
            network.fit();
        });

        //interact with network
        //if a node is selected display information in infobox
        network.on("selectNode", function (params) {
            params.event = "[original event]";

            let node = nodes.get(params.nodes);
            let issueID = node[0].id;
            let issueNode = findElement(nodeEdgeObject.nodes, "nodeid", issueID);
            if(typeof issueNode !== 'undefined') {

                currentIssue = issueNode.id;
                if (infoTabActive) {
                    infoTab();
                }
                if(proposedViewActive)
                {
                    proposedLinks()
                }
            }
        });

        //doubleclicking searches for the clicked issue
        network.on("doubleClick", function (params) {
            params.event = "[original event]";
            let node = nodes.get(params.nodes);
            if(typeof node[0] !== "undefined") {
                let issueID = node[0].id;
                let issueNode = findElement(nodeEdgeObject.nodes, "nodeid", issueID);
                if (typeof issueNode !== 'undefined' && issueNode.id !== issue) {
                    let issueKey = issueNode.id;
                    $('#issueInput').val(issueKey);
                    $('#depthInput').val(depth);
                    //
                    document.forms["search-id"].submit();
                }
            }
        });
    });

    $(document).on("load")

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