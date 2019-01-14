# OpenReq Issue Link Map

This web application was created as a result of the OpenReq project funded by the European Union Horizon 2020 Research and Innovation programme under grant agreement No 732463.

This web application visualizes the links between issues inside Qt’s JIRA. It uses the microservices of UH to manage links and the similarity detection of UPC to recommend missing links.

## Technical description
The following technologies are used:
- Spring Boot
- Tomcat
- Vis.js
- Google Gson
- Okhttp3 
- Maven
- Bootstrap

### Functionalities of the OpenReq Issue Link Map
#### Currently available features
- Visualization of the link network of public issues in Qt’s JIRA (bugreports.qt.io)
While in JIRA the user can only see the direct links, this tool enables the user to go more in-depth and also view indirect links between JIRA items.
- Quick info for selected issue
Essential information of an issue is displayed on the right-hand side.
- Navigating the link network
The user can drag items and add or remove layers.

#### Functionalities in development
- Accepting & rejecting proposed links
The results of a similarity detection are also visualized, this view should be toggled on and off. While the similarity detection is enabled the user is given a list where he can decide what type of link should be used or if this proposed link should not be a link.
- Editing links
By right-clicking an edge, the user can change the link type, switch direction or remove the link
Filtering the issue link map for specified properties
To support the user in navigating this link network filters should be in place to hide issues depending on their status, the link type between them.

### Accessing the application
The application is accessible here: http://217.172.12.199:10201

Additionally, a connection to the tool is in https://bugreports-test.qt.io/secure/Dashboard.jspa.

#### What does this application do?
Visualising the link network and recommending missing links.

### What’s next?
- Accepting and rejecting proposed links
- Disabling / Enabling the detection view 

### Challenges
Only the public issues are available. If a person has a Qt account, they should be able to see all the issues In the link map that they would be able to see in JIRA.

### Technical structure
![techstructure](https://github.com/OpenReqEU/qthulhu/blob/master/TechnicalStructure.png)
The service sends a request (JIRA keys, e.g. “QTWB-30”) for data to mulperi and receives a JSON with the issue data. This data is then visualized.

## How to contribute
See OpenReq project contribution guidelines.

## License
Free use of this software is granted under the terms of the EPL version 2 (EPL2.0).
