class RemoveTeamFromPitchingSeason < ActiveRecord::Migration
  def up
    remove_column :pitching_seasons, :team
  end

  def down
    add_column :pitching_seasons, :team, :string
  end
end
