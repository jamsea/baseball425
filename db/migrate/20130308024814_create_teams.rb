class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :abbreviation
      t.string :city
      t.string :team_name
      t.string :league
      t.string :division

      t.timestamps
    end
  end
end
