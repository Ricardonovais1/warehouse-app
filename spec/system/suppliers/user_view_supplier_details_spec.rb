require 'rails_helper'

describe 'Usuário acessa detalhes do fornecedor' do
    it 'com sucesso' do 
        # Arrange
        s = Supplier.new(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
            registration_number: 1234567891234, full_address: 'Rua das Palmeiras, 344', 
            city: 'Belo Horizonte',
            state: 'Minas Gerais', email: 'av@av.com')
        s.save()
        
        # Act 
        visit root_path
        click_on 'Fornecedores'
        click_on 'AV Guitars and Accessories'

        # Assert
        expect(current_path).to eq supplier_path(s)
        expect(page).to have_content 'Razão social: AV Guitars and Accessories'
        expect(page).to have_content 'Nome fantasia: Amigo Violão'
        expect(page).to have_content 'CNPJ: 12345'
        expect(page).to have_content 'Endereço: Rua das Palmeiras, 344'
        expect(page).to have_content 'Cidade: Belo Horizonte'
        expect(page).to have_content 'Estado: Minas Gerais'
        expect(page).to have_content 'Email: av@av.com'
    end
end