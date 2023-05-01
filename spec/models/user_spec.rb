require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when name is empty' do
      # Arrange 
      user = User.new(name: '', email: 'coisa@bonita.com', password: 'comosera')

      # Act
      result = user.valid?

      # Assert
      expect(result).to eq false
      end
    end
  end

  describe '#description' do 
    it 'nome e email aparecem juntos' do 
      # Arrange
      u = User.new(name: 'Rosa', email: 'rosa@email.com.br')

      # Act
      result = u.description()
      
      # Assert
      expect(result).to eq 'rosa@email.com.br | Olá Rosa!'
    end

    # it 'apenas o primeiro nome, quando nome e sobrenome são fornecidos' do
    #   # Arrange 
    #   u = User.new(name: 'Rosa de Novais', email: 'rosa@email.com.br')

    #   # Act
    #   result = u.description()
      
    #   # Assert
    #   expect(result).to eq 'rosa@email.com.br | Olá Rosa!'
    # end
  end
end
