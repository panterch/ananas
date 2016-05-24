class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :profile, polymorphic: true

  def member?
    'Member' == self.profile_type
  end

  def mentor?
    'Mentor' == self.profile_type
  end

  def to_s
    self.email
  end
end
