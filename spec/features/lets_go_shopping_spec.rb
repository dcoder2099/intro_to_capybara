require 'spec_helper'

describe "let's go shopping", type: :feature do
  fixtures :products
  it 'adds an item to the cart' do
    cs_book = products :coffee
    ruby_book = products :ruby

    visit '/'
    find("#product_#{cs_book.id}").click
    find('div#cart').should have_content cs_book.title
    find("#product_#{ruby_book.id}").click
    find('div#cart').should have_content ruby_book.title
    find('div#cart').should have_content ruby_book.price
  end

  it 'empties the cart' do
    ruby_book = products :ruby

    visit '/'
    find("#product_#{ruby_book.id}").click
    find('div#cart').should have_content ruby_book.title
    find('div#cart input[value="Empty cart"]').click
    find('div#cart').should_not have_content ruby_book.title
    find('div#cart').should_not have_content ruby_book.price
  end

  it 'can check out' do
    cs_book = products :coffee

    visit '/'
    find("#product_#{cs_book.id}").click
    find('div#cart').should have_content cs_book.title
    find('div#cart input[value="Checkout"]').click
    find('div#main').should have_content 'Please Enter Your Details'
  end

  it 'can place an order' do
    cs_book = products :coffee

    visit '/'
    find("#product_#{cs_book.id}").click
    find('div#cart').should have_content cs_book.title
    find('div#cart input[value="Checkout"]').click
    find('div#main').should have_content 'Please Enter Your Details'
    fill_in 'Name', with: 'Daniel Hedrick'
    fill_in 'Address', with: '1234 Main Street'
    fill_in 'Email', with: 'daniel@hedrick.org'
    select 'Check', from: 'Pay type'
    find('input[value="Place Order"]').click
    page.should have_content 'Thank you for your order'
  end

  it 'is unified, grandly (with a failure case)' do
    cs_book = products :coffee
    ruby_book = products :ruby
    test_book = products :test

    # Humble beginnings
    visit '/'

    # First item into cart
    find("#product_#{cs_book.id}").click
    find('div#cart').should have_content cs_book.title
    find('div#cart').should have_content cs_book.price

    # Second item replaces first
    find("#product_#{ruby_book.id}").click
    find('div#cart').should have_content ruby_book.title
    find('div#cart').should have_content ruby_book.price

    # Empty the cart
    find('div#cart input[value="Empty cart"]').click
    find('div#cart').should_not have_content ruby_book.title
    find('div#cart').should_not have_content ruby_book.price

    # Now add something back (can you imagine how tedious this is, manually?!)
    find("#product_#{test_book.id}").click
    find('div#cart').should have_content test_book.title
    find('div#cart').should have_content test_book.price

    # Checking out
    find('div#cart input[value="Checkout"]').click
    find('div#main').should have_content 'Please Enter Your Details'

    # Ensure proper errors show up
    find('input[value="Place Order"]').click
    find('div#error_explanation').should have_content "Name can't be blank"
    find('div#error_explanation').should have_content "Address can't be blank"
    find('div#error_explanation').should have_content "Email can't be blank"
    find('div#error_explanation').should have_content "Pay type is not included in the list"

    # Fill out the form (demo of scoping behavior)
    within('form#new_order') do
      fill_in 'Name', with: 'Daniel Hedrick'
      fill_in 'Address', with: '1234 Main Street'
      fill_in 'Email', with: 'daniel@hedrick.org'
      select 'Check', from: 'Pay type'
      find('input[value="Place Order"]').click
    end

    page.should have_content 'Thank you for your order'
  end
end
