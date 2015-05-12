class ProblemsController < ApplicationController
  def index
    redirect_to '/code/'
  end

  def sort
    page = if params[:page]
              params[:page].to_i
           else
             1
           end

    @sorting = if params[:sort] == 'asc'
                :asc
              else
                :desc
              end
    @problems, @order= case params[:data]
                when 'rate'
                  [ Problem.order(percentage: @sorting, code: :asc).page(page), :percentage ]
                when 'trial'
                  [ Problem.order(trial: @sorting, code: :asc).page(page), :trial ]
                when 'success'
                  [ Problem.order(success: @sorting, code: :asc).page(page), :success ]
                else
                  [ Problem.order(code: :asc).page(page), nil ]
                end
    render :index
  end

  def crawl
    CrawlWorker.perform_async(1)
  end
end
