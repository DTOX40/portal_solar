require 'rails_helper'

feature 'Visitor does a simple search' do
  scenario 'successfully' do
    create(:power_generator)

    visit root_path
    fill_in 'Digite sua busca?', with: 'trifásico'
    click_on 'Pesquisa Simples'

    expect(page).to have_link('TRIFÁSICO 380V')
  end

  scenario 'and finds no results' do
    create(:power_generator)

    visit root_path
    fill_in 'Digite sua busca?', with: 'ruby on rails'
    click_on 'Pesquisa Simples'

    expect(page).to have_content('Desculpe não temos resultados para a sua busca.')
  end
end
