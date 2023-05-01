require 'rails_helper'

describe 'Usuário registra novo modelo de produto' do 
  it 'com sucesso' do 
    # Arrange 
    supplier = Supplier.create!(corporate_name: 'Indústria Mendes de Calçados SA',
                                brand_name: 'Lindeza de sapato',
                                registration_number: 1223344556677,
                                full_address: 'Rua Mimosa, 123',
                                city: 'Divinópolis',
                                state: 'MG',
                                email: 'mimosa@sapatos.com' )
    other_supplier = Supplier.create!(corporate_name: 'Fábrica de sapatos masculinos Sobral',
                                brand_name: 'Sobral Sapatos',
                                registration_number: 9089786756453,
                                full_address: 'Rua Vitória, 321',
                                city: 'Nova Serrana',
                                state: 'MG',
                                email: 'sobral@sapatos.com' )
    user = User.create!(name: 'Romualdo', email: 'romualdo@romualdo.com', password: 'password')
    # Act 
    visit root_path
    login_as(user, :scope => :user)
    click_on 'Modelos de produtos'
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: 'Melissa transparente'
    fill_in 'Peso', with: 400
    fill_in 'Largura', with: 10
    fill_in 'Altura', with: 10
    fill_in 'Profundidade', with: 15
    fill_in 'SKU', with: 'SAPATO-MELISSA-LINDO'
    select 'Lindeza de sapato', from: 'Fornecedor'
    click_on 'Enviar'

        
    # Assert
    expect(page).to have_content 'Modelo de produto cadastrado com sucesso'
    expect(page).to have_content 'Nome: Melissa transparente'
    expect(page).to have_content 'Peso: 400g'
    expect(page).to have_content 'Dimensões: 10cm x 10cm x 15cm'
    expect(page).to have_content 'SKU: SAPATO-MELISSA-LINDO'
    expect(page).to have_content 'Fornecedor: Lindeza de sapato'
  end

  it 'e deve preencher todos os campos' do 
    # Arrange 
    supplier = Supplier.create!(corporate_name: 'Indústria Mendes de Calçados SA',
                                brand_name: 'Lindeza de sapato',
                                registration_number: 1223344556677,
                                full_address: 'Rua Mimosa, 123',
                                city: 'Divinópolis',
                                state: 'MG',
                                email: 'mimosa@sapatos.com' )
    user = User.create!(name: 'Romualdo', email: 'romualdo@romualdo.com', password: 'password')

    # Act 
    visit root_path
    login_as(user, :scope => :user)
    click_on 'Modelos de produtos'
    click_on 'Cadastrar modelo de produto'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: ''
    fill_in 'Largura', with: ''
    fill_in 'Altura', with: ''
    fill_in 'Profundidade', with: ''
    fill_in 'SKU', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content 'Ocorreu um erro ao cadastrar modelo de produto'

  end
end