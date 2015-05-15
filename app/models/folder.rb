class Folder < ActiveRecord::Base
  has_many :problem_folder_relations, -> { order :number }, dependent: :destroy
  has_many :problems, through: :problem_folder_relations
  belongs_to :parent_folder, class_name: "Folder"
  has_many :folders, class_name: "Folder", foreign_key: :parent_folder_id
  validates :slug, uniqueness: true
  validates :original_id, uniqueness: true
  enum type: [:normal, :competition]
  self.inheritance_column = nil

  def parent_folders
    parent_folders = []
    folder = self
    while ( folder = folder.parent_folder )
      parent_folders.unshift folder
    end
    parent_folders
  end
end
