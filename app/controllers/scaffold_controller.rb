class ScaffoldController < ApplicationController
  include ScaffoldHelper
  before_action :actions, :columns
  before_action :set_resource, only: [:show, :edit, :update, :destroy]
  def index
    @resources = resource_class.paginate(page:params[:page])
    render_template
  end
  def show
    render_template
  end
  def new
    @resource = resource_class.new
    render_template
  end
  def edit
    render_template
  end
  def create
    @resource = resource_class.new(resource_params)
    if @resource.save
      redirect_to @resource, notice:  t('create.success',scope: :scaffold, resource_class: resource_class)
    else
      render_template
    end
  end
  def update
    if @resource.update(resource_params)
      redirect_to @resource, notice: t('update.success',scope: :scaffold, resource_class: resource_class)
    else
      render_template
    end
  end
  def destroy
    @resource.destroy
    redirect_to resources_path, notice: t('destroy.success',scope: :scaffold, resource_class: resource_class)
  end
  def columns
    @columns = resource_class::column_names
  end
  def actions
    @actions = [:show, :edit, :destroy]
  end
  def search
    @resources = resource_class.where(search_params).paginate(page:params[:page])
    render_template 'index'
  end
  def import
    if resource_class.respond_to?(:import)
      if request.method == 'POST'
        import = resource_class.import(params[:file])
        if import == true
          flash[:success] =  t(:import_success,scope: :scaffold)
          redirect_to resources_path
        else
          flash[:error] = import
        end
      end
    else
      redirect_to resources_path
    end
    render_template
  end

  def export

  end
  protected
  def render_template name = nil
    if name.nil?
      name = params[:action] == 'create' ? 'new' : params[:action]
    end
    custom = [params[:controller],name].join('/')
    render !Dir.glob([Rails.root,'app/views',"#{custom}.*"].join('/')).empty? ? custom : "shared/scaffold/#{name}"
  end
  private
  def set_resource
    self.actions
    @resource = resource_class.find(params[:id])
  end
  def resource_params
    params.require(resource_name.downcase.to_sym).permit(resource_class.column_names)
  end
  def search_params
    params.require(:search).permit(resource_class.column_names)
  end
end