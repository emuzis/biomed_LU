class LovsController < ApplicationController
  
  def index
    prepare_collection
  end
  
  def new
    @lov = Lov.new
  end
  
  def create
    @lov = Lov.new(params[:lov])
    if @lov.save
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @lov.id
    else
      render :action => :new
    end
  end
  
  def update
    @lov = Lov.find(params[:id])
    if @lov.update_attributes(params[:lov])
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @lov.id
    else
      render :action => :new
    end
  end
  
  def edit
    @lov = Lov.find(params[:id])
    render :action => :new
  end
  
  def destroy
    lov = Lov.find(params[:id]).destroy
    flash[:info] = "Ieraksts veiksmīgi dzēsts"
    redirect_to :action => :index
  end
  
  def search
    prepare_collection
    render :action => "index"
  end
  
  private
  
  def prepare_collection
    @lovs = Lov.search(params[:search]).order_by(params[:sort]).paginate(:page => params[:page],
    :per_page => Biomed::Application::PAGINATION_PAGE_SIZE)
    flash.now[:error] = "Netika atrasts neviens ieraksts" if @lovs.empty?
  end
  
end