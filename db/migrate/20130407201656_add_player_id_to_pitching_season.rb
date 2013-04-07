class AddPlayerIdToPitchingSeason < ActiveRecord::Migration
  def change
    add_column :pitching_seasons, :player_id, :integer
  end
end
