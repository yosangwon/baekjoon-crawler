class Problem < ActiveRecord::Base
  has_many :problem_folder_relations, dependent: :destroy
  has_many :folders, through: :problem_folder_relations
end
