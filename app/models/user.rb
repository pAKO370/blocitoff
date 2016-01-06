class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:confirmable,:validatable, :authentication_keys => [:login]

  validates :username,:presence => true,:uniqueness => {:case_sensitive => false}
  validate :validate_username

  has_many :items
  

  attr_accessor :login #allows a username to be used

  def self.find_first_by_auth_conditions(warden_conditions)#method to allow username to be used
    conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      else
       if conditions[:username].nil?
        where(conditions).first
        else
        where(username: conditions[:username]).first
        end
      end
  end
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end
  def avatar_url(size) #allows the avatar to work in the user show view
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
end
