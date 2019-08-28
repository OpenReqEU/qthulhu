// /*TODO: Make cookie permanent for the duration of the stay on the website*/
// /**
//  *  @file         requests.js
//  *  @overview
//  *  @version      0.9
//  *  @author       Volodymyr Biryuk <4biryuk@informatik.uni-hamburg.de>
//  *
//  */
// "use strict";
//
// /**
//  * Send a HTTP POST request.
//  * @param {string} url The full URL.
//  * @param {JSON} body Request body as JSON.
//  * @param {Array} headerProperties Request header properties to be added to the default header.
//  */
// function postRequest(url, body, headerProperties) {
//     var xhr = new XMLHttpRequest();
//     xhr.open('POST', url);
//     for (var key in headerProperties) {
//         xhr.setRequestHeader(key, headerProperties[key]);
//     }
//     xhr.onload = function () {
//         if (xhr.status === 200) {
//             console.log(xhr.status);
//         }
//         else {
//             console.log(xhr.status);
//         }
//     };
//     xhr.send(body);
// }
//
// /**
//  * Send a HTTP GET request.
//  * @param {string} url The full URL.
//  * @param {Array} headerProperties Request header properties to be added to the default header.
//  */
// function getRequest(url, headerProperties) {
//     let xhr = new XMLHttpRequest();
//     xhr.open('GET', url);
//     if (headerProperties != null) {
//         for (let key in headerProperties) {
//             xhr.setRequestHeader(key, headerProperties[key]);
//         }
//     }
//     xhr.onload = function () {
//         if (xhr.status === 200) {
//             console.log(xhr.status);
//         }
//         else {
//             console.log(xhr.status);
//         }
//     };
//     xhr.send(null);
// }
//
//
// /**
//  * Log an Event.
//  * @param {Event} event The Event to log
//  */
// function log(event) {
//     let simplifiedEvent = simplifyObject(event);
//     let eventJson = JSON.stringify(simplifiedEvent);
//     send_log(eventJson);
// }
//
// /**
//  * Send log with al necessary data.
//  * @param {JSON} log The information to log.
//  */
// function send_log(log) {
//     // let url = "http://0.0.0.0:9798/fe/log";
//     let url = "https://openreq.esl.eng.it/hitec/ri-logging/fe/log";
//     let sessionId = getCookie("sessionId");
//     let header = {"sessionId": sessionId, "Content-Type": "application/json"};
//     post(url, log, header);
// }
//
//
// function getRequestJQ(url) {
//     console.log("Sending Request");
//     $.ajax({
//         'url': url,
//         'type': 'GET',
//         'data': "",
//         'success': function (data) {
//             //You can use any jQuery/JavaScript here!!!
//             // if (data == "success") {
//             //     alert('request sent!');
//             // }
//         }
//     });
// }