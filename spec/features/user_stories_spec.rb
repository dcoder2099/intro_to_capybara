require 'spec_helper'

describe 'user stories', type: :feature do
  fixtures :products

  it 'buys a product' do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    visit "/"
    page.should have_content 'Your Pragmatic Catalog'

    find("#product_#{ruby_book.id}").click

    find('div#cart').should have_content 'Your Cart'
    find('div#cart').should have_content ruby_book.title

    find('div#cart input[value="Checkout"]').click
    page.should have_content 'Please Enter Your Details'

    fill_in 'Name', with: 'Dave Thomas'
    fill_in 'Address', with: '123 The Street'
    fill_in 'Email', with: 'dave@example.com'
    select 'Check', from: 'Pay type'
    find('input[value="Place Order"]').click
    page.should have_content 'Thank you for your order'

    orders = Order.all
    orders.size.should eq(1)
    order = orders[0]
    order.name.should eq('Dave Thomas')
    order.address.should eq('123 The Street')
    order.email.should eq('dave@example.com')
    order.pay_type.should eq('Check')

    order.line_items.size.should eq(1)
    line_item = order.line_items[0]
    line_item.product.should eq(ruby_book)

    mail = ActionMailer::Base.deliveries.last
    mail.to.should include('dave@example.com')
    mail[:from].value.should eq('Sam Ruby <depot@example.com>')
    mail.subject.should eq('Pragmatic Store Order Confirmation')
  end
end
