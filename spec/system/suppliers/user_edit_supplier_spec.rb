require 'rails_helper'

describe '' do 
  it 'a partir da tela de detalhes' do 
    # Arrange 
    Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                    registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                    city: 'Belo Horizonte',
                    state: 'Minas Gerais', email: 'av@av.com')
        
    # Act 
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end
    click_on 'AV Guitars and Accessories'
    click_on 'Editar Fornecedor'

    # Assert
    expect(page).to have_content('Editar Fornecedor')
    expect(page).to have_field('Razão social', with: 'AV Guitars and Accessories')
    expect(page).to have_field('Nome fantasia', with: 'Amigo Violão')
    expect(page).to have_field('CNPJ', with: '1234567891234')
    expect(page).to have_field('Endereço', with: 'Rua das Palmeiras, 344')
    expect(page).to have_field('Cidade', with: 'Belo Horizonte')
    expect(page).to have_field('Estado', with: 'Minas Gerais')
    expect(page).to have_field('Email', with: 'av@av.com')
  end

  it 'com sucesso' do 
    # Arrange 
    supplier = Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                registration_number: 9876543212345, full_address: 'Rua das Palmeiras, 344', 
                                city: 'Belo Horizonte',
                                state: 'Minas Gerais', email: 'aviolao@av.com')

    # Act 
    visit root_path
    within('nav') do
      click_on 'Fornecedores'
    end    
    click_on 'AV Guitars and Accessories'
    click_on 'Editar Fornecedor'
    fill_in 'Razão social', with: 'Souza comércio LTDA' 
    fill_in 'Nome fantasia', with: 'Magazine Souza' 
    fill_in 'CNPJ', with: '9876543212349'
    fill_in 'Endereço', with: 'Rua das Carmélias, 342' 
    fill_in 'Cidade', with: 'São José' 
    fill_in 'Estado', with: 'SP' 
    fill_in 'Email', with: 'souza@magazine.com' 
    click_on 'Enviar'
    
    # Assert
    expect(current_path).to eq supplier_path(supplier)
    expect(page).to have_content 'Razão social: Souza comércio LTDA'
  end
 
end