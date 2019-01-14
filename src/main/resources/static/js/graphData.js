//this is an example network to get to know vis.js
$(document).ready(function () {

    let nodes = new vis.DataSet([
        {id: 1, label: 'QTBUG-67937', color: {background:'#FB4A08', border: '#172B4D'}, font: {color:'white', face:"Arial", multi: 'html'}},
        {id: 21474836479, label: 'Epic (Parent Issue)', color: {background:'#188322', border: '#172B4D'}, shape: 'box', font: {color:'white', face:"Arial", multi: 'html'}},
        {id: 3, label: 'Related Issue', color: {background:'#3a5372', border: '#172B4D'}, shape: 'box', font: {color:'white', face:"Arial", multi: 'html'}},
        {id: 4, label: 'Child Issue', color: {background:'#188322', border: '#172B4D'}, shape: 'box', font: {color:'white', face:"Arial", multi: 'html'}},
        {id: 5, label: 'Child Issue', color: {background:'#188322', border: '#172B4D'}, shape: 'box', font: {color:'white', face:"Arial", multi: 'html'}},
        {id: 7, label: 'Required Issue', color: {background:'#fecc3f', border: '#172B4D'}, shape: 'box', font: {color:'black', face:"Arial", multi: 'html'}},
        {id: 8, label: 'Duplicate', color: {background:'#188322', border: '#172B4D'}, shape: 'box', font: {color:'white', face:"Arial", multi: 'html'}},
        {id: 9, label: 'Depends on Issue', color: {background:'#fecc3f', border: '#172B4D'}, shape: 'box', font: {color:'black', face:"Arial", multi: 'html'}}
    ]);

// create an array with edges
    let edges = new vis.DataSet([
        {from: 21474836479, to: 1, arrows: 'to', color: '#36B37E', label: 'DECOMPOSITION'},
        {from: 1, to: 4, arrows: 'to', color: '#0052CC', label: 'DECOMPOSITION'},
        {from: 1, to: 5, arrows: 'to', color: '#0052CC', label: 'DECOMPOSITION'},
        {from: 1, to: 3, arrows: 'to', color: '#6554C0', label: 'SIMILAR'},
        {from: 1, to: 7, arrows: 'from', color: '#FF5630', label: 'REQUIRES'},
        {from: 1, to: 8, arrows: 'to', color: '#FF991F', label: 'DUPLICATES'},
        {from: 1, to: 9, arrows: 'to', color: '#FF5630', label: 'REQUIRES'}
    ]);

// create a network
    let networkContainer = document.getElementById('mynetwork');

// provide the data in the vis format
    let data = {
        nodes: nodes,
        edges: edges
    };
    let options = {
        "layout": {
            "randomSeed": 8
            // "hierarchical":
            //     {
            //         "direction": "UD",
            //         "sortMethod": "directed",
            //         "nodeSpacing": 200
            //     }
        },
        "physics": {
            "enabled": true,
            "minVelocity": 0
            // "repulsion": {
            //     "nodeDistance": 50
            // },
            // "barnesHut":
            //     {
            //         "avoidOverlap": 0.01
            //     }
        }
    };

// initialize your network!
    let network = new vis.Network(networkContainer, data, options);

});