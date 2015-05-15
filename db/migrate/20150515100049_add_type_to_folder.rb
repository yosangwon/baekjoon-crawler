class AddTypeToFolder < ActiveRecord::Migration
  def up
    add_column :folders, :type, :int, default: 0, null: false

    Folder.find_each do |folder|
      folder.update(type: :competition) if folder.original_id && folder.original_id.match("detail")
    end

    add_index :folders, :type
  end

  def down
    remove_column :folders, :type
  end
end
