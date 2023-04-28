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
end
