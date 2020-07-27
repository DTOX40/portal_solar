require 'rails_helper'

feature 'Personalized search' do
  scenario 'successfully' do
    create(:power_generator)

    visit root_path
    fill_in 'weg', with: 'metalico'
    click_on 'Recomendações'

    expect(page).to have_link('TRIFÁSICO 380V')
  end
end