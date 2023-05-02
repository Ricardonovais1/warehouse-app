require 'rails_helper'

describe 'Usuário edita um pedido' do 
  it 'e não é o dono' do 
    # Arrange 
    joao = User.create!(name: "Romualdo", email: "romualdo@gmail.com", password: "132435")
    alan = User.create!(name: "Alan", email: "alan@yahoo.com.br", password: "000000")
    warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                  address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                  registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'av@av.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now.to_date)
      
    # Act 
    login_as(alan)
    patch(order_path(order.id), params: {order: {supplier_id: 1}})

    # Assert
    expect(response).to redirect_to(root_path)
  end

  it 'e não está logado' do 
    # Arrange 
    joao = User.create!(name: "Romualdo", email: "romualdo@gmail.com", password: "132435")
    alan = User.create!(name: "Alan", email: "alan@yahoo.com.br", password: "000000")
    warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                  address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                  registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'av@av.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now.to_date)
      
    # Act 
    patch(order_path(order.id), params: {order: {supplier_id: 1}})

    # Assert
    expect(response).to redirect_to(new_user_session_path)
  end 
end