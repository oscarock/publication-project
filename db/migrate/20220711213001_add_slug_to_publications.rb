class AddSlugToPublications < ActiveRecord::Migration[7.0]
  def change
    add_column :publications, :slug, :string
    add_index :publications, :slug, unique: true
  end
end
