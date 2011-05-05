class SpecimenAttributeGroupsController < ApplicationController
  
  def index
    prepare_collection
  end
  
  def new
    @group = SpecimenAttributeGroup.new
  end
  
  def create
    @group = SpecimenAttributeGroup.create(params[:specimen_attribute_group])
    if @group.save
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @group.id
    else
      render :action => :new
    end
  end
  
  def update
    @group = SpecimenAttributeGroup.find(params[:id])
    if @group.update_attributes(params[:specimen_attribute_group])
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @group.id
    else
      render :action => :new
    end
  end
  
  def edit
    @group = SpecimenAttributeGroup.find(params[:id])
    render :action => :new
  end
  
  def destroy
    SpecimenAttributeGroup.find(params[:id]).destroy
    flash[:info] = "Ieraksts veiksmīgi dzēsts"
    redirect_to :action => :index
  end
  
  def search
    prepare_collection
    render :action => "index"
  end
  
  def new_attribute
    specimen_attribute = SpecimenAttribute.new(:data_type => "string", :order => Time.now.to_i)
    render :partial => "specimen_attribute", :object => specimen_attribute
  end
  
  private
  
  def prepare_collection
    @groups = SpecimenAttributeGroup.search(params[:search]).order_by(params[:sort]).paginate(:page => params[:page],
    :per_page => Biomed::Application::PAGINATION_PAGE_SIZE)
    flash.now[:error] = "Netika atrasts neviens ieraksts" if @groups.empty?
  end
  
end