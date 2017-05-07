class Dice
  attr_reader :value, :type
  TYPES = [4, 6, 8, 10, 12, 16, 20, 30, 100]

  def initialize(type)
    @type = type

    validate_type
  end

  def cast
    @value = rand(@type) + 1
  end

  def validate_type
    unless TYPES.include? @type
      raise DiceNotExistError.new('Dot exist')
    end
  end

end
