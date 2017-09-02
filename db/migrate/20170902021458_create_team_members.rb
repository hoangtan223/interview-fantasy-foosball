class CreateTeamMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_members do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :team, foreign_key: true
      t.integer :status

      t.timestamps
    end
  end
end
