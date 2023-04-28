require 'rails_helper'

describe 'Usuário vê modelos de produtos' do 
  it 'a partir do menu' do 
    # Arrange 
    
    # Act
    visit root_path 
    within('nav') do
      click_on 'Modelos de produtos'
    end

    # Assert
    expect(current_path).to eq product_models_path
   end

   it 'com sucesso' do 
    # Arrange 
    supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                        registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                        city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
    ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                         depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    ProductModel.create!(name:'Soundbar 7.1 Sorround', weight: 3000, width: 80, height: 15, 
                         depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)


    # Act 
    visit root_path 
    within('nav') do
      click_on 'Modelos de produtos'
    end

    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO90'
    expect(page).to have_content 'SOU71-SAMSU-NOIZ77'
    expect(page).to have_content 'Soundbar 7.1 Sorround'
    expect(page).to have_content 'Samsung'
   end

   it 'não existem produtos cadastrados' do 
    # Arrange 
    
    # Act 
    visit root_path 
    within('nav') do
      click_on 'Modelos de produtos'
    end

    # Assert
    expect(page).to have_content 'Não há nenhum modelo de produto cadastrado'
   end
end
