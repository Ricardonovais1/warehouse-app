require 'rails_helper'

describe 'Usuário informa novo status de pedido' do 
  it 'e pedido foi entregue' do 
  # Arrange 
       user = User.create!(name: "Romualdo", email: "romualdo@gmail.com", password: "132435")
  warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                            address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
  supplier =  Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                            registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                            city: 'Belo Horizonte',
                            state: 'Minas Gerais', email: 'av@av.com')
  product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', 
                            weight: 5, width: 70, height: 60, depth: 50, sku: 'CAD71-CADSU-CADZ7700')
  order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                            estimated_delivery_date: 1.day.from_now, status: 'pending')   
  item = OrderItem.create!(order: order, product_model: product, quantity: 5)
  
  # Act 
  login_as(user)
  visit root_path
  within('nav') do 
    click_on 'Meus pedidos'
  end
  click_on order.code
  click_on 'Marcar como entregue'

  # Assert
  expect(current_path).to eq order_path(order.id)
  expect(page).to have_content 'Situação do pedido: Entregue'
  expect(page).not_to have_button 'Marcar como entregue'
  expect(page).not_to have_button 'Cancelar pedido'
  expect(StockProduct.count).to eq 5
  estoque = StockProduct.where(warehouse: warehouse, product_model: product).count
  expect(estoque).to eq 5

  end

  it 'e pedido foi cancelado' do 
  # Arrange 
  user = User.create!(name: "Romualdo", email: "romualdo@gmail.com", password: "132435")
  warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                            address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
  supplier =  Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                            registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                            city: 'Belo Horizonte',
                            state: 'Minas Gerais', email: 'av@av.com')
  product = ProductModel.create!(supplier: supplier, name: 'Cadeira Gamer', 
                            weight: 5, width: 70, height: 60, depth: 50, sku: 'CAD71-CADSU-CADZ7700')
  order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                            estimated_delivery_date: 1.day.from_now, status: 'pending')  
  item = OrderItem.create!(order: order, product_model: product, quantity: 5)
   
  
  # Act 
  login_as(user)
  visit root_path
  within('nav') do 
    click_on 'Meus pedidos'
  end
  click_on order.code
  click_on 'Cancelar pedido'

  # Assert
  expect(current_path).to eq order_path(order.id)
  expect(page).to have_content 'Situação do pedido: Cancelado'
  estoque = StockProduct.where(warehouse: warehouse, product_model: product).count
  expect(estoque).to eq 0  
  end
end 