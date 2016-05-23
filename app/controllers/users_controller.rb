class UsersController < CrudController
  def user_params
    permitted_params = params.require(:user)

    permitted_params.permit([
      :email,
      :login,
      :password,
      :password_confirmation,
      :current_password
    ])
  end
end
