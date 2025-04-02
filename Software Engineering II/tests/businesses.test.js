const test = require('ava');
const got = require('got');
const http = require('http');
const app = require('../index.js');


test.before(async (t) => {
    t.context.server = http.createServer(app);
    const server = t.context.server.listen();
    const {port} = server.address();
    t.context.got = got.extend({responseType: 'json', prefixUrl: `http://localhost:${port}`});
});

test.after.always((t) => {
    t.context.server.close();
});

test("GET /businesses?categoryName=breakfast - Should return a list of businesses for a valid categoryName", async (t) => {
    const {body, statusCode} = await t.context.got.get('businesses?categoryName=breakfast');
    t.is(statusCode, 200, "Response status should be 200");
    t.true(Array.isArray(body), "Response body should be an array");
    t.true(body.length > 0, "Response body should not be empty");

    const business = body[0];
    t.not(business.businessId, undefined, "Business should have a businessId");
    t.not(business.businessName, undefined, "Business should have a businessName");
    t.not(business.ownerId, undefined, "Business should have an ownerId");
    t.not(business.categoryName, undefined, "Business should have a categoryName");
    t.not(business.keyword, undefined, "Business should have keyword");
});

// tests/getBusiness.test.js

test("GET /businesses?categoryName=invalidCategory - Should return an error message for an invalid categoryName", async (t) => {
    const invalid_category = "invalidCategory";
    const error = await t.throwsAsync(() => t.context.got.get(`businesses?categoryName=${invalid_category}`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /businesses?categoryName= - Should return an error message for an empty categoryName", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`businesses?categoryName=`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});




test("GET /businesses/search?keyword=keyword - Should return a list of businesses for a valid keyword", async (t) => {
    const {body, statusCode} = await t.context.got.get('businesses/search?keyword=keyword');
    t.is(statusCode, 200, "Response status should be 200");
    t.true(Array.isArray(body), "Response body should be an array");
    t.true(body.length > 0, "Response body should not be empty");

    const business = body[0];
    t.not(business.businessId, undefined, "Business should have a businessId");
    t.not(business.businessName, undefined, "Business should have a businessName");
    t.not(business.ownerId, undefined, "Business should have an ownerId");
    t.not(business.businessCategory, undefined, "Business should have a categoryName");
    t.not(business.keyword, undefined, "Business should have keyword");
});

test("GET /businesses/search?keyword=invalidKeyword - Should return an error message for an invalid keyword", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`businesses/search?1`));
    t.is(error.response.statusCode, 400, "Bad input parameter");
});

test("GET /businesses/search?keyword= - Should return an error message for an empty keyword", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`businesses/search?`));
    t.is(error.response.statusCode, 400, "Bad input parameter");
});

test("GET /businesses/search?keyword=keyword - Should return an error message for a keyword that does not exist", async (t) => {
    const invalidKeyword = "cute";
    const error = await t.throwsAsync(() => t.context.got.get(`businesses/search?keyword=${invalidKeyword}`));
    t.is(error.response.statusCode, 404, "Business not found with the given keyword");
});