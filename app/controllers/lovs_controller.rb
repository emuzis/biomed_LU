class LovsController < ApplicationController
  
  def index
    @lovs = Lov.paginate(:page => params[:page], :sort => params[:sort], :per_page => Biomed::Application::PAGINATION_PAGE_SIZE)
  end
  
  def destroy
    lov = Lov.find(params[:id]).destroy
    flash[:info] = "Ieraksts veiksmīgi dzēsts"
    redirect_to :action => :index
  end
  
end