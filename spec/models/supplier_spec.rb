require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do 
    context 'presence' do 
    it 'false when corporate_name is empty' do
      # # Arrange 
      # s = Supplier.new(corporate_name: '', 
      #                 brand_name: 'Amigo Violão', 
      #                 registration_number: 12345, 
      #                 full_address: 'Rua das Palmeiras, 344', 
      #                 city: 'Belo Horizonte',
      #                 state: 'Minas Gerais', 
      #                 email: 'av@av.com')
      # s.save()

      # # Act
      # visit root_path 
      # within('nav') do 
      #   click_on 'Fornecedores'
      # end

      # # Assert

    end
    end
  end
end
