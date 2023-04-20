require 'rails_helper'

describe 'usuario visita tela inicial' do
    it 'e vê o nome da app' do 
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content('Galpões & Estoque')
    end

    it 'e vê os galpões cadastrados' do 
        # Arrange 
        # Cadastrar 2 galpões: Rio e Maceió
        Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000)
        Warehouse.create(name: 'Maceió', code: 'MCZ', city: 'Maceió', area: 50_000)


        # Act 
        visit root_path

        # Assert
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
        # Apagar os galpões do teste anterior

        # Act
        visit root_path

        # Assert
        expect(page).to have_content('Nenhum galpão cadastrado')
    end
end