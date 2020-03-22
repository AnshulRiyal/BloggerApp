class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable
  has_many :role_users
  has_many :roles, through: :role_users
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  after_create :add_user_role

  private

  def add_user_role
    self.roles << Role.find_by(name: "default")
  end
end
