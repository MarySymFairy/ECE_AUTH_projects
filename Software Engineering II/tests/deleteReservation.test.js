const http = require("http");
const test = require("ava");
const got = require("got");

const app = require('../index.js');

test.before(async (t) => {
    t.context.server = http.createServer(app);
    const server = t.context.server.listen();
    const { port } = server.address();
    t.context.got = got.extend({ responseType: 'json', prefixUrl: `http://localhost:${port}` });
});

test.after.always((t) => {

    t.context.server.close();
});

// DELETE -----------------------------------------------------------------------------
test("DELETE /reservations/:id - Delete nonexistent reservation", async (t) => {
    const reservationId = 56;
    const error = await t.throwsAsync(() =>
      t.context.got.delete(`reservations/${reservationId}?userId=6`, {
        throwHttpErrors: true, // Ensure errors are thrown for non-2xx status codes
      })
    );
  
    // Check that the response has the expected status code and error message
    t.is(error.response.statusCode, 404);
    t.regex(error.response.body.message, /Reservation not found/);
  });


test("DELETE /reservations/:id - Delete reservation (happy path)", async (t) => {
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
        //console.log(getResponse.body);
        t.is(getResponse.statusCode, 200);
        t.deepEqual(getResponse.body, {
            "reservationId": 0,
            "userId": 6,
            "businessId": 1,
            'reservationTime': "12:00",
            'reservationDay': 5,
            'reservationMonth': 5,
            'reservationYear': 2025,
            'numberOfPeople': 7,
            'username': "username",
            'businessName': "businessName",
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


test("DELETE /reservations/:id - Missing reservation ID", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.delete("reservations/?userId=0"));
    t.is(error.response.statusCode, 405); // Adjust based on actual behavior
    t.regex(error.response.body.message, /DELETE method not allowed/);
});

test("DELETE /reservations/:id - Delete reservation with invalid ID format", async (t) => {
    const error = await t.throwsAsync(() => t.context.got.delete("reservations/invalidId"));
    t.is(error.response.statusCode, 400);
    t.regex(error.response.body.message, /request\.query should have required property/);
});