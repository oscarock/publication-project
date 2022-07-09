class CreatePublications < ActiveRecord::Migration[7.0]
  def change
    create_table :publications do |t|
      t.string :title
      t.text :description
      t.integer :price
      t.string :city
      t.string :address
      t.string :phone
      t.boolean :visible, default: true

      t.timestamps
    end
  end
end
