class Match::Battle
  attr_accessor :characters, :characters_ids, :total, :turn, :character_turn, :character_turn_id

  def initialize(attrs = {})
    attrs.each do |key, value|
      send("#{key}=", value)
    end

    sort_characters
  end

  def next
    @turn += 1
    index = @turn % @total
    index = @total if index == 0

    create_characters if @characters.nil?

    @character_turn_id = @characters[index - 1].id
    @character_turn = @characters[index - 1]

    self.next if @character_turn.hp <= 0
  end

  def character_turn
    @character_turn = UserCharacter.find @character_turn_id if @character_turn.nil?
    @character_turn
  end

  def to_s
    create_characters_ids if @characters_ids.nil?

    "{\"characters_ids\":#{@characters_ids},\"total\":#{@total},\"turn\":#{@turn},\"character_turn_id\":#{@character_turn_id}}"
  end

  def self.parse(string)
    Match::Battle.new(JSON.parse(string))
  end

  private
  def create_characters
    @characters = []

    @characters_ids.each do |id|
      characters << ::UserCharacter.find(id)
    end
  end

  def create_characters_ids
    @characters_ids = []

    @characters.each do |character|
      characters_ids << character.id
    end
  end

  def sort_characters
    create_characters if @characters.nil?
    @characters.sort! {|x, y| y.dex <=> x.dex}
    create_characters_ids
  end
end
