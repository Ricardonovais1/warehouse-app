require 'rails_helper'

RSpec.describe StockProduct, type: :model do
  describe 'Gera um número do série' do
    it 'ao criar um stock product' do
    # Arrange 
    user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password') 
    warehouse = Warehouse.create!(name: 'Aeroporto do Rio', code: 'GRU', city: 'Rio de Janeiro', area: 34_000,
                                  address: 'Av. Macedônia, 330', cep: '34562-000', description: 'Galpão do porto do Rio')
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                  registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'av@av.com')
    product_model = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                  depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)  
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now.to_date,
                                  status: :delivered)
    order_item = OrderItem.create!(product_model: product_model, order: order, quantity: 5)  

    # Act 
    stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product_model)

    # Assert
    expect(stock_product.serial_number.length).to eq 20
    end

    it 'e não é modificado ao atualizar o stock_product' do
    # Arrange 
    user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password') 
    warehouse = Warehouse.create!(name: 'Aeroporto do Rio', code: 'GRU', city: 'Rio de Janeiro', area: 34_000,
                                  address: 'Av. Macedônia, 330', cep: '34562-000', description: 'Galpão do porto do Rio')
    second_warehouse = Warehouse.create(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                  address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
    supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                  registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                  city: 'Belo Horizonte',
                                  state: 'Minas Gerais', email: 'av@av.com')
    product_model = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                  depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)  
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                  estimated_delivery_date: 1.day.from_now.to_date,
                                  status: :delivered)
    order_item = OrderItem.create!(product_model: product_model, order: order, quantity: 5)
    stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product_model)
    serial_number_original = stock_product.serial_number

    # Act 
    stock_product.update!(warehouse: second_warehouse)

    # Assert
    expect(stock_product.serial_number).to eq serial_number_original
    end
  end

  describe '#avaliable?' do 
    it 'true se não tiver destino' do 
      # Arrange 
      user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password') 
      warehouse = Warehouse.create!(name: 'Aeroporto do Rio', code: 'GRU', city: 'Rio de Janeiro', area: 34_000,
                                    address: 'Av. Macedônia, 330', cep: '34562-000', description: 'Galpão do porto do Rio')
      supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                    registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                    city: 'Belo Horizonte',
                                    state: 'Minas Gerais', email: 'av@av.com')
      product_model = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                    depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)  
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                    estimated_delivery_date: 1.day.from_now.to_date,
                                    status: :delivered)
      order_item = OrderItem.create!(product_model: product_model, order: order, quantity: 5)  

      # Act 
      stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product_model)

      # Assert
      expect(stock_product.avaliable?).to eq true
    end

    it 'false se tiver destino' do 
      # Arrange 
      user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password') 
      warehouse = Warehouse.create!(name: 'Aeroporto do Rio', code: 'GRU', city: 'Rio de Janeiro', area: 34_000,
                                    address: 'Av. Macedônia, 330', cep: '34562-000', description: 'Galpão do porto do Rio')
      supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                    registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                    city: 'Belo Horizonte',
                                    state: 'Minas Gerais', email: 'av@av.com')
      product_model = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                    depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)  
      order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                    estimated_delivery_date: 1.day.from_now.to_date,
                                    status: :delivered)
      order_item = OrderItem.create!(product_model: product_model, order: order, quantity: 5)  

      # Act 
      stock_product = StockProduct.create!(warehouse: warehouse, order: order, product_model: product_model)
      stock_product.create_stock_product_destination!(recipient: 'Ricardo', address: 'Rua da Lima, 88')

      # Assert
      expect(stock_product.avaliable?).to eq false
    end
  end
end 
