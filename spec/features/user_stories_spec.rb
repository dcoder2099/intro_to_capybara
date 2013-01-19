require 'spec_helper'

describe 'user stories', type: :feature do
  fixtures :products

  it 'buys a product' do
    LineItem.delete_all
    Order.delete_all
    ruby_book = products(:ruby)

    visit "/"
    page.should have_content 'Your Pragmatic Catalog'

    orders = Order.all
    orders.size.should eq(1)
  end
end
