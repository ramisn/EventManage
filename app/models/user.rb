class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessible :name, :email, :password, :password_confirmation, :role
  has_and_belongs_to_many :teams

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  scope :admin_users, where(:role => "admin")

end
