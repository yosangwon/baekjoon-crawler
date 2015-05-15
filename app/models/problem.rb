class Problem < ActiveRecord::Base
  has_many :problem_folder_relations, dependent: :destroy
  has_many :folders, through: :problem_folder_relations

  has_many :problem_solvings, dependent: :destroy
  has_many :baekjoon_user, through: :problem_solvings
end
