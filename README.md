# OpenReq Issue Link Map

This web application was created as a result of the OpenReq project funded by the European Union Horizon 2020 Research and Innovation programme under grant agreement No 732463.

This web application visualizes the links between issues inside Qt’s JIRA. It uses the microservices of UH ([API references](https://api.openreq.eu/#/services/milla)) to manage links and the similarity detection of UPC ([API references](https://api.openreq.eu/#/services/similarity-detection)) to recommend missing links.

## Technical description
### Technologies used
- Spring Boot
- Tomcat
- Vis.js
- Google Gson
- Okhttp3 
- Maven
- Bootstrap

### Functionalities of the OpenReq Issue Link Map
#### Currently available features
- *Visualization* of the link network of public issues in [Qt’s JIRA](https://bugreports.qt.io/secure/Dashboard.jspa)
While in JIRA the user can only see the direct links, this tool enables the user to go more in-depth and also view indirect links between JIRA items.
- Quick *info* for selected issue
Essential information of an issue is displayed on the right-hand side.
- *Navigating* the link network
The user can drag items and add or remove layers.

#### Functionalities in development
- *Accepting & rejecting* proposed links
The results of a similarity detection are also visualized, this view should be toggled on and off. While the similarity detection is enabled the user is given a list where he can decide what type of link should be used or if this proposed link should not be a link.
- *Editing* links
By right-clicking an edge, the user can change the link type, switch direction or remove the link
- *Filtering* the issue link map for specified properties
To support the user in navigating this link network filters should be in place to hide issues depending on their status, the link type between them.

#### Functionalities planned
- *Consistency Checker*
Checking if the issues in the link map do not have conflicting link type and priority

### Accessing the application
The application is accessible here: http://217.172.12.199:10201 
and an older version here: http://bugreports-test.qt.io:10201/

Additionally, a connection to the tool is in https://bugreports-test.qt.io/secure/Dashboard.jspa.

### How to install
This is a maven project, so use 
```
mvn clean package
```
in your IDE and then run 
```
java -jar qthulhu-webapp-1.0.war
```

### How to use
You can directly search for an issue here http://217.172.12.199:10201 or here http://bugreports-test.qt.io:10201/
![Search1](https://github.com/OpenReqEU/qthulhu/blob/master/pics/Search1.png)

for example Issue: QTWB-30 and layer 2.
![Search2](https://github.com/OpenReqEU/qthulhu/blob/master/pics/Search2.png)

which will then give you the LinkMap for issue QTWB-30 with layer 2.
![LinkMapEx](https://github.com/OpenReqEU/qthulhu/blob/master/pics/ExampleLinkMap.png)

Alternatively, you can access the test instance of Qt's jira https://bugreports-test.qt.io/secure/Dashboard.jspa and search for an issue. On the view page you can scroll down Issue Links, underneath this you will find OpenReq Dependency Browser (old name, needs to be updated to OpenReq Link Map)
![Search3](https://github.com/OpenReqEU/qthulhu/blob/master/pics/Search3.png)

#### What does this application do?
Visualising the link network and recommending missing links.

### What’s next?
- Accepting and rejecting proposed links
- Disabling / Enabling the detection view 

### Challenges
Only the public issues are available. If a person has a Qt account, they should be able to see all the issues In the link map that they would be able to see in JIRA.

### Technical structure
![techstructure](https://github.com/OpenReqEU/qthulhu/blob/master/pics/TechnicalStructure.png)
The service sends a request (JIRA keys, e.g. “QTWB-30”) for data to mulperi and receives a JSON with the issue data. This data is then visualized.

## Notes for Developers
I tried to comment most of the code to make it understandable. 
The Java part just gets the data in a vis.js friendlier format. The javascript & HTML/CSS will get some more functionality in the next iterations.

## How to contribute
See [OpenReq project contribution guidelines](https://github.com/OpenReqEU/OpenReq/blob/master/CONTRIBUTING.md). 

## License
Free use of this software is granted under the terms of the [EPL version 2 (EPL2.0)](https://www.eclipse.org/legal/epl-2.0/).
