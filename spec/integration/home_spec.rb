
require 'rails_helper'

feature 'Visits home page' do
  scenario 'succesfully' do

    visit root_path

    expect(page).to have_content('Geradores de Energia')
    expect(page).to have_content('TRIFÁSICO 380V')
  end

  feature 'Visits home page' do
    scenario 'succesfully' do
  
      visit root_path
      fill_in 'Digite sua busca?', with: 'trifásico'
      click_on 'Comprar'
  
      expect(page).to have_content('Geradores de Energia')
      expect(page).to have_content('TRIFÁSICO 380V')
    end
end