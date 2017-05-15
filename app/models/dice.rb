class Dice
  attr_reader :type
  TYPES = [4, 6, 8, 10, 12, 16, 20, 30, 100]

  def initialize(type)
    @type = type

    validate_type
  end

  def cast
    rand(@type) + 1
  end

  def casts(amount)
    results = []

    amount.times do
      results << rand(@type) + 1
    end

    results
  end

  def validate_type
    unless TYPES.include? @type
      raise DiceNotExistError.new('Dot exist')
    end
  end

end
