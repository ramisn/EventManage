class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :title
      t.text :description
      t.string :t1
      t.text :t1_desc
      t.string :t2
      t.text :t2_desc
      t.string :result

      t.references :event

      t.timestamps
    end
  end
end
