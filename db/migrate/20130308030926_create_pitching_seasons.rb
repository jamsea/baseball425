class CreatePitchingSeasons < ActiveRecord::Migration
  def change
    create_table :pitching_seasons do |t|
      t.string :team
      t.integer :jersey_number
      t.integer :season_order
      t.integer :gp
      t.integer :gs
      t.integer :w
      t.integer :l
      t.integer :sv
      t.integer :bs
      t.integer :hld
      t.integer :outs
      t.integer :outs
      t.integer :tbf
      t.integer :h
      t.integer :r
      t.integer :er
      t.integer :hr
      t.integer :k
      t.integer :bb
      t.integer :ibb
      t.integer :hbp
      t.integer :cg
      t.integer :sho
      t.integer :wp
      t.integer :bk
      t.float :era
      t.float :whip
      t.float :k_percent
      t.float :bb_percent
      t.float :babip

      t.timestamps
    end
  end
end
