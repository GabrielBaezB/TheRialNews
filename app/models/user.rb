class User < ApplicationRecord
  enum :role, [:normal_user, :author, :admin]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :news
  has_many :comments, dependent: :destroy
end
