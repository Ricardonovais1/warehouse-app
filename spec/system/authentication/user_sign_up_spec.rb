require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'com sucesso' do 
    # Arrange 

    # Act 
    visit root_path
    within('nav') do
      click_on 'Entrar'
    end
    click_on 'Criar uma conta'
    fill_in 'Nome', with: 'Maria'
    fill_in 'Email', with: 'umnome@umdominio.com.br'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar conta'

    # Assert
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    within('nav') do 
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'umnome@umdominio.com.br'
      expect(page).to have_content 'Olá Maria!'
    end  
  end
end