class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :profile, polymorphic: true

  def self.find_by_calendar_token!(token)
    id = token[40..-1].to_i
    user = User.find(id)
    unless user.calendar_token == token
      raise ActiveRecord::RecordNotFound
    end
  end

  def member?
    'Member' == self.profile_type
  end

  def mentor?
    'Mentor' == self.profile_type
  end

  def to_s
    self.email
  end

  def calendar_token
    "#{Digest::SHA1.hexdigest "#{id}:#{encrypted_password}"}#{id}"
  end
end
