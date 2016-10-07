class RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    if current_user.provider == "twitter"
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end


  def create
    super
    @user.add_role(params[:role][:role_name])
  end

  def after_sign_up_path_for(resource)
    if  params[:role][:role_name] == 'instructor'
      '/users/edit'
    else
      '/workouts' # Or :prefix_to_your_route
    end
  end

  # Overwrite update_resource to let users to update their user without giving their password

  def role
    if current_user.has_role?(:guest)
      redirect_to "/workouts"
    elsif current_user.has_role?(:instructor)
      redirect_to "/workouts"
    end
  end

  def guest
    if !current_user.nil?
      if !current_user.roles.nil?
        current_user.add_role(:guest)
      end
    end
    redirect_to "/workouts"
  end

  def instructor
    if !current_user.nil?
      if !current_user.roles.nil?
        current_user.add_role(:instructor)
      end
    end
    redirect_to "/users/edit"
  end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :first_name, :last_name)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :role, :first_name, :last_name, :interests, :fitness_background, :image )
  end
end
