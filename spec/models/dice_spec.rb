require 'rails_helper'

RSpec.describe Dice, type: :model do

  it 'deve lançar um dado de 4' do
    dice = Dice.new 4
    expect(dice.cast).to be <= 4
  end

  it 'deve retornar um erro caso não exista o dado' do
    expect { Dice.new 3 }.to raise_error(DiceNotExistError)
  end

end
