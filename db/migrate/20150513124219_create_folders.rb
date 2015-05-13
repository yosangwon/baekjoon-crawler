class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :slug
      t.string :name
      t.integer :parent_folder_id
      t.integer :original_id

      t.timestamps null: false
    end
    add_index :folders, :slug
    add_index :folders, :parent_folder_id
    add_index :folders, :original_id

    Folder.create do |root_folder|
      root_folder.slug = ""
    end
  end
end
