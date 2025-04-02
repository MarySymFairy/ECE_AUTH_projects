describe('Reservation API Tests', () => {
    const baseUrl = 'http://localhost:8080'; // Replace with your actual base URL
  
    beforeEach(() => {
      cy.visit(`${baseUrl}/docs`);
    });
  
    it('Should fetch available businesses by category', () => {
      cy.request({
        method: 'GET',
        url: `${baseUrl}/businesses`,
        qs: {
          categoryName: 'breakfast', // Example category
        }
      }).then((response) => {
        expect(response.status).to.eq(200);
        expect(response.body).to.be.an('array');
        expect(response.body[0]).to.have.property('businessName');
        expect(response.body[0]).to.have.property('categoryName', 'breakfast');
      });
    });
  
    it('Should fetch available hours for a reservation', () => {
      cy.request({
        method: 'GET',
        url: `${baseUrl}/reservations/availability`,
        qs: {
          businessId: 1,
          reservationDay: 25,
          reservationMonth: 12,
          reservationYear: 2025,
          numberOfPeople: 2,
        }
      }).then((response) => {
        expect(response.status).to.eq(200);
        expect(response.body).that.is.an('array');
        expect(response.body[0]).to.match(/^([0-1][0-9]|2[0-3]):[0-5][0-9]$/); // HH:mm format
      });
    });
  
    it('Should allow a user to make a reservation', () => {
      cy.request({
        method: 'POST',
        url: `${baseUrl}/reservations`,
        body: {
          reservationTime: '18:00',
          reservationDay: 25,
          reservationMonth: 12,
          reservationYear: 2025,
          numberOfPeople: 3,
          username: 'test_user',
          businessName: 'Test Business',
          userId: 6,
          businessId: 1,
          reservationId: 0,
        },
        qs: {
          userId: 6,
          businessId: 1,
        },
        headers: {
          'Content-Type': 'application/json',
        },
      }).then((response) => {
        expect(response.status).to.eq(200);
        expect(response.body).to.have.property('reservationId');
        expect(response.body).to.have.property('reservationTime', '18:00');
      });
    });
  
    it('Should fetch all reservations for a user', () => {
      cy.request({
        method: 'GET',
        url: `${baseUrl}/reservations`,
        qs: {
          userId: 6,
        }
      }).then((response) => {
        expect(response.status).to.eq(200);
        expect(response.body).to.be.an('array');
        if (response.body.length > 0) {
          expect(response.body[0]).to.have.property('reservationId');
          expect(response.body[0]).to.have.property('userId', 6);
        }
      });
    });
  
    it('Should delete a reservation', () => {
      cy.request({
        method: 'DELETE',
        url: `${baseUrl}/reservations/0`, // Example reservation ID
        qs: {
          userId: 6,
        }
      }).then((response) => {
        expect(response.status).to.eq(200);
        expect(response.body).to.have.property('message', 'Reservation deleted.');
      });
    });
  });