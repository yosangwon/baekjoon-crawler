class CreateFolderProgresses < ActiveRecord::Migration
  def change
    create_table :folder_progresses do |t|
      t.integer :status
      t.integer :folder_id
      t.integer :baekjoon_user_id
      t.integer :progress
      t.integer :total

      t.timestamps null: false
    end
  end
end
