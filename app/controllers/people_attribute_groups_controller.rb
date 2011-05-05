class PeopleAttributeGroupsController < ApplicationController
  
  def index
    prepare_collection
  end
  
  def new
    @group = PeopleAttributeGroup.new
  end
  
  def create
    @group = PeopleAttributeGroup.create(params[:people_attribute_group])
    if @group.save
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @group.id
    else
      render :action => :new
    end
  end
  
  def update
    @group = PeopleAttributeGroup.find(params[:id])
    if @group.update_attributes(params[:people_attribute_group])
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @group.id
    else
      render :action => :new
    end
  end
  
  def edit
    @group = PeopleAttributeGroup.find(params[:id])
    render :action => :new
  end
  
  def destroy
    PeopleAttributeGroup.find(params[:id]).destroy
    flash[:info] = "Ieraksts veiksmīgi dzēsts"
    redirect_to :action => :index
  end
  
  def search
    prepare_collection
    render :action => "index"
  end
  
  def new_attribute
    people_attribute = PeopleAttribute.new(:data_type => "string", :order => Time.now.to_i)
    render :partial => "people_attribute", :object => people_attribute
  end
  
  private
  
  def prepare_collection
    @groups = PeopleAttributeGroup.search(params[:search]).order_by(params[:sort]).paginate(:page => params[:page],
    :per_page => Biomed::Application::PAGINATION_PAGE_SIZE)
    flash.now[:error] = "Netika atrasts neviens ieraksts" if @groups.empty?
  end
  
end