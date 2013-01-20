require 'spec_helper'

describe 'backoffice', type: :feature do
  fixtures :products
  fixtures :users

  it 'processes an order', js: true do
    cs_book = products :coffee
    user = users :one

    Order.count.should eq(0)

    visit '/'
    find("#product_#{cs_book.id}").click
    find('div#cart').should have_content cs_book.title
    find('div#cart input[value="Checkout"]').click
    find('div#main').should have_content 'Please Enter Your Details'
    fill_in 'Name', with: 'Daniel Hedrick'
    fill_in 'Address', with: '1234 Main Street'
    fill_in 'Email', with: 'daniel@hedrick.org'
    select 'Credit card', from: 'Pay type'
    find('input[value="Place Order"]').click
    page.should have_content 'Thank you for your order'

    Order.count.should eq(1)

    visit '/login'
    page.should have_content 'Please Log In'
    fill_in 'Name', with: user.name
    fill_in 'Password', with: 'secret'
    find('input[value="Login"]').click
    page.should have_content 'Welcome'

    click_link 'Orders'
    page.should have_content 'Daniel Hedrick'
    page.should have_content '1234 Main Street'
    within('div#main table') do
      click_link 'Show'
    end
    page.should have_content 'Credit card'

    click_link 'Edit'
    select 'Check', from: 'Pay type'
    find('input[value="Place Order"]').click
    page.should have_content 'Order was successfully updated'
    page.should have_content 'Check'

    click_link 'Back'
    page.execute_script 'window.confirm = function() { return false; }'
    click_link 'Destroy'

    click_link 'Orders'
    page.should have_content 'Daniel Hedrick'
    page.should have_content '1234 Main Street'
    page.execute_script 'window.confirm = function() { return true; }'
    click_link 'Destroy'

    page.should_not have_content 'Daniel Hedrick'
    page.should_not have_content '1234 Main Street'

    Order.count.should eq(0)
  end

  it 'manages products', js: true do
    user = users :one

    visit '/login'
    page.should have_content 'Please Log In'
    fill_in 'Name', with: user.name
    fill_in 'Password', with: 'secret'
    find('input[value="Login"]').click
    page.should have_content 'Welcome'

    click_link 'Products'
    Product.count.should eq(3)

    click_link 'New product'
    fill_in 'Title', with: 'The Great American Novel'
    fill_in 'Description', with: 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    find('input[value="Create Product"]').click

    find('div#error_explanation').should have_content "Image url can't be blank"
    find('div#error_explanation').should have_content "Price is not a number"

    fill_in 'Image url', with: 'novel.jpg'
    fill_in 'Price', with: '12.34'
    find('input[value="Create Product"]').click

    page.should have_content 'Product was successfully created'

    click_link 'Back'
    Product.count.should eq(4)

    page.execute_script 'window.confirm = function() { return true; }'
    within('div#main table tr:last') do
      click_link 'Destroy'
    end

    Product.count.should eq(3)
  end
end
