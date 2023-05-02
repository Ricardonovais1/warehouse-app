require 'rails_helper'

describe 'Usuário busca por um pedido' do 
  it 'a partir do menu' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@email.com', password: 'password')

    # Act 
    login_as(user, :scope => :user)
    visit root_path

    # Assert 
    within('header nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end

    end


  it 'usuário precisa estar logado' do 
    # Arrange 


    # Act 
    visit root_path

    # Assert
    within('header nav') do
      expect(page).not_to have_field 'Buscar Pedido'
      expect(page).not_to have_button 'Buscar'
    end
  end

  it 'e encontra o pedido' do 
    # Arrange
                user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password') 
      warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                            address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
      supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                            registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                            city: 'Belo Horizonte',
                            state: 'Minas Gerais', email: 'av@av.com')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
      # Act 
      login_as(user, :scope => :user)
      visit root_path
      within('header nav') do 
        fill_in 'Buscar Pedido', with: order.code
        click_on 'Buscar'
      end
      
    # Assert
    expect(page).to have_content "Resultado da pesquisa para o termo '#{order.code}'"
    expect(page).to have_content "1 Pedido encontrado"
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão Destino: Galpão Maceió"
    expect(page).to have_content "Fornecedor: AV Guitars and Accessories | Amigo Violão"
    expect(page).to have_content "Usuário Responsável: Sérgio | sergio@sergio.com"
  end

  it 'e encontra múltiplos pedidos' do 
    # Arrange
    user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password') 
     first_warehouse = Warehouse.create!(name: 'Aeroporto do Rio', code: 'GRU', city: 'Rio de Janeiro', area: 34_000,
                                         address: 'Av. Macedônia, 330', cep: '34562-000', description: 'Galpão do porto do Rio')
    second_warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                         address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
   supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                          registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                          city: 'Belo Horizonte',
                          state: 'Minas Gerais', email: 'av@av.com')

      allow(SecureRandom).to receive(:alphanumeric).and_return('GRU23454')
       first_order = Order.create!(user: user, warehouse: first_warehouse, 
                                   supplier: supplier, estimated_delivery_date: 1.day.from_now)

      allow(SecureRandom).to receive(:alphanumeric).and_return('MCZ27654')
      second_order = Order.create!(user: user, warehouse: second_warehouse, 
                                   supplier: supplier, estimated_delivery_date: 1.day.from_now)

      allow(SecureRandom).to receive(:alphanumeric).and_return('GRU00000')
      third_order = Order.create!(user: user, warehouse: first_warehouse, 
                                  supplier: supplier, estimated_delivery_date: 1.day.from_now)
    # Act 
    login_as(user, :scope => :user)
    visit root_path
    within('header nav') do 
      fill_in 'Buscar Pedido', with: 'GRU'
      click_on 'Buscar'
    end

    # Assert
    expect(page).to have_content '2 Pedidos encontrados' 
    expect(page).to have_content 'GRU23454'
    expect(page).to have_content 'GRU00000'
    expect(page).not_to have_content 'MCZ27654'
    expect(page).not_to have_content "Galpão Destino: Galpão Maceió"
    expect(page).to have_content "Galpão Destino: Aeroporto do Rio"

  end
end