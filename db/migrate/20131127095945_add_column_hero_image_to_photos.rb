class AddColumnHeroImageToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :hero_image, :boolean, default: false
  end
end
