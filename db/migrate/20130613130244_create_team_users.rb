class CreateTeamUsers < ActiveRecord::Migration
  def self.up
    create_table :team_users, :id => false do |t|
      t.references :team, :user
    end
    add_index :team_users, [:team_id, :user_id]
  end

  def self.down
    drop_table :team_users
  end
end

