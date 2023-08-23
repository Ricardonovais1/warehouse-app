require 'rails_helper'

describe 'Usuário vê o estoque' do 
  it 'na tela do galpão' do
    # Arrange 
    user = User.create!(name: 'Fernanda', email: 'fernanda@email.com', password: 'password')
    warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.new(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                      registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                      city: 'Belo Horizonte',
                      state: 'Minas Gerais', email: 'av@av.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                      estimated_delivery_date: 1.day.from_now, status: 'pending')
    p_1 = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                      depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    p_2 = ProductModel.create!(name:'Soundbar 7.1 Sorround', weight: 3000, width: 80, height: 15, 
                      depth: 20, sku: 'SOU71-SAMSU-NOIZ7700', supplier: supplier)
    p_3 = ProductModel.create!(name:'Mouse wireless', weight: 200, width: 7, height: 3, 
                      depth: 10, sku: 'MOU99-EXBOM-MOSE9932', supplier: supplier)
    3.times { StockProduct.create!(warehouse: warehouse, order: order, product_model: p_1) }
    2.times { StockProduct.create!(warehouse: warehouse, order: order, product_model: p_2) }

    # Act 
    login_as user
    visit root_path 
    click_on "Aeroporto SP"

    # Assert
    within('section#stock_products') do
      expect(page).to have_content "Itens em estoque"
      expect(page).to have_content "3 x TV32-SAMSU-XPTO90000"
      expect(page).to have_content "2 x SOU71-SAMSU-NOIZ7700"
      expect(page).not_to have_content "MOU99-EXBOM-MOSE9932"
    end
  end

  it 'e dá baixa em um item' do 
    # Arrange 
    user = User.create!(name: 'Fernanda', email: 'fernanda@email.com', password: 'password')
    warehouse = Warehouse.new(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', area: 100_000,
                      address: 'Avenida do aeroporto, 1000', cep: '15000-000',
                      description: 'Galpão destinado para cargas internacionais')
    supplier = Supplier.new(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                      registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                      city: 'Belo Horizonte',
                      state: 'Minas Gerais', email: 'av@av.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                      estimated_delivery_date: 1.day.from_now, status: 'pending')
    p_1 = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                      depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    3.times { StockProduct.create!(warehouse: warehouse, order: order, product_model: p_1) }

    # Act 
    login_as user
    visit root_path 
    click_on "Aeroporto SP"
    select 'TV32-SAMSU-XPTO90000', from: 'Ítem para saída'
    fill_in 'Destinatário', with: 'Maria Ferreira'
    fill_in 'Endereço destino', with: 'Rua das Palmeiras, 100 - Campinas - São Paulo'
    click_on 'Confirmar'

    # Assert
    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Item retirado com sucesso'
    expect(page).to have_content '2 x TV32-SAMSU-XPTO90000'
  end
end