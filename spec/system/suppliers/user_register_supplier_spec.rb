require 'rails_helper'

describe 'Usuário cadastra um fornecedos' do 
    it 'a partir no menu' do 
        # Arrange 

        # Act
        visit root_path
        within('nav') do
            click_on 'Novo Fornecedor'
        end

        # Assert
        expect(current_path).to eq new_supplier_path
    end

    it 'com sucesso' do
        # Arrange 

        # Act 
        visit root_path
        within('nav') do
            click_on 'Novo Fornecedor'
        end
        fill_in 'Razão social', with: 'Souza comércio de roupas e acessórios LTDA'
        fill_in 'Nome fantasia', with: 'Magazine Souza'
        fill_in 'CNPJ', with: '1234'
        fill_in 'Endereço', with: 'Av. das Américas, 3200'
        fill_in 'Cidade', with: 'São Paulo'
        fill_in 'Estado', with: 'SP'
        fill_in 'Email', with: 'souza@souza.com.br'
        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'Souza comércio de roupas e acessórios LTDA'
        expect(current_path).to eq suppliers_path
    end

    it 'com dados incompletos' do 
        
    end
end