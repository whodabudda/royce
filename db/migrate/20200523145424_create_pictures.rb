class CreateDrawings < ActiveRecord::Migration[6.0]
  def change
    create_table :pictures do |t|
      t.date :created_on_date
      t.string :title
      t.string :moniker
      t.text :comment

      t.timestamps
    end
  end
end
