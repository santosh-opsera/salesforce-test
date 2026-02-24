/**
 * Sample Apex service for package validation and SonarQube scanning.
 * Repository path for pipelines: use repo root (.) or salesforce/ subfolder.
 */
public with sharing class SampleService {
    /**
     * Returns a greeting message.
     * @return Greeting string
     */
    public static String getGreeting() {
        return 'Hello from Salesforce';
    }
}
