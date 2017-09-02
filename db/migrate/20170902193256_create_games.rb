class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.belongs_to :match, foreign_key: true
      t.integer :home_point
      t.integer :away_point

      t.timestamps
    end
  end
end
