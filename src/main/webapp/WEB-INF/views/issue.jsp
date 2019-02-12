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
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        #issueDep {
            width: 100%;
            height: 80%;
        }

        input[type=number] {
            width: 100px;
        }

        input[type=text] {
            width: 150px;
        }

        .box {
            border-radius: 5px;
            border-color: #172B4D;
            border-style: solid;
            border-width: 1px;
            width: 100px;
            height: auto;
            display: inline-block;
        }
    </style>
</head>
<body>

<%--This is the navigation bar located at the top, it contains a link to the project website and a search box--%>
<div class="topnav">
    <a href="https://openreq.eu/"><img alt="or_logo"
                                       src="../images/or_logo.png"
                                       width="116px" height="30px"/></a>
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

<%--Title--%>
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

<%--Main body of the web page--%>
<div class="container-fluid" style="padding-left: 50px; padding-top: 30px">
    <div class="row">
        <%--(Left) Functionalities of the web application--%>
        <div class="col-2">
            <%--My try to get a button to center the graph--%>
            <%--<div class="col-3">--%>
            <%--<input type="button" onclick="centerGraph();"--%>
            <%--class="btn btn-default button-_layer button-effect-teal"--%>
            <%--value="Refresh Graph">--%>
            <%--</div>--%>

            <%--Layer buttons and information--%>
            <div class="row">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Layer</h5>
                        <h7 class="card-subtitle">Current: ${layerDepth}
                            <br>
                            Max: ${maxLayer}
                        </h7>
                        <div class="row">
                            <%--Add Layer Button--%>
                            <div class="col-6">
                                <form action="/issue" method="post" id="add-layer">
                                    <input type="hidden" name="issues" value="${issue}"/>
                                    <input type="hidden" name="layerDepth" value="${layerDepth}"/>
                                    <input type="hidden" name="layerChange" value="1"/>
                                    <input type="submit" class="button layer add button-effect-teal"
                                           id="add-btn"
                                           value="&#43">
                                </form>
                            </div>
                            <%--Remove Layer Button--%>
                            <div class="col-6">
                                <form action="/issue" method="post" id="remove-layer">
                                    <input type="hidden" name="issues" value="${issue}"/>
                                    <input type="hidden" name="layerDepth" value="${layerDepth}"/>
                                    <input type="hidden" name="layerChange" value="-1"/>
                                    <input type="submit"
                                           class="button layer remove button-effect-orange"
                                           id="remove-btn"
                                           value="&#45">
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <br>

            <%--Buttons to trigger the functionality of the microservices--%>
            <div class="row">
                <div class="card">
                    <!-- Trigger/Open The Modal -->
                    <button class="button button-effect-teal" id="CCBtn">Consistency<br>Checker</button>

                    <!-- The Modal -->
                    <div id="CCModal" class="modal">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span class="close" id="ccspan">&times;</span>
                            <p>We are very sorry, the Consistency Checker is not yet available.</p>
                        </div>

                    </div>

                    <br>

                    <!-- Trigger/Open The Modal -->
                    <button class="button button-effect-teal" id="DDBtn">Dependency<br>Detection</button>

                    <!-- The Modal -->
                    <div id="DDModal" class="modal">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span class="close" id="ddspan">&times;</span>
                            <p>We are very sorry, the Dependency Detection View is not fully available.</p>
                        </div>
                    </div>
                </div>
            </div>

            <br>

            <%--Legende--%>
            <div class="row">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Legend</h5>
                        <p class="card-text">
                        <div class="box blue">
                            To-Do
                        </div>
                        <br>

                        <div class="box red">
                            Stuck
                        </div>
                        <br>

                        <div class="box yellow">
                            In Progress
                        </div>
                        <br>

                        <div class="box green">
                            Done
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--(Middle) The network--%>
        <div class="col-7">
            <div class="card" id="issueDep"></div>
            <br>
        </div>

        <%--(Right) The information box--%>
        <div class="col-3">
            <div class="card infobox">
                <div class="card-body">
                    <h5 class="card-title" id="infoBoxHeading"></h5>
                    <p class="card-text" id="infoBoxIssueSummary"></p>
                    <p class="card-text" id="infoBoxIssueStatus"></p>
                    <p class="card-text" id="infoBoxIssueResolution"></p>
                    <p class="card-text" id="infoBoxIssueComponent"></p>
                    <p class="card-text" id="infoBoxIssueLabel"></p>
                    <p class="card-text" id="infoBoxIssueVersion"></p>
                    <p class="card-text" id="infoBoxIssueFix"></p>
                    <p class="card-text" id="infoBoxIssuePlatform"></p>
                    <p class="card-text" id="infoBoxIssueEnv"></p>
                    <div id="infoBoxIssueLink"></div>
                    <br>
                    <div id="infoBoxIssueLinkTestJIRA"></div>
                </div>
            </div>
        </div>

    </div>
</div>

<script>

    // Get the modal
    var ccmodal = document.getElementById('CCModal');
    var ddmodal = document.getElementById('DDModal');

    // Get the button that opens the modal
    var ccbtn = document.getElementById("CCBtn");
    var ddbtn = document.getElementById("DDBtn");

    // Get the <span> element that closes the modal
    var ccspan = document.getElementById("ccspan");
    var ddspan = document.getElementById("ddspan");


    // When the user clicks on the button, open the modal
    ccbtn.onclick = function () {
        ccmodal.style.display = "block";
    };
    ddbtn.onclick = function () {
        ddmodal.style.display = "block";
    };

    // When the user clicks on <span> (x), close the modal
    ccspan.onclick = function () {
        ccmodal.style.display = "none";
    };
    ddspan.onclick = function () {
        ddmodal.style.display = "none";
    };

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == ccmodal) {
            ccmodal.style.display = "none";
        }
    };

    window.onclick = function (event) {
        if (event.target == ddmodal) {
            ddmodal.style.display = "none";
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
        'CONTRIBUTES': 'to',
        'DAMAGES': 'to',
        'REFINES': 'to', //work breakdown, test
        'REQUIRES': 'to', //dependency
        'INCOMPATIBLE': '',
        'DECOMPOSITION': 'to', //sub-task, epic
        'SIMILAR': '', //relates
        'DUPLICATES': '', //duplicate
        'REPLACES': 'to' //replaces
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
                nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n").concat(nodetype.toString().toLocaleLowerCase());
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
                "minVelocity": 50,
                // "repulsion": {
                //     "nodeDistance": 150
                // },
                "barnesHut":
                    {
                        "avoidOverlap": 1
                    },
                "stabilization": {
                    "enabled": true,
                    "iterations": 50, // maximum number of iteration to stabilize
                    "updateInterval": 1,
                    "onlyDynamicEdges": false,
                    "fit": true
                }
            }
        };

        //initialize network
        let network = new vis.Network(networkContainer, data, options);

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