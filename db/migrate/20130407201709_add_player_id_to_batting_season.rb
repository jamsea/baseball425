class AddPlayerIdToBattingSeason < ActiveRecord::Migration
  def change
    add_column :batting_seasons, :player_id, :integer
  end
end
