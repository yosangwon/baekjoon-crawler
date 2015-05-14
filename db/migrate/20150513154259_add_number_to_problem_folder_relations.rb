class AddNumberToProblemFolderRelations < ActiveRecord::Migration
  def change
    add_column :problem_folder_relations, :number, :integer
  end
end
