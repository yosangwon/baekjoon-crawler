class FolderController < ApplicationController
  def index
    @folder = if params[:folder]
                Folder.find_by(slug: "#{params[:folder]}/")
              else
                Folder.first
              end

    not_found unless @folder
  end
end
