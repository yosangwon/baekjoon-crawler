class ProblemFolderRelation < ActiveRecord::Base
  belongs_to :problem
  belongs_to :folder
end
