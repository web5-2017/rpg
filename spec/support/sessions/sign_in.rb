module Sessions

  def sign_in(email, password)
    visit '/users/sign_in'

    within("#new_user") do
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: password
    end
    
    find('input[name="commit"]').click

    expect(page).to have_content 'Login efetuado com sucesso!'
  end

end
