class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :played
      t.integer :won
      t.integer :lost
      t.integer :tie
      t.integer :nr
      t.integer :points
      t.float :nrr

      t.timestamps
    end
  end
end
