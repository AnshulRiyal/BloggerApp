class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  has_many :role_users
  has_many :roles, through: :role_users, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :role_users, allow_destroy: true
  after_create :add_user_role_and_status
  
  include UserRoleMethods

  private

  def add_user_role_and_status
    self.roles << Role.find_by(name: "default")
    self.status = "active"
    self.save
  end
end
