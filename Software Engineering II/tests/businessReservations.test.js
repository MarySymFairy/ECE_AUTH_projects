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

test.after.always(t => {
    t.context.server.close();
});

const day = 1;
const month = 5;
const year = 2026;
const owner_id = 7;
const business_id = 8;
// GET /businessReservations

//Happy path: Retrieve all reservations 
test("GET /businessReservations - Retrieve all reservations", async (t) => {
    const { body, statusCode } = await t.context.got.get(`business-reservations?ownerId=${owner_id}&businessId=${business_id}&day=${day}&month=${month}&year=${year}`); 
    console.log("hello", body);
    
    t.is(statusCode, 200);
    t.true(Array.isArray(body));
    t.true(body.length > 0);
    body.forEach((br) => {
        t.is(br.reservationId >= 0, true);
        t.is(br.userId >= 0, true);
        t.is(br.ownerId >= 0, true);
        t.is(br.businessId >= 0, true);
        t.truthy(br.reservationTime);
        t.truthy(br.reservationDay);
        t.truthy(br.reservationMonth);
        t.truthy(br.reservationYear);
        t.truthy(br.people);
        t.truthy(br.username);
        t.truthy(br.businessName);
    });
});



//Unhappy path: No existing reservations
 test("GET /businessReservations - No existing reservations/", async (t) => {
    const noReservationsBusinessId = 12;
    const error = await t.throwsAsync(() => t.context.got.get(`business-reservations?ownerId=${owner_id}&businessId=${noReservationsBusinessId}&day=${day}&month=${month}&year=${year}`));
    t.is(error.response.statusCode, 404);
    t.is(error.response.body.message, "No business reservations found.");
  }); 

  
const invalid = "invalid";

//Unhappy path: Invalid owner id
test("GET /businessReservations - Invalid owner id", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-reservations?ownerId=${invalid}&businessId=${business_id}&day=${day}&month=${month}&year=${year}`));
    t.is(error.response.statusCode, 400);
    t.is(error.response.body.message, "request.query.ownerId should be integer");
});

//Unhappy path: Invalid business id
test("GET /businessReservations - Invalid business id", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-reservations?ownerId=${owner_id}&businessId=${invalid}&day=${day}&month=${month}&year=${year}`));
    t.is(error.response.statusCode, 400);
    t.is(error.response.body.message, "request.query.businessId should be integer");
});

//Unhappy path: Invalid day
test("GET /businessReservations - Invalid day", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-reservations?ownerId=${owner_id}&businessId=${business_id}&day=${invalid}&month=${month}&year=${year}`));
    t.is(error.response.statusCode, 400);
    t.is(error.response.body.message, "request.query.day should be integer");
});

//Unhappy path: Invalid month
test("GET /businessReservations - Invalid month", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-reservations?ownerId=${owner_id}&businessId=${business_id}&day=${day}&month=${invalid}&year=${year}`));
    t.is(error.response.statusCode, 400);
    t.is(error.response.body.message, "request.query.month should be integer");
});

//Unhappy path: Invalid year
test("GET /businessReservations - Invalid year", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get(`business-reservations?ownerId=${owner_id}&businessId=${business_id}&day=${day}&month=${month}&year=${invalid}`));
    t.is(error.response.statusCode, 400);
    t.is(error.response.body.message, "request.query.year should be integer");
});