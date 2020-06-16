class CreateImageContainers < ActiveRecord::Migration[6.0]
  def change
    create_table :image_containers do |t|
      t.string :name

      t.timestamps
    end
  end
end
