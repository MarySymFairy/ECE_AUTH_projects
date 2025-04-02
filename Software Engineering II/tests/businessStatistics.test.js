const test = require('ava');
const got = require('got');
const http = require('http');
const app = require('../index.js');

test.before(async (t) => {
     t.context.server = http.createServer(app);
     const server = t.context.server.listen();
     const {port} = server.address();
     t.context.got = got.extend({responseType: 'json', prefixUrl: `http://localhost:${port}`});
    //t.context.server = app.listen(8080); // Bind to a fixed port
    //t.context.got = got.extend({ responseType: 'json', prefixUrl: 'http://localhost:8080' });
});

test.after.always((t) => {
    t.context.server.close();
});

test("GET /business-statistics?businessId&ownerId - Should return a list of business statistics for a valid businessId and ownerId", async (t) => {
    const {body, statusCode} = await t.context.got.get('business-statistics?ownerId=7&businessId=8');
    t.is(statusCode, 200, "Response status should be 200");
    t.true(Array.isArray(body), "Response body should be an array");
    t.true(body.length > 0, "Response body should not be empty");

    const businessStatistics = body[0];
    t.not(businessStatistics.businessId, undefined, "Business should have a businessId");
    t.not(businessStatistics.ownerId, undefined, "Business should have an ownerId");
    t.not(businessStatistics.month, undefined, "Business should have a month");
    t.not(businessStatistics.numberOfReservations, undefined, "Business should have a numberOfReservations");
});

test("GET /business-statistics?businessId&ownerId - Should return an error message for an invalid ownerId", async (t) => {
    const invalid_ownerId = "invalidOwnerId";
    const error = await t.throwsAsync(() => t.context.got.get(`business-statistics?businessId=1&ownerId=${invalid_ownerId}`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /business-statistics?businessId&ownerId - Should return an error message for an invalid businessId", async (t) => {
    const invalid_businessId = "invalidBusinessId";
    const error = await t.throwsAsync(() => t.context.got.get(`business-statistics?businessId=${invalid_businessId}&ownerId=1`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /business-statistics?businessId&ownerId - Should return an error message for an empty ownerId", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-statistics?businessId=8&ownerId=`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /business-statistics?businessId&ownerId - Should return an error message for an empty businessId", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-statistics?businessId=&ownerId=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /business-statistics?businessId&ownerId - Should return an error message for an empty ownerId and businessId", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-statistics?businessId=&ownerId=`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /business-statistics?businessId&ownerId - Should return an error message for an invalid ownerId and businessId", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-statistics?businessId=ab&ownerId=ab`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /business-statistics?businessId&ownerId - Should return an error message for not found business statistics", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-statistics?businessId=999&ownerId=999`));
    t.is(error.response.statusCode, 404, "Response status should be 404");
});