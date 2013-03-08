class CreateBattingSeasons < ActiveRecord::Migration
  def change
    create_table :batting_seasons do |t|
      t.string :team
      t.integer :jersey_number
      t.integer :season_order
      t.string :position
      t.integer :ab
      t.integer :gp
      t.integer :pa
      t.integer :singles
      t.integer :doubles
      t.integer :triples
      t.integer :hr
      t.integer :tb
      t.integer :r
      t.integer :rbi
      t.integer :bb
      t.integer :ibb
      t.integer :so
      t.integer :hbp
      t.integer :sf
      t.integer :sh
      t.integer :gidp
      t.integer :sb
      t.integer :cs
      t.float :ba
      t.float :obp
      t.float :slg
      t.float :ops
      t.float :k_percent
      t.float :bb_percent

      t.timestamps
    end
  end
end
