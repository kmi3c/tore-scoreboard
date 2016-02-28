class UsersController < ScaffoldController
  layout "ipads", except: [:dashboard]
  before_action :authenticate_hostes, except: :dashboard
  def new
    @resource = resource_class.new
    @adult = '1'
    render_template
  end
  def index
  	today = User.user_days.except('TOTAL').invert[Time.zone.now.to_date]
    today = today.nil? ? 'score' : User.user_days.except('TOTAL').invert[Time.zone.now.to_date].gsub(' ','').downcase
    @resources = User.order("#{today} ASC").where('DATE(updated_at) = ?', Time.zone.now.to_date).where("#{today} is null")
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
    @today = params[:day].nil? ? Time.zone.now.to_date : User.user_days[params[:day].upcase.gsub('-',' ')]
    score = params[:day].nil? ? 'score' : params[:day].gsub('-','')
    score = 'score' if score == 'total'
    @users = User.order("users.#{score} DESC")
  end
  def create
    @adult = resource_params[:adult]
    @accept_r = resource_params[:accept_r]
    @accept_m = resource_params[:accept_m]
    @resource = resource_class.new(resource_params)
    if @resource.save
      redirect_to resource_new_path, notice: t('create.success',scope: :scaffold, resource_class: resource_class)
    elsif exists = User.where(email: resource_params[:email]).first
      exists.touch
      redirect_to resource_new_path, notice: t('create.success_login',scope: :scaffold, resource_class: resource_class)  
    else
      flash[:alert] = @resource.errors.to_a
      render_template
    end
  end
end
