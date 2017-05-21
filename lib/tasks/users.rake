namespace :users do
  desc "Cria os usuários para facilitar testes"
  task create_users: :environment do
    User.create(name: 'user1',
                email: 'user1@email.com',
                password: '123456',
                password_confirmation: '123456',
                confirmed_at: Time.now )

    User.create(name: 'user2',
                email: 'user2@email.com',
                password: '123456',
                password_confirmation: '123456',
                confirmed_at: Time.now )
  end

end
