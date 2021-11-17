require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  #RSpect setup
  before :each do #creates 10 products for apparel category beach each test is run
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99,
        image: open_asset('apparel1.jpg')
      )
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG / VERIFY / Commendted out was not needed unless debugging
    save_screenshot

    expect(page).to have_css 'article.product', count: 10 #feature spec testing code - With this line we set our first expectation of content we expect the user to see on the page. Since each _product partial renders an article with class product and each page contains 10 products, we are expecting to find all produts on the page (count 10)
  end

end
