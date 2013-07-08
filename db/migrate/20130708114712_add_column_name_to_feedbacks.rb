class AddColumnNameToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :name, :string, :default => nil, :null => true
  end
end
