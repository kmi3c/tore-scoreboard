class UsersController < ScaffoldController
  before_action :authenticate_hostes, except: :dashboard
  def new
    @resource = resource_class.new
    @adult = '1'
    render_template
  end
  def index
    @resources = User.today.paginate(page:params[:page])
    render_template
  end
  def update
    @adult = resource_params[:adult]
    if @resource.update(resource_params)
      redirect_to resources_path, notice: t('update.success',scope: :scaffold, resource_class: resource_class)
    else
      render_template
    end
  end
  def dashboard
    @users = User.order('users.score DESC')
  end
  def create
    @adult = resource_params[:adult]
    @resource = resource_class.new(resource_params)
    if @resource.save
      redirect_to resource_new_path, notice: t('create.success',scope: :scaffold, resource_class: resource_class)
    else
      flash[:alert] = @resource.errors.to_a
      render_template
    end
  end
end