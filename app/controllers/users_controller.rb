class UsersController < CrudController
  def update
    # Don't try to update password if not provided
    if user_params[:password].blank?
      [:password, :password_confirmation].collect{|p| user_params.delete(p) }
    end

    # Special case if user can manage other users
    successfully_updated = if can? :manage, @user
      user_params.delete(:current_password)
      @user.update_attributes(user_params)
    else
      @user.update_with_password(user_params)
    end

    if successfully_updated
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def create
    create! do |format|
      format.html do
        unless params[:redirect_location].blank?
          redirect_to params[:redirect_location]
        else
          redirect_to user_path(@user)
        end
      end
    end

  end

  def user_params
    if current_user.admin?
      params
      .require(:user)
      .permit([
        :email,
        :password,
        :password_confirmation,
        :current_password,
        :profile_id,
        :profile_type
      ])
    else
      params
      .require(:user)
      .permit([
        :email,
        :password,
        :password_confirmation,
        :current_password
      ])
    end
  end
end
