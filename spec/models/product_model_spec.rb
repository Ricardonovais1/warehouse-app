require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        # Arrange 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'', weight: 8000, width: 70, height: 45, 
                                  depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        
        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false      
      end

      it 'false when weight is empty' do
        # Arrange 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 32', weight: '', width: 70, height: 45, 
                                  depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        
        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false      
      end

      it 'false when width is empty' do
        # Arrange 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 32', weight: 8000, width: '', height: 45, 
                                  depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        
        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false      
      end

      it 'false when height is empty' do
        # Arrange 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: '', 
                                  depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        
        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false      
      end

      it 'false when depth is empty' do
        # Arrange 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                  depth: '', sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        
        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false      
      end

      it 'false when sku is empty' do
        # Arrange 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                  depth: 10, sku: '', supplier: supplier)
        
        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false      
      end

      it 'false when supplier is empty' do
        # Arrange 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, 
                                  depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        pm.supplier = nil
        
        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false      
      end
    end

    context 'uniqueness' do 
      it 'false when sku já existe' do
        # Arrange 
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.create!(name:'TV 45', weight: 8300, width: 74, height: 46, 
                              depth: 12, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        pm_2 = ProductModel.new(name:'TV 32', weight: 8000, width: 70, height: 45, 
                              depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
        # Act 
        result = pm_2.valid?

        # Assert
        expect(result).to eq false
      end
    end

    context 'length' do 
      it 'false when sku is NOT 20 characters long' do 
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: 8300, width: 74, height: 46, 
                                  depth: 12, sku: 'TV32-SAMSU-XPTO9', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end
    end

    context 'numericality' do
      it 'false when weight is equal to 0' do 
         # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: 0, width: 74, height: 46, 
                              depth: 12, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when weight is lower than 0' do 
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: -1, width: 74, height: 46, 
                              depth: 12, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when width is equal to 0' do 
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: 8000, width: 0, height: 46, 
                              depth: 12, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when width is lower than 0' do 
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: 8000, width: -1, height: 46, 
                              depth: 12, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when height is equal to 0' do 
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: 8000, width: 45, height: 0, 
                              depth: 12, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when height is lower than 0' do 
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: 8000, width: 45, height: -1, 
                              depth: 12, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when depth is equal to 0' do 
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: 8000, width: 45, height: 46, 
                              depth: 0, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when depth is lower than 0' do 
        # Arrange
        supplier = Supplier.create!(corporate_name: 'Samsung Eletronicos LTDA', brand_name: 'Samsung', 
                                    registration_number: '1792103100019', full_address: 'Av. Nações Unidas, 1000',
                                    city: 'São Paulo', state: 'SP', email: 'sac@samsung.com')
        pm = ProductModel.new(name:'TV 45', weight: 8000, width: 45, height: 46, 
                              depth: -1, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)

        # Act 
        result = pm.valid?

        # Assert
        expect(result).to eq false
      end
    end
  end
end
