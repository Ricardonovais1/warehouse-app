require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do 
    it 'a partir da tela de fornecedores' do 
        # Arrange 

        # Act
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end

        # Assert
        expect(current_path).to eq suppliers_path
        expect(page).to have_content 'Novo Fornecedor'
    end

    it 'com sucesso' do
        # Arrange 

        # Act 
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end
        click_on 'Novo Fornecedor'
        fill_in 'Razão social', with: 'Souza comércio de roupas e acessórios LTDA'
        fill_in 'Nome fantasia', with: 'Magazine Souza'
        fill_in 'CNPJ', with: 1234567891234
        fill_in 'Endereço', with: 'Av. das Américas, 3200'
        fill_in 'Cidade', with: 'São Paulo'
        fill_in 'Estado', with: 'SP'
        fill_in 'Email', with: 'souza@souza.com.br'
        click_on 'Enviar'

        # Assert
        expect(page).to have_content 'Fornecedor cadastrado com sucesso'
        expect(page).to have_content 'Souza comércio de roupas e acessórios LTDA'
        expect(current_path).to eq suppliers_path
    end

    it 'com dados incompletos' do 
        # Arrange 

        # Act
        visit root_path 
        within('nav') do
            click_on 'Fornecedores'
        end
        click_on 'Novo Fornecedor'
        fill_in 'Razão social', with: ''
        fill_in 'Nome fantasia', with: ''
        fill_in 'CNPJ', with: ''
        fill_in 'Endereço', with: ''
        fill_in 'Cidade', with: ''
        fill_in 'Estado', with: ''
        fill_in 'Email', with: ''
        click_on 'Enviar'

        # Assert
        expect(page).to have_content('Nenhum fornecedor cadastrado')
        expect(page).to have_content('Razão social não pode ficar em branco')
        expect(page).to have_content('Nome fantasia não pode ficar em branco')
        expect(page).to have_content('CNPJ não pode ficar em branco')
        expect(page).to have_content('Endereço completo não pode ficar em branco')
        expect(page).to have_content('Cidade não pode ficar em branco')
        expect(page).to have_content('Estado não pode ficar em branco')
        expect(page).to have_content('Email não pode ficar em branco')
    end
end