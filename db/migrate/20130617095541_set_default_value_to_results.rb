class SetDefaultValueToResults < ActiveRecord::Migration
  def up
    change_table :results do |t|
      t.change :played, :integer, :null => false, :default => 0
      t.change :won, :integer, :null => false, :default => 0
      t.change :lost, :integer, :null => false, :default => 0
      t.change :tie, :integer, :null => false, :default => 0
      t.change :nr, :integer, :null => false, :default => 0
      t.change :points, :integer, :null => false, :default => 0
      t.change :nrr, :float, :null => false, :default => 0
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Can't remove the default"
  end
end


