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


//GET--------------------------------------------------------------------------------
// Happy path: Get reservation
test("GET /reservations/:id - Get reservation (happy path)", async (t) => {
    const userId = 6;
    const { body, statusCode } = await t.context.got.get(`reservations/0?userId=${userId}`);
    t.is(statusCode, 200);
    t.is(body.userId, 6);
    t.is(body.businessId, 1);
    t.is(body.reservationTime, "12:00");
});

test("GET /reservations/:id - Get reservation (WITH POST INCLUDED)", async (t) => {
    try {
        // Create a reservation
        const response = await t.context.got.post('reservations?userId=6&businessId=1', {
            searchParams: {
                'userId': 6,
                'businessId': 1, // Use valid business ID
            },
            json: {
                'reservationId': 0,
                'userId': 6,
                'businessId': 1,
                'reservationTime': "12:00",
                'reservationDay': 5,
                'reservationMonth': 5,
                'reservationYear': 2025,
                'numberOfPeople': 7,
                'username': "username",
                'businessName': "businessName", // Match mock data
            },
        });

        t.is(response.statusCode, 200); 
        t.truthy(response.body);

        //GET /reservations/:id
        const getResponse = await t.context.got.get("reservations/0?userId=6");
        t.is(getResponse.statusCode, 200);
        t.deepEqual(getResponse.body, {
            'businessId': 1,
            'businessName': 'businessName',
            'numberOfPeople': 7,
            'reservationDay': 5,
            'reservationId': 0,
            'reservationMonth': 5,
            'reservationTime': '12:00',
            'reservationYear': 2025,
            'userId': 6,
            'username': 'username',
          });

        // Delete the created reservation
        const { body, statusCode } = await t.context.got.delete("reservations/0?userId=6");
        t.is(statusCode, 200);
        t.deepEqual(body, { message: "Reservation deleted." });

    } catch (error) {
        console.error("Error during test:", error.response ? error.response.body : error.message);
        t.fail("Test failed due to an error.");
    }
});

// Error case: Get nonexistent reservation
test("GET /reservations/:id - Get nonexistent reservation", async (t) => {
    const reservationId = 56;
    const error = await t.throwsAsync(() =>
      t.context.got.get(`reservations/${reservationId}?userId=6`, {
        //it worked for deleteReservation.test.js
        throwHttpErrors: true, // Ensure errors are thrown for non-2xx status codes
      })
    );
  
    // Check that the response has the expected status code and error message
    t.is(error.response.statusCode, 404);
    t.regex(error.response.body.message, /Reservation not found/);
});

// GET /reservations/:id - Get reservation with invalid ID format
test("GET /reservations/:id - Get reservation with invalid ID format", async (t) => {
    const invalidId = 'abc123';
    //console.log("invalidId", typeof invalidId);
    const error = await t.throwsAsync(() => t.context.got.get(`reservations/${invalidId}?userId=6`));
    t.is(error.response.statusCode, 400);
    t.is(error.response.body.message, 'request.params.reservationId should be integer');
});



//GET ALL-----------------------------------------------------------------------------
// Happy path: Get all reservations
test("GET /reservations - Retrieve all reservations (happy path)", async (t) => {
    const { body, statusCode } = await t.context.got.get("reservations?userId=6");
    t.is(statusCode, 200);
    t.true(Array.isArray(body));
    t.true(body.length > 0);
    body.forEach((reservation) => {
        t.is(reservation.reservationId >= 0, true);
        t.is(reservation.userId >= 0, true);
        t.is(reservation.businessId >= 0, true);
        t.truthy(reservation.reservationTime);
        t.truthy(reservation.reservationDay);
        t.truthy(reservation.reservationMonth);
        t.truthy(reservation.reservationYear);
        t.truthy(reservation.numberOfPeople);
        t.truthy(reservation.username);
        t.truthy(reservation.businessName);
    });
});

// Error case: Get reservations with invalid query parameters
test("GET /reservations?userId=aba - Retrieve reservations with invalid query parameters (error case)", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get("reservations?userId=aba"));
    t.is(error.response.statusCode, 400);
    t.is(error.response.body.message, "request.query.userId should be integer");
});

// Error case: Get reservations with missing query parameters
test("GET /reservations - Retrieve reservations with missing query parameters (error case)", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.get("reservations"));
    t.is(error.response.statusCode, 400);
    t.is(error.response.body.message, "request.query should have required property \'userId\'");
});

// GET /reservations - Retrieve all reservations (no reservations found)
test("GET /reservations?userId=77 - Retrieve all reservations (no reservations found)", async (t) => {
    // Assuming the database is empty for this user
    const { body, statusCode } = await t.context.got.get("reservations?userId=77");
    t.is(statusCode, 200);
    t.true(Array.isArray(body));
    t.is(body.length, 0);
});