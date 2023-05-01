require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do 
    context 'presence' do 
    it 'false when name is empty' do
    # Arrange 
    warehouse = Warehouse.new(name: '', code: 'RIO', address: 'Endereço', 
                                    cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
    end

    it 'false when code is empty' do
    # Arrange 
    warehouse = Warehouse.new(name: 'Rio galpão', code: '', address: 'Endereço', 
                                    cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
    end

    it 'false when address is empty' do
    # Arrange 
    warehouse = Warehouse.new(name: 'Rio galpão', code: 'RIO', address: '', 
                                    cep: '25000-000', city: 'Rio', area: 1000, description: 'Alguma descrição')

    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
    end

    it 'false when cep is empty' do
    # Arrange 
    warehouse = Warehouse.new(name: 'Rio galpão', code: 'RIO', address: 'Endereço', 
                                    cep: '', city: 'Rio', area: 1000, description: 'Alguma descrição')

    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
    end

    it 'false when city is empty' do
    # Arrange 
    warehouse = Warehouse.new(name: 'Rio galpão', code: 'RIO', address: 'Endereço', 
                                    cep: '25000-000', city: '', area: 1000, description: 'Alguma descrição')

    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
    end

    it 'false when area is empty' do
    # Arrange 
    warehouse = Warehouse.new(name: 'Rio galpão', code: 'RIO', address: 'Endereço', 
                                    cep: '25000-000', city: 'Cidade', area: '', description: 'Alguma descrição')

    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
    end

    it 'false when description is empty' do
    # Arrange 
    warehouse = Warehouse.new(name: 'Rio galpão', code: 'RIO', address: 'Endereço', 
                                    cep: '25000-000', city: 'Cidade', area: '', description: '')

    # Act
    result = warehouse.valid?

    # Assert
    expect(result).to eq false
    end
    end
    context 'uniqueness' do
      it 'false when code is already in use' do 
      #Arrange
      first_warehouse = Warehouse.create(name: 'SP galpão', code: 'RIO', address: 'Endereço 2', 
                                      cep: '25000-999', city: 'Município', area: '9000', description: 'Hello')
      second_warehouse = Warehouse.new(name: 'Rio galpão', code: 'RIO', address: 'Endereço', 
                                      cep: '25000-000', city: 'Cidade', area: '1000', description: 'Olá')

      # Act 
      result = second_warehouse.valid?

      # Assert
      expect(result).to eq false
      end
    end
  end

  describe '#full_description' do 
    it 'exibe o nome e o código' do
    # Arrange 
    w = Warehouse.new(name: 'Galpão Cuiabá', code: 'CBS')
    # Act 
    result = w.full_description()

    # Assert
    expect(result).to eq 'CBS - Galpão Cuiabá'
    end
  end
end
