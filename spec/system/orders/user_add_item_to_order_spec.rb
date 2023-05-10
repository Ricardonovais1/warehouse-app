require 'rails_helper'

describe 'Usuário adiciona item ao pedido' do 
  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo Novais', email: 'ricardo@email.com', password: 'password')
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                        registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                        city: 'Belo Horizonte',
                        state: 'Minas Gerais', email: 'av@av.com')
    warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                        address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
    product_a = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                        depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    product_b = ProductModel.create!(name:'Soundbar 7.1 Sorround', weight: 3000, width: 80, height: 15, 
                        depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                        estimated_delivery_date: 1.day.from_now.to_date)
    OrderItem.create!(product_model: product_a, order: order, quantity: 8)
    # Act 
    login_as(user)
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Adicionar item'
    select 'TV 32', from: 'Produto'
    fill_in 'Quantidade', with: 8
    click_on 'Gravar'

    # Assert
    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Item adicionado com sucesso'
    expect(page).to have_content '8 x TV 32'
  end

  it 'e não vê itens de outros fornecedores' do 
    # Arrange 
    user = User.create!(name: 'Ricardo Novais', email: 'ricardo@email.com', password: 'password')
    first_supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                        registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                        city: 'Belo Horizonte',
                        state: 'Minas Gerais', email: 'av@av.com')
    second_supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                        registration_number: 1111567891234, full_address: 'Rua das Araras, 3234', 
                        city: 'Belo Horizonte',
                        state: 'Minas Gerais', email: 'avemaria@avemaria.com')
    warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                        address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
    product_a = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                        depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: first_supplier)
    product_b = ProductModel.create!(name:'Soundbar 7.1 Sorround', weight: 3000, width: 80, height: 15, 
                        depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: second_supplier)
    
    order = Order.create!(user: user, warehouse: warehouse, supplier: first_supplier, 
                        estimated_delivery_date: 1.day.from_now.to_date)
    OrderItem.create!(product_model: product_a, order: order, quantity: 8)
    # Act 
    login_as(user)
    visit root_path
    click_on 'Meus pedidos'
    click_on order.code
    click_on 'Adicionar item'

    # Assert
    expect(page).to have_content 'TV 32'
    expect(page).not_to have_content 'Soundbar 7.1 Sorround'
  end
end