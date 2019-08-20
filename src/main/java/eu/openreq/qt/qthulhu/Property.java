package eu.openreq.qt.qthulhu;


public class Property {

    //You can change these to match your URLs
//    public static final String transitiveClosureURL = "https://api.openreq.eu/milla/getTransitiveClosureOfRequirement?requirementId=";
//    public static final String topProposedLinksURL = "https://api.openreq.eu/milla/getTopProposedDependenciesOfRequirement?requirementId=";
//    public static final String updateProposedDependenciesURL = "https://api.openreq.eu/milla/updateProposedDependencies";
//    public static final String consistencyCheckURL = "https://api.openreq.eu/milla/getConsistencyCheckForRequirement?requirementId=";
//
//
//    public static final String transitiveClosureURL = "https://bugreports-test.qt.io/rest/fisutankki/1/getTransitiveClosureOfRequirement?requirementId=";
//    public static final String topProposedLinksURL = "https://bugreports-test.qt.io/rest/fisutankki/1/getTopProposedDependenciesOfRequirement?requirementId=";
//    public static final String updateProposedDependenciesURL = "https://bugreports-test.qt.io/rest/fisutankki/1/updateProposedDependencies";
//    public static final String consistencyCheckURL = "https://bugreports-test.qt.io/rest/fisutankki/1/getConsistencyCheckForRequirement?requirementId=";

    public static final String transitiveClosureURL = "http://217.172.12.199:9203/getTransitiveClosureOfRequirement?requirementId=";
    public static final String topProposedLinksURL = "http://217.172.12.199:9203/getTopProposedDependenciesOfRequirement?requirementId=";
    public static final String updateProposedDependenciesURL = "http://217.172.12.199:9203/updateProposedDependencies";
    public static final String consistencyCheckURL = "http://217.172.12.199:9203/getConsistencyCheckForRequirement?requirementId=";

    public static final String jiraAuthorizationAddress = "https://bugreports-test.qt.io/rest/fisutankki/1/getJiraAuthorizationAddress";
    public static final String verifyAuthAddress = "https://bugreports-test.qt.io/rest/fisutankki/1/verifyJiraAuthorization";
}