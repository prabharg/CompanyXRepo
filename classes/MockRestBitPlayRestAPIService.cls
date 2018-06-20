@isTest
global class MockRestBitPlayRestAPIService implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('[{"code": "BTC","name": "Bitcoin","rate": 1},{"code": "USD","name": "US Dollars","rate": 11.31}]');
        res.setStatusCode(200);
        return res;
    }
}