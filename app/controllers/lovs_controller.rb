class LovsController < ApplicationController
  
  def index
    @lovs = Lov.paginate(:page => params[:page], :per_page => Biomed::Application::PAGINATION_PAGE_SIZE)
  end
  
end