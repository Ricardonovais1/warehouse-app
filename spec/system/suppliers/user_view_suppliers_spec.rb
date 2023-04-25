require 'rails_helper'

describe 'Usuário vê fornecedores' do 
    it 'a partir do menu' do
        # Arrange 
        
        # Act 
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end
        # Assert
        expect(current_path).to eq suppliers_path

    end

    it 'com sucesso' do
        # Arrange 
        Supplier.create!(corporate_name: 'AV Guitars and Accessories', brand_name: 'Amigo Violão', 
                         registration_number: 12345, full_address: 'Rua das Palmeiras, 344', 
                         city: 'Belo Horizonte',
                         state: 'Minas Gerais', email: 'av@av.com')

        # Act 
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end

        # Assert

        expect(page).to have_content 'Fornecedor cadastrado com sucesso'
        expect(page).to have_content 'Fornecedores'
        expect(page).to have_content 'AV Guitars and Accessories'
        expect(page).to have_content 'Rua das Palmeiras, 344'
       
    end

    it 'e não existem fornecedores cadastrados' do
        # Arrange 

        # Act 
        visit root_path
        within('nav') do
            click_on 'Fornecedores'
        end

        # Assert
        expect(page).to have_content 'Nenhum fornecedor cadastrado'
    end

end