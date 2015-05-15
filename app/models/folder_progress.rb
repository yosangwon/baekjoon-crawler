class FolderProgress < ActiveRecord::Base
  belongs_to :baekjoon_user
  belongs_to :folder

  has_many :problems, through: :problem_folder_relations, primary_key: :folder_id
end
