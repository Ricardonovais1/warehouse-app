require 'rails_helper'

describe 'Usuário remove um galpão' do 
    it 'com sucesso' do
        # Arrange 
        warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWV', city: 'Rio de Janeiro', area: 60_000,
            address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        # Act 
        visit root_path
        click_on 'Cuiaba'
        click_on 'Remover Galpão'
        # Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).not_to have_content 'Cuiaba'
        expect(page).not_to have_content 'CWV'

    end

    it 'e não apaga outros galpões' do
        # Arrange 
        first_warehouse = Warehouse.create!(name: 'Cuiaba', code: 'CWV', city: 'Rio de Janeiro', area: 60_000,
                          address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        second_warehouse = Warehouse.create!(name: 'Belo Horizonte', code: 'BHZ', city: 'Belo Horizonte', area: 90_000,
                           address: 'Av. Tiradentes, 4000', cep: '43000-000', description: 'Galpão de produtos mineiros')
        # Act 
        visit root_path
        click_on 'Belo Horizonte'
        click_on 'Remover Galpão'
        # Assert
        expect(current_path).to eq root_path
        expect(page).to have_content 'Galpão removido com sucesso'
        expect(page).to have_content 'Cuiaba'
        expect(page).to have_content 'CWV'
        expect(page).not_to have_content 'Belo Horizonte'
        expect(page).not_to have_content 'BHZ'
    end
end