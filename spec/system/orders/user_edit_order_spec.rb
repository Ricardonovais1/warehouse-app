require 'rails_helper'

describe 'Usuário edita pedido' do 
  it 'e precisa estar logado' do 
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
    visit edit_order_path(order.id)

    # Assert
    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do 
    # Arrange
    joao = User.create!(name: "Romualdo", email: "romualdo@gmail.com", password: "132435")
    warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                  address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                  registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'av@av.com')
    second_supplier = Supplier.create!(corporate_name: 'Fábrica de bonecas LTDA', brand_name: 'Fofura', 
                                  registration_number: 9089786756453, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'bonecas@bonecas.com')
    order = Order.create!(user: joao, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now.to_date)
      
    # Act 
    login_as(joao)
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in 'Data prevista de entrega', with: '12/12/2029'
    select 'Fábrica de bonecas LTDA | Fofura', from: 'Fornecedor'
    click_on 'Gravar'

    # Assert
    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Galpão Destino: Galpão Maceió'
    expect(page).to have_content 'Fornecedor: Fábrica de bonecas LTDA'
    expect(page).to have_content 'Usuário Responsável: Romualdo | romualdo@gmail.com'
    expect(page).to have_content "Data prevista de entrega: 12/12/2029"
  end

  it 'caso seja o responsável' do 
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
    visit edit_order_path(order.id)

    # Assert 
    expect(current_path).not_to eq edit_order_path(order.id)
    expect(current_path).to eq root_path
    expect(page).to have_content 'Você não tem permissão para editar este pedido'
  end
end