require 'rails_helper'

RSpec.feature "Visitors can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see cart updates when an item is added to cart: 'My Cart (0)" to "My Cart (1)'" do
    # ACT
    visit root_path
    puts page.html
    click_button("Add", match: :first).click

    # DEBUG
    save_screenshot

    # VERIFY
    expect(page).to have_text 'My Cart (1)'
  end
end