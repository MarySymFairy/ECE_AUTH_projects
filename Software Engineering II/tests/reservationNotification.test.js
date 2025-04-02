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

test("GET /reservations/reservationId/notification?userId - Should return a notifications for the reservation ", async (t) => {
    const { body, statusCode } = await t.context.got.get("reservations/0/notification?userId=6");
    t.is(statusCode, 200, "Response status should be 200");
    t.true(Array.isArray(body), "Response body should be an array");
    t.true(body.length > 0, "Response body should not be empty");

    const notification = body[0];
    t.not(notification.message, undefined, "Notification should have a message");
});

test("GET /reservations/reservationId/notification?userId - Should return an error message for an invalid userId", async (t) => {
    const invalid_userId = "invalidUserId";
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/0/notification?userId=${invalid_userId}`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/reservationId/notification?userId - Should return an error message for an invalid reservationId", async (t) => {
    const invalid_reservationId = "invalidReservationId";
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/${invalid_reservationId}/notification?userId=6`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/reservationId/notification?userId - Should return an error message for an empty userId", async (t) => {
   const error = await t.throwsAsync(() => t.context.got.get(`reservations/0/notification?userId=`));
    t.is(error.response.statusCode, 400, "Response status should be 400");
});

test("GET /reservations/reservationId/notification?userId - Should return an error message for a not found reservation with this userId and reservationId", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/4/notification?userId=0`));
    t.is(error.response.statusCode, 404, "Response status should be 404");
});