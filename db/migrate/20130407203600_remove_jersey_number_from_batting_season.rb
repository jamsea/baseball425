class RemoveJerseyNumberFromBattingSeason < ActiveRecord::Migration
  def up
    remove_column :batting_seasons, :jersey_number
  end

  def down
    add_column :batting_seasons, :jersey_number, :integer
  end
end
