class ProblemsController < ApplicationController
  def index
    @problems = Problem.order :code
  end

  def sort
    sorting = if params[:sort] == 'asc'
                :asc
              else
                :desc
              end
    @problems = case params[:data]
                when 'rate'
                  Problem.order percentage: sorting, code: :asc
                when 'trial'
                  Problem.order trial: sorting, code: :asc
                when 'success'
                  Problem.order success: sorting, code: :asc
                else
                  Problem.order code: :asc
                end
    render :index
  end
end
