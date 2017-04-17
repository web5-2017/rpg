class Map < ApplicationRecord
  belongs_to :history

  def update_id_json
    self.json_map.sub! 'new-map', "#{self.id}-map"
    save
  end
end
