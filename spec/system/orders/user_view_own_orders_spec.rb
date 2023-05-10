require 'rails_helper'

describe 'Usuario vê seus próprios pedidos' do 
  it 'e deve estar autenticado' do 
  # Arrange 


  # Act 
  visit root_path
  click_on 'Meus pedidos'

  # Assert
  expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do 
  # Arrange 
   first_user = User.create!(name: "Romualdo", email: "romualdo@gmail.com", password: "132435")
  second_user = User.create!(name: "Isabela", email: "isabela@hotmail.com", password: "343434")

  warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
    address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
 supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
    registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
    city: 'Belo Horizonte',
    state: 'Minas Gerais', email: 'av@av.com')

  allow(SecureRandom).to receive(:alphanumeric).and_return('AAA11111')
  first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now, status: 'pending')
  
  allow(SecureRandom).to receive(:alphanumeric).and_return('BBB11111')
  second_order = Order.create!(user: second_user, warehouse: warehouse, supplier: supplier, 
                               estimated_delivery_date: 1.day.from_now, status: 'delivered')
  
  allow(SecureRandom).to receive(:alphanumeric).and_return('CCC33333')
  third_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, 
                              estimated_delivery_date: 1.day.from_now, status: 'canceled')
  # Act
  
  login_as(first_user)
  visit root_path
  click_on "Meus pedidos"

  # Assert
  expect(page).to have_content first_order.code
  expect(page).to have_content 'Pendente'
  expect(page).not_to have_content second_order.code
  expect(page).not_to have_content 'Entregue'
  expect(page).to have_content third_order.code
  expect(page).to have_content 'Cancelado'
  
  end

  it 'e visita um pedido' do 
    # Arrange 
    joao = User.create!(name: "Romualdo", email: "romualdo@gmail.com", password: "132435")
    warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                  address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                  registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'av@av.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now.to_date)
    # Act 
    login_as(joao)
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code

    # Assert
    expect(page).to have_content "Pedido #{order.code}"
    expect(page).to have_content "Galpão Destino: Galpão Maceió"
    expect(page).to have_content "Fornecedor: AV Guitars and Accessories"
    expect(page).to have_content "Usuário Responsável: Romualdo | romualdo@gmail.com"
    formatted_date = I18n.localize(1.day.from_now.to_date)
    expect(page).to have_content "Data prevista de entrega: #{formatted_date}"
  end

  it 'e não consegue visitar pedidos de outros usuários' do 
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
    visit order_path(order.id)

    # Assert 
    expect(current_path).not_to eq order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não possui acesso a este pedido'
  end

  it 'e vê itens do pedido' do 
    # Arrange 
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                  registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'av@av.com')
    product_a = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                    depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    product_b = ProductModel.create!(name:'Soundbar 7.1 Sorround', weight: 3000, width: 80, height: 15, 
                                    depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
    product_c = ProductModel.create!(name:'Audio Interface Behringer', weight: 500, width: 90, height: 5, 
                                    depth: 14, sku: 'BEH34-BEHRI-SORT6754', supplier: supplier)
    joao = User.create!(name: "João", email: "joao@gmail.com", password: "132435")
    warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                  address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
   
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now.to_date)
    OrderItem.create!(product_model: product_a, order: order, quantity: 20)
    OrderItem.create!(product_model: product_b, order: order, quantity: 12)
    # Act 
    login_as(joao)
    visit root_path
    within('nav') do
      click_on 'Meus pedidos'
    end
    click_on order.code

    # Assert
    expect(page).to have_content 'Itens do pedido'
    expect(page).to have_content '20 x TV 32'
    expect(page).to have_content '12 x Soundbar 7.1 Sorround'
    expect(page).not_to have_content 'Audio Interface Behringer'
  end
end