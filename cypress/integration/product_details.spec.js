/// <reference types="cypress" />

describe('Jungle Rails app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it("should go to the products detail homepage", () => {
    cy
      .get(".products article")
      .first()
      .click()

      cy.location('pathname').should('eq', '/products/12')
  });

})
