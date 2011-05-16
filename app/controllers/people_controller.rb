class PeopleController < ApplicationController
  
  def index
    prepare_collection
  end
  
  def new
    @person = Person.new
  end
  
  def create
    @person = Person.create(params[:person])
    if @person.save
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @person.id
    else
      render :action => :new
    end
  end
  
  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      flash[:info] = "Ieraksts veiksmīgi saglabāts"
      redirect_to :action => :edit, :id => @person.id
    else
      render :action => :new
    end
  end
  
  def edit
    @person = Person.find(params[:id])
    render :action => :new
  end
  
  def destroy
    Person.find(params[:id]).destroy
    flash[:info] = "Ieraksts veiksmīgi dzēsts"
    redirect_to :action => :index
  end
  
  def search
    prepare_collection
    render :action => "index"
  end
  
  def new_group
    people_attribute_group = PeopleAttributeGroup.find(params[:id])
    used_people_attribute_group = UsedPeopleAttributeGroup.new(
      :alternate_name => people_attribute_group.name,
      :order => Time.now.to_i,
      :people_attribute_group_id => people_attribute_group.id
    )
    used_people_attribute_group.build_attribute_values(people_attribute_group)
    render :partial => "used_people_attribute_group", :object => used_people_attribute_group
  end
  
  private
  
  def prepare_collection
    @people = Person.search(params[:search]).order_by(params[:sort]).paginate(:page => params[:page],
    :per_page => Biomed::Application::PAGINATION_PAGE_SIZE)
    flash.now[:error] = "Netika atrasts neviens ieraksts" if @people.empty?
  end
  
end