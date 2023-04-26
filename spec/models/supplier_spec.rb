require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when corporate_name is empty' do
        # Arrange 
        s = Supplier.new(corporate_name: '', 
                        brand_name: 'Amigo Violão', 
                        registration_number: 12345, 
                        full_address: 'Rua das Palmeiras, 344', 
                        city: 'Belo Horizonte',
                        state: 'Minas Gerais', 
                        email: 'av@av.com')

        # Act
        result = s.valid?

        # Assert
        expect(result).to eq false
      end
      
      it 'false when brand_name is empty' do
        # Arrange 
        s = Supplier.new(corporate_name: 'AV Guitars and Accessories', 
                        brand_name: '', 
                        registration_number: 12345, 
                        full_address: 'Rua das Palmeiras, 344', 
                        city: 'Belo Horizonte',
                        state: 'Minas Gerais', 
                        email: 'av@av.com')

        # Act
        result = s.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when registration_number is empty' do
        # Arrange 
        s = Supplier.new(corporate_name: 'AV Guitars and Accessories', 
                        brand_name: 'Amigo Violão', 
                        registration_number: '', 
                        full_address: 'Rua das Palmeiras, 344', 
                        city: 'Belo Horizonte',
                        state: 'Minas Gerais', 
                        email: 'av@av.com')

        # Act
        result = s.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when full_address is empty' do
        # Arrange 
        s = Supplier.new(corporate_name: 'AV Guitars and Accessories', 
                        brand_name: 'Amigo Violão', 
                        registration_number: 12345, 
                        full_address: '', 
                        city: 'Belo Horizonte',
                        state: 'Minas Gerais', 
                        email: 'av@av.com')

        # Act
        result = s.valid?

        # Assert
        expect(result).to eq false
      end
      
      it 'false when city is empty' do
        # Arrange 
        s = Supplier.new(corporate_name: 'AV Guitars and Accessories', 
                        brand_name: 'Amigo Violão', 
                        registration_number: 12345, 
                        full_address: 'Rua das Palmeiras, 344', 
                        city: '',
                        state: 'Minas Gerais', 
                        email: 'av@av.com')

        # Act
        result = s.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when state is empty' do
        # Arrange 
        s = Supplier.new(corporate_name: 'AV Guitars and Accessories', 
                        brand_name: 'Amigo Violão', 
                        registration_number: 12345, 
                        full_address: 'Rua das Palmeiras, 344', 
                        city: 'Belo Horizonte',
                        state: '', 
                        email: 'av@av.com')

        # Act
        result = s.valid?

        # Assert
        expect(result).to eq false
      end

      it 'false when email is empty' do
        # Arrange 
        s = Supplier.new(corporate_name: 'AV Guitars and Accessories', 
                        brand_name: 'Amigo Violão', 
                        registration_number: 12345, 
                        full_address: 'Rua das Palmeiras, 344', 
                        city: 'Belo Horizonte',
                        state: 'Minas Gerais', 
                        email: '')

        # Act
        result = s.valid?

        # Assert
        expect(result).to eq false
      end
    end

    context 'uniqueness' do
        it 'false when registration_number is already in use' do 
          # Arrange
          first_supplier = Supplier.create(corporate_name: 'Souza comércio de roupas e acessórios LTDA', 
                                           brand_name: 'Magazine Souza', 
                                           registration_number: 12345, 
                                           full_address: 'Rua Lago das Araras, 1000', 
                                           city: 'Ji Paraná',
                                           state: 'Rondônia', 
                                           email: 'souza@souza.com.br')
            second_supplier = Supplier.new(corporate_name: 'AV Guitars and Accessories', 
                                           brand_name: 'Amigo Violão', 
                                           registration_number: 12345, 
                                           full_address: 'Rua das Palmeiras, 344', 
                                           city: 'Belo Horizonte',
                                           state: 'Minas Gerais', 
                                           email: 'av@av.com')
          # Act
          result = second_supplier.valid?

          # Assert
          expect(result).to eq false
        end

        it 'false when email is already in use' do 
          # Arrange
          first_supplier = Supplier.create(corporate_name: 'Souza comércio de roupas e acessórios LTDA', 
                                           brand_name: 'Magazine Souza', 
                                           registration_number: 54321, 
                                           full_address: 'Rua Lago das Araras, 1000', 
                                           city: 'Ji Paraná',
                                           state: 'Rondônia', 
                                           email: 'av@av.com')
            second_supplier = Supplier.new(corporate_name: 'AV Guitars and Accessories', 
                                           brand_name: 'Amigo Violão', 
                                           registration_number: 12345, 
                                           full_address: 'Rua das Palmeiras, 344', 
                                           city: 'Belo Horizonte',
                                           state: 'Minas Gerais', 
                                           email: 'av@av.com')
          # Act
          result = second_supplier.valid?

          # Assert
          expect(result).to eq false
        end
    end
  end
end
