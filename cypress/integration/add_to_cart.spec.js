/// <reference types="cypress" />

describe('Jungle Rails app', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000')
  })

  it("should go to the products detail homepage", () => {
    cy
      .get('a[href="/cart"]')
      .should('have.text', ' \n          My Cart (0) ')

    cy
      .get('form')
      .first()
      .submit()

    cy
    .get('a[href="/cart"]')
    .should('have.text', ' \n          My Cart (1) ')
  });

})
