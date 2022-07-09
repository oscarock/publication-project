class CreatePublicationCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :publication_categories do |t|
      t.references :publication, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
