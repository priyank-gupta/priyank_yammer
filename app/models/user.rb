class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :feeds, :dependent => :destroy
  has_many :follows

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :rememberable, :trackable, :validatable
  
  validates_inclusion_of :user_type, :in => %w( admin normal )
  validates_format_of :email, :with => /\A([^@\s]+)(@vinsol.com)\Z/i, :on => :create
  validates_uniqueness_of :email, :message => "User has already been created"
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_type
  
  attr_accessor :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at
  
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end
  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # new function to provide access to protected method unless_confirmed
  def only_if_unconfirmed
    unless_confirmed {yield}
  end
  
  def password_required?
  # Password is required if it is being set, but not for new records
  if !persisted? 
    false
  else
    !password.nil? || !password_confirmation.nil?
  end
end
end
