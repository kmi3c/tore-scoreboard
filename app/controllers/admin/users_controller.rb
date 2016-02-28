class Admin::UsersController < ScaffoldController
  layout "ipads"
  before_action :authenticate_hostes
  def columns
    @columns = ['first_name', 'last_name', 'nickname', 'p_first_name','p_last_name','email','phone', 'adult', 'accept_r', 'accept_m', 'signature_url','day1','day2','day3','day4','day5','finale']
  end
end
