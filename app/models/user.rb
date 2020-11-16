class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :coders
  has_many :missions

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, format: { with: /\A(\+33\s[1-9]{8})|(0[1-9]\s{8})\z/, message: "uniquement + ou des nombres" }
end
