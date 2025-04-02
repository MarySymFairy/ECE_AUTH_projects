describe('Swagger /docs Page Test', () => {
  beforeEach(() => {
    cy.visit('http://localhost:8080/docs')
  })

  it('Title exists', () => {
    cy.get('.title').should('contain.text', 'RESERVIO API')
  })

  it('Description exists', () => {
    cy.get('.description').should('include.text', 'Software Engineering II Course Reservio API')
  })

  it('All types of endpoints exists', () => {
    cy.get('.opblock-tag').should('have.length', 5)
  })

  it('Click on businesses endpoint', () => {
    cy.get('#operations-business-getBusinessesByCategory').click();
  })
  
  it('Open businesses endpoint should include description', () => {
    cy.get('#operations-business-getBusinessesByCategory')
      .click()
      .find('.opblock-description')
      .should('include.text', 'FR1: The logged in user must be able to view the businesses that are included in the system divided by categories.')
  })
  
  it('Click on reservations endpoint', () => {
    cy.get('#operations-reservation-viewReservations').click();
  })
  
  it('Open reservations endpoint should include description', () => {
    cy.get('#operations-reservation-viewReservations')
      .click()
      .find('.opblock-description')
      .should('include.text', 'FR10: The logged in user must be able to view his reservations.')
  })
});