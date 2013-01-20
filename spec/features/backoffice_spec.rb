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
end
