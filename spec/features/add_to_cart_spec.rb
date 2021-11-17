require 'rails_helper'

RSpec.feature "Visitor Navigates to HomePage and Adds Product to Cart ", type: :feature do
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

  scenario "They see MyCart increase from 0 to 1" do
    visit root_path
    expect(page).to have_content("My Cart (0)")

    page.find(".products article:first-child").click_on "Add"
    
    expect(page).to have_content("My Cart (1)")
    puts page.html
  end
end
