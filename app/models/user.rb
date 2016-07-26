class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :profile, polymorphic: true, optional: true

  def self.find_by_calendar_token!(token)
    id = token[40..-1].to_i
    user = User.find(id)
    if user.calendar_token == token
      user
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def member?
    'Member' == self.profile_type
  end

  def mentor?
    'Mentor' == self.profile_type
  end

  def team?
    'Team' == self.profile_type
  end

  def to_s
    self.email
  end

  def calendar_token
    "#{Digest::SHA1.hexdigest "#{id}:#{encrypted_password}"}#{id}"
  end
end
