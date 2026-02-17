/**
 * Test class for SampleService.
 */
@IsTest
private class SampleServiceTest {
    @IsTest
    static void testGetGreeting() {
        Test.startTest();
        String result = SampleService.getGreeting();
        Test.stopTest();
        System.assertNotEquals(null, result, 'Greeting should not be null');
        System.assert(result.contains('Hello'), 'Greeting should contain Hello');
    }
}
