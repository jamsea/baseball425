class RemoveTeamFromBattingSeason < ActiveRecord::Migration
  def up
    remove_column :batting_seasons, :team
  end

  def down
    add_column :batting_seasons, :team, :string
  end
end
