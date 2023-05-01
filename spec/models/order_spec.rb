require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do 
    it 'deve ter um código' do 
      # Arrange 
      user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                            address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
          
      supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                            registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                            city: 'Belo Horizonte',
                            state: 'Minas Gerais', email: 'av@av.com')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '2024-08-21')
      # Act 
      result = order.save!
      # Assert
      expect(result).to be true
    end

    it 'deve estimada de entrega deve ser obrigatória' do 
      # Arrange 
      order = Order.new(estimated_delivery_date: '')
      # Act 
      order.valid?
      # Assert
      expect(order.errors.include? :estimated_delivery_date).to be true
    end

    it 'data não deve ser no passado' do 
      # Arrange 
      order = Order.new(estimated_delivery_date: 1.day.ago)
      # Act 
      order.valid?
      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura')
    end

    it 'data não deve ser igual a hoje' do 
      # Arrange 
      order = Order.new(estimated_delivery_date: Date.today)
      # Act 
      order.valid?
      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura')
    end

    it 'data não deve ser maior ou igual a amanhã' do 
      # Arrange 
      order = Order.new(estimated_delivery_date: 1.day.from_now)
      # Act 
      order.valid?
      # Assert
      expect(order.errors.include?(:estimated_delivery_date)).to be false
    end
  end

  describe 'Gera um código aleatório' do 
    it 'ao criar um novo pedido' do 
      # Arrange 
          user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                            address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
          
      supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                            registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                            city: 'Belo Horizonte',
                            state: 'Minas Gerais', email: 'av@av.com')
      order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '2024-08-21')
      # Act 
      order.save!
      result = order.code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o código é único' do 
      # Arrange 
          user = User.create!(name: 'Sérgio', email: 'sergio@sergio.com', password: 'password')
      warehouse = Warehouse.create!(name: 'Galpão Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                            address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')
          
      supplier =   Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                            registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
                            city: 'Belo Horizonte',
                            state: 'Minas Gerais', email: 'av@av.com')
      first_order = Order.create!(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '2024-08-21')
      second_order = Order.new(warehouse: warehouse, supplier: supplier, user: user, estimated_delivery_date: '2024-01-02')
      # Act 
      second_order.save!

      # Assert
      expect(second_order.code).not_to eq first_order.code
    end
  end
end
