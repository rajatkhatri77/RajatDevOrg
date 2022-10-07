@isTest
global class Test_qrCodeGeneretorMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('Hello from Mock test class');
        response.setStatusCode(200);
        return response; 
    }
}