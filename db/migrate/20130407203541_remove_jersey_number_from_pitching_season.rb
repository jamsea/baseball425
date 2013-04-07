class RemoveJerseyNumberFromPitchingSeason < ActiveRecord::Migration
  def up
    remove_column :pitching_seasons, :jersey_number
  end

  def down
    add_column :pitching_seasons, :jersey_number, :integer
  end
end
