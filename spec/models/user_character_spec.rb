require 'rails_helper'

RSpec.describe UserCharacter, type: :model do
  let!(:user1) { create(:user_actived) }
  let!(:user2) { create(:user_actived) }
  let!(:game) { create(:game, user: user1)}
  let!(:history) { create(:history, user: user1, games: [game])}
  let!(:challenge) { create(:challenge, game: game, history: history) }
  let!(:alternative) { create(:alternative, challenge: challenge, exp: 3) }
  let!(:alternative2) { create(:alternative, challenge: challenge, exp: -5) }
  let!(:alternative3) { create(:alternative, challenge: challenge, exp: 20) }
  let!(:breed) { create(:breed, game: game) }
  let!(:character) { create(:character, breeds: [breed], game: game) }
  let!(:user_char) { create(:user_character, breed: breed, character: character, game: game, user: user2) }

  it "Deve escolher uma alternativa e ganhar exp" do
    alternative.chosen user_char

    expect(user_char.reload.exp).to eq 4
  end

  it "Deve escolher uma alternativa e ganhar exp e almentar seu level" do
    alternative3.chosen user_char

    expect(user_char.reload.level).to eq 2
  end

  it "Deve escolher uma alternativa e perder exp escolhendo outra, não pode ficar com menos de 0" do
    alternative2.chosen user_char

    expect(user_char.reload.exp).to eq 0
  end

end
