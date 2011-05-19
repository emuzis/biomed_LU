class SamplesController < ApplicationController
  
  def index
    prepare_collection
  end
  
  def new
    @sample = Sample.new
  end
  
  def create
    @sample = Sample.create(params[:sample])
    if @sample.save
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @sample.id
    else
      render :action => :new
    end
  end
  
  def update
    @sample = Sample.find(params[:id])
    if @sample.update_attributes(params[:sample])
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @sample.id
    else
      render :action => :new
    end
  end
  
  def edit
    @sample = Sample.find(params[:id])
    render :action => :new
  end
  
  def destroy
    Sample.find(params[:id]).destroy
    flash[:info] = "Ieraksts veiksmīgi dzēsts"
    redirect_to :action => :index
  end
  
  def search
    prepare_collection
    render :action => "index"
  end
  
  def new_group
    sample_attribute_group = SampleAttributeGroup.find(params[:id])
    used_sample_attribute_group = UsedSampleAttributeGroup.new(
      :alternate_name => sample_attribute_group.name,
      :order => Time.now.to_i,
      :sample_attribute_group_id => sample_attribute_group.id
    )
    used_sample_attribute_group.build_attribute_values(sample_attribute_group)
    render :partial => "used_sample_attribute_group", :object => used_sample_attribute_group
  end
  
  private
  
  def prepare_collection
    @samples = Sample.search(params[:search]).order_by(params[:sort]).paginate(:page => params[:page],
    :per_page => Biomed::Application::PAGINATION_PAGE_SIZE)
    flash.now[:error] = "Netika atrasts neviens ieraksts" if @samples.empty?
  end
  
end