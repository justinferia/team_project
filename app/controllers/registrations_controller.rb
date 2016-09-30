class RegistrationsController < Devise::RegistrationsController

  def create
    super
    @user = User.find(current_user.id)
    @role = params[:role][:role_name]
    @user.add_role(@role)
  end

  def after_sign_up_path_for(resource)
    if params[:role][:role_name] == 'instructor'
      '/users/edit' # Or :prefix_to_your_route
    else
      '/workouts'
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :role)
  end
end
