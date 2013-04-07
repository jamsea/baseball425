class RemovePlayerIdFromTeam < ActiveRecord::Migration
  def up
    remove_column :teams, :player_id
  end

  def down
    add_column :teams, :player_id, :integer
  end
end
