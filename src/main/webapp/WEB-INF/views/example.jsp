<%--&lt;%&ndash;--%>
  <%--Created by IntelliJ IDEA.--%>
  <%--User: claramarielueders--%>
  <%--Date: 25.02.19--%>
  <%--Time: 17:48--%>
  <%--To change this template use File | Settings | File Templates.--%>
<%--&ndash;%&gt;--%>

<%--<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>--%>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
    <%--<title>Example Issue Link Map</title>--%>
    <%--<script src="https://code.jquery.com/jquery-3.3.1.min.js"--%>
            <%--integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="--%>
            <%--crossorigin="anonymous"></script>--%>
    <%--<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.js"></script>--%>
    <%--<script type="text/javascript"--%>
            <%--src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>--%>

    <%--<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet"--%>
          <%--integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous">--%>
    <%--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/vis/4.21.0/vis.min.css">--%>
    <%--<link rel="stylesheet" href="./css/style.css">--%>
    <%--<style>--%>
        <%--#issueLinkMap {--%>
            <%--width: 100%;--%>
            <%--height: 70%;--%>
        <%--}--%>

        <%--input[type=number] {--%>
            <%--width: 100px;--%>
        <%--}--%>


    <%--</style>--%>
<%--</head>--%>
<%--<body>--%>

<%--&lt;%&ndash;This is the navigation bar located at the top, it contains a link to the project website and a search box&ndash;%&gt;--%>
<%--<div class="topnav">--%>
    <%--<a href="https://openreq.eu/"><img alt="or_logo"--%>
                                       <%--src="images/or_logo.png"--%>
                                       <%--width="116px" height="30px"/></a>--%>

    <%--<a href="https://bugreports.qt.io/browse/">Qt's Jira</a>--%>
    <%--<a href="./">Go Back</a>--%>
<%--</div>--%>

<%--&lt;%&ndash;Title&ndash;%&gt;--%>
<%--<div class="container-fluid" style="padding-left: 50px; padding-top: 30px">--%>
    <%--&lt;%&ndash;Header and Loader&ndash;%&gt;--%>
    <%--<div class="row">--%>

        <%--<div class="col-10">--%>
            <%--<h2>Issue Links of ${issue}</h2>--%>
        <%--</div>--%>

        <%--<div class="col-2">--%>
            <%--<div class="loader" id="loader"></div>--%>
        <%--</div>--%>

    <%--</div>--%>
<%--</div>--%>

<%--<div class="container-fluid" style="padding-left: 50px; padding-top: 30px">--%>
    <%--&lt;%&ndash;Network&ndash;%&gt;--%>
    <%--<div class="row">--%>
        <%--<div class="col-8">--%>
            <%--<div class="row">--%>
                <%--&lt;%&ndash;Depth buttons&ndash;%&gt;--%>
                <%--<form action="./example" method="post" id="depth-1" style="display: inline-block">--%>
                    <%--<input type="hidden" name="issues" value="${issue}"/>--%>
                    <%--<input type="hidden" name="layerDepth" value="1"/>--%>
                    <%--<input type="submit" class="button layer button-effect-teal" id="depth-1-btn"--%>
                           <%--value="Depth 1">--%>
                <%--</form>--%>
                <%--<form action="./example" method="post" id="depth-2" style="display: inline-block">--%>
                    <%--<input type="hidden" name="issues" value="${issue}"/>--%>
                    <%--<input type="hidden" name="layerDepth" value="2"/>--%>
                    <%--<input type="submit" class="button layer button-effect-teal" id="depth-2-btn"--%>
                           <%--value="Depth 2">--%>
                <%--</form>--%>
                <%--<form action="./example" method="post" id="depth-3" style="display: inline-block">--%>
                    <%--<input type="hidden" name="issues" value="${issue}"/>--%>
                    <%--<input type="hidden" name="layerDepth" value="3"/>--%>
                    <%--<input type="submit" class="button layer button-effect-teal" id="depth-3-btn"--%>
                           <%--value="Depth 3">--%>
                <%--</form>--%>
                <%--<form action="./example" method="post" id="depth-4" style="display: inline-block">--%>
                    <%--<input type="hidden" name="issues" value="${issue}"/>--%>
                    <%--<input type="hidden" name="layerDepth" value="4"/>--%>
                    <%--<input type="submit" class="button layer button-effect-teal" id="depth-4-btn"--%>
                           <%--value="Depth 4">--%>
                <%--</form>--%>
                <%--<form action="./example" method="post" id="depth-5">--%>
                    <%--<input type="hidden" name="issues" value="${issue}"/>--%>
                    <%--<input type="hidden" name="layerDepth" value="5"/>--%>
                    <%--<input type="submit" class="button layer button-effect-teal" id="depth-5-btn"--%>
                           <%--value="Depth 5">--%>
                <%--</form>--%>
            <%--</div>--%>
            <%--<div class="row">--%>
                <%--&lt;%&ndash;Issue Link Map&ndash;%&gt;--%>
                <%--<div class="card" id="issueLinkMap"></div>--%>
                <%--<br>--%>
            <%--</div>--%>
            <%--<br>--%>
            <%--<div class="row">--%>
                <%--<div class="card">--%>
                    <%--<div class="card-body">--%>
                        <%--<h5 class="card-title">Legend</h5>--%>
                        <%--<p class="card-text">--%>
                        <%--<div class="box blue" style="display: inline-block;">--%>
                            <%--To-Do--%>
                        <%--</div>--%>
                        <%--<div class="box red" style="display: inline-block;">--%>
                            <%--Stuck--%>
                        <%--</div>--%>
                        <%--<div class="box yellow" style="display: inline-block;">--%>
                            <%--In Progress--%>
                        <%--</div>--%>
                        <%--<div class="box green" style="display: inline-block;">--%>
                            <%--Done--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
        <%--&lt;%&ndash;Information&ndash;%&gt;--%>
        <%--<div class="col-4">--%>

            <%--&lt;%&ndash;Information buttons&ndash;%&gt;--%>
            <%--<ul class="nav nav-tabs nav-fill mb-3" id="info-nav" role="tablist">--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link active" id="info-tab" data-toggle="tab" href="#info-box" role="tab"--%>
                       <%--aria-controls="info-tab" aria-selected="true" onclick="infoTab();">Info--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--&lt;%&ndash;<li class="nav-item">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<a class="nav-link" id="list-tab" data-toggle="tab" href="#list-box" role="tab"&ndash;%&gt;--%>
                       <%--&lt;%&ndash;aria-controls="list-tab" aria-selected="true" onclick="listTab();">List&ndash;%&gt;--%>
                    <%--&lt;%&ndash;</a>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</li>&ndash;%&gt;--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" id="sd-tab" data-toggle="tab" href="#sd-box" role="tab"--%>
                       <%--aria-controls="sd-tab" aria-selected="false" onclick="proposedLinks();">Link--%>
                        <%--Detection--%>
                    <%--</a>--%>
                <%--</li>--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" id="cc-tab" data-toggle="tab" href="#cc-box" role="tab"--%>
                       <%--aria-controls="cc-tab" aria-selected="false" onclick="checkConsistency();">Consistency--%>
                        <%--Checker--%>
                    <%--</a>--%>
                <%--</li>--%>
            <%--</ul>--%>
            <%--&lt;%&ndash;Information box&ndash;%&gt;--%>
            <%--<div class="tab-content" id="tabs-tabContent">--%>
                <%--<div class="tab-pane fade show active" id="info-box" role="tabpanel"--%>
                     <%--aria-labelledby="info-tab">--%>
                    <%--<h5 id="infoBoxHeading"></h5>--%>
                    <%--<p id="infoBoxIssueSummary"></p>--%>
                    <%--<p id="infoBoxIssueStatus"></p>--%>
                    <%--<p id="infoBoxIssueResolution"></p>--%>
                    <%--<p id="infoBoxIssueComponent"></p>--%>
                    <%--<p id="infoBoxIssueLabel"></p>--%>
                    <%--<p id="infoBoxIssueVersion"></p>--%>
                    <%--<p id="infoBoxIssueFix"></p>--%>
                    <%--<p id="infoBoxIssuePlatform"></p>--%>
                    <%--<p id="infoBoxIssueEnv"></p>--%>
                    <%--<div id="infoBoxIssueLink"></div>--%>
                    <%--<br>--%>
                    <%--<div id="infoBoxIssueLinkTestJIRA"></div>--%>
                <%--</div>--%>
                <%--&lt;%&ndash;<div class="tab-pane fade show" id="list-box" role="tabpanel"&ndash;%&gt;--%>
                     <%--&lt;%&ndash;aria-labelledby="list-tab">&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<h5>Issue List</h5>&ndash;%&gt;--%>
                    <%--&lt;%&ndash;<p id="IssuesList"></p>&ndash;%&gt;--%>
                <%--&lt;%&ndash;</div>&ndash;%&gt;--%>
                <%--<div class="tab-pane fade" id="sd-box" role="tabpanel" aria-labelledby="sd-tab">--%>
                    <%--<h5>Proposed Links--%>
                    <%--</h5>--%>
                    <%--<p id="proposedIssuesList"></p>--%>
                <%--</div>--%>
                <%--<div class="tab-pane fade" id="cc-box" role="tabpanel" aria-labelledby="cc-tab">--%>
                    <%--<h5>Result</h5>--%>
                    <%--<p id="ccResult"></p>--%>
                    <%--<h5>Diagnosis</h5>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</div>--%>


