class ChangeOriginalIdColumnOnFolder < ActiveRecord::Migration
  def up
    remove_column :folders, :original_id
    add_column    :folders, :original_id, :string
    add_index     :folders, :original_id
  end

  def down
    remove_column :folders, :original_id
    add_column    :folders, :original_id, :integer
    add_index     :folders, :original_id
  end
end
