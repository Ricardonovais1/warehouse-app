require 'rails_helper'

describe 'Usuário edita um galpão' do 
    it 'a partir da página de detalhes' do
        # Arrange 
        warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                    address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        # Act 
        visit root_path
        click_on 'Rio'
        click_on 'Editar Galpão'


        # Assert
        expect(page).to have_content('Editar Galpão')
        expect(page).to have_field('Nome', with: 'Rio')
        expect(page).to have_field('Descrição', with: 'Galpão do Rio' )
        expect(page).to have_field('Código', with: 'SDU')
        expect(page).to have_field('Endereço', with: 'Av. do Porto, 1000')
        expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
        expect(page).to have_field('Cep', with: '20000-000')
        expect(page).to have_field('Área', with: '60000')
    end

    it 'com sucesso' do 
        # Arrange 
        warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                                      address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

        # Act 
        visit root_path
        click_on 'Rio'
        click_on 'Editar Galpão'
        
        fill_in 'Nome', with: 'Galpão Internacional'
        fill_in 'Área', with: '200000'
        fill_in 'Código', with: 'SDT'
        fill_in 'Cidade', with: 'RJ'
        fill_in 'Endereço', with: 'Av. do Porto, 2222'
        fill_in 'Cep', with: '22000-000'
        fill_in 'Descrição', with: 'Galpão Carioca'
        click_on 'Salvar'

        # Assert
        expect(page).to have_content 'Galpão atualizado com sucesso'
        expect(page).to have_content 'Nome: Galpão Internacional'
        expect(page).to have_content 'Área: 200000 m²'
        expect(page).to have_content 'Código: SDT'
        expect(page).to have_content 'Cidade: RJ'
        expect(page).to have_content 'Endereço: Av. do Porto, 2222, CEP: 22000-000'
        expect(page).to have_content 'Descrição: Galpão Carioca'
    end

    it 'e mantém os campos obrigatórios' do 
    # Arrange 
    warehouse = Warehouse.create!(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
        address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')

    # Act 
    visit root_path
    click_on 'Rio'
    click_on 'Editar Galpão'   
    fill_in 'Cidade', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Cep', with: ''
    click_on 'Salvar'

    # Assert 
    expect(page).to have_content 'Não foi possível atualizar o galpão'
    end
end