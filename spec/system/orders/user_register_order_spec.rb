require 'rails_helper'

describe 'Usuário cadastra um pedido' do 
  it 'e deve estar autenticado' do 
    # Arrange 

    # Act 
    visit root_path
    within('nav') do 
      click_on 'Registrar pedido'
    end
    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    # Arrange 
    user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password')
                Warehouse.create!(name: 'Galpão Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                  address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')  
    warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                  address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
                 Supplier.create!(corporate_name: 'Fábrica de bonecos SA', brand_name: 'Bonecos & CIA', 
                                  registration_number: 1111222293333, full_address: 'Av. das Acácias, 9090', 
                                  city: 'Cuiabá',
                                  state: 'Mato Grosso', email: 'bonecos@bonecos.com')
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                  registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'av@av.com')
    # Act 
    visit root_path
    login_as(user, :scope => :user)
    within('nav') do 
      click_on 'Registrar pedido'
    end
    select 'MCZ - Galpão Maceió', from: 'Galpão Destino'
    select supplier.corporate_name, from: 'Fornecedor'
    fill_in 'Data prevista de entrega', with: '20/12/2022'
    click_on 'Gravar'
    
    # Assert
    expect(page).to have_content 'Pedido cadastrado com sucesso'
    expect(page).to have_content 'Galpão Destino: Galpão Maceió'
    expect(page).to have_content 'Fornecedor: AV Guitars and Accessories'
    expect(page).to have_content 'Data prevista de entrega: 20/12/2022'
    expect(page).to have_content 'Usuário Responsável: Sérgio | sergio@sergio.com'
    expect(page).not_to have_content 'Galpão Destino: Galpão Rio'
    expect(page).not_to have_content 'Fornecedor: Fábrica de bonecos SA'
  end
end