class CreateGalleryPictures < ActiveRecord::Migration[6.0]
  def change
    create_table :gallery_pictures do |t|
      t.references :gallery, null: false, foreign_key: true, type: :bigint
      t.references :picture, null: false, foreign_key: true, type: :bigint

      t.timestamps
    end
  end
end
