class CreateAlternatives < ActiveRecord::Migration[5.0]
  def change
    create_table :alternatives do |t|
      t.string :content
      t.references :challenge, foreign_key: true

      t.timestamps
    end
  end
end
