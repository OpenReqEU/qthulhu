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
    <title>WP7 Qt Trial</title>
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
                                       src="../images/or_logo.png"
                                       width="116px" height="30px"/></a>
    <a href="https://bugreports.qt.io/browse/">Qt's Jira</a>
    <a href="/">Go Back</a>
    <div class="search-container">
        <form action="/issue" method="post" id="search-id" name="search">
            <button type="submit"><i class="fa fa-search" style="color: #ffffff;"></i></button>
            <input type="text" name="issues" id="issueInput" required="required" placeholder="Issue Key(s)..."
                   style="margin-right: 20px">
            <input type="number" name="layerDepth" id="layerInput" min="1" max="5" placeholder="Layer(s)..."
                   style="margin-right: 20px">
            <input type="hidden" name="layerChange" id="changeInput" value="0"/>
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
                <form action="/example" method="post" id="depth-1" style="display: inline-block">
                    <input type="hidden" name="issues" value="${issue}"/>
                    <input type="hidden" name="layerDepth" value="1"/>
                    <input type="submit" class="button layer button-effect-teal" id="depth-1-btn"
                           value="Depth 1">
                </form>
                <form action="/example" method="post" id="depth-2" style="display: inline-block">
                    <input type="hidden" name="issues" value="${issue}"/>
                    <input type="hidden" name="layerDepth" value="2"/>
                    <input type="submit" class="button layer button-effect-teal" id="depth-2-btn"
                           value="Depth 2">
                </form>
                <form action="/example" method="post" id="depth-3" style="display: inline-block">
                    <input type="hidden" name="issues" value="${issue}"/>
                    <input type="hidden" name="layerDepth" value="3"/>
                    <input type="submit" class="button layer button-effect-teal" id="depth-3-btn"
                           value="Depth 3">
                </form>
                <form action="/example" method="post" id="depth-4" style="display: inline-block">
                    <input type="hidden" name="issues" value="${issue}"/>
                    <input type="hidden" name="layerDepth" value="4"/>
                    <input type="submit" class="button layer button-effect-teal" id="depth-4-btn"
                           value="Depth 4">
                </form>
                <form action="/example" method="post" id="depth-5">
                    <input type="hidden" name="issues" value="${issue}"/>
                    <input type="hidden" name="layerDepth" value="5"/>
                    <input type="submit" class="button layer button-effect-teal" id="depth-5-btn"
                           value="Depth 5">
                </form>
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
                            To-Do
                        </div>
                        <div class="box red" style="display: inline-block;">
                            Stuck
                        </div>
                        <div class="box yellow" style="display: inline-block;">
                            In Progress
                        </div>
                        <div class="box green" style="display: inline-block;">
                            Done
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%--Information--%>
        <div class="col-4">

            <%--Information buttons--%>
            <ul class="nav nav-pills nav-fill mb-3" id="info-nav" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="info-tab" data-toggle="pill" href="#info-box" role="tab"
                       aria-controls="info-tab" aria-selected="true" onclick="infoTab();">Info
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="list-tab" data-toggle="pill" href="#list-box" role="tab"
                       aria-controls="list-tab" aria-selected="true" onclick="listTab();">List
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="sd-tab" data-toggle="pill" href="#sd-box" role="tab"
                       aria-controls="sd-tab" aria-selected="false" onclick="proposedLinks();">Link
                        Detection
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="cc-tab" data-toggle="pill" href="#cc-box" role="tab"
                       aria-controls="cc-tab" aria-selected="false" onclick="checkConsistency();">Consistency
                        Checker
                    </a>
                </li>
            </ul>
            <%--Information box--%>
            <div class="tab-content" id="pills-tabContent">
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
                <div class="tab-pane fade show" id="list-box" role="tabpanel"
                     aria-labelledby="list-tab">
                    <h5>Issue List</h5>
                    <p id="IssuesList"></p>
                </div>
                <div class="tab-pane fade" id="sd-box" role="tabpanel" aria-labelledby="sd-tab">
                    <h5>Proposed Links
                    </h5>
                    <p id="proposedIssuesList"></p>
                </div>
                <div class="tab-pane fade" id="cc-box" role="tabpanel" aria-labelledby="cc-tab">
                    <h5>Result</h5>
                    <p id="ccResult"></p>
                    <h5>Diagnosis</h5>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    // Get the modal
    var ccmodal = document.getElementById('CCModal');

    // Get the button that opens the modal
    var ccbtn = document.getElementById("CCBtn");

    // Get the <span> element that closes the modal
    var ccspan = document.getElementById("ccspan");

    // When the user clicks on the button, open the modal
    ccbtn.onclick = function () {
        ccmodal.style.display = "block";
    };
    // When the user clicks on <span> (x), close the modal
    ccspan.onclick = function () {
        ccmodal.style.display = "none";
    };

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == ccmodal) {
            ccmodal.style.display = "none";
        }
    };

    //Display loading circle when a request is submitted
    $('#add-layer').submit(function () {
        $('#loader').show();
    });

    $('#remove-layer').submit(function () {
        $('#loader').show();
    });

    $('#search-id').submit(function () {
        $('#loader').show();
    });

    //getting the data for the network and layer disabling
    var issue = '${issue}';
    var depth = '${layerDepth}';
    //console.log("LAYER DEPTH:" + depth);
    var max_depth = '${maxLayer}';
    //console.log("MAX DEPTH:" + max_depth);
    var nodeEdgeSet = '${nodeEdgeSet}';
    var nodeEdgeObject = JSON.parse(nodeEdgeSet);
    var issueArray = issue.replace(/ /g, "").split(",");

    //disables the layer buttons if the depth would be smaller than 1 or bigger than 5
    //TODO: make it visible that these buttons are disabled by greying them out

    //Remove-Layer Button
    $(document).ready(function () {
        //console.log("RMV LAYER DEPTH:" + depth);
        if (depth <= 1) {
            $("#remove-btn").prop("disabled", true);
        } else {
            $("#remove-btn").removeAttr('disabled');

        }
    });

    //Add-Layer Button
    $(document).ready(function () {
        //console.log("ADD LAYER DEPTH:" + depth);
        if (depth >= max_depth) {
            $("#add-btn").prop("disabled", true);
        } else {
            $("#add-btn").removeAttr('disabled');
        }
    });

    //function to help find a specific item depending on its identifier
    function findElement(arr, propName, propValue) {
        for (var i = 0; i < arr.length; i++)
            if (arr[i][propName] == propValue)
                return arr[i];
    }

    //display the initial infobox only if the user put exactly one issue in the input
    if (issueArray.length == 1) {
        //get coressponding JSON
        let issueInfo = findElement(nodeEdgeObject.nodes, "id", issue);

        //get information that should be displayed
        let infoLink = "https://bugreports.qt.io/browse/" + issue;
        let infoLinkTestJIRA = "https://bugreports-test.qt.io/browse/" + issue;
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
        document.getElementById('infoBoxHeading').innerHTML = "".concat(issue);
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

    //if the user searched for multiple issues, hide the infobox until an issue is selected
    else {
        $(".infobox").css("display", "none");
    }

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

    // Create the network after the page is loaded and the network containing div is rendered
    $(document).ready(function () {
        let edgeElements = [];
        let nodeElements = [];

        //add nodes
        $.each(nodeEdgeObject['nodes'], function (i, v) {
            let ID = v['nodeid'];
            let nodekey = v['id'];
            let nodetype = v['requirement_type'];
            //TODO: Add first 20 characters of title to box beneath id (QTPROJECT_XXX)
            //let nodename = v['name'];
            let nodestatus = v['status'];
            let nodelayer = v['layer'];
            let noderesolution = v['resolution'];
            let nodegroup = colorPaletteStatus[nodestatus] + "_layer_" + nodelayer;
            let nodehidden = v['layer'] > depth;
            let nodelabel = "";
            if (!(nodetype == null)) {
                nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n").concat(nodetype.toString());
            }
            else
                nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n not specified");
            let nodetitle = "";
            nodetitle = nodetitle.concat(nodestatus).concat("\n, ").concat(noderesolution);
            nodeElements.push({
                id: ID,
                label: nodelabel,
                group: nodegroup,
                shape: 'box',
                title: nodetitle,
                level: nodelayer,
                hidden: nodehidden
            })
        });

        //the type of a proposed link is proposed where as the type of an accepted link is smth like duplicates, similar, etc.
        function findProposed(status, type) {
            if (status == "proposed")
                return "proposed";
            else {
                return type;
            }
        }

        //add edges
        $.each(nodeEdgeObject['edges'], function (i, v) {
            let edgestatus = v['status'];
            let fromID = v['node_fromid'];
            let toID = v['node_toid'];
            let edgelabel = findProposed(v['status'], v['dependency_type']);
            let edgearrow = arrowPaletteType[edgelabel];
            let edgedashes = edgeStatusPalette[edgestatus];

            edgeElements.push({
                from: fromID,
                to: toID,
                arrows: edgearrow,
                label: edgelabel,
                color: {color: '#172B4D', inherit: false},
                width: 2,
                dashes: edgedashes
            });
        });

        //create an array with nodes
        let nodes = new vis.DataSet(nodeElements);

        // create an array with edges
        let edges = new vis.DataSet(edgeElements);

        // create a network
        let networkContainer = document.getElementById('issueDep');

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
                "yellow_layer_0": {
                    color: {background: '#FECC3F', border: '#172B4D'},
                    borderWidth: 6,
                    font: {color: 'black', multi: 'html'}
                },
                "green_layer_0": {
                    color: {background: '#24C533', border: '#172B4D'},
                    borderWidth: 6,
                    font: {color: 'black', multi: 'html'}
                },
                "blue_layer_0": {
                    color: {background: '#6D8DB5', border: '#172B4D'},
                    borderWidth: 6,
                    font: {color: 'black', multi: 'html'}
                },
                "red_layer_0": {
                    color: {background: '#FF5E36', border: '#172B4D'},
                    borderWidth: 6,
                    font: {color: 'black', multi: 'html'}
                },
                "yellow_layer_1": {
                    color: {background: '#FED153', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "green_layer_1": {
                    color: {background: '#27D638', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "blue_layer_1": {
                    color: {background: '#7A97BB', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "red_layer_1": {
                    color: {background: '#FF5E36', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "yellow_layer_2": {
                    color: {background: '#FED666', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "green_layer_2": {
                    color: {background: '#36DA46', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "blue_layer_2": {
                    color: {background: '#87A1C2', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "red_layer_2": {
                    color: {background: '#FF6D49', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "yellow_layer_3": {
                    color: {background: '#FEDC7A', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "green_layer_3": {
                    color: {background: '#47DD55', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "blue_layer_3": {
                    color: {background: '#94ABC9', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "red_layer_3": {
                    color: {background: '#FF7D5D', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "yellow_layer_4": {
                    color: {background: '#FEE18D', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "green_layer_4": {
                    color: {background: '#58E064', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "blue_layer_4": {
                    color: {background: '#A1B6CF', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "red_layer_4": {
                    color: {background: '#FF8D71', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "yellow_layer_5": {
                    color: {background: '#FFE6A1', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "green_layer_5": {
                    color: {background: '#68E374', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "blue_layer_5": {
                    color: {background: '#AEC0D6', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "red_layer_5": {
                    color: {background: '#FF9D84', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                },
                "proposed": {
                    color: {background: '#17b2ad', border: '#172B4D'},
                    borderWidth: 2,
                    font: {color: 'black', multi: 'html'}
                }
            },
            //nodedesign
            "nodes": {
                "font": {
                    "face": 'Lato'
                },
                "margin": {
                    "top": 10,
                    "right": 10,
                    "bottom": 10,
                    "left": 10
                }
            },
            //edgedesign
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
                "randomSeed": 9
            },
            "interaction": {
                "multiselect": true,
                "navigationButtons": false
            },
            "physics": {
                "enabled": true,
                'forceAtlas2Based': {
                    'gravitationalConstant': -26,
                    'centralGravity': 0.005,
                    'springLength': 230,
                    'springConstant': 0.18,
                    'avoidOverlap': 2
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
            network.setOptions( { physics: false } );
        });

        //Similarity detection functionality
        //Showing and removing proposed issues
        function addProposedIssues(){
            try {
                nodes.add({
                    id: 1,
                    label: "TEST-1" + "<i>".concat(nodekey).concat("</i>").concat("\n").concat("Bug"),
                    group: nodegroup,
                    shape: 'box',
                    title: "Unresolved, Open",
                    level: 1,
                    hidden: false
                });
            }
            catch (err)
            {
                alert(err);
            }
        }
        //interact with network

        //if a node is selected display information in infobox
        network.on("selectNode", function (params) {
            params.event = "[original event]";

            $(".infobox").css("display", "flex");

            //get information of selected issue
            let node = nodes.get(params.nodes);
            let issueID = node[0].id;

            let issueNode = findElement(nodeEdgeObject.nodes, "nodeid", issueID);

            let issueKey = issueNode.id;
            let issueLink = "https://bugreports.qt.io/browse/" + issueKey;
            let issueLinkTestJIRA = "https://bugreports-test.qt.io/browse/" + issueKey;
            let issueTitle = issueNode.name;
            let issueStatus = issueNode.status;
            let issueResolution = issueNode.resolution;
            let issueEnvironment = issueNode.environment;
            let issueComponent = issueNode.components;
            let issueLabel = issueNode.labels;
            let issueVersion = issueNode.versions;
            let issuePlatform = issueNode.platforms;
            let issueFixVersion = issueNode.fixversion;

            //update corressponding element in HTML
            document.getElementById('infoBoxHeading').innerHTML = "".concat(issueKey);
            document.getElementById('infoBoxIssueLink').innerHTML = '<a href=\"' + issueLink + '\" class=\"button jira  button-effect-orange center\" target="_blank">View Issue in Qt JIRA</a>';
            document.getElementById('infoBoxIssueLinkTestJIRA').innerHTML = '<a href=\"' + issueLinkTestJIRA + '\" class=\"button jira  button-effect-orange center\" target="_blank">View Issue in Qt Test JIRA</a>';
            document.getElementById('infoBoxIssueStatus').innerHTML = "<b>Status: </b>".concat(issueStatus);
            document.getElementById('infoBoxIssueSummary').innerHTML = "<b>Summary: </b>".concat(issueTitle);
            document.getElementById('infoBoxIssueResolution').innerHTML = "<b>Resolution: </b>".concat(issueResolution);
            document.getElementById('infoBoxIssueEnv').innerHTML = "<b>Environment: </b>".concat(issueEnvironment);
            document.getElementById('infoBoxIssueComponent').innerHTML = "<b>Component: </b>".concat(issueComponent);
            document.getElementById('infoBoxIssueLabel').innerHTML = "<b>Label: </b>".concat(issueLabel);
            document.getElementById('infoBoxIssueVersion').innerHTML = "<b>Version: </b>".concat(issueVersion);
            document.getElementById('infoBoxIssueFix').innerHTML = "<b>Fix Version: </b>".concat(issueFixVersion);
            document.getElementById('infoBoxIssuePlatform').innerHTML = "<b>Platform(s): </b>".concat(issuePlatform);
        });

        //doubleclicking searches for the clicked issue
        network.on("doubleClick", function (params) {
            params.event = "[original event]";

            let node = nodes.get(params.nodes);
            let issueID = node[0].id;
            let issueNode = findElement(nodeEdgeObject.nodes, "nodeid", issueID);
            let issueKey = issueNode.id;

            console.log(depth);

            $('#issueInput').val(issueKey);
            $('#layerInput').val(depth);
            $('#changeInput').val(0);
            //
            document.forms["search-id"].submit();
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