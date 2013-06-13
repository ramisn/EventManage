class AddEventIdToTeamUsers < ActiveRecord::Migration
  def change
    add_column :team_users, :event_id, :integer
  end
end
