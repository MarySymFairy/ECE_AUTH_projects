describe('TEST endpoint GET reservations & GET reservations/id', () => {
  beforeEach(() => {
    cy.visit('http://localhost:8080/docs')
  })
  
  it('should load the homepage', () => {
    cy.contains('RESERVIO API').should('be.visible');
    cy.contains('Software Engineering II Course Reservio API').should('be.visible');
    cy.contains('Reservation').should('be.visible');
  });
  
  it('should open the GET /reservations/{id} endpoint and try to execute', () => {
    cy.get('#operations-reservation-viewAReservation').click();
    cy.contains('Parameters').should('be.visible'); // Check if the parameters section is shown
    cy.get('.btn.try-out__btn').should('be.visible').click(); // Click on the "Try it out" button
    cy.get('input[placeholder="reservationId - ReservationId of the reservation submitted to the system"]').type('12345'); // Enter an id
    cy.get('input[placeholder="userId - UserId of the logged in user that made the reservation"]').type('6');
    cy.get('.btn.execute.opblock-control__btn').click(); // Click on the "Execute" button
    cy.contains('Reservation not found').should('be.visible'); // Check if the response is shown
  });

  it('should display a list of reservations', () => {
    cy.get('#operations-reservation-viewReservations').click();
    cy.contains('Parameters').should('be.visible'); // Check if the parameters section is shown
    cy.get('.btn.try-out__btn').should('be.visible').click(); // Click on the "Try it out" button
    cy.get('input[placeholder="userId - UserId of the logged in user that made the reservation"]').type('6');
    cy.get('.btn.execute.opblock-control__btn').click(); // Click on the "Execute" button
    cy.contains('Response body').should('be.visible'); // Ensure response section is visible
    cy.get('.microlight').should('contain.text', '"reservationId"'); // Check JSON contains reservation data  
      
  });

});