require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe '#valid?' do
    it 'falso quando quantidade está vazia' do
      user = User.create!(name: "Romualdo", email: "romualdo@gmail.com", password: "132435")
      supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                                    registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                                    city: 'Belo Horizonte',
                                    state: 'Minas Gerais', email: 'av@av.com')
      product = ProductModel.create!(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                    depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
      warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                                    address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
        order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, 
                                    estimated_delivery_date: 1.day.from_now.to_date)
      oi = OrderItem.new(product_model: product, order: order, quantity: '')

      result = oi.valid?

      expect(result).to be false
    end
  end
end
