class UsersController < CrudController
  has_scope :per, default: 10000, only: [ :index ]

  def profile
    if current_user.profile
      redirect_to current_user.profile
    else
      redirect_to current_user
    end
  end

  def index
    @mentors_with_no_user = Mentor.with_no_user
    @members_with_no_user = Member.with_no_user
    @unconfirmed = collection.where(sign_in_count: 0)
    @all = collection
  end

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
      if current_user == @user
        bypass_sign_in(@user)
      end
      redirect_to user_path(@user)
    else
      render "edit"
    end
  end

  def create_for_profile
    @user = User.new(user_params)
    @user.email = @user.profile.vcard.contacts.email.first if @user.email.blank?
    @user.password = Devise.friendly_token.first(8)
    @user.password_confirmation = @user.password

    flash[:notice] = 'User created and invitation sent'
    if @user.save
      @user.send_reset_password_instructions
    else
      render 'edit'
    end
  end

  def create
    if @user.profile
      create_for_profile
      return
    end

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
        :admin,
        :password,
        :password_confirmation,
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
