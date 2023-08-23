require 'rails_helper'

describe 'usuario visita tela inicial' do
    it 'e vê o nome da app' do 
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content('Galpões & Estoque')
        expect(page).to have_link('Galpões & Estoque', href: root_path)
    end

    it 'e vê os galpões cadastrados' do 
        # Arrange 
        Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000,
                        address: 'Av. do Porto, 1000', cep: '20000-000', description: 'Galpão do Rio')
        Warehouse.create(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000,
                        address: 'Av. Atlântia, 2000', cep: '80000-000', description: 'Galpão de Maceió')


        # Act 
        visit root_path

        # Assert
        expect(page).not_to have_content('Não existem galpões cadastrados')
        expect(page).to have_content('Rio')
        expect(page).to have_content('Código: SDU')
        expect(page).to have_content('Cidade: Rio de Janeiro')
        expect(page).to have_content('Área: 60000 m²')

        expect(page).to have_content('Maceió')
        expect(page).to have_content('Código: MCZ')
        expect(page).to have_content('Cidade: Maceió')
        expect(page).to have_content('Área: 50000 m²')

    end

    it 'e não existem galpões cadastrados' do
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content('Nenhum galpão cadastrado')
    end
end