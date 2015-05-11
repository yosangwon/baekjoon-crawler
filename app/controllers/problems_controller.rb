class ProblemsController < ApplicationController
  def index
    @problems = Problem.order :code
  end

  def sort
    @sorting = if params[:sort] == 'asc'
                :asc
              else
                :desc
              end
    @problems, @order= case params[:data]
                when 'rate'
                  [ Problem.order(percentage: @sorting, code: :asc), :percentage ]
                when 'trial'
                  [ Problem.order(trial: @sorting, code: :asc), :trial ]
                when 'success'
                  [ Problem.order(success: @sorting, code: :asc), :success ]
                else
                  [ Problem.order(code: :asc), nil ]
                end
    render :index
  end

  def crawl
    CrawlWorker.perform_async(1)
  end
end
