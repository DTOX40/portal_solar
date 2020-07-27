require 'rails_helper'

feature 'show cep' do
  scenario 'successfully' do
    create(:power_generator)
    create(:freight)

    visit root_path
    click_on 'TRIFÁSICO 380V'
    fill_in 'Informe seu CEP', with: '02126070'
    click_on 'Calcular Frete'

    expect(page).to have_content('Valor do Frete: R$ 399.15')
  end
end