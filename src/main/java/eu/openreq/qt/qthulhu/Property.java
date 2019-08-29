package eu.openreq.qt.qthulhu;


public class Property {

    private Property(){

    }
    //You can change these to match your URLs
    public static final String TRANSITIVE_CLOSURE_URL = "https://api.openreq.eu/milla/getTransitiveClosureOfRequirement?requirementId=";
    public static final String TOP_PROPOSED_LINKS_URL = "https://api.openreq.eu/milla/getTopProposedDependenciesOfRequirement?requirementId=";
    public static final String UPDATE_PROPOSED_DEPENDENCIES_URL = "https://api.openreq.eu/milla/updateProposedDependencies";
    public static final String CONSISTENCY_CHECK_URL = "https://api.openreq.eu/milla/getConsistencyCheckForRequirement?requirementId=";

//    public static final String TRANSITIVE_CLOSURE_URL = "https://bugreports-test.qt.io/rest/fisutankki/1/getTransitiveClosureOfRequirement?requirementId=";
//    public static final String TOP_PROPOSED_LINKS_URL = "https://bugreports-test.qt.io/rest/fisutankki/1/getTopProposedDependenciesOfRequirement?requirementId=";
//    public static final String UPDATE_PROPOSED_DEPENDENCIES_URL = "https://bugreports-test.qt.io/rest/fisutankki/1/updateProposedDependencies";
//    public static final String CONSISTENCY_CHECK_URL = "https://bugreports-test.qt.io/rest/fisutankki/1/getConsistencyCheckForRequirement?requirementId=";

//    public static final String TRANSITIVE_CLOSURE_URL = "http://217.172.12.199:9203/getTransitiveClosureOfRequirement?requirementId=";
//    public static final String TOP_PROPOSED_LINKS_URL = "http://217.172.12.199:9203/getTopProposedDependenciesOfRequirement?requirementId=";
//    public static final String UPDATE_PROPOSED_DEPENDENCIES_URL = "http://217.172.12.199:9203/updateProposedDependencies";
//    public static final String CONSISTENCY_CHECK_URL = "http://217.172.12.199:9203/getConsistencyCheckForRequirement?requirementId=";

//    public static final String TRANSITIVE_CLOSURE_URL = "http://localhost:9203/getTransitiveClosureOfRequirement?requirementId=";
//    public static final String TOP_PROPOSED_LINKS_URL = "http://localhost:9203/getTopProposedDependenciesOfRequirement?requirementId=";
//    public static final String UPDATE_PROPOSED_DEPENDENCIES_URL = "http://localhost:9203/updateProposedDependencies";
//    public static final String CONSISTENCY_CHECK_URL = "http://localhost:9203/getConsistencyCheckForRequirement?requirementId=";

    public static final String JIRA_AUTHORIZATION_ADDRESS = "https://bugreports-test.qt.io/rest/fisutankki/1/getJiraAuthorizationAddress";
    public static final String VERIFY_AUTH_ADDRESS = "https://bugreports-test.qt.io/rest/fisutankki/1/verifyJiraAuthorization";
}