def login(user)
  within('nav') do
    click_on 'Entrar'
  end
  fill_in 'Email', with: user.email
  fill_in 'Senha', with: user.password
  within('form') do 
    click_on 'Entrar'
  end
end