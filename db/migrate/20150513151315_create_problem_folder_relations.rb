class CreateProblemFolderRelations < ActiveRecord::Migration
  def change
    create_table :problem_folder_relations do |t|
      t.integer :problem_id
      t.integer :folder_id
    end
    add_index :problem_folder_relations, :problem_id
    add_index :problem_folder_relations, :folder_id
  end
end
