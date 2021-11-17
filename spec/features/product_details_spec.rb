require 'rails_helper'

RSpec.feature "Visitor navigates to product details page from home page", type: :feature, js: true do
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

  scenario "They see product details for selected product" do
    visit root_path
    page.find(".products article:first-child").click_on "Details"


    expect(page).to have_css 'article.product-detail', count: 1
    save_screenshot
  end


end
