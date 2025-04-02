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

test.after.always(t => {
    t.context.server.close();
});

// Happy Scenario

test('PUT /reservations/:reservationId - successful case', async t => {
    try {
        const response = await t.context.got.put('reservations/0?userId=6', {
            searchParams: {
                userId: 6,
            },
            json: {
                reservationId: 0,
                userId: 6,
                businessId: 1,
                reservationTime: "18:00",
                reservationDay: 15,
                reservationMonth: 10,
                reservationYear: 2025,
                numberOfPeople: 4,
                username: "username",
                businessName: "businessName",
            },
        });

        t.is(response.statusCode, 200);
        t.deepEqual(response.body, {
            reservationId: 0,
            userId: 6,
            businessId: 1,
            reservationTime: "18:00",
            reservationDay: 15,
            reservationMonth: 10,
            reservationYear: 2025,
            numberOfPeople: 4,
            username: "username",
            businessName: "businessName",
        });
    } catch (error) {
        console.error('Error:', error.response ? error.response.body : error.message);
        t.fail('Request failed');
    }
});

// Unhappy Scenario: Missing userId in query parameters

test('PUT /reservations/:reservationId - missing userId', async t => {
    try {
        await t.context.got.put('reservations/{reservationId}=0?userId=', {
            json: {
                reservationTime: "18:00",
                reservationDay: 15,
                reservationMonth: 10,
                reservationYear: 2025,
                numberOfPeople: 4,
            },
        });
        t.fail('Request should have failed');
    } catch (error) {
        t.is(error.response.statusCode, 400);
        t.regex(error.response.body.message, /userId/);
    }
});

// Unhappy Scenario: Missing reservationId in the URL path

test('PUT /reservations/:reservationId - missing reservationId', async t => {
    try {
        await t.context.got.put('reservations/{reservationId}=?userId=6', {
            searchParams: {
                userId: 6,
                // Missing reservationId
            },
            json: {
                reservationTime: "18:00",
                reservationDay: 15,
                reservationMonth: 10,
                reservationYear: 2025,
                numberOfPeople: 4,
            },
        });
        t.fail('Request should have failed');
    } catch (error) {
        t.is(error.response.statusCode, 400); // Adjusted to match the expected status code
        t.regex(error.response.body.message, /reservationId/);
    }
});

// Unhappy Scenario: Invalid reservationTime format

test('PUT /reservations/:reservationId - invalid reservationTime format', async t => {
    try {
        await t.context.got.put('reservations/0?userId=6', {
            searchParams: {
                userId: 6,
            },
            json: {
                reservationTime: "25:00", // Invalid time
                reservationDay: 15,
                reservationMonth: 10,
                reservationYear: 2025,
                numberOfPeople: 4,
            },
        });
        t.fail('Request should have failed');
    } catch (error) {
        t.is(error.response.statusCode, 400);
        t.regex(error.response.body.message, /reservationTime/);
    }
});

// Unhappy Scenario: Reservation date in the past

test('PUT /reservations/:reservationId - reservation date in the past', async t => {
    try {
        await t.context.got.put('reservations/0?userId=6', {
            searchParams: {
                userId: 6,
            },
            json: {
                reservationTime: "18:00",
                reservationDay: 1,
                reservationMonth: 1,
                reservationYear: 2020, // Past date
                numberOfPeople: 4,
            },
        });
        t.fail('Request should have failed');
    } catch (error) {
        t.is(error.response.statusCode, 400);
        t.regex(error.response.body.message, /request.body.reservationYear should be >= 2024/);
    }
});

// Unhappy Scenario: Invalid numberOfPeople

test('PUT /reservations/:reservationId - invalid numberOfPeople', async t => {
    try {
        await t.context.got.put('reservations/0?userId=6', {
            searchParams: {
                userId: 6,
            },
            json: {
                reservationTime: "18:00",
                reservationDay: 15,
                reservationMonth: 10,
                reservationYear: 2025,
                numberOfPeople: 0, // Invalid value
            },
        });
        t.fail('Request should have failed');
    } catch (error) {
        t.is(error.response.statusCode, 400);
        t.regex(error.response.body.message, /numberOfPeople/);
    }
});