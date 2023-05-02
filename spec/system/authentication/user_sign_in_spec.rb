require 'rails_helper'

describe 'Usuário faz login no sistema' do
  it 'com sucesso' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com', password: 'password')

    # Act 
    visit root_path 
    within('nav') do 
      click_on 'Entrar'
    end
    fill_in 'Email', with: 'ricardo@amigoviolao.com'
    fill_in 'Senha', with: 'password'
    within('form') do 
      click_on 'Entrar'
    end

    # Assert   
    within('nav') do 
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'ricardo@amigoviolao.com | Olá Ricardo!'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end

  it 'e faz logout' do 
    # Arrange 
    user = User.create!(name: 'Ricardo', email: 'ricardo@amigoviolao.com', password: 'password')

    # Act 
    visit root_path 
    click_on 'Entrar'
    fill_in 'Email', with: 'ricardo@amigoviolao.com'
    fill_in 'Senha', with: 'password'
    within('form') do 
      click_on 'Entrar'
    end
    within('nav') do 
      click_on 'Sair'
    end

    # Assert
    expect(page).to have_link 'Entrar'
    expect(page).not_to have_link 'Sair'
    expect(page).to have_content 'Logout efetuado com sucesso.'
    expect(page).not_to have_content 'ricardo@amigoviolao.com | Olá Ricardo!'
  end
end