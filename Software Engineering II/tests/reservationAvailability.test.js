const http = require("http");

const test = require("ava");
const got = require("got");

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

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return the availability of a business based on the specific parameters", async (t) => {
    const { body, statusCode } = await t.context.got.get("reservations/availability?businessId=1&reservationDay=5&reservationMonth=5&reservationYear=2025&numberOfPeople=7");
    t.is(statusCode, 200, "Response status should be 200");
    t.true(Array.isArray(body), "Response body should be an array");
    t.true(body.length > 0, "Response body should not be empty");

    // Assert the elements in the array are strings
    t.true(body.every(item => typeof item === "string"), "Each item in the response array should be a string");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an invalid businessId", async (t) => {
    const invalid_businessId = "invalidBusinessId";
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=${invalid_businessId}&reservationDay=5&reservationMonth=5&reservationYear=2025&numberOfPeople=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an invalid reservationDay", async (t) => {
    const invalid_reservationDay = "invalidReservationDay";
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=${invalid_reservationDay}&reservationMonth=5&reservationYear=2025&numberOfPeople=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an invalid reservationMonth", async (t) => {
    const invalid_reservationMonth = "invalidReservationMonth";
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=5&reservationMonth=${invalid_reservationMonth}&reservationYear=2025&numberOfPeople=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an invalid reservationYear", async (t) => {
    const invalid_reservationYear = "invalidReservationYear";
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=5&reservationMonth=5&reservationYear=${invalid_reservationYear}&numberOfPeople=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an invalid numberOfPeople", async (t) => {
    const invalid_numberOfPeople = "invalidNumberOfPeople";
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=5&reservationMonth=5&reservationYear=2025&numberOfPeople=${invalid_numberOfPeople}`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an empty businessId", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=&reservationDay=5&reservationMonth=5&reservationYear=2025&numberOfPeople=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an empty reservationDay", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=&reservationMonth=5&reservationYear=2025&numberOfPeople=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an empty reservationMonth", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=5&reservationMonth=&reservationYear=2025&numberOfPeople=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an empty reservationYear", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=5&reservationMonth=5&reservationYear=&numberOfPeople=7`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return an error message for an empty numberOfPeople", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=5&reservationMonth=5&reservationYear=2025&numberOfPeople=`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/availability?businessId&reservationDay&reservationMonth&reservationYear&numberOfPeople - Should return a not found availabilty ", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/availability?businessId=1&reservationDay=2&reservationMonth=5&reservationYear=2026&numberOfPeople=2`));
    t.is(error.response.statusCode, 404, "Response status should be 404");
});