<%--&lt;%&ndash;&lt;%&ndash;(Right) The information box&ndash;%&gt;&ndash;%&gt;--%>
<%--&lt;%&ndash;<div class="col-3">&ndash;%&gt;--%>
<%--&lt;%&ndash;<div class="card infobox">&ndash;%&gt;--%>
<%--&lt;%&ndash;<div class="card-body">&ndash;%&gt;--%>
<%--&lt;%&ndash;<h5 class="card-title" id="infoBoxHeading"></h5>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssueSummary"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssueStatus"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssueResolution"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssueComponent"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssueLabel"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssueVersion"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssueFix"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssuePlatform"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<p class="card-text" id="infoBoxIssueEnv"></p>&ndash;%&gt;--%>
<%--&lt;%&ndash;<div id="infoBoxIssueLink"></div>&ndash;%&gt;--%>
<%--&lt;%&ndash;<br>&ndash;%&gt;--%>
<%--&lt;%&ndash;<div id="infoBoxIssueLinkTestJIRA"></div>&ndash;%&gt;--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>

<%--&lt;%&ndash;</div>&ndash;%&gt;--%>
<%--&lt;%&ndash;</div>&ndash;%&gt;--%>

<%--<script>--%>
    <%--//getting the data for the network and layer disabling--%>
    <%--let issue = '${issue}';--%>
    <%--let depth = '${layerDepth}';--%>
    <%--//console.log("LAYER DEPTH:" + depth);--%>
    <%--let max_depth = '${maxLayer}';--%>
    <%--//console.log("MAX DEPTH:" + max_depth);--%>
    <%--let issueArray = issue.replace(/ /g, "").split(",");--%>
    <%--//proposed View active boolean--%>
    <%--let proposedViewActive = false;--%>
    <%--//proposed View active boolean--%>
    <%--let consistencyViewActive = false;--%>

    <%--//Example Data--%>
    <%--let nodeEdgeObject = JSON.parse('{"nodes": ' +--%>
        <%--'[{"id": "EX-1", "created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "user story","effort": 0,"nodeid": 1,"name": "Example Issue 1 ","layer": 1,"resolution": "Fixed","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "Closed","fixversion": "No FixVersion","components": "General"},' +--%>
        <%--'{"id": "EX-2","created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "user story","effort": 0,"nodeid": 2,"name": "Example Issue 2 ","layer": 1,"resolution": "Open","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "Verified","fixversion": "No FixVersion","components": "General"},' +--%>
        <%--'{"id": "EX-3","created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "epic","effort": 0,"nodeid": 3,"name": "Example Issue 3  ","layer": 0,"resolution": "Open","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "In Progress","fixversion": "No FixVersion","components": "General"},' +--%>
        <%--'{"id": "EX-4","created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "user story","effort": 0,"nodeid": 4,"name": "Example Issue 4  ","layer": 1,"resolution": "Open","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "In Progress","fixversion": "No FixVersion","components": "General"},' +--%>
        <%--'{"id": "EX-5","created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "task","effort": 0,"nodeid": 5,"name": "Example Issue 5  ","layer": 2,"resolution": "Open","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "Open","fixversion": "No FixVersion","components": "General"}' +--%>
        <%--'],' +--%>
        <%--'"edges": [' +--%>
        <%--'{"dependency_type": "similar","dependency_score": 0.0,"status": "accepted","fromid": "EX-1","toid": "EX-2","description": ["Similar"],"created_at": 0,"node_fromid": 1,"node_toid": 2},' +--%>
        <%--'{"dependency_type": "work breakdown","dependency_score": 0.0,"status": "accepted","fromid": "EX-3","toid": "EX-1","description": ["work breakdown"],"created_at": 0,"node_fromid": 3,"node_toid": 1},' +--%>
        <%--'{"dependency_type": "work breakdown","dependency_score": 0.0,"status": "accepted","fromid": "EX-3","toid": "EX-2","description": ["work breakdown"],"created_at": 0,"node_fromid": 3,"node_toid": 2},' +--%>
        <%--'{"dependency_type": "work breakdown","dependency_score": 0.0,"status": "accepted","fromid": "EX-3","toid": "EX-4","description": ["work breakdown"],"created_at": 0,"node_fromid": 3,"node_toid": 4},' +--%>
        <%--'{"dependency_type": "work breakdown","dependency_score": 0.0,"status": "accepted","fromid": "EX-4","toid": "EX-5","description": ["work breakdown"],"created_at": 0,"node_fromid": 4,"node_toid": 5}' +--%>
        <%--'],' +--%>
        <%--'"max_layer": 2}');--%>

    <%--//this will be replaced by an API call with an issue key--%>
    <%--let proposedNodesEdges = JSON.parse('{"nodes": ' +--%>
        <%--'[{"id": "PROP-1", "created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "user story","effort": 0,"nodeid": 10,"name": "Proposed Issue 1 ", "layer": 1, "resolution": "Fixed","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "Closed","fixversion": "No FixVersion","components": "General"},' +--%>
        <%--'{"id": "PROP-2","created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "user story","effort": 0,"nodeid": 20,"name": "Proposed Issue 2 ", "layer": 1,"resolution": "Open","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "Assigned","fixversion": "No FixVersion","components": "General"},' +--%>
        <%--'{"id": "PROP-3","created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "user story","effort": 0,"nodeid": 30,"name": "Proposed Issue 3  ", "layer": 1,"resolution": "Open","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "In Progress","fixversion": "No FixVersion","components": "General"},' +--%>
        <%--'{"id": "PROP-4","created_at": 0,"modified_at": 0,"priority": 7,"requirement_type": "user story","effort": 0,"nodeid": 40,"name": "Proposed Issue 4  ", "layer": 1,"resolution": "Open","platforms": "none",' +--%>
        <%--'"versions": "1. 0","labels": "","environment": "none","status": "In Progress","fixversion": "No FixVersion","components": "General"}' +--%>
        <%--'],' +--%>
        <%--'"edges": [' +--%>
        <%--'{"dependency_type": "duplicate","dependency_score": 0.0,"status": "proposed","fromid": "EX-3","toid": "PROP-1","created_at": 0,"node_fromid": 10,"node_toid": 3},' +--%>
        <%--'{"dependency_type": "duplicate","dependency_score": 0.0,"status": "proposed","fromid": "EX-3","toid": "PROP-2","created_at": 0,"node_fromid": 20,"node_toid": 3},' +--%>
        <%--'{"dependency_type": "duplicate","dependency_score": 0.0,"status": "proposed","fromid": "EX-3","toid": "PROP-3","created_at": 0,"node_fromid": 30,"node_toid": 3},' +--%>
        <%--'{"dependency_type": "duplicate","dependency_score": 0.0,"status": "proposed","fromid": "EX-3","toid": "PROP-4","created_at": 0,"node_fromid": 40,"node_toid": 3}' +--%>
        <%--']}');--%>

    <%--//disables the layer buttons if the depth would be smaller than 1 or bigger than 5--%>
    <%--//Depth Buttons--%>
    <%--//TODO: THIS IS VERY VERY BAD CODING, pls improve--%>
    <%--$(document).ready(function () {--%>
        <%--if (1 > max_depth) {--%>
            <%--$("#depth-1-btn").prop("disabled", true);--%>
        <%--} else {--%>
            <%--$("#depth-1-btn").removeAttr('disabled');--%>
        <%--}--%>
        <%--if (2 > max_depth) {--%>
            <%--$("#depth-2-btn").prop("disabled", true);--%>
        <%--} else {--%>
            <%--$("#depth-2-btn").removeAttr('disabled');--%>
        <%--}--%>
        <%--if (3 > max_depth) {--%>
            <%--$("#depth-3-btn").prop("disabled", true);--%>
        <%--} else {--%>
            <%--$("#depth-3-btn").removeAttr('disabled');--%>
        <%--}--%>
        <%--if (4 > max_depth) {--%>
            <%--$("#depth-4-btn").prop("disabled", true);--%>
        <%--} else {--%>
            <%--$("#depth-4-btn").removeAttr('disabled');--%>
        <%--}--%>
        <%--if (5 > max_depth) {--%>
            <%--$("#depth-5-btn").prop("disabled", true);--%>
        <%--} else {--%>
            <%--$("#depth-5-btn").removeAttr('disabled');--%>
        <%--}--%>
        <%--if (1 == depth) {--%>
            <%--$("#depth-1-btn").attr("class", "button layer button-effect-teal active");--%>
        <%--} else {--%>
            <%--$("#depth-1-btn").attr('class', "button layer button-effect-teal");--%>
        <%--}--%>
        <%--if (2 == depth) {--%>
            <%--$("#depth-2-btn").attr("class", "button layer button-effect-teal active");--%>
        <%--} else {--%>
            <%--$("#depth-2-btn").attr('class', "button layer button-effect-teal");--%>
        <%--}--%>
        <%--if (3 == depth) {--%>
            <%--$("#depth-3-btn").attr("class", "button layer button-effect-teal active");--%>
        <%--} else {--%>
            <%--$("#depth-3-btn").attr('class', "button layer button-effect-teal");--%>
        <%--}--%>
        <%--if (4 == depth) {--%>
            <%--$("#depth-4-btn").attr("class", "button layer button-effect-teal active");--%>
        <%--} else {--%>
            <%--$("#depth-4-btn").attr('class', "button layer button-effect-teal");--%>
        <%--}--%>
        <%--if (5 == depth) {--%>
            <%--$("#depth-5-btn").attr("class", "button layer button-effect-teal active");--%>
        <%--} else {--%>
            <%--$("#depth-5-btn").attr('class', "button layer button-effect-teal");--%>
        <%--}--%>
        <%--infoTab()--%>
    <%--});--%>

    <%--//function to help find a specific item depending on its identifier--%>
    <%--function findElement(arr, propName, propValue) {--%>
        <%--for (var i = 0; i < arr.length; i++)--%>
            <%--if (arr[i][propName] == propValue)--%>
                <%--return arr[i];--%>
    <%--}--%>

    <%--//the type of a proposed link is proposed where as the type of an accepted link is smth like duplicates, similar, etc.--%>
    <%--function findProposed(status, type) {--%>
        <%--if (status == "proposed")--%>
            <%--return "proposed";--%>
        <%--else {--%>
            <%--return type;--%>
        <%--}--%>
    <%--}--%>

    <%--//color map for status according to bucketing in Kanban board--%>
    <%--//Open blue, Blocked red, In Progress yellow, Done green--%>
    <%--let colorPaletteStatus = {--%>
        <%--'Open': 'blue',--%>
        <%--'Reopened': 'blue',--%>
        <%--'Accepted': 'blue',--%>
        <%--'Reported': 'blue',--%>
        <%--'To-Do': 'blue',--%>
        <%--'Blocked': 'red',--%>
        <%--'On hold': 'red',--%>
        <%--'Need more info': 'red',--%>
        <%--'Waiting 3rd party': 'red',--%>
        <%--'In Progress': 'yellow',--%>
        <%--'Implemented': 'yellow',--%>
        <%--'Resolved': 'green',--%>
        <%--'Closed': 'green',--%>
        <%--'Withdrawn': 'green',--%>
        <%--'Rejected': 'green',--%>
        <%--'Done': 'green',--%>
        <%--'Verified': 'green',--%>
        <%--'undefined': 'yellow'--%>
    <%--};--%>

    <%--//map to create the correct type of error, links like duplicates do not have a direction--%>
    <%--let arrowPaletteType = {--%>
        <%--'contributes': 'to',--%>
        <%--'damages': 'to',--%>
        <%--'refines': 'to', //work breakdown, test--%>
        <%--'requires': 'to', //dependency--%>
        <%--'incompatible': '',--%>
        <%--'decomposition': 'to', //sub-task, epic--%>
        <%--'similar': '', //relates--%>
        <%--'duplicates': '', //duplicate--%>
        <%--'replaces': 'to' //replaces--%>
    <%--};--%>

    <%--//map to visually differentiate between accepted and proposed links--%>
    <%--let edgeStatusPalette = {--%>
        <%--'accepted': false,--%>
        <%--'proposed': true--%>
    <%--};--%>

    <%--let edgeElements = [];--%>
    <%--let nodeElements = [];--%>
    <%--let issueList = [];--%>

    <%--//add nodes--%>
    <%--$.each(nodeEdgeObject['nodes'], function (i, v) {--%>
        <%--let ID = v['nodeid'];--%>
        <%--let nodekey = v['id'];--%>
        <%--let nodetype = v['requirement_type'];--%>
        <%--//TODO: Add first 20 characters of title to box beneath id (QTPROJECT_XXX)--%>
        <%--//let nodename = v['name'];--%>
        <%--let nodestatus = v['status'];--%>
        <%--let nodelayer = v['layer'];--%>
        <%--let noderesolution = v['resolution'];--%>
        <%--let nodegroup = colorPaletteStatus[nodestatus] + "_layer_" + nodelayer;--%>
        <%--let nodehidden = v['layer'] > depth;--%>
        <%--let nodelabel = "";--%>
        <%--if (!(nodetype == null)) {--%>
            <%--nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n").concat(nodetype.toString());--%>
        <%--}--%>
        <%--else--%>
            <%--nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n not specified");--%>
        <%--let nodetitle = "";--%>
        <%--nodetitle = nodetitle.concat(nodestatus).concat("\n, ").concat(noderesolution);--%>
        <%--if (nodelayer <= depth) {--%>
            <%--nodeElements.push({--%>
                <%--id: ID,--%>
                <%--label: nodelabel,--%>
                <%--group: nodegroup,--%>
                <%--shape: 'box',               //'image'--%>
                <%--title: nodetitle,--%>
                <%--level: nodelayer,--%>
                <%--hidden: nodehidden,--%>
                <%--//image: "http://localhost:10201/images/Priority/major.svg"--%>
            <%--});--%>
            <%--issueList.push({--%>
                <%--id: nodekey--%>
            <%--})--%>
        <%--}--%>
    <%--});--%>

    <%--//add edges--%>
    <%--$.each(nodeEdgeObject['edges'], function (i, v) {--%>
        <%--let edgestatus = v['status'];--%>
        <%--let fromID = v['node_fromid'];--%>
        <%--let toID = v['node_toid'];--%>
        <%--let edgelabel = findProposed(v['status'], v['dependency_type']);--%>
        <%--let edgearrow = arrowPaletteType[edgelabel];--%>
        <%--let edgedashes = edgeStatusPalette[edgestatus];--%>

        <%--edgeElements.push({--%>
            <%--from: fromID,--%>
            <%--to: toID,--%>
            <%--arrows: edgearrow,--%>
            <%--label: edgelabel,--%>
            <%--color: {color: '#172B4D', inherit: false},--%>
            <%--width: 2,--%>
            <%--dashes: edgedashes--%>
        <%--});--%>
    <%--});--%>

    <%--//create an array with nodes--%>
    <%--let nodes = new vis.DataSet(nodeElements);--%>

    <%--// create an array with edges--%>
    <%--let edges = new vis.DataSet(edgeElements);--%>

    <%--let proposedNodeElements = [];--%>
    <%--let proposedEdgeElements = [];--%>
    <%--let proposedIssuesList = [];--%>

    <%--//add nodes--%>
    <%--$.each(proposedNodesEdges['nodes'], function (i, v) {--%>
        <%--let ID = v['nodeid'];--%>
        <%--let nodekey = v['id'];--%>
        <%--let nodetype = v['requirement_type'];--%>
        <%--//TODO: Add first 20 characters of title to box beneath id (QTPROJECT_XXX)--%>
        <%--//let nodename = v['name'];--%>
        <%--let nodestatus = v['status'];--%>
        <%--let nodelayer = v['layer'];--%>
        <%--let noderesolution = v['resolution'];--%>
        <%--let nodehidden = v['layer'] > depth;--%>
        <%--let nodelabel = "";--%>
        <%--if (!(nodetype == null)) {--%>
            <%--nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n").concat(nodetype.toString());--%>
        <%--}--%>
        <%--else--%>
            <%--nodelabel = nodelabel + "<i>".concat(nodekey).concat("</i>").concat("\n not specified");--%>
        <%--let nodetitle = "";--%>
        <%--nodetitle = nodetitle.concat(nodestatus).concat("\n, ").concat(noderesolution);--%>
        <%--proposedNodeElements.push({--%>
            <%--id: ID,--%>
            <%--label: nodelabel,--%>
            <%--group: "proposed",--%>
            <%--shape: 'box',--%>
            <%--title: nodetitle,--%>
            <%--level: nodelayer,--%>
            <%--hidden: nodehidden--%>
        <%--});--%>
        <%--proposedIssuesList.push({--%>
            <%--id: nodekey--%>
        <%--})--%>
    <%--});--%>

    <%--//add edges--%>
    <%--$.each(proposedNodesEdges['edges'], function (i, v) {--%>
        <%--let edgestatus = v['status'];--%>
        <%--let fromID = v['node_fromid'];--%>
        <%--let toID = v['node_toid'];--%>
        <%--let edgelabel = findProposed(v['status'], v['dependency_type']);--%>
        <%--let edgearrow = arrowPaletteType[edgelabel];--%>

        <%--proposedEdgeElements.push({--%>
            <%--from: fromID,--%>
            <%--to: toID,--%>
            <%--arrows: edgearrow,--%>
            <%--label: edgelabel,--%>
            <%--color: {color: '#172B4D', inherit: false},--%>
            <%--width: 2,--%>
            <%--dashes: true--%>
        <%--});--%>
    <%--});--%>

    <%--function updateGraphDepth(){--%>


    <%--}--%>

    <%--let numberOfProposedLinks = 0;--%>
    <%--let linkDetectionResponse;--%>

    <%--function registerClick(elem) {--%>
        <%--if (elem.id.charAt(1) == 'r') {--%>
            <%--let btnid = "#" + elem.id;--%>
            <%--if ($(btnid).hasClass('reject')) {--%>
                <%--let otherbtnid = "#" + elem.id.charAt(0) + "a";--%>
                <%--if ($(otherbtnid).hasClass('accepted')) {--%>
                    <%--$(otherbtnid).removeClass('accepted');--%>
                    <%--$(otherbtnid).addClass('accept');--%>
                <%--}--%>
                <%--$(btnid).removeClass('reject');--%>
                <%--$(btnid).addClass('rejected');--%>
                <%--linkDetectionResponse[elem.id.charAt(0)] = "reject";--%>
            <%--}--%>
            <%--else {--%>
                <%--$(btnid).removeClass('rejected');--%>
                <%--$(btnid).addClass('reject');--%>
                <%--delete linkDetectionResponse[elem.id.charAt(0)];--%>
            <%--}--%>
        <%--}--%>
        <%--else {--%>
            <%--let selectid = elem.id.charAt(0) + "s";--%>
            <%--let selectedItem = document.getElementById(selectid).value;--%>
            <%--let btnid = "#" + elem.id;--%>
            <%--if ($(btnid).hasClass('accept')) {--%>
                <%--let otherbtnid = "#" + elem.id.charAt(0) + "r";--%>
                <%--if ($(otherbtnid).hasClass('rejected')) {--%>
                    <%--$(otherbtnid).removeClass('rejected');--%>
                    <%--$(otherbtnid).addClass('reject');--%>
                <%--}--%>
                <%--$(btnid).removeClass('accept');--%>
                <%--$(btnid).addClass('accepted');--%>
                <%--linkDetectionResponse[elem.id.charAt(0)] = selectedItem;--%>
            <%--}--%>
            <%--else {--%>
                <%--$(btnid).removeClass('accepted');--%>
                <%--$(btnid).addClass('accept');--%>
                <%--delete linkDetectionResponse[elem.id.charAt(0)];--%>
            <%--}--%>
        <%--}--%>
    <%--}--%>

    <%--function sendLinkData() {--%>
        <%--let linkDetectionResponseJSON = proposedNodesEdges['edges'].map(function (d, i) {--%>
            <%--return {--%>
                <%--dependency_type: d.dependency_type,--%>
                <%--fromid: d.fromid,--%>
                <%--toid: d.toid,--%>
                <%--status: d.status--%>
            <%--};--%>
        <%--});--%>
        <%--for (i = linkDetectionResponse.length - 1; i >= 0; i--) {--%>
            <%--if (linkDetectionResponse[i] != undefined) {--%>
                <%--if (linkDetectionResponse[i] != "reject") {--%>
                    <%--linkDetectionResponseJSON[i].dependency_type = linkDetectionResponse[i];--%>
                    <%--linkDetectionResponseJSON[i].status = "accepted"--%>
                <%--}--%>
                <%--else {--%>
                    <%--linkDetectionResponseJSON[i].status = "rejected"--%>
                <%--}--%>
            <%--}--%>
            <%--else {--%>
                <%--linkDetectionResponseJSON.splice(i, i);--%>
            <%--}--%>
        <%--}--%>
        <%--// for(i = linkDetectionResponse.length-1; i >=0 ; i++)--%>
        <%--// {--%>
        <%--//     if(linkDetectionResponse[i] == undefined)--%>
        <%--//     {--%>
        <%--//         linkDetectionResponseJSON.splice(i,i);--%>
        <%--//         console.log("bla")--%>
        <%--//     }--%>
        <%--// }--%>
        <%--let linkResponseJSON =--%>
            <%--{--%>
                <%--"dependencies":--%>
                    <%--{linkDetectionResponseJSON}--%>
            <%--};--%>
        <%--console.log(linkResponseJSON);--%>

        <%--// Sending and receiving data in JSON format using POST method--%>
<%--//--%>
        <%--let xhr = new XMLHttpRequest();--%>
        <%--let url = "url";--%>
        <%--xhr.open("POST", url, true);--%>
        <%--xhr.setRequestHeader("Content-Type", "application/json");--%>
        <%--xhr.onreadystatechange = function () {--%>
            <%--if (xhr.readyState === 4 && xhr.status === 200) {--%>
                <%--let json = JSON.parse(xhr.responseText);--%>
                <%--console.log(json.email + ", " + json.password);--%>
            <%--}--%>
        <%--};--%>
        <%--var data = JSON.stringify({"email": "hey@mail.com", "password": "101010"});--%>
        <%--xhr.send(data);--%>
    <%--}--%>


    <%--//Similarity detection functionality--%>
    <%--//Showing and removing proposed issues--%>
    <%--function proposedLinks() {--%>
        <%--if (proposedViewActive == false) {--%>
            <%--try {--%>
                <%--numberOfProposedLinks = proposedEdgeElements.length;--%>
                <%--linkDetectionResponse = Array(numberOfProposedLinks);--%>
                <%--nodes.add(proposedNodeElements);--%>
                <%--edges.add(proposedEdgeElements);--%>
                <%--proposedViewActive = true;--%>
                <%--stringList = " <table style='width: 100%'><tr>\n" +--%>
                    <%--"<th>Issue Key</th>" +--%>
                    <%--"<th>Link type</th>" +--%>
                    <%--"<th>Accept</th>" +--%>
                    <%--"<th>Reject</th>" +--%>
                    <%--"</tr>";--%>
                <%--selectionList = '<div class="custom-select">';--%>
                <%--acceptBtn = "<button class='button accept button-effect-teal-light' onclick=\"registerClick(this)\" id=";--%>
                <%--rejectBtn = "<button class='button reject button-effect-orange-light' onclick=\"registerClick(this)\" id=";--%>
                <%--for (i = 0; i < proposedIssuesList.length; i++) {--%>
                    <%--stringList = stringList + "<tr><td>" + proposedIssuesList[i].id + "</td><td>" + selectionList + "<select id=" + i + "s>" +--%>
                        <%--"<option value='duplicate'>Duplicate</option>" +--%>
                        <%--"<option value='similar'>Similar</option>" +--%>
                        <%--"<option value='depends'>Dependency</option></select></div></td><td>" + acceptBtn + i + "a>&#x2713</button></td><td>" + rejectBtn + +i + "r>&#x2717</button></td></tr>";--%>
                <%--}--%>
                <%--stringList = stringList + "<td><button class='button button-effect-teal' onclick ='sendLinkData()'>Save</button></td><td></td><td></td><td></td></table>";--%>
                <%--document.getElementById('proposedIssuesList').innerHTML = stringList;--%>
            <%--}--%>
            <%--catch (err) {--%>
                <%--alert(err);--%>
            <%--}--%>
        <%--}--%>
    <%--}--%>

    <%--function checkConsistency() {--%>
        <%--if (proposedViewActive == true) {--%>
            <%--try {--%>
                <%--nodes.remove(proposedNodeElements);--%>
                <%--edges.remove(proposedEdgeElements);--%>
                <%--proposedViewActive = false;--%>
            <%--}--%>
            <%--catch (err) {--%>
                <%--alert(err);--%>
            <%--}--%>
        <%--}--%>
        <%--document.getElementById('ccResult').innerHTML = "".concat("Everything is consistent!");--%>
    <%--}--%>

    <%--function listTab() {--%>
        <%--stringList = "";--%>
        <%--for (i = 0; i < issueList.length; i++) {--%>
            <%--stringList = stringList + issueList[i].id + '<br>';--%>
        <%--}--%>
        <%--document.getElementById('IssuesList').innerHTML = stringList;--%>
    <%--}--%>

    <%--//TODO Remeber last selected issue--%>
    <%--function infoTab() {--%>
        <%--if (proposedViewActive) {--%>
            <%--try {--%>
                <%--nodes.remove(proposedNodeElements);--%>
                <%--edges.remove(proposedEdgeElements);--%>
                <%--proposedViewActive = false;--%>
            <%--}--%>
            <%--catch (err) {--%>
                <%--alert(err);--%>
            <%--}--%>
        <%--}--%>
        <%--//display the initial infobox only if the user put exactly one issue in the input--%>
        <%--if (issueArray.length === 1) {--%>
            <%--//get coressponding JSON--%>
            <%--let issueInfo = findElement(nodeEdgeObject.nodes, "id", issue);--%>

            <%--//get information that should be displayed--%>
            <%--let infoLink = "https://bugreports.qt.io/browse/" + issue;--%>
            <%--let infoLinkTestJIRA = "https://bugreports-test.qt.io/browse/" + issue;--%>
            <%--let infoTitle = issueInfo.name;--%>
            <%--//let infoType = issueInfo.requirement_type;--%>
            <%--let infoStatus = issueInfo.status;--%>
            <%--//let infoDescription = issueInfo.issueDescription;--%>
            <%--let infoResolution = issueInfo.resolution;--%>
            <%--let infoEnvironment = issueInfo.environment;--%>
            <%--let infoComponent = issueInfo.components;--%>
            <%--let infoLabel = issueInfo.labels;--%>
            <%--let infoVersion = issueInfo.versions;--%>
            <%--let infoPlatform = issueInfo.platforms;--%>
            <%--let infoFixVersion = issueInfo.fixversion;--%>

            <%--//put the issues in the corressponding part of the website--%>
            <%--document.getElementById('infoBoxHeading').innerHTML = "".concat(issue);--%>
            <%--document.getElementById('infoBoxIssueLink').innerHTML = '<a href=\"' + infoLink + '\" class=\"button jira button-effect-orange center\" target="_blank">View Issue in Qt JIRA</a>';--%>
            <%--document.getElementById('infoBoxIssueLinkTestJIRA').innerHTML = '<a href=\"' + infoLinkTestJIRA + '\" class=\"button jira button-effect-orange center\" target="_blank">View Issue in Qt Test JIRA</a>';--%>
            <%--document.getElementById('infoBoxIssueStatus').innerHTML = "<b>Status: </b>".concat(infoStatus);--%>
            <%--document.getElementById('infoBoxIssueSummary').innerHTML = "<b>Summary: </b>".concat(infoTitle);--%>
            <%--document.getElementById('infoBoxIssueResolution').innerHTML = "<b>Resolution: </b>".concat(infoResolution);--%>
            <%--document.getElementById('infoBoxIssueEnv').innerHTML = "<b>Environment: </b>".concat(infoEnvironment);--%>
            <%--document.getElementById('infoBoxIssueComponent').innerHTML = "<b>Component: </b>".concat(infoComponent);--%>
            <%--document.getElementById('infoBoxIssueLabel').innerHTML = "<b>Label: </b>".concat(infoLabel);--%>
            <%--document.getElementById('infoBoxIssueVersion').innerHTML = "<b>Version: </b>".concat(infoVersion);--%>
            <%--document.getElementById('infoBoxIssueFix').innerHTML = "<b>Fix Version: </b>".concat(infoFixVersion);--%>
            <%--document.getElementById('infoBoxIssuePlatform').innerHTML = "<b>Platform(s): </b>".concat(infoPlatform);--%>
        <%--}--%>
        <%--//if the user searched for multiple issues, hide the infobox until an issue is selected--%>
        <%--else {--%>
            <%--$(".infobox").css("display", "none");--%>
        <%--}--%>
    <%--}--%>

    <%--// Create the network after the page is loaded and the network containing div is rendered--%>
    <%--$(document).ready(function () {--%>
        <%--// create a network--%>
        <%--let networkContainer = document.getElementById('issueLinkMap');--%>

        <%--// provide the data in the vis format--%>
        <%--let data = {--%>
            <%--nodes: nodes,--%>
            <%--edges: edges--%>
        <%--};--%>

        <%--//specify options such as physics--%>
        <%--let options = {--%>
            <%--//specify the different groups--%>
            <%--//TODO: There must be an easier way to create these groups--%>
            <%--"groups": {--%>
                <%--"yellow_layer_0": {--%>
                    <%--color: {background: '#FECC3F', border: '#172B4D'},--%>
                    <%--borderWidth: 6,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"green_layer_0": {--%>
                    <%--color: {background: '#24C533', border: '#172B4D'},--%>
                    <%--borderWidth: 6,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"blue_layer_0": {--%>
                    <%--color: {background: '#6D8DB5', border: '#172B4D'},--%>
                    <%--borderWidth: 6,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"red_layer_0": {--%>
                    <%--color: {background: '#FF5E36', border: '#172B4D'},--%>
                    <%--borderWidth: 6,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"yellow_layer_1": {--%>
                    <%--color: {background: '#FED153', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"green_layer_1": {--%>
                    <%--color: {background: '#27D638', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"blue_layer_1": {--%>
                    <%--color: {background: '#7A97BB', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"red_layer_1": {--%>
                    <%--color: {background: '#FF5E36', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"yellow_layer_2": {--%>
                    <%--color: {background: '#FED666', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"green_layer_2": {--%>
                    <%--color: {background: '#36DA46', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"blue_layer_2": {--%>
                    <%--color: {background: '#87A1C2', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"red_layer_2": {--%>
                    <%--color: {background: '#FF6D49', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"yellow_layer_3": {--%>
                    <%--color: {background: '#FEDC7A', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"green_layer_3": {--%>
                    <%--color: {background: '#47DD55', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"blue_layer_3": {--%>
                    <%--color: {background: '#94ABC9', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"red_layer_3": {--%>
                    <%--color: {background: '#FF7D5D', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"yellow_layer_4": {--%>
                    <%--color: {background: '#FEE18D', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"green_layer_4": {--%>
                    <%--color: {background: '#58E064', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"blue_layer_4": {--%>
                    <%--color: {background: '#A1B6CF', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"red_layer_4": {--%>
                    <%--color: {background: '#FF8D71', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"yellow_layer_5": {--%>
                    <%--color: {background: '#FFE6A1', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"green_layer_5": {--%>
                    <%--color: {background: '#68E374', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"blue_layer_5": {--%>
                    <%--color: {background: '#AEC0D6', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"red_layer_5": {--%>
                    <%--color: {background: '#FF9D84', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--},--%>
                <%--"proposed": {--%>
                    <%--color: {background: '#17b2ad', border: '#172B4D'},--%>
                    <%--borderWidth: 2,--%>
                    <%--font: {color: 'black', multi: 'html'}--%>
                <%--}--%>
            <%--},--%>
            <%--//nodedesign--%>
            <%--"nodes": {--%>
                <%--"font": {--%>
                    <%--"face": 'Lato'--%>
                <%--},--%>
                <%--"margin": {--%>
                    <%--"top": 10,--%>
                    <%--"right": 10,--%>
                    <%--"bottom": 10,--%>
                    <%--"left": 10--%>
                <%--}--%>
            <%--},--%>
            <%--//edgedesign--%>
            <%--"edges": {--%>
                <%--"font": {--%>
                    <%--"face": 'Lato',--%>
                    <%--"align": 'bottom'--%>
                <%--},--%>
                <%--"smooth": {--%>
                    <%--"type": "curvedCW",--%>
                    <%--"forceDirection": "none",--%>
                    <%--"roundness": 0   // This is max roundness--%>
                <%--}--%>
            <%--},--%>
            <%--//physics, interaction--%>
            <%--"layout": {--%>
                <%--"hierarchical":--%>
                    <%--{--%>
                        <%--"enabled": true,--%>
                        <%--"nodeSpacing": 150,--%>
                        <%--"blockShifting": false,--%>
                        <%--"edgeMinimization": false,--%>
                        <%--"sortMethod": "directed"--%>
                    <%--},--%>
                <%--"randomSeed": 9--%>
            <%--},--%>
            <%--"interaction": {--%>
                <%--"multiselect": true,--%>
                <%--"navigationButtons": false--%>
            <%--},--%>
            <%--"physics": {--%>
                <%--"enabled": true,--%>
                <%--'forceAtlas2Based': {--%>
                    <%--'gravitationalConstant': 26,--%>
                    <%--'centralGravity': 0.005,--%>
                    <%--'springLength': 230,--%>
                    <%--'springConstant': 0.18,--%>
                    <%--'avoidOverlap': 10--%>
                <%--},--%>
                <%--'maxVelocity': 146,--%>
                <%--'solver': 'forceAtlas2Based',--%>
                <%--'timestep': 0.35,--%>
                <%--'stabilization': {--%>
                    <%--'enabled': true,--%>
                    <%--"iterations": 1000,--%>
                    <%--"updateInterval": 25--%>
                    <%--// "minVelocity": 50,--%>
                    <%--// // "repulsion": {--%>
                    <%--// //     "nodeDistance": 150--%>
                    <%--// // },--%>
                    <%--// "barnesHut":--%>
                    <%--//     {--%>
                    <%--//         "avoidOverlap": 1--%>
                    <%--//     },--%>
                    <%--// "stabilization": {--%>
                    <%--//     "enabled": true,--%>
                    <%--//     "iterations": 50, // maximum number of iteration to stabilize--%>
                    <%--//     "updateInterval": 1,--%>
                    <%--//     "onlyDynamicEdges": false,--%>
                    <%--//     "fit": true--%>
                <%--}--%>
            <%--}--%>
        <%--};--%>

        <%--//initialize network--%>
        <%--let network = new vis.Network(networkContainer, data, options);--%>

        <%--network.on("stabilizationIterationsDone", function () {--%>
            <%--network.setOptions({physics: false});--%>
        <%--});--%>

        <%--//interact with network--%>

        <%--//if a node is selected display information in infobox--%>
        <%--network.on("selectNode", function (params) {--%>
            <%--params.event = "[original event]";--%>

            <%--$(".infobox").css("display", "flex");--%>

            <%--//get information of selected issue--%>
            <%--let node = nodes.get(params.nodes);--%>
            <%--let issueID = node[0].id;--%>

            <%--let issueNode = findElement(nodeEdgeObject.nodes, "nodeid", issueID);--%>

            <%--let issueKey = issueNode.id;--%>
            <%--let issueLink = "https://bugreports.qt.io/browse/" + issueKey;--%>
            <%--let issueLinkTestJIRA = "https://bugreports-test.qt.io/browse/" + issueKey;--%>
            <%--let issueTitle = issueNode.name;--%>
            <%--let issueStatus = issueNode.status;--%>
            <%--let issueResolution = issueNode.resolution;--%>
            <%--let issueEnvironment = issueNode.environment;--%>
            <%--let issueComponent = issueNode.components;--%>
            <%--let issueLabel = issueNode.labels;--%>
            <%--let issueVersion = issueNode.versions;--%>
            <%--let issuePlatform = issueNode.platforms;--%>
            <%--let issueFixVersion = issueNode.fixversion;--%>

            <%--//update corressponding element in HTML--%>
            <%--document.getElementById('infoBoxHeading').innerHTML = "".concat(issueKey);--%>
            <%--document.getElementById('infoBoxIssueLink').innerHTML = '<a href=\"' + issueLink + '\" class=\"button jira  button-effect-orange center\" target="_blank">View Issue in Qt JIRA</a>';--%>
            <%--document.getElementById('infoBoxIssueLinkTestJIRA').innerHTML = '<a href=\"' + issueLinkTestJIRA + '\" class=\"button jira  button-effect-orange center\" target="_blank">View Issue in Qt Test JIRA</a>';--%>
            <%--document.getElementById('infoBoxIssueStatus').innerHTML = "<b>Status: </b>".concat(issueStatus);--%>
            <%--document.getElementById('infoBoxIssueSummary').innerHTML = "<b>Summary: </b>".concat(issueTitle);--%>
            <%--document.getElementById('infoBoxIssueResolution').innerHTML = "<b>Resolution: </b>".concat(issueResolution);--%>
            <%--document.getElementById('infoBoxIssueEnv').innerHTML = "<b>Environment: </b>".concat(issueEnvironment);--%>
            <%--document.getElementById('infoBoxIssueComponent').innerHTML = "<b>Component: </b>".concat(issueComponent);--%>
            <%--document.getElementById('infoBoxIssueLabel').innerHTML = "<b>Label: </b>".concat(issueLabel);--%>
            <%--document.getElementById('infoBoxIssueVersion').innerHTML = "<b>Version: </b>".concat(issueVersion);--%>
            <%--document.getElementById('infoBoxIssueFix').innerHTML = "<b>Fix Version: </b>".concat(issueFixVersion);--%>
            <%--document.getElementById('infoBoxIssuePlatform').innerHTML = "<b>Platform(s): </b>".concat(issuePlatform);--%>
        <%--});--%>

    <%--});--%>

    <%--$(document).on("load")--%>


    <%--//    ######GRAVEYARD & INFORMATION######--%>
    <%--//    LINKS in Qt and OpenReq JSON--%>
    <%--//         'CONTRIBUTES'--%>
    <%--//         'DAMAGES'--%>
    <%--//         'REFINES'        work breakdown, test--%>
    <%--//         'REQUIRES'       dependency--%>
    <%--//         'INCOMPATIBLE'--%>
    <%--//         'DECOMPOSITION'  sub-task, epic--%>
    <%--//         'SIMILAR'        relates--%>
    <%--//         'DUPLICATES'     duplicate--%>
    <%--//         'REPLACES'       replaces--%>
<%--</script>--%>
<%--</body>--%>
<%--</html>--%>